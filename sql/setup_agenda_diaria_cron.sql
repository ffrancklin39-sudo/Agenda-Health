-- setup_agenda_diaria_cron.sql
-- Agenda o envio do email diario para profissionais toda noite as 20h (horario Brasilia = 23h UTC)
-- Roda de domingo a sexta (envia a agenda de segunda a sabado)
--
-- PRE-REQUISITOS:
-- 1. Extensoes habilitadas: pg_cron e pg_net
--    (Dashboard -> Database -> Extensions -> buscar "cron" e "http")
-- 2. Edge Function "agenda-diaria" deployada
-- 3. Secret RESEND_API_KEY configurada na funcao

-- Remove cron antigo se existir
select cron.unschedule('agenda-diaria-email') 
where exists (
  select 1 from cron.job where jobname = 'agenda-diaria-email'
);

-- Cria o cron: toda noite as 23:00 UTC (20:00 Brasilia), de domingo a sexta
select cron.schedule(
  'agenda-diaria-email',
  '0 23 * * 0-5',
  $$
  select
    net.http_post(
      url     := 'https://iudghjdmfcxjcpspeify.supabase.co/functions/v1/agenda-diaria',
      headers := jsonb_build_object(
        'Content-Type',  'application/json',
        'x-cron-secret', '<CRON_SECRET>'  -- mesmo valor do secret CRON_SECRET da função; NUNCA commitar o valor real
      ),
      body    := '{}'::jsonb
    ) as request_id;
  $$
);

-- Confirma
select jobid, jobname, schedule, active 
from cron.job 
where jobname = 'agenda-diaria-email';
