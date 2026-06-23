# Sofia como Produto Standalone — Arquitetura de Transição

**Status:** Proposta para revisão (ainda não implementada)
**Data:** 2026-06-19
**Contexto:** Decisão do Francklin de evoluir a Sofia de "automação interna da Clínica Candia" para um produto vendável separadamente — uma SDR de IA "quase perfeita" (acolhedora, calorosa, estilo mineiro de atendimento), oferecida primeiro a outras clínicas como porta de entrada, com integração fácil (e desacoplável) com o SintesIA.

Decisões já confirmadas pelo Francklin nesta sessão:
- Sofia vira **produto separado**, com infraestrutura própria (não vive dentro do Supabase/repositório do SintesIA).
- **Mantém WAHA** (WhatsApp não-oficial) por enquanto — só migra pra API oficial do WhatsApp Business quando houver o primeiro cliente pagante de fato.

---

## 0. Achado crítico desta sessão — resolver antes de qualquer coisa

Ao inspecionar o workflow `Fluxo Novo-Cloude` (produção, atualmente desativado) no n8n, confirmei: **a captura de lead (criar/atualizar o paciente com nome e telefone) e a resposta automática da Sofia estão no mesmo workflow, atrás do mesmo webhook único do WAHA.** Não existe hoje uma separação real entre "capturar o lead" e "a IA responder" — são a mesma cadeia de nodes.

