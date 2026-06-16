-- ─────────────────────────────────────────────────────────────────────────────
-- Módulo de Anamnese e Evoluções — SintesIA
-- Tabelas: anamnesis_templates + anamnesis_records
-- ─────────────────────────────────────────────────────────────────────────────

-- Templates de formulário (modelos reutilizáveis por especialidade)
CREATE TABLE IF NOT EXISTS anamnesis_templates (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text        NOT NULL,
  type         text        NOT NULL DEFAULT 'anamnese'
                           CHECK (type IN ('anamnese', 'evolucao', 'laudo', 'complemento')),
  specialties  text[]      NOT NULL DEFAULT '{}',
  fields       jsonb       NOT NULL DEFAULT '[]',
  -- Estrutura de cada campo em fields[]:
  -- {
  --   "id": "uuid",
  --   "type": "title"|"text"|"memo"|"radio"|"checkbox"|"select"|"date"|"divider",
  --   "label": "Queixa Principal",
  --   "required": true,
  --   "placeholder": "Descreva...",
  --   "options": ["Opção 1", "Opção 2"]   -- para radio/checkbox/select
  -- }
  is_active    boolean     NOT NULL DEFAULT true,
  created_at   timestamptz NOT NULL DEFAULT now(),
  updated_at   timestamptz NOT NULL DEFAULT now()
);

-- Registros preenchidos (uma linha por consulta/anamnese realizada)
CREATE TABLE IF NOT EXISTS anamnesis_records (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id       uuid        NOT NULL REFERENCES patients(id)              ON DELETE CASCADE,
  template_id      uuid        REFERENCES anamnesis_templates(id)            ON DELETE SET NULL,
  template_name    text        NOT NULL,   -- snapshot do nome no momento do preenchimento
  professional_id  uuid        REFERENCES professionals(id)                  ON DELETE SET NULL,
  appointment_id   uuid        REFERENCES appointments(id)                   ON DELETE SET NULL,
  data             jsonb       NOT NULL DEFAULT '{}',
  -- data: { "field_uuid": valor, ... }
  -- valor pode ser string, boolean, string[] (checkbox múltiplo) ou null
  notes            text,       -- campo livre adicional ("caixa livre")
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now()
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_anamnesis_records_patient    ON anamnesis_records(patient_id);
CREATE INDEX IF NOT EXISTS idx_anamnesis_records_template   ON anamnesis_records(template_id);
CREATE INDEX IF NOT EXISTS idx_anamnesis_records_created    ON anamnesis_records(patient_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_anamnesis_templates_type     ON anamnesis_templates(type, is_active);

-- Trigger: atualiza updated_at automaticamente
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_anamnesis_templates_updated_at
  BEFORE UPDATE ON anamnesis_templates
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_anamnesis_records_updated_at
  BEFORE UPDATE ON anamnesis_records
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Seed: template inicial "Primeira Consulta" pronto para usar
INSERT INTO anamnesis_templates (name, type, specialties, fields) VALUES (
  'Primeira Consulta',
  'anamnese',
  ARRAY['Biomedicina', 'Nutrição', 'Saúde Integrativa'],
  '[
    {"id":"f1","type":"title",   "label":"Identificação e Queixa"},
    {"id":"f2","type":"memo",    "label":"Queixa Principal",           "required":true,  "placeholder":"Descreva o motivo da consulta..."},
    {"id":"f3","type":"memo",    "label":"História da Doença Atual",   "required":false, "placeholder":"Início, evolução, fatores de melhora/piora..."},
    {"id":"f4","type":"divider", "label":""},
    {"id":"f5","type":"title",   "label":"Antecedentes"},
    {"id":"f6","type":"memo",    "label":"Antecedentes Pessoais",      "required":false, "placeholder":"Doenças pregressas, cirurgias, internações..."},
    {"id":"f7","type":"memo",    "label":"Antecedentes Familiares",    "required":false, "placeholder":"Doenças hereditárias relevantes..."},
    {"id":"f8","type":"memo",    "label":"Alergias / Intolerâncias",   "required":false, "placeholder":"Medicamentos, alimentos, substâncias..."},
    {"id":"f9","type":"divider", "label":""},
    {"id":"f10","type":"title",  "label":"Hábitos e Estilo de Vida"},
    {"id":"f11","type":"radio",  "label":"Pratica atividade física?",  "required":false, "options":["Sim, regularmente","Sim, ocasionalmente","Não"]},
    {"id":"f12","type":"radio",  "label":"Tabagismo",                  "required":false, "options":["Nunca fumou","Ex-tabagista","Fumante"]},
    {"id":"f13","type":"radio",  "label":"Etilismo",                   "required":false, "options":["Não consome","Consumo social","Consumo frequente"]},
    {"id":"f14","type":"memo",   "label":"Alimentação / Dieta atual",  "required":false, "placeholder":"Descreva os hábitos alimentares..."},
    {"id":"f15","type":"memo",   "label":"Sono",                       "required":false, "placeholder":"Qualidade, horas, dificuldades..."},
    {"id":"f16","type":"divider","label":""},
    {"id":"f17","type":"title",  "label":"Medicamentos e Suplementos"},
    {"id":"f18","type":"memo",   "label":"Medicamentos em uso",        "required":false, "placeholder":"Nome, dose, frequência..."},
    {"id":"f19","type":"memo",   "label":"Suplementos",                "required":false, "placeholder":"Vitaminas, fitoterápicos, outros..."},
    {"id":"f20","type":"divider","label":""},
    {"id":"f21","type":"title",  "label":"Exame Físico / Observações"},
    {"id":"f22","type":"text",   "label":"Peso (kg)",                  "required":false, "placeholder":"Ex: 72.5"},
    {"id":"f23","type":"text",   "label":"Altura (cm)",                "required":false, "placeholder":"Ex: 168"},
    {"id":"f24","type":"text",   "label":"Pressão Arterial",           "required":false, "placeholder":"Ex: 120/80 mmHg"},
    {"id":"f25","type":"memo",   "label":"Observações do Profissional","required":false, "placeholder":"Conduta, impressão clínica, orientações..."}
  ]'::jsonb
) ON CONFLICT DO NOTHING;

INSERT INTO anamnesis_templates (name, type, specialties, fields) VALUES (
  'Evolução / Retorno',
  'evolucao',
  ARRAY[]::text[],
  '[
    {"id":"e1","type":"memo",  "label":"Evolução desde a última consulta", "required":true,  "placeholder":"Como o paciente está se sentindo, mudanças..."},
    {"id":"e2","type":"memo",  "label":"Aderência ao tratamento",          "required":false, "placeholder":"Medicamentos, suplementos, orientações seguidas..."},
    {"id":"e3","type":"memo",  "label":"Queixas atuais",                   "required":false, "placeholder":"Novas queixas ou mudança nas anteriores..."},
    {"id":"e4","type":"text",  "label":"Peso atual (kg)",                  "required":false, "placeholder":"Ex: 71.0"},
    {"id":"e5","type":"text",  "label":"Pressão Arterial",                 "required":false, "placeholder":"Ex: 118/78 mmHg"},
    {"id":"e6","type":"memo",  "label":"Conduta / Próximos passos",        "required":false, "placeholder":"Ajuste de protocolo, novos pedidos, orientações..."}
  ]'::jsonb
) ON CONFLICT DO NOTHING;
