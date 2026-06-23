-- Migração: rastreamento de eco da própria Sofia
-- Necessária para o novo fluxo "Sofia 2.0 — TESTE" diferenciar:
--   (a) a Sofia enviando sua própria resposta (webhook fromMe:true ecoado pelo WAHA)
--   (b) um humano (Nayla/recepção) usando a mesma sessão manualmente
-- Sem isso, todo fromMe:true seria tratado como handoff humano, incluindo as
-- respostas da própria Sofia — o que pausaria a Sofia a cada mensagem que ela manda.

alter table patients
  add column if not exists last_sofia_message_at timestamptz,
  add column if not exists last_sofia_message_text text;

comment on column patients.last_sofia_message_at is
  'Timestamp do último envio feito pela própria Sofia (fluxo automático). Usado para diferenciar eco da Sofia de envio manual humano na mesma sessão WhatsApp.';
comment on column patients.last_sofia_message_text is
  'Texto da última mensagem enviada pela Sofia. Comparado com o conteúdo de eventos fromMe:true recebidos em poucos segundos para confirmar que é eco, não humano.';
