-- ============================================================
-- SintesIA — Setup de Produção
-- Execute no Supabase SQL Editor (Dashboard → SQL Editor)
-- Seguro para rodar mesmo se as tabelas já existirem
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. TABELA APPOINTMENTS (cria se não existir)
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS appointments (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id        UUID REFERENCES patients(id) ON DELETE CASCADE,
  professional_id   UUID REFERENCES professionals(id) ON DELETE SET NULL,
  service_id        UUID REFERENCES services(id) ON DELETE SET NULL,
  date_time         TIMESTAMPTZ NOT NULL,
  duration_minutes  INTEGER DEFAULT 60,
  status            TEXT DEFAULT 'scheduled'
                    CHECK (status IN ('scheduled','confirmed','completed','cancelled','no_show')),
  notes             TEXT,
  created_at        TIMESTAMPTZ DEFAULT NOW(),
  updated_at        TIMESTAMPTZ DEFAULT NOW()
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_apt_patient  ON appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_apt_prof     ON appointments(professional_id);
CREATE INDEX IF NOT EXISTS idx_apt_date     ON appointments(date_time);
CREATE INDEX IF NOT EXISTS idx_apt_status   ON appointments(status);

-- ────────────────────────────────────────────────────────────
-- 2. TABELA DE PERFIS (roles dos usuários)
-- Cada usuário do Supabase Auth terá um perfil com seu papel
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS profiles (
  id          UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  role        TEXT NOT NULL DEFAULT 'RECEPTIONIST'
              CHECK (role IN ('ADMIN','DOCTOR','RECEPTIONIST')),
  name        TEXT,
  professional_id UUID REFERENCES professionals(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ────────────────────────────────────────────────────────────
-- 3. TRIGGER: atualiza updated_at automaticamente
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_appointments_updated_at ON appointments;
CREATE TRIGGER trg_appointments_updated_at
  BEFORE UPDATE ON appointments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ────────────────────────────────────────────────────────────
-- 4. RLS — Habilitar segurança por linha em todas as tabelas
-- ────────────────────────────────────────────────────────────
ALTER TABLE patients      ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments  ENABLE ROW LEVEL SECURITY;
ALTER TABLE professionals ENABLE ROW LEVEL SECURITY;
ALTER TABLE services      ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles      ENABLE ROW LEVEL SECURITY;

-- ────────────────────────────────────────────────────────────
-- 5. FUNÇÃO AUXILIAR: retorna o role do usuário logado
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION get_my_role()
RETURNS TEXT AS $$
  SELECT role FROM profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

CREATE OR REPLACE FUNCTION get_my_professional_id()
RETURNS UUID AS $$
  SELECT professional_id FROM profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- ────────────────────────────────────────────────────────────
-- 6. POLÍTICAS RLS — Patients
-- ADMIN: tudo | DOCTOR: só seus pacientes | RECEPTIONIST: lê tudo, edita básico
-- ────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "patients_select" ON patients;
DROP POLICY IF EXISTS "patients_insert" ON patients;
DROP POLICY IF EXISTS "patients_update" ON patients;
DROP POLICY IF EXISTS "patients_delete" ON patients;

-- Leitura: ADMIN e RECEPTIONIST veem todos; DOCTOR vê só pacientes com appointment seu
CREATE POLICY "patients_select" ON patients FOR SELECT
  USING (
    get_my_role() IN ('ADMIN','RECEPTIONIST')
    OR (
      get_my_role() = 'DOCTOR'
      AND id IN (
        SELECT patient_id FROM appointments
        WHERE professional_id = get_my_professional_id()
      )
    )
  );

-- Inserção: ADMIN e RECEPTIONIST
CREATE POLICY "patients_insert" ON patients FOR INSERT
  WITH CHECK (get_my_role() IN ('ADMIN','RECEPTIONIST'));

-- Atualização: ADMIN sempre; RECEPTIONIST campos básicos; DOCTOR só seus pacientes
CREATE POLICY "patients_update" ON patients FOR UPDATE
  USING (
    get_my_role() = 'ADMIN'
    OR get_my_role() = 'RECEPTIONIST'
    OR (
      get_my_role() = 'DOCTOR'
      AND id IN (
        SELECT patient_id FROM appointments
        WHERE professional_id = get_my_professional_id()
      )
    )
  );

-- Exclusão: só ADMIN
CREATE POLICY "patients_delete" ON patients FOR DELETE
  USING (get_my_role() = 'ADMIN');

-- ────────────────────────────────────────────────────────────
-- 7. POLÍTICAS RLS — Appointments
-- ────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "appointments_select" ON appointments;
DROP POLICY IF EXISTS "appointments_insert" ON appointments;
DROP POLICY IF EXISTS "appointments_update" ON appointments;
DROP POLICY IF EXISTS "appointments_delete" ON appointments;

-- ADMIN/RECEPTIONIST: veem todos | DOCTOR: só os seus
CREATE POLICY "appointments_select" ON appointments FOR SELECT
  USING (
    get_my_role() IN ('ADMIN','RECEPTIONIST')
    OR (get_my_role() = 'DOCTOR' AND professional_id = get_my_professional_id())
  );

CREATE POLICY "appointments_insert" ON appointments FOR INSERT
  WITH CHECK (get_my_role() IN ('ADMIN','RECEPTIONIST','DOCTOR'));

CREATE POLICY "appointments_update" ON appointments FOR UPDATE
  USING (
    get_my_role() IN ('ADMIN','RECEPTIONIST')
    OR (get_my_role() = 'DOCTOR' AND professional_id = get_my_professional_id())
  );

CREATE POLICY "appointments_delete" ON appointments FOR DELETE
  USING (get_my_role() IN ('ADMIN','RECEPTIONIST'));

-- ────────────────────────────────────────────────────────────
-- 8. POLÍTICAS RLS — Professionals e Services (leitura livre, escrita ADMIN)
-- ────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "professionals_select" ON professionals;
DROP POLICY IF EXISTS "professionals_write"  ON professionals;
DROP POLICY IF EXISTS "services_select"      ON services;
DROP POLICY IF EXISTS "services_write"       ON services;

CREATE POLICY "professionals_select" ON professionals FOR SELECT USING (true);
CREATE POLICY "professionals_write"  ON professionals FOR ALL
  USING (get_my_role() = 'ADMIN') WITH CHECK (get_my_role() = 'ADMIN');

CREATE POLICY "services_select" ON services FOR SELECT USING (true);
CREATE POLICY "services_write"  ON services FOR ALL
  USING (get_my_role() = 'ADMIN') WITH CHECK (get_my_role() = 'ADMIN');

-- ────────────────────────────────────────────────────────────
-- 9. POLÍTICAS RLS — Profiles
-- ────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "profiles_select" ON profiles;
DROP POLICY IF EXISTS "profiles_update" ON profiles;

CREATE POLICY "profiles_select" ON profiles FOR SELECT USING (true);
CREATE POLICY "profiles_update" ON profiles FOR UPDATE
  USING (id = auth.uid() OR get_my_role() = 'ADMIN');

-- ────────────────────────────────────────────────────────────
-- 10. CRIAR PERFIS para usuários já existentes
-- Ajuste os emails e roles conforme a equipe real
-- ────────────────────────────────────────────────────────────
-- Execute este bloco depois de confirmar os IDs dos usuários:
-- SELECT id, email FROM auth.users;
--
-- Exemplo:
-- INSERT INTO profiles (id, role, name) VALUES
--   ('uuid-do-admin',       'ADMIN',        'Francklin'),
--   ('uuid-da-candia',      'RECEPTIONIST', 'Candia'),
--   ('uuid-do-dr-fulano',   'DOCTOR',       'Dr. Fulano')
-- ON CONFLICT (id) DO UPDATE SET role = EXCLUDED.role, name = EXCLUDED.name;

-- ────────────────────────────────────────────────────────────
-- VERIFICAÇÃO FINAL — rode para confirmar que está tudo certo
-- ────────────────────────────────────────────────────────────
SELECT
  schemaname, tablename,
  rowsecurity AS rls_ativo
FROM pg_tables
WHERE tablename IN ('patients','appointments','professionals','services','profiles')
ORDER BY tablename;
