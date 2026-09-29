-- ============================================================
-- SintesIA — Corrigir geração de parcelas para séries com
--            recurrence_end no passado
-- Executar no Supabase SQL Editor
-- Data: 2026-09-29
-- ============================================================
-- Problema: a versão anterior da função skipava bills cujo
--   recurrence_end < CURRENT_DATE, mesmo que ainda tivessem
--   filhas pendentes de geração (ex: série criada com data
--   inicial em meses anteriores, recurrence_end já passou).
--
-- Correção: incluir sempre contas com installment_total IS NOT NULL
--   (séries numeradas), pois o loop interno já controla o stop
--   via EXIT WHEN v_child_count >= v_max_children.
-- ============================================================

CREATE OR REPLACE FUNCTION fn_generate_recurring_bills(p_months_ahead INTEGER DEFAULT 3)
RETURNS INTEGER
LANGUAGE plpgsql AS $$
DECLARE
  v_bill         RECORD;
  v_latest       DATE;
  v_next         DATE;
  v_horizon      DATE;
  v_interval     INTERVAL;
  v_count        INTEGER := 0;
  v_child_count  INTEGER;
  v_new_inst_num INT;
  v_max_children INT;
BEGIN
  v_horizon := (CURRENT_DATE + (p_months_ahead || ' months')::INTERVAL)::DATE;

  FOR v_bill IN
    SELECT * FROM bills
    WHERE recurrence != 'none'
      AND status != 'cancelled'
      AND parent_bill_id IS NULL
      -- Inclui se: sem data de fim, data de fim futura,
      -- OU é série numerada (recurrence_end pode ter passado mas
      -- ainda pode haver filhas a gerar — loop interno controla o stop)
      AND (
        recurrence_end IS NULL
        OR recurrence_end >= CURRENT_DATE
        OR installment_total IS NOT NULL
      )
  LOOP
    -- Monta o intervalo por tipo de recorrência
    v_interval := CASE v_bill.recurrence
      WHEN 'weekly'    THEN INTERVAL '1 week'
      WHEN 'monthly'   THEN INTERVAL '1 month'
      WHEN 'quarterly' THEN INTERVAL '3 months'
      WHEN 'yearly'    THEN INTERVAL '1 year'
      ELSE NULL
    END;
    CONTINUE WHEN v_interval IS NULL;

    -- Ponto de partida: maior due_date existente na série (pai ou qualquer filha)
    SELECT COALESCE(
      (SELECT MAX(due_date) FROM bills WHERE parent_bill_id = v_bill.id),
      v_bill.due_date
    ) INTO v_latest;

    -- Quantas filhas já existem (para calcular installment_number dos novos)
    SELECT COUNT(*) INTO v_child_count FROM bills WHERE parent_bill_id = v_bill.id;

    -- Máximo de filhas permitidas (para séries com número fixo de parcelas)
    IF v_bill.installment_total IS NOT NULL THEN
      v_max_children := v_bill.installment_total - COALESCE(v_bill.installment_number, 1);
    ELSE
      v_max_children := NULL; -- ilimitado (forever ou end_date)
    END IF;

    -- Se a série já está completa, pula imediatamente
    CONTINUE WHEN v_max_children IS NOT NULL AND v_child_count >= v_max_children;

    -- Loop: gera uma ocorrência por vez, avançando v_next
    v_next := v_latest;
    LOOP
      v_next := (v_next + v_interval)::DATE;

      -- Stop: ultrapassou o horizonte de geração
      EXIT WHEN v_next > v_horizon;

      -- Stop: ultrapassou a data de encerramento
      EXIT WHEN v_bill.recurrence_end IS NOT NULL AND v_next > v_bill.recurrence_end;

      -- Stop: atingiu o número máximo de parcelas filhas
      EXIT WHEN v_max_children IS NOT NULL AND v_child_count >= v_max_children;

      -- Insere apenas se esta ocorrência ainda não existe
      IF NOT EXISTS (
        SELECT 1 FROM bills WHERE parent_bill_id = v_bill.id AND due_date = v_next
      ) THEN
        v_new_inst_num := CASE
          WHEN v_bill.installment_total IS NOT NULL
          THEN COALESCE(v_bill.installment_number, 1) + v_child_count + 1
          ELSE NULL
        END;

        INSERT INTO bills (
          description,
          category,
          supplier,
          amount,
          due_date,
          recurrence,
          recurrence_end,
          parent_bill_id,
          notes,
          installment_number,
          installment_total
        ) VALUES (
          v_bill.description,
          v_bill.category,
          v_bill.supplier,
          v_bill.amount,
          v_next,
          v_bill.recurrence,
          v_bill.recurrence_end,
          v_bill.id,
          v_bill.notes,
          v_new_inst_num,
          v_bill.installment_total
        );

        v_child_count := v_child_count + 1;
        v_count := v_count + 1;
      END IF;
    END LOOP;
  END LOOP;

  RETURN v_count;
END;
$$;


-- ─────────────────────────────────────────────────────────────
-- Executa imediatamente para completar séries incompletas
-- ─────────────────────────────────────────────────────────────
SELECT fn_generate_recurring_bills(12) AS geradas;


-- ─────────────────────────────────────────────────────────────
-- Verificação: séries com parcelas faltando
-- ─────────────────────────────────────────────────────────────
SELECT
  p.description,
  p.installment_number  AS parcela_pai,
  p.installment_total   AS total,
  COUNT(c.id)           AS filhas_geradas,
  p.installment_total - COALESCE(p.installment_number, 1) AS filhas_esperadas,
  MIN(c.due_date)       AS primeira_filha,
  MAX(c.due_date)       AS ultima_filha
FROM bills p
LEFT JOIN bills c ON c.parent_bill_id = p.id
WHERE p.parent_bill_id IS NULL
  AND p.installment_total IS NOT NULL
GROUP BY p.id, p.description, p.installment_number, p.installment_total
ORDER BY p.description;
