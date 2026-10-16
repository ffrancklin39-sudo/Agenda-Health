-- ============================================================================
-- 20261016002126_seguranca_perfis_instagram.sql  (UP)
--
-- 1. Instagram Lead Ads: colunas que o webhook usa e que nunca foram criadas
--    em produção (o upsert do webhook falhava).
-- 2. profiles: (a) visitantes sem login liam e-mail e papel de todos;
--    (b) qualquer usuário logado podia mudar o PRÓPRIO papel para ADMIN.
--    (c) a regra profiles_authenticated_all dava poder total a qualquer logado.
--    Agora: cada um lê só o próprio perfil (ADMIN lê todos) e só ADMIN altera.
-- 3. professionals / services: regras valiam para visitantes sem login
--    (professionals expunha CPF/telefone/e-mail). Agora só usuários logados.
-- 4. Funções antigas: search_path fixo e sem execução por visitantes.
--
-- Sem DROP/DELETE (o painel do Supabase trata como destrutivo).
-- Não altera nenhum dado existente.
-- Reversão: supabase/rollback/20261016002126_seguranca_perfis_instagram_down.sql
-- ============================================================================

SET LOCAL lock_timeout = '5s';

-- ── 1. Instagram Lead Ads ─────────────────────────────────────────────────
ALTER TABLE public.patients
  ADD COLUMN IF NOT EXISTS meta_leadgen_id text,
  ADD COLUMN IF NOT EXISTS meta_ad_id      text,
  ADD COLUMN IF NOT EXISTS meta_form_id    text;

-- Índice único COMPLETO (não parcial): o upsert do webhook usa
-- ON CONFLICT (meta_leadgen_id), que não reconhece índice parcial.
-- NULLs continuam permitidos em quantidade (cadastros que não vieram da Meta).
CREATE UNIQUE INDEX IF NOT EXISTS uq_patients_meta_leadgen_id
  ON public.patients (meta_leadgen_id);

COMMENT ON COLUMN public.patients.meta_leadgen_id IS 'ID do lead no Meta Lead Ads — evita duplicar o mesmo lead em reenvios do webhook';

-- ── 2 e 3. Regras de acesso (ALTER POLICY: não remove nada) ───────────────
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='profiles' AND policyname='profiles_select') THEN
    ALTER POLICY "profiles_select" ON public.profiles
      TO authenticated
      USING (id = auth.uid() OR public.is_admin());
  END IF;

  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='profiles' AND policyname='profiles_update') THEN
    ALTER POLICY "profiles_update" ON public.profiles
      TO authenticated
      USING (public.is_admin())
      WITH CHECK (public.is_admin());
  END IF;

  -- Esta regra dava a QUALQUER usuário logado poder total sobre perfis
  -- (inclusive mudar o papel de qualquer um). Passa a valer só para ADMIN.
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='profiles' AND policyname='profiles_authenticated_all') THEN
    ALTER POLICY "profiles_authenticated_all" ON public.profiles
      TO authenticated
      USING (public.is_admin())
      WITH CHECK (public.is_admin());
  END IF;

  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='professionals' AND policyname='professionals_select') THEN
    ALTER POLICY "professionals_select" ON public.professionals TO authenticated;
  END IF;

  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='professionals' AND policyname='professionals_write') THEN
    ALTER POLICY "professionals_write" ON public.professionals TO authenticated;
  END IF;

  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='services' AND policyname='services_write') THEN
    ALTER POLICY "services_write" ON public.services TO authenticated;
  END IF;
END $$;

-- ── 4. Funções antigas ────────────────────────────────────────────────────
DO $$
DECLARE
  f regprocedure;
BEGIN
  FOR f IN
    SELECT p.oid::regprocedure FROM pg_proc p
    WHERE p.pronamespace = 'public'::regnamespace
      AND p.proname IN ('update_updated_at','get_my_role','get_my_professional_id','update_updated_at_column',
                        'save_bill_categories','set_role_permissions_updated_at','set_updated_at',
                        'calculate_procedure_profit','fn_auto_calculate_payment','fn_create_commission_on_insert',
                        'fn_create_commission_entry','fn_generate_recurring_bills')
  LOOP
    EXECUTE format('ALTER FUNCTION %s SET search_path = public, extensions, pg_temp', f);
  END LOOP;

  FOR f IN
    SELECT p.oid::regprocedure FROM pg_proc p
    WHERE p.pronamespace = 'public'::regnamespace
      AND p.proname IN ('is_admin','get_my_role','get_my_professional_id','save_bill_categories')
  LOOP
    EXECUTE format('REVOKE EXECUTE ON FUNCTION %s FROM PUBLIC, anon', f);
    EXECUTE format('GRANT EXECUTE ON FUNCTION %s TO authenticated, service_role', f);
  END LOOP;
END $$;
