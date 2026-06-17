-- crm_ai_layer.sql
-- Camada 2 do CRM: Resumo IA + Lead Quente (Gemini)
-- Execute no Supabase SQL Editor

-- Cache da análise de IA por paciente/lead — evita chamar o Gemini a cada
-- renderização. A análise só é re-gerada quando o usuário clicar em
-- "Atualizar" no painel de histórico.
ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS ai_summary TEXT,
  ADD COLUMN IF NOT EXISTS ai_summary_updated_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS lead_temperature TEXT,        -- 'quente' | 'morno' | 'frio'
  ADD COLUMN IF NOT EXISTS lead_temperature_reason TEXT; -- explicação curta gerada pela IA

COMMENT ON COLUMN patients.ai_summary IS 'Resumo gerado pela IA (Gemini) do histórico do paciente/lead';
COMMENT ON COLUMN patients.lead_temperature IS 'Classificação de urgência/interesse gerada pela IA: quente, morno ou frio';
