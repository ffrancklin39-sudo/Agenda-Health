# Cronograma SintesIA — Plano Completo (As 4 Pontas)

**Atualizado em:** 2026-06-06
**Como usar:** siga as fases NA ORDEM. Marque `[x]` quando terminar. Não pule fases — cada uma destrava a próxima.

---

## 📍 Onde você está agora

Já funcionando: Dashboard, CRM (kanban), Pacientes, Tarefas, Financeiro (5 sub-abas), BI & Margem, Relatórios (11), Configurações.

Ainda pendente: Agenda (lógica incompleta), Automações (placeholder), Serviços (só UI).

---

## FASE 1 — Fechar a base operacional
*Objetivo: ninguém trava no dia a dia da clínica.*

- [x] **CRM — Automação de follow-up (Parte A): lead parado 7+ dias é movido sozinho para "Leads Frios" + notificação** ✅ implementado em 2026-06-06

### CRMi → CRM Inteligente (análise comparativa em `docs/analise-crmi-vs-mercado-2026.md`)
*Construir em camadas — cada uma é a base da próxima. Não pular etapa.*

**🟢 Camada 1 — Inteligência sobre os dados que já existem (sem infra nova)** ✅ concluída em 2026-06-06
- [x] Timeline de interações por lead (histórico cronológico: contatos, mudanças de status, pagamentos — hoje só existe um campo de anotação único)
- [x] Lead scoring baseado no histórico real de conversões (nota de probabilidade por lead novo)
- [x] Painel de "saúde do funil" (alertas tipo "conversão caiu essa semana", "origem X rendendo menos")
- [x] Atribuição de responsável por lead (quem da equipe está cuidando + desempenho por pessoa)

**🟡 Camada 2 — Inteligência conversacional (usa Gemini/Groq que já estão instalados)**
- [ ] Resumo automático do histórico do paciente
- [ ] Análise de interesse/urgência da conversa (a IA lê o WhatsApp e sinaliza "lead quente, responda agora")
- [ ] Sugestão de próxima melhor ação
- [ ] Geração de rascunho de mensagem personalizada para revisão humana

**🔴 Camada 3 — Automação autônoma e omnichannel (depende da Sofia ativa — Fase 3)**
- [ ] Inbox omnichannel (WhatsApp + Instagram + site unificados no CRM)
- [ ] Agente autônomo cuidando do funil (Sofia agenda, confirma, move lead sozinha)
- [ ] Sequências automáticas de nutrição expandidas (Projeto Lazaro além dos Leads Frios)

---

- [ ] Agenda — completar lógica de criação/edição/cancelamento
  - [x] Permitir múltiplos procedimentos no mesmo agendamento/paciente (ex.: limpeza de pele + criolipólise + anamnese na mesma sessão) — implementado em 2026-06-08
  - [x] Recorrência flexível: agora com Diário, Semanal, Quinzenal, Mensal e Personalizado (intervalo livre em dias) — implementado em 2026-06-08
  - [x] Campo de observação no agendamento (textarea livre no modal de criar e editar, indicador visual no card quando preenchido — usa o campo `notes` já existente em `appointments`) — implementado em 2026-06-08
  - [x] Horário inicial da grade alterado de 7h para 9h, reduzindo a faixa visível e a rolagem necessária — implementado em 2026-06-08
  - [x] Hover nos cards mostra serviço(s), telefone, idade, alertas e observação — implementado em 2026-06-08

- [ ] **Ficha completa do paciente (PatientProfile) — URGENTE** *(doutoras precisam disso para usar o sistema)*
  - [ ] Anamnese estruturada (formulário editável por especialidade)
  - [ ] Evolução clínica (registro cronológico por consulta)
  - [ ] Histórico de agendamentos e procedimentos realizados
  - [ ] Documentos e exames (upload + visualização)
  - [ ] Prescrições e orientações
  - [ ] Linha do tempo clínica unificada

- [ ] Serviços (ServicesCatalog) — conectar ao Supabase, sair de "UI apenas"

- [ ] **Migração para domínio próprio** *(domínio já existe, só precisa configurar)*
  - [ ] Apontar DNS do domínio para a Vercel
  - [ ] Configurar domínio customizado no painel da Vercel
  - [ ] Atualizar URLs de redirect no Supabase Auth (OAuth callback)

---

## FASE 2 — Torre de Controle: fechar pendências do Financeiro
*Objetivo: gestão com visão completa de lucratividade (já bem avançada, faltam refinamentos).*

- [ ] Pagamento parcelado (installments)
- [ ] Pagamento parcial / saldo devedor
- [ ] Tela de pagamento de comissões aos profissionais
- [ ] Juros e multa em contas vencidas
- [ ] Conta bancária vinculada por transação
- [ ] Caixa pequeno (lançamento rápido)
- [ ] Projeção de fluxo de caixa 30/60/90 dias
- [ ] Competência vs caixa no DRE
- [ ] Convênios/planos de saúde
- [ ] Fechamento de período contábil

---

## FASE 3 — Painel da Recepção (a Concierge Humana)
*Objetivo: a IA cuida da burocracia, a recepção cuida do acolhimento.*

- [ ] Lembretes automáticos de consulta (WhatsApp)
- [ ] Sofia (SDR de IA) integrada ao n8n
- [ ] **Projeto Lazaro — Parte B (depende da Sofia ativa):** quando um lead entra em "Leads Frios" (já automatizado no CRM — ver Fase 1), disparar conteúdo semanal automático sobre o que ele buscava, sem prazo para acabar. Se o lead responder, volta sozinho ao funil ativo.
- [ ] Notificações de confirmação de consulta

---

## FASE 4 — Painel do Profissional (o foco no humano)
*Objetivo: zero burocracia, máximo "olho no olho" com o paciente.*

- [ ] Prontuário clínico completo (anamnese, evoluções, prescrições, laudos)
- [ ] Resumo gerado por IA do histórico do paciente (co-piloto silencioso)
- [ ] Transcrição de consulta (Groq) + resumo automático (Gemini)
- [ ] Assinatura digital

---

## FASE 5 — Hub do Paciente (o grande diferencial de mercado)
*Objetivo: estender a clínica até o bolso do paciente — fidelização absurda.*

- [ ] Portal do paciente (web/app)
- [ ] Exames lado a lado mostrando evolução, laudos fáceis de ler
- [ ] Lembretes de horários de suplementação
- [ ] Receitas saudáveis sugeridas conforme fase do protocolo
- [ ] Canal direto de comunicação com a equipe da clínica
- [ ] Dicas curtas de saúde / conteúdo de comunidade

---

## 🎯 Regra de ouro

> O que evita caos na clínica vem primeiro:
> **Agenda > Prontuário > Financeiro > Automações**

Se uma ideia nova surgir no meio do caminho, anote ela na fase certa acima — não pare a fase atual para perseguir ela.
