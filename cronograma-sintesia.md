# Cronograma SintesIA — Plano Completo (As 4 Pontas)

**Atualizado em:** 2026-06-15
**Como usar:** siga as fases NA ORDEM. Marque `[x]` quando terminar. Não pule fases — cada uma destrava a próxima.
**Ritmo:** Seg–Sáb · ~3h/dia · 1 sessão = 1 dia de trabalho

---

## 📍 Onde você está agora (Jun 15, 2026)

**Funcionando:** Dashboard, CRM Inteligente (Camada 1 completa), Agenda, Pacientes, Tarefas, Financeiro (5 sub-abas), BI & Margem, Relatórios (11), Configurações, Serviços (CRUD), Anamnese (builder + aba no perfil).

**Pendente na Fase 1:** abas Prescrições, Documentos/Exames e Linha do Tempo no perfil do paciente + CRM Camada 2 (IA conversacional).

**⚠️ Ação imediata:** rodar `sql/services_add_description.sql` no Supabase SQL Editor para habilitar o campo Descrição nos serviços.

**⚠️ Commit pendente:** muita coisa não commitada desde 64ec680 — AnamnesisTab, PatientProfile, ServicesCatalog, Dashboard, PaymentRegisterModal.

---

## FASE 1 — Fechar a base operacional
*Objetivo: ninguém trava no dia a dia da clínica.*
*🏁 Meta: 24 de junho de 2026*

### CRM Inteligente

- [x] **Automação Projeto Lazaro — Parte A:** lead parado 7+ dias → "Leads Frios" + notificação ✅ 2026-06-06

**🟢 Camada 1 — Inteligência sobre dados existentes** ✅ concluída em 2026-06-06
- [x] Timeline de interações por lead (histórico cronológico)
- [x] Lead scoring baseado no histórico real de conversões
- [x] Painel de saúde do funil (alertas automáticos)
- [x] Atribuição de responsável por lead

**🟡 Camada 2 — Inteligência conversacional (Gemini/Groq já instalados)**
*Previsão: 20 e 23 de junho*
- [x] Resumo automático do histórico do paciente ✅ 2026-06-16
- [x] Análise de interesse/urgência (IA lê contexto e sinaliza "lead quente") ✅ 2026-06-16
- [ ] Sugestão de próxima melhor ação `[Jun 23]`
- [ ] Rascunho de mensagem personalizada para revisão humana `[Jun 23]`
- [x] Captura automática de leads — WhatsApp via n8n (workflow da Sofia) ✅ 2026-06-16

**🔴 Camada 3 — Automação autônoma (depende da Sofia ativa — Fase 3)**
- [ ] Inbox omnichannel (WhatsApp + Instagram + site)
- [ ] Agente autônomo cuidando do funil (Sofia agenda, confirma, move lead)
- [ ] Projeto Lazaro Parte B (nutrição contínua de leads frios)

---

### Agenda ✅ concluída em 2026-06-09
- [x] Lógica completa de criação/edição/cancelamento
- [x] Múltiplos procedimentos por agendamento
- [x] Recorrência flexível (Diário, Semanal, Quinzenal, Mensal, Personalizado)
- [x] Campo de observação no card
- [x] Hover com dados rápidos do paciente
- [x] Status visual (cancelado, não compareceu)
- [x] Cancelamento com motivo
- [x] Aba Histórico no modal de edição
- [x] Grade compacta (9h–20h, sem rolagem em notebook)

---

### Ficha completa do paciente (PatientProfile)
*Previsão: 16–19 de junho*

- [x] Anamnese estruturada — builder drag-drop + aba de preenchimento ✅ 2026-06-09
- [x] Histórico de agendamentos — aba com dados reais do Supabase ✅ 2026-06-09
- [x] Evolução clínica — coberta pelos templates do tipo "evolucao" no builder ✅
- [ ] Prescrições e orientações `[Jun 16]`
- [ ] Linha do tempo clínica unificada `[Jun 17]`
- [ ] Documentos e exames (upload + visualização via Supabase Storage) `[Jun 18–19]`

---

### Serviços ✅ concluído em 2026-06-09
- [x] CRUD completo (criar, editar, excluir) conectado ao Supabase
- [ ] ⚠️ Rodar `sql/services_add_description.sql` para habilitar campo Descrição (usuário)

---

