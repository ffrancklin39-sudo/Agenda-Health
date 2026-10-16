// URL pública do painel do Chatwoot (WhatsApp / Atendimento).
// Vem de VITE_CHATWOOT_URL. Tudo que começa com VITE_ vai para o JavaScript
// público do site: aqui só pode ir o ENDEREÇO do painel, nunca token/chave.
// Por isso a URL é recusada se tiver usuário/senha, parâmetros (?...) ou #.

export function getChatwootUrl(): string | null {
  const raw = String(import.meta.env.VITE_CHATWOOT_URL ?? '').trim();
  if (!raw) return null;
  try {
    const u = new URL(raw);
    if (u.protocol !== 'https:') return null;
    if (u.username || u.password) return null;
    if (u.search || u.hash) return null;
    return u.toString();
  } catch {
    return null;
  }
}
