-- ============================================================
-- SintesIA — Core Financeiro: clinic_settings + bills + views
-- Executar no Supabase SQL Editor
-- ============================================================


-- ------------------------------------------------------------
-- 1. TABELA: clinic_settings
--    Configurações globais da clínica em formato chave/valor.
--    Flexível: novas configs não precisam de ALTER TABLE.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS clinic_settings (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  key         TEXT UNIQUE NOT NULL,
  value       JSONB NOT NULL,
  label       TEXT,           -- nome legível para a UI
  description TEXT,
  category    TEXT,           -- 'fiscal' | 'payment_fees' | 'general'
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_by  UUID
);

-- Índice para lookup por category
CREATE INDEX IF NOT EXISTS idx_clinic_settings_category ON clinic_settings(category);

-- Trigger updated_at
DROP TRIGGER IF EXISTS trg_clinic_settings_updated_at ON clinic_settings;
CREATE TRIGGER trg_clinic_settings_updated_at
  BEFORE UPDATE ON clinic_settings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- ------------------------------------------------------------
-- 2. SEED: configurações padrão da clínica
-- ------------------------------------------------------------
INSERT INTO clinic_settings (key, value, label, description, category) VALUES
  -- Regime fiscal
  ('tax_regime',         '"simples"',   'Regime Tributário',   'simples | lucro_presumido | lucro_real | mei', 'fiscal'),
  ('default_tax_pct',    '6.0',         'Alíquota padrão (%)', 'ISS ou alíquota do Simples sobre serviços',   'fiscal'),
  ('issqn_city',         '"Brasília"',  'Município ISSQN',     'Município para recolhimento do ISS',          'fiscal'),
  -- Taxas da maquininha
  ('fee_pix',            '0.0',         'Taxa PIX (%)',         'Taxa cobrada pela operadora no PIX',          'payment_fees'),
  ('fee_debit',          '1.5',         'Taxa Débito (%)',      'Taxa maquininha débito',                      'payment_fees'),
  ('fee_credit_1x',      '2.5',         'Taxa Crédito 1x (%)', 'Taxa maquininha crédito à vista',             'payment_fees'),
  ('fee_credit_2_6x',    '3.5',         'Taxa Crédito 2–6x (%)','Taxa maquininha crédito parcelado 2–6x',    'payment_fees'),
  ('fee_credit_7x_plus', '4.5',         'Taxa Crédito 7x+ (%)','Taxa maquininha crédito parcelado 7x+',      'payment_fees'),
  -- Geral
  ('clinic_name',        '"Minha Clínica"', 'Nome da Clínica',  'Nome exibido em recibos e relatórios',       'general'),
  ('default_commission_pct', '40.0',    'Comissão padrão (%)', 'Comissão padrão dos profissionais sobre rec. líquida', 'general'),
  ('retention_alert_days', '60',        'Alerta de retenção (dias)', 'Pacientes sem visita há X dias = em risco', 'general')
ON CONFLICT (key) DO NOTHING;