### Melhorias pontuais ✅
- [x] Dashboard — receita e lucro real de `payments` (não mais `patients.price`)
- [x] PaymentRegisterModal — proteção anti-duplicata

---

### Migração para domínio próprio *(30 min — tarefa do usuário)*
- [ ] Apontar DNS do domínio para a Vercel `[Jun 24]`
- [ ] Configurar domínio customizado no painel da Vercel `[Jun 24]`
- [ ] Atualizar URLs de redirect no Supabase Auth `[Jun 24]`

---

## FASE 2 — Torre de Controle: fechar pendências do Financeiro
*Objetivo: gestão com visão completa de lucratividade.*
*🏁 Meta: 9 de julho de 2026*

- [ ] Pagamento parcelado (installments) `[Jun 25]`
- [ ] Pagamento parcial / saldo devedor `[Jun 26]`
- [ ] Tela de pagamento de comissões aos profissionais `[Jun 27]`
- [ ] Caixa pequeno (lançamento rápido) `[Jun 30]`
- [ ] Projeção de fluxo de caixa 30/60/90 dias `[Jul 1]`
- [ ] Competência vs caixa no DRE `[Jul 2]`
- [ ] Conta bancária vinculada por transação `[Jul 2]`
- [ ] Juros e multa em contas vencidas `[Jul 3]`
- [ ] Convênios/planos de saúde — parte 1 (cadastro + vínculo) `[Jul 7]`
- [ ] Convênios/planos de saúde — parte 2 (repasse + relatório) `[Jul 8]`
- [ ] Fechamento de período contábil `[Jul 9]`

---

## FASE 3 — Painel da Recepção (a Concierge Humana)
*Objetivo: a IA cuida da burocracia, a recepção cuida do acolhimento.*
*🏁 Meta: 14 de julho de 2026*

- [ ] Lembretes automáticos de consulta via WhatsApp (WAHA) `[Jul 10]`
- [ ] Notificações de confirmação de consulta `[Jul 11]`
- [ ] Sofia (SDR de IA) — integração final no n8n `[Jul 14]`
- [ ] **Projeto Lazaro Parte B** (Sofia dispara sequência semanal para leads frios, volta ao funil se responder) `[Jul 14]`

---

## FASE 4 — Painel do Profissional (o foco no humano)
*Objetivo: zero burocracia, máximo "olho no olho" com o paciente.*
*🏁 Meta: 18 de julho de 2026*

- [ ] Evoluções clínicas estruturadas (registro por consulta, diferente da anamnese) `[Jul 15]`
- [ ] Transcrição de consulta em tempo real (Groq) `[Jul 16]`
- [ ] Resumo IA do histórico do paciente — co-piloto silencioso (Gemini) `[Jul 17]`
- [ ] Assinatura digital `[Jul 18]`

---

## FASE 5 — Hub do Paciente (o grande diferencial de mercado)
*Objetivo: estender a clínica até o bolso do paciente — fidelização absurda.*
*🏁 Meta: Setembro de 2026 (planejamento separado)*

- [ ] Portal do paciente (web/app)
- [ ] Exames lado a lado mostrando evolução, laudos fáceis de ler
- [ ] Lembretes de horários de suplementação
- [ ] Receitas saudáveis sugeridas conforme fase do protocolo
- [ ] Canal direto de comunicação com a equipe da clínica
- [ ] Dicas curtas de saúde / conteúdo de comunidade

---

## 🗓️ Visão rápida do calendário

| Semana | Datas | Foco |
|--------|-------|------|
| Sem 1 | Jun 16–20 | Ficha do paciente (Prescrições, Timeline, Docs/Exames) + CRM IA |
| Sem 2 | Jun 23–27 | CRM Camada 2 + buffer/testes + início Fase 2 |
| Sem 3 | Jun 30–Jul 4 | Financeiro (parcelado, parcial, comissões, caixa, DRE) |
| Sem 4 | Jul 7–11 | Financeiro (convênios, fechamento) + início Fase 3 |
| Sem 5 | Jul 14–18 | Sofia/WhatsApp + Fase 4 (prontuário, IA, transcrição) |
| Sem 6+ | Ago+ | Fase 5 — Portal do Paciente |

---

## 🎯 Regra de ouro

> O que evita caos na clínica vem primeiro:
> **Agenda > Prontuário > Financeiro > Automações**

Se uma ideia nova s