Isso quer dizer que, na prática, **o CRMi não funciona de forma independente da Sofia hoje**: quando o Francklin desativou o fluxo em 2026-06-17 por causa da regressão, ele desativou a captura automática de leads do WhatsApp junto, não só a Sofia. Não encontrei, dentro desse workflow, nenhum node de Instagram Lead Ads — então a captura via Instagram (#59) deve viver em outro lugar (outro projeto n8n ou integração direta fora do n8n); isso ainda precisa ser confirmado.

**Isso precisa ser corrigido independente da decisão de vender a Sofia separada** — é a mesma correção estrutural que o produto standalone também precisa. Ver seção 2.

---

## 1. Visão do Produto

> Uma SDR de IA que combina o melhor do atendimento humano (acolhimento, empatia, calor — referência: atendimento mineiro) com qualificação e agendamento consistentes, vendida como porta de entrada de clínicas, plugável em qualquer CRM (incluindo, mas não exclusivamente, o SintesIA).

Princípios:
- A Sofia precisa funcionar **sozinha** (sem o SintesIA) para ser vendável a quem não usa o SintesIA.
- A Sofia precisa **integrar fácil** com o SintesIA pra quem já usa (ou decide adotar depois).
- "Perfeição" no atendimento não é um prompt fixo — é um **processo contínuo de avaliação e ajuste** (ver seção 6).

---

## 2. Separação Estrutural: Captura vs. Sofia

Esse é o pilar técnico de tudo o que vem depois — tanto pro SintesIA quanto pra Sofia standalone.

```
Webhook (WAHA / API oficial)
  → RESOLVE_IDENTIDADE (já desenhado na arquitetura definitiva)
  → CAPTURA_LEAD  ◄── sempre ativo, independente de IA
        - cria/atualiza o registro do lead (nome, telefone, origem, timestamp)
        - não depende de nenhuma chamada à Claude
        - é o que garante que o CRM (qualquer CRM) nunca fica "cego" a um lead novo
  → (opcional) SOFIA_RESPONDE  ◄── camada de IA, plugável e desplugável
        - só roda se o tenant/cliente tiver a Sofia ativada
        - lê o estado de conversa, decide se responde, chama Claude, processa tags
        - se desativada (ou se der erro), a captura já aconteceu — nada se perde
```

Implicações práticas:
- **Para o SintesIA hoje:** o `Fluxo Novo-Cloude` precisa ser refeito como dois blocos claramente separados (ou dois workflows: um "Captura" sempre publicado, outro "Sofia" que pode ser ligado/desligado sem afetar o primeiro). Isso já é uma correção pendente, independente da venda da Sofia.
- **Para a Sofia standalone:** o bloco `CAPTURA_LEAD` é o ponto de entrada universal — ele é o mesmo não importa se o destino final do lead é o SintesIA, um inbox próprio da Sofia, ou outro CRM do cliente.
- **Para o adaptador de entrega (seção 4):** é o `CAPTURA_LEAD` que decide para onde o lead vai depois de capturado — não a Sofia.

---

## 3. Infraestrutura da "Sofia Core" (produto separado)

Banco de dados próprio (novo projeto Supabase, ou ao menos schema isolado), com tabelas genéricas — sem nada específico da Clínica Candia:

| Tabela | Função |
|---|---|
| `tenants` | um registro por cliente: nome da clínica, serviços, preços, horários, tom de voz, webhook de entrega configurado |
| `leads` | equivalente ao `patients` de hoje, mas só os campos que a Sofia precisa (nome, telefone, origem, `conversation_state`) — sem campos clínicos do SintesIA |
| `conversation_memory` | histórico de mensagens por lead, igual ao modelo atual |
| `tenant_prompt_config` | variáveis injetadas no prompt por tenant (preço, serviço, clínica) — ver seção 5 |

Workflow n8n próprio, derivado do `Sofia 2.0 - TESTE` atual, mas parametrizado por `tenant_id` em vez de hardcoded pra uma clínica só. Cada tenant tem sua própria sessão WAHA (chip/número), já que WAHA não tem multi-tenant nativo — isso é uma limitação operacional a ter em mente conforme o número de clientes crescer (motivo pelo qual a migração futura pra API oficial deixa de ser opcional e passa a ser necessária em algum volume).

---

## 4. Adaptador de Entrega do Lead

Em vez da Sofia "saber" sobre o SintesIA, ela entrega todo lead qualificado (ou só capturado) num **webhook configurável por tenant**, definido em `tenants.webhook_entrega`:

- **Cliente usa SintesIA:** o webhook aponta pra rota de criação de lead do SintesIA (mesma lógica de `CAPTURA_LEAD` que já existe lá — ver seção 2). Sofia e SintesIA continuam conversando, só que por um contrato HTTP simples, não por acoplamento direto de banco.
- **Cliente não usa SintesIA:** o webhook aponta pra um inbox simples próprio da Sofia (uma tela mínima de "leads capturados", que pode até ser uma view simples no mesmo banco da Sofia Core).
- **Migração de um lado pro outro:** trocar o destino é só reapontar o `webhook_entrega` do tenant — não exige reescrever nada da Sofia. Isso resolve diretamente a pergunta original de "aderir e desaderir de forma prática e rápida".

Contrato sugerido do payload (versionar isso desde já):
```json
{
  "tenant_id": "...",
  "lead": { "nome": "...", "telefone": "...", "origem": "whatsapp|instagram|...", "primeira_mensagem": "..." },
  "qualificacao": { "interesse": "...", "lead_score": 0-100, "resumo_ia": "..." },
  "evento": "lead_capturado | lead_qualificado | handoff_humano"
}
```

---

## 5. Camada de Personalidade

Hoje o prompt da Sofia (`PROMPT_SOFIA`) é um bloco único, com o tom e os dados da Clínica Candia misturados. Pra reusar entre clientes, fatiar em duas partes:

1. **Núcleo de personalidade** (versionado, reusável entre todos os tenants): o jeito de falar — acolhedor, caloroso, ritmo de conversa, como ela se identifica, como ela escala pra humano, as proibições (nunca diagnosticar, nunca prometer disponibilidade sem checar agenda, etc). Esse é o "produto" de verdade — o trabalho de "aperfeiçoar a Sofia até quase a perfeição" é principalmente aqui.
2. **Variáveis do tenant** (uma linha em `tenant_prompt_config` por cliente): nome da clínica, serviços oferecidos, preços, horário de funcionamento, particularidades de tom que o cliente queira (ex: mais formal vs. mais informal).

O prompt final enviado à Claude é o núcleo + as variáveis interpoladas — nunca duas cópias divergentes do texto-base.

---

## 6. Avaliação Contínua ("perfeição" como processo, não como prompt)

Achado relevante da Fase 1 de testes (2026-06-18): a Sofia nem sempre usa as tags `[AGENDAR]`/`[TRANSFERIR]` exatamente como o prompt pede — ela às vezes pede mais informação antes. Isso é esperado de um modelo de linguagem, e significa que "perfeição" exige um loop, não um prompt fixo:

1. **Banco de cenários de teste** crescente (expandindo o que já existe em `docs/sofia-fase1-payloads.md`): tom, empatia, casos sensíveis (conteúdo clínico, reclamação, pedido de humano), agendamento, edge cases. Roda de novo a cada mudança de prompt, antes de publicar.
2. **Feedback de conversas reais:** quem atende (Nayla, ou a recepção do cliente) marca conversas boas/ruins; isso alimenta ajustes no núcleo de personalidade (seção 5).
3. **Métricas objetivas por tenant:** taxa de handoff correto, taxa de agendamento, tempo médio de resposta, reclamações — pra comparar tenants e versões de prompt entre si.

---

## 7. Caminho de Migração pro WhatsApp Oficial (futuro, não agora)

Decisão atual: manter WAHA enquanto valida o produto com a Clínica Candia como cliente zero. Pontos a observar pra saber quando migrar:
- Primeiro cliente externo pagante confirmado → gatilho pra migrar antes de ativar o número dele.
- WAHA é por sessão/número — cada tenant novo é uma sessão nova; isso escala mal operacionalmente (cada chip precisa ser conectado manualmente) e tem risco de ban por ser automação não-oficial.
- Migração realista: API Cloud da Meta direto, ou um BSP (360dialog, Twilio, Gupshup) — abstrai a complexidade de infra de WhatsApp, e dá suporte a múltiplos números de forma nativa.

---

## 8. Plano de Implementação (ordem sugerida)

1. **Separar Captura vs. Sofia no `Fluxo Novo-Cloude` atual** (seção 2) — corrige o problema operacional de hoje e já é o desenho que a Sofia standalone vai precisar.
2. Fatiar o prompt em núcleo + variáveis (seção 5), ainda dentro da infra atual — testável já com a Clínica Candia.
3. Criar a infraestrutura própria da Sofia Core (Supabase + n8n separados, seção 3) — migração de fato pra produto isolado.
4. Implementar o adaptador de entrega via webhook (seção 4), com o SintesIA como primeiro consumidor.
5. Expandir o banco de cenários de avaliação (seção 6) em paralelo a tudo isso.
6. Só então: buscar o primeiro cliente externo, e avaliar a migração pro WhatsApp oficial (seção 7) antes de ativar o número dele.

---

## 9. Decisões 2026-06-19 (respostas do Francklin)

1. **Instagram:** não tem captura de Lead Ads do Instagram ativa hoje — só chegam leads via WhatsApp. Simplifica a task #77: não existe uma segunda fonte de captura escondida em outro lugar.
2. **Precificação:** decide mais adiante, não trava a construção do motor. Único ajuste: instrumentar uso por tenant (mensagens, leads capturados, conversas) desde a v1, mesmo sem modelo de cobrança definido, pra não faltar histórico quando o modelo for escolhido.
3. **UI própria:** meio-termo decidido — v1 terá um inbox **mínimo** (lista de leads + conversa de cada um), sem nenhuma feature de CRM (sem kanban/funil/relatório). Dá valor pra quem não tem CRM nenhum sem roubar foco do trabalho real (a personalidade/qualificação da Sofia). O webhook de entrega (seção 4) continua existindo em paralelo pra quem já tem CRM.
4. **Nome:** mantém "Sofia" (paralelo com Alexa/Siri — nome próprio funciona bem pra assistente conversacional). Cuidado: marca/domínio da Sofia deve ser separado de `usesintesia.com.br`, pra ficar claro que é vendável independente. Checagem de domínio/disponibilidade de marca ainda não foi feita.

**Ordem de execução escolhida:** começar pela task #77 (separar Captura vs. Sofia dentro do `Fluxo Novo-Cloude` existente) antes de migrar pra infraestrutura própria — corrige o problema operacional atual e já constrói a peça que a Sofia standalone vai reusar.
