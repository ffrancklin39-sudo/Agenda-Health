export enum PatientStatus {
  LEAD = 'lead',
  NEGOTIATION = 'negotiation',
  WAITING = 'waiting',
  SCHEDULED = 'scheduled',
  CONFIRMED = 'confirmed',
  DISCARDED = 'discarded'
}

export type UserRole = 'ADMIN' | 'DOCTOR' | 'RECEPTIONIST';

export interface Patient {
  id: string;
  name: string;
  email: string;
  phone: string;

  // Identidade
  social_name?: string;
  cpf?: string;
  rg?: string;
  cns?: string;
  birth_date?: string;
  date_of_birth?: string;
  gender?: string;
  skin_color?: string;
  civil_status?: string;
  profession?: string;
  education?: string;
  religion?: string;
  nationality?: string;
  birthplace?: string;

  // Dados fisicos
  height?: number;
  weight?: number;
  blood_type?: string;

  // Sistema / CRM
  status: string;
  source?: string;
  record_number?: string;
  priority?: string;
  alerts?: string;
  /** Profissional/atendente responsável por este lead no funil (id de `professionals`) */
  assigned_to?: string;

  // Contatos extras
  phone2?: string;
  cell2?: string;
  email2?: string;
  instagram?: string;

  // Endereco
  address?: string;
  address_number?: string;
  address_complement?: string;
  neighborhood?: string;
  zip_code?: string;
  city?: string;
  state?: string;
  country?: string;

  // Convenio
  insurance?: string;
  insurance_plan?: string;
  insurance_card?: string;
  insurance_expires?: string;
  insurance_holder?: string;

  // Agendamento
  appointmentDate?: string;
  appointment_date?: string;
  professionalId?: string;
  professional_id?: string;
  serviceId?: string;
  service_id?: string;
  duration_minutes?: number;

  // Financeiro
  price?: number;
  last_payment_date?: string;

  // Lembretes
  reminderDate?: string;
  reminder_date?: string;
  reminderNote?: string;
  reminder_note?: string;
  reminderExecuted?: boolean;
  reminder_executed?: boolean;

  // Clinico
  medical_notes?: string;
  observation?: string;
  notes?: any[];
  history?: any[];
  attachments?: any[];

  // Metadata
  created_at?: string;
  updated_at?: string;
  stage_entered_at?: string;

  // IA — Camada 2 (resumo + lead quente, Gemini)
  ai_summary?: string;
  ai_summary_updated_at?: string;
  lead_temperature?: 'quente' | 'morno' | 'frio' | string;
  lead_temperature_reason?: string;
}

export interface Professional {
  id: string;
  name: string;
  title?: string;
  specialty: string;
  color: string;
  email?: string;
  phone?: string;
  phone2?: string;
  gender?: string;
  birth_date?: string;
  cpf?: string;
  cns?: string;
  council?: string;
  council_number?: string;
  council_uf?: string;
  rqe?: string;
  social_name?: string;
  observation?: string;
  active?: boolean;
  created_at?: string;
  updated_at?: string;
}

/** Um intervalo de atendimento (ex: 09:00–12:00). Um dia pode ter vários,
 *  permitindo representar intervalo de almoço (09-12 e 14-19, por exemplo). */
export interface ProfessionalScheduleSlot {
  id?: string;
  professional_id: string;
  day_of_week: number; // 0=domingo ... 6=sábado (igual Date.getDay())
  start_time: string;  // 'HH:MM' ou 'HH:MM:SS'
  end_time: string;
}

export interface ClinicService {
  id: string;
  name: string;
  price: number;
  duration: number;
  duration_minutes?: number;
  category: string;
  description?: string;
  created_at?: string;
  updated_at?: string;
}

export interface Appointment {
  id: string;
  patient_id: string;
  patient_name?: string;
  professional_id: string;
  service_id: string;
  date_time: string;
  duration_minutes: number;
  status: 'scheduled' | 'confirmed' | 'completed' | 'cancelled' | 'no_show';
  notes?: string;
  series_id?: string;
  session_number?: number;
  /** Agrupa múltiplos procedimentos do mesmo atendimento/visita (ex.: limpeza de pele + criolipólise na mesma sessão) */
  group_id?: string;
  created_at?: string;
  updated_at?: string;
}

export type PaymentMethodFull =
  | 'pix'
  | 'debit'
  | 'credit_1x'
  | 'credit_2_6x'
  | 'credit_7x_plus'
  | 'cash'
  | 'transfer'
  | 'check';

