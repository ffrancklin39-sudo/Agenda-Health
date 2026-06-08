-- Adiciona campo para rastrear quando o lead entrou no status atual
-- (necessário para a automação de follow-up: detectar "dias parado na coluna",
-- não "dias desde que o lead foi criado")

ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS stage_entered_at timestamptz DEFAULT now();

-- Preenche os registros existentes com a melhor data disponível
UPDATE patients
SET stage_entered_at = COALESCE(updated_at, created_at, now())
WHERE stage_entered_at IS NULL;
