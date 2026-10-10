-- ============================================================================
-- consentimento_test.sql — testes da migration 20261010120000.
-- Dados 100% fictícios (nomes "Teste", números da faixa 9 0000-xxxx).
-- Roda após a migration UP. Qualquer falha aborta com ERRO (ON_ERROR_STOP).
-- ============================================================================
\set ON_ERROR_STOP on

CREATE OR REPLACE FUNCTION pg_temp.assert(cond boolean, msg text) RETURNS void LANGUAGE plpgsql AS $$
BEGIN IF cond IS NOT TRUE THEN RAISE EXCEPTION 'FALHOU: %', msg; END IF; END; $$;

-- Usuários fictícios
INSERT INTO public.profiles (id, email, role) VALUES
  ('00000000-0000-0000-0000-00000000000a', 'admin@teste.invalid', 'ADMIN'),
  ('00000000-0000-0000-0000-00000000000b', 'recepcao@teste.invalid', 'RECEPTIONIST')
ON CONFLICT (id) DO NOTHING;

-- ── 1. Normalização E.164 ────────────────────────────────────────────────
SELECT pg_temp.assert(public.normalizar_telefone_e164('(61) 99000-0001') = '+5561990000001', 'celular 11 dígitos');
SELECT pg_temp.assert(public.normalizar_telefone_e164('61 9000-0002')     = '+5561990000002', 'celular sem 9º dígito ganha o 9');
SELECT pg_temp.assert(public.normalizar_telefone_e164('+55 61 3000-0003')  = '+556130000003',  'fixo NÃO ganha 9');
SELECT pg_temp.assert(public.normalizar_telefone_e164('556190000004@c.us') = '+5561990000004', 'JID @c.us');
SELECT pg_temp.assert(public.normalizar_telefone_e164('20809116553293@lid') IS NULL,           '@lid não é telefone');
SELECT pg_temp.assert(public.normalizar_telefone_e164('(20) 99000-0005') IS NULL,               'DDD inexistente');
SELECT pg_temp.assert(public.normalizar_telefone_e164('(61) 89000-0006') IS NULL,               '9 dígitos sem começar com 9');
SELECT pg_temp.assert(public.normalizar_telefone_e164('(61) 1000-0007') IS NULL,                '8 dígitos começando com 1');
SELECT pg_temp.assert(public.normalizar_telefone_e164('12345') IS NULL,                         'curto demais');
SELECT pg_temp.assert(public.normalizar_telefone_e164(NULL) IS NULL,                            'nulo');
SELECT pg_temp.assert(public.normalizar_telefone_e164('(55) 99000-0008') = '+5555990000008',    'DDD 55 (RS) nacional');

-- ── 2. Backfill: cadastros antigos ficam incerto e não elegíveis ─────────
SELECT pg_temp.assert((SELECT count(*) FROM public.patients WHERE name LIKE 'Antigo%') = 3, 'fixture antiga existe');
SELECT pg_temp.assert(NOT EXISTS (SELECT 1 FROM public.patients WHERE name LIKE 'Antigo%' AND opt_in <> 'incerto'), 'backfill = incerto');
SELECT pg_temp.assert(NOT EXISTS (SELECT 1 FROM public.patients WHERE name LIKE 'Antigo%' AND public.pode_receber_disparo(id)), 'nenhum antigo elegível');

-- ── 3. Usuário logado NÃO escreve consentimento direto ───────────────────
SET ROLE authenticated;
SELECT set_config('request.jwt.claims', '{"role":"authenticated","sub":"00000000-0000-0000-0000-00000000000b"}', false);
INSERT INTO public.patients (id, name, phone, is_lead) VALUES
  ('10000000-0000-0000-0000-000000000001', 'Teste Lead A', '(61) 99000-0101', true),
  ('10000000-0000-0000-0000-000000000002', 'Teste Lead B (mesmo número de A, formato antigo)', '61 9000-0101', true),
  ('10000000-0000-0000-0000-000000000003', 'Teste Lead C', '(61) 99000-0103', true),
  ('10000000-0000-0000-0000-000000000004', 'Teste Lead D sem telefone', NULL, true),
  ('10000000-0000-0000-0000-000000000005', 'Teste Lead E', '(61) 99000-0105', true);
