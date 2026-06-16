// Remove tudo que não seja dígito e retorna apenas números.
export const normalizePhone = (value: string | null | undefined): string => {
  return String(value ?? '').replace(/\D/g, '');
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