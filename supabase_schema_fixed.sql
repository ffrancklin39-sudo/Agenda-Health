-- ============================================================================
-- SCHEMA SUPABASE PARA SintesIA - VERSÃO CORRIGIDA
-- ⚠️ AVISO: Vai DELETAR tabelas antigas se existirem
-- ============================================================================

-- Deletar tabelas antigas (ordem importa: dependências primeiro)
DROP TABLE IF EXISTS patient_history CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS professionals CASCADE;
DROP TABLE IF EXISTS services CASCADE;

-- ============================================================================
-- 1. TABELA: PROFESSIONALS (Profissionais/Médicos)
-- ============================================================================
CREATE TABLE professionals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  specialty TEXT,
  color TEXT DEFAULT 'blue',
  email TEXT,
  phone TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 2. TABELA: SERVICES (Serviços/Procedimentos)
-- ============================================================================
CREATE TABLE services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  duration_minutes INTEGER DEFAULT 60,
  category TEXT,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 3. TABELA: PATIENTS (Pacientes/Leads)
-- ============================================================================
CREATE TABLE patients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Informações Básicas
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  cpf TEXT UNIQUE,
  date_of_birth DATE,
  gender TEXT,

  -- Endereço
  address TEXT,
  city TEXT,
  state TEXT,
  zip_code TEXT,

  -- Status & Pipeline
  status TEXT DEFAULT 'lead',
  source TEXT,

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
  notes JSONB DEFAULT '[]'::jsonb,

  -- Metadata
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 4. TABELA: APPOINTMENTS (Agendamentos)
-- ============================================================================
CREATE TABLE appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  professional_id UUID NOT NULL REFERENCES professionals(id),
  service_id UUID NOT NULL REFERENCES services(id),

  date_time TIMESTAMP NOT NULL,
  duration_minutes INTEGER DEFAULT 60,
  status TEXT DEFAULT 'scheduled',
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),

  CONSTRAINT appointments_no_overlap UNIQUE (professional_id, date_time)
);

-- ============================================================================
-- 5. TABELA: PAYMENTS (Pagamentos/Recebimentos)
-- ============================================================================
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  appointment_id UUID REFERENCES appointments(id) ON DELETE SET NULL,

  amount DECIMAL(10, 2) NOT NULL,
  status TEXT DEFAULT 'pending',
  payment_method TEXT,
  payment_date TIMESTAMP,

  professional_id UUID REFERENCES professionals(id),
  commission_percentage DECIMAL(5, 2),
  commission_amount DECIMAL(10, 2),
  commission_paid BOOLEAN DEFAULT FALSE,

  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 6. TABELA: PATIENT_HISTORY (Histórico de Pacientes)
-- ============================================================================
CREATE TABLE patient_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,

  event_type TEXT NOT NULL,
  description TEXT,
  professional_id UUID REFERENCES professionals(id),
  metadata JSONB DEFAULT '{}'::jsonb,
  created_by TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 7. ÍNDICES PARA PERFORMANCE
-- ============================================================================
CREATE INDEX idx_appointments_patient ON appointments(patient_id);
CREATE INDEX idx_appointments_professional ON appointments(professional_id);
CREATE INDEX idx_appointments_date ON appointments(date_time);
CREATE INDEX idx_appointments_status ON appointments(status);

CREATE INDEX idx_payments_patient ON payments(patient_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_professional ON payments(professional_id);
CREATE INDEX idx_payments_date ON payments(payment_date);

CREATE INDEX idx_patient_history_patient ON patient_history(patient_id);
CREATE INDEX idx_patient_history_type ON patient_history(event_type);
CREATE INDEX idx_patient_history_date ON patient_history(created_at);

-- ============================================================================
-- 8. DADOS DE EXEMPLO
-- ============================================================================

-- Profissionais
INSERT INTO professionals (name, specialty, color, email, phone) VALUES
  ('Dr. Ricardo Mendonça', 'Ortopedia', 'blue', 'ricardo@clinic.com', '11999999999'),
  ('Dra. Ana Beatriz', 'Dermatologia', 'purple', 'ana@clinic.com', '11888888888'),
  ('Dr. Lucas Silva', 'Fisioterapia', 'emerald', 'lucas@clinic.com', '11777777777');

-- Serviços
INSERT INTO services (name, price, duration_minutes, category, description) VALUES
  ('Consulta Médica', 450.00, 60, 'Consultas', 'Consulta clínica com médico especializado'),
  ('Aplicação de Botox', 1800.00, 45, 'Procedimentos', 'Aplicação de toxina botulínica'),
  ('Criolipólise', 1200.00, 90, 'Estética', 'Redução de gordura localizada por criofrequência'),
  ('Sessão de Fisioterapia', 250.00, 60, 'Reabilitação', 'Sessão de fisioterapia para reabilitação');

-- ============================================================================
-- 9. ROW LEVEL SECURITY (RLS)
-- ============================================================================

ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE patient_history ENABLE ROW LEVEL SECURITY;

-- Permitir acesso público (ajuste conforme necessário)
CREATE POLICY "Anyone can read patients" ON patients FOR SELECT USING (true);
CREATE POLICY "Anyone can create patients" ON patients FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can update patients" ON patients FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "Anyone can delete patients" ON patients FOR DELETE USING (true);

CREATE POLICY "Anyone can read appointments" ON appointments FOR SELECT USING (true);
CREATE POLICY "Anyone can create appointments" ON appointments FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can update appointments" ON appointments FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "Anyone can delete appointments" ON appointments FOR DELETE USING (true);

CREATE POLICY "Anyone can read payments" ON payments FOR SELECT USING (true);
CREATE POLICY "Anyone can create payments" ON payments FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can update payments" ON payments FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "Anyone can delete payments" ON payments FOR DELETE USING (true);

CREATE POLICY "Anyone can read history" ON patient_history FOR SELECT USING (true);
CREATE POLICY "Anyone can create history" ON patient_history FOR INSERT WITH CHECK (true);

-- ============================================================================
-- FIM DO SCHEMA
-- ============================================================================
