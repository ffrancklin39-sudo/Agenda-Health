-- ============================================================
-- SintesIA — Pagamentos Reais + Comissões Automáticas
-- Executar no Supabase SQL Editor
-- ============================================================
-- Este script fecha os buracos de automação:
--   ✓ Captura método de pagamento real (pix/débito/crédito)
--   ✓ Usa valor efetivamente pago (não o tabelado)
--   ✓ Calcula comissão automaticamente via trigger
--   ✓ Rastreia pagamento de comissão ao profissional
--   ✓ Views atualizadas para usar dados reais
-- ============================================================


-- ------------------------------------------------------------
-- 0. ENUM: método de pagamento
-- ------------------------------------------------------------
DO $$ BEGIN
  CREATE TYPE payment_method_enum AS ENUM (
    'pix', 'debit', 'credit_1x', 'credit_2_6x', 'credit_7x_plus', 'cash', 'transfer', 'check'
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE payment_status_enum AS ENUM ('pending', 'paid', 'refunded', 'cancelled');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE commission_status_enum AS ENUM ('pending', 'paid', 'cancelled');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;


-- ------------------------------------------------------------
-- 1. TABELA: payments
--    Registro real de cada transação financeira.
--    Uma consulta pode ter múltiplos pagamentos (ex: parcelado).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS payments (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Vínculos
  patient_id            UUID REFERENCES patients(id) ON DELETE SET NULL,
  appointment_id        UUID,  -- referência futura à tabela appointments
  professional_id       UUID REFERENCES professionals(id) ON DELETE SET NULL,
  service_id            UUID REFERENCES services(id) ON DELETE SET NULL,

  -- Valor real cobrado
  amount                DECIMAL(10,2) NOT NULL,
  payment_method        payment_method_enum NOT NULL DEFAULT 'pix',
  status                payment_status_enum NOT NULL DEFAULT 'pending',
  payment_date          TIMESTAMPTZ,  -- data/hora efetiva do pagamento
  due_date              TIMESTAMPTZ,  -- vencimento (para parcelas futuras)

  -- Campos calculados (preenchidos pelo trigger)
  payment_fee_pct       DECIMAL(5,2),   -- taxa do método de pgto (%)
  payment_fee_amount    DECIMAL(10,2),  -- valor da taxa
  tax_pct               DECIMAL(5,2),   -- imposto (%)
  tax_amount            DECIMAL(10,2),  -- valor do imposto
  net_revenue           DECIMAL(10,2),  -- amount - fee - tax
  commission_pct        DECIMAL(5,2),   -- % comissão do profissional
  commission_amount     DECIMAL(10,2),  -- valor comissão (calculado sobre net_revenue)
  fixed_cost            DECIMAL(10,2),  -- custo de insumos do procedimento
  real_profit           DECIMAL(10,2),  -- net_revenue - fixed_cost - commission_amount
  margin_pct            DECIMAL(5,2),   -- real_profit / amount * 100

  -- Origem da precificação usada no cálculo
  pricing_source        TEXT DEFAULT 'procedures_pricing',  -- ou 'default'

  notes                 TEXT,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_payments_patient_id      ON payments(patient_id);
CREATE INDEX IF NOT EXISTS idx_payments_professional_id ON payments(professional_id);
CREATE INDEX IF NOT EXISTS idx_payments_service_id      ON payments(service_id);
CREATE INDEX IF NOT EXISTS idx_payments_payment_date    ON payments(payment_date);
CREATE INDEX IF NOT EXISTS idx_payments_status          ON payments(status);

DROP TRIGGER IF EXISTS trg_payments_updated_at ON payments;
CREATE TRIGGER trg_payments_updated_at
  BEFORE UPDATE ON payments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- ------------------------------------------------------------
-- 2. TABELA: commission_ledger
--    Rastreia cada comissão gerada e seu status de pagamento.
--    Preenchida automaticamente pelo trigger abaixo.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS commission_ledger (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  payment_id            UUID REFERENCES payments(id) ON DELETE CASCADE,
  professional_id       UUID REFERENCES professionals(id) ON DELETE SET NULL,
  patient_id            UUID REFERENCES patients(id) ON DELETE SET NULL,
  service_id            UUID REFERENCES services(id) ON DELETE SET NULL,

  -- Detalhes do cálculo
  gross_amount          DECIMAL(10,2) NOT NULL,
  net_revenue           DECIMAL(10,2) NOT NULL,
  commission_pct        DECIMAL(5,2)  NOT NULL,
  commission_amount     DECIMAL(10,2) NOT NULL,
  payment_method        payment_method_enum,
  payment_date          TIMESTAMPTZ,

  -- Controle de pagamento ao profissional
  status                commission_status_enum NOT NULL DEFAULT 'pending',
  paid_at               TIMESTAMPTZ,
  paid_by               UUID,  -- usuário que confirmou o pagamento
  payment_reference     TEXT,  -- nº de transferência, comprovante, etc.

  notes                 TEXT,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_commission_ledger_professional ON commission_ledger(professional_id);
CREATE INDEX IF NOT EXISTS idx_commission_ledger_payment      ON commission_ledger(payment_id);
CREATE INDEX IF NOT EXISTS idx_commission_ledger_status       ON commission_ledger(status);
CREATE INDEX IF NOT EXISTS idx_commission_ledger_date         ON commission_ledger(payment_date);

DROP TRIGGER IF EXISTS trg_commission_ledger_updated_at ON commission_ledger;
CREATE TRIGGER trg_commission_ledger_updated_at
  BEFORE UPDATE ON commission_ledger
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- ------------------------------------------------------------
-- 3. FUNÇÃO AUXILIAR: busca taxa do método de pagamento
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_payment_fee_pct(
  p_service_id UUID,
  p_method     payment_method_enum
)
RETURNS DECIMAL
LANGUAGE plpgsql STABLE AS $$
DECLARE
  v_fee DECIMAL := 0;
BEGIN
  SELECT
    CASE p_method
      WHEN 'pix'           THEN fee_pix
      WHEN 'debit'         THEN fee_debit
      WHEN 'credit_1x'     THEN fee_credit_1x
      WHEN 'credit_2_6x'   THEN fee_credit_2_6x
      WHEN 'credit_7x_plus'THEN fee_credit_7x_plus
      ELSE 0
    END
  INTO v_fee
  FROM procedures_pricing
  WHERE service_id = p_service_id AND active = TRUE
  LIMIT 1;

  RETURN COALESCE(v_fee, 0);
END;
$$;


-- ------------------------------------------------------------
-- 4. TRIGGER: auto-calcula lucro e comissão ao inserir pagamento
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_auto_calculate_payment()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
DECLARE
  v_pricing        RECORD;
  v_fee_pct        DECIMAL := 0;
  v_tax_pct        DECIMAL := 6;    -- padrão ISS
  v_comm_pct       DECIMAL := 40;   -- padrão comissão
  v_fixed_cost     DECIMAL := 0;
  v_fee_amount     DECIMAL;
  v_tax_amount     DECIMAL;
  v_net_revenue    DECIMAL;
  v_commission     DECIMAL;
  v_real_profit    DECIMAL;
  v_margin         DECIMAL;
  v_source         TEXT := 'default';
BEGIN
  -- Busca precificação do serviço
  SELECT * INTO v_pricing
  FROM procedures_pricing
  WHERE service_id = NEW.service_id AND active = TRUE
  LIMIT 1;

  IF FOUND THEN
    v_tax_pct    := v_pricing.tax_percentage;
    v_comm_pct   := v_pricing.commission_percentage;
    v_fixed_cost := v_pricing.fixed_cost;
    v_source     := 'procedures_pricing';

    -- Taxa do método de pagamento
    v_fee_pct := CASE NEW.payment_method
      WHEN 'pix'            THEN v_pricing.fee_pix
      WHEN 'debit'          THEN v_pricing.fee_debit
      WHEN 'credit_1x'      THEN v_pricing.fee_credit_1x
      WHEN 'credit_2_6x'    THEN v_pricing.fee_credit_2_6x
      WHEN 'credit_7x_plus' THEN v_pricing.fee_credit_7x_plus
      ELSE 0
    END;
  ELSE
    -- Sem precificação: usa taxas padrão conservadoras
    v_fee_pct := CASE NEW.payment_method
      WHEN 'pix'            THEN 0
      WHEN 'debit'          THEN 1.5
      WHEN 'credit_1x'      THEN 2.5
      WHEN 'credit_2_6x'    THEN 3.5
      WHEN 'credit_7x_plus' THEN 4.5
      ELSE 0
    END;
  END IF;

  -- Cálculos
  v_fee_amount  := NEW.amount * (v_fee_pct  / 100.0);
  v_tax_amount  := NEW.amount * (v_tax_pct  / 100.0);
  v_net_revenue := NEW.amount - v_fee_amount - v_tax_amount;
  v_commission  := v_net_revenue * (v_comm_pct / 100.0);
  v_real_profit := v_net_revenue - v_fixed_cost - v_commission;
  v_margin      := CASE WHEN NEW.amount > 0
                     THEN ROUND((v_real_profit / NEW.amount) * 100, 2)
                     ELSE 0 END;

  -- Preenche os campos calculados
  NEW.payment_fee_pct    := v_fee_pct;
  NEW.payment_fee_amount := ROUND(v_fee_amount, 2);
  NEW.tax_pct            := v_tax_pct;
  NEW.tax_amount         := ROUND(v_tax_amount, 2);
  NEW.net_revenue        := ROUND(v_net_revenue, 2);
  NEW.commission_pct     := v_comm_pct;
  NEW.commission_amount  := ROUND(v_commission, 2);
  NEW.fixed_cost         := ROUND(v_fixed_cost, 2);
  NEW.real_profit        := ROUND(v_real_profit, 2);
  NEW.margin_pct         := v_margin;
  NEW.pricing_source     := v_source;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_auto_calculate_payment ON payments;
CREATE TRIGGER trg_auto_calculate_payment
  BEFORE INSERT OR UPDATE OF amount, payment_method, service_id
  ON payments
  FOR EACH ROW EXECUTE FUNCTION fn_auto_calculate_payment();


-- ------------------------------------------------------------
-- 5. TRIGGER: cria entrada no commission_ledger quando
--    um pagamento é marcado como 'paid'
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_create_commission_entry()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
  -- Só age quando status muda para 'paid'
  IF NEW.status = 'paid' AND (OLD.status IS DISTINCT FROM 'paid') THEN

    -- Evita duplicata
    IF NOT EXISTS (SELECT 1 FROM commission_ledger WHERE payment_id = NEW.id) THEN
      INSERT INTO commission_ledger (
        payment_id, professional_id, patient_id, service_id,
        gross_amount, net_revenue, commission_pct, commission_amount,
        payment_method, payment_date, status
      ) VALUES (
        NEW.id,
        NEW.professional_id,
        NEW.patient_id,
        NEW.service_id,
        NEW.amount,
        COALESCE(NEW.net_revenue, NEW.amount * 0.88),  -- fallback
        COALESCE(NEW.commission_pct, 40),
        COALESCE(NEW.commission_amount, NEW.amount * 0.88 * 0.40),
        NEW.payment_method,
        COALESCE(NEW.payment_date, NOW()),
        'pending'
      );
    END IF;

  END IF;

  -- Se pagamento for cancelado/estornado, cancela a comissão pendente
  IF NEW.status IN ('cancelled', 'refunded') AND OLD.status = 'paid' THEN
    UPDATE commission_ledger
    SET status = 'cancelled', updated_at = NOW()
    WHERE payment_id = NEW.id AND status = 'pending';
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_create_commission_entry ON payments;
CREATE TRIGGER trg_create_commission_entry
  AFTER UPDATE OF status ON payments
  FOR EACH ROW EXECUTE FUNCTION fn_create_commission_entry();

-- Também dispara no INSERT direto com status 'paid'
CREATE OR REPLACE FUNCTION fn_create_commission_on_insert()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.status = 'paid' THEN
    INSERT INTO commission_ledger (
      payment_id, professional_id, patient_id, service_id,
      gross_amount, net_revenue, commission_pct, commission_amount,
      payment_method, payment_date, status
    ) VALUES (
      NEW.id, NEW.professional_id, NEW.patient_id, NEW.service_id,
      NEW.amount, COALESCE(NEW.net_revenue, NEW.amount * 0.88),
      COALESCE(NEW.commission_pct, 40),
      COALESCE(NEW.commission_amount, NEW.amount * 0.88 * 0.40),
      NEW.payment_method, COALESCE(NEW.payment_date, NOW()), 'pending'
    );
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_create_commission_on_insert ON payments;
CREATE TRIGGER trg_create_commission_on_insert
  AFTER INSERT ON payments
  FOR EACH ROW EXECUTE FUNCTION fn_create_commission_on_insert();


-- ------------------------------------------------------------
-- 6. VIEW: vw_payments_full
--    Payments enriquecido com nome do paciente, profissional e serviço.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_payments_full AS
SELECT
  p.id,
  p.patient_id,
  pat.name                   AS patient_name,
  p.professional_id,
  prof.name                  AS professional_name,
  prof.specialty             AS professional_specialty,
  p.service_id,
  svc.name                   AS service_name,
  svc.category               AS service_category,
  p.amount,
  p.payment_method,
  p.status,
  p.payment_date,
  p.due_date,
  p.payment_fee_pct,
  p.payment_fee_amount,
  p.tax_pct,
  p.tax_amount,
  p.net_revenue,
  p.commission_pct,
  p.commission_amount,
  p.fixed_cost,
  p.real_profit,
  p.margin_pct,
  p.pricing_source,
  p.notes,
  p.created_at
FROM payments p
LEFT JOIN patients      pat  ON pat.id  = p.patient_id
LEFT JOIN professionals prof ON prof.id = p.professional_id
LEFT JOIN services      svc  ON svc.id  = p.service_id;


-- ------------------------------------------------------------
-- 7. VIEW: vw_commission_summary
--    Resumo de comissões por profissional, mês e status.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_commission_summary AS
SELECT
  cl.professional_id,
  prof.name                          AS professional_name,
  prof.specialty,
  prof.color,
  DATE_TRUNC('month', cl.payment_date) AS month,
  COUNT(*)                           AS transaction_count,
  SUM(cl.gross_amount)               AS gross_revenue,
  SUM(cl.net_revenue)                AS net_revenue,
  SUM(cl.commission_amount)          AS commission_due,
  SUM(CASE WHEN cl.status = 'paid' THEN cl.commission_amount ELSE 0 END) AS commission_paid,
  SUM(CASE WHEN cl.status = 'pending' THEN cl.commission_amount ELSE 0 END) AS commission_pending,
  cl.status
FROM commission_ledger cl
LEFT JOIN professionals prof ON prof.id = cl.professional_id
GROUP BY
  cl.professional_id, prof.name, prof.specialty, prof.color,
  DATE_TRUNC('month', cl.payment_date), cl.status
ORDER BY month DESC, commission_due DESC;


-- ------------------------------------------------------------
-- 8. VIEW: vw_dre_monthly
--    DRE mensal automático — sem nenhum input manual.
--    Basta registrar pagamentos que o DRE se atualiza sozinho.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_dre_monthly AS
SELECT
  DATE_TRUNC('month', payment_date)  AS month,
  COUNT(*)                           AS transactions,
  SUM(amount)                        AS gross_revenue,
  SUM(tax_amount)                    AS total_tax,
  SUM(payment_fee_amount)            AS total_payment_fees,
  SUM(net_revenue)                   AS net_revenue,
  SUM(fixed_cost)                    AS total_fixed_costs,
  SUM(commission_amount)             AS total_commissions,
  SUM(real_profit)                   AS net_profit,
  ROUND(
    CASE WHEN SUM(amount) > 0
      THEN SUM(real_profit) / SUM(amount) * 100
      ELSE 0
    END, 2
  )                                  AS margin_pct,
  ROUND(SUM(amount) / COUNT(*), 2)   AS avg_ticket
FROM payments
WHERE status = 'paid'
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY month DESC;


-- ------------------------------------------------------------
-- 9. VIEW: vw_revenue_by_service
--    Receita e margem por serviço — 100% automático.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_revenue_by_service AS
SELECT
  p.service_id,
  svc.name                          AS service_name,
  svc.category                      AS service_category,
  COUNT(*)                          AS transaction_count,
  SUM(p.amount)                     AS gross_revenue,
  SUM(p.tax_amount)                 AS total_tax,
  SUM(p.payment_fee_amount)         AS total_fees,
  SUM(p.fixed_cost)                 AS total_fixed_costs,
  SUM(p.commission_amount)          AS total_commissions,
  SUM(p.net_revenue)                AS net_revenue,
  SUM(p.real_profit)                AS net_profit,
  ROUND(AVG(p.margin_pct), 2)       AS avg_margin_pct,
  ROUND(SUM(p.amount) / COUNT(*), 2) AS avg_ticket,
  ROUND(SUM(p.real_profit) / COUNT(*), 2) AS avg_profit_per_transaction
FROM payments p
LEFT JOIN services svc ON svc.id = p.service_id
WHERE p.status = 'paid'
GROUP BY p.service_id, svc.name, svc.category
ORDER BY net_profit DESC;


-- ------------------------------------------------------------
-- 10. RLS
-- ------------------------------------------------------------
ALTER TABLE payments          ENABLE ROW LEVEL SECURITY;
ALTER TABLE commission_ledger ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated read payments"
  ON payments FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated manage payments"
  ON payments FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated read commission_ledger"
  ON commission_ledger FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Authenticated manage commission_ledger"
  ON commission_ledger FOR ALL USING (auth.role() = 'authenticated');


-- ------------------------------------------------------------
-- ✅ VERIFICAÇÃO PÓS-EXECUÇÃO
-- Rode essas queries para confirmar que está tudo funcionando:
-- ------------------------------------------------------------

-- Testa o trigger (substitua pelos IDs reais):
-- INSERT INTO payments (patient_id, professional_id, service_id, amount, payment_method, status, payment_date)
-- VALUES (
--   '<patient-uuid>',
--   '<professional-uuid>',
--   '<service-uuid>',
--   250.00,
--   'credit_1x',
--   'paid',
--   NOW()
-- );
-- SELECT * FROM vw_payments_full ORDER BY created_at DESC LIMIT 1;
-- SELECT * FROM commission_ledger ORDER BY created_at DESC LIMIT 1;
-- SELECT * FROM vw_dre_monthly;
-- SELECT * FROM vw_revenue_by_service;
-- SELECT * FROM vw_commission_summary;
