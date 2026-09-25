-- ============================================================
-- SintesIA — Tabela: patient_clinical_notes (Prontuário)
-- Armazena prescrições, atestados, pedidos de exame e diagnósticos
-- ============================================================

CREATE TABLE IF NOT EXISTS patient_clinical_notes (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id   UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  type         TEXT NOT NULL DEFAULT 'prescricao',
                -- 'prescricao' | 'atestado' | 'pedido_exame' | 'diagnostico' | 'nota'
  content      TEXT,          -- HTML do Feegow ou texto livre
  professional TEXT,          -- Nome do profissional
  note_date    TIMESTAMPTZ,   -- Data da consulta/emissão
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_clinical_notes_patient ON patient_clinical_notes(patient_id);
CREATE INDEX IF NOT EXISTS idx_clinical_notes_date    ON patient_clinical_notes(note_date DESC);

-- RLS
ALTER TABLE patient_clinical_notes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "cn_select" ON patient_clinical_notes
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "cn_insert" ON patient_clinical_notes
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "cn_update" ON patient_clinical_notes
  FOR UPDATE USING (auth.role() = 'authenticated')
             WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "cn_delete" ON patient_clinical_notes
  FOR DELETE USING (auth.role() = 'authenticated');

-- Verificação:
-- SELECT COUNT(*) FROM patient_clinical_notes;
