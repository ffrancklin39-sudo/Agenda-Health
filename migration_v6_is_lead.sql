-- ============================================================================
-- MIGRATION V6 — Separar pacientes clínicos de leads do CRM
-- Execute no Supabase SQL Editor
-- ============================================================================

-- 1. Adiciona o campo is_lead (default false para todos existentes)
ALTER TABLE patients ADD COLUMN IF NOT EXISTS is_lead BOOLEAN DEFAULT FALSE;

-- 2. Marca como lead apenas os que nunca tiveram agendamento real
--    (status lead, negotiation, waiting, discarded — jamais scheduled/confirmed)
UPDATE patients
SET is_lead = TRUE
WHERE status IN ('lead', 'negotiation', 'waiting', 'discarded')
  AND id NOT IN (SELECT DISTINCT patient_id FROM appointments WHERE patient_id IS NOT NULL);

-- 3. Verifica o resultado antes de finalizar
SELECT
  status,
  is_lead,
  COUNT(*) as total
FROM patients
GROUP BY status, is_lead
ORDER BY status, is_lead;