export type PaymentStatus = 'pending' | 'paid' | 'refunded' | 'cancelled';
export type CommissionStatus = 'pending' | 'paid' | 'cancelled';

export const PAYMENT_METHOD_LABELS: Record<PaymentMethodFull, string> = {
  pix:            'PIX',
  debit:          'Débito',
  credit_1x:      'Crédito 1x',
  credit_2_6x:    'Crédito 2–6x',
  credit_7x_plus: 'Crédito 7x+',
  cash:           'Dinheiro',
  transfer:       'Transferência',
  check:          'Cheque',
};

export interface Payment {
  id: string;
  patient_id: string;
  appointment_id?: string;
  professional_id?: string;
  service_id?: string;
  amount: number;
  payment_method: PaymentMethodFull;
  status: PaymentStatus;
  payment_date?: string;
  due_date?: string;

  // Campos calculados automaticamente pelo trigger
  payment_fee_pct?:    number;
  payment_fee_amount?: number;
  tax_pct?:            number;
  tax_amount?:         number;
  net_revenue?:        number;
  commission_pct?:     number;
  commission_amount?:  number;
  fixed_cost?:         number;
  real_profit?:        number;
  margin_pct?:         number;
  pricing_source?:     'procedures_pricing' | 'default';

  notes?: string;
  created_at?: string;
  updated_at?: string;
}

/** Row da view vw_payments_full — inclui nomes de paciente, profissional e serviço */
export interface PaymentFull extends Payment {
  patient_name?:             string;
  professional_name?:        string;
  professional_specialty?:   string;
  service_name?:             string;
  service_category?:         string;
}

export interface CommissionLedger {
  id: string;
  payment_id: string;
  professional_id?: string;
  patient_id?: string;
  service_id?: string;

  gross_amount: number;
  net_revenue: number;
  commission_pct: number;
  commission_amount: number;
  payment_method?: PaymentMethodFull;
  payment_date?: string;

  status: CommissionStatus;
  paid_at?: string;
  paid_by?: string;
  payment_reference?: string;

  notes?: string;
  created_at?: string;
  updated_at?: string;
}

/** Row da view vw_commission_summary */
export interface CommissionSummary {
  professional_id: string;
  professional_name: string;
  specialty: string;
  color: string;
  month: string;
  transaction_count: number;
  gross_revenue: number;
  net_revenue: number;
  commission_due: number;
  commission_paid: number;
  commission_pending: number;
  status: CommissionStatus;
}

export interface PatientHistory {
  id: string;
  patient_id: string;
  event_type: 'consultation' | 'procedure' | 'payment' | 'follow_up' | 'note' | 'status_change' | 'other';
  description?: string;
  notes?: string;
  date?: string;
  professional_id?: string;
  metadata?: Record<string, any>;
  created_by?: string;
  created_at?: string;
}

// ─── BI: Lucratividade Real por Procedimento ────────────────────────────────

export type PaymentMethod = 'pix' | 'debit' | 'credit_1x' | 'credit_2_6x' | 'credit_7x_plus';

export interface ProcedurePricing {
  id: string;
  service_id: string;

  // Precificação
  base_price: number;
  fixed_cost: number;
  estimated_duration_minutes: number;

  // Taxas
  tax_percentage: number;
  commission_percentage: number;
  fee_pix: number;
  fee_debit: number;
  fee_credit_1x: number;
  fee_credit_2_6x: number;
  fee_credit_7x_plus: number;

  active?: boolean;
  notes?: string;
  created_at?: string;
  updated_at?: string;
}

/** Resultado do cálculo de lucratividade (retornado pela fn do Supabase ou calculado no front) */
export interface ProfitBreakdown {
  base_price: number;
  tax_amount: number;
  payment_fee_amount: number;
  net_revenue: number;
  commission_amount: number;
  fixed_cost: number;
  real_profit: number;
  margin_percentage: number;
}

/** Row da view vw_procedure_profitability enriquecida com o nome do serviço */
export interface ProcedureProfitability extends ProcedurePricing {
  service_name: string;
  service_category: string;

  // Cenários por método de pagamento
  profit_pix: ProfitBreakdown;
  profit_debit: ProfitBreakdown;
  profit_credit_1x: ProfitBreakdown;
  profit_credit_2_6x: ProfitBreakdown;

  // Campos derivados para ranking
  margin_pct_pix: number;
  profit_per_minute: number;
}
