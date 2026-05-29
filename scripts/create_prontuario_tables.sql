-- create_prontuario_tables.sql
-- Execute no Supabase SQL Editor

-- ── Registros clínicos estruturados (prescrições, atestados, exames) ──────────
CREATE TABLE IF NOT EXISTS clinical_records (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id     UUID REFERENCES patients(id) ON DELETE CASCADE,
  record_type    TEXT NOT NULL,  -- Prescricao | Atestado | PedidosExames | Diagnostico
  content_html   TEXT,           -- conteúdo original em HTML
  content_text   TEXT,           -- versão texto puro (para busca)
  professional   TEXT,           -- nome do profissional
  record_date    TIMESTAMPTZ,
  created_at     TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_clinical_records_patient ON clinical_records(patient_id);
CREATE INDEX IF NOT EXISTS idx_clinical_records_type    ON clinical_records(record_type);
CREATE INDEX IF NOT EXISTS idx_clinical_records_date    ON clinical_records(record_date);

-- ── Arquivos dos pacientes (PDFs e imagens) ────────────────────────────────────
CREATE TABLE IF NOT EXISTS patient_files (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id   UUID REFERENCES patients(id) ON DELETE CASCADE,
  file_name    TEXT NOT NULL,       -- nome original do arquivo
  storage_path TEXT,                -- caminho no Supabase Storage
  description  TEXT,                -- descrição do arquivo
  file_type    TEXT,                -- pdf | jpg | png | etc
  folder       TEXT,                -- Arquivos | Imagens | Perfil
  file_size    INTEGER,             -- bytes
  uploaded     BOOLEAN DEFAULT FALSE,
  record_date  TIMESTAMPTZ,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_patient_files_patient ON patient_files(patient_id);
