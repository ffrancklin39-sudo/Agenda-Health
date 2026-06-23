# Sofia 2.0 — Payloads Fase 1 (teste isolado)

Como rodar cada cenário:

1. Abra o workflow "Sofia 2.0 - TESTE" no n8n.
2. Clique no node `Webhook` → "Listen for test event" (ele mostra a URL de teste, algo como `https://n8n.../webhook-test/ClinicaCandiaSofiaTeste`).
3. Rode o `curl` correspondente ao cenário (no seu terminal, ou peça pra eu rodar se você me der a URL de teste).
4. Confira no n8n, node por node, se a saída bate com o "esperado" de cada cenário.
5. Antes do próximo cenário, sempre clique em "Listen for test event" de novo (ele só escuta uma execução por vez).

Uso dois números fictícios de teste, que **não existem ainda no banco**:
- `5561999990001` — vai representar um lead novo (cenários 1, 6, 7)
- `5561999990002` — vai representar um paciente já existente, com estado controlado manualmente via SQL antes de cada cenário (3, 4, 5)

---

## Cenário 1 — Lead novo, mensagem normal

**Esperado:** `RESOLVE_IDENTIDADE` resolve `from_real = 5561999990001`; `PEGA_PACIENTE` retorna `exists:false`; `PODE_SOFIA_RESPONDER` retorna `pode_responder:true, novo_conversation_state:"NOVO_LEAD"`; `CRIA_PACIENTE` cria a linha.

```bash
curl -X POST <URL_DE_TESTE> \
  -H "Content-Type: application/json" \
  -d '{
    "event": "message",
    "payload": {
      "from": "5561999990001@c.us",
      "to": "556185216790@c.us",
      "fromMe": false,
      "body": "Oi, vi o anúncio de vocês no Instagram, queria saber mais",
      "_data": { "notifyName": "Teste Lead Um" }
    }
  }'
```

---

## Cenário 2 — Resolução `@lid` (nota importante)

Esse cenário só é válido de verdade se o `@lid` usado existir de fato na base de contatos do WAHA (senão o código cai no fallback e trata o `lid` cru como telefone, sem testar a resolução real). Não tem como simular isso com um `lid` inventado.

**Recomendação:** pular este teste isolado e validar a resolução `@lid` já na Fase 2, usando seu próprio WhatsApp (que certamente tem `@lid` real na base do WAHA) como um dos números de teste. Te aviso nessa hora pra conferirmos junto.

---

## Cenário 3 — `HUMANO_ASSUMIU` bloqueando

Primeiro, criar o paciente de teste já em `HUMANO_ASSUMIU` direto no Supabase (SQL Editor):

```sql
insert into patients (phone, status, name, is_lead, source, conversation_state)
values ('5561999990002', 'lead', 'Teste Lead Dois', true, 'whatsapp', 'HUMANO_ASSUMIU')
on conflict (phone) do update set conversation_state = 'HUMANO_ASSUMIU';
```

Depois, mandar a mensagem do lead:

```bash
curl -X POST <URL_DE_TESTE> \
  -H "Content-Type: application/json" \
  -d '{
    "event": "message",
    "payload": {
      "from": "5561999990002@c.us",
      "to": "556185216790@c.us",
      "fromMe": false,
      "body": "Oi, ainda estou esperando resposta",
      "_data": { "notifyName": "Teste Lead Dois" }
    }
  }'
```

**Esperado:** `PEGA_PACIENTE` retorna `conversation_state:"HUMANO_ASSUMIU"`; `PODE_SOFIA_RESPONDER` retorna `pode_responder:false`; nada é enviado, nada muda no banco.

---

## Cenário 4 — Eco da própria Sofia (não deve pausar)

Antes, simular que a Sofia acabou de responder (grava eco há poucos segundos):

```sql
update patients
set conversation_state = 'SOFIA_ATIVA',
    last_sofia_message_at = now(),
    last_sofia_message_text = 'Oi! Claro, te explico os valores da consulta.'
where phone = '5561999990002';
```

Depois, simular o webhook ecoando essa mesma mensagem como `fromMe:true` (rodar em até 15 segundos depois do UPDATE acima):

