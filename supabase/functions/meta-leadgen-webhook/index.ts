// supabase/functions/meta-leadgen-webhook/index.ts
//
// Recebe o webhook "leadgen" da Meta (Instagram/Facebook Lead Ads) e cria
// automaticamente um lead em `patients`, com is_lead = true.
//
// Fluxo:
//   1. Meta faz GET para validar o webhook (handshake) -> ecoa hub.challenge.
//   2. Meta faz POST a cada novo lead -> evento só contém IDs.
//   3. Buscamos os dados reais do lead na Graph API usando o leadgen_id.
//   4. Inserimos em `patients` (com upsert por meta_leadgen_id para evitar
//      duplicar caso a Meta reenvie o mesmo evento).
//
// Variáveis de ambiente necessárias (configurar via `supabase secrets set`):
//   META_VERIFY_TOKEN        — string escolhida por você, usada no handshake
//   META_APP_SECRET          — App Secret do app no Meta Business (para verificar assinatura HMAC)
//   META_PAGE_ACCESS_TOKEN   — Page Access Token gerado no Meta Business
//   SUPABASE_URL             — injetada automaticamente pelo Supabase
//   SUPABASE_SERVICE_ROLE_KEY— injetada automaticamente pelo Supabase
//
// Deploy:
//   supabase functions deploy meta-leadgen-webhook --no-verify-jwt
//
// (--no-verify-jwt é necessário porque a Meta não envia o header de auth do Supabase)

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const VERIFY_TOKEN = Deno.env.get('META_VERIFY_TOKEN') ?? '';
const APP_SECRET = Deno.env.get('META_APP_SECRET') ?? '';
const PAGE_ACCESS_TOKEN = Deno.env.get('META_PAGE_ACCESS_TOKEN') ?? '';
const GRAPH_API_VERSION = 'v19.0';

/** Verifica a assinatura HMAC-SHA256 enviada pela Meta no header X-Hub-Signature-256. */
async function verifyMetaSignature(body: Uint8Array, signatureHeader: string | null): Promise<boolean> {
  if (!APP_SECRET) return false; // sem secret configurado = rejeita (falha fechada)
  if (!signatureHeader?.startsWith('sha256=')) return false;
  const expected = signatureHeader.slice('sha256='.length);
  const key = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(APP_SECRET),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const sig = await crypto.subtle.sign('HMAC', key, body);
  const computed = Array.from(new Uint8Array(sig))
    .map(b => b.toString(16).padStart(2, '0'))
    .join('');
  if (computed.length !== expected.length) return false;
  let diff = 0;
  for (let i = 0; i < computed.length; i++) diff |= computed.charCodeAt(i) ^ expected.charCodeAt(i);
  return diff === 0;
}

const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY);

interface FieldDatum {
  name: string;
  values: string[];
}

interface LeadgenChange {
  field: string;
  value: {
    leadgen_id: string;
    page_id?: string;
    form_id?: string;
    ad_id?: string;
    created_time?: number;
  };
}

// ── Consentimento (opt-in WhatsApp) ─────────────────────────────────────
// META_CONSENT_KEYS: nomes (separados por vírgula) da pergunta/checkbox de
//   aceite no formulário da Meta. Padrão abaixo.
// META_CONSENT_TEXTO_VIGENCIA: data (AAAA-MM-DD) em que o texto do aceite
//   exibido no formulário passou a valer. Sem ela não há evidência suficiente
//   e o lead fica 'incerto' mesmo marcando o checkbox.
const CONSENT_KEYS = (Deno.env.get('META_CONSENT_KEYS') ?? 'consentimento_whatsapp,aceite_whatsapp,whatsapp_opt_in')
  .split(',').map(k => k.trim().toLowerCase()).filter(Boolean);
const CONSENT_VIGENCIA = (Deno.env.get('META_CONSENT_TEXTO_VIGENCIA') ?? '').trim();

