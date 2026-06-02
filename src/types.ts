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
  created_at?: string;
  updated_at?: string;
}

export interface Payment {
  id: string;
  patient_id: string;
  appointment_id?: string;
  amount: number;
  status: 'pending' | 'paid' | 'refunded' | 'cancelled';
  payment_method: 'pix' | 'credit_card' | 'cash' | 'check' | 'transfer';
  payment_date?: string;
  professional_id?: string;
  commission_percentage?: number;
  commission_amount?: number;
  commission_paid?: boolean;
  notes?: string;
  created_at?: string;
  updated_at?: string;
}

export interface PatientHistory {
  id: string;
  patient_id: string;
  event_type: 'consultation' | 'procedure' | 'payment' | 'follow_up' | 'note' | 'status_change';
  description?: string;
  professional_id?: string;
  metadata?: Record<string, any>;
  created_by?: string;
  created_at?: string;
}