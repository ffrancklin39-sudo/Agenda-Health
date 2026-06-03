# 🏥 SintesIA — Documentação do Projeto

**Status:** Em desenvolvimento ativo
**Última atualização:** 2026-06-03
**Próxima prioridade:** CRM — melhorias e funcionalidades avançadas

---

## 📋 Visão Geral

SintesIA é um **ecossistema autônomo de receita (RevOps)** para clínicas de saúde integrada, impulsionado por IA.

### Stack
- **Frontend:** React 18 + Vite + TypeScript + Tailwind CSS
- **Backend:** Supabase (auth + DB realtime)
- **IA:** Google Genai (Gemini) + Groq (transcrição)
- **Automações:** n8n + Sofia (SDR de IA) — planejado
- **Deploy:** Vercel + Supabase

---

## 🗂️ Estrutura de Pastas

```
SintesIA/
├── src/
│   ├── components/
│   │   ├── Sidebar.tsx           # Nav com grupos Operacional/Administrativo
│   │   ├── App.tsx               # Roteamento principal
│   │   ├── Dashboard.tsx         # ✅ Funcional
│   │   ├── CRMi.tsx              # ✅ Kanban drag-drop, lembretes, PaymentModal
│   │   ├── PatientList.tsx       # ✅ Lista com filtros
│   │   ├── PatientProfile.tsx    # ✅ Perfil completo + aba Financeiro
│   │   ├── Agenda.tsx            # ⏳ UI pronta, lógica incompleta
│   │   ├── Automations.tsx       # ⏳ Planejado
│   │   ├── Finance.tsx           # ✅ Reestruturado com 5 sub-abas
│   │   ├── ServicesCatalog.tsx   # ⚠️ UI apenas
│   │   ├── Settings.tsx          # ✅ Com aba Financeiro
│   │   ├── Tasks.tsx             # ✅ Funcional
│   │   └── Login.tsx             # ✅ Supabase Auth
│   │
│   ├── components/admin/
│   │   ├── FinancialSettings.tsx      # Configurações fiscais globais
│   │   ├── PaymentRegisterModal.tsx   # Modal de pagamento com cálculo automático
│   │   ├── finance/
│   │   │   ├── CaixaDiario.tsx        # Caixa do dia/semana/mês
│   │   │   ├── Lancamentos.tsx        # Histórico unificado payments+bills
│   │   │   ├── ContasPagar.tsx        # Gestão de despesas (bills)
│   │   │   └── ContasReceber.tsx      # Pagamentos pendentes
│   │   └── reports/
│   │       ├── DRE.tsx
│   │       ├── CommissionsReport.tsx
│   │       ├── RevenueByService.tsx
│   │       ├── Inadimplencia.tsx
│   │       ├── PatientRetention.tsx
│   │       ├── LTV.tsx
│   │       ├── LeadOrigin.tsx
│   │       ├── AgendaOccupancy.tsx
│   │       ├── NoShow.tsx
│   │       ├── MarginEvolution.tsx
│   │       └── ChairEfficiency.tsx
│   │
│   ├── components/bi/
│   │   ├── ProfitDashboard.tsx        # Ranking de lucratividade por procedimento
│   │   └── ProcedurePricingForm.tsx   # Cadastro de precificação
│   │
│   ├── services/
│   │   └── supabaseClient.ts
│   ├── types.ts              # Todas as interfaces TypeScript
│   ├── constants.tsx
│   ├── phoneUtils.ts
│   └── main.tsx
│
├── sql/                      # Scripts SQL para o Supabase
│   ├── bi_profitability.sql        # procedures_pricing + vw_procedure_profitability
│   ├── seed_procedures_pricing.sql # Seed dos 30 serviços com price > 0
│   ├── payments_and_triggers.sql   # payments + commission_ledger + triggers
│   └── financial_core.sql         # bills + clinic_settings + vw_cash_flow
│
└── docs/
    └── manual-financeiro-sintesia.md
```

---

## 🗄️ Banco de Dados — Tabelas Existentes no Supabase

### Tabelas principais (já criadas e funcionando)

| Tabela | Status | Descrição |
|--------|--------|-----------|
| `patients` | ✅ | Pacientes/leads com todos os campos clínicos |
| `professionals` | ✅ | Profissionais com agenda e comissão |
| `services` | ✅ | Catálogo de serviços/procedimentos |
| `appointments` | ✅ | Agendamentos vinculados a paciente+profissional+serviço |
| `payments` | ✅ | Pagamentos reais com cálculo automático via trigger |
| `commission_ledger` | ✅ | Comissões geradas automaticamente |
| `procedures_pricing` | ✅ | Precificação por serviço (custo, imposto, comissão, taxas) |
| `bills` | ✅ | Contas a pagar (despesas fixas e avulsas) |
| `clinic_settings` | ✅ | Configurações globais da clínica (chave/valor) |

