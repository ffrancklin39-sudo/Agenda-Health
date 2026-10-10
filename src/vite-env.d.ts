/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_SUPABASE_URL: string;
  readonly VITE_SUPABASE_ANON_KEY: string;
  /** URL pública do painel do Chatwoot (sem token). Opcional. */
  readonly VITE_CHATWOOT_URL?: string;
}
