-- add_patient_columns.sql
-- Execute no Supabase SQL Editor para adicionar os campos faltantes em patients
ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS birth_date     DATE,
  ADD COLUMN IF NOT EXISTS gender         TEXT,
  ADD COLUMN IF NOT EXISTS social_name    TEXT,
  ADD COLUMN IF NOT EXISTS rg             TEXT,
  ADD COLUMN IF NOT EXISTS cns            TEXT,
  ADD COLUMN IF NOT EXISTS civil_status   TEXT,
  ADD COLUMN IF NOT EXISTS profession     TEXT,
  ADD COLUMN IF NOT EXISTS education      TEXT,
  ADD COLUMN IF NOT EXISTS blood_type     TEXT,
  ADD COLUMN IF NOT EXISTS height         DECIMAL(5,2),
  ADD COLUMN IF NOT EXISTS weight         DECIMAL(5,2),
  ADD COLUMN IF NOT EXISTS alerts         TEXT,
  ADD COLUMN IF NOT EXISTS medical_notes  TEXT,
  -- Endereço
  ADD COLUMN IF NOT EXISTS address            TEXT,
  ADD COLUMN IF NOT EXISTS address_number     TEXT,
  ADD COLUMN IF NOT EXISTS address_complement TEXT,
  ADD COLUMN IF NOT EXISTS neighborhood       TEXT,
  ADD COLUMN IF NOT EXISTS zip_code           TEXT,
  ADD COLUMN IF NOT EXISTS city               TEXT,
  ADD COLUMN IF NOT EXISTS state              TEXT,
  ADD COLUMN IF NOT EXISTS country            TEXT DEFAULT 'Brasil',
  -- Contatos extras
  ADD COLUMN IF NOT EXISTS phone2     TEXT,
  ADD COLUMN IF NOT EXISTS email2     TEXT,
  ADD COLUMN IF NOT EXISTS instagram  TEXT;
