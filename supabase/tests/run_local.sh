#!/usr/bin/env bash
# Testa a migration de consentimento num Postgres local descartável:
#   stub → dados "antigos" fictícios → UP → UP (idempotência) → testes →
#   DOWN → DOWN (idempotência) → confere que nada antigo mudou → UP de novo.
#
# Uso: PGBIN=/usr/lib/postgresql/16/bin supabase/tests/run_local.sh
# (precisa rodar como usuário não-root; o diretório de dados é temporário)
set -euo pipefail

PGBIN="${PGBIN:-/usr/lib/postgresql/16/bin}"
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
UP="$ROOT/supabase/migrations/20261010120000_whatsapp_consentimento.sql"
DOWN="$ROOT/supabase/rollback/20261010120000_whatsapp_consentimento_down.sql"
TESTS="$ROOT/supabase/tests"
WORK="$(mktemp -d)"
PORT="${PORT:-54329}"

cleanup() { "$PGBIN/pg_ctl" -D "$WORK/data" -m immediate stop >/dev/null 2>&1 || true; rm -rf "$WORK"; }
trap cleanup EXIT

"$PGBIN/initdb" -D "$WORK/data" -U postgres -A trust >/dev/null
"$PGBIN/pg_ctl" -D "$WORK/data" -o "-p $PORT -k $WORK -c listen_addresses=''" -l "$WORK/log" start >/dev/null
PSQL=(psql -h "$WORK" -p "$PORT" -U postgres -d postgres -v ON_ERROR_STOP=1 -q -X)

step() { echo "▶ $*"; }

step "stub do Supabase"
"${PSQL[@]}" -f "$TESTS/stub_supabase.sql"

step "dados antigos fictícios (antes da migration)"
"${PSQL[@]}" -c "
  INSERT INTO public.patients (name, phone, is_lead, updated_at) VALUES
    ('Antigo Teste 1', '(61) 99000-0001', false, '2026-01-01T00:00:00Z'),
    ('Antigo Teste 2', '61 9000-0002',     true,  '2026-01-01T00:00:00Z'),
    ('Antigo Teste 3', NULL,               true,  '2026-01-01T00:00:00Z');
  INSERT INTO public.role_permissions (role, module, enabled) VALUES ('ADMIN','dashboard',true);"
SNAP="SELECT md5(string_agg(id::text||name||coalesce(phone,'')||is_lead::text||updated_at::text, ',' ORDER BY id)) FROM public.patients WHERE name LIKE 'Antigo%'"
BEFORE="$("${PSQL[@]}" -tAc "$SNAP")"

step "UP (1ª vez)";  "${PSQL[@]}" -1 -f "$UP"
step "UP (2ª vez — idempotência)"; "${PSQL[@]}" -1 -f "$UP"
AFTER_UP="$("${PSQL[@]}" -tAc "$SNAP")"
[ "$BEFORE" = "$AFTER_UP" ] || { echo "FALHOU: UP alterou dados antigos (inclusive updated_at)"; exit 1; }
echo "  ok: dados antigos intactos após UP (updated_at incluso)"

step "testes"; "${PSQL[@]}" -f "$TESTS/consentimento_test.sql"

step "concorrência: opt-out em andamento durante marcação em massa"
"${PSQL[@]}" -c "
  INSERT INTO public.patients (id, name, phone, is_lead) VALUES
    ('30000000-0000-0000-0000-000000000001', 'Teste Concorrência', '(61) 99000-0301', true);"
ADMIN_CLAIMS='{"role":"authenticated","sub":"00000000-0000-0000-0000-00000000000a"}'
# Sessão 1: marca opt-out e segura a transação aberta por 3 s
"${PSQL[@]}" -c "BEGIN; SET LOCAL ROLE authenticated; SELECT set_config('request.jwt.claims', '$ADMIN_CLAIMS', true);
  SELECT public.marcar_opt_out('30000000-0000-0000-0000-000000000001', 'teste concorrência'); SELECT pg_sleep(3); COMMIT;" >/dev/null &
