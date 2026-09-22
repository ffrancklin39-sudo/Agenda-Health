// Remove tudo que não seja dígito e retorna apenas números.
export const normalizePhone = (value: string | null | undefined): string => {
  return String(value ?? '').replace(/\D/g, '');
};

// Trata identificadores JID do WhatsApp antes de armazenar/exibir.
//
// Formatos reconhecidos:
//   5521999887766@c.us          → contato pessoal → extrai e normaliza o número
//   5521999887766@s.whatsapp.net → idem
//   20809116553293@lid           → "linked identity" — NÃO é número de telefone;
//                                  retorna '' para que o CRM exiba '—' e não um
//                                  código incompreensível.
//   120363xxxxxx@g.us            → grupo → retorna '' (não é telefone)
//
// Para qualquer outro formato (número normal, com máscara, etc.), retorna limpo.
export const sanitizePhone = (raw: string | null | undefined): string => {
  const value = String(raw ?? '').trim();
  if (!value) return '';

  // JID com sufixo WhatsApp
  if (value.includes('@')) {
    const suffix = value.split('@')[1]?.toLowerCase() ?? '';
    const numPart = value.split('@')[0];

    // @lid e @g.us não são telefones reais
    if (suffix === 'lid' || suffix === 'g.us') return '';

    // @c.us e @s.whatsapp.net contêm o número com código de país
    if (suffix === 'c.us' || suffix === 's.whatsapp.net') {
      let digits = numPart.replace(/\D/g, '');
      // Remove código do Brasil (55) se presente
      if (digits.startsWith('55') && digits.length >= 12) digits = digits.slice(2);
      // Remove 9º dígito extra se houver (11 dígitos = DDD + 9 + número)
      if (digits.length === 11 && digits.charAt(2) === '9') {
        digits = digits.slice(0, 2) + digits.slice(3);
      }
      // Formata como (DDD) XXXX-XXXX
      if (digits.length === 10) {
        return `(${digits.slice(0, 2)}) ${digits.slice(2, 6)}-${digits.slice(6)}`;
      }
      return digits; // retorna só os dígitos se não encaixar no formato brasileiro
    }

    // Sufixo desconhecido — retorna vazio para não exibir lixo
    return '';
  }

  // Número normal (já formatado ou só dígitos) — retorna como veio
  return value;
};

// Converte para Title Case enquanto o usuário digita.
// Impede tudo maiúsculo ou tudo minúsculo — cada palavra começa com maiúscula.
export const toTitleCase = (value: string): string => {
  // O separador (espaço ou hífen) deve ser mantido no resultado —
  // por isso usamos dois grupos de captura: (sep)(letra)
  return value
    .toLowerCase()
    .replace(/(^|\s|-)(\p{L})/gu, (_, sep, char) => sep + char.toUpperCase());
};

// Chave canônica para comparar telefones com formatos diferentes (ex: +55/55 e DDD).
export const phoneMatchKey = (value: string | null | undefined): string => {
  if (!value) return '';

  // 1. Remove tudo que não for número (espaços, hifens, @c.us, etc)
  let cleaned = value.replace(/\D/g, '');

  // 2. Remove o código do país (55) se existir
  // Só tira o 55 se o número total tiver 12 ou 13 dígitos
  if (cleaned.startsWith('55') && cleaned.length >= 12) {
    cleaned = cleaned.substring(2);
  }

  // 3. O terror do WhatsApp: O Nono Dígito
  // Se sobrou 11 dígitos (DDD + 9 + número), removemos o 9 extra para a comparação exata
  if (cleaned.length === 11 && cleaned.charAt(2) === '9') {
    cleaned = cleaned.substring(0, 2) + cleaned.substring(3);
  }

  // O resultado sempre será apenas o DDD + 8 dígitos (ex: 6198356364)
  return cleaned; 
};