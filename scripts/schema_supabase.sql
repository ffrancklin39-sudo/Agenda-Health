-- ============================================================
-- SintesIA — Schema Supabase (tabelas faltantes)
-- Execute no Supabase SQL Editor antes de importar os CSVs
-- ============================================================

-- Habilita extensão UUID (já vem ativa no Supabase, mas por segurança)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ------------------------------------------------------------
-- professionals
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS professionals (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  specialty   TEXT,
  color       TEXT DEFAULT 'blue',
  email       TEXT,
  phone       TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------
-- services
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS services (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name              TEXT NOT NULL,
  price             DECIMAL(10,2) DEFAULT 0,
  duration_minutes  INTEGER DEFAULT 0,
  category          TEXT DEFAULT 'Consultas',
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------
-- patients  (atualiza a existente se já houver)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS patients (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT NOT NULL,
  email            TEXT,
  phone            TEXT,
  cpf              TEXT,
  status           TEXT DEFAULT 'lead'
                   CHECK (status IN ('lead','negotiation','waiting','scheduled','confirmed','discarded')),
  appointment_date TIMESTAMPTZ,
  professional_id  UUID REFERENCES professionals(id) ON DELETE SET NULL,
  service_id       UUID REFERENCES services(id) ON DELETE SET NULL,
  price            DECIMAL(10,2),
  reminder_date    TIMESTAMPTZ,
  reminder_note    TEXT,
  reminder_executed BOOLEAN DEFAULT FALSE,
  observation      TEXT,
  source           TEXT,
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  updated_at       TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------
-- appointments
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS appointments (
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

-- ------------------------------------------------------------
-- payments
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS payments (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id            UUID REFERENCES patients(id) ON DELETE CASCADE,
  appointment_id        UUID REFERENCES appointments(id) ON DELETE SET NULL,
  amount                DECIMAL(10,2) NOT NULL,
  status                TEXT DEFAULT 'pending'
                        CHECK (status IN ('pending','paid','refunded')),
  payment_method        TEXT CHECK (payment_method IN ('pix','credit_card','cash','other')),
  payment_date          TIMESTAMPTZ,
  professional_id       UUID REFERENCES professionals(id) ON DELETE SET NULL,
  commission_percentage DECIMAL(5,2),
  created_at            TIMESTAMPTZ DEFAULT NOW(),
  updated_at            TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------
-- patient_history
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS patient_history (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id  UUID REFERENCES patients(id) ON DELETE CASCADE,
  date        TIMESTAMPTZ DEFAULT NOW(),
  event_type  TEXT CHECK (event_type IN ('consultation','procedure','payment','follow_up','other')),
  notes       TEXT,
  created_by  TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------
-- Índices úteis para performance
-- ------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_appointments_patient    ON appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_date       ON appointments(date_time);
CREATE INDEX IF NOT EXISTS idx_appointments_status     ON appointments(status);
CREATE INDEX IF NOT EXISTS idx_payments_patient        ON payments(patient_id);
CREATE INDEX IF NOT EXISTS idx_patient_history_patient ON patient_history(patient_id);
CREATE INDEX IF NOT EXISTS idx_patients_status         ON patients(status);
CREATE INDEX IF NOT EXISTS idx_patients_cpf            ON patients(cpf);

-- ------------------------------------------------------------
-- Trigger: updated_at automático
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_patients_updated_at') THEN
    CREATE TRIGGER trg_patients_updated_at
      BEFORE UPDATE ON patients FOR EACH ROW EXECUTE FUNCTION update_updated_at();
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_appointments_updated_at') THEN
    CREATE TRIGGER trg_appointments_updated_at
      BEFORE UPDATE ON appointments FOR EACH ROW EXECUTE FUNCTION update_updated_at();
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_payments_updated_at') THEN
    CREATE TRIGGER trg_payments_updated_at
      BEFORE UPDATE ON payments FOR EACH ROW EXECUTE FUNCTION update_updated_at();
  END IF;
END $$;

-- ------------------------------------------------------------
-- RLS (Row Level Security) — habilita por tabela
-- Descomente e adapte após configurar auth no Supabase
-- ------------------------------------------------------------
-- ALTER TABLE patients       ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE appointments   ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE payments       ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE patient_history ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Authenticated users" ON patients FOR ALL USING (auth.role() = 'authenticated');
-- (repita para cada tabela)

