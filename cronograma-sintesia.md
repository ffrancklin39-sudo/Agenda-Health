# Cronograma SintesIA — Plano Completo (As 4 Pontas)

**Atualizado em:** 2026-06-25 (Camada 2 do CRM fechada + captura de lead validada)
**Como usar:** siga as fases NA ORDEM. Marque `[x]` quando terminar. Não pule fases — cada una destrava a próxima.
**Ritmo:** Seg–Sáb · ~3h/dia · 1 sessão = 1 dia de trabalho

---

## 📍 Onde você está agora (Jun 22, 2026)

**Funcionando:** Dashboard, CRM Inteligente (Camada 1 + boa parte da Camada 2), Agenda, Pacientes, Tarefas, Financeiro (5 sub-abas), BI & Margem, Relatórios (11), Configurações, Serviços (CRUD), Anamnese (builder + aba no perfil), **Sofia 2.0 publicada em produção** (captura de lead sempre ativa, resposta da IA com kill-switch desligado).

**⚠️ Por que as datas abaixo mudaram:** entre 17 e 22/06 a Sofia regrediu (respondia tudo, atropelava a Nayla) e você decidiu refazer a arquitetura do zero em vez de remendar — 3º incidente do mesmo bug. Isso consumiu praticamente toda a "Sem 1" original (que era pra ser Ficha do Paciente) e parou a captura de leads no meio do caminho. Foi a prioridade certa (sem captura de lead não tem CRM), mas o cronograma não previa esse trabalho — por isso a Fase 1 está sendo reorganizada com ~5 dias de atraso real.

**✅ Correção 2026-06-23:** as abas Prescrições, Linha do Tempo e Documentos/Exames do PatientProfile já estavam implementadas e commitadas desde 2026-06-15 (`8844032`, `bb5ed56`, `e1e5671`) — este documento não tinha sido atualizado após a entrega. Marcadas como concluídas abaixo. Pendente real da Fase 1 agora é só validar a captura de lead real da Sofia 2.0 e a Camada 2 do CRM.

**Pendente na Camada 2:** sugestão de próxima melhor ação + rascunho de mensagem (IA).

**✅ Correção 2026-06-24:** as três pendências abaixo já estavam resolvidas, só não tinham sido marcadas:
- `sql/services_add_description.sql` já tinha sido rodado — coluna `description` confirmada na tabela `services`.
- Commit de checkpoint já tinha sido feito em 2026-06-23 (`6bd5c40`, `6f3cfb0`) — `HEAD` local está igual a `origin/main`, nada pendente para commitar ou dar push.
- Bug de sintaxe no node `PODE_SOFIA_RESPONDER` (chave extra) que travava toda a captura de leads/pacientes foi corrigido e publicado — testado com "Execute step" e confirmado sem erro.

**✅ Correção 2026-06-24 (segurança):** ao verificar o `fix_rls_security.sql` da auditoria de 06-09, descobrimos que ele tinha rodado mas não removeu as políticas antigas (`patients_select/insert/update/delete` e `appointments_select/insert/update/delete`, todas `roles = {public}`) porque o `DROP POLICY` usava nomes diferentes dos reais. Ou seja, `patients` e `appointments` continuavam abertos a qualquer um com a anon key mesmo depois do "fix". Políticas antigas removidas agora — confirmado que só restam policies `{authenticated}` nessas duas tabelas.

**✅ Correção 2026-06-25:** Camada 2 do CRM fechada — sugestão de próxima melhor ação + rascunho de mensagem implementados (`ai_next_action`/`ai_message_draft`, reaproveitando a mesma chamada do Gemini que já gerava resumo/temperatura). Captura de lead real da Sofia 2.0 também validada: lead "Rosana" entrou com telefone real em 24/06, confirmando que o fix do `PODE_SOFIA_RESPONDER` está funcionando ponta a ponta em produção.

**Pendente real agora:** Fase 1 está praticamente fechada — falta só a migração de domínio próprio (tarefa sua, DNS/Vercel/Supabase Auth) e a aba "Resumos de IA" do PatientProfile (extra, fora do plano original, ainda placeholder). Próximo passo natural é avançar para a Fase 2 (Financeiro).

---

## FASE 1 — Fechar a base operacional
*Objetivo: ninguém trava no dia a dia da clínica.*
*🏁 Meta: ~~24 de junho~~ → 29 de junho de 2026 (ajustado pelo desvio da Sofia)*

### CRM Inteligente

- [x] **Automação Projeto Lazaro — Parte A:** lead parado 7+ dias → "Leads Frios" + notificação ✅ 2026-06-06

