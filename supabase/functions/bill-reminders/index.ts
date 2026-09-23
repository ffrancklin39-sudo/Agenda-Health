// supabase/functions/bill-reminders/index.ts
//
// Busca contas a pagar vencendo em ≤3 dias (ou já vencidas e não pagas)
// e envia um lembrete no WhatsApp via WAHA para os contatos configurados.
//
// Chamada diariamente pelo pg_cron às 08:00 BRT.
// Pode também ser chamada manualmente pelo app (botão "Enviar lembretes").
//
// Variáveis de ambiente (Supabase Secrets):
//   WAHA_API_KEY   — API Key do WAHA (configurada no docker do WAHA)
//   WAHA_BASE_URL  — URL base do WAHA, ex: http://204.216.153.179:3000
//   WAHA_SESSION   — Nome da sessão WAHA (normalmente "default")
//   SUPABASE_URL             — injetada automaticamente
//   SUPABASE_SERVICE_ROLE_KEY— injetada automaticamente

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const SUPABASE_URL     = Deno.env.get('SUPABASE_URL')!;
const SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const WAHA_BASE_URL    = Deno.env.get('WAHA_BASE_URL') ?? 'http://204.216.153.179:3000';
const WAHA_SESSION     = Deno.env.get('WAHA_SESSION')  ?? 'default';
const WAHA_API_KEY     = Deno.env.get('WAHA_API_KEY')  ?? '';

const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY);

const fmtBRL  = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtDate = (d: string) => new Date(d + 'T00:00:00').toLocaleDateString('pt-BR');

interface Bill {
  id: string;
  description: string;
  supplier: string | null;
  amount: number;
  due_date: string;
  status: string;
  boleto_url: string | null;
}

interface ReminderContact {
  name: string;
  phone: string; // formato: 5561999999999
}

const WAHA_USERNAME = Deno.env.get('WAHA_USERNAME') ?? '';
const WAHA_PASSWORD = Deno.env.get('WAHA_PASSWORD') ?? '';

/** Envia mensagem de texto via WAHA */
async function sendWhatsApp(phone: string, text: string): Promise<void> {
  const chatId = phone.includes('@') ? phone : `${phone}@c.us`;

  // Suporta API Key (X-Api-Key), Basic Auth (usuário/senha) ou sem auth
  const authHeaders: Record<string, string> = {};
  if (WAHA_API_KEY) {
    authHeaders['X-Api-Key'] = WAHA_API_KEY;
  } else if (WAHA_USERNAME && WAHA_PASSWORD) {
    authHeaders['Authorization'] = 'Basic ' + btoa(`${WAHA_USERNAME}:${WAHA_PASSWORD}`);
  }

  const res = await fetch(`${WAHA_BASE_URL}/api/sendText`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', ...authHeaders },
    body: JSON.stringify({ chatId, text, session: WAHA_SESSION }),
  });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`WAHA error ${res.status}: ${body}`);
  }
}

/** Formata a mensagem de lembrete */
function buildMessage(bills: Bill[], recipientName: string): string {
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const overdue  = bills.filter(b => b.status === 'overdue');
  const upcoming = bills.filter(b => b.status === 'pending');

  let msg = `🔔 *Lembrete Financeiro — Clínica Candia*\n`;
  msg    += `Olá, ${recipientName}! Aqui está o resumo das contas.\n`;

  if (overdue.length > 0) {
    msg += `\n⚠️ *Contas vencidas (${overdue.length}):*\n`;
    for (const b of overdue) {
      msg += `\n• *${b.description}*\n`;
      msg += `  💰 ${fmtBRL(b.amount)} — venceu em ${fmtDate(b.due_date)}\n`;
      if (b.supplier) msg += `  🏢 ${b.supplier}\n`;
      if (b.boleto_url) msg += `  🔗 ${b.boleto_url}\n`;
    }
  }

  if (upcoming.length > 0) {
    msg += `\n📅 *Vencendo em até 3 dias (${upcoming.length}):*\n`;
    for (const b of upcoming) {
      const dueDate = new Date(b.due_date + 'T00:00:00');
      const diffDays = Math.ceil((dueDate.getTime() - today.getTime()) / 86400000);
      const when = diffDays === 0 ? 'hoje' : diffDays === 1 ? 'amanhã' : `em ${diffDays} dias`;

      msg += `\n• *${b.description}* — vence *${when}*\n`;
      msg += `  💰 ${fmtBRL(b.amount)} — ${fmtDate(b.due_date)}\n`;
      if (b.supplier) msg += `  🏢 ${b.supplier}\n`;
      if (b.boleto_url) msg += `  🔗 ${b.boleto_url}\n`;
    }
  }

  const total = bills.reduce((s, b) => s + b.amount, 0);
  msg += `\n💳 *Total pendente: ${fmtBRL(total)}*\n`;
  msg += `\nAcesse o SintesIA para registrar pagamentos.`;

  return msg;
}

Deno.serve(async () => {
  try {
    // ── 1. Buscar contas vencidas ou vencendo em ≤3 dias ──────────────────
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const in3Days = new Date(today);
    in3Days.setDate(in3Days.getDate() + 3);

    const { data: bills, error: billsErr } = await supabase
      .from('bills')
      .select('id, description, supplier, amount, due_date, status, boleto_url')
      .in('status', ['pending', 'overdue'])
      .lte('due_date', in3Days.toISOString().slice(0, 10))
      .order('due_date', { ascending: true });

    if (billsErr) throw billsErr;
    if (!bills || bills.length === 0) {
      console.log('Nenhuma conta pendente para lembrar.');
      return new Response(JSON.stringify({ ok: true, sent: 0 }), { status: 200 });
    }

    // ── 2. Buscar contatos de lembrete ────────────────────────────────────
    const { data: setting } = await supabase
      .from('clinic_settings')
      .select('value')
      .eq('key', 'reminder_contacts')
      .single();

    // value é JSONB — Supabase já retorna parsed, não precisa de JSON.parse
    const contacts: ReminderContact[] = Array.isArray(setting?.value)
      ? setting.value
      : typeof setting?.value === 'string'
        ? JSON.parse(setting.value)
        : [];

    if (contacts.length === 0) {
      console.warn('Nenhum contato de lembrete configurado em clinic_settings.');
      return new Response(JSON.stringify({ ok: false, error: 'No contacts configured' }), { status: 200 });
    }

    // ── 3. Enviar mensagem para cada contato ──────────────────────────────
    const errors: string[] = [];
    for (const contact of contacts) {
      try {
        const msg = buildMessage(bills as Bill[], contact.name);
        await sendWhatsApp(contact.phone, msg);
        console.log(`Lembrete enviado para ${contact.name} (${contact.phone})`);
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        console.error(`Erro ao enviar para ${contact.name}: ${msg}`);
        errors.push(`${contact.name}: ${msg}`);
      }
    }

    return new Response(
      JSON.stringify({ ok: errors.length === 0, sent: contacts.length - errors.length, errors }),
      { status: 200, headers: { 'Content-Type': 'application/json' } },
    );

  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    console.error('bill-reminders crash:', msg);
    return new Response(JSON.stringify({ ok: false, error: msg }), { status: 500 });
  }
});
