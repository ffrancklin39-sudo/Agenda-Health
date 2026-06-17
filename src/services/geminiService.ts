// geminiService.ts
// Camada 2 do CRM — Inteligência conversacional (Gemini)
// Responsável por: resumo automático do histórico do paciente/lead
// e análise de interesse/urgência ("lead quente").
//
// Mantém o cache no banco (colunas ai_summary / lead_temperature em
// `patients`, ver sql/crm_ai_layer.sql) — este serviço só é chamado
// quando o usuário pede explicitamente para gerar/atualizar a análise.

import { GoogleGenAI, Type } from '@google/genai';
import { Patient, PatientHistory } from '../types';

const API_KEY = import.meta.env.VITE_GEMINI_API_KEY as string | undefined;
const MODEL = 'gemini-2.5-flash';

let client: GoogleGenAI | null = null;
function getClient(): GoogleGenAI {
  if (!API_KEY) {
    throw new Error('VITE_GEMINI_API_KEY não configurada em .env.local');
  }
  if (!client) {
    client = new GoogleGenAI({ apiKey: API_KEY });
  }
  return client;
}

export interface PatientAIAnalysis {
  summary: string;
  temperature: 'quente' | 'morno' | 'frio';
  temperatureReason: string;
}

export const isGeminiConfigured = (): boolean => !!API_KEY;

/** Monta um texto compacto com os dados relevantes do lead + timeline para o prompt. */
function buildContext(patient: Patient, history: PatientHistory[]): string {
  const days = patient.created_at
    ? Math.floor((Date.now() - new Date(patient.created_at).getTime()) / (1000 * 60 * 60 * 24))
    : null;

  const lines: string[] = [];
  lines.push(`Nome: ${patient.name || 'Sem nome'}`);
  lines.push(`Status atual no funil: ${patient.status || 'lead'}`);
  if (patient.source) lines.push(`Origem do lead: ${patient.source}`);
  if (days !== null) lines.push(`Dias desde a criação do lead: ${days}`);
  if (patient.price) lines.push(`Valor do procedimento de interesse: R$ ${patient.price}`);
  if (patient.observation) lines.push(`Observações cadastradas: ${patient.observation}`);
  if (patient.reminderDate) lines.push(`Possui lembrete agendado para: ${patient.reminderDate}`);

  if (history.length === 0) {
    lines.push('\nNenhum evento registrado no histórico ainda.');
  } else {
    lines.push('\nHistórico de interações (mais recente primeiro):');
    history.slice(0, 25).forEach(ev => {
      const when = ev.date || ev.created_at;
      const whenStr = when ? new Date(when).toLocaleDateString('pt-BR') : '';
      lines.push(`- [${whenStr}] (${ev.event_type}) ${ev.notes || ev.description || ''}`);
    });
  }
  return lines.join('\n');
}

/**
 * Gera o resumo + classificação de temperatura do lead via Gemini.
 * Lança erro se a chave não estiver configurada ou a chamada falhar —
 * quem chama deve tratar e mostrar feedback ao usuário.
 */
export async function analyzePatient(
  patient: Patient,
  history: PatientHistory[]
): Promise<PatientAIAnalysis> {
  const ai = getClient();
  const context = buildContext(patient, history);

  const prompt = `Você é um assistente de CRM para uma clínica de saúde estética/integrada. Analise o lead abaixo e responda em português do Brasil, de forma objetiva e profissional.

${context}

Tarefas:
1. Escreva um resumo curto (2 a 4 frases) do histórico e situação atual deste lead/paciente, útil para a recepção entender rapidamente o contexto sem reler tudo.
2. Classifique a temperatura do lead como "quente" (alto interesse/urgência, agir agora), "morno" (interesse moderado, acompanhar) ou "frio" (baixo engajamento ou parado há muito tempo).
3. Explique em uma frase curta o motivo da classificação.`;

  const response = await ai.models.generateContent({
    model: MODEL,
    contents: prompt,
    config: {
      responseMimeType: 'application/json',
      responseSchema: {
        type: Type.OBJECT,
        properties: {
          summary: { type: Type.STRING },
          temperature: { type: Type.STRING, enum: ['quente', 'morno', 'frio'] },
          temperatureReason: { type: Type.STRING },
        },
        required: ['summary', 'temperature', 'temperatureReason'],
      },
    },
  });

  const text = response.text;
  if (!text) throw new Error('Resposta vazia do Gemini');

  const parsed = JSON.parse(text);
  const temperature = ['quente', 'morno', 'frio'].includes(parsed.temperature)
    ? parsed.temperature
    : 'morno';

  return {
    summary: String(parsed.summary || '').trim(),
    temperature,
    temperatureReason: String(parsed.temperatureReason || '').trim(),
  };
}
