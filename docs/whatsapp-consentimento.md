# Consentimento WhatsApp (opt-in / opt-out)

Camada de consentimento exigida antes de qualquer integração com a API oficial
do WhatsApp (Meta Cloud API + Chatwoot). **Esta fase não envia mensagens.**

Migration: `supabase/migrations/20261015234055_whatsapp_consentimento.sql`
Reversão: `supabase/rollback/20261015234055_whatsapp_consentimento_down.sql`
Testes locais: `PGBIN=/usr/lib/postgresql/16/bin supabase/tests/run_local.sh`

## Regra única

Pode receber **disparo ativo** (campanha, promoção, mensagem iniciada pela clínica):

```
opt_in = 'sim'  E  opt_out = false  E  telefone válido (phone_e164)  E  número fora da lista de supressão
```

- Banco: `select public.pode_receber_disparo('<patient_id>')`. **Fonte da verdade.**
- Front: `podeReceberDisparo(lead)` em `src/lib/consentimento.ts`. Usado só em filtros e selos.
- Todo envio ativo real (n8n, Chatwoot, Edge Function) consulta a função do banco
  **imediatamente antes de enviar**. Não existe exceção.

## O que cada estado significa

| Campo | Valores | Observação |
|---|---|---|
| `opt_in` | `sim` / `incerto` / `nao` | Padrão `incerto`. Cadastros antigos ficaram `incerto`. |
| `opt_in_origem` | `click_to_whatsapp`, `form_com_consentimento`, `form_sem_consentimento`, `lead_ad`, `manual`, `feegow`, `whatsapp_legado` | Com `incerto`, guarda só o canal de entrada. |
| `opt_in_evidencia` | texto | Obrigatória para `sim` (mín. 10 caracteres; 20 na marcação em massa). |
| `opt_out` | `true`/`false` | Sempre vence. Propaga para todo cadastro com o mesmo número. Só ADMIN reverte. |
| `phone_e164` | `+55DDNNNNNNNNN` | Gerado pelo banco a partir de `phone`. NULL = nunca elegível. |

Telefone: 9º dígito só é acrescentado em celular (8 dígitos começando com 6–9);
fixo (2–5) fica sem o 9; DDD inválido, `@lid` ou tamanho errado viram NULL.

## Quem pode o quê

| Ação | Função | Quem |
|---|---|---|
| Editar consentimento de 1 cadastro | `atualizar_consentimento` | Qualquer usuário logado |
| Marcar opt-out | `marcar_opt_out` | Qualquer usuário logado, ou integração (service_role) |
| Reverter opt-out | `reverter_opt_out` | Somente ADMIN, com motivo |
| Opt-in em massa | `marcar_opt_in_em_massa` | Somente ADMIN, seleção explícita, evidência, até 500 |
| Entrada automática | `registrar_consentimento_entrada` | Somente integração (service_role) |

Escrita direta nas colunas de consentimento pelo app é **recusada pelo banco**.
Toda mudança fica em `consentimento_eventos` (quem, quando, antes/depois) — sem telefone nem nome.

## Contato manual (links wa.me)

| Tela | Tipo | opt-out | Recusou | Sem registro |
|---|---|---|---|---|
| CRMi (card do lead) | prospecção | bloqueia | bloqueia | aviso |
| Agenda, Contas a Receber, Inadimplência | transacional | aviso | aviso | livre |

## n8n — trechos exatos

As chamadas usam a **credencial** do Supabase no n8n (tipo *Header Auth* ou
*Supabase API*), com a chave `service_role` **já rotacionada**. Nunca cole a
chave no corpo ou na URL de um node.

### 1. Lead novo pelo WAHA (número antigo) → fica `incerto`

Logo depois do node que cria/encontra o paciente (`CAPTURA_LEAD`), adicione
um node **HTTP Request**:

- Método: `POST`
- URL: `https://<PROJECT_REF>.supabase.co/rest/v1/rpc/registrar_consentimento_entrada`
- Autenticação: a credencial do Supabase (envia `apikey` e `Authorization: Bearer`)
- Headers: `Content-Type: application/json`
- Body (JSON):

```json
{
  "p_patient_id": "{{ $json.id }}",
  "p_origem": "whatsapp_legado",
  "p_consentimento": null,
  "p_evidencia": "n8n WAHA: primeira mensagem recebida em {{ $now.toISO() }}"
}
```

Resposta esperada: `"incerto"`. Se o cadastro já tiver opt-out: `"opt_out_mantido"`.
Marque o node com **Continue On Fail**: falhar aqui não pode impedir a captura do lead.

### 2. Canal oficial: lead que chegou por anúncio Click-to-WhatsApp → `sim`

Quando a mensagem recebida da Meta trouxer o objeto `referral` (anúncio CTWA):

```json
{
  "p_patient_id": "{{ $json.patient_id }}",
  "p_origem": "click_to_whatsapp",
  "p_consentimento": "sim",
  "p_evidencia": "CTWA ad={{ $json.referral.source_id }} ctwa_clid={{ $json.referral.ctwa_clid }} wamid={{ $json.message_id }} recebido_em={{ $now.toISO() }}"
}
```

Se o cadastro estiver `nao`, a resposta é `"nao_mantido_revisao_humana"` e nada muda.

### 3. ANTES de qualquer envio ativo (obrigatório)

- `POST https://<PROJECT_REF>.supabase.co/rest/v1/rpc/pode_receber_disparo`
- Body: `{ "p_patient_id": "{{ $json.patient_id }}" }`
- Em seguida um node **IF**: só segue se a resposta for exatamente `true`.
  Erro, vazio ou `false` = **não envia**.

### 4. Pessoa respondeu "SAIR" → opt-out

Quando o texto recebido (sem espaços, minúsculo) for `sair`, `parar`, `pare`,
`stop`, `cancelar` ou `descadastrar`:

```json
{
  "p_patient_id": "{{ $json.patient_id }}",
  "p_motivo": "Respondeu {{ $json.text }} no WhatsApp"
}
```

para `POST .../rest/v1/rpc/marcar_opt_out`.

## Chatwoot

O Chatwoot **não conhece** esta regra. Campanhas disparadas por ele ignoram o
opt-in. Até existir a sincronização de supressão, deixe **Campanhas desligadas**
no Chatwoot e use-o só para atendimento.

O menu "WhatsApp / Atendimento" abre `VITE_CHATWOOT_URL` em nova aba. Essa
variável aceita **só o endereço https** do painel (sem token, `?` ou `#`); o
app recusa qualquer outra coisa e deixa o item desabilitado.
