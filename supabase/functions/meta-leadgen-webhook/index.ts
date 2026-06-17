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
const PAGE_ACCESS_TOKEN = Deno.env.get('META_PAGE_ACCESS_TOKEN') ?? '';
const GRAPH_API_VERSION = 'v19.0';

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

/** Busca os dados reais do lead na Graph API a partir do leadgen_id. */
async function fetchLeadData(leadgenId: string): Promise<FieldDatum[]> {
  const url = `https://graph.facebook.com/${GRAPH_API_VERSION}/${leadgenId}?access_token=${PAGE_ACCESS_TOKEN}`;
  const res = await fetch(url);
  const json = await res.json();
  if (!res.ok) {
    throw new Error(`Graph API error: ${JSON.stringify(json)}`);
  }
  return (json.field_data ?? []) as FieldDatum[];
}

/** Converte o array field_data da Meta num objeto simples { campo: valor }. */
function mapFieldData(fieldData: FieldDatum[]): Record<string, string> {
  const map: Record<string, string> = {};
  for (const f of fieldData) {
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

async function handleLeadgenChange(change: LeadgenChange) {
  const { leadgen_id, ad_id, form_id } = change.value;
  if (!leadgen_id) return;

  const fieldData = await fetchLeadData(leadgen_id);
  const map = mapFieldData(fieldData);

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
    console.error('Erro ao inserir lead do Instagram:', error);
    throw error;
  }
}

Deno.serve(async (req: Request) => {
  const url = new URL(req.url);

  // ── Handshake de verificação do webhook (GET) ──────────────────────────
  if (req.method === 'GET') {
    const mode = url.searchParams.get('hub.mode');
    const token = url.searchParams.get('hub.verify_token');
    const challenge = url.searchParams.get('hub.challenge');

    if (mode === 'subscribe' && token === VERIFY_TOKEN && challenge) {
      return new Response(challenge, { status: 200 });
    }
    return new Response('Forbidden', { status: 403 });
  }

  // ── Eventos de lead (POST) ──────────────────────────────────────────────
  if (req.method === 'POST') {
    try {
      const body = await req.json();
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
      console.error('Erro ao processar webhook da Meta:', err);
      // Mesmo em erro, respondemos 200 — a Meta reenvia agressivamente em
      // caso de erro/timeout, e o upsert idempotente evita duplicatas.
    }
    return new Response('EVENT_RECEIVED', { status: 200 });
  }

  return new Response('Method Not Allowed', { status: 405 });
});
