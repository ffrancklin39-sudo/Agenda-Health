-- crm_ai_next_action.sql
-- Camada 2 do CRM: Próxima Melhor Ação + Rascunho de Mensagem (Gemini)
-- Execute no Supabase SQL Editor
--
-- Extensão de crm_ai_layer.sql (ai_summary / lead_temperature). Reaproveita
-- o mesmo cache: só é re-gerado quando o usuário clicar em "Gerar/Atualizar
-- resumo" no painel do lead — não chama o Gemini em toda renderização.

ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS ai_next_action TEXT,    -- ação recomendada (ex: "Ligar hoje oferecendo agendamento")
  ADD COLUMN IF NOT EXISTS ai_message_draft TEXT;  -- rascunho de mensagem em PT-BR para revisão humana antes de enviar

COMMENT ON COLUMN patients.ai_next_action IS 'Próxima melhor ação sugerida pela IA (Gemini) para este lead/paciente';
COMMENT ON COLUMN patients.ai_message_draft IS 'Rascunho de mensagem gerado pela IA — SEMPRE para revisão humana antes de enviar, nunca disparado automaticamente';
