-- storage_policy.sql
-- Execute no Supabase SQL Editor para liberar acesso aos arquivos
-- para usuários autenticados (médicos, recepcionistas, etc.)

CREATE POLICY "authenticated_users_read_patient_files"
ON storage.objects FOR SELECT
TO authenticated
USING (bucket_id = 'patient-files');
