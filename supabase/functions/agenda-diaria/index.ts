import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const SUPABASE_URL     = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_SERVICE = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const RESEND_KEY       = Deno.env.get('RESEND_API_KEY')!;
const FROM_EMAIL       = 'onboarding@resend.dev';
const FROM_NAME        = 'SintesIA - Clinica Candia';

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE);

const DAYS_PT = ['Domingo','Segunda-feira','Terca-feira','Quarta-feira','Quinta-feira','Sexta-feira','Sabado'];
const MONTHS_PT = ['janeiro','fevereiro','marco','abril','maio','junho','julho','agosto','setembro','outubro','novembro','dezembro'];

function formatDate(date: Date): string {
  return `${DAYS_PT[date.getDay()]}, ${date.getDate()} de ${MONTHS_PT[date.getMonth()]} de ${date.getFullYear()}`;
}

function formatTime(dateStr: string): string {
  const d = new Date(dateStr);
  return `${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`;
}

function buildEmailHtml(profName: string, specialty: string, date: Date, appointments: any[]): string {
  const dateLabel = formatDate(date);
  const firstName = profName.split(' ')[0];

  const rows = appointments.map((apt, i) => {
    const time     = formatTime(apt.date_time);
    const patient  = apt.patients?.name || 'Paciente';
    const service  = apt.services?.name || 'Consulta';
    const duration = apt.duration_minutes || 60;
    const bg       = i % 2 === 0 ? '#f8fafc' : '#ffffff';
    return `
      <tr style="background:${bg}">
        <td style="padding:12px 16px;font-size:15px;font-weight:700;color:#123451;white-space:nowrap">${time}</td>
        <td style="padding:12px 16px;font-size:14px;color:#1e293b;font-weight:600">${patient}</td>
        <td style="padding:12px 16px;font-size:13px;color:#64748b">${service}</td>
        <td style="padding:12px 16px;font-size:13px;color:#64748b;white-space:nowrap">${duration} min</td>
      </tr>`;
  }).join('');

  return `
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:0;background:#f1f5f9;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif">
  <div style="max-width:600px;margin:32px auto;background:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 24px rgba(0,0,0,0.08)">

    <!-- Header -->
    <div style="background:#123451;padding:32px 32px 24px">
      <p style="margin:0 0 4px;font-size:12px;font-weight:700;color:#7dd3fc;text-transform:uppercase;letter-spacing:0.1em">Agenda do dia seguinte</p>
      <h1 style="margin:0;font-size:22px;font-weight:800;color:#ffffff">Boa noite, ${firstName}!</h1>
      <p style="margin:8px 0 0;font-size:14px;color:#94a3b8">${specialty}</p>
    </div>

    <!-- Date banner -->
    <div style="background:#0b6873;padding:12px 32px">
      <p style="margin:0;font-size:13px;font-weight:700;color:#ffffff">${dateLabel}</p>
    </div>

    <!-- Summary -->
    <div style="padding:24px 32px 16px;border-bottom:1px solid #e2e8f0">
      <p style="margin:0;font-size:14px;color:#475569">
        Voce tem <strong style="color:#123451;font-size:18px">${appointments.length}</strong>
        agendamento${appointments.length !== 1 ? 's' : ''} para amanha.
      </p>
    </div>

    <!-- Table -->
    <div style="padding:0 0 8px">
      <table style="width:100%;border-collapse:collapse">
        <thead>
          <tr style="background:#f8fafc;border-bottom:2px solid #e2e8f0">
            <th style="padding:10px 16px;font-size:11px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:0.05em;text-align:left">Horario</th>
            <th style="padding:10px 16px;font-size:11px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:0.05em;text-align:left">Paciente</th>
            <th style="padding:10px 16px;font-size:11px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:0.05em;text-align:left">Servico</th>
            <th style="padding:10px 16px;font-size:11px;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:0.05em;text-align:left">Duracao</th>
          </tr>
        </thead>
        <tbody>${rows}</tbody>
      </table>
    </div>

    <!-- Footer -->
    <div style="padding:24px 32px;border-top:1px solid #e2e8f0;background:#f8fafc">
      <p style="margin:0;font-size:12px;color:#94a3b8;text-align:center">
        SintesIA — Clinica Candia &nbsp;|&nbsp; Este email e enviado automaticamente toda noite
      </p>
    </div>
  </div>
</body>
</html>`;
}

serve(async (req) => {
  try {
    // Calcula "amanha" no fuso de Brasilia (UTC-3)
    const now       = new Date();
    const tomorrow  = new Date(now);
    tomorrow.setDate(tomorrow.getDate() + 1);
    const dateStr   = tomorrow.toISOString().split('T')[0]; // YYYY-MM-DD

    // Busca todos os agendamentos de amanha com dados de paciente e servico
    const { data: apts, error } = await supabase
      .from('appointments')
      .select('*, patients(name), services(name), professionals(id, name, email, specialty)')
      .gte('date_time', `${dateStr}T00:00:00`)
      .lte('date_time', `${dateStr}T23:59:59`)
      .in('status', ['scheduled', 'confirmed'])
      .order('date_time', { ascending: true });

    if (error) throw error;
    if (!apts || apts.length === 0) {
      return new Response(JSON.stringify({ ok: true, msg: 'Sem agendamentos amanha.' }), { status: 200 });
    }

    // Agrupa por profissional
    const byProf = new Map<string, { prof: any; apts: any[] }>();
    for (const apt of apts) {
      if (!apt.professionals?.email) continue; // ignora profissionais sem email
      const profId = apt.professional_id;
      if (!byProf.has(profId)) {
        byProf.set(profId, { prof: apt.professionals, apts: [] });
      }
      byProf.get(profId)!.apts.push(apt);
    }

    const results: any[] = [];

    for (const { prof, apts: profApts } of byProf.values()) {
      const html = buildEmailHtml(prof.name, prof.specialty || '', tomorrow, profApts);

      const res = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${RESEND_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          from:    `${FROM_NAME} <${FROM_EMAIL}>`,
          to:      [prof.email],
          subject: `Sua agenda de amanha — ${profApts.length} agendamento${profApts.length !== 1 ? 's' : ''}`,
          html,
        }),
      });

      const json = await res.json();
      results.push({ prof: prof.name, email: prof.email, status: res.status, resend: json });
    }

    return new Response(JSON.stringify({ ok: true, sent: results.length, results }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });

  } catch (err: any) {
    return new Response(JSON.stringify({ ok: false, error: err.message }), { status: 500 });
  }
});
