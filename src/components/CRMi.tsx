import React, { useState, useEffect, useRef, useMemo } from 'react';
import { DragDropContext, Droppable, Draggable, DropResult } from '@hello-pangea/dnd';
import { supabase } from '../services/supabaseClient';
import { Patient, PatientHistory, Professional } from '../types';
import { phoneMatchKey } from '../phoneUtils';
import {
  Phone, MessageCircle, DollarSign, Check, UserPlus, BellRing, Bell,
  Edit2, Trash2, AlarmClock, AlignLeft, X, Stethoscope, Search, Clock, History,
} from 'lucide-react';
import PaymentRegisterModal from './admin/PaymentRegisterModal';

// ─── CONFIGURAÇÃO DAS COLUNAS ────────────────────────────────────────────────
const COLUMNS: Record<string, { title: string; color: string; text: string; border: string; accent: string; icon: string }> = {
  lead:        { title: 'Novos Leads',    color: 'bg-indigo-50/40',  text: 'text-indigo-700',  border: 'border-indigo-100',  accent: 'bg-indigo-400',  icon: '🎯' },
  negotiation: { title: 'Em Conversa',    color: 'bg-blue-50/40',    text: 'text-blue-700',    border: 'border-blue-100',    accent: 'bg-blue-400',    icon: '💬' },
  waiting:     { title: 'Atenção Humana', color: 'bg-amber-50/40',   text: 'text-amber-700',   border: 'border-amber-100',   accent: 'bg-amber-400',   icon: '⚠️' },
  scheduled:   { title: 'Agendados',      color: 'bg-purple-50/40',  text: 'text-purple-700',  border: 'border-purple-100',  accent: 'bg-purple-400',  icon: '📅' },
  confirmed:   { title: 'Atendidos',      color: 'bg-emerald-50/40', text: 'text-emerald-700', border: 'border-emerald-100', accent: 'bg-emerald-500', icon: '✅' },
  discarded:   { title: 'Leads Frios',    color: 'bg-slate-50',      text: 'text-slate-500',   border: 'border-slate-200',   accent: 'bg-slate-400',   icon: '🧊' },
};

// ─── AUTOMAÇÃO DE FOLLOW-UP (Leads Frios) ───────────────────────────────────
// Quantos dias um lead pode ficar parado (sem mudar de coluna) antes de ser
// movido automaticamente para "Leads Frios". Ajustável aqui no futuro, ou via
// tela de Configurações se quisermos deixar configurável pela UI.
const COLD_LEAD_DAYS = 7;

// Status que contam como "funil ativo" — se o lead ficar parado aqui por tempo
// demais, ele esfria e vai para Leads Frios automaticamente.
const ACTIVE_FUNNEL_STATUSES = [
  'lead', 'negotiation', 'waiting',
  'novos leads', 'new', 'novo', 'em conversa', 'negociacao',
  'aguardando', 'humano', 'human', 'atencao',
];

// ─── ORIGENS DO LEAD ─────────────────────────────────────────────────────────
const SOURCES: Record<string, { label: string; color: string; bg: string }> = {
  instagram: { label: 'Instagram', color: 'text-pink-700',   bg: 'bg-pink-50 border-pink-200'     },
  whatsapp:  { label: 'WhatsApp',  color: 'text-green-700',  bg: 'bg-green-50 border-green-200'   },
  indicacao: { label: 'Indicação', color: 'text-blue-700',   bg: 'bg-blue-50 border-blue-200'     },
  google:    { label: 'Google',    color: 'text-orange-700', bg: 'bg-orange-50 border-orange-200' },
  site:      { label: 'Site',      color: 'text-cyan-700',   bg: 'bg-cyan-50 border-cyan-200'     },
  feegow:    { label: 'Feegow',    color: 'text-indigo-700', bg: 'bg-indigo-50 border-indigo-200' },
  outro:     { label: 'Outro',     color: 'text-slate-600',  bg: 'bg-slate-100 border-slate-200'  },
};

// ─── ESTILO DOS EVENTOS NA TIMELINE ──────────────────────────────────────────
const EVENT_STYLES: Record<string, { label: string; dot: string }> = {
  consultation: { label: 'Consulta',      dot: 'bg-blue-400' },
  procedure:    { label: 'Procedimento',  dot: 'bg-indigo-400' },
  payment:      { label: 'Pagamento',     dot: 'bg-emerald-400' },
  follow_up:    { label: 'Lembrete',      dot: 'bg-amber-400' },
  other:        { label: 'Atualização',   dot: 'bg-slate-400' },
};

// ─── PROPS ────────────────────────────────────────────────────────────────────
interface CRMiProps {
  onSelectPatient?: (id: string) => void;
  patients: Patient[];
  onRefresh: () => void;
  onSaveReminder: (id: string, date: string, note: string) => Promise<void>;
  onUpdatePatient: (id: string, updates: Partial<Patient>) => void;
  session?: any;
  /** Time da clínica — usado para atribuir um responsável a cada lead */
  professionals?: Professional[];
}

