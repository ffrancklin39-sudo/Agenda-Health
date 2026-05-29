-- ============================================================
-- fix_schema.sql
-- Dropa e recria as tabelas com o schema correto (UUID)
-- Execute no Supabase SQL Editor ANTES de rodar o import
-- ============================================================

-- Remove tabelas na ordem correta (respeitando foreign keys)
DROP TABLE IF EXISTS appointments      CASCADE;
DROP TABLE IF EXISTS payments          CASCADE;
DROP TABLE IF EXISTS patient_history   CASCADE;
DROP TABLE IF EXISTS patients          CASCADE;
DROP TABLE IF EXISTS services          CASCADE;
DROP TABLE IF EXISTS professionals     CASCADE;

-- Habilita extensão UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- professionals
CREATE TABLE professionals (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  specialty   TEXT,
  color       TEXT DEFAULT 'blue',
  email       TEXT,
  phone       TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- services
CREATE TABLE services (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name              TEXT NOT NULL,
  price             DECIMAL(10,2) DEFAULT 0,
  duration_minutes  INTEGER DEFAULT 0,
  category          TEXT DEFAULT 'Consultas',
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

-- patients
CREATE TABLE patients (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name              TEXT NOT NULL,
  email             TEXT,
  phone             TEXT,
  cpf               TEXT,
  status            TEXT DEFAULT 'lead'
                    CHECK (status IN ('lead','negotiation','waiting','scheduled','confirmed','discarded')),
  appointment_date  TIMESTAMPTZ,
  professional_id   UUID REFERENCES professionals(id) ON DELETE SET NULL,
  service_id        UUID REFERENCES services(id) ON DELETE SET NULL,
  price             DECIMAL(10,2),
  reminder_date     TIMESTAMPTZ,
  reminder_note     TEXT,
  reminder_executed BOOLEAN DEFAULT FALSE,
  observation       TEXT,
  source            TEXT,
  created_at        TIMESTAMPTZ DEFAULT NOW(),
  updated_at        TIMESTAMPTZ DEFAULT NOW()
);

-- appointments
CREATE TABLE appointments (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id        UUID REFERENCES patients(id) ON DELETE CASCADE,
  professional_id   UUID REFERENCES professionals(id) ON DELETE SET NULL,
  service_id        UUID REFERENCES services(id) ON DELETE SET NULL,
  date_time         TIMESTAMPTZ NOT NULL,
  duration_minutes  INTEGER DEFAULT 0,
  status            TEXT DEFAULT 'scheduled'
                    CHECK (status IN ('scheduled','confirmed','completed','cancelled')),
  notes             TEXT,
  price             DECIMAL(10,2) DEFAULT 0,
  created_at        TIMESTAMPTZ DEFAULT NOW(),
  updated_at        TIMESTAMPTZ DEFAULT NOW()
);

-- payments
CREATE TABLE payments (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id            UUID REFERENCES patients(id) ON DELETE CASCADE,
  appointment_id        UUID REFERENCES appointments(id) ON DELETE SET NULL,
  amount                DECIMAL(10,2) NOT NULL,
  status                TEXT DEFAULT 'pending'
                        CHECK (status IN ('pending','paid','refunded')),
  payment_method        TEXT,
  payment_date          TIMESTAMPTZ,
  professional_id       UUID REFERENCES professionals(id) ON DELETE SET NULL,
  commission_percentage DECIMAL(5,2),
  created_at            TIMESTAMPTZ DEFAULT NOW(),
  updated_at            TIMESTAMPTZ DEFAULT NOW()
);

-- patient_history
CREATE TABLE patient_history (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id  UUID REFERENCES patients(id) ON DELETE CASCADE,
  date        TIMESTAMPTZ DEFAULT NOW(),
  event_type  TEXT,
  notes       TEXT,
  created_by  TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX idx_appointments_patient ON appointments(patient_id);
CREATE INDEX idx_appointments_date    ON appointments(date_time);
CREATE INDEX idx_appointments_status  ON appointments(status);
CREATE INDEX idx_patients_status      ON patients(status);
CREATE INDEX idx_patients_cpf         ON patients(cpf);

-- Trigger updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_patients_updated_at
  BEFORE UPDATE ON patients FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_appointments_updated_at
  BEFORE UPDATE ON appointments FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ⚠️ RLS desativado para importação — ative depois com o comando abaixo
-- ALTER TABLE patients     ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
