-- ============================================================================
-- SCHEMA SUPABASE PARA SintesIA - PRESERVANDO DADOS EXISTENTES
-- ⚠️ AVISO: Mantém tabela patients com dados existentes
-- ============================================================================

-- Deletar APENAS tabelas novas (se existirem)
DROP TABLE IF EXISTS patient_history CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS professionals CASCADE;
DROP TABLE IF EXISTS services CASCADE;

-- ============================================================================
-- 1. TABELA: PROFESSIONALS (Profissionais/Médicos)
-- ============================================================================
CREATE TABLE IF NOT EXISTS professionals (
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
CREATE TABLE IF NOT EXISTS services (
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
-- 3. TABELA: APPOINTMENTS (Agendamentos)
-- Usa BIGINT para patient_id (compatível com patients existente)
-- ============================================================================
CREATE TABLE IF NOT EXISTS appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- IMPORTANTE: patient_id é BIGINT para compatibilidade com tabela patients existente
  patient_id BIGINT NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
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
-- 4. TABELA: PAYMENTS (Pagamentos/Recebimentos)
-- Usa BIGINT para patient_id (compatível com patients existente)
-- ============================================================================
CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id BIGINT NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
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
-- 5. TABELA: PATIENT_HISTORY (Histórico de Pacientes)
-- Usa BIGINT para patient_id (compatível com patients existente)
-- ============================================================================
CREATE TABLE IF NOT EXISTS patient_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  patient_id BIGINT NOT NULL REFERENCES patients(id) ON DELETE CASCADE,

  event_type TEXT NOT NULL,
  description TEXT,
  professional_id UUID REFERENCES professionals(id),
  metadata JSONB DEFAULT '{}'::jsonb,
  created_by TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- 6. ÍNDICES PARA PERFORMANCE
-- ============================================================================
CREATE INDEX IF NOT EXISTS idx_appointments_patient ON appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_professional ON appointments(professional_id);
CREATE INDEX IF NOT EXISTS idx_appointments_date ON appointments(date_time);
CREATE INDEX IF NOT EXISTS idx_appointments_status ON appointments(status);

CREATE INDEX IF NOT EXISTS idx_payments_patient ON payments(patient_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_professional ON payments(professional_id);
CREATE INDEX IF NOT EXISTS idx_payments_date ON payments(payment_date);

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
-- 8. ROW LEVEL SECURITY (RLS)
-- ============================================================================

ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE patient_history ENABLE ROW LEVEL SECURITY;

-- Permitir acesso público (ajuste conforme necessário)
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
-- FIM DO SCHEMA (DADOS EXISTENTES PRESERVADOS)
-- ============================================================================
