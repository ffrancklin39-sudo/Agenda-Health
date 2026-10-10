-- ============================================================================
-- 20261010120000_whatsapp_consentimento_down.sql  (DOWN / reversão)
-- Desfaz supabase/migrations/20261010120000_whatsapp_consentimento.sql.
--
-- Fica FORA de supabase/migrations de propósito: a CLI do Supabase não deve
-- aplicá-lo automaticamente. Rode à mão no SQL Editor, só se precisar reverter.
--
-- Antes de remover, ARQUIVA o que foi coletado (consentimentos, opt-outs,
-- auditoria e supressão) em public.consentimento_arquivo, que tem RLS ligada,
-- nenhuma política e nenhum acesso para anon/authenticated (só o dono/
-- service_role lê). Nenhum dado pré-existente de pacientes é tocado.
-- Idempotente: rodar duas vezes não dá erro nem duplica o arquivo.
-- Sem BEGIN/COMMIT: rode o arquivo inteiro de uma vez (SQL Editor) — é uma
-- transação só; se algo falhar, nada é desfeito pela metade.
-- ============================================================================

-- ── 1. Tabela de arquivo (protegida) ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.consentimento_arquivo (
  id            bigserial PRIMARY KEY,
  tipo          text NOT NULL,          -- patient | evento | supressao
  dados         jsonb NOT NULL,
  arquivado_em  timestamptz NOT NULL DEFAULT now()
);
COMMENT ON TABLE public.consentimento_arquivo IS 'Cópia do consentimento WhatsApp feita pela reversão da migration 20261010120000. Sem acesso pelo app.';
ALTER TABLE public.consentimento_arquivo ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.consentimento_arquivo FROM PUBLIC, anon, authenticated;
REVOKE ALL ON SEQUENCE public.consentimento_arquivo_id_seq FROM PUBLIC, anon, authenticated;

-- ── 2. Arquivar (só se as estruturas ainda existirem) ─────────────────────
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'patients' AND column_name = 'opt_in'
  ) THEN
    INSERT INTO public.consentimento_arquivo (tipo, dados)
    SELECT 'patient', jsonb_build_object(
             'patient_id',       p.id,
             'opt_in',           p.opt_in::text,
             'opt_in_origem',    p.opt_in_origem,
             'opt_in_data',      p.opt_in_data,
             'opt_in_evidencia', p.opt_in_evidencia,
             'opt_out',          p.opt_out,
             'opt_out_data',     p.opt_out_data)
      FROM public.patients p
     WHERE p.opt_in::text <> 'incerto' OR p.opt_out OR p.opt_in_origem IS NOT NULL;
  END IF;

  IF to_regclass('public.consentimento_eventos') IS NOT NULL THEN
    INSERT INTO public.consentimento_arquivo (tipo, dados)
    SELECT 'evento', to_jsonb(e) FROM public.consentimento_eventos e;
  END IF;

  IF to_regclass('public.whatsapp_supressao') IS NOT NULL THEN
    INSERT INTO public.consentimento_arquivo (tipo, dados)
    SELECT 'supressao', to_jsonb(s) FROM public.whatsapp_supressao s;
  END IF;
END $$;

-- ── 3. Triggers e funções ─────────────────────────────────────────────────
DROP TRIGGER IF EXISTS trg_consentimento_before ON public.patients;
DROP TRIGGER IF EXISTS trg_consentimento_after  ON public.patients;

DROP FUNCTION IF EXISTS public.registrar_consentimento_entrada(uuid, text, text, text);
DROP FUNCTION IF EXISTS public.marcar_opt_in_em_massa(uuid[], text, text);
DROP FUNCTION IF EXISTS public.reverter_opt_out(uuid, text);
DROP FUNCTION IF EXISTS public.marcar_opt_out(uuid, text);
DO $$ BEGIN
  IF to_regtype('public.opt_in_status') IS NOT NULL THEN
    EXECUTE 'DROP FUNCTION IF EXISTS public.atualizar_consentimento(uuid, public.opt_in_status, text, text)';
  END IF;
END $$;
DROP FUNCTION IF EXISTS public.pode_receber_disparo(uuid);
DROP FUNCTION IF EXISTS public.trg_consentimento_after();
DROP FUNCTION IF EXISTS public.trg_consentimento_before();
DROP FUNCTION IF EXISTS public.consentimento_papel_atual();
DROP FUNCTION IF EXISTS public.consentimento_eh_admin();

-- ── 4. Tabelas novas ──────────────────────────────────────────────────────
DROP TABLE IF EXISTS public.consentimento_eventos;
DROP TABLE IF EXISTS public.whatsapp_supressao;

-- ── 5. Colunas, índices e restrições em patients ──────────────────────────
DROP INDEX IF EXISTS public.idx_patients_elegiveis;
DROP INDEX IF EXISTS public.idx_patients_phone_e164;
ALTER TABLE public.patients DROP CONSTRAINT IF EXISTS chk_opt_in_sim_com_evidencia;
ALTER TABLE public.patients DROP CONSTRAINT IF EXISTS chk_opt_in_origem_valida;
ALTER TABLE public.patients
  DROP COLUMN IF EXISTS phone_e164,
  DROP COLUMN IF EXISTS opt_out_data,
  DROP COLUMN IF EXISTS opt_out,
  DROP COLUMN IF EXISTS opt_in_evidencia,
  DROP COLUMN IF EXISTS opt_in_data,
  DROP COLUMN IF EXISTS opt_in_origem,
  DROP COLUMN IF EXISTS opt_in;

DROP FUNCTION IF EXISTS public.telefone_hash(text);
DROP FUNCTION IF EXISTS public.normalizar_telefone_e164(text);
DROP TYPE IF EXISTS public.opt_in_status;

-- ── 6. Item de menu ───────────────────────────────────────────────────────
DO $$ BEGIN
  IF to_regclass('public.role_permissions') IS NOT NULL THEN
    DELETE FROM public.role_permissions WHERE module = 'whatsapp';
  END IF;
END $$;

