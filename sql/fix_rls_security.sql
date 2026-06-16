-- ============================================================================
-- FIX DE SEGURANÇA (CRÍTICO) — Políticas RLS permissivas demais
-- Execute no Supabase SQL Editor: https://supabase.com/dashboard → SQL Editor
--
-- PROBLEMA: as políticas atuais usam USING (true), ou seja, QUALQUER pessoa
-- com a anon key (que fica embutida no JavaScript do site e foi commitada no
-- GitHub) pode LER, ALTERAR e APAGAR todos os pacientes, agendamentos e
-- pagamentos — SEM ESTAR LOGADA. Isso é uma violação grave de LGPD.
--
-- SOLUÇÃO: este script remove as políticas "Anyone can..." e exige usuário
-- autenticado (login no app) para qualquer operação. O app continua
-- funcionando exatamente igual, pois todos os usuários fazem login.
--
-- PASSO FUTURO (recomendado): políticas por papel (ADMIN/RECEPTIONIST)
-- usando a tabela profiles — ver seção comentada no final.
-- ============================================================================

-- 1. PATIENTS ----------------------------------------------------------------
DROP POLICY IF EXISTS "Anyone can read patients"   ON patients;
DROP POLICY IF EXISTS "Anyone can create patients" ON patients;
DROP POLICY IF EXISTS "Anyone can update patients" ON patients;
DROP POLICY IF EXISTS "Anyone can delete patients" ON patients;

CREATE POLICY "Authenticated read patients"
  ON patients FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated insert patients"
  ON patients FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Authenticated update patients"
  ON patients FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Authenticated delete patients"
  ON patients FOR DELETE TO authenticated USING (true);

-- 2. APPOINTMENTS ------------------------------------------------------------
DROP POLICY IF EXISTS "Anyone can read appointments"   ON appointments;
DROP POLICY IF EXISTS "Anyone can create appointments" ON appointments;
DROP POLICY IF EXISTS "Anyone can update appointments" ON appointments;
DROP POLICY IF EXISTS "Anyone can delete appointments" ON appointments;

CREATE POLICY "Authenticated read appointments"
  ON appointments FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated insert appointments"
  ON appointments FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Authenticated update appointments"
  ON appointments FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Authenticated delete appointments"
  ON appointments FOR DELETE TO authenticated USING (true);

-- 3. PAYMENTS ----------------------------------------------------------------
DROP POLICY IF EXISTS "Anyone can read payments"   ON payments;
DROP POLICY IF EXISTS "Anyone can create payments" ON payments;
DROP POLICY IF EXISTS "Anyone can update payments" ON payments;
DROP POLICY IF EXISTS "Anyone can delete payments" ON payments;

-- (payments_and_triggers.sql já criou políticas autenticadas; estas linhas
-- garantem que existam mesmo se aquele script não tiver sido executado)
DO $$ BEGIN
  CREATE POLICY "Authenticated read payments v2"
    ON payments FOR SELECT TO authenticated USING (true);
EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN
  CREATE POLICY "Authenticated manage payments v2"
    ON payments FOR ALL TO authenticated USING (true) WITH CHECK (true);
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- 4. PATIENT_HISTORY ---------------------------------------------------------
DROP POLICY IF EXISTS "Anyone can read history"   ON patient_history;
DROP POLICY IF EXISTS "Anyone can create history" ON patient_history;

CREATE POLICY "Authenticated read history"
  ON patient_history FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated insert history"
  ON patient_history FOR INSERT TO authenticated WITH CHECK (true);

-- 5. VERIFICAÇÃO — todas as tabelas sensíveis devem ter RLS habilitado -------
ALTER TABLE patients         ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments     ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments         ENABLE ROW LEVEL SECURITY;
ALTER TABLE patient_history  ENABLE ROW LEVEL SECURITY;

-- Confira o resultado: nenhuma política deve aparecer com roles = {public}
SELECT tablename, policyname, roles, cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

-- ============================================================================
-- FASE 2 (futuro) — Exemplo de política por papel, usando a tabela profiles:
--
-- CREATE POLICY "Only admins delete patients" ON patients FOR DELETE
--   TO authenticated
--   USING (EXISTS (
--     SELECT 1 FROM profiles
--     WHERE profiles.id = auth.uid() AND profiles.role = 'ADMIN'
--   ));
-- ============================================================================