```bash
curl -X POST <URL_DE_TESTE> \
  -H "Content-Type: application/json" \
  -d '{
    "event": "message",
    "payload": {
      "from": "5561999990002@c.us",
      "to": "556185216790@c.us",
      "fromMe": true,
      "body": "Oi! Claro, te explico os valores da consulta.",
      "_data": { "notifyName": "Teste Lead Dois" }
    }
  }'
```

**Esperado:** `PODE_SOFIA_RESPONDER` retorna `motivo:"eco da propria Sofia"`, `novo_conversation_state:null` — ou seja, **não vira `HUMANO_ASSUMIU`**, conversa continua `SOFIA_ATIVA`.

---

## Cenário 5 — Handoff humano real (texto diferente do eco)

Mesma preparação do cenário 4 (rodar o `UPDATE` de novo se já passou tempo), mas agora simulando uma mensagem manual da Nayla com texto diferente:

```bash
curl -X POST <URL_DE_TESTE> \
  -H "Content-Type: application/json" \
  -d '{
    "event": "message",
    "payload": {
      "from": "5561999990002@c.us",
      "to": "556185216790@c.us",
      "fromMe": true,
      "body": "Oi, aqui é a Nayla, posso te ajudar a agendar agora mesmo",
      "_data": { "notifyName": "Teste Lead Dois" }
    }
  }'
```

**Esperado:** texto não bate com `last_sofia_message_text` → `PODE_SOFIA_RESPONDER` retorna `novo_conversation_state:"HUMANO_ASSUMIU"`. Confirme no Supabase que o paciente `5561999990002` ficou com `conversation_state = HUMANO_ASSUMIU`.

---

## Cenário 6 — Tag `[AGENDAR]` dispara handoff

Esse cenário depende da resposta real da Claude conter a tag — mais fácil de validar enviando uma mensagem que naturalmente leve a Sofia a agendar, por exemplo:

```bash
curl -X POST <URL_DE_TESTE> \
  -H "Content-Type: application/json" \
  -d '{
    "event": "message",
    "payload": {
      "from": "5561999990001@c.us",
      "to": "556185216790@c.us",
      "fromMe": false,
      "body": "Pode ser quinta às 14h, fechado, pode confirmar minha consulta",
      "_data": { "notifyName": "Teste Lead Um" }
    }
  }'
```

**Esperado:** resposta da Claude contém `[AGENDAR]`; `PROCESSA_RESPOSTA_CLAUDE` seta `tem_agendamento:true`; `IF3` dispara `ATUALIZA_ESTADO_HANDOFF`; paciente `5561999990001` vira `conversation_state = HUMANO_ASSUMIU` no Supabase depois da execução.

---

## Cenário 7 — Tag `[TRANSFERIR]` dispara handoff

```bash
curl -X POST <URL_DE_TESTE> \
  -H "Content-Type: application/json" \
  -d '{
    "event": "message",
    "payload": {
      "from": "5561999990001@c.us",
      "to": "556185216790@c.us",
      "fromMe": false,
      "body": "Isso é um diagnóstico que vocês fazem? Eu tenho uma condição rara e queria saber se dá pra tratar",
      "_data": { "notifyName": "Teste Lead Um" }
    }
  }'
```

**Esperado:** resposta da Claude contém `[TRANSFERIR]` (pergunta de conteúdo clínico, fora do escopo da Sofia conforme o prompt); `PROCESSA_RESPOSTA_CLAUDE` seta `tem_transferencia:true`; mesmo efeito do cenário 6 — `conversation_state = HUMANO_ASSUMIU`.

⚠️ Os cenários 6 e 7 dependem do comportamento real da Claude — se ela não usar a tag exatamente como esperado, isso já é em si um achado importante (significa o prompt precisa de ajuste), não um erro de infraestrutura.

---

## Limpeza depois do teste

Rodar nessa ordem (primeiro as tabelas que referenciam `patient_id`, só depois `patients`):

```sql
delete from patient_intelligence where patient_id in (
  select id from patients where phone in ('5561999990001', '5561999990002')
);
delete from conversation_memory where phone in ('5561999990001', '5561999990002');
delete from patients where phone in ('5561999990001', '5561999990002');
```
