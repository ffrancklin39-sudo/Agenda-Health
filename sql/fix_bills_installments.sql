-- ============================================================
-- SintesIA — Correção do sistema de parcelas (bills)
-- Executar no Supabase SQL Editor
-- Data: 2026-09-28
-- ============================================================
-- O que este script faz:
--  1. Adiciona colunas installment_number e installment_total
--  2. Reescreve fn_generate_recurring_bills para gerar TODOS
--     os meses dentro do horizonte (não apenas o próximo)
--  3. Atualiza o Empréstimo Roberto com dados corretos (69/72)
--  4. Executa a geração imediatamente para o horizonte de 6 meses
-- ============================================================


-- ─────────────────────────────────────────────────────────────
-- 1. COLUNAS: controle de parcelas
--    installment_number  — número desta parcela (ex: 69)
--    installment_total   — total de parcelas da série (ex: 72)
--    Ambas ficam NULL para contas "forever" ou com recurrence_end por data.
-- ─────────────────────────────────────────────────────────────
ALTER TABLE bills
  ADD COLUMN IF NOT EXISTS installment_number INT,
  ADD COLUMN IF NOT EXISTS installment_total  INT;

-- Índice para consultas por série (parent + todas as filhas)
CREATE INDEX IF NOT EXISTS idx_bills_installment ON bills(parent_bill_id, installment_number);


-- ─────────────────────────────────────────────────────────────
-- 2. FUNÇÃO REESCRITA: fn_generate_recurring_bills
--
--    Correção do bug original: a versão anterior calculava
--    sempre v_next = parent.due_date + 1 mês, ignorando filhas
--    já existentes. Gerava apenas UMA ocorrência por execução.
--
--    Nova lógica:
--      • Encontra a ocorrência mais recente da série (pai ou filha)
--      • Faz loop a partir dela até o horizonte
--      • Respeita: recurrence_end, installment_total, horizonte
--      • Nunca duplica: verifica existência antes de inserir
-- ─────────────────────────────────────────────────────────────
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
      -- Só inclui se ainda não encerrou (recurrence_end no futuro ou indefinida)
      AND (recurrence_end IS NULL OR recurrence_end >= CURRENT_DATE)
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
    -- Isso garante que avançamos a partir do último gerado, não sempre do pai.
    SELECT COALESCE(
      (SELECT MAX(due_date) FROM bills WHERE parent_bill_id = v_bill.id),
      v_bill.due_date
    ) INTO v_latest;

    -- Quantas filhas já existem (para calcular installment_number dos novos)
    SELECT COUNT(*) INTO v_child_count FROM bills WHERE parent_bill_id = v_bill.id;

    -- Máximo de filhas permitidas (para séries com número fixo de parcelas)
    --   Ex: parent installment_number=69, total=72 → pode ter até 3 filhas (70, 71, 72)
    IF v_bill.installment_total IS NOT NULL THEN
      v_max_children := v_bill.installment_total - COALESCE(v_bill.installment_number, 1);
    ELSE
      v_max_children := NULL; -- ilimitado (forever ou end_date)
    END IF;

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
        -- Número desta parcela (NULL se não é série numerada)
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
-- 3. ATUALIZAR: 1º Empréstimo Roberto (69/72)
--    Parcela de setembro/2026 = número 69 de 72.
--    Série encerra em dezembro/2026 (parcela 72 → dia 04/12).
-- ─────────────────────────────────────────────────────────────
UPDATE bills
SET
  installment_number = 69,
  installment_total  = 72,
  recurrence_end     = '2026-12-04',
  notes              = 'Parcela 69/72 — série encerra em dez/2026'
WHERE description = '1º Empréstimo Roberto (69/72)'
  AND due_date = '2026-09-04'
  AND parent_bill_id IS NULL;

-- Garantir que a coluna recurrence seja 'monthly' (já deve ser, mas confirma)
UPDATE bills
SET recurrence = 'monthly'
WHERE description = '1º Empréstimo Roberto (69/72)'
  AND due_date = '2026-09-04'
  AND parent_bill_id IS NULL;


-- ─────────────────────────────────────────────────────────────
-- 4. EXECUTAR: gerar parcelas do horizonte atual (6 meses)
--    Isso vai criar automaticamente out/nov/dez para o Roberto
--    e completar as ocorrências de outras contas recorrentes.
-- ─────────────────────────────────────────────────────────────
SELECT fn_generate_recurring_bills(6) AS geradas;


-- ─────────────────────────────────────────────────────────────
-- 5. VERIFICAÇÃO
-- ─────────────────────────────────────────────────────────────

-- Série do Roberto
SELECT
  description,
  due_date,
  installment_number,
  installment_total,
  status,
  recurrence_end,
  parent_bill_id IS NULL AS is_parent
FROM bills
WHERE description LIKE '%Empréstimo Roberto%'
ORDER BY due_date;

-- Todas as contas com parcelas numeradas
SELECT
  description,
  due_date,
  installment_number || '/' || installment_total AS parcela,
  status
FROM bills
WHERE installment_total IS NOT NULL
ORDER BY description, due_date;

-- Resumo por série (quantas filhas cada pai tem)
SELECT
  p.description,
  p.installment_number AS parcela_pai,
  p.installment_total  AS total,
  COUNT(c.id)          AS filhas_geradas,
  MIN(c.due_date)      AS primeira_filha,
  MAX(c.due_date)      AS ultima_filha
FROM bills p
LEFT JOIN bills c ON c.parent_bill_id = p.id
WHERE p.parent_bill_id IS NULL
  AND p.installment_total IS NOT NULL
GROUP BY p.id, p.description, p.installment_number, p.installment_total
ORDER BY p.description;
