-- ============================================================
-- SintesIA — Permissões por papel (role_permissions)
-- Controla quais módulos cada papel (ADMIN/DOCTOR/RECEPTIONIST)
-- pode acessar. Configurável pelo ADMIN na tela de Configurações.
-- ============================================================

CREATE TABLE IF NOT EXISTS role_permissions (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  role       TEXT        NOT NULL CHECK (role IN ('ADMIN','DOCTOR','RECEPTIONIST')),
  module     TEXT        NOT NULL,
  enabled    BOOLEAN     NOT NULL DEFAULT true,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (role, module)
);

COMMENT ON TABLE role_permissions IS 'Controla acesso por papel a cada módulo do SintesIA. Gerenciado pelo ADMIN em Configurações > Permissões.';

-- Trigger: atualiza updated_at
CREATE OR REPLACE FUNCTION set_role_permissions_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END; $$;

DROP TRIGGER IF EXISTS trg_role_permissions_updated_at ON role_permissions;
CREATE TRIGGER trg_role_permissions_updated_at
  BEFORE UPDATE ON role_permissions
  FOR EACH ROW EXECUTE FUNCTION set_role_permissions_updated_at();

-- Garante que a função is_admin() existe (pode ter sido criada antes em profiles_and_roles.sql)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'ADMIN');
$$;

-- RLS
ALTER TABLE role_permissions ENABLE ROW LEVEL SECURITY;

-- Leitura: qualquer usuário autenticado (precisa ler no startup do app)
CREATE POLICY "rp_select" ON role_permissions
  FOR SELECT TO authenticated USING (true);

-- Escrita: apenas ADMIN
CREATE POLICY "rp_write" ON role_permissions
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- ============================================================
-- Seed: permissões padrão (espelha o hardcoded atual do Sidebar)
-- ============================================================
INSERT INTO role_permissions (role, module, enabled) VALUES
  -- ADMIN: acesso total
  ('ADMIN', 'dashboard',   true),
  ('ADMIN', 'agenda',      true),
  ('ADMIN', 'kanban',      true),
  ('ADMIN', 'patients',    true),
  ('ADMIN', 'tasks',       true),
  ('ADMIN', 'automations', true),
  ('ADMIN', 'services',    true),
  ('ADMIN', 'finance',     true),
  ('ADMIN', 'bi',          true),
  ('ADMIN', 'reports',     true),
  ('ADMIN', 'settings',    true),

  -- DOCTOR: acesso clínico
  ('DOCTOR', 'dashboard',   true),
  ('DOCTOR', 'agenda',      true),
  ('DOCTOR', 'kanban',      false),
  ('DOCTOR', 'patients',    true),
  ('DOCTOR', 'tasks',       true),
  ('DOCTOR', 'automations', false),
  ('DOCTOR', 'services',    false),
  ('DOCTOR', 'finance',     false),
  ('DOCTOR', 'bi',          false),
  ('DOCTOR', 'reports',     false),
  ('DOCTOR', 'settings',    false),

  -- RECEPTIONIST: operacional sem financeiro
  ('RECEPTIONIST', 'dashboard',   true),
  ('RECEPTIONIST', 'agenda',      true),
  ('RECEPTIONIST', 'kanban',      true),
  ('RECEPTIONIST', 'patients',    true),
  ('RECEPTIONIST', 'tasks',       true),
  ('RECEPTIONIST', 'automations', false),
  ('RECEPTIONIST', 'services',    true),
  ('RECEPTIONIST', 'finance',     false),
  ('RECEPTIONIST', 'bi',          false),
  ('RECEPTIONIST', 'reports',     false),
  ('RECEPTIONIST', 'settings',    false)

ON CONFLICT (role, module) DO NOTHING;

-- Verificação
SELECT role, module, enabled FROM role_permissions ORDER BY role, module;
