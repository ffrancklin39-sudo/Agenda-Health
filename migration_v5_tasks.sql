-- ============================================================================
-- MIGRATION V5 — Módulo de Tarefas
-- Execute no Supabase SQL Editor
-- ============================================================================

CREATE TABLE IF NOT EXISTS tasks (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title            TEXT NOT NULL,
  description      TEXT,
  priority         TEXT DEFAULT 'normal',     -- baixa, normal, alta, urgente
  status           TEXT DEFAULT 'pending',    -- pending, in_progress, done, cancelled

  -- Pessoas
  created_by       UUID REFERENCES auth.users(id),
  created_by_name  TEXT,                      -- nome cacheado para exibição
  assigned_to_id   UUID,                      -- id do professional (referência soft)
  assigned_to_name TEXT,                      -- nome cacheado do destinatário

  -- Datas
  due_date         DATE,
  due_time         TIME,
  completed_at     TIMESTAMP,

  created_at       TIMESTAMP DEFAULT NOW(),
  updated_at       TIMESTAMP DEFAULT NOW()
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS tasks_status_idx       ON tasks(status);
CREATE INDEX IF NOT EXISTS tasks_assigned_to_idx  ON tasks(assigned_to_id);
CREATE INDEX IF NOT EXISTS tasks_due_date_idx     ON tasks(due_date);

-- RLS
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- Remove política antiga se existir, recria limpa
DROP POLICY IF EXISTS "Authenticated users manage tasks" ON tasks;

-- Qualquer usuário autenticado pode ver, criar e editar tarefas
CREATE POLICY "Authenticated users manage tasks"
ON tasks FOR ALL TO authenticated
USING (true) WITH CHECK (true);