DO $$ BEGIN
  UPDATE public.patients SET opt_in = 'sim' WHERE id = '10000000-0000-0000-0000-000000000001';
  RAISE EXCEPTION 'FALHOU: update direto deveria ser recusado';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;
DO $$ BEGIN
  INSERT INTO public.patients (name, phone, opt_in, opt_in_origem, opt_in_evidencia)
  VALUES ('Teste injeção', '(61) 99000-0199', 'sim', 'manual', 'evidencia falsa aqui');
  RAISE EXCEPTION 'FALHOU: insert com opt_in deveria ser recusado';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;
-- Edição comum (nome) continua funcionando
UPDATE public.patients SET name = 'Teste Lead A editado' WHERE id = '10000000-0000-0000-0000-000000000001';

-- ── 4. Edição individual via RPC ─────────────────────────────────────────
DO $$ BEGIN
  PERFORM public.atualizar_consentimento('10000000-0000-0000-0000-000000000001', 'sim', 'manual', 'curta');
  RAISE EXCEPTION 'FALHOU: sim sem evidência deveria falhar';
EXCEPTION WHEN invalid_parameter_value THEN NULL; END $$;
DO $$ BEGIN
  PERFORM public.atualizar_consentimento('10000000-0000-0000-0000-000000000001', 'sim', NULL, 'Evidência boa, mas sem origem informada');
  RAISE EXCEPTION 'FALHOU: sim sem origem deveria falhar';
EXCEPTION WHEN invalid_parameter_value THEN NULL; END $$;
DO $$ BEGIN
  PERFORM public.atualizar_consentimento('10000000-0000-0000-0000-000000000001', 'sim', 'inventada', 'Evidência boa com origem inventada');
  RAISE EXCEPTION 'FALHOU: origem inválida deveria falhar';
EXCEPTION WHEN invalid_parameter_value THEN NULL; END $$;
SELECT public.atualizar_consentimento('10000000-0000-0000-0000-000000000001', 'sim', 'manual',
  'Paciente pediu por telefone para receber avisos, registrado em 10/10/2026');
SELECT pg_temp.assert(public.pode_receber_disparo('10000000-0000-0000-0000-000000000001'), 'A elegível após opt-in');
SELECT pg_temp.assert((SELECT opt_in_data IS NOT NULL FROM public.patients WHERE id = '10000000-0000-0000-0000-000000000001'), 'opt_in_data preenchida');
SELECT pg_temp.assert(NOT public.pode_receber_disparo('10000000-0000-0000-0000-000000000004'), 'sem telefone nunca elegível');

-- ── 5. Recepção não pode marcar em massa nem reverter opt-out ────────────
DO $$ BEGIN
  PERFORM * FROM public.marcar_opt_in_em_massa(ARRAY['10000000-0000-0000-0000-000000000003']::uuid[], 'manual',
    'Lista de presença do evento com aceite assinado');
  RAISE EXCEPTION 'FALHOU: recepção não pode marcar em massa';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;

-- ── 6. Opt-out vence e se propaga para o mesmo número ────────────────────
SELECT public.marcar_opt_out('10000000-0000-0000-0000-000000000002', 'Pediu para sair');
SELECT pg_temp.assert((SELECT opt_out FROM public.patients WHERE id = '10000000-0000-0000-0000-000000000001'), 'opt-out propagado para A (mesmo número)');
SELECT pg_temp.assert(NOT public.pode_receber_disparo('10000000-0000-0000-0000-000000000001'), 'A deixou de ser elegível');
SELECT pg_temp.assert((SELECT opt_in FROM public.patients WHERE id = '10000000-0000-0000-0000-000000000001') = 'sim', 'opt_in sim mantido, mas opt_out vence');
DO $$ BEGIN
  PERFORM public.atualizar_consentimento('10000000-0000-0000-0000-000000000001', 'sim', 'manual', 'tentando religar depois do opt-out');
  PERFORM pg_temp.assert(NOT public.pode_receber_disparo('10000000-0000-0000-0000-000000000001'), 'religar opt_in não vence opt_out');
