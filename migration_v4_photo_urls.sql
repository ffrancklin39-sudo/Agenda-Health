-- ============================================================================
-- MIGRATION V4 — Fotos de perfil para profissionais e pacientes
-- Execute no Supabase SQL Editor
-- ============================================================================

-- 1. Adicionar photo_url nas tabelas
ALTER TABLE professionals ADD COLUMN IF NOT EXISTS photo_url TEXT;
ALTER TABLE patients      ADD COLUMN IF NOT EXISTS photo_url TEXT;

-- 2. Criar bucket público para fotos de perfil (execute uma vez)
-- Se preferir, crie manualmente em: Storage > New Bucket > nome: "profiles" > Public: ON
INSERT INTO storage.buckets (id, name, public)
VALUES ('profiles', 'profiles', true)
ON CONFLICT (id) DO NOTHING;

-- 3. Política: qualquer usuário autenticado pode fazer upload
CREATE POLICY IF NOT EXISTS "Authenticated users can upload profiles"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'profiles');

-- 4. Política: leitura pública
CREATE POLICY IF NOT EXISTS "Public profiles are viewable"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'profiles');

-- 5. Política: dono pode deletar
CREATE POLICY IF NOT EXISTS "Authenticated users can delete own profiles"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'profiles');