interface DisclaimerResponse { checkbox_key?: string; is_checked?: string | boolean }
interface LeadData {
  field_data: FieldDatum[];
  custom_disclaimer_responses: DisclaimerResponse[];
  created_time?: string;
}

/** Busca os dados reais do lead na Graph API a partir do leadgen_id. */
async function fetchLeadData(leadgenId: string): Promise<LeadData> {
  const url = `https://graph.facebook.com/${GRAPH_API_VERSION}/${encodeURIComponent(leadgenId)}`
    + '?fields=field_data,custom_disclaimer_responses,created_time';
  // Token no header (não na URL) para não aparecer em logs de proxy.
  const res = await fetch(url, { headers: { Authorization: `Bearer ${PAGE_ACCESS_TOKEN}` } });
  const json = await res.json();
  if (!res.ok) {
    // Só o código do erro: a resposta da Meta pode ecoar dados do lead.
    throw new Error(`Graph API error ${res.status} code=${json?.error?.code ?? '?'}`);
  }
  return {
    field_data: (json.field_data ?? []) as FieldDatum[],
    custom_disclaimer_responses: (json.custom_disclaimer_responses ?? []) as DisclaimerResponse[],
    created_time: json.created_time,
  };
}

/** Converte o array field_data da Meta num objeto simples { campo: valor }. */
function mapFieldData(fieldData: FieldDatum[]): Record<string, string> {
  const map: Record<string, string> = {};
  for (const f of fieldData) {
    if (!f?.name) continue;
    map[f.name.toLowerCase()] = f.values?.[0] ?? '';
  }
  return map;
}

/** Tenta achar o valor de um campo por uma lista de nomes possíveis (PT/EN). */
function pick(map: Record<string, string>, candidates: string[]): string {
  for (const c of candidates) {
    if (map[c]) return map[c];
  }
  return '';
}

const SIM = new Set(['sim', 'yes', 'true', '1', 'aceito', 'concordo', 'autorizo', 'checked']);
const NAO = new Set(['nao', 'não', 'no', 'false', '0', 'recuso', 'nao_aceito', 'não aceito']);

/** 'sim' | 'nao' | null. Ausente ou ambíguo = null (fica 'incerto'). */
function lerConsentimento(lead: LeadData, map: Record<string, string>): { valor: 'sim' | 'nao' | null; campo: string | null } {
  for (const d of lead.custom_disclaimer_responses) {
    const key = String(d?.checkbox_key ?? '').toLowerCase();
    if (!CONSENT_KEYS.includes(key)) continue;
    const v = String(d?.is_checked ?? '').toLowerCase();
    if (v === 'true' || v === '1') return { valor: 'sim', campo: key };
    if (v === 'false' || v === '0') return { valor: 'nao', campo: key };
    return { valor: null, campo: key };
  }
  for (const key of CONSENT_KEYS) {
    if (!(key in map)) continue;
    const v = String(map[key] ?? '').trim().toLowerCase();
    if (SIM.has(v)) return { valor: 'sim', campo: key };
    if (NAO.has(v)) return { valor: 'nao', campo: key };
    return { valor: null, campo: key };
  }
  return { valor: null, campo: null };
}

