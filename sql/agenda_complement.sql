-- agenda_complement.sql
-- Tabelas e colunas necessárias para a Agenda funcionar 100%:
--   - appointment_series  (pacotes recorrentes)
--   - blocked_slots       (bloqueio de horários por profissional)
--   - colunas em appointments: duration_minutes, series_id, session_number
--
-- Execute no Supabase SQL Editor (Project → SQL Editor → New query).
-- Seguro para re-executar: todos os comandos usam IF NOT EXISTS / IF EXISTS.

-- ─── 1. Colunas em appointments ─────────────────────────────────────────────

ALTER TABLE appointments
  ADD COLUMN IF NOT EXISTS duration_minutes  INTEGER NOT NULL DEFAULT 60,
  ADD COLUMN IF NOT EXISTS series_id         UUID,
  ADD COLUMN IF NOT EXISTS session_number    INTEGER;

COMMENT ON COLUMN appointments.duration_minutes IS 'Duração do procedimento em minutos (padrão 60)';
COMMENT ON COLUMN appointments.series_id      IS 'FK para appointment_series — agrupa sessões recorrentes de um mesmo pacote (ex: 10x fisioterapia)';
COMMENT ON COLUMN appointments.session_number IS 'Número da sessão dentro da série (1, 2, 3...)';

-- ─── 2. Tabela appointment_series ────────────────────────────────────────────
-- Agrupa múltiplos agendamentos de um mesmo pacote/tratamento recorrente.

CREATE TABLE IF NOT EXISTS appointment_series (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id       UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  professional_id  UUID REFERENCES professionals(id) ON DELETE SET NULL,
  service_id       UUID REFERENCES services(id) ON DELETE SET NULL,
  total_sessions   INTEGER NOT NULL DEFAULT 1,
  notes            TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE appointment_series IS 'Agrupa sessões recorrentes de um mesmo pacote/tratamento (ex: 10 sessões de fisioterapia). Cada sessão individual fica em appointments com series_id apontando para cá.';

-- FK de appointments → appointment_series (adicionada após criação da tabela)
ALTER TABLE appointments
  ADD CONSTRAINT IF NOT EXISTS fk_appointments_series
  FOREIGN KEY (series_id) REFERENCES appointment_series(id) ON DELETE SET NULL;

-- Índices
CREATE INDEX IF NOT EXISTS idx_appointment_series_patient ON appointment_series(patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_series        ON appointments(series_id);
CREATE INDEX IF NOT EXISTS idx_appointments_datetime      ON appointments(date_time);

-- Trigger updated_at (reutiliza a função set_updated_at() já existente em contracts.sql)
DROP TRIGGER IF EXISTS trg_appointment_series_updated_at ON appointment_series;
CREATE TRIGGER trg_appointment_series_updated_at
  BEFORE UPDATE ON appointment_series
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- ─── 3. Tabela blocked_slots ─────────────────────────────────────────────────
-- Bloqueia horários de um profissional (férias, almoço, feriado, etc.)

CREATE TABLE IF NOT EXISTS blocked_slots (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professional_id  UUID NOT NULL REFERENCES professionals(id) ON DELETE CASCADE,
  start_datetime   TIMESTAMPTZ NOT NULL,
  end_datetime     TIMESTAMPTZ NOT NULL,
  reason           TEXT,         -- ex: "Férias", "Almoço", "Feriado"
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT chk_blocked_slots_range CHECK (end_datetime > start_datetime)
);

COMMENT ON TABLE blocked_slots IS 'Bloqueios de agenda por profissional — impede criar agendamentos no período bloqueado. Pode ser um bloco único (ex: férias) ou períodos curtos (ex: almoço recorrente — mas para almoço use professional_schedules).';

-- Índices
CREATE INDEX IF NOT EXISTS idx_blocked_slots_prof     ON blocked_slots(professional_id);
CREATE INDEX IF NOT EXISTS idx_blocked_slots_datetime ON blocked_slots(start_datetime, end_datetime);

-- ─── 4. RLS ──────────────────────────────────────────────────────────────────

ALTER TABLE appointment_series ENABLE ROW LEVEL SECURITY;
ALTER TABLE blocked_slots      ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "appointment_series_auth_all" ON appointment_series;
CREATE POLICY "appointment_series_auth_all"
  ON appointment_series FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "blocked_slots_auth_all" ON blocked_slots;
CREATE POLICY "blocked_slots_auth_all"
  ON blocked_slots FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ─── 5. Verificação ──────────────────────────────────────────────────────────

SELECT
  table_name,
  (SELECT string_agg(column_name, ', ' ORDER BY ordinal_position)
   FROM information_schema.columns c
   WHERE c.table_schema = 'public' AND c.table_name = t.table_name) AS columns
FROM information_schema.tables t
WHERE table_schema = 'public'
  AND table_name IN ('appointments', 'appointment_series', 'blocked_slots', 'professional_schedules')
ORDER BY table_name;
