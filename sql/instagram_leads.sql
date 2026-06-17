-- instagram_leads.sql
-- Captura automática de Lead Ads do Instagram/Facebook via webhook da Meta
-- Execute no Supabase SQL Editor

-- Garante que a coluna usada em todo o CRMi para distinguir leads de
-- pacientes clínicos migrados existe (caso ainda não exista no schema).
ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS is_lead BOOLEAN DEFAULT false;

-- Guarda o id do lead na Meta (leadgen_id) para evitar duplicar o mesmo
-- lead caso o webhook seja reenviado (a Meta reenvia em caso de timeout).
ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS meta_leadgen_id TEXT,
  ADD COLUMN IF NOT EXISTS meta_ad_id TEXT,
  ADD COLUMN IF NOT EXISTS meta_form_id TEXT;

CREATE UNIQUE INDEX IF NOT EXISTS idx_patients_meta_leadgen_id
  ON patients (meta_leadgen_id)
  WHERE meta_leadgen_id IS NOT NULL;

COMMENT ON COLUMN patients.meta_leadgen_id IS 'ID do lead no Meta Lead Ads — usado para evitar duplicatas em reenvios do webhook';
