-- ============================================================
-- SintesIA — Limpeza de pacientes duplicados
-- ⚠️  Rode find_duplicate_patients.sql ANTES e revise!
-- Estratégia: mantém o registro MAIS ANTIGO (created_at mínimo)
--   e remove os mais novos. Antes de deletar, migra dados
--   importantes (payments, appointments, clinical_notes) para
--   o registro que será mantido.
-- ============================================================

BEGIN;

-- ─── ETAPA 1: Duplicados por CPF ──────────────────────────
-- Para cada grupo de CPF duplicado, mantém o mais antigo
-- e redireciona os filhos dos duplicatas antes de deletar

DO $$
DECLARE
  r RECORD;
  keeper_id UUID;
  dup_id    UUID;
BEGIN
  FOR r IN
    SELECT cpf, array_agg(id ORDER BY created_at) AS ids
    FROM patients
    WHERE cpf IS NOT NULL AND cpf <> ''
    GROUP BY cpf
    HAVING COUNT(*) > 1
  LOOP
    keeper_id := r.ids[1];  -- mais antigo

    FOREACH dup_id IN ARRAY r.ids[2:]  -- todos os duplicados
    LOOP
      RAISE NOTICE 'CPF % — mantendo %, removendo %', r.cpf, keeper_id, dup_id;

      -- Migra appointments
      UPDATE appointments   SET patient_id = keeper_id WHERE patient_id = dup_id;
      -- Migra payments
      UPDATE payments        SET patient_id = keeper_id WHERE patient_id = dup_id;
      -- Migra clinical notes
      UPDATE patient_clinical_notes SET patient_id = keeper_id WHERE patient_id = dup_id;
      -- Migra arquivos (se existir)
      -- UPDATE patient_files   SET patient_id = keeper_id WHERE patient_id = dup_id;

      -- Atualiza keeper com campos do duplicado se keeper estiver vazio
      UPDATE patients SET
        phone       = COALESCE(NULLIF(phone,''),       (SELECT phone       FROM patients WHERE id = dup_id)),
        email       = COALESCE(NULLIF(email,''),       (SELECT email       FROM patients WHERE id = dup_id)),
        birth_date  = COALESCE(birth_date,             (SELECT birth_date  FROM patients WHERE id = dup_id)),
        address     = COALESCE(NULLIF(address,''),     (SELECT address     FROM patients WHERE id = dup_id)),
        zip_code    = COALESCE(NULLIF(zip_code,''),    (SELECT zip_code    FROM patients WHERE id = dup_id)),
        blood_type  = COALESCE(NULLIF(blood_type,''),  (SELECT blood_type  FROM patients WHERE id = dup_id)),
        appointment_date = GREATEST(appointment_date,  (SELECT appointment_date FROM patients WHERE id = dup_id))
      WHERE id = keeper_id;

      -- Deleta o duplicado
      DELETE FROM patients WHERE id = dup_id;
    END LOOP;
  END LOOP;
END;
$$;

-- ─── ETAPA 2: Duplicados por nome + telefone (sem CPF) ────

DO $$
DECLARE
  r RECORD;
  keeper_id UUID;
  dup_id    UUID;
BEGIN
  FOR r IN
    SELECT array_agg(id ORDER BY created_at) AS ids
    FROM patients
    WHERE (cpf IS NULL OR cpf = '') AND phone IS NOT NULL AND phone <> ''
    GROUP BY LOWER(TRIM(name)), phone
    HAVING COUNT(*) > 1
  LOOP
    keeper_id := r.ids[1];

    FOREACH dup_id IN ARRAY r.ids[2:]
    LOOP
      RAISE NOTICE 'Nome+fone — mantendo %, removendo %', keeper_id, dup_id;

      UPDATE appointments            SET patient_id = keeper_id WHERE patient_id = dup_id;
      UPDATE payments                SET patient_id = keeper_id WHERE patient_id = dup_id;
      UPDATE patient_clinical_notes  SET patient_id = keeper_id WHERE patient_id = dup_id;

      UPDATE patients SET
        email       = COALESCE(NULLIF(email,''),      (SELECT email      FROM patients WHERE id = dup_id)),
        cpf         = COALESCE(NULLIF(cpf,''),        (SELECT cpf        FROM patients WHERE id = dup_id)),
        birth_date  = COALESCE(birth_date,            (SELECT birth_date FROM patients WHERE id = dup_id)),
        address     = COALESCE(NULLIF(address,''),    (SELECT address    FROM patients WHERE id = dup_id)),
        zip_code    = COALESCE(NULLIF(zip_code,''),   (SELECT zip_code   FROM patients WHERE id = dup_id)),
        appointment_date = GREATEST(appointment_date, (SELECT appointment_date FROM patients WHERE id = dup_id))
      WHERE id = keeper_id;

      DELETE FROM patients WHERE id = dup_id;
    END LOOP;
  END LOOP;
END;
$$;

-- ─── Confirmação ──────────────────────────────────────────
SELECT
  'Após limpeza' AS status,
  COUNT(*) AS total_pacientes
FROM patients;

COMMIT;
