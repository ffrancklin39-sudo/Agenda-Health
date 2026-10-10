-- ============================================================================
-- 20261010120000_whatsapp_consentimento.sql  (UP)
-- Camada de consentimento (opt-in / opt-out) para WhatsApp — LGPD.
--
-- Garantias desta migration:
--   * Idempotente: pode rodar mais de uma vez sem erro.
--   * Não apaga nem altera dados existentes. Todos os registros atuais
--     ficam opt_in = 'incerto' pelo DEFAULT da coluna (nenhum vira 'sim').
--   * phone_e164 é coluna GERADA: não dispara UPDATE em massa, não mexe em
--     updated_at e não gera eventos de realtime.
--   * opt_out sempre vence: nenhuma regra torna elegível quem tem opt-out
--     ou cujo telefone está na lista de supressão.
--   * Toda mudança de consentimento feita por usuário logado passa pelas
--     funções (RPC) abaixo; escrita direta nas colunas é recusada.
--   * Reversão: supabase/rollback/20261010120000_whatsapp_consentimento_down.sql
--
-- Sem escopo de clínica (tenant): o esquema atual não tem clinic_id.
-- Quando o multi-tenant chegar, whatsapp_supressao e consentimento_eventos
-- precisam ganhar clinic_id junto com o resto das tabelas.
--
-- Sem BEGIN/COMMIT de propósito: a CLI do Supabase já roda cada migration
-- numa transação, e o SQL Editor executa o script inteiro como uma só
-- transação (falhou no meio = nada fica aplicado).
-- ============================================================================

-- ── 1. Tipo do opt-in ─────────────────────────────────────────────────────
DO $$ BEGIN
  CREATE TYPE public.opt_in_status AS ENUM ('sim', 'incerto', 'nao');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- ── 2. Normalização de telefone (E.164) ───────────────────────────────────
-- Regras (Brasil):
--   * JIDs '@lid' e '@g.us' não são telefone → NULL.
--   * Aceita 10/11 dígitos (DDD + número) ou 12/13 com o 55 na frente.
--   * DDD precisa ser um DDD brasileiro existente.
--   * 9 dígitos: precisa começar com 9 (celular).
--   * 8 dígitos começando com 6–9: celular sem o 9º dígito → acrescenta o 9.
--   * 8 dígitos começando com 2–5: fixo → mantém como está (sem 9).
--   * Qualquer outra coisa → NULL (nunca elegível para disparo).
-- Mesma regra em src/phoneUtils.ts (paraE164). Mudou aqui, mude lá.
CREATE OR REPLACE FUNCTION public.normalizar_telefone_e164(p_raw text)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
PARALLEL SAFE
SET search_path = pg_catalog, pg_temp
AS $$
DECLARE
  v_raw    text := btrim(coalesce(p_raw, ''));
  v_suffix text;
  v_digits text;
  v_nat    text;
  v_ddd    text;
  v_num    text;
BEGIN
  IF v_raw = '' THEN RETURN NULL; END IF;

  IF position('@' in v_raw) > 0 THEN
    v_suffix := lower(split_part(v_raw, '@', 2));
    IF v_suffix NOT IN ('c.us', 's.whatsapp.net') THEN RETURN NULL; END IF;
    v_raw := split_part(v_raw, '@', 1);
  END IF;

  v_digits := regexp_replace(v_raw, '\D', '', 'g');

  IF length(v_digits) IN (12, 13) AND left(v_digits, 2) = '55' THEN
    v_nat := substr(v_digits, 3);
  ELSIF length(v_digits) IN (10, 11) THEN
    v_nat := v_digits;
  ELSE
    RETURN NULL;
  END IF;

  v_ddd := left(v_nat, 2);
  v_num := substr(v_nat, 3);

  IF v_ddd NOT IN (
    '11','12','13','14','15','16','17','18','19',
    '21','22','24','27','28',
    '31','32','33','34','35','37','38',
    '41','42','43','44','45','46','47','48','49',
    '51','53','54','55',
    '61','62','63','64','65','66','67','68','69',
    '71','73','74','75','77','79',
    '81','82','83','84','85','86','87','88','89',
    '91','92','93','94','95','96','97','98','99'
  ) THEN
    RETURN NULL;
  END IF;

  IF length(v_num) = 9 THEN
    IF left(v_num, 1) <> '9' THEN RETURN NULL; END IF;
  ELSIF length(v_num) = 8 THEN
    IF left(v_num, 1) IN ('6','7','8','9') THEN
      v_num := '9' || v_num;                 -- celular antigo sem o 9º dígito
    ELSIF left(v_num, 1) NOT IN ('2','3','4','5') THEN
      RETURN NULL;                           -- nem celular nem fixo
    END IF;
  ELSE
    RETURN NULL;
  END IF;

  RETURN '+55' || v_ddd || v_num;