**🟢 Camada 1 — Inteligência sobre dados existentes** ✅ concluída em 2026-06-06
- [x] Timeline de interações por lead (histórico cronológico)
- [x] Lead scoring baseado no histórico real de conversões
- [x] Painel de saúde do funil (alertas automáticos)
- [x] Atribuição de responsável por lead

**🟡 Camada 2 — Inteligência conversacional (Gemini/Groq já instalados)**
- [x] Resumo automático do histórico do paciente ✅ 2026-06-16
- [x] Análise de interesse/urgência (IA lê contexto e sinaliza "lead quente") ✅ 2026-06-16
- [x] Captura automática de leads — WhatsApp via n8n ✅ 2026-06-16 (depois refeita do zero, ver abaixo)
- [x] Sugestão de próxima melhor ação ✅ 2026-06-25 (`ai_next_action`, mesma chamada do resumo IA)
- [x] Rascunho de mensagem personalizada para revisão humana ✅ 2026-06-25 (`ai_message_draft`, botão "Copiar" no painel do lead — nunca enviado automaticamente)

**⚪ Fora do plano original — redesenho completo da Sofia (3º incidente do bug @lid/handoff)**
- [x] Diagnóstico da causa raiz (resolução de identidade espalhada pelo fluxo) ✅ 2026-06-17
- [x] Arquitetura definitiva documentada (`docs/sofia-arquitetura-definitiva.md`) ✅ 2026-06-17
- [x] Separação `CAPTURA_LEAD` (sempre ativa) / `SOFIA_RESPONDE` (opcional, kill-switch) ✅ 2026-06-18
- [x] Testes da Fase 1 do plano de testes (cenários 1–7) ✅ 2026-06-18
- [x] Publicação em produção como "Sofia 2.0 - Produção", Sofia OFF via `SOFIA_GLOBAL_ATIVA` ✅ 2026-06-22
- [x] Validar captura de lead real (primeiro contato de paciente) ✅ 2026-06-25 (lead "Rosana", telefone real, capturado em 24/06 após o fix do `PODE_SOFIA_RESPONDER`)

### Controle de acesso por papel (ADMIN / RECEPTIONIST / DOCTOR) `[Jun 26]`
**Adicionado em 2026-06-25** — não estava no cronograma ainda, só na visão original (`sintesia_vision.md`). Investigado o código real: a "casca" de UI já existe (Sidebar já filtra menu por `roles: string[]` por item) e funcionaria hoje mesmo, mas `userRole` está hardcoded em `'ADMIN'` em `App.tsx` porque a tabela `profiles` (de onde o role real viria) nunca foi criada no Supabase. Não há nenhuma policy RLS diferenciando por role hoje (é authenticated-or-nothing em tudo), a aba "Usuários" em Settings é 100% estática/placeholder, e não existe vínculo entre login (`auth.users`) e a tabela `professionals` — então "médico só vê os próprios pacientes" ainda não é possível estruturalmente.
- [x] Tabela `profiles` (id, role, email) + trigger de auto-criação no signup ✅ 2026-06-25 (SQL pronto em `sql/profiles_and_roles.sql` — backfill dos 2 logins atuais como ADMIN, novos signups entram como RECEPTIONIST. **Falta rodar no Supabase** — tem `CREATE POLICY`/RLS, então é o usuário quem clica "Run", não eu.)
- [ ] Atribuir role real aos 2 logins existentes — automático no backfill do SQL acima; revisar depois de rodar se algum dos 2 deveria ser DOCTOR/RECEPTIONIST em vez de ADMIN
- [x] Aba "Usuários" funcional em Settings (listar/atribuir role) ✅ 2026-06-25 — lista `profiles`, ADMIN troca o papel de cada usuário num select. Criar novo login ainda é manual no Supabase Auth (sem API admin no frontend); aparece aqui sozinho depois.
- [x] Aplicar checagem de role *dentro* das abas restritas ✅ 2026-06-25 — guard real em `App.tsx` (`canAccessTab`, reaproveita o mesmo mapa de roles do Sidebar) bloqueia o conteúdo de Finance/Settings/BI/Reports mesmo que `activeTab` mude por outro caminho, não só esconder o botão.
- [ ] Decidir e implementar RLS por role em `patients`/`appointments`/etc. (defesa em profundidade — hoje a trava é só no app, não no banco)
- [ ] Vincular `professionals.user_id` → `auth.users.id` (necessário se "DOCTOR só vê seus próprios pacientes/agenda" for a regra desejada — decisão de negócio em aberto, decidir depois)

