# Node RESOLVE_IDENTIDADE — código

**Status:** Proposta para revisão (ainda não implementada no n8n)
**Data:** 2026-06-17
**Referência:** docs/sofia-arquitetura-definitiva.md, seção 3

Node único de **Code** (JavaScript, "Run Once for Each Item"), posicionado imediatamente após o `Webhook`. Substitui todos os nodes `Resolver LID WAHA*` espalhados pelo fluxo. Nenhum node depois deste deve ler `payload.from`/`payload.to` bruto — só `from_real`/`to_real`.

```javascript
// RESOLVE_IDENTIDADE
// Resolve from/to (que podem vir como @lid ou já como número real/@c.us)
// para o telefone real, uma única vez, logo após o Webhook.
// Qualquer node depois deste consome from_real/to_real — nunca payload.from/to bruto.

const WAHA_BASE_URL = 'http://204.216.153.179:3000';
const WAHA_API_KEY = 'sintesia123';
const WAHA_SESSION = 'default'; // ajustar por sessão quando os 3 chips estiverem separados

const payload = $input.item.json.payload ?? $input.item.json;

async function resolveToRealPhone(rawId) {
  if (!rawId) return null;

  // Já é um número real (@c.us) — não precisa resolver
  if (!rawId.includes('@lid')) {
    return rawId.split('@')[0];
  }

  // É um @lid — precisa consultar o WAHA
  const lid = rawId.split('@')[0];
  try {
    const response = await this.helpers.httpRequest({
      method: 'GET',
      url: `${WAHA_BASE_URL}/api/${WAHA_SESSION}/lids/${lid}`,
      headers: { 'X-Api-Key': WAHA_API_KEY },
      json: true,
    });
    // 'pn' = phone number resolvido pelo WAHA
    if (response?.pn) {
      return response.pn.split('@')[0];
    }
  } catch (err) {
    // Falha na resolução: cai no fallback abaixo, NUNCA quebra o fluxo
  }

  // Fallback: devolve o valor bruto (sem @lid) — melhor ter algo
  // identificável do que travar o fluxo todo por uma falha do WAHA.
  return lid;
}

const from_real = await resolveToRealPhone.call(this, payload.from);
const to_real = await resolveToRealPhone.call(this, payload.to);

return {
  json: {
    from_real,
    to_real,
    fromMe: payload.fromMe ?? false,
    event: payload.event ?? $input.item.json.event ?? null,
    raw: payload,
  },
};
```

## Notas

- `this.helpers.httpRequest` está disponível em Code nodes de versões recentes do n8n (modo "Run Once for Each Item"). Se a versão instalada não suportar, a alternativa é dois nodes `HTTP Request` (um para `from`, um para `to`) seguidos de um node `Merge`/`Set` que monta o mesmo objeto `{ from_real, to_real, fromMe, event, raw }` — funcionalmente equivalente, só mais nodes no canvas.
- O fallback (linha final) é deliberado: preferimos um identificador "errado" mas presente a travar o webhook inteiro se o WAHA estiver fora do ar. Isso é consistente com o princípio de fail-safe do documento — na pior das hipóteses, o lead cai na fila humana porque `PODE_SOFIA_RESPONDER` não vai reconhecer um paciente existente com esse ID.
- `WAHA_SESSION` está fixo como `'default'` porque hoje só existe uma sessão. Quando os 3 chips (seção 9 do documento) forem separados, isso vira um valor injetado por workflow/webhook, não hardcoded.
