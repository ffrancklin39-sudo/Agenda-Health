-- ============================================================================
-- 20261016002126_seguranca_perfis_instagram_down.sql  (DOWN / reversão)
-- ATENÇÃO: volta ao estado ANTERIOR, que era inseguro (visitantes liam
-- profissionais e perfis; usuário podia se promover a ADMIN). Use só em
-- emergência, se alguma tela parar de funcionar, e corrija em seguida.
-- As colunas meta_* NÃO são removidas (apagariam vínculos de leads).
-- ============================================================================

SET LOCAL lock_timeout = '5s';

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='profiles' AND policyname='profiles_select') THEN
    ALTER POLICY "profiles_select" ON public.profiles TO public USING (true);
  END IF;
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='profiles' AND policyname='profiles_update') THEN
    ALTER POLICY "profiles_update" ON public.profiles TO public
      USING ((id = auth.uid()) OR (get_my_role() = 'ADMIN'::text));
  END IF;
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='profiles' AND policyname='profiles_authenticated_all') THEN
    ALTER POLICY "profiles_authenticated_all" ON public.profiles TO authenticated USING (true) WITH CHECK (true);
  END IF;
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='professionals' AND policyname='professionals_select') THEN
    ALTER POLICY "professionals_select" ON public.professionals TO public;
  END IF;
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='professionals' AND policyname='professionals_write') THEN
    ALTER POLICY "professionals_write" ON public.professionals TO public;
  END IF;
  IF EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='services' AND policyname='services_write') THEN
    ALTER POLICY "services_write" ON public.services TO public;
  END IF;
END $$;

DO $$
DECLARE f regprocedure;
BEGIN
  FOR f IN
    SELECT p.oid::regprocedure FROM pg_proc p
    WHERE p.pronamespace = 'public'::regnamespace
      AND p.proname IN ('is_admin','get_my_role','get_my_professional_id','save_bill_categories')
  LOOP
    EXECUTE format('GRANT EXECUTE ON FUNCTION %s TO PUBLIC, anon', f);
  END LOOP;
  -- search_path fixo é inofensivo; não é desfeito.
END $$;
