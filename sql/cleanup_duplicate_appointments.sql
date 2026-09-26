-- ============================================================
-- SintesIA — Limpeza de agendamentos duplicados
-- Causa: import_agendamentos_feegow_2026.sql inseriu registros
--        que já existiam na agenda (mesmo paciente + profissional + horário)
-- Estratégia: manter o registro sem "importado do Feegow" nas notes;
--             se ambos vieram do Feegow, manter o mais antigo (created_at menor).
-- ============================================================

-- 1. Preview — veja o que será removido antes de confirmar
/*
SELECT
  a.id,
  p.name AS patient,
  pr.name AS professional,
  a.date_time,
  a.notes,
  a.created_at
FROM appointments a
JOIN patients p ON p.id = a.patient_id
LEFT JOIN professionals pr ON pr.id = a.professional_id
WHERE EXISTS (
  SELECT 1 FROM appointments b
  WHERE b.patient_id       = a.patient_id
    AND b.professional_id  = a.professional_id
    AND b.date_time        = a.date_time
    AND b.id              <> a.id
)
ORDER BY a.patient_id, a.date_time, a.created_at;
*/

-- 2. Limpeza — delete os duplicados mantendo o mais adequado
DELETE FROM appointments
WHERE id IN (
  SELECT id FROM (
    SELECT
      a.id,
      -- Se a note contém "importado do Feegow", preferimos deletar esse
      -- Se ambos contêm (ou ambos não contêm), deletar o mais recente (created_at maior)
      ROW_NUMBER() OVER (
        PARTITION BY a.patient_id, a.professional_id, a.date_time
        ORDER BY
          -- Preferir manter o que NÃO tem "importado do Feegow"
          CASE WHEN a.notes ILIKE '%importado do Feegow%' THEN 1 ELSE 0 END ASC,
          -- Desempate: manter o mais antigo
          a.created_at ASC
      ) AS rn
    FROM appointments a
    WHERE EXISTS (
      SELECT 1 FROM appointments b
      WHERE b.patient_id      = a.patient_id
        AND b.professional_id = a.professional_id
        AND b.date_time       = a.date_time
        AND b.id             <> a.id
    )
  ) ranked
  WHERE rn > 1
);

-- 3. Verificação pós-limpeza — deve retornar 0 linhas
SELECT COUNT(*) AS duplicatas_restantes
FROM (
  SELECT patient_id, professional_id, date_time
  FROM appointments
  GROUP BY patient_id, professional_id, date_time
  HAVING COUNT(*) > 1
) d;