async function handleLeadgenChange(change: LeadgenChange) {
  const { leadgen_id, ad_id, form_id } = change.value;
  if (!leadgen_id) return;

  const lead = await fetchLeadData(leadgen_id);
  const map = mapFieldData(lead.field_data);

  const name = pick(map, ['full_name', 'nome', 'name']) || 'Lead Instagram (sem nome)';
  const email = pick(map, ['email', 'e-mail']);
  const phone = pick(map, ['phone_number', 'telefone', 'celular', 'whatsapp']);

  const row = {
    name,
    email,
    phone,
    status: 'lead',
    source: 'instagram',
    is_lead: true,
    meta_leadgen_id: leadgen_id,
    meta_ad_id: ad_id ?? null,
    meta_form_id: form_id ?? null,
    observation: 'Lead capturado automaticamente via Instagram (Lead Ads).',
  };

  const { error } = await supabase
    .from('patients')
    .upsert(row, { onConflict: 'meta_leadgen_id', ignoreDuplicates: true });

  if (error) {
    console.error('Erro ao inserir lead do Instagram: code=', error.code);   // sem dados do lead
    throw new Error(`insert failed code=${error.code}`);
  }

  // Consentimento: registra pelo gancho do banco (que nunca desfaz opt-out
  // nem transforma 'nao' em 'sim').
  const { data: saved, error: findErr } = await supabase
    .from('patients').select('id').eq('meta_leadgen_id', leadgen_id).maybeSingle();
  if (findErr || !saved?.id) {
    console.error('Lead Ads: não achei o lead para registrar consentimento. code=', findErr?.code ?? 'not_found');
    return;
  }

  const cons = lerConsentimento(lead, map);
  let valor = cons.valor;
  if (valor === 'sim' && !/^\d{4}-\d{2}-\d{2}$/.test(CONSENT_VIGENCIA)) {
    console.warn('Lead Ads: META_CONSENT_TEXTO_VIGENCIA ausente/inválida — aceite registrado como incerto.');
    valor = null;
  }
  const evidencia = [
    'lead_ad',
    `form=${form_id ?? '?'}`,
    `ad=${ad_id ?? '?'}`,
    `leadgen=${leadgen_id}`,
    `campo=${cons.campo ?? 'ausente'}`,
    `resposta=${cons.valor ?? 'ausente_ou_ambigua'}`,
    `respondido_em=${lead.created_time ?? '?'}`,
    `texto_aceite_vigente_desde=${CONSENT_VIGENCIA || 'nao_configurado'}`,
  ].join(' ');

  const { error: rpcErr } = await supabase.rpc('registrar_consentimento_entrada', {
    p_patient_id: saved.id,
    p_origem: 'lead_ad',
    p_consentimento: valor,
    p_evidencia: evidencia,
  });
  if (rpcErr) console.error('Lead Ads: falha ao registrar consentimento. code=', rpcErr.code);
}

Deno.serve(async (req: Request) => {
  const url = new URL(req.url);

  // ── Handshake de verificação do webhook (GET) ──────────────────────────
  if (req.method === 'GET') {
    const mode = url.searchParams.get('hub.mode');
    const token = url.searchParams.get('hub.verify_token');
    const challenge = url.searchParams.get('hub.challenge');

    if (VERIFY_TOKEN && mode === 'subscribe' && token === VERIFY_TOKEN && challenge) {
      return new Response(challenge, { status: 200 });
    }
    return new Response('Forbidden', { status: 403 });
  }

  // ── Eventos de lead (POST) ──────────────────────────────────────────────
  if (req.method === 'POST') {
    try {
      const rawBody = await req.arrayBuffer();
      const bodyBytes = new Uint8Array(rawBody);

      // Verifica assinatura HMAC — protege contra POSTs falsos
      const sig = req.headers.get('X-Hub-Signature-256');
      const valid = await verifyMetaSignature(bodyBytes, sig);
      if (!valid) {
        console.warn('Webhook rejeitado: assinatura inválida');
        return new Response('Forbidden', { status: 403 });
      }

      const body = JSON.parse(new TextDecoder().decode(bodyBytes));
      const entries = body.entry ?? [];

      for (const entry of entries) {
        const changes: LeadgenChange[] = entry.changes ?? [];
        for (const change of changes) {
          if (change.field === 'leadgen') {
            await handleLeadgenChange(change);
          }
        }
      }
    } catch (err) {
      console.error('Erro ao processar webhook da Meta:', err instanceof Error ? err.message : 'erro');
      // Erro de processamento: responde 500 para a Meta REENVIAR o evento
      // (o upsert por meta_leadgen_id é idempotente, então não duplica).
      return new Response('ERROR', { status: 500 });
    }
    return new Response('EVENT_RECEIVED', { status: 200 });
  }

  return new Response('Method Not Allowed', { status: 405 });
});
