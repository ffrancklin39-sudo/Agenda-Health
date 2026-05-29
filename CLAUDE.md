# 🏥 SintesIA — Documentação do Projeto

**Status:** Em desenvolvimento | **Prioridade:** Migração Feegow + Completar abas funcionais

---

## 📋 Visão Geral

SintesIA é um **ecossistema autônomo de receita (RevOps)** para clínicas de saúde integrada, impulsionado por IA.

### Componentes do Sistema
- **Frontend:** React 18 + Vite + TypeScript + Tailwind CSS
- **Backend:** Supabase (auth + DB realtime)
- **IA:** Google Genai (Gemini) + Groq (transcrição)
- **Automações:** n8n + Sofia (SDR de IA)
- **Deploy:** Vercel + Supabase

### Abas Principais
1. **Dashboard** ✅ (funcional)
2. **CRM (Kanban)** ✅ (funcional - drag-drop, lembretes, pagamentos)
3. **Pacientes** ✅ (funcional - lista com filtros)
4. **Agenda** ⏳ (UI pronta, lógica faltando)
5. **Automações** ⏳ (UI pronta, integração Sofia/n8n faltando)
6. **Financeiro** ⏳ (UI pronta, cálculos faltando)
7. **Serviços** ⚠️ (UI apenas, sem funcionalidade)
8. **Configurações** ⚠️ (UI apenas)

---

## 🗂️ Estrutura de Pastas

```
SintesIA/
├── src/
│   ├── components/           # Componentes React
│   │   ├── Sidebar.tsx
│   │   ├── App.tsx
│   │   ├── Dashboard.tsx
│   │   ├── CRMi.tsx         # Kanban de leads
│   │   ├── PatientList.tsx
│   │   ├── PatientProfile.tsx
│   │   ├── Agenda.tsx        # Calendário (incompleto)
│   │   ├── Automations.tsx
│   │   ├── Finance.tsx       # DRE (incompleto)
│   │   ├── ServicesCatalog.tsx
│   │   ├── Settings.tsx
│   │   └── Login.tsx         # Supabase Auth
│   ├── services/
│   │   └── supabaseClient.ts # Inicialização Supabase
│   ├── types.ts              # TypeScript interfaces
│   ├── constants.tsx         # Configurações globais
│   ├── phoneUtils.ts         # Helpers de telefone
│   ├── index.css             # Estilos globais
│   ├── main.tsx              # Entrypoint React
│   └── vite-env.d.ts         # Tipos do Vite
├── .env.local                # Credenciais Supabase (local)
├── .env.example
├── index.html                # HTML root
├── vite.config.ts
├── tsconfig.json
├── package.json
└── README.md
```

---

## 🗄️ Schema de Banco de Dados Esperado (Supabase)