-- ------------------------------------------------------------
-- 3. ENUM: categoria de conta a pagar
-- ------------------------------------------------------------
DO $$ BEGIN
  CREATE TYPE bill_category_enum AS ENUM (
    'aluguel', 'salario', 'insumos', 'equipamentos', 'marketing',
    'servicos', 'impostos', 'manutencao', 'outros'
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE bill_status_enum AS ENUM ('pending', 'paid', 'overdue', 'cancelled');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE recurrence_enum AS ENUM ('none', 'daily', 'weekly', 'monthly', 'quarterly', 'yearly');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;


-- ------------------------------------------------------------
-- 4. TABELA: bills (contas a pagar)
--    Cobre despesas fixas recorrentes E compras avulsas.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bills (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Identificação
  description     TEXT NOT NULL,
  category        bill_category_enum NOT NULL DEFAULT 'outros',
  supplier        TEXT,              -- fornecedor / credor

  -- Valores
  amount          DECIMAL(10,2) NOT NULL,
  amount_paid     DECIMAL(10,2),     -- pode diferir (desconto, juros)

  -- Datas
  due_date        DATE NOT NULL,
  paid_at         TIMESTAMPTZ,
  competence_date DATE,              -- mês de competência (pode ≠ vencimento)

  -- Status e recorrência
  status          bill_status_enum NOT NULL DEFAULT 'pending',
  recurrence      recurrence_enum  NOT NULL DEFAULT 'none',
  recurrence_end  DATE,             -- até quando recorre (null = indefinido)
  parent_bill_id  UUID REFERENCES bills(id),  -- link para a conta-mãe recorrente

  -- Rastreabilidade
  payment_method  TEXT,             -- como foi pago
  bank_account    TEXT,             -- conta bancária usada
  document_number TEXT,             -- NF, boleto, nº contrato
  attachment_url  TEXT,             -- comprovante

  notes           TEXT,
  created_by      UUID,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_bills_due_date   ON bills(due_date);
CREATE INDEX IF NOT EXISTS idx_bills_status     ON bills(status);
CREATE INDEX IF NOT EXISTS idx_bills_category   ON bills(category);
CREATE INDEX IF NOT EXISTS idx_bills_parent     ON bills(parent_bill_id);

DROP TRIGGER IF EXISTS trg_bills_updated_at ON bills;
CREATE TRIGGER trg_bills_updated_at
  BEFORE UPDATE ON bills
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- ------------------------------------------------------------
-- 5. FUNÇÃO: auto-marca bills como overdue
--    Chamada por cron ou manualmente.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_mark_overdue_bills()
RETURNS INTEGER
LANGUAGE plpgsql AS $$
DECLARE v_count INTEGER;
BEGIN
  UPDATE bills
  SET status = 'overdue', updated_at = NOW()
  WHERE status = 'pending'
    AND due_date < CURRENT_DATE;
  GET DIAGNOSTICS v_count = ROW_COUNT;
  RETURN v_count;
END;
$$;

-- Para automatizar via pg_cron (se habilitado no Supabase):
-- SELECT cron.schedule('mark-overdue-bills', '0 1 * * *', 'SELECT fn_mark_overdue_bills()');


-- ------------------------------------------------------------
-- 6. FUNÇÃO: gera próximas ocorrências de bills recorrentes
--    Chame manualmente ou via cron mensal.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_generate_recurring_bills(p_months_ahead INTEGER DEFAULT 3)
RETURNS INTEGER
LANGUAGE plpgsql AS $$
DECLARE
  v_bill    RECORD;
  v_next    DATE;
  v_count   INTEGER := 0;
BEGIN
  FOR v_bill IN
    SELECT * FROM bills
    WHERE recurrence != 'none'
      AND status != 'cancelled'
      AND parent_bill_id IS NULL
      AND (recurrence_end IS NULL OR recurrence_end > CURRENT_DATE)
  LOOP
    -- Calcula próximo vencimento
    v_next := CASE v_bill.recurrence
      WHEN 'monthly'    THEN (v_bill.due_date + INTERVAL '1 month')::DATE
      WHEN 'weekly'     THEN (v_bill.due_date + INTERVAL '1 week')::DATE
      WHEN 'quarterly'  THEN (v_bill.due_date + INTERVAL '3 months')::DATE
      WHEN 'yearly'     THEN (v_bill.due_date + INTERVAL '1 year')::DATE
      ELSE NULL
    END;

    -- Só gera se ainda não existe e está dentro do horizonte
    IF v_next IS NOT NULL
      AND v_next <= (CURRENT_DATE + (p_months_ahead || ' months')::INTERVAL)
      AND NOT EXISTS (SELECT 1 FROM bills WHERE parent_bill_id = v_bill.id AND due_date = v_next)
    THEN
      INSERT INTO bills (
        description, category, supplier, amount, due_date,
        recurrence, recurrence_end, parent_bill_id, notes
      ) VALUES (
        v_bill.description, v_bill.category, v_bill.supplier, v_bill.amount, v_next,
        v_bill.recurrence, v_bill.recurrence_end, v_bill.id, v_bill.notes
      );
      v_count := v_count + 1;
    END IF;
  END LOOP;
  RETURN v_count;
END;
$$;


-- ------------------------------------------------------------
-- 7. VIEW: vw_cash_flow
--    Une payments (entradas) + bills (saídas) em linha do tempo.
--    É a fonte de verdade do fluxo de caixa.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_cash_flow AS

  -- ENTRADAS: pagamentos recebidos
  SELECT
    p.id,
    p.payment_date                          AS date,
    'income'                                AS flow_type,
    COALESCE(svc.name, 'Atendimento')       AS description,
    COALESCE(pat.name, '—')                 AS counterpart,   -- paciente
    p.amount                                AS gross_amount,
    p.real_profit                           AS net_amount,
    p.payment_method::TEXT                  AS payment_method,
    p.status::TEXT                          AS status,
    'atendimento'                           AS category,
    p.professional_id,
    p.service_id,
    p.patient_id,
    NULL::UUID                              AS bill_id,
    DATE_TRUNC('month', p.payment_date)     AS month,
    DATE_TRUNC('day',   p.payment_date)     AS day
  FROM payments p
  LEFT JOIN patients     pat ON pat.id = p.patient_id
  LEFT JOIN services     svc ON svc.id = p.service_id
  WHERE p.status = 'paid'

UNION ALL

  -- SAÍDAS: contas pagas
  SELECT
    b.id,
    b.paid_at                               AS date,
    'expense'                               AS flow_type,
    b.description,
    COALESCE(b.supplier, '—')               AS counterpart,
    COALESCE(b.amount_paid, b.amount)       AS gross_amount,
    -COALESCE(b.amount_paid, b.amount)      AS net_amount,  -- negativo para cálculo
    COALESCE(b.payment_method, '—')         AS payment_method,
    b.status::TEXT                          AS status,
    b.category::TEXT                        AS category,
    NULL::UUID                              AS professional_id,
    NULL::UUID                              AS service_id,
    NULL::UUID                              AS patient_id,
    b.id                                    AS bill_id,
    DATE_TRUNC('month', COALESCE(b.paid_at, b.due_date::TIMESTAMPTZ)) AS month,
    DATE_TRUNC('day',   COALESCE(b.paid_at, b.due_date::TIMESTAMPTZ)) AS day
  FROM bills b
  WHERE b.status = 'paid'

ORDER BY date DESC NULLS LAST;


-- ------------------------------------------------------------
-- 8. VIEW: vw_monthly_balance
--    Saldo mensal: receitas - despesas por mês.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_monthly_balance AS
SELECT
  DATE_TRUNC('month', date) AS month,
  SUM(CASE WHEN flow_type = 'income'  THEN gross_amount ELSE 0 END) AS total_income,
  SUM(CASE WHEN flow_type = 'expense' THEN gross_amount ELSE 0 END) AS total_expense,
  SUM(CASE WHEN flow_type = 'income'  THEN gross_amount ELSE 0 END) -
  SUM(CASE WHEN flow_type = 'expense' THEN gross_amount ELSE 0 END) AS net_balance,
  COUNT(CASE WHEN flow_type = 'income'  THEN 1 END) AS income_count,
  COUNT(CASE WHEN flow_type = 'expense' THEN 1 END) AS expense_count
FROM vw_cash_flow
GROUP BY DATE_TRUNC('month', date)
ORDER BY month DESC;


-- ------------------------------------------------------------
-- 9. VIEW: vw_bills_upcoming
--    Contas a pagar nos próximos 30 dias + vencidas.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_bills_upcoming AS
SELECT
  *,
  (due_date - CURRENT_DATE) AS days_until_due,
  CASE
    WHEN due_date < CURRENT_DATE AND status = 'pending' THEN 'overdue'
    WHEN due_date = CURRENT_DATE THEN 'due_today'
    WHEN due_date <= CURRENT_DATE + 7  THEN 'due_week'
    WHEN due_date <= CURRENT_DATE + 30 THEN 'due_month'
    ELSE 'future'
  END AS urgency
FROM bills
WHERE status IN ('pending', 'overdue')
ORDER BY due_date ASC;


-- ------------------------------------------------------------
-- 10. RLS
-- ------------------------------------------------------------
ALTER TABLE clinic_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE bills           ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated read clinic_settings"
  ON clinic_settings FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated manage clinic_settings"
  ON clinic_settings FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated read bills"
  ON bills FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated manage bills"
  ON bills FOR ALL USING (auth.role() = 'authenticated');


-- ------------------------------------------------------------
-- ✅ VERIFICAÇÃO
-- SELECT key, value, label, category FROM clinic_settings ORDER BY category, key;
-- SELECT * FROM vw_bills_upcoming LIMIT 10;
-- SELECT * FROM vw_monthly_balance LIMIT 12;
-- SELECT * FROM vw_cash_flow LIMIT 20;
-- ------------------------------------------------------------