// ─── COMPONENTE ───────────────────────────────────────────────────────────────
const CRMi: React.FC<CRMiProps> = ({
  onSelectPatient,
  patients: initialPatients,
  onRefresh,
  onSaveReminder,
  session,
  professionals = [],
}) => {
  const scrollContainerRef = useRef<HTMLDivElement>(null);
  const [isDragging, setIsDragging] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');

  // Modal de Pagamento
  const [showPaymentModal, setShowPaymentModal] = useState(false);
  const [pendingDrag, setPendingDrag] = useState<{ draggableId: string; source: any; destination: any } | null>(null);
  const [paymentPatient, setPaymentPatient] = useState<Patient | null>(null);

  // Modal de Reembolso
  const [showRefundModal, setShowRefundModal] = useState(false);
  const [refundData, setRefundData] = useState<{ name: string; price: number } | null>(null);

  // Modal Novo Lead / Edição
  const [showAddModal, setShowAddModal] = useState(false);
  const [editingPatientId, setEditingPatientId] = useState<string | null>(null);
  const [newPatientData, setNewPatientData] = useState({ name: '', phone: '', email: '', source: '' });
  const [dealValue, setDealValue] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  // Modal de Exclusão de Lead
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [deletingPatient, setDeletingPatient] = useState<Patient | null>(null);
  const [deleteReason, setDeleteReason] = useState('');
  const [deleteNote, setDeleteNote] = useState('');
  const [isDeleting, setIsDeleting] = useState(false);

  // Modal de Lembrete
  const [showReminderModal, setShowReminderModal] = useState(false);
  const [selectedForReminder, setSelectedForReminder] = useState<Patient | null>(null);
  const [reminderDate, setReminderDate] = useState('');
  const [reminderNote, setReminderNote] = useState('');

  // Painel de Histórico / Timeline
  const [showHistoryPanel, setShowHistoryPanel] = useState(false);
  const [historyPatient, setHistoryPatient] = useState<Patient | null>(null);
  const [historyEvents, setHistoryEvents] = useState<PatientHistory[]>([]);
  const [loadingHistory, setLoadingHistory] = useState(false);

  // Feedback visual
  const [confirmSuccess, setConfirmSuccess] = useState<string | null>(null);
  const [dueReminders, setDueReminders] = useState<Patient[]>([]);
  const [coldLeadNotice, setColdLeadNotice] = useState<string | null>(null);

  // ── Estado local (Optimistic UI) ──────────────────────────────────────────
  const [localPatients, setLocalPatients] = useState<Patient[]>(initialPatients);

  useEffect(() => {
    setLocalPatients(initialPatients);
  }, [initialPatients]);

  // ── Atribuição de responsável ─────────────────────────────────────────────
  // Controla qual card está com o seletor de responsável aberto no momento
  const [assigningPatientId, setAssigningPatientId] = useState<string | null>(null);

  // Fecha o seletor de responsável ao clicar fora dele
  useEffect(() => {
    if (!assigningPatientId) return;
    const closeOnOutsideClick = () => setAssigningPatientId(null);
    document.addEventListener('click', closeOnOutsideClick);
    return () => document.removeEventListener('click', closeOnOutsideClick);
  }, [assigningPatientId]);

  // ── Motor de rolagem durante drag ─────────────────────────────────────────
  useEffect(() => {
    if (!isDragging) return;
    let animationFrameId: number;

    const handleMouseMove = (e: MouseEvent) => {
      if (!scrollContainerRef.current) return;
      const container = scrollContainerRef.current;
      const rect = container.getBoundingClientRect();
      const edgeThreshold = 100;
      const scrollSpeed = 15;
      const isNearRight = e.clientX > rect.right - edgeThreshold;
      const isNearLeft = e.clientX < rect.left + edgeThreshold;
      cancelAnimationFrame(animationFrameId);
      if (isNearRight || isNearLeft) {
        const scroll = () => {
          if (isNearRight) container.scrollLeft += scrollSpeed;
          if (isNearLeft) container.scrollLeft -= scrollSpeed;
          animationFrameId = requestAnimationFrame(scroll);
        };
        animationFrameId = requestAnimationFrame(scroll);
      }
    };

    window.addEventListener('mousemove', handleMouseMove);
    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      cancelAnimationFrame(animationFrameId);
    };
  }, [isDragging]);

  // ── Verificador de lembretes ──────────────────────────────────────────────
  useEffect(() => {
    const checkReminders = () => {
      const now = new Date();
      const due = localPatients.filter(p => {
        if (!p.reminderDate) return false;
        const rDate = new Date(String(p.reminderDate).substring(0, 16));
        return rDate <= now;
      });
      setDueReminders(due);
    };
    checkReminders();
    const interval = setInterval(checkReminders, 60000);
    return () => clearInterval(interval);
  }, [localPatients]);

  // ── Automação: lead esfriou → move para "Leads Frios" + notifica ─────────
  // Regra combinada com o Francklin: se o lead ficar parado por
  // COLD_LEAD_DAYS dias numa coluna do funil ativo, ele é movido sozinho
  // para "Leads Frios". A partir daí entra no fluxo do Projeto Lazaro
  // (conteúdo semanal via Sofia — Fase 3, ainda pendente de ativação):
  // ou o lead bloqueia, ou levanta a mão e volta ao funil.
  useEffect(() => {
    const checkColdLeads = () => {
      const cooled = localPatients.filter(p => {
        const status = (p.status || 'lead').toLowerCase();
        if (!ACTIVE_FUNNEL_STATUSES.includes(status)) return false;
        return getDaysInStage(p) >= COLD_LEAD_DAYS;
      });

      if (cooled.length === 0) return;

      cooled.forEach(p => updateStatusInDB(String(p.id), 'discarded'));

      const message = cooled.length === 1
        ? `${cooled[0].name || 'Lead'} ficou ${COLD_LEAD_DAYS}+ dias sem avançar e foi movido para Leads Frios`
        : `${cooled.length} leads ficaram ${COLD_LEAD_DAYS}+ dias parados e foram movidos para Leads Frios`;

      setColdLeadNotice(message);
      setTimeout(() => setColdLeadNotice(null), 6000);
    };

    checkColdLeads();
    const interval = setInterval(checkColdLeads, 60000);
    return () => clearInterval(interval);
  }, [localPatients]);

  // ── Utilitários ──────────────────────────────────────────────────────────
  const safeParseFloat = (val: any): number => {
    if (typeof val === 'number') return val;
    if (!val) return 0;
    const clean = String(val).replace('R$', '').replace(/\./g, '').replace(',', '.').trim();
    return parseFloat(clean) || 0;
  };

  // ── KPIs ─────────────────────────────────────────────────────────────────
  const kpis = useMemo(() => {
    const leads = localPatients.filter(p => (p as any).is_lead);
    const activeStatuses = ['lead', 'negotiation', 'waiting', 'scheduled', 'novos leads', 'new', 'novo', 'em conversa', 'negociacao', 'aguardando', 'agendado', 'agenda'];
    const active = leads.filter(p => activeStatuses.includes((p.status || 'lead').toLowerCase()));
    const scheduled = leads.filter(p => ['scheduled', 'agendado', 'agenda'].includes((p.status || '').toLowerCase()));
    const confirmed = leads.filter(p => ['confirmed', 'confirmado', 'pago', 'paid', 'active'].includes((p.status || '').toLowerCase()));
    const totalConfirmedValue = confirmed.reduce((acc, p) => acc + safeParseFloat(p.price), 0);
    return { active: active.length, scheduled: scheduled.length, confirmed: confirmed.length, totalConfirmedValue };
  }, [localPatients]);

  // ── Saúde do Funil — alertas inteligentes ───────────────────────────────
  // Diferente dos KPIs acima (que mostram "quanto tem agora"), aqui comparamos
  // a semana atual com a anterior e só geramos um aviso quando algo relevante
  // mudou — conversão caindo/subindo, ou uma origem que parou de trazer leads.
  // Se está tudo dentro do esperado, a lista fica vazia e nada é exibido.
  const funnelAlerts = useMemo(() => {
    type Alert = { type: 'warning' | 'success' | 'info'; icon: string; message: string };
    const alerts: Alert[] = [];
    const DAY = 1000 * 60 * 60 * 24;
    const now = new Date();
    const startThisWeek = new Date(now.getTime() - 7 * DAY);
    const startLastWeek = new Date(now.getTime() - 14 * DAY);

    const withDate = localPatients.filter(p => !!p.created_at);
    const thisWeek = withDate.filter(p => new Date(p.created_at as string) >= startThisWeek);
    const lastWeek = withDate.filter(p => {
      const d = new Date(p.created_at as string);
      return d >= startLastWeek && d < startThisWeek;
    });

    const isConfirmed = (p: Patient) =>
      ['confirmed', 'confirmado', 'pago', 'paid', 'active'].includes((p.status || '').toLowerCase());

    // Exige uma amostra mínima — com poucos leads, qualquer variação vira ruído
    const MIN_SAMPLE = 5;
    if (thisWeek.length >= MIN_SAMPLE && lastWeek.length >= MIN_SAMPLE) {
      const rateThis = thisWeek.filter(isConfirmed).length / thisWeek.length;
      const rateLast = lastWeek.filter(isConfirmed).length / lastWeek.length;
      const diffPp = Math.round((rateThis - rateLast) * 100);

      if (diffPp <= -10) {
        alerts.push({
          type: 'warning',
          icon: '⚠️',
          message: `A conversão caiu de ${Math.round(rateLast * 100)}% para ${Math.round(rateThis * 100)}% nos últimos 7 dias em relação à semana anterior. Vale dar uma olhada no que mudou.`,
        });
      } else if (diffPp >= 10) {
        alerts.push({
          type: 'success',
          icon: '📈',
          message: `Boa semana: a conversão subiu de ${Math.round(rateLast * 100)}% para ${Math.round(rateThis * 100)}% em relação aos 7 dias anteriores.`,
        });
      }
    }

    // Origem que vinha trazendo leads e parou de trazer nos últimos 7 dias
    const countBySource = (list: Patient[]) => {
      const map = new Map<string, number>();
      list.forEach(p => {
        const src = p.source || 'outro';
        map.set(src, (map.get(src) || 0) + 1);
      });
      return map;
    };
    const sourcesLastWeek = countBySource(lastWeek);
    const sourcesThisWeek = countBySource(thisWeek);
    sourcesLastWeek.forEach((count, src) => {
      if (count >= 3 && !sourcesThisWeek.has(src)) {
        const label = SOURCES[src]?.label || src;
        alerts.push({
          type: 'warning',
          icon: '📊',
          message: `A origem "${label}" trouxe ${count} lead${count > 1 ? 's' : ''} na semana passada e nenhum nos últimos 7 dias — pode valer checar se algo travou ali.`,
        });
      }
    });

    // No máximo 3 — o objetivo é chamar atenção pro que importa, não poluir
    return alerts.slice(0, 3);
  }, [localPatients]);

  // Nome amigável da coluna a partir do status — usado para descrever
  // mudanças de status na timeline de forma legível ("Novos Leads" em vez de "lead")
  const getStatusLabel = (status?: string): string => {
    const key = (status || 'lead').toLowerCase();
    return COLUMNS[key]?.title || status || '—';
  };

  // Registra um evento na timeline do lead (tabela patient_history já existente)
  const logHistoryEvent = async (patientId: string, eventType: string, notes: string) => {
    try {
      await supabase.from('patient_history').insert([{
        patient_id: patientId,
        event_type: eventType,
        notes,
        created_by: session?.user?.email || 'Sistema',
      }]);
    } catch (e) {
      console.error('Erro ao registrar evento no histórico', e);
    }
  };

  // Abre o painel de histórico e busca os eventos do paciente
  const openHistoryPanel = async (patient: Patient) => {
    setHistoryPatient(patient);
    setShowHistoryPanel(true);
    setLoadingHistory(true);
    try {
      const { data, error } = await supabase
        .from('patient_history')
        .select('*')
        .eq('patient_id', patient.id)
        .order('date', { ascending: false });
      if (error) throw error;
      setHistoryEvents((data as PatientHistory[]) || []);
    } catch (e) {
      console.error('Erro ao buscar histórico do paciente', e);
      setHistoryEvents([]);
    } finally {
      setLoadingHistory(false);
    }
  };

  const handleDeletePatient = async () => {
    if (!deletingPatient || !deleteReason) return;
    setIsDeleting(true);
    try {
      const fullNote = deleteNote.trim()
        ? `Motivo: ${deleteReason} — ${deleteNote.trim()}`
        : `Motivo: ${deleteReason}`;
      await logHistoryEvent(String(deletingPatient.id), 'other', `Lead excluído. ${fullNote}`);
      const { error } = await supabase.from('patients').delete().eq('id', deletingPatient.id);
      if (error) throw error;
      setLocalPatients(prev => prev.filter(p => String(p.id) !== String(deletingPatient.id)));
      setShowDeleteModal(false);
      setDeletingPatient(null);
      setDeleteReason('');
      setDeleteNote('');
      onRefresh();
    } catch (err: any) {
      alert(`Erro ao excluir: ${err.message}`);
    } finally {
      setIsDeleting(false);
    }
  };

  const openWhatsApp = (phone: string) => {
    if (!phone) return;
    const clean = phone.replace(/\D/g, '');
    if (!clean) return;
    const number = clean.startsWith('55') ? clean : `55${clean}`;
    window.open(`https://wa.me/${number}`, '_blank');
  };

  const getDaysInPipeline = (patient: Patient): number => {
    if (!patient.created_at) return 0;
    const created = new Date(patient.created_at);
    const now = new Date();
    return Math.floor((now.getTime() - created.getTime()) / (1000 * 60 * 60 * 24));
  };

  // Diferente de getDaysInPipeline (que conta desde a criação do lead),
  // esta função conta há quanto tempo o lead está PARADO na coluna atual —
  // é o que usamos para decidir se ele "esfriou".
  const getDaysInStage = (patient: Patient): number => {
    const reference = patient.stage_entered_at || patient.created_at;
    if (!reference) return 0;
    const enteredAt = new Date(reference);
    const now = new Date();
    return Math.floor((now.getTime() - enteredAt.getTime()) / (1000 * 60 * 60 * 24));
  };

  // ── Lead Scoring (0–100 pts) ──────────────────────────────────────────────
  // Fatores: origem, momento no estágio, valor definido, lembrete ativo, posição no funil.
  // Pesos provisórios — serão ajustados com dados reais ao longo do tempo.
  const calculateLeadScore = (patient: Patient) => {
    let score = 0;

    // Origem (0–25 pts)
    const sourcePoints: Record<string, number> = {
      indicacao: 25, whatsapp: 20, instagram: 20,
      google: 15, site: 15, feegow: 10, outro: 5,
    };
    score += sourcePoints[patient.source || ''] ?? 0;

    // Momento no estágio (0–25 pts) — sweet spot: 2–4 dias de engajamento
    const daysInStage = getDaysInStage(patient);
    if (daysInStage <= 1)      score += 12;
    else if (daysInStage <= 4) score += 25;
    else if (daysInStage <= 6) score += 10;
    // 7+ dias = 0 (candidato a lead frio)

    // Valor estimado preenchido (0–20 pts)
    if (safeParseFloat(patient.price) > 0) score += 20;

    // Lembrete ativo (0–15 pts)
    if (patient.reminderDate && !patient.reminderExecuted) score += 15;

    // Posição no funil (0–15 pts)
    const stagePoints: Record<string, number> = { waiting: 15, negotiation: 10, lead: 5 };
    score += stagePoints[(patient.status || '').toLowerCase()] ?? 0;

    const s = Math.min(100, Math.max(0, score));
    if (s >= 70) return { score: s, label: 'Alta',  color: 'text-emerald-700', bg: 'bg-emerald-50 border-emerald-200', dot: 'bg-emerald-400' };
    if (s >= 40) return { score: s, label: 'Média', color: 'text-amber-700',   bg: 'bg-amber-50 border-amber-200',     dot: 'bg-amber-400'   };
    return         { score: s, label: 'Baixa', color: 'text-rose-600',    bg: 'bg-rose-50 border-rose-200',       dot: 'bg-rose-400'    };
  };

  // Colunas onde o score faz sentido (funil ativo, antes da conversão)
  const SCORE_COLUMNS = ['lead', 'negotiation', 'waiting'];

  // ── Filtro de pacientes por coluna ───────────────────────────────────────
  const getPatientsByStatus = (columnId: string): Patient[] => {
    return localPatients.filter(p => {
      if (!(p as any).is_lead) return false;

      // Filtro de busca
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase();
        const nameMatch = (p.name || '').toLowerCase().includes(q);
        const phoneMatch = (p.phone || '').includes(q);
        if (!nameMatch && !phoneMatch) return false;
      }

      const s = (p.status || 'lead').toLowerCase();
      if (columnId === 'lead')        return ['lead', 'novos leads', 'new', 'novo'].includes(s);
      if (columnId === 'negotiation') return ['negotiation', 'em conversa', 'negociacao'].includes(s);
      if (columnId === 'waiting')     return ['waiting', 'aguardando', 'humano', 'human', 'atencao'].includes(s);
      if (columnId === 'scheduled')   return ['scheduled', 'agendado', 'agenda'].includes(s);
      if (columnId === 'confirmed')   return ['confirmed', 'confirmado', 'pago', 'paid', 'active'].includes(s);
      if (columnId === 'discarded')   return ['discarded', 'descartado', 'lixo', 'arquivado', 'lost', 'perda', 'leads frios'].includes(s);
      return s === columnId;
    });
  };

  // ── Modais de Lead ────────────────────────────────────────────────────────
  const openEditModal = (patient: Patient) => {
    setNewPatientData({
      name: patient.name || '',
      phone: patient.phone || '',
      email: patient.email || '',
      source: patient.source || '',
    });
    setDealValue(patient.price ? String(patient.price) : '');
    setEditingPatientId(String(patient.id));
    setShowAddModal(true);
  };

  const openAddModal = () => {
    setNewPatientData({ name: '', phone: '', email: '', source: '' });
    setDealValue('');
    setEditingPatientId(null);
    setShowAddModal(true);
  };

  const handleSavePatient = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newPatientData.name.trim()) return;
    setIsSubmitting(true);
    try {
      const payload = {
        name: newPatientData.name,
        phone: newPatientData.phone,
        email: newPatientData.email,
        source: newPatientData.source || null,
        price: safeParseFloat(dealValue),
      };

      if (editingPatientId) {
        const { error } = await supabase.from('patients').update(payload).eq('id', editingPatientId);
        if (error) throw error;
      } else {
        const incomingPhone = phoneMatchKey(payload.phone);
        if (incomingPhone) {
          const existing = localPatients.find(p => phoneMatchKey(p.phone) === incomingPhone);
          if (existing) {
            alert(`Já existe um paciente com este telefone (${payload.phone}). Abrindo o cadastro existente.`);
            onSelectPatient?.(String(existing.id));
            setShowAddModal(false);
            return;
          }
        }
        const { error } = await supabase.from('patients').insert([{ ...payload, status: 'lead', is_lead: true }]);
        if (error) throw error;
      }
      setShowAddModal(false);
      onRefresh();
    } catch (error: any) {
      alert(`Erro do Banco de Dados: ${error.message}`);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleSaveObservation = async (patientId: string, newObservation: string) => {
    setLocalPatients(prev =>
      prev.map(p => String(p.id) === patientId ? { ...p, observation: newObservation } : p)
    );
    try {
      await supabase.from('patients').update({ observation: newObservation }).eq('id', patientId);
    } catch (error) {
      console.error('Erro ao salvar anotação', error);
    }
  };

  // ── Atribuição de responsável ─────────────────────────────────────────────
  // Reaproveita a lista de `professionals` já carregada (mesma fonte usada na
  // Agenda/Configurações) — sem necessidade de uma tabela de "usuários" separada.
  const getInitials = (name?: string): string => {
    if (!name) return '?';
    const parts = name.trim().split(/\s+/);
    if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  };

  const handleAssignResponsible = async (patientId: string, professionalId: string | null) => {
    const previous = localPatients.find(p => String(p.id) === patientId)?.assigned_to ?? null;
    if ((previous ?? null) === (professionalId ?? null)) {
      setAssigningPatientId(null);
      return;
    }

    // Atualiza local imediatamente (optimistic UI)
    setLocalPatients(prev =>
      prev.map(p => String(p.id) === patientId ? { ...p, assigned_to: professionalId ?? undefined } : p)
    );
    setAssigningPatientId(null);

    try {
      const { error } = await supabase
        .from('patients')
        .update({ assigned_to: professionalId })
        .eq('id', patientId);
      if (error) throw error;

      const newName = professionalId ? professionals.find(pr => String(pr.id) === professionalId)?.name : null;
      const note = newName
        ? `Lead atribuído a ${newName}`
        : 'Atribuição de responsável removida';
      logHistoryEvent(patientId, 'other', note);
    } catch (error) {
      console.error('Erro ao atribuir responsável', error);
      // Rollback em caso de falha
      setLocalPatients(prev =>
        prev.map(p => String(p.id) === patientId ? { ...p, assigned_to: previous ?? undefined } : p)
      );
    }
  };

  // ── Lembretes ─────────────────────────────────────────────────────────────
  const handleSaveReminder = async () => {
    if (!selectedForReminder || !reminderDate) return;
    setIsSubmitting(true);
    try {
      await onSaveReminder(String(selectedForReminder.id), reminderDate, reminderNote);
      setLocalPatients(prev =>
        prev.map(p =>
          String(p.id) === String(selectedForReminder.id)
            ? { ...p, reminderDate, reminderNote }
            : p
        )
      );

      // Registra a criação do lembrete na timeline
      const formattedDate = new Date(reminderDate).toLocaleString('pt-BR', {
        day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit',
      });
      logHistoryEvent(
        String(selectedForReminder.id),
        'follow_up',
        `Lembrete agendado para ${formattedDate}${reminderNote ? ' — ' + reminderNote : ''}`
      );

      setShowReminderModal(false);
      setReminderDate('');
      setReminderNote('');
    } catch {
      alert('Erro ao salvar lembrete.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const clearReminder = async (patientId: string) => {
    setDueReminders(prev => prev.filter(p => String(p.id) !== patientId));
    setLocalPatients(prev =>
      prev.map(p =>
        String(p.id) === patientId
          ? { ...p, reminderDate: undefined, reminderNote: undefined }
          : p
      )
    );
    setShowReminderModal(false);
    try {
      await supabase.from('patients').update({ reminder_date: null, reminder_note: null }).eq('id', patientId);
      onRefresh();
    } catch (e) {
      console.error('Erro ao limpar lembrete no banco', e);
    }
  };

  // ── 🚀 OPTIMISTIC UI — atualiza local imediatamente ──────────────────────
  const updateStatusInDB = async (id: string, status: string, price?: number) => {
    // Sempre que o status muda, registramos o momento — é a base do "tempo
    // parado na coluna atual" usado pela automação de Leads Frios.
    const updates: any = { status, stage_entered_at: new Date().toISOString() };
    if (price !== undefined) updates.price = price;

    // Snapshot para rollback
    const previousPatients = localPatients;
    const patientBefore = localPatients.find(p => String(p.id) === id);
    const previousStatus = patientBefore?.status;

    // Atualiza local IMEDIATAMENTE
    setLocalPatients(prev => prev.map(p => String(p.id) === id ? { ...p, ...updates } : p));

    try {
      const { error } = await supabase.from('patients').update(updates).eq('id', id);
      if (error) throw error;
      // Sem onRefresh() no caminho feliz — estado local já reflete a mudança

      // Registra a mudança de status na timeline (não bloqueia o fluxo principal)
      if (previousStatus && previousStatus.toLowerCase() !== status.toLowerCase()) {
        logHistoryEvent(
          id,
          'other',
          `Status alterado: ${getStatusLabel(previousStatus)} → ${getStatusLabel(status)}`
        );
      }
    } catch {
      // Rollback em caso de erro
      setLocalPatients(previousPatients);
      alert('Erro ao sincronizar com o banco. A mudança foi revertida.');
    }
  };

  // ── Sucesso no registro de pagamento ─────────────────────────────────────
  const handlePaymentSuccess = () => {
    const targetId = pendingDrag?.draggableId ?? paymentPatient?.id;
    const targetName = paymentPatient?.name;

    if (targetId) {
      updateStatusInDB(String(targetId), 'confirmed');
    }
    if (targetName) {
      setConfirmSuccess(targetName);
      setTimeout(() => setConfirmSuccess(null), 3500);
    }

    setPendingDrag(null);
    setShowPaymentModal(false);
    setPaymentPatient(null);

    // Refresh em background para sincronizar módulo financeiro
    setTimeout(() => onRefresh(), 600);
  };

  const handleRefundDecision = (shouldRefund: boolean) => {
    if (!pendingDrag) return;
    updateStatusInDB(
      pendingDrag.draggableId,
      pendingDrag.destination.droppableId,
      shouldRefund ? 0 : refundData?.price
    );
    setShowRefundModal(false);
    setPendingDrag(null);
  };

  // ── Drag & Drop ───────────────────────────────────────────────────────────
  const onDragStart = () => setIsDragging(true);

  const onDragEnd = (result: DropResult) => {
    setIsDragging(false);
    const { destination, source, draggableId } = result;
    if (!destination) return;
    if (destination.droppableId === source.droppableId && destination.index === source.index) return;

    const newStatus = destination.droppableId;
    const oldStatus = source.droppableId;
    const currentPatient = localPatients.find(p => String(p.id) === draggableId);
    const currentPrice = safeParseFloat(currentPatient?.price);

    // Arrastar para Atendidos → abre PaymentRegisterModal completo
    if (newStatus === 'confirmed' && oldStatus !== 'confirmed') {
      setPendingDrag({ draggableId, source, destination });
      setPaymentPatient(currentPatient ?? null);
      setShowPaymentModal(true);
      return;
    }

    // Tirar de Atendidos com valor → pergunta sobre reembolso
    if (oldStatus === 'confirmed' && newStatus !== 'confirmed' && currentPrice > 0) {
      setPendingDrag({ draggableId, source, destination });
      setRefundData({ name: currentPatient?.name || 'Paciente', price: currentPrice });
      setShowRefundModal(true);
      return;
    }

    updateStatusInDB(draggableId, newStatus);
  };

  // ── RENDER ────────────────────────────────────────────────────────────────
  return (
    <div className="h-full flex flex-col bg-white rounded-2xl overflow-hidden">

      {/* ── HEADER ── */}
      <div className="px-6 pt-5 pb-4 border-b border-slate-100 space-y-4">

        {/* Título + ações */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-3">
          <div>
            <h2 className="text-xl font-bold text-slate-900 tracking-tight">Pipeline de Vendas</h2>
            <p className="text-slate-500 text-xs mt-0.5">Gerencie o fluxo de leads da clínica de ponta a ponta.</p>
          </div>
          <div className="flex items-center gap-2">
            {/* Busca */}
            <div className="relative">
              <Search size={13} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400" />
              <input
                type="text"
                value={searchQuery}
                onChange={e => setSearchQuery(e.target.value)}
                placeholder="Buscar por nome ou telefone..."
                className="pl-8 pr-7 py-1.5 text-xs border border-slate-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent outline-none w-52 bg-slate-50 text-slate-700"
              />
              {searchQuery && (
                <button
                  onClick={() => setSearchQuery('')}
                  className="absolute right-2 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
                >
                  <X size={12} />
                </button>
              )}
            </div>
            <button
              onClick={openAddModal}
              className="flex items-center gap-1.5 px-3.5 py-1.5 bg-indigo-600 hover:bg-indigo-700 text-white text-sm font-semibold rounded-lg shadow-sm transition-colors shrink-0"
            >
              <UserPlus size={15} /> <span>Novo Lead</span>
            </button>
          </div>
        </div>

        {/* KPIs */}
        <div className="grid grid-cols-4 gap-2.5">
          <div className="bg-slate-50 rounded-xl p-3 border border-slate-100">
            <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1">Funil Ativo</p>
            <p className="text-2xl font-black text-slate-800 leading-none">{kpis.active}</p>
            <p className="text-[10px] text-slate-400 mt-1">leads no pipeline</p>
          </div>
          <div className="bg-purple-50 rounded-xl p-3 border border-purple-100">
            <p className="text-[10px] font-bold text-purple-400 uppercase tracking-wider mb-1">Agendados</p>
            <p className="text-2xl font-black text-purple-700 leading-none">{kpis.scheduled}</p>
            <p className="text-[10px] text-purple-400 mt-1">prontos p/ atender</p>
          </div>
          <div className="bg-emerald-50 rounded-xl p-3 border border-emerald-100">
            <p className="text-[10px] font-bold text-emerald-500 uppercase tracking-wider mb-1">Atendidos</p>
            <p className="text-2xl font-black text-emerald-700 leading-none">{kpis.confirmed}</p>
            <p className="text-[10px] text-emerald-400 mt-1">conversões totais</p>
          </div>
          <div className="bg-indigo-50 rounded-xl p-3 border border-indigo-100">
            <p className="text-[10px] font-bold text-indigo-400 uppercase tracking-wider mb-1">Faturado</p>
            <p className="text-lg font-black text-indigo-700 leading-none mt-0.5">
              {kpis.totalConfirmedValue > 0
                ? `R$ ${kpis.totalConfirmedValue.toLocaleString('pt-BR', { minimumFractionDigits: 0, maximumFractionDigits: 0 })}`
                : '—'}
            </p>
            <p className="text-[10px] text-indigo-400 mt-1">em conversões</p>
          </div>
        </div>

        {/* Saúde do Funil — só aparece quando há algo para avisar (não duplica os KPIs acima) */}
        {funnelAlerts.length > 0 && (
          <div className="space-y-1.5">
            {funnelAlerts.map((alert, idx) => {
              const styles = alert.type === 'warning'
                ? 'bg-amber-50 border-amber-200 text-amber-800'
                : alert.type === 'success'
                ? 'bg-emerald-50 border-emerald-200 text-emerald-800'
                : 'bg-slate-50 border-slate-200 text-slate-700';
              return (
                <div key={idx} className={`flex items-start gap-2 px-3 py-2 rounded-lg border text-xs ${styles}`}>
                  <span className="shrink-0">{alert.icon}</span>
                  <span className="leading-snug">{alert.message}</span>
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* ── KANBAN ── */}
      <div className="flex-1 overflow-hidden p-4">
        <DragDropContext onDragStart={onDragStart} onDragEnd={onDragEnd}>
          <div
            ref={scrollContainerRef}
            className="flex gap-3 overflow-x-auto pb-3 h-full items-start crm-hscroll"
            onWheel={e => {
              if (Math.abs(e.deltaX) > Math.abs(e.deltaY)) return;
              e.preventDefault();
              if (scrollContainerRef.current) {
                scrollContainerRef.current.scrollLeft += e.deltaY * 1.5;
              }
            }}
          >
            {Object.entries(COLUMNS).map(([columnId, config]) => {
              const columnPatients = getPatientsByStatus(columnId);
              const totalValue = columnPatients.reduce((acc, curr) => acc + safeParseFloat(curr.price), 0);

              return (
                <div
                  key={columnId}
                  className={`w-[268px] flex flex-col max-h-full rounded-xl border ${config.border} bg-slate-50/50 shrink-0`}
                >
                  {/* Cabeçalho da coluna */}
                  <div className={`p-3 border-b ${config.border} rounded-t-xl ${config.color}`}>
                    <div className="flex justify-between items-center">
                      <div className="flex items-center gap-2">
                        <div className={`w-1 h-5 rounded-full ${config.accent}`} />
                        <div>
                          <h3 className={`font-bold text-[11px] uppercase tracking-wider ${config.text}`}>
                            {config.title}
                          </h3>
                          {totalValue > 0 && (
                            <p className={`text-[10px] font-semibold mt-0.5 opacity-70 ${config.text}`}>
                              R$ {totalValue.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
                            </p>
                          )}
                        </div>
                      </div>
                      <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold bg-white/70 ${config.text}`}>
                        {columnPatients.length}
                      </span>
                    </div>
                  </div>

                  <Droppable droppableId={columnId}>
                    {(provided, snapshot) => (
                      <div
                        {...provided.droppableProps}
                        ref={provided.innerRef}
                        className={`flex-1 p-2.5 overflow-y-auto min-h-[140px] transition-colors duration-150 ${
                          snapshot.isDraggingOver ? 'bg-indigo-50/50' : ''
                        }`}
                      >
                        {/* Empty state */}
                        {columnPatients.length === 0 && !snapshot.isDraggingOver && (
                          <div className="flex flex-col items-center justify-center py-8 text-center select-none">
                            <span className="text-xl mb-1.5 opacity-30">{config.icon}</span>
                            <p className="text-[11px] text-slate-400 font-medium">Nenhum lead aqui</p>
                            {columnId === 'lead' && (
                              <button
                                onClick={openAddModal}
                                className="mt-2 text-[11px] text-indigo-500 hover:text-indigo-700 font-semibold"
                              >
                                + Adicionar lead
                              </button>
                            )}
                          </div>
                        )}

                        {columnPatients.map((patient, index) => {
                          const days = getDaysInPipeline(patient);
                          const isUrgent = days > 7 && ['lead', 'negotiation'].includes(columnId);
                          const sourceConfig = patient.source ? SOURCES[patient.source] : null;
                          const leadScore = SCORE_COLUMNS.includes(columnId) ? calculateLeadScore(patient) : null;
                          const assignedProfessional = patient.assigned_to
                            ? professionals.find(pr => String(pr.id) === String(patient.assigned_to)) || null
                            : null;

                          return (
                            <Draggable
                              key={patient.id}
                              draggableId={String(patient.id)}
                              index={index}
                            >
                              {(provided, snapshot) => (
                                <div
                                  ref={provided.innerRef}
                                  {...provided.draggableProps}
                                  {...provided.dragHandleProps}
                                  style={{
                                    userSelect: 'none',
                                    marginBottom: '10px',
                                    ...provided.draggableProps.style,
                                  }}
                                  className={`bg-white rounded-xl border flex flex-col overflow-hidden transition-shadow ${
                                    snapshot.isDragging
                                      ? 'border-indigo-400 shadow-2xl ring-2 ring-indigo-200'
                                      : isUrgent
                                      ? 'border-amber-300 shadow-sm hover:shadow-md hover:border-amber-400'
                                      : 'border-slate-200 shadow-sm hover:shadow-md hover:border-indigo-300'
                                  }`}
                                >
                                  {/* Barra de urgência */}
                                  {isUrgent && (
                                    <div className="h-0.5 w-full bg-gradient-to-r from-amber-400 to-orange-400" />
                                  )}
                                  {/* Barra de "atendido" */}
                                  {columnId === 'confirmed' && (
                                    <div className="h-0.5 w-full bg-gradient-to-r from-emerald-400 to-teal-400" />
                                  )}

                                  <div className="p-3">
                                    {/* Nome + score + lembrete */}
                                    <div className="flex justify-between items-start mb-1.5 gap-1.5">
                                      <h4
                                        onClick={() => onSelectPatient?.(String(patient.id))}
                                        className="font-bold text-sm text-slate-800 cursor-pointer hover:text-indigo-600 transition-colors truncate flex-1 leading-tight"
                                        title="Abrir Prontuário"
                                      >
                                        {patient.name || 'Sem nome'}
                                      </h4>
                                      <div className="flex items-center gap-1 shrink-0">
                                        {/* Responsável pelo lead */}
                                        <div className="relative">
                                          <button
                                            onClick={e => {
                                              e.stopPropagation();
                                              setAssigningPatientId(prev => prev === String(patient.id) ? null : String(patient.id));
                                            }}
                                            title={assignedProfessional ? `Responsável: ${assignedProfessional.name}` : 'Atribuir responsável'}
                                            className="block"
                                          >
                                            {assignedProfessional ? (
                                              <span
                                                style={{ backgroundColor: assignedProfessional.color || '#94a3b8' }}
                                                className="w-5 h-5 rounded-full flex items-center justify-center text-[8px] font-bold text-white shadow-sm hover:ring-2 hover:ring-offset-1 hover:ring-slate-300 transition-all"
                                              >
                                                {getInitials(assignedProfessional.name)}
                                              </span>
                                            ) : (
                                              <span className="w-5 h-5 rounded-full border border-dashed border-slate-300 flex items-center justify-center text-slate-300 hover:border-indigo-400 hover:text-indigo-400 transition-colors">
                                                <UserPlus size={10} />
                                              </span>
                                            )}
                                          </button>

                                          {assigningPatientId === String(patient.id) && (
                                            <div
                                              onClick={e => e.stopPropagation()}
                                              className="absolute right-0 top-6 z-30 bg-white border border-slate-200 rounded-lg shadow-xl w-48 py-1 max-h-56 overflow-y-auto"
                                            >
                                              <p className="px-3 py-1.5 text-[9px] font-bold uppercase tracking-wider text-slate-400 border-b border-slate-100">
                                                Atribuir responsável
                                              </p>
                                              <button
                                                onClick={() => handleAssignResponsible(String(patient.id), null)}
                                                className="w-full flex items-center gap-2 px-3 py-1.5 text-xs text-slate-500 hover:bg-slate-50 transition-colors"
                                              >
                                                <span className="w-5 h-5 rounded-full border border-dashed border-slate-300 flex items-center justify-center shrink-0">
                                                  <X size={9} className="text-slate-300" />
                                                </span>
                                                Sem responsável
                                              </button>
                                              {professionals.map(pro => (
                                                <button
                                                  key={pro.id}
                                                  onClick={() => handleAssignResponsible(String(patient.id), String(pro.id))}
                                                  className="w-full flex items-center gap-2 px-3 py-1.5 text-xs text-slate-700 hover:bg-slate-50 transition-colors"
                                                >
                                                  <span
                                                    style={{ backgroundColor: pro.color || '#94a3b8' }}
                                                    className="w-5 h-5 rounded-full flex items-center justify-center text-[8px] font-bold text-white shrink-0"
                                                  >
                                                    {getInitials(pro.name)}
                                                  </span>
                                                  <span className="truncate">{pro.name}</span>
                                                </button>
                                              ))}
                                              {professionals.length === 0 && (
                                                <p className="px-3 py-2 text-[11px] text-slate-400">Nenhum profissional cadastrado.</p>
                                              )}
                                            </div>
                                          )}
                                        </div>
                                        {leadScore && (
                                          <span
                                            className={`inline-flex items-center gap-1 px-1.5 py-0.5 rounded border text-[9px] font-bold ${leadScore.color} ${leadScore.bg}`}
                                            title={`Score: ${leadScore.score}/100`}
                                          >
                                            <span className={`w-1.5 h-1.5 rounded-full ${leadScore.dot}`} />
                                            {leadScore.label}
                                          </span>
                                        )}
                                        {patient.reminderDate && (
                                          <BellRing size={13} className="text-amber-500 mt-0.5" />
                                        )}
                                      </div>
                                    </div>

                                    {/* Telefone */}
                                    <p className="flex items-center text-[11px] text-slate-500 mb-2">
                                      <Phone size={10} className="mr-1.5 text-slate-400 shrink-0" />
                                      <span className="truncate">{patient.phone || '—'}</span>
                                    </p>

                                    {/* Badge de origem */}
                                    {sourceConfig && (
                                      <span
                                        className={`inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-semibold border mb-2 ${sourceConfig.bg} ${sourceConfig.color}`}
                                      >
                                        {sourceConfig.label}
                                      </span>
                                    )}

                                    {/* Valor */}
                                    {safeParseFloat(patient.price) > 0 && (
                                      <div className="mb-2 px-2 py-1 bg-emerald-50 text-emerald-700 rounded-lg text-[11px] font-bold inline-flex items-center gap-1 border border-emerald-100">
                                        <DollarSign size={10} />
                                        {safeParseFloat(patient.price).toLocaleString('pt-BR', {
                                          minimumFractionDigits: 2,
                                        })}
                                      </div>
                                    )}

                                    {/* Anotação */}
                                    <div className="bg-slate-50 border border-slate-100 rounded-lg p-2 relative mb-2">
                                      <AlignLeft size={10} className="absolute top-2 left-2 text-slate-400" />
                                      <textarea
                                        className="w-full text-[11px] text-slate-600 bg-transparent outline-none resize-none pl-4 placeholder-slate-400 leading-relaxed"
                                        placeholder="Anotação rápida..."
                                        rows={2}
                                        defaultValue={patient.observation || ''}
                                        onBlur={e => handleSaveObservation(String(patient.id), e.target.value)}
                                      />
                                    </div>

                                    {/* Dias no funil */}
                                    {days > 0 && (
                                      <div className={`flex items-center gap-1 text-[10px] mb-2 ${isUrgent ? 'text-amber-600 font-semibold' : 'text-slate-400'}`}>
                                        <Clock size={9} />
                                        <span>{days === 1 ? '1 dia no funil' : `${days} dias no funil`}</span>
                                        {isUrgent && <span>· atenção!</span>}
                                      </div>
                                    )}

                                    {/* Ações do card */}
                                    <div className="flex items-center gap-1 pt-2 border-t border-slate-100">
                                      {/* WhatsApp */}
                                      <button
                                        onClick={e => { e.stopPropagation(); openWhatsApp(patient.phone); }}
                                        disabled={!patient.phone}
                                        className="p-1.5 text-slate-400 hover:text-green-600 hover:bg-green-50 rounded-md transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
                                        title="Abrir WhatsApp"
                                      >
                                        <MessageCircle size={14} />
                                      </button>

                                      {/* Editar */}
                                      <button
                                        onClick={e => { e.stopPropagation(); openEditModal(patient); }}
                                        className="p-1.5 text-slate-400 hover:text-indigo-600 hover:bg-indigo-50 rounded-md transition-colors"
                                        title="Editar"
                                      >
                                        <Edit2 size={14} />
                                      </button>

                                      {/* Histórico / Timeline */}
                                      <button
                                        onClick={e => { e.stopPropagation(); openHistoryPanel(patient); }}
                                        className="p-1.5 text-slate-400 hover:text-purple-600 hover:bg-purple-50 rounded-md transition-colors"
                                        title="Ver histórico"
                                      >
                                        <History size={14} />
                                      </button>

                                      {/* Excluir lead */}
                                      <button
                                        onClick={e => {
                                          e.stopPropagation();
                                          setDeletingPatient(patient);
                                          setDeleteReason('');
                                          setDeleteNote('');
                                          setShowDeleteModal(true);
                                        }}
                                        className="p-1.5 text-slate-400 hover:text-rose-600 hover:bg-rose-50 rounded-md transition-colors"
                                        title="Excluir lead"
                                      >
                                        <Trash2 size={14} />
                                      </button>

                                      {/* Lembrete */}
                                      <button
                                        onClick={e => {
                                          e.stopPropagation();
                                          setSelectedForReminder(patient);
                                          setReminderDate(
                                            patient.reminderDate
                                              ? String(patient.reminderDate).substring(0, 16)
                                              : ''
                                          );
                                          setReminderNote(patient.reminderNote || '');
                                          setShowReminderModal(true);
                                        }}
                                        className={`p-1.5 rounded-md transition-colors ml-auto ${
                                          patient.reminderDate
                                            ? 'text-amber-600 bg-amber-50'
                                            : 'text-slate-400 hover:text-amber-600 hover:bg-amber-50'
                                        }`}
                                        title="Lembrete"
                                      >
                                        <Bell size={14} />
                                      </button>
                                    </div>

                                    {/* Botão Confirmar Atendimento (coluna Agendados) */}
                                    {columnId === 'scheduled' && (
                                      <button
                                        onClick={e => {
                                          e.stopPropagation();
                                          setPaymentPatient(patient);
                                          setShowPaymentModal(true);
                                        }}
                                        className="mt-2 w-full flex items-center justify-center gap-1.5 bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 text-white text-[11px] font-bold py-2 rounded-lg transition-colors"
                                      >
                                        <Stethoscope size={12} />
                                        Confirmar Atendimento
                                      </button>
                                    )}
                                  </div>
                                </div>
                              )}
                            </Draggable>
                          );
                        })}
                        {provided.placeholder}
                      </div>
                    )}
                  </Droppable>
                </div>
              );
            })}
          </div>
        </DragDropContext>
      </div>

      {/* ══════════════════════════════════════════════════════════════════════
          MODAIS
      ══════════════════════════════════════════════════════════════════════ */}

      {/* Modal de Exclusão de Lead */}
      {showDeleteModal && deletingPatient && (
        <div className="fixed inset-0 z-[200] bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-9 h-9 rounded-xl bg-rose-100 flex items-center justify-center shrink-0">
                <Trash2 size={16} className="text-rose-600" />
              </div>
              <div>
                <h3 className="text-base font-bold text-slate-900">Excluir Lead</h3>
                <p className="text-xs text-slate-500">{deletingPatient.name}</p>
              </div>
            </div>

            <p className="text-xs text-slate-500 mb-4 leading-relaxed">
              Esta ação é permanente. O motivo será registrado no histórico antes da exclusão para fins de análise.
            </p>

            <div className="space-y-3">
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">
                  Motivo *
                </label>
                <select
                  value={deleteReason}
                  onChange={e => setDeleteReason(e.target.value)}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-rose-400 outline-none bg-white"
                >
                  <option value="">Selecionar motivo...</option>
                  <option value="Número errado / sem contato">Número errado / sem contato</option>
                  <option value="Paciente desistiu">Paciente desistiu</option>
                  <option value="Preço">Preço</option>
                  <option value="Fora do perfil da clínica">Fora do perfil da clínica</option>
                  <option value="Cadastro duplicado">Cadastro duplicado</option>
                  <option value="Outro">Outro</option>
                </select>
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">
                  Observação (opcional)
                </label>
                <textarea
                  value={deleteNote}
                  onChange={e => setDeleteNote(e.target.value)}
                  placeholder="Detalhe se quiser..."
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-rose-400 outline-none resize-none"
                  rows={2}
                />
              </div>
            </div>

            <div className="flex gap-2 mt-5">
              <button
                onClick={() => { setShowDeleteModal(false); setDeletingPatient(null); }}
                className="flex-1 py-2 text-xs font-bold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors"
              >
                Cancelar
              </button>
              <button
                onClick={handleDeletePatient}
                disabled={!deleteReason || isDeleting}
                className="flex-1 py-2 text-xs font-bold text-white bg-rose-600 hover:bg-rose-700 rounded-lg transition-colors disabled:opacity-50"
              >
                {isDeleting ? 'Excluindo...' : 'Excluir Lead'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal Novo Lead / Editar Lead */}
      {showAddModal && (
        <div className="fixed inset-0 z-[200] bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6">
            <h3 className="text-base font-bold text-slate-900 mb-4 flex items-center gap-2">
              <UserPlus className="text-indigo-600" size={18} />
              {editingPatientId ? 'Editar Informações' : 'Adicionar Novo Lead'}
            </h3>

            <form onSubmit={handleSavePatient} className="space-y-3">
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Nome *</label>
                <input
                  type="text" required
                  value={newPatientData.name}
                  onChange={e => setNewPatientData({ ...newPatientData, name: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 outline-none"
                  placeholder="Nome completo..."
                />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Telefone (WhatsApp)</label>
                <input
                  type="text"
                  value={newPatientData.phone}
                  onChange={e => setNewPatientData({ ...newPatientData, phone: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 outline-none"
                  placeholder="(00) 00000-0000"
                />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">E-mail</label>
                <input
                  type="email"
                  value={newPatientData.email}
                  onChange={e => setNewPatientData({ ...newPatientData, email: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 outline-none"
                  placeholder="paciente@email.com"
                />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Origem</label>
                <select
                  value={newPatientData.source}
                  onChange={e => setNewPatientData({ ...newPatientData, source: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 outline-none bg-white"
                >
                  <option value="">Selecionar origem...</option>
                  {Object.entries(SOURCES).map(([key, cfg]) => (
                    <option key={key} value={key}>{cfg.label}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Valor estimado (R$)</label>
                <input
                  type="text"
                  value={dealValue}
                  onChange={e => setDealValue(e.target.value)}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 outline-none"
                  placeholder="Ex: 350,00"
                />
              </div>

              <div className="flex gap-2 pt-3 border-t border-slate-100 mt-2">
                <button
                  type="button"
                  onClick={() => setShowAddModal(false)}
                  className="flex-1 py-2 text-xs font-bold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors"
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="flex-1 py-2 text-xs font-bold text-white bg-indigo-600 hover:bg-indigo-700 rounded-lg transition-colors disabled:opacity-50"
                >
                  {isSubmitting ? 'Salvando...' : editingPatientId ? 'Salvar Alterações' : 'Adicionar Lead'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Modal de Pagamento Completo */}
      {showPaymentModal && paymentPatient && (
        <PaymentRegisterModal
          patient={paymentPatient}
          onClose={() => {
            setShowPaymentModal(false);
            setPaymentPatient(null);
            setPendingDrag(null);
          }}
          onSuccess={handlePaymentSuccess}
        />
      )}

      {/* Modal de Reembolso / Estorno */}
      {showRefundModal && refundData && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6 animate-in zoom-in-95 duration-200">
            <h3 className="text-base font-bold text-rose-600 mb-2 flex items-center gap-2">
              <AlarmClock size={18} /> Atenção ao Valor!
            </h3>
            <p className="text-sm text-slate-600 mb-1">
              Você está tirando <strong>{refundData.name}</strong> dos atendidos.
            </p>
            <p className="text-sm text-slate-500 mb-5">
              Valor registrado:{' '}
              <span className="font-bold text-emerald-600">
                R$ {refundData.price.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
              </span>
            </p>
            <div className="flex flex-col gap-2">
              <button
                onClick={() => handleRefundDecision(false)}
                className="w-full py-2.5 text-sm font-bold text-indigo-700 bg-indigo-50 hover:bg-indigo-100 border border-indigo-200 rounded-xl transition-colors"
              >
                Manter o valor no sistema
              </button>
              <button
                onClick={() => handleRefundDecision(true)}
                className="w-full py-2.5 text-sm font-bold text-rose-700 bg-rose-50 hover:bg-rose-100 border border-rose-200 rounded-xl transition-colors"
              >
                Zerar o valor (Estorno)
              </button>
              <button
                onClick={() => { setShowRefundModal(false); setPendingDrag(null); }}
                className="w-full py-2.5 text-sm font-medium text-slate-500 hover:bg-slate-50 rounded-xl transition-colors"
              >
                Cancelar Movimento
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de Lembrete */}
      {showReminderModal && selectedForReminder && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6">
            <h3 className="text-base font-bold text-slate-900 mb-0.5 flex items-center gap-2">
              <BellRing className="text-amber-500" size={18} />
              Lembrete de Atenção
            </h3>
            <p className="text-xs text-slate-500 mb-4">
              Paciente: <span className="font-bold text-slate-700">{selectedForReminder.name}</span>
            </p>
            <div className="space-y-3">
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">
                  Data e Hora
                </label>
                <input
                  type="datetime-local"
                  value={reminderDate}
                  onChange={e => setReminderDate(e.target.value)}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-amber-500 outline-none"
                />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">
                  Motivo / Mensagem
                </label>
                <textarea
                  value={reminderNote}
                  onChange={e => setReminderNote(e.target.value)}
                  placeholder="Ex: Retornar para reagendamento..."
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-amber-500 outline-none resize-none"
                  rows={3}
                />
              </div>
            </div>
            <div className="flex gap-2 mt-5">
              <button
                onClick={() => setShowReminderModal(false)}
                className="flex-1 py-2 text-xs font-bold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors"
              >
                Cancelar
              </button>
              {selectedForReminder?.reminderDate && (
                <button
                  onClick={() => clearReminder(String(selectedForReminder.id))}
                  className="px-3 py-2 text-rose-500 bg-rose-50 hover:bg-rose-100 rounded-lg transition-colors"
                  title="Apagar Lembrete"
                >
                  <Trash2 size={15} />
                </button>
              )}
              <button
                onClick={handleSaveReminder}
                disabled={isSubmitting || !reminderDate}
                className="flex-[1.5] py-2 text-xs font-bold text-white bg-amber-500 hover:bg-amber-600 rounded-lg transition-colors disabled:opacity-50"
              >
                {isSubmitting ? 'Salvando...' : 'Salvar Alerta'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Painel de Histórico / Timeline */}
      {showHistoryPanel && historyPatient && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-md shadow-2xl flex flex-col max-h-[80vh]">
            <div className="p-5 border-b border-slate-100 flex items-center justify-between shrink-0">
              <div>
                <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                  <History className="text-purple-500" size={18} />
                  Histórico de Interações
                </h3>
                <p className="text-xs text-slate-500 mt-0.5">{historyPatient.name}</p>
              </div>
              <button
                onClick={() => { setShowHistoryPanel(false); setHistoryPatient(null); setHistoryEvents([]); }}
                className="p-1.5 text-slate-400 hover:text-slate-600 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <X size={16} />
              </button>
            </div>
            <div className="flex-1 overflow-y-auto p-5">
              {loadingHistory && (
                <p className="text-sm text-slate-400 text-center py-8">Carregando histórico...</p>
              )}
              {!loadingHistory && historyEvents.length === 0 && (
                <div className="text-center py-8">
                  <span className="text-2xl opacity-30">🕓</span>
                  <p className="text-sm text-slate-400 mt-2">Nenhum evento registrado ainda.</p>
                  <p className="text-[11px] text-slate-300 mt-1">
                    A partir de agora, mudanças de status e lembretes deste lead aparecem aqui automaticamente.
                  </p>
                </div>
              )}
              {!loadingHistory && historyEvents.map((ev, idx) => {
                const style = EVENT_STYLES[ev.event_type] || EVENT_STYLES.other;
                const isLast = idx === historyEvents.length - 1;
                const when = ev.date || ev.created_at;
                return (
                  <div key={ev.id} className="flex gap-3">
                    <div className="flex flex-col items-center">
                      <div className={`w-2.5 h-2.5 rounded-full mt-1 shrink-0 ${style.dot}`} />
                      {!isLast && <div className="flex-1 w-px bg-slate-100 my-0.5" />}
                    </div>
                    <div className={isLast ? 'pb-1' : 'pb-4'}>
                      <p className="text-[10px] font-bold uppercase tracking-wider text-slate-400">
                        {style.label}
                        {when && (
                          <span className="font-medium normal-case tracking-normal text-slate-400">
                            {' · '}
                            {new Date(when).toLocaleString('pt-BR', {
                              day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit',
                            })}
                          </span>
                        )}
                      </p>
                      <p className="text-sm text-slate-700 mt-0.5 leading-snug">{ev.notes}</p>
                      {ev.created_by && (
                        <p className="text-[10px] text-slate-400 mt-0.5">por {ev.created_by}</p>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      )}

      {/* Toast de sucesso (atendimento confirmado) */}
      {confirmSuccess && (
        <div className="fixed bottom-6 right-6 z-[300] bg-emerald-500 text-white px-5 py-3 rounded-xl shadow-2xl flex items-center gap-2.5 animate-in slide-in-from-bottom-4 duration-300">
          <Check size={16} />
          <span className="text-sm font-bold">{confirmSuccess} — atendimento confirmado!</span>
        </div>
      )}

      {/* Toast de lead esfriado */}
      {coldLeadNotice && (
        <div className="fixed bottom-6 right-6 z-[300] bg-slate-700 text-white px-5 py-3 rounded-xl shadow-2xl flex items-center gap-2.5 animate-in slide-in-from-bottom-4 duration-300 max-w-sm">
          <span className="text-base shrink-0">🧊</span>
          <span className="text-sm font-semibold leading-snug">{coldLeadNotice}</span>
        </div>
      )}

    </div>
  );
};

export default CRMi;
