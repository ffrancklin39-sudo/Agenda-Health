-- Adiciona coluna description na tabela services
-- Rodar no Supabase SQL Editor

ALTER TABLE services
  ADD COLUMN IF NOT EXISTS description TEXT;
