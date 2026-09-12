// geminiService.ts
// Camada de IA do CRM — chama a Edge Function 'gemini-analyze' no Supabase.
// A chave do Gemini fica exclusivamente no servidor (Supabase Secret).

import { supabase } from './supabaseClient';
import { Patient, PatientHistory } from '../types';

export interface PatientAIAnalysis {
  summary: string;
  temperature: 'quente' | 'morno' | 'frio';
  temperatureReason: string;
  nextAction: string;
  messageDraft: string;
}

/** Sempre retorna true — a disponibilidade real é verificada pela Edge Function */
export const isGeminiConfigured = (): boolean => true;

/**
 * Gera resumo + classificação de temperatura via Edge Function segura.
 * Lança erro se a chamada falhar — quem chama deve tratar e mostrar feedback.
 */
export async function analyzePatient(
  patient: Patient,
  history: PatientHistory[]
): Promise<PatientAIAnalysis> {
  const { data, error } = await supabase.functions.invoke('gemini-analyze', {
    body: { patient, history },
  });

  if (error) {
    throw new Error(error.message || 'Erro ao chamar análise de IA');
  }

  if (data?.error) {
    throw new Error(data.error);
  }

  const validTemps = ['quente', 'morno', 'frio'];
  return {
    summary:           String(data.summary           || '').trim(),
    temperature:       validTemps.includes(data.temperature) ? data.temperature : 'morno',
    temperatureReason: String(data.temperatureReason || '').trim(),
    nextAction:        String(data.nextAction        || '').trim(),
    messageDraft:      String(data.messageDraft      || '').trim(),
  };
}

/**
 * Geração de texto livre — mantida por compatibilidade com PatientProfile.
 * Chama a Edge Function com um prompt direto (sem análise estruturada).
 */
export async function generateTextContent(prompt: string): Promise<string> {
  const { data, error } = await supabase.functions.invoke('gemini-analyze', {
    body: { freePrompt: prompt },
  });

  if (error) throw new Error(error.message || 'Erro ao gerar texto');
  if (data?.error) throw new Error(data.error);
  return String(data?.text || '').trim();
}