**🔴 Camada 3 — Automação autônoma (parcialmente destravada agora que a Sofia 2.0 está publicada)**
- [ ] Inbox omnichannel (WhatsApp + Instagram + site)
- [ ] Agente autônomo cuidando do funil (Sofia agenda, confirma, move lead)
- [ ] Projeto Lazaro Parte B (nutrição contínua de leads frios) — ver Fase 3, pode adiantar agora que `conversation_state` já existe

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

### Ficha completa do paciente (PatientProfile) ✅ concluída em 2026-06-15

- [x] Anamnese estruturada — builder drag-drop + aba de preenchimento ✅ 2026-06-09
- [x] Histórico de agendamentos — aba com dados reais do Supabase ✅ 2026-06-09
- [x] Evolução clínica — coberta pelos templates do tipo "evolucao" no builder ✅
- [x] Prescrições e orientações — builder de modelos + preenchimento + impressão ✅ 2026-06-15
- [x] Linha do tempo clínica unificada — dados do Feegow + filtro por tipo ✅ 2026-06-15
- [x] Documentos e exames — upload, preview e agrupamento por pasta via Supabase Storage ✅ 2026-06-15
- [ ] (extra, fora do plano original) Aba "Resumos de IA" — ainda é placeholder em `PatientProfile.tsx`

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

## Módulo de Contratos `[Jul 2026]`

> Gerar contratos de tratamento automaticamente com dados do paciente, serviços contratados, forma de pagamento — entrega PDF pronto pra imprimir ou enviar pro paciente assinar. Assinatura digital (Clicksign/DocuSign) é fase 2 deste módulo.

**Banco de dados**
- [ ] Tabela `contracts` — `patient_id`, `professional_id`, `items` (JSONB: lista de serviços/pacotes + valores), `payment_method`, `total_amount`, `status` (draft/active/signed), `notes`, `created_at`
- [ ] SQL + RLS (só ADMIN cria/visualiza contratos)

**Frontend**
- [ ] Botão "Novo contrato" no perfil do paciente (aba nova ou modal)
- [ ] Cabeçalho auto-preenchido: nome, CPF, endereço, data de nascimento do `patients`
- [ ] Seletor de itens contratados (busca nos `services` cadastrados + campo livre pra pacote)
- [ ] Seletor de forma de pagamento (reusa `PaymentMethodFull`) + campo de valor/parcelamento
- [ ] Preview do contrato antes de gerar PDF
- [ ] Geração de PDF com `@react-pdf/renderer` — layout com logo da clínica, dados do paciente, tabela de itens, assinatura no rodapé
- [ ] Histórico de contratos do paciente (listagem com status e download)

**Fase 2 (depois)**
- [ ] Assinatura digital via Clicksign ou DocuSign API
- [ ] Envio do contrato por WhatsApp (link ou PDF direto via WAHA)
- [ ] Template personalizável por tipo de tratamento

---

## FASE 6 — Preparação para Comercialização (Multi-clínica)
*Objetivo: tornar o SintesIA vendável para outras clínicas sem que cada venda exija uma implantação manual completa.*
*🏁 Meta: sem data fixa — revisitar com prioridade antes de fechar a primeira venda para uma 2ª clínica.*

**Contexto (2026-06-25):** discutimos a comercialização do SintesIA para outras clínicas. A separação "CRM com/sem Sofia" já funciona bem (captura automática e resposta automática são chaves independentes desde a arquitetura definida em `docs/sofia-arquitetura-definitiva.md`), então isso não é bloqueio. Os pontos reais a resolver antes de vender para uma 2ª clínica:

- [ ] Arquitetura multi-tenant: hoje é um Supabase + Vercel + workflow n8n + número WAHA por clínica (sem `clinic_id` em nenhuma tabela) — cada venda = implantação manual completa, não escala
- [ ] Expor o toggle "Sofia ativa" em `clinic_settings`/aba Configurações do app, em vez de ser uma variável só editável por mim no n8n
- [ ] Isolar cota/billing do Gemini por clínica (hoje é uma chave global única, sem atribuição de uso por cliente)
- [ ] Avaliar migrar do WAHA (automação não-oficial do WhatsApp) para a WhatsApp Business API oficial — o risco de banimento de número se multiplica por clínica vendida
- [ ] Padronizar (ou eliminar via multi-tenant) o processo de onboarding de cliente novo: clonar workflow n8n, provisionar Supabase/Vercel, configurar número

**Nota:** isso não trava o roadmap atual — features novas (CRM Camada 2, etc.) continuam sendo construídas normalmente, só evitando decisões que tornem essa migração futura mais difícil do que precisa ser.

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

Se uma ideia nova surgir no meio do caminho, anote na fase certa acima — não pare a fase atual para perseguir ela.
