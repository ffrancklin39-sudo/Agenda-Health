-- contracts.sql
-- Módulo de Contratos — Candia Saúde e Bem-Estar
-- Execute no Supabase SQL Editor
--
-- Gera contratos de prestação de serviços automaticamente:
-- dados do paciente puxados do cadastro, serviços selecionados,
-- descrição do tratamento gerada pelo Gemini, PDF exportável.

-- ─── 1. Tabela principal ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS contracts (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id            UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  professional_id       UUID REFERENCES professionals(id) ON DELETE SET NULL,

  -- Descrição do tratamento (gerada pelo Gemini)
  treatment_description TEXT,

  -- Condições financeiras
  total_amount          NUMERIC(10,2) NOT NULL DEFAULT 0,
  payment_method        TEXT,          -- mesmo enum do payments: pix, credit_1x, etc.
  installments          INT DEFAULT 1, -- número de parcelas
  installment_value     NUMERIC(10,2), -- valor de cada parcela
  down_payment          NUMERIC(10,2), -- entrada (quando houver)
  payment_notes         TEXT,          -- campo livre: "12x de R$598 no cartão"

  -- Datas
  start_date            DATE,
  end_date              DATE,
  signed_at             TIMESTAMPTZ,   -- quando o contrato foi assinado/finalizado

  -- Status: draft → active → signed → cancelled
  status                TEXT NOT NULL DEFAULT 'draft'
                        CHECK (status IN ('draft','active','signed','cancelled')),

  -- PDF gerado (URL pública no Supabase Storage, opcional)
  pdf_url               TEXT,

  notes                 TEXT,
  created_by            UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE contracts IS 'Contratos de prestação de serviços gerados automaticamente a partir do cadastro do paciente';
COMMENT ON COLUMN contracts.treatment_description IS 'Parágrafo descritivo do tratamento gerado pelo Gemini com base nos itens selecionados';
COMMENT ON COLUMN contracts.payment_notes IS 'Campo livre para descrever condições especiais de pagamento (ex: 12x de R$598 no cartão)';
COMMENT ON COLUMN contracts.status IS 'draft=rascunho, active=contrato ativo, signed=assinado, cancelled=cancelado';

-- ─── 2. Itens do contrato (serviços/pacotes contratados) ────────────────────
CREATE TABLE IF NOT EXISTS contract_items (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  contract_id   UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
  service_id    UUID REFERENCES services(id) ON DELETE SET NULL,

  -- Snapshot do serviço no momento do contrato (não depender de JOIN p/ histórico)
  description   TEXT NOT NULL,   -- nome/descrição do item (ex: "5S - 90 dias com acompanhamento nutricional")
  sessions      INT,             -- número de sessões incluídas (quando aplicável)
  unit_price    NUMERIC(10,2),
  quantity      INT DEFAULT 1,
  subtotal      NUMERIC(10,2),   -- unit_price * quantity
  notes         TEXT,            -- obs do item (ex: "15 em 15 dias + suporte diário online")

  sort_order    INT DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE contract_items IS 'Itens (serviços/pacotes) que compõem o contrato — snapshot no momento da criação';

-- ─── 3. Índices ─────────────────────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_contracts_patient   ON contracts(patient_id);
CREATE INDEX IF NOT EXISTS idx_contracts_status    ON contracts(status);
CREATE INDEX IF NOT EXISTS idx_contract_items_cont ON contract_items(contract_id);

-- ─── 4. Trigger updated_at ──────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_contracts_updated_at ON contracts;
CREATE TRIGGER trg_contracts_updated_at
  BEFORE UPDATE ON contracts
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- ─── 5. View útil para listagem ─────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_contracts_full AS
SELECT
  c.id,
  c.status,
  c.total_amount,
  c.payment_method,
  c.payment_notes,
  c.installments,
  c.installment_value,
  c.down_payment,
  c.start_date,
  c.end_date,
  c.signed_at,
  c.treatment_description,
  c.pdf_url,
  c.notes,
  c.created_at,
  -- Paciente
  p.name        AS patient_name,
  p.cpf         AS patient_cpf,
  p.phone       AS patient_phone,
  p.email       AS patient_email,
  p.birth_date  AS patient_birth_date,
  p.address     AS patient_address,
  p.address_number,
  p.neighborhood,
  p.city        AS patient_city,
  p.state       AS patient_state,
  p.zip_code    AS patient_zip,
  -- Profissional
  pr.name       AS professional_name
FROM contracts c
JOIN patients p ON p.id = c.patient_id
LEFT JOIN professionals pr ON pr.id = c.professional_id;

-- ─── 6. RLS ─────────────────────────────────────────────────────────────────
ALTER TABLE contracts      ENABLE ROW LEVEL SECURITY;
ALTER TABLE contract_items ENABLE ROW LEVEL SECURITY;

-- Authenticated users podem ler e escrever (mesmo padrão atual do sistema).
-- Quando o RBAC por role evoluir, filtrar por role aqui.
DROP POLICY IF EXISTS "contracts_all_authenticated"      ON contracts;
CREATE POLICY "contracts_all_authenticated"
  ON contracts FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "contract_items_all_authenticated" ON contract_items;
CREATE POLICY "contract_items_all_authenticated"
  ON contract_items FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ─── 7. Verificação ─────────────────────────────────────────────────────────
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('contracts','contract_items')
ORDER BY table_name;
