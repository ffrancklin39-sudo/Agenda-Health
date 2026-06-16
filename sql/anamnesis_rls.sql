-- ─────────────────────────────────────────────────────────────────────────────
-- RLS para as tabelas do módulo de Anamnese
-- Execute este arquivo no Supabase SQL Editor se os templates/registros
-- não estiverem salvando ou aparecendo (erro 42501 = permissão negada)
-- ─────────────────────────────────────────────────────────────────────────────

-- Habilitar RLS nas tabelas
ALTER TABLE anamnesis_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE anamnesis_records   ENABLE ROW LEVEL SECURITY;

-- Política permissiva: usuários autenticados têm acesso total
-- (igual ao padrão das outras tabelas do SintesIA)

CREATE POLICY "anamnesis_templates_auth_all"
  ON anamnesis_templates
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "anamnesis_records_auth_all"
  ON anamnesis_records
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);
