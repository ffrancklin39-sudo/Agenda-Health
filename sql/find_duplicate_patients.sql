-- ============================================================
-- SintesIA — Diagnóstico de pacientes duplicados
-- Execute PRIMEIRO. Revise os resultados antes de limpar.
-- ============================================================

-- ─── 1. Duplicados por CPF (mais confiável) ───────────────
SELECT
  cpf,
  COUNT(*)                                          AS total,
  string_agg(id::TEXT, ', ' ORDER BY created_at)   AS ids,
  string_agg(name, ' | ' ORDER BY created_at)      AS nomes,
  string_agg(phone, ' | ' ORDER BY created_at)     AS telefones,
  MIN(created_at)                                   AS mais_antigo,
  MAX(created_at)                                   AS mais_novo
FROM patients
WHERE cpf IS NOT NULL AND cpf <> ''
GROUP BY cpf
HAVING COUNT(*) > 1
ORDER BY total DESC, cpf;

-- ─── 2. Duplicados por nome + telefone (sem CPF) ──────────
SELECT
  LOWER(TRIM(name))                                    AS nome_norm,
  phone,
  COUNT(*)                                             AS total,
  string_agg(id::TEXT, ', ' ORDER BY created_at)      AS ids,
  string_agg(cpf, ' | ' ORDER BY created_at)          AS cpfs,
  MIN(created_at)                                      AS mais_antigo,
  MAX(created_at)                                      AS mais_novo
FROM patients
WHERE (cpf IS NULL OR cpf = '')
GROUP BY LOWER(TRIM(name)), phone
HAVING COUNT(*) > 1 AND phone IS NOT NULL AND phone <> ''
ORDER BY total DESC, nome_norm;

-- ─── 3. Duplicados por nome apenas (sem CPF, sem telefone) ─
SELECT
  LOWER(TRIM(name))                                    AS nome_norm,
  COUNT(*)                                             AS total,
  string_agg(id::TEXT, ', ' ORDER BY created_at)      AS ids,
  string_agg(phone, ' | ' ORDER BY created_at)        AS telefones,
  MIN(created_at)                                      AS mais_antigo,
  MAX(created_at)                                      AS mais_novo
FROM patients
WHERE (cpf IS NULL OR cpf = '') AND (phone IS NULL OR phone = '')
GROUP BY LOWER(TRIM(name))
HAVING COUNT(*) > 1
ORDER BY total DESC, nome_norm;

-- ─── 4. Resumo geral ──────────────────────────────────────
SELECT
  'Por CPF'          AS criterio,
  COUNT(*)           AS grupos_duplicados,
  SUM(total - 1)     AS registros_a_remover
FROM (
  SELECT cpf, COUNT(*) AS total
  FROM patients
  WHERE cpf IS NOT NULL AND cpf <> ''
  GROUP BY cpf HAVING COUNT(*) > 1
) t

UNION ALL

SELECT
  'Por nome+telefone' AS criterio,
  COUNT(*)            AS grupos_duplicados,
  SUM(total - 1)      AS registros_a_remover
FROM (
  SELECT LOWER(TRIM(name)), phone, COUNT(*) AS total
  FROM patients
  WHERE (cpf IS NULL OR cpf = '') AND phone IS NOT NULL AND phone <> ''
  GROUP BY LOWER(TRIM(name)), phone HAVING COUNT(*) > 1
) t;
