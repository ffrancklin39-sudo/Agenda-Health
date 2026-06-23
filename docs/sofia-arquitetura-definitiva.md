# Sofia 2.0 — Arquitetura Definitiva

**Status:** Proposta para revisão (ainda não implementada)
**Data:** 2026-06-17
**Contexto:** Sofia foi desativada em 2026-06-17 após o 3º incidente de "responde tudo" causado por resolução fragmentada de identidade (`@lid`). Decisão: não remendar nó por nó — redesenhar o fluxo inteiro de uma vez, como parte do lançamento do CRM Inteligente (Fase 3 do roadmap).

---

## 1. Princípio Central

> **Um humano sempre tem prioridade absoluta sobre a Sofia. Sempre.**

Toda a arquitetura abaixo existe para garantir isso de forma estrutural — não como uma condição IF espalhada em vários nodes, mas como uma única fonte de verdade que todo o resto do fluxo consulta.

---

## 2. Escopo de Atuação da Sofia

Decisão confirmada: **Sofia atende leads novos + leads frios (Projeto Lázaro). Nunca toca em paciente com histórico ativo.**

| Tipo de contato | Sofia pode responder? |
|---|---|
| Lead 100% novo (nunca existiu no banco) | ✅ Sim |
| Lead frio (`status = discarded`, parado +5 dias) — reativação Lázaro | ✅ Sim, só a mensagem de reativação de segunda-feira + resposta imediata |
| Paciente com consulta futura agendada | ❌ Não — vai direto pra fila humana |
| Paciente em atendimento ativo (qualquer status que não seja lead/descartado) | ❌ Não |
| Qualquer conversa onde um humano já respondeu | ❌ Não (pausa indefinida, ver seção 5) |

Essa tabela precisa estar **codificada em um único node de decisão** (ver seção 4), não espalhada.

---

## 3. Resolução de Identidade Centralizada (corrige o bug raiz)

