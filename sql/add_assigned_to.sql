-- Adiciona campo de "responsável pelo lead" ao CRM.
-- Reaproveita a tabela `professionals` já existente (nomes + cores já cadastrados,
-- e nada impede que um atendente/vendedor também esteja cadastrado lá) em vez de
-- criar uma tabela nova só para isso — menos fricção, mesma fonte de verdade
-- usada no agendamento.

ALTER TABLE patients
  ADD COLUMN IF NOT EXISTS assigned_to uuid REFERENCES professionals(id) ON DELETE SET NULL;

-- Índice para os filtros/consultas por responsável (ex.: "meus leads")
CREATE INDEX IF NOT EXISTS idx_patients_assigned_to ON patients (assigned_to);

COMMENT ON COLUMN patients.assigned_to IS
  'Profissional/atendente responsável por este lead no funil do CRM (não confundir com professional_id, que é o profissional do agendamento clínico).';
