// supabase/functions/gemini-analyze/index.ts
// Proxy seguro para o Google Gemini — a chave nunca vai para o frontend.
// Chamado via supabase.functions.invoke('gemini-analyze', { body: { patient, history } })

import { createClient } from 'jsr:@supabase/supabase-js@2';

const GEMINI_KEY = Deno.env.get('GEMINI_API_KEY');
const GEMINI_MODEL = 'gemini-2.5-flash';
const GEMINI_URL = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_KEY}`;

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    // Valida autenticação — só usuários logados podem chamar
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Não autorizado' }), {
        status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      { global: { headers: { Authorization: authHeader } } }
    );
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) {
      return new Response(JSON.stringify({ error: 'Sessão inválida' }), {
        status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    if (!GEMINI_KEY) {
      return new Response(JSON.stringify({ error: 'Gemini não configurado no servidor' }), {
        status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const body = await req.json();
    const { patient, history, freePrompt } = body;

    // Modo 1: texto livre (usado por generateTextContent)
    if (freePrompt) {
      const geminiRes = await fetch(GEMINI_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ contents: [{ parts: [{ text: String(freePrompt) }] }] }),
      });
      if (!geminiRes.ok) {
        const errText = await geminiRes.text();
        return new Response(JSON.stringify({ error: 'Erro Gemini', detail: errText }), {
          status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }
      const gd = await geminiRes.json();
      const text = gd?.candidates?.[0]?.content?.parts?.[0]?.text ?? '';
      return new Response(JSON.stringify({ text }), {
        status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Modo 2: análise estruturada de lead
    if (!patient) {
      return new Response(JSON.stringify({ error: 'Dados do paciente ausentes' }), {
        status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const context = buildContext(patient, history ?? []);
    const prompt = buildPrompt(context);

    const geminiRes = await fetch(GEMINI_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{ parts: [{ text: prompt }] }],
        generationConfig: {
          responseMimeType: 'application/json',
          responseSchema: {
            type: 'OBJECT',
            properties: {
              summary:             { type: 'STRING' },
              temperature:         { type: 'STRING', enum: ['quente', 'morno', 'frio'] },
              temperatureReason:   { type: 'STRING' },
              nextAction:          { type: 'STRING' },
              messageDraft:        { type: 'STRING' },
            },
            required: ['summary', 'temperature', 'temperatureReason', 'nextAction', 'messageDraft'],
          },
        },
      }),
    });

    if (!geminiRes.ok) {
      const errText = await geminiRes.text();
      console.error('[gemini-analyze] Gemini error:', errText);
      return new Response(JSON.stringify({ error: 'Erro ao chamar Gemini', detail: errText }), {
        status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const geminiData = await geminiRes.json();
    const text = geminiData?.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!text) {
      return new Response(JSON.stringify({ error: 'Resposta vazia do Gemini' }), {
        status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const parsed = JSON.parse(text);
    const validTemps = ['quente', 'morno', 'frio'];
    const result = {
      summary:           String(parsed.summary           || '').trim(),
      temperature:       validTemps.includes(parsed.temperature) ? parsed.temperature : 'morno',
      temperatureReason: String(parsed.temperatureReason || '').trim(),
      nextAction:        String(parsed.nextAction        || '').trim(),
      messageDraft:      String(parsed.messageDraft      || '').trim(),
    };

    return new Response(JSON.stringify(result), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (err) {
    console.error('[gemini-analyze] Unexpected error:', err);
    return new Response(JSON.stringify({ error: 'Erro interno', detail: String(err) }), {
      status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});

// ── helpers ────────────────────────────────────────────────────────────────

function buildContext(patient: Record<string, unknown>, history: Record<string, unknown>[]): string {
  const days = patient.created_at
    ? Math.floor((Date.now() - new Date(String(patient.created_at)).getTime()) / 86_400_000)
    : null;

  const lines: string[] = [
    `Nome: ${patient.name || 'Sem nome'}`,
    `Status atual no funil: ${patient.status || 'lead'}`,
  ];
  if (patient.source)       lines.push(`Origem do lead: ${patient.source}`);
  if (days !== null)        lines.push(`Dias desde a criação: ${days}`);
  if (patient.price)        lines.push(`Valor do procedimento: R$ ${patient.price}`);
  if (patient.observation)  lines.push(`Observações: ${patient.observation}`);
  if (patient.reminderDate) lines.push(`Lembrete: ${patient.reminderDate}`);

  if (history.length === 0) {
    lines.push('\nNenhum evento registrado ainda.');
  } else {
    lines.push('\nHistórico (mais recente primeiro):');
    history.slice(0, 25).forEach((ev) => {
      const when = ev.date || ev.created_at;
      const whenStr = when ? new Date(String(when)).toLocaleDateString('pt-BR') : '';
      lines.push(`- [${whenStr}] (${ev.event_type}) ${ev.notes || ev.description || ''}`);
    });
  }
  return lines.join('\n');
}

function buildPrompt(context: string): string {
  return `Você é um assistente de CRM para uma clínica de saúde integrada. Analise o lead abaixo e responda em português do Brasil, de forma objetiva e profissional.

${context}

Tarefas:
1. Escreva um resumo curto (2 a 4 frases) do histórico e situação atual deste lead/paciente.
2. Classifique a temperatura: "quente" (alto interesse, agir agora), "morno" (interesse moderado) ou "frio" (baixo engajamento).
3. Explique em uma frase curta o motivo da classificação.
4. Sugira a próxima melhor ação para a recepção em uma frase curta e prática.
5. Escreva um rascunho de mensagem de WhatsApp (2 a 3 frases, tom acolhedor, sem emojis em excesso) para revisão humana antes de enviar.`;
}
