-- profiles_and_roles.sql
-- Controle de acesso por papel (ADMIN / RECEPTIONIST / DOCTOR)
-- Execute no Supabase SQL Editor
--
-- Cria a tabela `profiles` que faltava (App.tsx já tentava ler dela, mas
-- ela nunca existiu — por isso userRole sempre caía no default 'ADMIN').
-- Decisão tomada (2026-06-25): por enquanto, ADMIN/RECEPTIONIST/DOCTOR têm
-- acesso de visão igual a registros de pacientes/agenda (sem filtro "só
-- meus pacientes" ainda — isso fica para uma 2ª etapa, é decisão de
-- negócio pendente). O que muda agora é: quais ABAS cada papel acessa.

-- 1. Tabela ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS profiles (
  id         UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email      TEXT,
  role       TEXT NOT NULL DEFAULT 'RECEPTIONIST' CHECK (role IN ('ADMIN','DOCTOR','RECEPTIONIST')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE profiles IS 'Papel de cada usuário logado (ADMIN/DOCTOR/RECEPTIONIST) — controla o que cada um vê no app';

-- 2. Backfill dos usuários que já existem ----------------------------------
-- Os logins atuais já têm acesso total ao sistema hoje — entram como ADMIN
-- pra não causar regressão. Próximos usuários (via trigger abaixo) entram
-- como RECEPTIONIST por padrão (menor privilégio) e um ADMIN promove depois.
INSERT INTO profiles (id, email, role)
SELECT id, email, 'ADMIN'
FROM auth.users
WHERE id NOT IN (SELECT id FROM profiles)
ON CONFLICT (id) DO NOTHING;

-- 3. Trigger — todo novo usuário criado no Supabase Auth ganha um profile --
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role)
  VALUES (NEW.id, NEW.email, 'RECEPTIONIST')
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 4. Função auxiliar para checar admin sem recursão de RLS -----------------
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'ADMIN');
$$;

-- 5. RLS ---------------------------------------------------------------------
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "profiles_select" ON profiles;
CREATE POLICY "profiles_select"
  ON profiles FOR SELECT TO authenticated
  USING (id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS "profiles_update_admin_only" ON profiles;
CREATE POLICY "profiles_update_admin_only"
  ON profiles FOR UPDATE TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Sem policy de INSERT/DELETE para authenticated: só o trigger (SECURITY
-- DEFINER) cria profiles. Ninguém apaga o próprio registro de papel pelo app.

-- 6. Verificação --------------------------------------------------------------
SELECT id, email, role, created_at FROM profiles ORDER BY created_at;