END;
$$;

-- Hash do telefone para a lista de supressão (não guarda o número em claro).
-- Entrada: telefone em qualquer formato. Saída: sha256 hex do E.164, ou NULL.
CREATE OR REPLACE FUNCTION public.telefone_hash(p_raw text)
RETURNS text
LANGUAGE sql
IMMUTABLE
PARALLEL SAFE
SET search_path = pg_catalog, pg_temp
AS $$
  SELECT CASE
    WHEN public.normalizar_telefone_e164(p_raw) IS NULL THEN NULL
    ELSE encode(sha256(convert_to(public.normalizar_telefone_e164(p_raw), 'UTF8')), 'hex')
  END;
$$;

-- ── 3. Colunas novas em patients (leads e pacientes) ──────────────────────
ALTER TABLE public.patients
  ADD COLUMN IF NOT EXISTS opt_in           public.opt_in_status NOT NULL DEFAULT 'incerto',
  ADD COLUMN IF NOT EXISTS opt_in_origem    text,
  ADD COLUMN IF NOT EXISTS opt_in_data      timestamptz,
  ADD COLUMN IF NOT EXISTS opt_in_evidencia text,
  ADD COLUMN IF NOT EXISTS opt_out          boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS opt_out_data     timestamptz;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'patients' AND column_name = 'phone_e164'
  ) THEN
    ALTER TABLE public.patients
      ADD COLUMN phone_e164 text
      GENERATED ALWAYS AS (public.normalizar_telefone_e164(phone)) STORED;
  END IF;
END $$;

COMMENT ON COLUMN public.patients.opt_in IS 'Consentimento para mensagens ativas no WhatsApp: sim | incerto | nao. Padrão incerto.';
COMMENT ON COLUMN public.patients.opt_in_origem IS 'De onde veio o opt-in (ou o canal de entrada, se incerto).';
COMMENT ON COLUMN public.patients.opt_in_evidencia IS 'Referência verificável: formulário, anúncio, texto exibido e data de vigência.';
COMMENT ON COLUMN public.patients.opt_out IS 'Pediu para não receber. Sempre vence o opt_in. Só ADMIN reverte, via reverter_opt_out().';
COMMENT ON COLUMN public.patients.phone_e164 IS 'Telefone normalizado (+55DDNNNNNNNNN), gerado a partir de phone. NULL = inválido, nunca elegível.';

