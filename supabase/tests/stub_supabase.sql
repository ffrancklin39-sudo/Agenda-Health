-- ============================================================================
-- stub_supabase.sql — SOMENTE para teste local (Postgres puro).
-- Imita o mínimo do Supabase que as migrations usam: papéis anon /
-- authenticated / service_role, auth.uid(), privilégios padrão (que dão
-- acesso a anon em tabelas novas, como no Supabase) e as tabelas
-- patients / profiles / role_permissions com a RLS de hoje.
-- Nenhum dado real: os registros de teste ficam em consentimento_test.sql.
-- ============================================================================

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'anon') THEN CREATE ROLE anon NOLOGIN; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'authenticated') THEN CREATE ROLE authenticated NOLOGIN; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'service_role') THEN CREATE ROLE service_role NOLOGIN BYPASSRLS; END IF;
END $$;

CREATE SCHEMA IF NOT EXISTS auth;
CREATE OR REPLACE FUNCTION auth.uid() RETURNS uuid LANGUAGE sql STABLE AS $$
  SELECT nullif(coalesce(
    nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub',
    current_setting('request.jwt.claim.sub', true)
  ), '')::uuid;
$$;
GRANT USAGE ON SCHEMA auth, public TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION auth.uid() TO anon, authenticated, service_role;

-- Privilégios padrão do Supabase: tudo em public para os três papéis.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES    TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon, authenticated, service_role;

CREATE TABLE IF NOT EXISTS public.profiles (
  id    uuid PRIMARY KEY,
  email text,
  role  text NOT NULL DEFAULT 'RECEPTIONIST'
);

CREATE TABLE IF NOT EXISTS public.role_permissions (
  id      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  role    text NOT NULL,
  module  text NOT NULL,
  enabled boolean NOT NULL DEFAULT true,
  UNIQUE (role, module)
);

CREATE TABLE IF NOT EXISTS public.patients (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text NOT NULL,
  phone      text,
  email      text,
  status     text DEFAULT 'lead',
  is_lead    boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION public.stub_touch_updated_at() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at := now(); RETURN NEW; END; $$;
DROP TRIGGER IF EXISTS trg_stub_updated_at ON public.patients;
CREATE TRIGGER trg_stub_updated_at BEFORE UPDATE ON public.patients
  FOR EACH ROW EXECUTE FUNCTION public.stub_touch_updated_at();

-- RLS de hoje em produção: qualquer usuário logado faz tudo.
ALTER TABLE public.patients ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Authenticated all patients" ON public.patients;
CREATE POLICY "Authenticated all patients" ON public.patients
  FOR ALL TO authenticated USING (true) WITH CHECK (true);
