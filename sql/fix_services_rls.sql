-- fix_services_rls.sql
-- Garante que usuários autenticados podem criar, editar e excluir serviços.
-- Execute no Supabase SQL Editor.

-- Habilita RLS se ainda não estiver ativo
ALTER TABLE services ENABLE ROW LEVEL SECURITY;

-- Remove políticas antigas para recriar limpas
DROP POLICY IF EXISTS "services_select"  ON services;
DROP POLICY IF EXISTS "services_insert"  ON services;
DROP POLICY IF EXISTS "services_update"  ON services;
DROP POLICY IF EXISTS "services_delete"  ON services;
DROP POLICY IF EXISTS "services_all"     ON services;
DROP POLICY IF EXISTS "services_auth_all" ON services;

-- Política única: qualquer usuário autenticado pode fazer tudo
CREATE POLICY "services_auth_all"
  ON services FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- Garante a coluna category (pode estar ausente nos dados Feegow)
ALTER TABLE services ADD COLUMN IF NOT EXISTS category TEXT;

-- Garante a coluna description
ALTER TABLE services ADD COLUMN IF NOT EXISTS description TEXT;

-- Garante a coluna duration (alguns registros Feegow usam duration_minutes)
ALTER TABLE services ADD COLUMN IF NOT EXISTS duration INTEGER;

-- Sincroniza duration ← duration_minutes nos registros que só têm duration_minutes
UPDATE services
  SET duration = duration_minutes
  WHERE duration IS NULL AND duration_minutes IS NOT NULL;

-- Define 60 min como padrão para quem não tem nenhum dos dois
UPDATE services
  SET duration = 60
  WHERE duration IS NULL;

SELECT
  COUNT(*) FILTER (WHERE duration IS NULL) AS sem_duration,
  COUNT(*) FILTER (WHERE category IS NULL) AS sem_category,
  COUNT(*) AS total
FROM services;