END $$;
DO $$ BEGIN
  PERFORM public.reverter_opt_out('10000000-0000-0000-0000-000000000001', 'Recepção tentando reverter');
  RAISE EXCEPTION 'FALHOU: recepção não pode reverter opt-out';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;
-- Cadastro novo com número suprimido já nasce bloqueado
INSERT INTO public.patients (id, name, phone, is_lead) VALUES
  ('10000000-0000-0000-0000-000000000006', 'Teste Lead F duplicado', '+55 61 99000-0101', true);
SELECT pg_temp.assert((SELECT opt_out FROM public.patients WHERE id = '10000000-0000-0000-0000-000000000006'), 'novo cadastro com número suprimido nasce opt-out');
-- Trocar telefone para um suprimido também bloqueia
UPDATE public.patients SET phone = '61 99000 0101' WHERE id = '10000000-0000-0000-0000-000000000003';
SELECT pg_temp.assert((SELECT opt_out FROM public.patients WHERE id = '10000000-0000-0000-0000-000000000003'), 'troca para número suprimido bloqueia');
RESET ROLE;

-- ── 7. ADMIN: massa e reversão ───────────────────────────────────────────
SET ROLE authenticated;
SELECT set_config('request.jwt.claims', '{"role":"authenticated","sub":"00000000-0000-0000-0000-00000000000a"}', false);
SELECT public.atualizar_consentimento('10000000-0000-0000-0000-000000000005', 'nao', NULL, NULL);
DO $$
DECLARE r record;
BEGIN
  SELECT * INTO r FROM public.marcar_opt_in_em_massa(
    ARRAY['10000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000004',
          '10000000-0000-0000-0000-000000000005', '10000000-0000-0000-0000-0000000000ff']::uuid[],
    'form_com_consentimento', 'Ficha de cadastro em papel com aceite assinado, modelo v1 de 01/10/2026');
  PERFORM pg_temp.assert(r.marcados = 1,        'massa: só D (incerto, sem opt-out) marcado');
  PERFORM pg_temp.assert(r.pulados_opt_out = 1, 'massa: B pulado por opt-out');
  PERFORM pg_temp.assert(r.pulados_nao = 1,     'massa: E (nao) pulado');
  PERFORM pg_temp.assert(r.nao_encontrados = 1, 'massa: id inexistente contado');
END $$;
SELECT pg_temp.assert((SELECT opt_in FROM public.patients WHERE id = '10000000-0000-0000-0000-000000000005') = 'nao', 'nao não virou sim na massa');
SELECT pg_temp.assert(
  (SELECT count(*) FROM public.consentimento_eventos WHERE acao = 'massa' AND ator = '00000000-0000-0000-0000-00000000000a') = 1,
  'massa auditada com o ADMIN como ator');
SELECT pg_temp.assert(public.reverter_opt_out('10000000-0000-0000-0000-000000000002', 'Paciente pediu para voltar, por escrito') >= 3,
  'reversão libera todos os cadastros do número');
SELECT pg_temp.assert(NOT EXISTS (SELECT 1 FROM public.whatsapp_supressao), 'supressão limpa após reversão');
SELECT pg_temp.assert((SELECT opt_in FROM public.patients WHERE id = '10000000-0000-0000-0000-000000000001') = 'incerto',
  'após reversão volta a incerto (precisa novo consentimento)');
RESET ROLE;

