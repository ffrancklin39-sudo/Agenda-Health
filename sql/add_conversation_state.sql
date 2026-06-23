-- add_conversation_state.sql
-- Sofia 2.0 — máquina de estados da conversa (separada do funil comercial `status`)
-- Ver docs/sofia-arquitetura-definitiva.md, seção 4
-- Execute no Supabase SQL Editor

-- Por que um campo novo e não reaproveitar `status`:
-- `status` é o funil comercial do CRM (novo, contatado, agendado, descartado...).
-- Sobrecarregá-lo para também controlar se a Sofia pode falar (valor 'waiting')
-- foi a causa indireta de mais de um incidente: uma mudança no funil podia
-- destravar a Sofia por acidente, e vice-versa. `conversation_state` controla
-- exclusivamente a permissão de a Sofia responder.

ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS conversation_state TEXT;

COMMENT ON COLUMN patients.conversation_state IS
  'Estado da conversa com a Sofia (separado do funil `status`). Valores: NOVO_LEAD, SOFIA_ATIVA, HUMANO_ASSUMIU, CONVERTIDO, LEAD_FRIO. NULL = nunca conversou com a Sofia.';

-- Trava de valores válidos (fail-safe: evita strings soltas por erro de digitação em algum node do n8n)
ALTER TABLE patients
  DROP CONSTRAINT IF EXISTS chk_conversation_state_valid;

ALTER TABLE patients
  ADD CONSTRAINT chk_conversation_state_valid
  CHECK (conversation_state IS NULL OR conversation_state IN (
    'NOVO_LEAD',
    'SOFIA_ATIVA',
    'HUMANO_ASSUMIU',
    'CONVERTIDO',
    'LEAD_FRIO'
  ));

-- Índice — todo node de decisão (`PODE_SOFIA_RESPONDER`) filtra por esse campo
CREATE INDEX IF NOT EXISTS idx_patients_conversation_state
  ON patients (conversation_state);

-- Backfill best-effort a partir do estado atual, só pra não deixar tudo NULL
-- de uma vez (NULL já é tratado como "não responde" pelo fail-safe do node de
-- decisão, então isso é só conveniência, não é obrigatório pra segurança).
UPDATE patients
SET conversation_state = CASE
  WHEN status = 'waiting' THEN 'HUMANO_ASSUMIU'
  WHEN status = 'discarded' THEN 'LEAD_FRIO'
  WHEN is_lead = true THEN 'NOVO_LEAD'
  ELSE NULL
END
WHERE conversation_state IS NULL;
