-- ============================================================
--  SintesIA — Migração: Novos campos da ficha do paciente
--  Rode isso no SQL Editor do Supabase
-- ============================================================

ALTER TABLE patients
  -- Identidade
  ADD COLUMN IF NOT EXISTS social_name         TEXT,
  ADD COLUMN IF NOT EXISTS rg                  TEXT,
  ADD COLUMN IF NOT EXISTS cns                 TEXT,
  ADD COLUMN IF NOT EXISTS birth_date          DATE,
  ADD COLUMN IF NOT EXISTS gender              TEXT,
  ADD COLUMN IF NOT EXISTS skin_color          TEXT,
  ADD COLUMN IF NOT EXISTS civil_status        TEXT,
  ADD COLUMN IF NOT EXISTS profession          TEXT,
  ADD COLUMN IF NOT EXISTS education           TEXT,
  ADD COLUMN IF NOT EXISTS religion            TEXT,
  ADD COLUMN IF NOT EXISTS nationality         TEXT,
  ADD COLUMN IF NOT EXISTS birthplace          TEXT,

  -- Dados físicos
  ADD COLUMN IF NOT EXISTS height              NUMERIC(5,2),
  ADD COLUMN IF NOT EXISTS weight              NUMERIC(5,2),
  ADD COLUMN IF NOT EXISTS blood_type          TEXT,

  -- Sistema
  ADD COLUMN IF NOT EXISTS record_number       TEXT,
  ADD COLUMN IF NOT EXISTS priority            TEXT DEFAULT 'normal',
  ADD COLUMN IF NOT EXISTS alerts              TEXT,

  -- Contatos extras
  ADD COLUMN IF NOT EXISTS phone2              TEXT,
  ADD COLUMN IF NOT EXISTS cell2               TEXT,
  ADD COLUMN IF NOT EXISTS email2              TEXT,
  ADD COLUMN IF NOT EXISTS instagram           TEXT,

  -- Endereço detalhado
  ADD COLUMN IF NOT EXISTS address             TEXT,
  ADD COLUMN IF NOT EXISTS address_number      TEXT,
  ADD COLUMN IF NOT EXISTS address_complement  TEXT,
  ADD COLUMN IF NOT EXISTS neighborhood        TEXT,
  ADD COLUMN IF NOT EXISTS zip_code            TEXT,
  ADD COLUMN IF NOT EXISTS city                TEXT,
  ADD COLUMN IF NOT EXISTS state               TEXT,
  ADD COLUMN IF NOT EXISTS country             TEXT DEFAULT 'Brasil',

  -- Convênio (simplificado — linha única por ora)
  ADD COLUMN IF NOT EXISTS insurance           TEXT,
  ADD COLUMN IF NOT EXISTS insurance_plan      TEXT,
  ADD COLUMN IF NOT EXISTS insurance_card      TEXT,
  ADD COLUMN IF NOT EXISTS insurance_expires   DATE,
  ADD COLUMN IF NOT EXISTS insurance_holder    TEXT,

  -- Clínico
  ADD COLUMN IF NOT EXISTS medical_notes       TEXT,
  ADD COLUMN IF NOT EXISTS observation         TEXT;
ALTER TABLE patients ADD COLUMN IF NOT EXISTS duration_minutes INTEGER DEFAULT 60;
