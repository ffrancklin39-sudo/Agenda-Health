-- ============================================================================
-- CORRIGIR NOMES DOS PACIENTES — Title Case
-- Execute no Supabase SQL Editor
-- initcap() converte "MARIA SILVA" e "maria silva" para "Maria Silva"
-- ============================================================================

-- 1. Prévia: ver quantos nomes vão mudar
SELECT COUNT(*) as total_a_corrigir
FROM patients
WHERE name IS NOT NULL AND name <> initcap(name);

-- 2. Executar a correção (descomente quando confirmar o número acima)
-- UPDATE patients
-- SET name = initcap(name)
-- WHERE name IS NOT NULL AND name <> initcap(name);

-- 3. (Opcional) Corrigir também nome social
-- UPDATE patients
-- SET social_name = initcap(social_name)
-- WHERE social_name IS NOT NULL AND social_name <> initcap(social_name);
