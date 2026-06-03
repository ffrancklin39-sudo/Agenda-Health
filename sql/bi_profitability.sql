-- ============================================================
-- SintesIA — Módulo BI: Lucratividade Real por Procedimento
-- Executar no Supabase SQL Editor
-- ============================================================

-- ------------------------------------------------------------
-- 1. TABELA: procedures_pricing
--    Estende os serviços da clínica com dados de custo/margem
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS procedures_pricing (
  id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  service_id              UUID REFERENCES services(id) ON DELETE CASCADE,

  -- Precificação
  base_price              DECIMAL(10,2) NOT NULL DEFAULT 0,
  fixed_cost              DECIMAL(10,2) NOT NULL DEFAULT 0,   -- insumos/materiais
  estimated_duration_minutes INTEGER NOT NULL DEFAULT 30,

  -- Taxas e comissões
  tax_percentage          DECIMAL(5,2)  NOT NULL DEFAULT 0,   -- ISS, DAS, etc.
  commission_percentage   DECIMAL(5,2)  NOT NULL DEFAULT 0,   -- comissão do profissional

  -- Taxas por forma de pagamento (%)
  fee_pix                 DECIMAL(5,2)  NOT NULL DEFAULT 0,
  fee_debit               DECIMAL(5,2)  NOT NULL DEFAULT 1.5,
  fee_credit_1x           DECIMAL(5,2)  NOT NULL DEFAULT 2.5,
  fee_credit_2_6x         DECIMAL(5,2)  NOT NULL DEFAULT 3.5,
  fee_credit_7x_plus      DECIMAL(5,2)  NOT NULL DEFAULT 4.5,

  -- Metadata
  active                  BOOLEAN NOT NULL DEFAULT TRUE,
  notes                   TEXT,
  created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Índice para lookup por serviço
CREATE INDEX IF NOT EXISTS idx_procedures_pricing_service_id
  ON procedures_pricing(service_id);

-- Trigger para updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_procedures_pricing_updated_at ON procedures_pricing;
CREATE TRIGGER trg_procedures_pricing_updated_at
  BEFORE UPDATE ON procedures_pricing
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- ------------------------------------------------------------
-- 2. FUNÇÃO: calculate_procedure_profit
--    Calcula a lucratividade de um procedimento dado o método
--    de pagamento. Retorna um JSONB com todos os valores.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION calculate_procedure_profit(
  p_base_price            DECIMAL,
  p_fixed_cost            DECIMAL,
  p_tax_percentage        DECIMAL,
  p_commission_percentage DECIMAL,
  p_payment_fee           DECIMAL  -- taxa do cartão/pix (%)
)
RETURNS JSONB
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  v_tax_amount        DECIMAL;
  v_payment_fee_amount DECIMAL;
  v_net_revenue       DECIMAL;
  v_commission_amount DECIMAL;
  v_real_profit       DECIMAL;
  v_margin_pct        DECIMAL;
BEGIN
  -- Passo 1: Impostos sobre preço bruto
  v_tax_amount        := p_base_price * (p_tax_percentage / 100.0);

  -- Passo 2: Taxa do meio de pagamento sobre preço bruto
  v_payment_fee_amount := p_base_price * (p_payment_fee / 100.0);

  -- Passo 3: Receita Líquida (base para comissão)
  v_net_revenue       := p_base_price - v_tax_amount - v_payment_fee_amount;

  -- Passo 4: Comissão calculada sobre receita líquida (não sobre bruto!)
  v_commission_amount := v_net_revenue * (p_commission_percentage / 100.0);

  -- Passo 5: Lucro Real da Clínica
  v_real_profit       := v_net_revenue - p_fixed_cost - v_commission_amount;

  -- Passo 6: Margem %
  v_margin_pct        := CASE
    WHEN p_base_price > 0 THEN (v_real_profit / p_base_price) * 100.0
    ELSE 0
  END;

  RETURN jsonb_build_object(
    'base_price',           ROUND(p_base_price, 2),
    'tax_amount',           ROUND(v_tax_amount, 2),
    'payment_fee_amount',   ROUND(v_payment_fee_amount, 2),
    'net_revenue',          ROUND(v_net_revenue, 2),
    'commission_amount',    ROUND(v_commission_amount, 2),
    'fixed_cost',           ROUND(p_fixed_cost, 2),
    'real_profit',          ROUND(v_real_profit, 2),
    'margin_percentage',    ROUND(v_margin_pct, 2)
  );
END;
$$;


-- ------------------------------------------------------------
-- 3. VIEW: vw_procedure_profitability
--    Ranking de procedimentos por margem de lucro real.
--    Usa PIX como método de pagamento padrão para comparação.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_procedure_profitability AS
SELECT
  pp.id,
  pp.service_id,
  s.name                          AS service_name,
  s.category                      AS service_category,
  pp.base_price,
  pp.fixed_cost,
  pp.tax_percentage,
  pp.commission_percentage,
  pp.estimated_duration_minutes,

  -- Lucratividade por método de pagamento (cenários)
  calculate_procedure_profit(
    pp.base_price, pp.fixed_cost, pp.tax_percentage,
    pp.commission_percentage, pp.fee_pix
  ) AS profit_pix,

  calculate_procedure_profit(
    pp.base_price, pp.fixed_cost, pp.tax_percentage,
    pp.commission_percentage, pp.fee_debit
  ) AS profit_debit,

  calculate_procedure_profit(
    pp.base_price, pp.fixed_cost, pp.tax_percentage,
    pp.commission_percentage, pp.fee_credit_1x
  ) AS profit_credit_1x,

  calculate_procedure_profit(
    pp.base_price, pp.fixed_cost, pp.tax_percentage,
    pp.commission_percentage, pp.fee_credit_2_6x
  ) AS profit_credit_2_6x,

  -- Margem "real" padrão (pix) para ranking
  ROUND(
    (
      calculate_procedure_profit(
        pp.base_price, pp.fixed_cost, pp.tax_percentage,
        pp.commission_percentage, pp.fee_pix
      )->>'margin_percentage'
    )::DECIMAL, 2
  ) AS margin_pct_pix,

  -- Receita por minuto (eficiência de agenda)
  CASE
    WHEN pp.estimated_duration_minutes > 0 THEN
      ROUND(
        (
          (calculate_procedure_profit(
            pp.base_price, pp.fixed_cost, pp.tax_percentage,
            pp.commission_percentage, pp.fee_pix
          )->>'real_profit')::DECIMAL
        ) / pp.estimated_duration_minutes, 2
      )
    ELSE 0
  END AS profit_per_minute,

  pp.active,
  pp.notes,
  pp.created_at,
  pp.updated_at

FROM procedures_pricing pp
LEFT JOIN services s ON s.id = pp.service_id
WHERE pp.active = TRUE
ORDER BY margin_pct_pix DESC;


-- ------------------------------------------------------------
-- 4. RLS (Row Level Security)
-- ------------------------------------------------------------
ALTER TABLE procedures_pricing ENABLE ROW LEVEL SECURITY;

-- Leitura: qualquer usuário autenticado da clínica
CREATE POLICY "Authenticated users can read procedures_pricing"
  ON procedures_pricing FOR SELECT
  USING (auth.role() = 'authenticated');

-- Escrita: apenas admin/manager (ajuste o campo conforme seu perfil de usuário)
CREATE POLICY "Admins can manage procedures_pricing"
  ON procedures_pricing FOR ALL
  USING (auth.role() = 'authenticated');
  -- Para restringir a admins, substitua por:
  -- USING (EXISTS (
  --   SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'manager')
  -- ));


-- ------------------------------------------------------------
-- 5. DADOS DE EXEMPLO (opcional — remova antes de produção)
-- ------------------------------------------------------------
-- INSERT INTO procedures_pricing (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage)
-- VALUES
--   ('<uuid-do-servico-1>', 250.00, 15.00, 60, 6.0, 40.0),
--   ('<uuid-do-servico-2>', 180.00, 8.00,  30, 6.0, 35.0),
--   ('<uuid-do-servico-3>', 450.00, 60.00, 90, 6.0, 45.0);
