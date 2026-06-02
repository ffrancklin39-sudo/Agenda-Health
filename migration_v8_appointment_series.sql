-- ============================================================================
-- MIGRATION V8 — Séries de agendamentos (pacotes/recorrência)
-- Execute no Supabase SQL Editor
-- ============================================================================

-- Tabela de séries
CREATE TABLE IF NOT EXISTS appointment_series (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id        UUID,
  professional_id   UUID,
  service_id        UUID,
  total_sessions    INTEGER NOT NULL DEFAULT 1,
  notes             TEXT,
  created_at        TIMESTAMP DEFAULT NOW()
);

ALTER TABLE appointment_series ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Authenticated users manage series" ON appointment_series;
CREATE POLICY "Authenticated users manage series"
ON appointment_series FOR ALL TO authenticated
USING (true) WITH CHECK (true);

-- Adicionar referência de série nos agendamentos
ALTER TABLE appointments ADD COLUMN IF NOT EXISTS series_id UUID REFERENCES appointment_series(id) ON DELETE SET NULL;
ALTER TABLE appointments ADD COLUMN IF NOT EXISTS session_number INTEGER;
