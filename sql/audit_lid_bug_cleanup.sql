-- ============================================================
-- Auditoria: registros afetados pelo bug do @lid (Task #65/#66)
-- Rodar no SQL Editor do Supabase. Apenas leitura (SELECT) — seguro.
-- ============================================================

-- 1) Quantos pacientes/leads ficaram com telefone "quebrado" (@lid)?
SELECT id, name, phone, status, created_at
FROM patients
WHERE phone LIKE '%@lid'
ORDER BY created_at DESC;

-- 2) Quantos ficaram sem nome real (capturados como "Sem nome" / "Lead Sem Nome")?
SELECT id, name, phone, status, created_at
FROM patients
WHERE name IN ('Sem nome', 'Lead Sem Nome')
ORDER BY created_at DESC;

-- 3) Possíveis duplicados: mesmo paciente existindo 2x —
--    uma vez com telefone real e outra vez como lead "@lid".
--    Versão simples (sem extensão extra): nome exatamente igual.
SELECT
  p1.id   AS id_real,
  p1.name AS nome_real,
  p1.phone AS telefone_real,
  p2.id   AS id_lead_lid,
  p2.name AS nome_lead,
  p2.phone AS telefone_lid,
  p2.created_at AS criado_em
FROM patients p1
JOIN patients p2
  ON p2.phone LIKE '%@lid'
  AND p1.phone NOT LIKE '%@lid'
  AND p1.name = p2.name
ORDER BY p2.created_at DESC;

-- 3b) (Opcional, mais abrangente) Para comparar por nome PARECIDO, não só igual,
--     habilite a extensão pg_trgm primeiro — geralmente funciona no Supabase:
--     CREATE EXTENSION IF NOT EXISTS pg_trgm;
-- Depois rode:
-- SELECT
--   p1.id AS id_real, p1.name AS nome_real, p1.phone AS telefone_real,
--   p2.id AS id_lead_lid, p2.name AS nome_lead, p2.phone AS telefone_lid,
--   p2.created_at AS criado_em
-- FROM patients p1
-- JOIN patients p2
--   ON p2.phone LIKE '%@lid'
--   AND p1.phone NOT LIKE '%@lid'
--   AND similarity(p1.name, p2.name) > 0.4
-- ORDER BY p2.created_at DESC;

-- 3c) Caso a query 3 não retorne nada (nomes "Sem nome" não vão bater por igualdade),
--     liste manualmente os leads "@lid" sem nome pra você comparar por telefone/data com a lista de pacientes:
SELECT id, name, phone, status, created_at
FROM patients
WHERE phone LIKE '%@lid'
   OR name IN ('Sem nome', 'Lead Sem Nome')
ORDER BY created_at DESC;

-- 4) Total geral afetado (visão rápida)
SELECT
  COUNT(*) FILTER (WHERE phone LIKE '%@lid') AS total_telefone_lid,
  COUNT(*) FILTER (WHERE name IN ('Sem nome', 'Lead Sem Nome')) AS total_sem_nome
FROM patients;
