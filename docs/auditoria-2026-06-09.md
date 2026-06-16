# 🔍 Auditoria SintesIA — 09/06/2026

Análise completa do projeto: código, segurança, arquitetura e comparação com os líderes de mercado.

---

## ✅ O que já foi corrigido nesta sessão

**1. Bug crítico no CRM — pacientes clínicos viravam "Leads Frios"**
A automação de leads frios (`CRMi.tsx`) verificava apenas o status, sem checar `is_lead`. Resultado: pacientes clínicos migrados do Feegow com status antigo de funil eram movidos automaticamente para "Leads Frios" (status `discarded`), corrompendo dados. Corrigido: a automação agora só atua em leads reais do CRM.

**2. Chave hardcoded removida do código**
`supabaseClient.ts` tinha URL e chave embutidas como fallback. Agora exige as variáveis de ambiente e falha com mensagem clara se faltarem.

**3. `.gitignore` reescrito**
Estava corrompido (entradas duplicadas com aspas) e não ignorava `.env.local`, `dist` nem os dados de pacientes. Reescrito do zero.

**4. Dados sensíveis removidos do versionamento (LGPD)**
O repositório GitHub continha commitados: `.env.local` (credenciais) e `scripts/migration_output/` — **2.602 pacientes com nome, e-mail, telefone e CPF, além de prontuários em `clinical_records.json`**. Removidos do git (`git rm --cached` — os arquivos continuam no seu disco). Falta você commitar.

**5. Criado `sql/fix_rls_security.sql`** — ver ação urgente abaixo.

Verificação: `tsc --noEmit` passa sem erros após as correções.

---

## 🚨 AÇÕES URGENTES (fazer hoje, nesta ordem)

**Passo 1 — Rodar o script de segurança no Supabase.**
As políticas RLS atuais usam `USING (true)`: qualquer pessoa com a anon key (que fica visível no JavaScript do site e foi commitada no GitHub) pode **ler, alterar e apagar todos os pacientes, agendamentos e pagamentos sem fazer login**. Abra o Supabase Dashboard → SQL Editor → cole e execute `sql/fix_rls_security.sql`. O app continua funcionando normalmente depois.

**Passo 2 — Conferir se o repositório GitHub é privado.**
Repo: `ffrancklin39-sudo/Agenda-Health`. Se estiver público, torne privado imediatamente.

**Passo 3 — Commitar as mudanças desta sessão.**
```bash
git add -A
git commit -m "security: remove dados sensíveis do git, corrige RLS e bug de leads frios"
git push
```

**Passo 4 — Limpar o histórico do git (esta semana).**
Mesmo removidos agora, os CPFs e credenciais continuam nos commits antigos. Recomendo o caminho mais simples: criar um repositório novo e privado, e fazer um push apenas do estado atual. Depois, no Supabase Dashboard → Settings → API, rotacionar o JWT secret (invalida a anon key vazada) e atualizar `.env.local` + variáveis do Vercel.

---

## 🐛 Problemas encontrados (não corrigidos — decidir juntos)

**Papel padrão é ADMIN** — em `App.tsx`, `userRole` inicia como `'ADMIN'`. Usuário sem linha na tabela `profiles` vê o menu completo de administrador. A proteção real virá das políticas RLS por papel (fase 2 do script de segurança). Sugestão: padrão `'RECEPTIONIST'` + garantir que todo usuário tenha profile.

**Dashboard mostra faturamento "estimado", não real** — o card Faturamento soma `patients.price` (valor do deal no CRM), não a tabela `payments` (valores reais com data de pagamento). Os números do Dashboard e do módulo Financeiro divergem. Sugestão: ler de `vw_payments_full`, que já existe.

**Código morto** — `AgendaNew.tsx` (553 linhas) e `FinanceNew.tsx` (393 linhas) não são importados por ninguém. ~950 linhas confundindo a manutenção. Sugestão: apagar (ficam no histórico do git se precisar).

**Automação de leads frios roda no navegador** — executa a cada 60s em cada aba aberta de cada usuário; com 2 pessoas usando, são gravações duplicadas concorrentes. Sugestão: mover para `pg_cron` no Supabase (1×/dia) — o front só exibe.

**Pagamento pode ser registrado em duplicidade** — o `PaymentRegisterModal` não vincula `appointment_id` nem verifica pagamento existente. Arrastar o card para fora e de volta para "Atendidos" cria dois pagamentos (e duas comissões).

**`alert()`/`confirm()` nativos em ~15 pontos** — quebram a experiência visual; o Agenda já tem sistema de toast, vale generalizar.

**Escala futura** — todos os ~2.600 pacientes são carregados em memória no login. Funciona bem hoje; quando passar de ~10 mil, paginar com busca server-side.

---

## 🏆 Comparação com os líderes do mercado

**Onde o SintesIA já está à frente:**
O cálculo de lucro real por procedimento (taxa de maquininha + ISS + comissão + insumos por transação, via trigger) é um diferencial que nem Feegow nem iClinic entregam nativamente — é o coração do conceito RevOps. O lead scoring no Kanban e a detecção de duplicados por telefone (com tratamento do nono dígito) são features de CRM maduro — Zoho e LeadSquared cobram caro por isso.

**Onde os líderes estão à frente (em ordem de impacto para a clínica):**

1. **Confirmação automática via WhatsApp** — padrão em Feegow, Clinicorp e Amplimed; é a feature com maior ROI comprovado (redução de no-show; WhatsApp tem ~90% de taxa de abertura). Vocês já têm n8n + WAHA no ar para a Sofia — dá para reaproveitar a infraestrutura.
2. **Agendamento online pelo paciente** — link público onde o paciente escolhe horário (iClinic/Doctoralia). Reduz trabalho da recepção e captura leads fora do horário comercial.
3. **Orçamentos e pacotes por sessão** — o Clinicorp domina clínicas de estética com controle de tratamentos longos (ex.: 10 sessões de criolipólise, sessão 3/10). O campo `session_number` já existe em `appointments` — falta a camada de orçamento/pacote com pagamento parcelado (que já é a pendência nº 1 do financeiro).
4. **Cadência automática de follow-up** — nos CRMs líderes, lead parado dispara sequência de mensagens automáticas, não só vai para "Leads Frios". É exatamente o Projeto Lazaro/Sofia — a comparação confirma que a prioridade está certa.
5. **IA nativa de gestão** — Clinicorp IA responde perguntas sobre os dados da clínica. Com Gemini já instalado e as views prontas (`vw_dre_monthly`, `vw_cash_flow`), um "pergunte aos seus dados" é viável em poucos dias.

**O que NÃO copiar agora:** TISS/convênios (já está corretamente adiado), telemedicina e estoque — complexidade alta, retorno baixo para o momento da clínica.

---

## 🗺️ Roadmap sugerido (ordem de prioridade)

1. **Segurança/LGPD** (passos urgentes acima) — antes de qualquer feature nova.
2. **Confirmação de consulta via WhatsApp** (n8n + WAHA existentes) — maior ROI imediato.
3. **Pagamento parcelado/parcial** — já era a pendência nº 1; destrava orçamentos por pacote.
4. **Dashboard com faturamento real** (ler de `payments`).
5. **Mover automação de leads frios para o servidor** (pg_cron).
6. **Agendamento online público** — diferencial competitivo.
7. **Limpeza técnica**: apagar AgendaNew/FinanceNew, trocar alert/confirm por toasts.

---

*Auditoria gerada em 09/06/2026. Correções aplicadas verificadas com `tsc --noEmit` (zero erros).*