### Tabela: `patients`
```sql
CREATE TABLE patients (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  cpf TEXT UNIQUE,
  status TEXT DEFAULT 'lead', -- lead, negotiation, waiting, scheduled, confirmed, discarded
  
  -- Agendamento
  appointment_date TIMESTAMP,
  professional_id UUID,
  service_id UUID,
  
  -- Financeiro
  price DECIMAL(10, 2),
  
  -- Lembretes
  reminder_date TIMESTAMP,
  reminder_note TEXT,
  reminder_executed BOOLEAN DEFAULT FALSE,
  
  -- Histórico & Observações
  observation TEXT,
  source TEXT, -- origem do lead (WhatsApp, Call, Indicação)
  
  -- Metadata
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Tabela: `appointments` (faltando)
```sql
CREATE TABLE appointments (
  id UUID PRIMARY KEY,
  patient_id UUID REFERENCES patients(id),
  professional_id UUID REFERENCES professionals(id),
  service_id UUID REFERENCES services(id),
  
  date_time TIMESTAMP NOT NULL,
  duration_minutes INTEGER, -- 30, 45, 60, 90
  status TEXT DEFAULT 'scheduled', -- scheduled, confirmed, completed, cancelled
  notes TEXT,
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Tabela: `payments` (faltando)
```sql
CREATE TABLE payments (
  id UUID PRIMARY KEY,
  patient_id UUID REFERENCES patients(id),
  appointment_id UUID REFERENCES appointments(id),
  
  amount DECIMAL(10, 2) NOT NULL,
  status TEXT DEFAULT 'pending', -- pending, paid, refunded
  payment_method TEXT, -- pix, credit_card, cash
  payment_date TIMESTAMP,
  
  professional_id UUID REFERENCES professionals(id),
  commission_percentage DECIMAL(5, 2),
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Tabela: `patient_history` (faltando)
```sql
CREATE TABLE patient_history (
  id UUID PRIMARY KEY,
  patient_id UUID REFERENCES patients(id),
  
  date TIMESTAMP DEFAULT NOW(),
  event_type TEXT, -- consultation, procedure, payment, follow_up
  notes TEXT,
  created_by TEXT, -- usuário que criou
  
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Tabela: `professionals` (parcial)
```sql
CREATE TABLE professionals (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  specialty TEXT,
  color TEXT, -- para UI (blue, purple, emerald)
  email TEXT,
  phone TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Tabela: `services`
```sql
CREATE TABLE services (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  price DECIMAL(10, 2),
  duration_minutes INTEGER,
  category TEXT, -- Consultas, Procedimentos, Estética
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

## 🔄 Roadmap de Implementação

### Fase 1: Estrutura Base ✅ (FAZENDO)
- [x] Reorganizar projeto (src/, components/, services/)
- [x] Criar supabaseClient.ts
- [ ] Solicitar anon_key correta
- [ ] Validar conexão com Supabase
- [ ] Documentar schema final

### Fase 2: Migração Feegow 📋
- [ ] Explorar dados/API do Feegow
- [ ] Criar scripts de ETL (Python/Node)
- [ ] Mapear campos Feegow → SintesIA
- [ ] Importar dados em lotes (com rollback)
- [ ] Validar integridade dos dados

### Fase 3: Completar Abas 🔨
- [ ] **Agenda:** Criar/editar/deletar agendamentos
- [ ] **Agenda:** Calendário com visualização diário/semanal/mensal
- [ ] **Financeiro:** Dashboard de receita
- [ ] **Financeiro:** Lista de recebimentos
- [ ] **Financeiro:** Cálculo de comissões
- [ ] **Automações:** Integração com Sofia/n8n

### Fase 4: Integrações Avançadas 🚀
- [ ] Sofia (SDR de IA) → Criar leads automaticamente
- [ ] n8n → Orquestração de workflows
- [ ] WhatsApp → Comunicação com pacientes
- [ ] Lembretes automáticos → SMS/Email
- [ ] Relatórios → Email semanal/mensal

---

## 🔐 Credenciais & Variáveis de Ambiente

### `.env.local`
```
VITE_SUPABASE_URL=https://iudghjdmfcxjcpspeify.supabase.co
VITE_SUPABASE_ANON_KEY=seu_anon_key_aqui
```

**⚠️ NUNCA commit `.env.local`** — está no `.gitignore`

---

## 🚀 Como Rodar Localmente

```bash
# Instalar dependências
npm install

# Rodar em desenvolvimento (porta 3000)
npm run dev

# Build para produção
npm run build

# Preview do build
npm run preview

# Lint/Type-check
npm run lint
```

---

## 📊 Tipos de Dados Principais

### Patient (paciente/lead)
```typescript
interface Patient {
  id: string;
  name: string;
  email: string;
  phone: string;
  status: 'lead' | 'negotiation' | 'waiting' | 'scheduled' | 'confirmed' | 'discarded';
  appointmentDate?: string;
  price?: number;
  reminderDate?: string;
  reminderNote?: string;
  history?: any[];
  attachments?: any[];
  created_at?: string;
}
```

### Appointment (agendamento)
```typescript
interface Appointment {
  id: string;
  patient_id: string;
  professional_id: string;
  service_id: string;
  date_time: string; // ISO 8601
  duration_minutes: number;
  status: 'scheduled' | 'confirmed' | 'completed' | 'cancelled';
  notes?: string;
}
```

### Payment (pagamento)
```typescript
interface Payment {
  id: string;
  patient_id: string;
  appointment_id?: string;
  amount: number;
  status: 'pending' | 'paid' | 'refunded';
  payment_method: 'pix' | 'credit_card' | 'cash';
  payment_date?: string;
  professional_id?: string;
  commission_percentage?: number;
}
```

---

## 🔗 Integrações Planejadas

| Sistema | Status | Responsabilidade |
|---------|--------|------------------|
| **Supabase** | ✅ Setup | Auth + DB realtime |
| **Google Genai** | ✅ Instalado | IA para insights |
| **Groq** | ✅ Instalado | Transcrição de áudio |
| **n8n** | 📋 Planejado | Automações de workflow |
| **Sofia (SDR)** | 📋 Planejado | Atendimento automático |
| **WhatsApp API** | 📋 Pendente | Comunicação |
| **Stripe/PagSeguro** | 📋 Pendente | Pagamentos |
| **Feegow** | 📋 Em migração | Importação de dados |

---

## 📝 Checklist Antes de Produção

- [ ] Anon_key do Supabase validada
- [ ] Schema de DB criado e testado
- [ ] Migração de dados Feegow completada
- [ ] Agenda totalmente funcional
- [ ] Financeiro com cálculos corretos
- [ ] Autenticação (login) testada
- [ ] Permissions no Supabase configuradas
- [ ] RLS (Row Level Security) implementado
- [ ] Deploy Vercel validado
- [ ] Backup de dados Feegow
- [ ] Testes de desempenho (Lighthouse)
- [ ] Documentação de usuário

---

## 👤 Owner: Francklin
**Contato:** ffrancklin.39@gmail.com
**Empresa:** Clínica de Saúde Integrada (esposa)
**Última atualização:** 2026-05-19