**Problema histórico:** `payload.from`/`payload.to` do webhook vêm como `@lid` (ID interno do WhatsApp) ou `@c.us` (número real), de forma inconsistente. Cada node que precisava do telefone real fazia sua própria resolução via WAHA — e quando um node novo era adicionado sem essa resolução, o bug voltava (foi o caso das Tasks #65, #66 e #67).

**Solução:** logo após o `Webhook`, um único bloco resolve **uma vez** tanto `from` quanto `to`:

```
Webhook
  → RESOLVE_IDENTIDADE (node único)
      - resolve from_lid → from_real (via WAHA /lids/{id}, fallback pro valor bruto)
      - resolve to_lid → to_real (mesma lógica)
      - grava os dois em um objeto normalizado: { from_real, to_real, fromMe, event, raw }
  → todo o resto do fluxo consome só `from_real`/`to_real`
```

Nenhum outro node do fluxo deve mais ler `payload.from`/`payload.to` diretamente. Isso é a regra que elimina a categoria inteira do bug, não só a instância atual.

**Implementação prática:** pode ser um único node de Code (JavaScript) que faz as duas chamadas HTTP ao WAHA em paralelo (ou sequencial, dado que é leve) e devolve o objeto normalizado — mais simples de manter do que dois nodes HTTP Request separados como está hoje.

---

## 4. Máquina de Estados da Conversa

Cada conversa (identificada por `from_real`) tem um estado único, guardado em `patients.conversation_state` (campo novo, substituindo o uso improvisado de `status` para essa finalidade):

```
NOVO_LEAD        → Sofia pode iniciar/responder
SOFIA_ATIVA      → Sofia está conduzindo a conversa
HUMANO_ASSUMIU   → pausa indefinida, Sofia NUNCA responde aqui até reativação manual
CONVERTIDO       → virou paciente / agendou — Sofia não entra mais
LEAD_FRIO        → descartado, candidato a reativação Lázaro
```

Hoje o campo `status` (que já existe e serve pro funil do CRM) está sendo sobrecarregado para também controlar a pausa da Sofia (valor `'waiting'`). Recomendo **separar essas duas responsabilidades**: `status` continua sendo o funil comercial do CRM (novo, contatado, agendado, etc.), e `conversation_state` (campo novo) controla exclusivamente se a Sofia pode ou não falar. Isso evita que uma mudança no funil do CRM destrave a Sofia por acidente, e vice-versa.

**Único node decide se a Sofia responde:** `PODE_SOFIA_RESPONDER` — lê `conversation_state` do paciente (já resolvido pela identidade central) e só deixa passar se for `NOVO_LEAD`, `SOFIA_ATIVA` ou `LEAD_FRIO` em reativação. Qualquer outro estado, ou ausência de registro com regra ambígua, vai para fila humana por padrão (fail-safe: na dúvida, não responde).

---

## 5. Regra de Pausa — Indefinida

Confirmado: **uma vez que um humano (`fromMe: true`) responde numa conversa, `conversation_state` vira `HUMANO_ASSUMIU` e fica assim para sempre**, até alguém reativar manualmente pelo CRM (botão "devolver pra Sofia" no card do lead, por exemplo).

Isso é mais simples e mais seguro do que pausa temporária: elimina o risco de a Sofia "voltar sozinha" no meio de um atendimento humano em andamento por timeout.

---

## 6. Hierarquia e Handoff Forçado

Mesmo dentro de `NOVO_LEAD`/`SOFIA_ATIVA`, a Sofia deve interromper e escalar para humano **imediatamente** (sem esperar o humano "perceber") quando detectar:

- Pedido explícito de falar com humano ("quero falar com atendente", "isso é uma pessoa?")
- Reclamação ou sentimento muito negativo
- Pergunta sobre diagnóstico, prescrição, ou qualquer conteúdo clínico (Sofia nunca responde isso — só agenda/qualifica)
- Pedido de cancelamento/reembolso
- Mensagem de áudio/imagem que ela não conseguiu processar com confiança
- Mais de N (sugestão: 8) mensagens trocadas sem chegar a um agendamento — evita loop infinito

Quando qualquer gatilho acima dispara: `conversation_state → HUMANO_ASSUMIU`, notificação pro CRM/Nayla, e Sofia envia uma mensagem de transição (algo como "vou te conectar com nossa equipe, só um instante") em vez de simplesmente silenciar sem avisar.

---

## 7. Treinamento / Educação da Sofia (prompt e guardrails)

A "personalidade" da Sofia deve ser definida em um único prompt-base (não duplicado entre os nodes `PROMPT_SOFIA` e a análise de lead), com seções explícitas:

1. **Identidade:** quem ela é, que é uma assistente virtual (nunca finge ser humana se perguntada diretamente).
2. **Objetivo único:** qualificar o lead e marcar uma consulta — nada além disso.
3. **Proibições explícitas:** nunca falar sobre diagnóstico, preço fechado sem confirmação humana (se aplicável), nunca prometer disponibilidade sem checar a agenda real, nunca discutir concorrentes.
4. **Tom:** acolhedor, objetivo, frases curtas (WhatsApp, não e-mail).
5. **Quando se calar:** lista dos gatilhos da seção 6, em linguagem que o modelo entende como instrução de comportamento, não só lógica de código (defesa em camadas: o código força o handoff, mas o prompt também orienta a Sofia a se identificar como vai escalar).

Sugestão: versionar esse prompt em uma tabela (`sofia_prompts` ou similar) em vez de hardcoded no node, pra poder ajustar o tom sem reabrir o n8n a cada vez.

---

## 8. Integração com Projeto Lázaro

Leads em `LEAD_FRIO` (descartados, parados +5 dias) recebem follow-up automático toda segunda-feira. Se responderem, `conversation_state` volta para `SOFIA_ATIVA` automaticamente e o lead retorna ao funil do CRM. Métricas a expor nos relatórios: total recuperados, taxa de reativação, tempo médio até reativação — já estava planejado na Fase 3 do roadmap, fica encaixado naturalmente nesse desenho porque usa a mesma máquina de estados.

---

## 9. Números/Chips (confirmado, mantém decisão anterior)

| Número | Uso |
|---|---|
| Sofia (chip próprio) | Só leads novos + reativação Lázaro |
| Nayla (número dela) | Follow-up e fechamento manual |
| Recepção (número antigo) | Pacientes já existentes / atendimento corrente |

Cada número é uma sessão separada no WAHA. O bloco de `RESOLVE_IDENTIDADE` (seção 3) é reaproveitado nas três sessões — é a mesma lógica, só aplicada a webhooks diferentes.

---

## 10. Plano de Implementação no n8n

1. Construir o fluxo novo **isolado** (workflow separado ou branch dentro do mesmo, claramente nomeado "Sofia 2.0 — TESTE"), sem afetar o fluxo atual desativado.
2. Node único de identidade (`RESOLVE_IDENTIDADE`) substituindo os múltiplos `Resolver LID WAHA*` espalhados.
3. Campo novo `conversation_state` em `patients` (migração SQL).
4. Node único de decisão (`PODE_SOFIA_RESPONDER`) substituindo as várias combinações de IF espalhadas (`If`, `If1`, `IF_FROM_ME`, `IF_JA_WAITING`, `IF_WAITING_STOP`).
5. Prompt único versionado (seção 7).
6. Gatilhos de handoff forçado (seção 6) como uma checagem explícita antes de cada resposta da Sofia, não só na entrada da conversa.
7. Testar com 3-5 leads reais de baixo risco antes de qualquer publicação.
8. Só então: publicar, conectar chip da Sofia, religar.

---

## 11. Checklist Antes de Reativar

- [ ] Migração `conversation_state` rodada no Supabase
- [ ] Fluxo novo testado isolado (sem leads reais de pacientes ativos)
- [ ] Confirmado que `HUMANO_ASSUMIU` nunca é sobrescrito automaticamente
- [ ] Prompt revisado e aprovado pelo Francklin/Candia
- [ ] Métricas Lázaro com onde aparecer nos relatórios já mapeado
- [ ] Plano de rollback claro (como desativar rápido se algo sair errado de novo)