-- ── 8. Gancho de entrada (service_role) ──────────────────────────────────
SET ROLE service_role;
SELECT set_config('request.jwt.claims', '{"role":"service_role"}', false);
INSERT INTO public.patients (id, name, phone, is_lead) VALUES
  ('20000000-0000-0000-0000-000000000001', 'Teste CTWA', '(61) 99000-0201', true),
  ('20000000-0000-0000-0000-000000000002', 'Teste Form sem campo', '(61) 99000-0202', true),
  ('20000000-0000-0000-0000-000000000003', 'Teste WAHA legado', '(61) 99000-0203', true),
  ('20000000-0000-0000-0000-000000000004', 'Teste Lead Ad sem vigência', '(61) 99000-0204', true);
SELECT pg_temp.assert(public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000001', 'click_to_whatsapp', NULL,
  'CTWA ad=TESTE wamid=TESTE recebido_em=2026-10-10T10:00:00-03:00') = 'sim', 'CTWA vira sim');
SELECT pg_temp.assert(public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000002', 'form_sem_consentimento', NULL, 'form site v1') = 'incerto', 'form sem campo = incerto');
SELECT pg_temp.assert(public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000003', 'whatsapp_legado', NULL, 'n8n waha') = 'incerto', 'WAHA legado = incerto');
SELECT pg_temp.assert(public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000004', 'lead_ad', 'talvez', 'lead ad x') = 'incerto', 'valor ambíguo = incerto');
-- 'nao' + CTWA continua 'nao'
SELECT pg_temp.assert(public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000004', 'lead_ad', 'nao', 'lead ad recusou') = 'nao', 'recusa explícita = nao');
SELECT pg_temp.assert(public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000004', 'click_to_whatsapp', NULL,
  'CTWA posterior ad=TESTE recebido_em=2026-10-10') = 'nao_mantido_revisao_humana', 'nao + CTWA permanece nao');
SELECT public.marcar_opt_out('20000000-0000-0000-0000-000000000001', 'Respondeu SAIR');
SELECT pg_temp.assert(public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000001', 'click_to_whatsapp', NULL,
  'CTWA de novo, depois do SAIR') = 'opt_out_mantido', 'CTWA não desfaz opt-out');
RESET ROLE;

-- Recepção não chama o gancho de integração
SET ROLE authenticated;
SELECT set_config('request.jwt.claims', '{"role":"authenticated","sub":"00000000-0000-0000-0000-00000000000b"}', false);
DO $$ BEGIN
  PERFORM public.registrar_consentimento_entrada('20000000-0000-0000-0000-000000000002', 'click_to_whatsapp', NULL, 'tentativa via app');
  RAISE EXCEPTION 'FALHOU: authenticated não deveria executar o gancho';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;
RESET ROLE;

-- ── 9. anon não lê nada novo ─────────────────────────────────────────────
SET ROLE anon;
DO $$ BEGIN
  PERFORM 1 FROM public.whatsapp_supressao;
  RAISE EXCEPTION 'FALHOU: anon leu supressão';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;
DO $$ BEGIN
  PERFORM 1 FROM public.consentimento_eventos;
  RAISE EXCEPTION 'FALHOU: anon leu eventos';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;
DO $$ BEGIN
  PERFORM public.pode_receber_disparo('10000000-0000-0000-0000-000000000001');
  RAISE EXCEPTION 'FALHOU: anon executou função';
EXCEPTION WHEN insufficient_privilege THEN NULL; END $$;
RESET ROLE;

-- ── 10. Auditoria sem telefone/nome em texto aberto ──────────────────────
SELECT pg_temp.assert(NOT EXISTS (
  SELECT 1 FROM public.consentimento_eventos e
  WHERE to_jsonb(e)::text ~ '99000-0|\+5561' OR to_jsonb(e)::text ILIKE '%Teste Lead%'
), 'auditoria não contém telefone nem nome');
SELECT pg_temp.assert(NOT EXISTS (SELECT 1 FROM public.whatsapp_supressao WHERE phone_hash ~ '\+|99000'), 'supressão guarda só hash');

\echo 'TODOS OS TESTES DE CONSENTIMENTO PASSARAM'