S1=$!
sleep 1
# Sessão 2: marcação em massa no mesmo cadastro, enquanto a sessão 1 ainda não terminou
RES="$("${PSQL[@]}" -tAc "SET ROLE authenticated; SELECT set_config('request.jwt.claims', '$ADMIN_CLAIMS', false);
  SELECT marcados || '/' || pulados_opt_out FROM public.marcar_opt_in_em_massa(
    ARRAY['30000000-0000-0000-0000-000000000001']::uuid[], 'manual', 'Teste de concorrência com evidência longa o bastante')" | tail -1)"
wait $S1
[ "$RES" = "0/0" ] || [ "$RES" = "0/1" ] || { echo "FALHOU: massa marcou durante opt-out concorrente ($RES)"; exit 1; }
ELEG="$("${PSQL[@]}" -tAc "SELECT public.pode_receber_disparo('30000000-0000-0000-0000-000000000001')")"
[ "$ELEG" = "f" ] || { echo "FALHOU: ficou elegível após opt-out concorrente"; exit 1; }
echo "  ok: opt-out concorrente venceu a marcação em massa (resultado $RES)"

step "DOWN (1ª vez)"; "${PSQL[@]}" -1 -f "$DOWN"
step "DOWN (2ª vez — idempotência)"; "${PSQL[@]}" -1 -f "$DOWN"
LEFT="$("${PSQL[@]}" -tAc "
  SELECT count(*) FROM information_schema.columns WHERE table_name='patients'
     AND column_name IN ('opt_in','opt_in_origem','opt_in_data','opt_in_evidencia','opt_out','opt_out_data','phone_e164')
  UNION ALL SELECT count(*) FROM pg_proc WHERE proname IN ('pode_receber_disparo','normalizar_telefone_e164','marcar_opt_in_em_massa')
  UNION ALL SELECT (to_regclass('public.whatsapp_supressao') IS NOT NULL)::int + (to_regclass('public.consentimento_eventos') IS NOT NULL)::int
  UNION ALL SELECT count(*) FROM public.role_permissions WHERE module='whatsapp'" | tr '\n' ' ')"
[ "$LEFT" = "0 0 0 0 " ] || { echo "FALHOU: DOWN deixou restos: $LEFT"; exit 1; }
AFTER_DOWN="$("${PSQL[@]}" -tAc "$SNAP")"
[ "$BEFORE" = "$AFTER_DOWN" ] || { echo "FALHOU: DOWN alterou dados antigos"; exit 1; }
ARQ="$("${PSQL[@]}" -tAc "SELECT count(*) FROM public.consentimento_arquivo")"
[ "$ARQ" -gt 0 ] || { echo "FALHOU: DOWN não arquivou o consentimento"; exit 1; }
"${PSQL[@]}" -c "SET ROLE authenticated; DO \$\$ BEGIN PERFORM 1 FROM public.consentimento_arquivo; RAISE EXCEPTION 'FALHOU: authenticated leu o arquivo'; EXCEPTION WHEN insufficient_privilege THEN NULL; END \$\$;"
"${PSQL[@]}" -c "SET ROLE anon; DO \$\$ BEGIN PERFORM 1 FROM public.consentimento_arquivo; RAISE EXCEPTION 'FALHOU: anon leu o arquivo'; EXCEPTION WHEN insufficient_privilege THEN NULL; END \$\$;"
echo "  ok: sem restos, dados antigos intactos, $ARQ registros arquivados e protegidos"

step "UP de novo (sobe → reverte → sobe)"; "${PSQL[@]}" -1 -f "$UP"
ELEG="$("${PSQL[@]}" -tAc "SELECT count(*) FROM public.patients WHERE public.pode_receber_disparo(id)")"
[ "$ELEG" = "0" ] || { echo "FALHOU: após re-UP há $ELEG elegíveis sem ação humana"; exit 1; }
echo "  ok: após re-UP ninguém é elegível sem ação humana"

echo "✅ migration sobe, reverte e sobe sem erro"
