-- ============================================================================
-- SCHEMA SUPABASE PARA SintesIA
-- Copie e execute estes comandos no SQL Editor do Supabase
-- ============================================================================

-- ============================================================================
-- 1. TABELA: PROFESSIONALS (Profissionais/Médicos)
-- ============================================================================
CREATE TABLE IF NOT EXISTS professionals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  specialty TEXT,
  color TEXT DEFAULT 'blue', -- blue, purple, emerald, etc
  email TEXT,
  phone TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 2. TABELA: SERVICES (Serviços/Procedimentos)
-- ============================================================================
CREATE TABLE IF NOT EXISTS services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  duration_minutes INTEGER DEFAULT 60,
  category TEXT, -- Consultas, Procedimentos, Estética, Reabilitação
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 3. TABELA: PATIENTS (Pacientes/Leads) - AUMENTADA
-- ============================================================================
CREATE TABLE IF NOT EXISTS patients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Informações Básicas
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  cpf TEXT UNIQUE,
  date_of_birth DATE,
  gender TEXT, -- M, F, O

  -- Endereço
  address TEXT,
  city TEXT,
  state TEXT,
  zip_code TEXT,

  -- Status & Pipeline
  status TEXT DEFAULT 'lead', -- lead, negotiation, waiting, scheduled, confirmed, discarded
  source TEXT, -- WhatsApp, Call, Indicação, Feegow

  -- Agendamento
  appointment_date TIMESTAMP,
  professional_id UUID REFERENCES professionals(id),
  service_id UUID REFERENCES services(id),

  -- Financeiro
  price DECIMAL(10, 2),
  last_payment_date TIMESTAMP,

  -- Lembretes
  reminder_date TIMESTAMP,
  reminder_note TEXT,
  reminder_executed BOOLEAN DEFAULT FALSE,

  -- Histórico & Observações
  observation TEXT,
  notes JSONB DEFAULT '[]'::jsonb, -- Array de notas com timestamp

  -- Metadata
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 4. TABELA: APPOINTMENTS (Agendamentos)
-- ============================================================================
CREATE TABLE IF NOT EXISTS appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  professional_id UUID NOT NULL REFERENCES professionals(id),
  service_id UUID NOT NULL REFERENCES services(id),

  date_time TIMESTAMP NOT NULL,
  duration_minutes INTEGER DEFAULT 60,
  status TEXT DEFAULT 'scheduled', -- scheduled, confirmed, completed, cancelled, no_show

  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),

  -- Índices para performance
  CONSTRAINT appointments_no_overlap UNIQUE (professional_id, date_time)
);

CREATE INDEX IF NOT EXISTS idx_appointments_patient ON appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_professional ON appointments(professional_id);
CREATE INDEX IF NOT EXISTS idx_appointments_date ON appointments(date_time);
CREATE INDEX IF NOT EXISTS idx_appointments_status ON appointments(status);

