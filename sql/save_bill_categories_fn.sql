-- Salva categorias customizadas de contas a pagar
-- SECURITY DEFINER ignora RLS — roda como dono da função
-- Execute no Supabase SQL Editor (único bloco, tudo junto)

CREATE OR REPLACE FUNCTION save_bill_categories(p_categories JSONB)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO clinic_settings (key, value)
  VALUES ('bill_categories', p_categories)
  ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();
END;
$$;

GRANT EXECUTE ON FUNCTION save_bill_categories(JSONB) TO authenticated;

-- Verificação (deve retornar a função)
SELECT routine_name FROM information_schema.routines
WHERE routine_name = 'save_bill_categories';
