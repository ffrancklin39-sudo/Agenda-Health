-- ============================================================
-- MIGRAÇÃO: Pacientes Feegow → status 'active'
-- Objetivo: zerar o CRM de leads falsos gerados pela migração.
-- Todos os pacientes importados do Feegow que ainda estão como
-- 'lead' viram 'active' (base histórica de pacientes atendidos).
-- Leads reais adicionados manualmente/Sofia ficam intactos.
-- ============================================================

-- 1. Confirme o volume antes de executar (rode isso primeiro):
SELECT status, COUNT(*) FROM patients GROUP BY status ORDER BY COUNT(*) DESC;

-- 2. Execução: move todos os 'lead' para 'active'
--    (Se quiser preservar leads adicionados DEPOIS da migração,
--     adicione: AND created_at < '2025-01-01' com a data da importação)
UPDATE patients
SET status = 'active'
WHERE LOWER(status) IN ('lead', 'novos leads', 'new', 'novo');

-- 3. Confirme o resultado:
SELECT status, COUNT(*) FROM patients GROUP BY status ORDER BY COUNT(*) DESC;