### Views (geradas automaticamente)

| View | Descrição |
|------|-----------|
| `vw_procedure_profitability` | Ranking de procedimentos por margem real |
| `vw_payments_full` | Payments enriquecido com nomes de paciente/profissional/serviço |
| `vw_cash_flow` | União de payments (entradas) + bills (saídas) |
| `vw_monthly_balance` | Saldo mensal automático |
| `vw_bills_upcoming` | Contas vencendo nos próximos 30 dias |
| `vw_commission_summary` | Resumo de comissões por profissional e mês |
| `vw_dre_monthly` | DRE mensal automático |
| `vw_revenue_by_service` | Receita e margem por serviço |

### Triggers automáticos em `payments`
- `trg_auto_calculate_payment` — calcula taxa, imposto, comissão e lucro real ao inserir
- `trg_create_commission_on_insert` — cria entrada no commission_ledger quando status = 'paid'
- `trg_create_commission_entry` — atualiza commission_ledger quando status muda

---

## 📱 Status das Abas

### Sidebar — Grupo OPERACIONAL
| Aba | Status | Observações |
|-----|--------|-------------|
| Dashboard | ✅ | KPIs, funil, métricas |
| Agenda | ⏳ | UI pronta, lógica de criação/edição incompleta |
| CRMi | ✅ | Kanban drag-drop, PaymentModal ao confirmar |
| Pacientes | ✅ | Lista, filtros, perfil completo |
| Tarefas | ✅ | Funcional |
| Automações | ⏳ | UI apenas |
| Serviços | ⚠️ | UI apenas |

### Sidebar — Grupo ADMINISTRATIVO
| Aba | Status | Observações |
|-----|--------|-------------|
| Financeiro | ✅ | 5 sub-abas: Visão Geral, Caixa, Lançamentos, Contas a Pagar, Contas a Receber |
| BI & Margem | ✅ | ProfitDashboard + ProcedurePricingForm |
| Relatórios | ✅ | 11 relatórios implementados com filtros e exportação CSV |
| Configurações | ✅ | Profissionais, Serviços, Clínica, Financeiro, Usuários |

---

## 💳 Fluxo de Pagamento

1. Paciente confirmado no CRM → `PaymentRegisterModal` abre automaticamente
2. Gestora informa: valor real, método de pagamento, data
3. Trigger do Postgres calcula automaticamente: taxa, ISS, comissão, lucro
4. `commission_ledger` é populado automaticamente
5. `vw_cash_flow`, DRE e relatórios se atualizam em tempo real

---

## 🔢 Tipos de Pagamento (PaymentMethodFull)
```typescript
type PaymentMethodFull = 'pix' | 'debit' | 'credit_1x' | 'credit_2_6x' | 'credit_7x_plus' | 'cash' | 'transfer' | 'check';
```
⚠️ `'credit_card'` NÃO existe mais — foi substituído pelos tipos acima.

---

## 📊 O que o Módulo Financeiro faz automaticamente
- Calcula imposto, taxa da maquininha e comissão a cada pagamento
- Gera próximas ocorrências de contas recorrentes (bills)
- Marca bills como `overdue` automaticamente
- Atualiza caixa, lançamentos e relatórios em tempo real
- Sinaliza pacientes atendidos sem pagamento registrado

---

## 🚧 Pendências Conhecidas do Módulo Financeiro
(em ordem de prioridade — próximas sessões)

1. Pagamento parcelado do paciente (installments)
2. Pagamento parcial / saldo devedor
3. Tela de pagamento de comissões aos profissionais
4. Juros e multa em contas vencidas
5. Conta bancária vinculada por transação
6. Caixa pequeno (lançamento rápido)
7. Projeção de fluxo de caixa 30/60/90 dias
8. Competência vs caixa no DRE
9. Convênios/planos de saúde (projeto separado)
10. Fechamento de período contábil

---

## 🔐 Credenciais

```
VITE_SUPABASE_URL=https://iudghjdmfcxjcpspeify.supabase.co
VITE_SUPABASE_ANON_KEY=[ver .env.local]
```
⚠️ NUNCA commitar `.env.local`

---

## 🚀 Como Rodar Localmente

```bash
npm install
npm run dev      # porta 5173
npm run build    # build produção
```

---

## 🔗 Integrações

| Sistema | Status |
|---------|--------|
| Supabase | ✅ Auth + DB + Realtime |
| Vercel | ✅ Deploy automático via GitHub |
| Google Genai | ✅ Instalado |
| Groq | ✅ Instalado |
| n8n | 📋 Planejado |
| Sofia (SDR) | 📋 Planejado |
| WhatsApp API | 📋 Pendente |
| Feegow | ✅ Dados migrados (backup em pasta separada) |

---

## 👤 Owner: Francklin
**Contato:** ffrancklin.39@gmail.com
**Empresa:** Clínica de Saúde Integrada (esposa)
