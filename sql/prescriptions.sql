-- ============================================================
-- Módulo Prescrições e Orientações — SintesIA
-- Rodar no Supabase SQL Editor
-- ============================================================

-- Templates de prescrição (modelo reutilizável)
CREATE TABLE IF NOT EXISTS prescription_templates (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text NOT NULL,
  description  text,
  record_type  text NOT NULL DEFAULT 'prescricao', -- prescricao | orientacao | protocolo
  fields       jsonb NOT NULL DEFAULT '[]',
  is_active    boolean DEFAULT true,
  created_at   timestamptz DEFAULT now(),
  updated_at   timestamptz DEFAULT now()
);

-- Prescrições preenchidas por paciente
CREATE TABLE IF NOT EXISTS prescription_records (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id      uuid NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  professional_id uuid REFERENCES professionals(id),
  template_id     uuid REFERENCES prescription_templates(id),
  template_name   text NOT NULL,
  record_type     text NOT NULL DEFAULT 'prescricao', -- prescricao | orientacao | protocolo
  answers         jsonb NOT NULL DEFAULT '{}',
  is_active       boolean DEFAULT true,
  created_at      timestamptz DEFAULT now(),
  updated_at      timestamptz DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_prescription_records_patient ON prescription_records(patient_id);
CREATE INDEX IF NOT EXISTS idx_prescription_records_created ON prescription_records(created_at DESC);

-- RLS
ALTER TABLE prescription_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE prescription_records   ENABLE ROW LEVEL SECURITY;

CREATE POLICY "prescription_templates_auth_all"
  ON prescription_templates FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

CREATE POLICY "prescription_records_auth_all"
  ON prescription_records FOR ALL TO authenticated
  USING (true) WITH CHECK (true);
