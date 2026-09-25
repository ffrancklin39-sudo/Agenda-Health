-- ============================================================
-- SintesIA — Módulo Contas Bancárias
-- Executar no Supabase SQL Editor
-- ============================================================


-- ------------------------------------------------------------
-- 0. PRÉ-REQUISITO: bank_account em payments (pode não existir)
-- ------------------------------------------------------------
ALTER TABLE payments ADD COLUMN IF NOT EXISTS bank_account TEXT;


-- ------------------------------------------------------------
-- 1. TABELA: bank_accounts
--    Cadastro de contas bancárias / caixas da clínica
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bank_accounts (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name            TEXT NOT NULL,          -- "Nubank Clínica", "Caixa Bradesco"
  bank            TEXT,                   -- nome do banco/instituição
  type            TEXT NOT NULL DEFAULT 'checking',
                                          -- 'checking' | 'savings' | 'cash' | 'investment'
  initial_balance DECIMAL(12,2) NOT NULL DEFAULT 0,
  color           TEXT NOT NULL DEFAULT '#6366f1',  -- hex para distinção visual
  notes           TEXT,
  is_active       BOOLEAN NOT NULL DEFAULT true,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Trigger updated_at
DROP TRIGGER IF EXISTS trg_bank_accounts_updated_at ON bank_accounts;
CREATE TRIGGER trg_bank_accounts_updated_at
  BEFORE UPDATE ON bank_accounts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- ------------------------------------------------------------
-- 2. VIEW: vw_bank_account_balances
--    Calcula saldo atual = saldo_inicial + entradas - saídas
--    Cruza pelo campo TEXT bank_account em payments e bills
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_bank_account_balances AS
SELECT
  ba.id,
  ba.name,
  ba.bank,
  ba.type,
  ba.color,
  ba.notes,
  ba.is_active,
  ba.initial_balance,
  COALESCE(inc.total, 0)                                          AS total_income,
  COALESCE(exp.total, 0)                                          AS total_expenses,
  ba.initial_balance
    + COALESCE(inc.total, 0)
    - COALESCE(exp.total, 0)                                      AS current_balance,
  COALESCE(inc.tx_count, 0)                                       AS income_count,
  COALESCE(exp.tx_count, 0)                                       AS expense_count
FROM bank_accounts ba

-- Entradas: pagamentos recebidos nesta conta
LEFT JOIN (
  SELECT
    bank_account,
    SUM(amount)   AS total,
    COUNT(*)      AS tx_count
  FROM payments
  WHERE status = 'paid'
    AND bank_account IS NOT NULL
    AND bank_account <> ''
  GROUP BY bank_account
) inc ON inc.bank_account = ba.name

-- Saídas: contas pagas desta conta
LEFT JOIN (
  SELECT
    bank_account,
    SUM(COALESCE(amount_paid, amount)) AS total,
    COUNT(*) AS tx_count
  FROM bills
  WHERE status = 'paid'
    AND bank_account IS NOT NULL
    AND bank_account <> ''
  GROUP BY bank_account
) exp ON exp.bank_account = ba.name

ORDER BY ba.name;


-- ------------------------------------------------------------
-- 3. RLS
-- ------------------------------------------------------------
ALTER TABLE bank_accounts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ba_select" ON bank_accounts
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "ba_insert" ON bank_accounts
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "ba_update" ON bank_accounts
  FOR UPDATE USING (auth.role() = 'authenticated')
             WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "ba_delete" ON bank_accounts
  FOR DELETE USING (auth.role() = 'authenticated');


-- ------------------------------------------------------------
-- ✅ VERIFICAÇÃO
-- SELECT * FROM vw_bank_account_balances;
-- SELECT * FROM bank_accounts;
-- ------------------------------------------------------------