DO $$ BEGIN
  ALTER TABLE public.patients ADD CONSTRAINT chk_opt_in_origem_valida CHECK (
    opt_in_origem IS NULL OR opt_in_origem IN (
      'click_to_whatsapp', 'form_com_consentimento', 'form_sem_consentimento',
      'lead_ad', 'manual', 'feegow', 'whatsapp_legado'
    )
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- opt_in = 'sim' exige origem, evidência e data.
DO $$ BEGIN
  ALTER TABLE public.patients ADD CONSTRAINT chk_opt_in_sim_com_evidencia CHECK (
    opt_in <> 'sim' OR (
      opt_in_origem IS NOT NULL
      AND opt_in_data IS NOT NULL
      AND length(btrim(coalesce(opt_in_evidencia, ''))) >= 10
    )
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

CREATE INDEX IF NOT EXISTS idx_patients_phone_e164 ON public.patients (phone_e164);
CREATE INDEX IF NOT EXISTS idx_patients_elegiveis
  ON public.patients (id) WHERE opt_in = 'sim' AND opt_out = false;

-- ── 4. Lista de supressão (por telefone, não por cadastro) ────────────────
CREATE TABLE IF NOT EXISTS public.whatsapp_supressao (
  phone_hash  text PRIMARY KEY,           -- sha256 do E.164 (sem número em claro)
  criado_em   timestamptz NOT NULL DEFAULT now(),
  criado_por  uuid,                       -- auth.uid() de quem marcou (NULL = sistema)
  origem      text NOT NULL DEFAULT 'manual',
  motivo      text
);
COMMENT ON TABLE public.whatsapp_supressao IS 'Telefones que pediram opt-out. Bloqueia disparo para QUALQUER cadastro com o mesmo número.';

ALTER TABLE public.whatsapp_supressao ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.whatsapp_supressao FROM PUBLIC, anon;
GRANT SELECT ON public.whatsapp_supressao TO authenticated;
DROP POLICY IF EXISTS "supressao_select_logado" ON public.whatsapp_supressao;
CREATE POLICY "supressao_select_logado" ON public.whatsapp_supressao
  FOR SELECT TO authenticated USING (true);
-- Sem políticas de INSERT/UPDATE/DELETE: só as funções SECURITY DEFINER escrevem.

-- ── 5. Trilha de auditoria (somente inserção) ─────────────────────────────
CREATE TABLE IF NOT EXISTS public.consentimento_eventos (
  id              bigserial PRIMARY KEY,
  patient_id      uuid NOT NULL,
  ocorrido_em     timestamptz NOT NULL DEFAULT now(),
  ator            uuid,                    -- auth.uid(); NULL = sistema/integração
  ator_papel      text,                    -- authenticated | service_role | postgres
  acao            text NOT NULL,           -- edicao | massa | entrada_automatica | opt_out | reversao_opt_out | supressao_propagada | sistema
  opt_in_antes    public.opt_in_status,
  opt_in_depois   public.opt_in_status,
  opt_out_antes   boolean,
  opt_out_depois  boolean,
  origem          text,
  evidencia       text,
  motivo          text
);
-- Sem telefone e sem nome aqui (LGPD): o vínculo é só o patient_id.
CREATE INDEX IF NOT EXISTS idx_consentimento_eventos_patient ON public.consentimento_eventos (patient_id, ocorrido_em DESC);

ALTER TABLE public.consentimento_eventos ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.consentimento_eventos FROM PUBLIC, anon;
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public.consentimento_eventos FROM authenticated;
GRANT SELECT ON public.consentimento_eventos TO authenticated;
DROP POLICY IF EXISTS "consent_eventos_select_logado" ON public.consentimento_eventos;
CREATE POLICY "consent_eventos_select_logado" ON public.consentimento_eventos
  FOR SELECT TO authenticated USING (true);

-- ── 6. Funções auxiliares internas ────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.consentimento_eh_admin()
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'ADMIN');
$$;

CREATE OR REPLACE FUNCTION public.consentimento_papel_atual()
RETURNS text
LANGUAGE sql
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT coalesce(
    nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role',
    nullif(current_setting('request.jwt.claim.role', true), ''),
    current_user::text
  );
$$;

-- ── 7. Trigger BEFORE: trava escrita direta + regras automáticas ──────────
CREATE OR REPLACE FUNCTION public.trg_consentimento_before()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_via_rpc  boolean := coalesce(current_setting('app.consentimento_via_rpc', true), '') = 'on';
  v_reverter boolean := coalesce(current_setting('app.reverter_opt_out', true), '') = 'on';
  v_papel    text    := public.consentimento_papel_atual();
  v_mudou    boolean;
  v_hash     text;
BEGIN
  -- (a) Usuário do app não escreve consentimento direto: só via RPC.
  IF TG_OP = 'INSERT' THEN
    v_mudou := NEW.opt_in IS DISTINCT FROM 'incerto'::public.opt_in_status
            OR NEW.opt_out IS TRUE
            OR NEW.opt_in_origem IS NOT NULL OR NEW.opt_in_evidencia IS NOT NULL
            OR NEW.opt_in_data IS NOT NULL OR NEW.opt_out_data IS NOT NULL;
  ELSE
    v_mudou := NEW.opt_in IS DISTINCT FROM OLD.opt_in
            OR NEW.opt_out IS DISTINCT FROM OLD.opt_out
            OR NEW.opt_in_origem IS DISTINCT FROM OLD.opt_in_origem
            OR NEW.opt_in_evidencia IS DISTINCT FROM OLD.opt_in_evidencia
            OR NEW.opt_in_data IS DISTINCT FROM OLD.opt_in_data
            OR NEW.opt_out_data IS DISTINCT FROM OLD.opt_out_data;
  END IF;
  IF v_mudou AND NOT v_via_rpc AND v_papel IN ('authenticated', 'anon') THEN
    RAISE EXCEPTION 'Consentimento só pode ser alterado pelas funções próprias (atualizar_consentimento, marcar_opt_out...).'
      USING ERRCODE = '42501';
  END IF;

  -- (b) opt-out é permanente: só reverter_opt_out() desfaz.
  IF TG_OP = 'UPDATE' AND OLD.opt_out AND NOT NEW.opt_out AND NOT v_reverter THEN
    RAISE EXCEPTION 'Opt-out não pode ser desfeito por edição. Use reverter_opt_out() (somente ADMIN).'
      USING ERRCODE = '42501';
  END IF;

  -- (c) Telefone na lista de supressão → opt-out automático (vale para
  --     cadastros novos e para quem trocou de telefone).
  IF NOT NEW.opt_out AND (TG_OP = 'INSERT' OR NEW.phone IS DISTINCT FROM OLD.phone) THEN
    v_hash := public.telefone_hash(NEW.phone);
    IF v_hash IS NOT NULL AND EXISTS (SELECT 1 FROM public.whatsapp_supressao WHERE phone_hash = v_hash) THEN
      NEW.opt_out := true;
    END IF;
  END IF;

  -- (d) Datas automáticas (nunca confiar em data enviada pelo cliente).
  IF TG_OP = 'INSERT' THEN
    NEW.opt_in_data := CASE WHEN NEW.opt_in <> 'incerto' THEN now() END;
  ELSIF NEW.opt_in IS DISTINCT FROM OLD.opt_in THEN
    NEW.opt_in_data := now();
  ELSE
    NEW.opt_in_data := OLD.opt_in_data;
  END IF;

  IF NEW.opt_out AND (TG_OP = 'INSERT' OR NOT OLD.opt_out) THEN
    NEW.opt_out_data := now();
  ELSIF NEW.opt_out THEN
    NEW.opt_out_data := OLD.opt_out_data;
  ELSE
    NEW.opt_out_data := NULL;
  END IF;

  RETURN NEW;
END;
$$;

-- ── 8. Trigger AFTER: supressão, propagação e auditoria ───────────────────
CREATE OR REPLACE FUNCTION public.trg_consentimento_after()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_acao   text := coalesce(nullif(current_setting('app.consentimento_acao', true), ''), 'sistema');
  v_motivo text := nullif(current_setting('app.consentimento_motivo', true), '');
  v_hash   text;
  v_e164   text;
  v_via    text;
  v_old_in public.opt_in_status;
  v_old_out boolean;
BEGIN
  IF TG_OP = 'UPDATE' THEN
    v_old_in := OLD.opt_in; v_old_out := OLD.opt_out;
  END IF;

  -- Entrou em opt-out: grava o telefone na supressão e bloqueia os
  -- outros cadastros com o mesmo número.
  IF NEW.opt_out AND (TG_OP = 'INSERT' OR NOT OLD.opt_out) THEN
    v_e164 := public.normalizar_telefone_e164(NEW.phone);
    v_hash := public.telefone_hash(NEW.phone);
    IF v_hash IS NOT NULL THEN
      INSERT INTO public.whatsapp_supressao (phone_hash, criado_por, origem, motivo)
      VALUES (v_hash, auth.uid(), CASE WHEN v_acao = 'sistema' THEN 'sistema' ELSE 'manual' END, v_motivo)
      ON CONFLICT (phone_hash) DO NOTHING;

      v_via := coalesce(current_setting('app.consentimento_via_rpc', true), '');
      PERFORM set_config('app.consentimento_via_rpc', 'on', true);
      PERFORM set_config('app.consentimento_acao', 'supressao_propagada', true);
      UPDATE public.patients
         SET opt_out = true
       WHERE id <> NEW.id
         AND NOT opt_out
         AND phone_e164 = v_e164;
      PERFORM set_config('app.consentimento_acao', v_acao, true);
      PERFORM set_config('app.consentimento_via_rpc', v_via, true);
    END IF;
  END IF;

  -- Auditoria: só quando algo de consentimento mudou.
  IF TG_OP = 'INSERT' AND NEW.opt_in = 'incerto' AND NOT NEW.opt_out AND NEW.opt_in_origem IS NULL THEN
    RETURN NULL;
  END IF;
  IF TG_OP = 'UPDATE'
     AND NEW.opt_in IS NOT DISTINCT FROM OLD.opt_in
     AND NEW.opt_out IS NOT DISTINCT FROM OLD.opt_out
     AND NEW.opt_in_origem IS NOT DISTINCT FROM OLD.opt_in_origem
     AND NEW.opt_in_evidencia IS NOT DISTINCT FROM OLD.opt_in_evidencia THEN
    RETURN NULL;
  END IF;

  INSERT INTO public.consentimento_eventos (
    patient_id, ator, ator_papel, acao,
    opt_in_antes, opt_in_depois, opt_out_antes, opt_out_depois,
    origem, evidencia, motivo
  ) VALUES (
    NEW.id, auth.uid(), public.consentimento_papel_atual(), v_acao,
    v_old_in, NEW.opt_in, v_old_out, NEW.opt_out,
    NEW.opt_in_origem, NEW.opt_in_evidencia, v_motivo
  );
  RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_consentimento_before ON public.patients;
CREATE TRIGGER trg_consentimento_before
  BEFORE INSERT OR UPDATE ON public.patients
  FOR EACH ROW EXECUTE FUNCTION public.trg_consentimento_before();

DROP TRIGGER IF EXISTS trg_consentimento_after ON public.patients;
CREATE TRIGGER trg_consentimento_after
  AFTER INSERT OR UPDATE ON public.patients
  FOR EACH ROW EXECUTE FUNCTION public.trg_consentimento_after();

-- ── 9. Regra única de elegibilidade ───────────────────────────────────────
-- TODO envio ativo (n8n, Chatwoot, Edge Function, app) deve consultar isto
-- imediatamente antes de enviar. Espelho no front: src/lib/consentimento.ts.
CREATE OR REPLACE FUNCTION public.pode_receber_disparo(p_patient_id uuid)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
  SELECT coalesce((
    SELECT p.opt_in = 'sim'
       AND p.opt_out = false
       AND p.phone_e164 IS NOT NULL
       AND NOT EXISTS (
         SELECT 1 FROM public.whatsapp_supressao s
         WHERE s.phone_hash = public.telefone_hash(p.phone_e164)
       )
    FROM public.patients p
    WHERE p.id = p_patient_id
  ), false);
$$;

-- ── 10. RPCs ──────────────────────────────────────────────────────────────

-- Edição individual (qualquer usuário logado). Mudar 'nao' → 'sim' aqui é a
-- "revisão humana" exigida.
CREATE OR REPLACE FUNCTION public.atualizar_consentimento(
  p_patient_id uuid,
  p_opt_in     public.opt_in_status,
  p_origem     text,
  p_evidencia  text
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_rows int;
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'Não autenticado' USING ERRCODE = '42501';
  END IF;
  IF p_opt_in IS NULL THEN
    RAISE EXCEPTION 'opt_in obrigatório' USING ERRCODE = '22023';
  END IF;
  IF p_opt_in = 'sim' AND nullif(btrim(coalesce(p_origem, '')), '') IS NULL THEN
    RAISE EXCEPTION 'Para marcar opt-in = sim, informe a origem do consentimento.' USING ERRCODE = '22023';
  END IF;
  IF nullif(btrim(coalesce(p_origem, '')), '') IS NOT NULL AND btrim(p_origem) NOT IN (
    'click_to_whatsapp', 'form_com_consentimento', 'form_sem_consentimento',
    'lead_ad', 'manual', 'feegow', 'whatsapp_legado'
  ) THEN
    RAISE EXCEPTION 'Origem inválida' USING ERRCODE = '22023';
  END IF;
  IF p_opt_in = 'sim' AND length(btrim(coalesce(p_evidencia, ''))) < 10 THEN
    RAISE EXCEPTION 'Para marcar opt-in = sim, descreva a evidência (mín. 10 caracteres).' USING ERRCODE = '22023';
  END IF;

  PERFORM set_config('app.consentimento_via_rpc', 'on', true);
  PERFORM set_config('app.consentimento_acao', 'edicao', true);

  UPDATE public.patients
     SET opt_in           = p_opt_in,
         opt_in_origem    = nullif(btrim(coalesce(p_origem, '')), ''),
         opt_in_evidencia = nullif(btrim(coalesce(p_evidencia, '')), '')
   WHERE id = p_patient_id;
  GET DIAGNOSTICS v_rows = ROW_COUNT;
  IF v_rows = 0 THEN
    RAISE EXCEPTION 'Cadastro não encontrado' USING ERRCODE = 'P0002';
  END IF;
END;
$$;

-- Opt-out manual (qualquer usuário logado, ou integração com service_role).
CREATE OR REPLACE FUNCTION public.marcar_opt_out(p_patient_id uuid, p_motivo text)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_rows int;
  v_e164 text;
BEGIN
  IF auth.uid() IS NULL AND public.consentimento_papel_atual() <> 'service_role' THEN
    RAISE EXCEPTION 'Não autenticado' USING ERRCODE = '42501';
  END IF;

  -- Trava por NÚMERO antes de tocar em qualquer linha: dois opt-outs
  -- simultâneos em cadastros duplicados não entram em deadlock.
  SELECT public.normalizar_telefone_e164(phone) INTO v_e164 FROM public.patients WHERE id = p_patient_id;
  IF v_e164 IS NOT NULL THEN
    PERFORM pg_advisory_xact_lock(hashtextextended('optout:' || v_e164, 0));
  END IF;

  PERFORM set_config('app.consentimento_via_rpc', 'on', true);
  PERFORM set_config('app.consentimento_acao', 'opt_out', true);
  PERFORM set_config('app.consentimento_motivo', coalesce(left(btrim(p_motivo), 500), ''), true);

  UPDATE public.patients SET opt_out = true WHERE id = p_patient_id;
  GET DIAGNOSTICS v_rows = ROW_COUNT;
  IF v_rows = 0 THEN
    RAISE EXCEPTION 'Cadastro não encontrado' USING ERRCODE = 'P0002';
  END IF;
END;
$$;

-- Reverter opt-out: SOMENTE ADMIN, com motivo. Libera o telefone inteiro
-- (todos os cadastros com o mesmo número). opt_in volta para 'incerto'.
CREATE OR REPLACE FUNCTION public.reverter_opt_out(p_patient_id uuid, p_motivo text)
RETURNS int
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_hash text;
  v_e164 text;
  v_rows int;
BEGIN
  IF NOT public.consentimento_eh_admin() THEN
    RAISE EXCEPTION 'Somente ADMIN pode reverter opt-out' USING ERRCODE = '42501';
  END IF;
  IF length(btrim(coalesce(p_motivo, ''))) < 10 THEN
    RAISE EXCEPTION 'Informe o motivo da reversão (mín. 10 caracteres).' USING ERRCODE = '22023';
  END IF;

  SELECT public.telefone_hash(phone), public.normalizar_telefone_e164(phone)
    INTO v_hash, v_e164
    FROM public.patients WHERE id = p_patient_id;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Cadastro não encontrado' USING ERRCODE = 'P0002';
  END IF;
  IF v_e164 IS NOT NULL THEN
    PERFORM pg_advisory_xact_lock(hashtextextended('optout:' || v_e164, 0));
  END IF;

  PERFORM set_config('app.consentimento_via_rpc', 'on', true);
  PERFORM set_config('app.reverter_opt_out', 'on', true);
  PERFORM set_config('app.consentimento_acao', 'reversao_opt_out', true);
  PERFORM set_config('app.consentimento_motivo', left(btrim(p_motivo), 500), true);

  IF v_hash IS NOT NULL THEN
    DELETE FROM public.whatsapp_supressao WHERE phone_hash = v_hash;
  END IF;

  UPDATE public.patients
     SET opt_out = false, opt_in = 'incerto', opt_in_origem = NULL, opt_in_evidencia = NULL
   WHERE opt_out
     AND (id = p_patient_id
          OR (v_e164 IS NOT NULL AND phone_e164 = v_e164));
  GET DIAGNOSTICS v_rows = ROW_COUNT;

  PERFORM set_config('app.reverter_opt_out', 'off', true);
  RETURN v_rows;
END;
$$;

-- Marcação em massa: SOMENTE ADMIN, seleção explícita, evidência obrigatória.
-- Nunca sobrescreve opt-out nem recusa explícita ('nao').
CREATE OR REPLACE FUNCTION public.marcar_opt_in_em_massa(
  p_ids       uuid[],
  p_origem    text,
  p_evidencia text
)
RETURNS TABLE (marcados int, ja_sim int, pulados_opt_out int, pulados_nao int, nao_encontrados int)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_ids uuid[];
BEGIN
  IF NOT public.consentimento_eh_admin() THEN
    RAISE EXCEPTION 'Somente ADMIN pode marcar opt-in em massa' USING ERRCODE = '42501';
  END IF;
  SELECT coalesce(array_agg(DISTINCT x), '{}') INTO v_ids FROM unnest(p_ids) AS x WHERE x IS NOT NULL;
  IF cardinality(v_ids) = 0 THEN
    RAISE EXCEPTION 'Nenhum cadastro selecionado' USING ERRCODE = '22023';
  END IF;
  IF cardinality(v_ids) > 500 THEN
    RAISE EXCEPTION 'Máximo de 500 cadastros por vez' USING ERRCODE = '22023';
  END IF;
  IF p_origem IS NULL OR p_origem NOT IN ('form_com_consentimento', 'manual', 'feegow') THEN
    RAISE EXCEPTION 'Origem inválida para marcação em massa' USING ERRCODE = '22023';
  END IF;
  IF length(btrim(coalesce(p_evidencia, ''))) < 20 THEN
    RAISE EXCEPTION 'Descreva a evidência do consentimento (mín. 20 caracteres).' USING ERRCODE = '22023';
  END IF;

  PERFORM set_config('app.consentimento_via_rpc', 'on', true);
  PERFORM set_config('app.consentimento_acao', 'massa', true);

  RETURN QUERY
  WITH alvo AS (
    SELECT p.id, p.opt_in, p.opt_out FROM public.patients p WHERE p.id = ANY (v_ids)
  ),
  upd AS (
    UPDATE public.patients p
       SET opt_in = 'sim', opt_in_origem = p_origem, opt_in_evidencia = btrim(p_evidencia)
     WHERE p.id = ANY (v_ids)
       AND NOT p.opt_out             -- reavaliado após lock: opt-out concorrente vence
       AND p.opt_in = 'incerto'
    RETURNING p.id
  )
  SELECT (SELECT count(*) FROM upd)::int,
         (SELECT count(*) FROM alvo WHERE opt_in = 'sim' AND NOT opt_out)::int,
         (SELECT count(*) FROM alvo WHERE opt_out)::int,
         (SELECT count(*) FROM alvo WHERE opt_in = 'nao' AND NOT opt_out)::int,
         (cardinality(v_ids) - (SELECT count(*) FROM alvo))::int;
END;
$$;

-- Gancho de entrada automática (n8n, webhooks). Só service_role.
--   p_origem:        click_to_whatsapp | form_com_consentimento | form_sem_consentimento | lead_ad | whatsapp_legado | manual
--   p_consentimento: 'sim' | 'nao' | NULL (ausente/ambíguo = incerto)
-- Regras: opt-out nunca muda; 'nao' existente nunca vira 'sim' sozinho;
-- 'sim' existente não é rebaixado por formulário sem campo.
CREATE OR REPLACE FUNCTION public.registrar_consentimento_entrada(
  p_patient_id    uuid,
  p_origem        text,
  p_consentimento text,
  p_evidencia     text
)
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_atual   public.opt_in_status;
  v_out     boolean;
  v_novo    public.opt_in_status;
  v_cons    text := lower(btrim(coalesce(p_consentimento, '')));
  v_evid    text := nullif(btrim(coalesce(p_evidencia, '')), '');
BEGIN
  IF public.consentimento_papel_atual() <> 'service_role' AND NOT public.consentimento_eh_admin() THEN
    RAISE EXCEPTION 'Somente integrações (service_role) podem registrar entrada' USING ERRCODE = '42501';
  END IF;
  IF p_origem IS NULL OR p_origem NOT IN (
    'click_to_whatsapp', 'form_com_consentimento', 'form_sem_consentimento',
    'lead_ad', 'whatsapp_legado', 'manual'
  ) THEN
    RAISE EXCEPTION 'Origem inválida' USING ERRCODE = '22023';
  END IF;

  SELECT opt_in, opt_out INTO v_atual, v_out
    FROM public.patients WHERE id = p_patient_id FOR UPDATE;
  IF NOT FOUND THEN
    RETURN 'nao_encontrado';
  END IF;
  IF v_out THEN
    RETURN 'opt_out_mantido';
  END IF;

  v_novo := CASE
    WHEN p_origem = 'click_to_whatsapp' THEN 'sim'
    WHEN p_origem IN ('form_com_consentimento', 'lead_ad') AND v_cons = 'sim' THEN 'sim'
    WHEN p_origem IN ('form_com_consentimento', 'lead_ad') AND v_cons = 'nao' THEN 'nao'
    ELSE 'incerto'
  END::public.opt_in_status;

  -- Sem evidência não existe 'sim'.
  IF v_novo = 'sim' AND (v_evid IS NULL OR length(v_evid) < 10) THEN
    v_novo := 'incerto';
  END IF;

  PERFORM set_config('app.consentimento_via_rpc', 'on', true);
  PERFORM set_config('app.consentimento_acao', 'entrada_automatica', true);

  IF v_atual = 'nao' AND v_novo <> 'nao' THEN
    RETURN 'nao_mantido_revisao_humana';
  END IF;
  IF v_atual = 'sim' AND v_novo <> 'nao' THEN
    RETURN 'ja_sim';
  END IF;

  IF v_novo = 'incerto' THEN
    -- Registra só o canal de entrada, sem mexer no status.
    UPDATE public.patients
       SET opt_in_origem = coalesce(opt_in_origem, p_origem),
           opt_in_evidencia = coalesce(opt_in_evidencia, v_evid)
     WHERE id = p_patient_id AND opt_in = 'incerto';
    RETURN 'incerto';
  END IF;

  UPDATE public.patients
     SET opt_in = v_novo, opt_in_origem = p_origem, opt_in_evidencia = v_evid
   WHERE id = p_patient_id;
  RETURN v_novo::text;
END;
$$;

-- ── 11. Permissões de execução ────────────────────────────────────────────
REVOKE ALL ON FUNCTION public.normalizar_telefone_e164(text)                       FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.telefone_hash(text)                                  FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.consentimento_eh_admin()                             FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.consentimento_papel_atual()                          FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.trg_consentimento_before()                           FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.trg_consentimento_after()                            FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.pode_receber_disparo(uuid)                           FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.atualizar_consentimento(uuid, public.opt_in_status, text, text) FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.marcar_opt_out(uuid, text)                           FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.reverter_opt_out(uuid, text)                         FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.marcar_opt_in_em_massa(uuid[], text, text)           FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.registrar_consentimento_entrada(uuid, text, text, text) FROM PUBLIC, anon, authenticated;

GRANT EXECUTE ON FUNCTION public.normalizar_telefone_e164(text)                    TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.telefone_hash(text)                               TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.consentimento_eh_admin()                          TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.consentimento_papel_atual()                       TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.pode_receber_disparo(uuid)                        TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.atualizar_consentimento(uuid, public.opt_in_status, text, text) TO authenticated;
GRANT EXECUTE ON FUNCTION public.marcar_opt_out(uuid, text)                        TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.reverter_opt_out(uuid, text)                      TO authenticated;
GRANT EXECUTE ON FUNCTION public.marcar_opt_in_em_massa(uuid[], text, text)        TO authenticated;
GRANT EXECUTE ON FUNCTION public.registrar_consentimento_entrada(uuid, text, text, text) TO service_role;

-- ── 12. Item de menu "WhatsApp / Atendimento" nas permissões por papel ────
DO $$ BEGIN
  IF to_regclass('public.role_permissions') IS NOT NULL THEN
    INSERT INTO public.role_permissions (role, module, enabled) VALUES
      ('ADMIN',        'whatsapp', true),
      ('RECEPTIONIST', 'whatsapp', true),
      ('DOCTOR',       'whatsapp', false)
    ON CONFLICT (role, module) DO NOTHING;
  END IF;
END $$;

