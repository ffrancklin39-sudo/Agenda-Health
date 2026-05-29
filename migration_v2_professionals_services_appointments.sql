-- ============================================================
-- SintesIA — Migration v2
-- Tabelas: professionals, services, appointments
-- Executar no Supabase Dashboard > SQL Editor
-- ============================================================


-- ============================================================
-- 1. PROFESSIONALS
-- ============================================================
CREATE TABLE IF NOT EXISTS professionals (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  specialty   TEXT,
  color       TEXT DEFAULT 'blue',   -- blue | purple | emerald | teal | rose | amber | indigo
  email       TEXT,
  phone       TEXT,
  active      BOOLEAN DEFAULT TRUE,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Seed: profissionais que estavam hardcoded no App.tsx
INSERT INTO professionals (name, specialty, color) VALUES
  ('Dr. Ricardo Mendonça', 'Ortopedia',    'blue'),
  ('Dra. Ana Beatriz',     'Dermatologia', 'purple'),
  ('Dr. Lucas Silva',      'Fisioterapia', 'emerald')
ON CONFLICT DO NOTHING;


-- ============================================================
-- 2. SERVICES (catálogo de serviços)
-- ============================================================
CREATE TABLE IF NOT EXISTS services (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT NOT NULL,
  price            DECIMAL(10,2) DEFAULT 0,
  duration_minutes INTEGER DEFAULT 60,
  category         TEXT DEFAULT 'Consultas',
  description      TEXT,
  active           BOOLEAN DEFAULT TRUE,
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  updated_at       TIMESTAMPTZ DEFAULT NOW()
);

-- Seed: serviços que estavam hardcoded no App.tsx
INSERT INTO services (name, price, duration_minutes, category) VALUES
  ('Consulta Médica',         450,  60, 'Consultas'),
  ('Aplicação de Botox',     1800,  45, 'Procedimentos'),
  ('Criolipólise',           1200,  90, 'Estética'),
  ('Sessão de Fisioterapia',  250,  60, 'Reabilitação')
ON CONFLICT DO NOTHING;


-- ============================================================
-- 3. APPOINTMENTS (tabela dedicada de agendamentos)
--
-- NOTA: patient_id é BIGINT para corresponder ao tipo real
-- da coluna patients.id (serial/bigint gerado pelo Supabase).
-- professional_id e service_id continuam UUID pois as tabelas
-- professionals e services foram criadas com UUID PRIMARY KEY.
-- ============================================================
CREATE TABLE IF NOT EXISTS appointments (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id       BIGINT NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  professional_id  UUID REFERENCES professionals(id) ON DELETE SET NULL,
  service_id       UUID REFERENCES services(id)      ON DELETE SET NULL,
  date_time        TIMESTAMPTZ NOT NULL,
  duration_minutes INTEGER DEFAULT 60,
  status           TEXT DEFAULT 'scheduled',
  -- scheduled | confirmed | completed | cancelled | no_show
  notes            TEXT,
  price            DECIMAL(10,2),
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  updated_at       TIMESTAMPTZ DEFAULT NOW()
);


-- ============================================================
-- 4. MIGRAÇÃO: agendamentos existentes em patients → appointments
--
-- ATENÇÃO: os campos professional_id e service_id nos patients
-- armazenam valores antigos como 'dr1', 'dr2', 's1', etc.
-- (IDs hardcoded, não UUIDs válidos). Por isso são migrados como NULL.
-- Após a migração, reatribua os profissionais/serviços via UI.
-- ============================================================
INSERT INTO appointments (patient_id, date_time, duration_minutes, status)
SELECT
  id,   -- BIGINT direto, sem cast
  appointment_date::TIMESTAMPTZ,
  COALESCE(duration_minutes, 60),
  CASE
    WHEN status IN ('scheduled', 'confirmed', 'completed', 'cancelled', 'no_show')
    THEN status
    ELSE 'scheduled'
  END
FROM patients
WHERE appointment_date IS NOT NULL
  AND appointment_date::TEXT NOT IN ('', 'Não agendado')
  AND appointment_date::TEXT ~ '^\d{4}-\d{2}-\d{2}'
ON CONFLICT DO NOTHING;


-- ============================================================
-- 5. RLS — Row Level Security
-- Usuários autenticados têm acesso total.
-- (Ajuste as políticas conforme necessidade no futuro)
-- ============================================================
ALTER TABLE professionals ENABLE ROW LEVEL SECURITY;
ALTER TABLE services      ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments  ENABLE ROW LEVEL SECURITY;

-- Dropar políticas antigas caso existam (idempotente)
DROP POLICY IF EXISTS "allow_all_professionals" ON professionals;
DROP POLICY IF EXISTS "allow_all_services"      ON services;
DROP POLICY IF EXISTS "allow_all_appointments"  ON appointments;

CREATE POLICY "allow_all_professionals" ON professionals
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "allow_all_services" ON services
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "allow_all_appointments" ON appointments
  FOR ALL TO authenticated USING (true) WITH CHECK (true);


-- ============================================================
-- 6. ÍNDICES para performance nas queries da Agenda
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_appointments_date_time
  ON appointments(date_time);

CREATE INDEX IF NOT EXISTS idx_appointments_patient_id
  ON appointments(patient_id);

CREATE INDEX IF NOT EXISTS idx_appointments_professional_id
  ON appointments(professional_id);
