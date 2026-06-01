-- ============================================================================
-- MIGRATION V3 — Campos estendidos da tabela professionals
-- Execute no Supabase SQL Editor
-- ============================================================================

ALTER TABLE professionals
  ADD COLUMN IF NOT EXISTS title          TEXT,
  ADD COLUMN IF NOT EXISTS social_name    TEXT,
  ADD COLUMN IF NOT EXISTS birth_date     DATE,
  ADD COLUMN IF NOT EXISTS gender         TEXT,
  ADD COLUMN IF NOT EXISTS cpf            TEXT,
  ADD COLUMN IF NOT EXISTS cns            TEXT,
  ADD COLUMN IF NOT EXISTS council        TEXT,
  ADD COLUMN IF NOT EXISTS council_number TEXT,
  ADD COLUMN IF NOT EXISTS council_uf     TEXT,
  ADD COLUMN IF NOT EXISTS rqe            TEXT,
  ADD COLUMN IF NOT EXISTS phone2         TEXT,
  ADD COLUMN IF NOT EXISTS observation    TEXT,
  ADD COLUMN IF NOT EXISTS active         BOOLEAN DEFAULT TRUE;
