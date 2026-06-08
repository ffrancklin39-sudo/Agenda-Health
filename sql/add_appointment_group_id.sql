-- Permite agrupar múltiplos procedimentos no mesmo atendimento/horário do paciente
-- (ex.: limpeza de pele + criolipólise + anamnese na mesma visita).
--
-- Em vez de criar uma tabela nova de "itens do agendamento", reaproveitamos a
-- própria `appointments`: cada procedimento vira uma linha (com seu próprio
-- serviço/duração), e todas as linhas de um mesmo atendimento compartilham o
-- mesmo `group_id`, agendadas em sequência (uma começa quando a anterior termina).
-- Mesma lógica que já usamos em `series_id` para pacotes recorrentes — aqui é
-- só um agrupamento "horizontal" (mesma visita) em vez de "vertical" (várias datas).

ALTER TABLE appointments
  ADD COLUMN IF NOT EXISTS group_id uuid;

CREATE INDEX IF NOT EXISTS idx_appointments_group_id ON appointments (group_id);

COMMENT ON COLUMN appointments.group_id IS
  'Agrupa múltiplos procedimentos do mesmo atendimento/visita do paciente (cada procedimento é uma linha própria em appointments, agendada em sequência). NULL = agendamento avulso, sem outros procedimentos vinculados.';
