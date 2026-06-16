import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

// Sem fallback hardcoded: se as variáveis não existirem, falha com erro claro
// em vez de conectar com uma chave inválida embutida no código.
if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    'VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY não configuradas. ' +
    'Defina-as no .env.local (dev) ou nas Environment Variables do Vercel (produção).'
  );
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

