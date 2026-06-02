-- ============================================================================
-- MIGRATION V7 — Bloqueios de Agenda
-- Execute no Supabase SQL Editor
-- ============================================================================

CREATE TABLE IF NOT EXISTS blocked_slots (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professional_id UUID NOT NULL,
  start_datetime  TIMESTAMP NOT NULL,
  end_datetime    TIMESTAMP NOT NULL,
  reason          TEXT,
  created_at      TIMESTAMP DEFAULT NOW()
);

ALTER TABLE blocked_slots ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Authenticated users manage blocked_slots" ON blocked_slots;
CREATE POLICY "Authenticated users manage blocked_slots"
ON blocked_slots FOR ALL TO authenticated
USING (true) WITH CHECK (true);
