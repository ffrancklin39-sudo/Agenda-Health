-- bill_reminders_setup.sql
-- 1. Adiciona boleto_url na tabela bills
-- 2. Configura os contatos que receberão lembretes
-- 3. Habilita pg_cron e agenda o job diário
-- Execute no Supabase SQL Editor

-- ── 1. Campo boleto_url em bills ──────────────────────────────────────────────
ALTER TABLE bills ADD COLUMN IF NOT EXISTS boleto_url TEXT;
COMMENT ON COLUMN bills.boleto_url IS 'Link do boleto (PDF ou página de pagamento) para enviar no lembrete WhatsApp';

-- ── 2. Contatos de lembrete em clinic_settings ────────────────────────────────
-- Formato JSON: array de objetos { name, phone } (55 + DDD + número)
INSERT INTO clinic_settings (key, value)
VALUES (
  'reminder_contacts',
  '[{"name":"Fellipe","phone":"5561998356364"},{"name":"Roberto","phone":"5561994300500"}]'
)
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

-- ── 3. pg_cron — habilitar extensão ──────────────────────────────────────────
-- Se aparecer erro de permissão, habilite em:
--   Supabase Dashboard → Database → Extensions → pg_cron → Enable
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- ── 4. Agendar o job diário às 8h (horário de Brasília = 11:00 UTC) ───────────
-- Remove job anterior se existir
SELECT cron.unschedule('bill-reminders-daily') WHERE EXISTS (
  SELECT 1 FROM cron.job WHERE jobname = 'bill-reminders-daily'
);

SELECT cron.schedule(
  'bill-reminders-daily',
  '0 11 * * *',   -- 08:00 BRT (UTC-3)
  $$
  SELECT net.http_post(
    url    := (SELECT value FROM clinic_settings WHERE key = 'supabase_url')
              || '/functions/v1/bill-reminders',
    headers := jsonb_build_object(
      'Authorization', 'Bearer ' || (SELECT value FROM clinic_settings WHERE key = 'service_role_key'),
      'Content-Type',  'application/json'
    ),
    body   := '{}'::jsonb
  );
  $$
);

-- ── 5. Alternativa mais simples: guardar a URL + service_role_key nos settings ─
-- (a Edge Function também pode ser chamada manualmente pelo app)
-- Se preferir não usar pg_cron, pode chamar a função via botão na tela Financeiro.

-- ── Verificação ───────────────────────────────────────────────────────────────
SELECT id, key, value FROM clinic_settings WHERE key = 'reminder_contacts';
SELECT * FROM cron.job WHERE jobname = 'bill-reminders-daily';
