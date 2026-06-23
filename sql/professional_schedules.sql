-- ============================================================
-- Horários flexíveis de atendimento por profissional — SintesIA
-- Permite múltiplos intervalos por dia da semana (ex: 09-12 e 14-19,
-- cobrindo intervalo de almoço) e dias diferentes por profissional.
-- Rodar no Supabase SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS professional_schedules (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  professional_id uuid NOT NULL REFERENCES professionals(id) ON DELETE CASCADE,
  day_of_week     smallint NOT NULL CHECK (day_of_week BETWEEN 0 AND 6), -- 0=domingo ... 6=sábado (igual Date.getDay() do JS)
  start_time      time NOT NULL,
  end_time        time NOT NULL,
  created_at      timestamptz DEFAULT now(),
  CONSTRAINT professional_schedules_valid_range CHECK (end_time > start_time)
);

CREATE INDEX IF NOT EXISTS idx_professional_schedules_prof_day
  ON professional_schedules(professional_id, day_of_week);

-- RLS
ALTER TABLE professional_schedules ENABLE ROW LEVEL SECURITY;

CREATE POLICY "professional_schedules_auth_all"
  ON professional_schedules FOR ALL TO authenticated
  USING (true) WITH CHECK (true);
