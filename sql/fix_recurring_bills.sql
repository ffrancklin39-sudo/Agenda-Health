-- ============================================================
-- fix_recurring_bills.sql
-- 1. Corrige fn_generate_recurring_bills para gerar TODOS os
--    meses futuros (não só o próximo)
-- 2. Garante que upsert de clinic_settings funciona com RLS
-- Execute no Supabase SQL Editor
-- ============================================================

-- ------------------------------------------------------------
-- 1. Atualiza fn_generate_recurring_bills
--    Antes: gerava só 1 ocorrência a partir da data raiz
--    Depois: percorre mês a mês até o horizonte
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_generate_recurring_bills(p_months_ahead INTEGER DEFAULT 12)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER   -- roda com permissão de dono, ignora RLS
AS $$
DECLARE
  v_bill    RECORD;
  v_next    DATE;
  v_horizon DATE;
  v_latest  DATE;
  v_count   INTEGER := 0;
BEGIN
  v_horizon := (CURRENT_DATE + (p_months_ahead || ' months')::INTERVAL)::DATE;

  FOR v_bill IN
    SELECT * FROM bills
    WHERE recurrence != 'none'
      AND status NOT IN ('cancelled', 'paid')
      AND parent_bill_id IS NULL
      AND (recurrence_end IS NULL OR recurrence_end >= CURRENT_DATE)
  LOOP
    -- Encontra a data da ÚLTIMA ocorrência gerada (raiz ou filha)
    SELECT COALESCE(MAX(due_date), v_bill.due_date)
      INTO v_latest
      FROM bills
     WHERE (id = v_bill.id OR parent_bill_id = v_bill.id)
       AND status != 'cancelled';

    -- Percorre de v_latest em diante até o horizonte
    v_next := v_latest;
    LOOP
      v_next := CASE v_bill.recurrence
        WHEN 'monthly'    THEN (v_next + INTERVAL '1 month')::DATE
        WHEN 'weekly'     THEN (v_next + INTERVAL '1 week')::DATE
        WHEN 'quarterly'  THEN (v_next + INTERVAL '3 months')::DATE
        WHEN 'yearly'     THEN (v_next + INTERVAL '1 year')::DATE
        ELSE NULL
      END;

      EXIT WHEN v_next IS NULL;
      EXIT WHEN v_next > v_horizon;
      EXIT WHEN (v_bill.recurrence_end IS NOT NULL AND v_next > v_bill.recurrence_end);

      -- Só insere se ainda não existe
      IF NOT EXISTS (
        SELECT 1 FROM bills
         WHERE (id = v_bill.id OR parent_bill_id = v_bill.id)
           AND due_date = v_next
      ) THEN
        INSERT INTO bills (
          description, category, supplier, amount, due_date,
          recurrence, recurrence_end, parent_bill_id, notes, boleto_url
        ) VALUES (
          v_bill.description, v_bill.category, v_bill.supplier,
          v_bill.amount, v_next,
          v_bill.recurrence, v_bill.recurrence_end, v_bill.id,
          v_bill.notes, v_bill.boleto_url
        );
        v_count := v_count + 1;
      END IF;
    END LOOP;

  END LOOP;

  RETURN v_count;
END;
$$;

-- Garante que usuários autenticados podem chamar via RPC
GRANT EXECUTE ON FUNCTION fn_generate_recurring_bills(INTEGER) TO authenticated;


-- ------------------------------------------------------------
-- 2. Corrige RLS de clinic_settings para INSERT via upsert
--    A política FOR ALL sem WITH CHECK bloqueia novos rows
-- ------------------------------------------------------------
-- Remove policies existentes de clinic_settings
DROP POLICY IF EXISTS "Authenticated read clinic_settings"  ON clinic_settings;
DROP POLICY IF EXISTS "Authenticated manage clinic_settings" ON clinic_settings;

-- Recria separadas (SELECT + INSERT/UPDATE/DELETE) com WITH CHECK
CREATE POLICY "cs_select"
  ON clinic_settings FOR SELECT
  USING (auth.role() = 'authenticated');

CREATE POLICY "cs_insert"
  ON clinic_settings FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "cs_update"
  ON clinic_settings FOR UPDATE
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "cs_delete"
  ON clinic_settings FOR DELETE
  USING (auth.role() = 'authenticated');


-- ------------------------------------------------------------
-- 3. Gera ocorrências imediatas para os próximos 12 meses
--    (popula o banco para bills recorrentes já cadastradas)
-- ------------------------------------------------------------
SELECT fn_generate_recurring_bills(12);


-- Verificação
SELECT id, description, due_date, recurrence, parent_bill_id IS NOT NULL AS is_child
FROM bills
WHERE recurrence != 'none'
ORDER BY description, due_date
LIMIT 30;
