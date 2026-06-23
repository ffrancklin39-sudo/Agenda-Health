# Sofia 2.0 — Plano de Teste (Task #75)

**Status:** Pronto para execução
**Pré-requisitos já cumpridos:** SQL `add_conversation_state.sql` + `add_sofia_echo_tracking.sql` rodadas; `Sofia 2.0 - TESTE.json` importado no n8n (workflow separado, webhook `ClinicaCandiaSofiaTeste`); fluxo antigo "Fluxo Novo-Cloude" permanece desativado e intocado.

Duas fases, conforme seção 10 (passo 7) e checklist (seção 11) de `sofia-arquitetura-definitiva.md`.

---

## Fase 1 — Teste isolado, sem tráfego real do WhatsApp

Objetivo: validar a lógica do fluxo (identidade, estados, eco, tags) com payloads simulados, sem envolver nenhum lead real e sem nada saindo pelo WAHA. Roda direto no n8n usando execução manual com JSON colado no node `Webhook` (pin data) ou "Test workflow".

Cenários a rodar, um por um, conferindo a saída de cada node:

1. **Lead novo, mensagem normal (`@c.us`)** — esperado: `RESOLVE_IDENTIDADE` resolve sem erro, `CRIA_PACIENTE` cria com `conversation_state = NOVO_LEAD`, Sofia responde.
2. **Mesmo cenário, mas chat id em formato `@lid`** — esperado: resolução via WAHA funciona, telefone real é o mesmo do cenário 1 (mesma pessoa, dois formatos).
3. **Paciente existente com `conversation_state = HUMANO_ASSUMIU`** — esperado: `PODE_SOFIA_RESPONDER` bloqueia, Sofia não responde, nada muda.
4. **Evento `fromMe:true` cujo texto bate com `last_sofia_message_text` gravado há menos de 15s** — esperado: tratado como eco da própria Sofia, `conversation_state` continua `SOFIA_ATIVA` (não vira `HUMANO_ASSUMIU`).
5. **Evento `fromMe:true` com texto diferente, ou fora da janela de 15s** — esperado: tratado como handoff humano real, `conversation_state → HUMANO_ASSUMIU`.
6. **Resposta da Claude contendo `[AGENDAR]`** — esperado: `PROCESSA_RESPOSTA_CLAUDE` detecta, `IF3` dispara `ATUALIZA_ESTADO_HANDOFF`.
7. **Resposta da Claude contendo `[TRANSFERIR]`** — esperado: mesmo comportamento do item 6 (esse era o gap que não existia no fluxo antigo).

Nenhum desses cenários precisa enviar mensagem real — pode revisar o payload que iria pro WAHA antes do node `Enviar Resposta (WAHA)` e não precisa executá-lo.

**Limitação conhecida, não bloqueante:** `has_future_appointment` está hardcoded como `false` em `PEGA_PACIENTE` — ainda não consulta a tabela `appointments` de fato. Não invalida o teste, mas vale registrar.

---

## Fase 2 — Teste real com 3-5 leads de baixo risco

Critério de "baixo risco": números que **não** são pacientes reais ativos da clínica — idealmente o próprio Francklin e 1–2 pessoas de confiança avisadas, simulando perguntas comuns de lead novo. Nunca usar lead real que possa ficar sem resposta se algo falhar.

**Decisão de roteamento necessária:** hoje o WAHA envia webhooks só para o path antigo (`ClinicaCandia`). Para o fluxo novo (`ClinicaCandiaSofiaTeste`) receber mensagens reais, é preciso apontar temporariamente o webhook do WAHA pra esse path novo durante a janela de teste, e reverter depois. Isso não tem risco para pacientes reais porque o fluxo antigo já está desativado — mas é uma mudança de infraestrutura que prefiro confirmar com você antes de fazer.

O que validar durante o teste real (itens do checklist da arquitetura):

- `HUMANO_ASSUMIU` nunca é sobrescrito automaticamente — mandar 2+ mensagens do número de teste depois que um humano (você) responder manualmente, confirmar que Sofia continua calada.
- Eco da Sofia é distinguido corretamente de handoff humano real (cenário mais arriscado, nunca testado contra payload real do WAHA).
- `[AGENDAR]`/`[TRANSFERIR]` realmente pausam a Sofia em conversa real.
- `patient_intelligence` é populado corretamente (lead score, queixas).
- Resolução `@lid`/`@c.us` funciona com número de teste real (não só simulado).

**Plano de rollback:** desativar o workflow "Sofia 2.0 — TESTE" no n8n (toggle Active = false) e/ou reverter o webhook do WAHA pro path antigo. Qualquer um dos dois interrompe o fluxo novo imediatamente, sem afetar o fluxo de produção (que já está desativado).

---

## Decisão confirmada — roteamento Fase 2

Francklin escolheu: trocar o webhook da sessão WAHA atual temporariamente pro path novo (`ClinicaCandiaSofiaTeste`) durante a janela de teste, e reverter pro path antigo (`ClinicaCandia`) depois.

**Como fazer (via API do WAHA):**

```bash
curl -X PUT http://204.216.153.179:3000/api/sessions/default \
  -H "X-Api-Key: sintesia123" \
  -H "Content-Type: application/json" \
  -d '{
    "config": {
      "webhooks": [
        {
          "url": "https://<seu-n8n>/webhook/ClinicaCandiaSofiaTeste",
          "events": ["message", "session.status"]
        }
      ]
    }
  }'
```

Substituir `<seu-n8n>` pela URL real do n8n (domínio `n8n.usesintesia.com.br` se já propagado, senão `http://204.216.153.179:5678`). Pra reverter depois do teste, repetir o mesmo comando trocando `ClinicaCandiaSofiaTeste` por `ClinicaCandia`.

⚠️ Confirmar a URL/sessão exata antes de rodar — `GET /api/sessions/default` mostra a config atual pra comparar.

## Próximo passo

1. Rodar Fase 1 agora (sem risco, dentro do próprio n8n, sem tocar no WAHA).
2. Quando Fase 1 estiver OK, trocar o webhook do WAHA (comando acima) e rodar Fase 2 com 3-5 números de baixo risco.
3. Reverter o webhook do WAHA pro path antigo ao final do teste.