-- ============================================================================
-- 5. TABELA: PAYMENTS (Pagamentos/Recebimentos)
-- ============================================================================
CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  appointment_id UUID REFERENCES appointments(id) ON DELETE SET NULL,

  amount DECIMAL(10, 2) NOT NULL,
  status TEXT DEFAULT 'pending', -- pending, paid, refunded, cancelled
  payment_method TEXT, -- pix, credit_card, cash, check, transfer
  payment_date TIMESTAMP,

  -- Comissão
  professional_id UUID REFERENCES professionals(id),
  commission_percentage DECIMAL(5, 2),
  commission_amount DECIMAL(10, 2),
  commission_paid BOOLEAN DEFAULT FALSE,

  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_payments_patient ON payments(patient_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_professional ON payments(professional_id);
CREATE INDEX IF NOT EXISTS idx_payments_date ON payments(payment_date);

-- ============================================================================
-- 6. TABELA: PATIENT_HISTORY (Histórico de Pacientes)
-- ============================================================================
CREATE TABLE IF NOT EXISTS patient_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,

  event_type TEXT NOT NULL, -- consultation, procedure, payment, follow_up, note, status_change
  description TEXT,

  professional_id UUID REFERENCES professionals(id),

  metadata JSONB DEFAULT '{}'::jsonb, -- Dados adicionais (valores, status anterior, etc)

  created_by TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_patient_history_patient ON patient_history(patient_id);
CREATE INDEX IF NOT EXISTS idx_patient_history_type ON patient_history(event_type);
CREATE INDEX IF NOT EXISTS idx_patient_history_date ON patient_history(created_at);

-- ============================================================================
-- 7. DADOS DE EXEMPLO
-- ============================================================================

-- Profissionais
INSERT INTO professionals (name, specialty, color, email, phone) VALUES
  ('Dr. Ricardo Mendonça', 'Ortopedia', 'blue', 'ricardo@clinic.com', '11999999999'),
  ('Dra. Ana Beatriz', 'Dermatologia', 'purple', 'ana@clinic.com', '11888888888'),
  ('Dr. Lucas Silva', 'Fisioterapia', 'emerald', 'lucas@clinic.com', '11777777777')
ON CONFLICT DO NOTHING;

-- Serviços
INSERT INTO services (name, price, duration_minutes, category, description) VALUES
  ('Consulta Médica', 450.00, 60, 'Consultas', 'Consulta clínica com médico especializado'),
  ('Aplicação de Botox', 1800.00, 45, 'Procedimentos', 'Aplicação de toxina botulínica'),
  ('Criolipólise', 1200.00, 90, 'Estética', 'Redução de gordura localizada por criofrequência'),
  ('Sessão de Fisioterapia', 250.00, 60, 'Reabilitação', 'Sessão de fisioterapia para reabilitação')
ON CONFLICT DO NOTHING;

-- ============================================================================
-- 8. ROW LEVEL SECURITY (RLS) - OPCIONAL
-- ============================================================================

-- Habilitar RLS
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE patient_history ENABLE ROW LEVEL SECURITY;

-- Criar policy para permitir leitura/escrita de dados
-- (Ajuste conforme sua estratégia de autenticação)
CREATE POLICY "Anyone can read patients" ON patients
  FOR SELECT
  USING (true);

CREATE POLICY "Anyone can create patients" ON patients
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update patients" ON patients
  FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- Repetir para outras tabelas conforme necessário...

-- ============================================================================
-- 9. VIEWS ÚTEIS
-- ============================================================================

-- View: Resumo financeiro por profissional
CREATE OR REPLACE VIEW professional_revenue AS
SELECT
  p.id,
  p.name,
  COUNT(DISTINCT a.id) as total_appointments,
  COUNT(DISTINCT CASE WHEN a.status = 'completed' THEN a.id END) as completed_appointments,
  SUM(CASE WHEN pay.status = 'paid' THEN pay.amount ELSE 0 END) as total_received,
  SUM(CASE WHEN pay.status = 'pending' THEN pay.amount ELSE 0 END) as pending_amount
FROM professionals p
LEFT JOIN appointments a ON p.id = a.professional_id
LEFT JOIN payments pay ON a.id = pay.appointment_id
GROUP BY p.id, p.name;

-- View: Próximos agendamentos
CREATE OR REPLACE VIEW upcoming_appointments AS
SELECT
  a.id,
  pat.name as patient_name,
  pat.phone,
  prof.name as professional_name,
  s.name as service_name,
  a.date_time,
  a.status
FROM appointments a
JOIN patients pat ON a.patient_id = pat.id
JOIN professionals prof ON a.professional_id = prof.id
JOIN services s ON a.service_id = s.id
WHERE a.date_time > NOW() AND a.status IN ('scheduled', 'confirmed')
ORDER BY a.date_time ASC;

-- ============================================================================
-- FIM DO SCHEMA
-- ============================================================================
