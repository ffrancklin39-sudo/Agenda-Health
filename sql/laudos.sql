-- ============================================================
-- Módulo Laudos e Formulários — SintesIA
-- Rodar no Supabase SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS laudo_templates (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text NOT NULL,
  description  text,
  record_type  text NOT NULL DEFAULT 'laudo', -- laudo | formulario | atestado | declaracao
  fields       jsonb NOT NULL DEFAULT '[]',
  is_active    boolean DEFAULT true,
  created_at   timestamptz DEFAULT now(),
  updated_at   timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS laudo_records (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id      uuid NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  professional_id uuid REFERENCES professionals(id),
  template_id     uuid REFERENCES laudo_templates(id),
  template_name   text NOT NULL,
  record_type     text NOT NULL DEFAULT 'laudo',
  answers         jsonb NOT NULL DEFAULT '{}',
  is_active       boolean DEFAULT true,
  created_at      timestamptz DEFAULT now(),
  updated_at      timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_laudo_records_patient ON laudo_records(patient_id);
CREATE INDEX IF NOT EXISTS idx_laudo_records_created ON laudo_records(created_at DESC);

ALTER TABLE laudo_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE laudo_records   ENABLE ROW LEVEL SECURITY;

CREATE POLICY "laudo_templates_auth_all"
  ON laudo_templates FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

CREATE POLICY "laudo_records_auth_all"
  ON laudo_records FOR ALL TO authenticated
  USING (true) WITH CHECK (true);
