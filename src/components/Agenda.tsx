import React, { useState, useEffect, useRef } from 'react';
import {
  Clock, ChevronLeft, ChevronRight, Calendar as CalIcon, Plus, X, Check,
  Search, CheckCircle2, AlertCircle, Loader2, User, FileText,
} from 'lucide-react';
import { Patient, Professional, ClinicService, Appointment } from '../types';
import { supabase } from '../services/supabaseClient';
import { toTitleCase } from '../phoneUtils';

interface Props {
  patients: Patient[];
  professionals: Professional[];
  services: ClinicService[];
  onSelectPatient: (id: string) => void;
  onRefresh: () => void;
  refreshTrigger?: number;
}

type ViewType = 'diario' | 'semanal' | 'mensal';
type EditTab  = 'agendamento' | 'ficha' | 'historico';

// ─── Color map ────────────────────────────────────────────────────────────────
const PROF_COLORS: Record<string, { bg: string; border: string; text: string; dot: string }> = {
  blue:    { bg: '#dbeafe', border: '#3b82f6', text: '#1e40af', dot: '#3b82f6' },
  purple:  { bg: '#f3e8ff', border: '#9333ea', text: '#6b21a8', dot: '#9333ea' },
  emerald: { bg: '#d1fae5', border: '#10b981', text: '#065f46', dot: '#10b981' },
  teal:    { bg: '#ccfbf1', border: '#14b8a6', text: '#0f766e', dot: '#14b8a6' },
  rose:    { bg: '#ffe4e6', border: '#f43f5e', text: '#be123c', dot: '#f43f5e' },
  amber:   { bg: '#fef3c7', border: '#f59e0b', text: '#92400e', dot: '#f59e0b' },
  indigo:  { bg: '#e0e7ff', border: '#6366f1', text: '#3730a3', dot: '#6366f1' },
};
const DEFAULT_COLOR = { bg: '#eef8f8', border: '#0b6873', text: '#123451', dot: '#0b6873' };
const getProfColor  = (color: string) => PROF_COLORS[color] || DEFAULT_COLOR;

// ─── Time constants ──────────────────────────────────────────────────────────
const START_HOUR   = 7;
const END_HOUR     = 20;
const HOUR_HEIGHT  = 60;          // px per hour
const SNAP_MIN     = 15;          // drag snaps to 15-min intervals
const HOURS        = Array.from({ length: END_HOUR - START_HOUR }, (_, i) => START_HOUR + i);
const DAYS_OF_WEEK = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

// ─── Helpers ─────────────────────────────────────────────────────────────────
const getMonday = (date: Date): Date => {
  const d   = new Date(date);
  const day = d.getDay();
  d.setDate(d.getDate() - day + (day === 0 ? -6 : 1));
  return d;
};

const parseAptDate = (dateStr: string) => {
  if (!dateStr || dateStr === 'Não agendado') return { date: '', hours: 0, minutes: 0 };
  const normalized = dateStr.replace('T', ' ').replace(/([+-]\d{2}:\d{2}|Z).*$/, '').split('.')[0];
  const [datePart = '', timePart = '00:00'] = normalized.split(' ');
  const [h = 0, m = 0] = timePart.split(':').map(Number);
  return { date: datePart, hours: h || 0, minutes: m || 0 };
};

const getTimeLabel = (dateStr: string): string => {
  if (!dateStr) return '';
  const { hours, minutes } = parseAptDate(dateStr);
  return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;
};

const getTopOffset = (hours: number, minutes: number) =>
  (hours * 60 + minutes - START_HOUR * 60) * (HOUR_HEIGHT / 60);

const toDateStr = (d: Date) => {
  const y  = d.getFullYear();
  const m  = String(d.getMonth() + 1).padStart(2, '0');
  const dd = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${dd}`;
};

const minToTime = (totalMin: number) => {
  const h = Math.floor(totalMin / 60);
  const m = totalMin % 60;
  return `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`;
};

// ─── Types ───────────────────────────────────────────────────────────────────
type Toast = { type: 'success' | 'error'; msg: string } | null;

interface DragPreview {
  aptId:    string;
  topPx:    number;
  heightPx: number;
  date:     string;    // target date (may differ from original in weekly move)
}

const STATUS_OPTIONS = [
  { value: 'scheduled', label: 'Marcado — não confirmado' },
  { value: 'confirmed', label: 'Confirmado' },
  { value: 'completed', label: 'Concluído' },
  { value: 'cancelled', label: 'Cancelado' },
  { value: 'no_show',   label: 'Não compareceu' },
];

// ─────────────────────────────────────────────────────────────────────────────
const Agenda: React.FC<Props> = ({
  patients, professionals, services,
  onSelectPatient, onRefresh, refreshTrigger,
}) => {
  const [view, setView]               = useState<ViewType>('semanal');
  const [selectedProf, setSelectedProf] = useState('all');
  const [currentDate, setCurrentDate] = useState(new Date());
  const [miniCalDate, setMiniCalDate] = useState(new Date());
  const [showQuickAdd, setShowQuickAdd] = useState(false);
  const [prefilled, setPrefilled]     = useState({ date: '', time: '' });
  const [timeLineTop, setTimeLineTop] = useState(0);
  const [saving, setSaving]           = useState(false);
  const [toast, setToast]             = useState<Toast>(null);

  // ── New appointment form ──
  const [formDate, setFormDate]           = useState('');
  const [formTime, setFormTime]           = useState('');
  const [formDuration, setFormDuration]   = useState('01:00');
  const [formServiceId, setFormServiceId] = useState('');
  const [formProfId, setFormProfId]       = useState('');
  const [patientQuery, setPatientQuery]   = useState('');
  const [selPatient, setSelPatient]       = useState<Patient | null>(null);
  const [showDrop, setShowDrop]           = useState(false);
  const [newPatPhone, setNewPatPhone]     = useState('');

  // ── Recorrência (pacotes) ──
  const DAYS_PT = ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb'];
  const [useRecurrence, setUseRecurrence]     = useState(false);
  const [recDays, setRecDays]                 = useState<number[]>([]); // dias da semana 0=Dom
  const [recSessions, setRecSessions]         = useState(10);
  const [recPreview, setRecPreview]           = useState<string[]>([]);
  const [showRecPreview, setShowRecPreview]   = useState(false);

  const generateRecurrenceDates = (startDate: string, days: number[], sessions: number): string[] => {
    if (!startDate || days.length === 0 || sessions <= 0) return [];
    const dates: string[] = [];
    const cur = new Date(startDate + 'T12:00');
    // inclui a data de início se for um dos dias selecionados
    while (dates.length < sessions) {
      if (days.includes(cur.getDay())) dates.push(cur.toISOString().slice(0, 10));
      cur.setDate(cur.getDate() + 1);
      if (dates.length >= sessions) break;
    }
    return dates;
  };

  const toggleRecDay = (day: number) => {
    setRecDays(prev => prev.includes(day) ? prev.filter(d => d !== day) : [...prev, day].sort());
  };

  // ── Appointments (próprio state — não usa patients como fonte) ──
  const [appointments, setAppointments]   = useState<Appointment[]>([]);

  // ── Bloqueios de agenda ──
  interface BlockedSlot { id: string; professional_id: string; start_datetime: string; end_datetime: string; reason?: string; }
  const [blockedSlots, setBlockedSlots]     = useState<BlockedSlot[]>([]);
  const [showBlockModal, setShowBlockModal] = useState(false);
  const [blockForm, setBlockForm]           = useState({ professional_id: '', date: '', end_date: '', start: '08:00', end: '18:00', reason: '', full_day: false });
  const [savingBlock, setSavingBlock]       = useState(false);

  const fetchBlockedSlots = async () => {
    const ref  = new Date();
    const from = new Date(ref); from.setMonth(from.getMonth() - 1);
    const to   = new Date(ref); to.setMonth(to.getMonth() + 12);
    const { data } = await supabase.from('blocked_slots')
      .select('*').gte('start_datetime', from.toISOString()).lte('start_datetime', to.toISOString());
    setBlockedSlots((data || []) as BlockedSlot[]);
  };

  const saveBlock = async () => {
    if (!blockForm.professional_id || !blockForm.date) return;
    setSavingBlock(true);
    const startTime = blockForm.full_day ? '00:00' : blockForm.start;
    const endTime   = blockForm.full_day ? '23:59' : blockForm.end;
    // Se tiver data final diferente, cria um registro por dia
    const startD = new Date(blockForm.date + 'T12:00');
    const endD   = blockForm.end_date ? new Date(blockForm.end_date + 'T12:00') : startD;
    const records = [];
    for (let d = new Date(startD); d <= endD; d.setDate(d.getDate() + 1)) {
      const ds = d.toISOString().slice(0, 10);
      records.push({
        professional_id: blockForm.professional_id,
        start_datetime:  `${ds}T${startTime}:00`,
        end_datetime:    `${ds}T${endTime}:00`,
        reason:          blockForm.reason || null,
      });
    }
    await supabase.from('blocked_slots').insert(records);
    setSavingBlock(false);
    setShowBlockModal(false);
    setBlockForm({ professional_id: '', date: '', end_date: '', start: '08:00', end: '18:00', reason: '', full_day: false });
    fetchBlockedSlots();
  };

  const deleteBlock = async (id: string) => {
    await supabase.from('blocked_slots').delete().eq('id', id);
    fetchBlockedSlots();
  };

  const fetchAppointments = async (centerDate?: Date) => {
    try {
      // Busca janela de -6 meses a +12 meses a partir da data central (evita limite de 1000 linhas do Supabase)
      const ref   = centerDate || new Date();
      const from  = new Date(ref); from.setMonth(from.getMonth() - 6);
      const to    = new Date(ref); to.setMonth(to.getMonth() + 12);
      const fromISO = from.toISOString().split('T')[0];
      const toISO   = to.toISOString().split('T')[0];

      const { data, error } = await supabase
        .from('appointments')
        .select('*, patients(name)')
        .gte('date_time', fromISO)
        .lte('date_time', toISO + 'T23:59:59')
        .order('date_time', { ascending: true })
        .limit(5000);
      if (error) throw error;
      setAppointments(
        (data || []).map((a: any): Appointment => ({
          id:               String(a.id),
          patient_id:       String(a.patient_id),
          patient_name:     a.patients?.name || '',
          professional_id:  a.professional_id ? String(a.professional_id) : '',
          service_id:       a.service_id       ? String(a.service_id)       : '',
          date_time:        a.date_time || '',
          duration_minutes: a.duration_minutes || 60,
          status:           a.status || 'scheduled',
          notes:            a.notes || '',
          created_at:       a.created_at,
          updated_at:       a.updated_at,
        }))
      );
    } catch (err) {
      console.error('Erro ao buscar agendamentos:', err);
    }
  };

  // Refresh externo (ex: paciente deletado pelo PatientProfile)
  useEffect(() => {
    if (refreshTrigger && refreshTrigger > 0) fetchAppointments();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [refreshTrigger]);

  // Busca inicial + realtime
  useEffect(() => {
    fetchAppointments();
    fetchBlockedSlots();

    const channel = supabase
      .channel('agenda-realtime')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'appointments' }, () => {
        fetchAppointments();
      })
      // Quando um paciente é deletado, recarrega agenda para remover cards órfãos
      .on('postgres_changes', { event: 'DELETE', schema: 'public', table: 'patients' }, () => {
        fetchAppointments();
      })
      .subscribe();

    return () => { supabase.removeChannel(channel); };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // ── Edit appointment modal ──
  const [editingApt, setEditingApt]       = useState<Appointment | null>(null);
  const [editTab, setEditTab]             = useState<EditTab>('agendamento');
  const [editDate, setEditDate]           = useState('');
  const [editTime, setEditTime]           = useState('');
  const [editDuration, setEditDuration]   = useState('01:00');
  const [editServiceId, setEditServiceId] = useState('');
  const [editProfId, setEditProfId]       = useState('');
  const [editStatus, setEditStatus]       = useState('scheduled');

  // ── Drag state ──
  const [dragPreview, setDragPreview]     = useState<DragPreview | null>(null);
  const dragPreviewRef                    = useRef<DragPreview | null>(null);   // mirror for closures
  const didDragRef                        = useRef(false);

  // refs
  const gridRef     = useRef<HTMLDivElement>(null);
  const weekGridRef = useRef<HTMLDivElement>(null);
  const searchRef   = useRef<HTMLDivElement>(null);

  // ── Timeline ──
  useEffect(() => {
    const update = () => {
      const now = new Date();
      setTimeLineTop(getTopOffset(now.getHours(), now.getMinutes()));
    };
    update();
    const t = setInterval(update, 60_000);
    return () => clearInterval(t);
  }, []);

  useEffect(() => {
    if (gridRef.current && timeLineTop > 0)
      gridRef.current.scrollTop = Math.max(0, timeLineTop - 120);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // ── Close dropdown on outside click ──
  useEffect(() => {
    const h = (e: MouseEvent) => {
      if (searchRef.current && !searchRef.current.contains(e.target as Node))
        setShowDrop(false);
    };
    document.addEventListener('mousedown', h);
    return () => document.removeEventListener('mousedown', h);
  }, []);

  // ── Auto-hide toast ──
  useEffect(() => {
    if (!toast) return;
    const t = setTimeout(() => setToast(null), 3500);
    return () => clearTimeout(t);
  }, [toast]);

  const todayStr = toDateStr(new Date());

  const filtered = appointments.filter(a =>
    selectedProf === 'all' || a.professional_id === selectedProf,
  );

  // ── Open new-appointment modal ──
  const openAdd = (date: string, time = '08:00') => {
    setPrefilled({ date, time });
    setFormDate(date);
    setFormTime(time);
    setFormDuration('01:00');
    setFormServiceId(services[0]?.id || '');
    setFormProfId(professionals[0]?.id || '');
    setPatientQuery('');
    setSelPatient(null);
    setShowDrop(false);
    setShowQuickAdd(true);
  };

  // ── Open edit modal ──
  const openEdit = (apt: Appointment) => {
    const parsed  = parseAptDate(apt.date_time);
    const durMin  = apt.duration_minutes || 60;
    setEditingApt(apt);
    setEditTab('agendamento');
    setEditDate(parsed.date || toDateStr(new Date()));
    setEditTime(parsed.hours || parsed.minutes
      ? `${String(parsed.hours).padStart(2, '0')}:${String(parsed.minutes).padStart(2, '0')}`
      : '08:00');
    setEditDuration(`${String(Math.floor(durMin / 60)).padStart(2, '0')}:${String(durMin % 60).padStart(2, '0')}`);
    setEditServiceId(apt.service_id || '');
    setEditProfId(apt.professional_id || '');
    setEditStatus(apt.status || 'scheduled');
  };

  const handleEditSave = async () => {
    if (!editingApt) return;
    const [dh, dm] = editDuration.split(':').map(Number);
    const dur = (dh || 0) * 60 + (dm || 0) || 60;
    const profId = editProfId || editingApt.professional_id;
    if (profId) {
      const aptStart = new Date(`${editDate}T${editTime}:00`).getTime();
      const aptEnd   = aptStart + dur * 60000;
      const conflict = blockedSlots.find(b => {
        if (b.professional_id !== profId) return false;
        const bStart = new Date(b.start_datetime).getTime();
        const bEnd   = new Date(b.end_datetime).getTime();
        return aptStart < bEnd && aptEnd > bStart;
      });
      if (conflict) {
        const profName = professionals.find(p => p.id === profId)?.name?.split(' ')[0] || 'profissional';
        setToast({ type: 'error', msg: `${profName} está com agenda bloqueada neste horário${conflict.reason ? ` (${conflict.reason})` : ''}.` });
        return;
      }
    }
    setSaving(true);
    try {
      const updates: Record<string, any> = {
        date_time:        `${editDate}T${editTime}:00`,
        duration_minutes: dur,
        status:           editStatus,
      };
      if (editProfId)    updates.professional_id = editProfId;
      if (editServiceId) updates.service_id       = editServiceId;
      const { error } = await supabase.from('appointments').update(updates).eq('id', editingApt.id);
      if (error) throw error;
      await fetchAppointments();
      setEditingApt(null);
      setToast({ type: 'success', msg: 'Agendamento atualizado!' });
    } catch (err: any) {
      setToast({ type: 'error', msg: `Erro: ${err?.message}` });
    } finally {
      setSaving(false);
    }
  };

  const handleDeleteApt = async () => {
    if (!editingApt) return;
    const patName = patients.find(p => p.id === editingApt.patient_id)?.name || 'paciente';
    if (!window.confirm(`Remover agendamento de ${patName}?`)) return;
    setSaving(true);
    try {
      const { error } = await supabase.from('appointments').delete().eq('id', editingApt.id);
      if (error) throw error;
      // Volta o status do paciente para lead no CRM
      // Paciente mantém seu status — cancelar consulta não afeta o cadastro
      await fetchAppointments();
      setEditingApt(null);
      setToast({ type: 'success', msg: 'Agendamento removido.' });
    } catch (err: any) {
      setToast({ type: 'error', msg: `Erro: ${err?.message}` });
    } finally {
      setSaving(false);
    }
  };

  // ── Submit new apt ──
  const patientSuggestions = patientQuery.trim().length >= 1
    ? patients.filter(p =>
        p.name.toLowerCase().includes(patientQuery.toLowerCase()) ||
        p.phone?.includes(patientQuery)
      ).slice(0, 8)
    : [];

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selPatient)            { setToast({ type: 'error', msg: 'Selecione um paciente.' }); return; }

    // Se for paciente novo, cria no banco antes de agendar
    let patientId = selPatient.id;
    if (selPatient.id === 'NEW_FROM_AGENDA') {
      // Gera proximo numero de prontuario sequencial
      // Busca todos os record_numbers numericos e pega o maior
      const { data: maxData } = await supabase
        .from('patients')
        .select('record_number')
        .not('record_number', 'is', null);
      let nextNum = 1;
      if (maxData && maxData.length > 0) {
        const nums = maxData
          .map((p: any) => parseInt(p.record_number, 10))
          .filter((n: number) => !isNaN(n) && n > 0);
        if (nums.length > 0) nextNum = Math.max(...nums) + 1;
      }
      const record_number = String(nextNum);

      const { data: newPat, error: patErr } = await supabase
        .from('patients')
        .insert([{
          name: toTitleCase(selPatient.name),
          phone: newPatPhone.trim() || null,
          record_number,
          status: 'scheduled',
        }])
        .select('id')
        .single();
      if (patErr || !newPat) { setToast({ type: 'error', msg: 'Erro ao criar paciente.' }); setSaving(false); return; }
      patientId = String(newPat.id);
    }
    if (!formDate || !formTime) { setToast({ type: 'error', msg: 'Informe data e horário.' }); return; }

    // Valida bloqueio de agenda
    if (formProfId) {
      const [dh, dm] = formDuration.split(':').map(Number);
      const dur = (dh || 0) * 60 + (dm || 0) || 60;
      const aptStart = new Date(`${formDate}T${formTime}:00`).getTime();
      const aptEnd   = aptStart + dur * 60000;
      const conflict = blockedSlots.find(b => {
        if (b.professional_id !== formProfId) return false;
        const bStart = new Date(b.start_datetime).getTime();
        const bEnd   = new Date(b.end_datetime).getTime();
        return aptStart < bEnd && aptEnd > bStart;
      });
      if (conflict) {
        const profName = professionals.find(p => p.id === formProfId)?.name?.split(' ')[0] || 'profissional';
        setToast({ type: 'error', msg: `${profName} está com agenda bloqueada neste horário${conflict.reason ? ` (${conflict.reason})` : ''}.` });
        return;
      }
    }

    setSaving(true);
    try {
      const [dh, dm] = formDuration.split(':').map(Number);
      const dur = (dh || 0) * 60 + (dm || 0) || 60;

      if (useRecurrence && recDays.length > 0 && recSessions > 1) {
        // ── Modo recorrência: cria série + múltiplos agendamentos ──
        const dates = generateRecurrenceDates(formDate, recDays, recSessions);
        if (dates.length === 0) { setToast({ type: 'error', msg: 'Selecione pelo menos 1 dia da semana.' }); setSaving(false); return; }

        // Cria a série
        const { data: seriesData, error: seriesErr } = await supabase
          .from('appointment_series')
          .insert({ patient_id: patientId, professional_id: formProfId || null, service_id: formServiceId || null, total_sessions: dates.length })
          .select('id').single();
        if (seriesErr) throw seriesErr;
        const seriesId = seriesData.id;

        // Cria todos os agendamentos
        const apts = dates.map((date, i) => ({
          patient_id:       patientId,
          date_time:        `${date}T${formTime}:00`,
          duration_minutes: dur,
          status:           'scheduled',
          professional_id:  formProfId || null,
          service_id:       formServiceId || null,
          series_id:        seriesId,
          session_number:   i + 1,
        }));
        const { error: aptErr } = await supabase.from('appointments').insert(apts);
        if (aptErr) throw aptErr;
        setToast({ type: 'success', msg: `${dates.length} sessões de ${selPatient.name} agendadas!` });
      } else {
        // ── Modo simples: 1 agendamento ──
        const newApt: Record<string, any> = {
          patient_id:       patientId,
          date_time:        `${formDate}T${formTime}:00`,
          duration_minutes: dur,
          status:           'scheduled',
        };
        if (formProfId)    newApt.professional_id = formProfId;
        if (formServiceId) newApt.service_id       = formServiceId;
        const { error } = await supabase.from('appointments').insert(newApt);
        if (error) throw error;
        setToast({ type: 'success', msg: `Agendamento de ${selPatient.name} salvo!` });
      }

      // Atualiza status do paciente
      await supabase.from('patients').update({ status: 'scheduled' }).eq('id', patientId);
      await fetchAppointments();
      setShowQuickAdd(false);
      setNewPatPhone('');
      setUseRecurrence(false);
      setRecDays([]);
      setRecSessions(10);
      setShowRecPreview(false);
      onRefresh();
    } catch (err: any) {
      setToast({ type: 'error', msg: `Erro ao salvar: ${err?.message}` });
    } finally {
      setSaving(false);
    }
  };

  // ── Navigation ──
  const navigate = (dir: 1 | -1) => {
    const d = new Date(currentDate);
    if (view === 'diario')  d.setDate(d.getDate() + dir);
    if (view === 'semanal') d.setDate(d.getDate() + dir * 7);
    if (view === 'mensal')  d.setMonth(d.getMonth() + dir);
    setCurrentDate(d);
    setMiniCalDate(d);
    // Re-busca se navegou para fora da janela carregada
    fetchAppointments(d);
  };

  const goToday = () => { setCurrentDate(new Date()); setMiniCalDate(new Date()); };

  const periodLabel = () => {
    if (view === 'diario')
      return currentDate.toLocaleDateString('pt-BR', { weekday: 'short', day: '2-digit', month: 'short', year: 'numeric' });
    if (view === 'semanal') {
      const mon = getMonday(new Date(currentDate));
      const sun = new Date(mon); sun.setDate(mon.getDate() + 6);
      return `${mon.toLocaleDateString('pt-BR', { day: '2-digit', month: 'short' })} – ${sun.toLocaleDateString('pt-BR', { day: '2-digit', month: 'short', year: 'numeric' })}`;
    }
    return currentDate.toLocaleDateString('pt-BR', { month: 'long', year: 'numeric' });
  };

  const todayApts    = appointments.filter(a => a.date_time?.startsWith(todayStr));
  const confirmedCnt = todayApts.filter(a => a.status === 'confirmed').length;
  const pendingCnt   = todayApts.filter(a => a.status === 'scheduled').length;

  // ─────────────────────────── DRAG & DROP ─────────────────────────────────
  /**
   * startDrag — closure-based approach so handlers always see fresh state
   * without useCallback/stale-closure issues.
   */
  const startDrag = (
    type: 'move' | 'resize',
    apt: Appointment,
    e: React.MouseEvent,
    scale: number,
    weekDays?: Date[],
  ) => {
    e.stopPropagation();
    e.preventDefault();
    didDragRef.current = false;

    const parsed   = parseAptDate(apt.date_time);
    const origMins = parsed.hours * 60 + parsed.minutes;
    const origDur  = apt.duration_minutes || 60;
    const origDate = parsed.date;
    const startY   = e.clientY;
    const startX   = e.clientX;
    const pxPerMin = (HOUR_HEIGHT / 60) * scale;

    // Calculate column width for weekly drag
    let colWidth = 0;
    if (weekDays && weekGridRef.current) {
      const totalW = weekGridRef.current.clientWidth - 56; // subtract hour column
      colWidth = totalW / weekDays.length;
    }

    const setPreview = (preview: DragPreview | null) => {
      dragPreviewRef.current = preview;
      setDragPreview(preview);
    };

    const handleMove = (ev: MouseEvent) => {
      const deltaY = ev.clientY - startY;
      if (Math.abs(deltaY) < 2 && Math.abs(ev.clientX - startX) < 2 && !didDragRef.current) return;
      didDragRef.current = true;

      if (type === 'resize') {
        const deltaMin   = Math.round(deltaY / pxPerMin / SNAP_MIN) * SNAP_MIN;
        const newDur     = Math.max(15, origDur + deltaMin);
        const topPx      = (origMins - START_HOUR * 60) * pxPerMin;
        setPreview({ aptId: apt.id, topPx, heightPx: newDur * pxPerMin, date: origDate });
      }

      if (type === 'move') {
        const deltaMin   = Math.round(deltaY / pxPerMin / SNAP_MIN) * SNAP_MIN;
        const newMins    = Math.max(START_HOUR * 60, Math.min((END_HOUR - 1) * 60, origMins + deltaMin));
        const topPx      = (newMins - START_HOUR * 60) * pxPerMin;
        const heightPx   = origDur * pxPerMin;

        let newDate = origDate;
        if (weekDays && colWidth > 0 && weekGridRef.current) {
          const rect   = weekGridRef.current.getBoundingClientRect();
          const relX   = ev.clientX - rect.left - 56;
          const colIdx = Math.max(0, Math.min(weekDays.length - 1, Math.floor(relX / colWidth)));
          newDate      = toDateStr(weekDays[colIdx]);
        }

        setPreview({ aptId: apt.id, topPx, heightPx, date: newDate });
      }
    };

    const handleUp = async (ev: MouseEvent) => {
      document.removeEventListener('mousemove', handleMove);
      document.removeEventListener('mouseup', handleUp);

      const preview = dragPreviewRef.current;
      setPreview(null);

      if (!didDragRef.current || !preview) return;

      try {
        if (type === 'resize') {
          const deltaY  = ev.clientY - startY;
          const deltaM  = Math.round(deltaY / pxPerMin / SNAP_MIN) * SNAP_MIN;
          const newDur  = Math.max(15, origDur + deltaM);
          const { error } = await supabase.from('appointments').update({ duration_minutes: newDur }).eq('id', apt.id);
          if (error) throw error;
          await fetchAppointments();
          setToast({ type: 'success', msg: 'Duração atualizada!' });
        }
        if (type === 'move') {
          const deltaY  = ev.clientY - startY;
          const deltaM  = Math.round(deltaY / pxPerMin / SNAP_MIN) * SNAP_MIN;
          const newMins = Math.max(START_HOUR * 60, Math.min((END_HOUR - 1) * 60, origMins + deltaM));
          const { error } = await supabase.from('appointments').update({ date_time: `${preview.date}T${minToTime(newMins)}:00` }).eq('id', apt.id);
          if (error) throw error;
          await fetchAppointments();
          setToast({ type: 'success', msg: 'Agendamento movido!' });
        }
      } catch (err: any) {
        setToast({ type: 'error', msg: `Erro: ${err?.message}` });
      }
    };

    document.addEventListener('mousemove', handleMove);
    document.addEventListener('mouseup', handleUp);
  };

  // ─── Calcula colunas para agendamentos sobrepostos ──────────────────────────
  const computeColumns = (apts: Appointment[]): Map<string, { col: number; total: number }> => {
    const result = new Map<string, { col: number; total: number }>();
    const toMin = (apt: Appointment) => {
      const p = parseAptDate(apt.date_time);
      return p.hours * 60 + p.minutes;
    };
    const endMin = (apt: Appointment) => toMin(apt) + (apt.duration_minutes || 60);

    // Ordena por horário de início
    const sorted = [...apts].sort((a, b) => toMin(a) - toMin(b));

    // Grupos de sobreposição
    const groups: Appointment[][] = [];
    for (const apt of sorted) {
      let placed = false;
      for (const group of groups) {
        if (group.some(g => toMin(apt) < endMin(g) && endMin(apt) > toMin(g))) {
          group.push(apt);
          placed = true;
          break;
        }
      }
      if (!placed) groups.push([apt]);
    }

    for (const group of groups) {
      // Atribui colunas dentro do grupo (greedy)
      const cols: Appointment[][] = [];
      for (const apt of group) {
        let assigned = false;
        for (let c = 0; c < cols.length; c++) {
          if (!cols[c].some(g => toMin(apt) < endMin(g) && endMin(apt) > toMin(g))) {
            cols[c].push(apt);
            result.set(apt.id, { col: c, total: 0 }); // total preenchido depois
            assigned = true;
            break;
          }
        }
        if (!assigned) {
          result.set(apt.id, { col: cols.length, total: 0 });
          cols.push([apt]);
        }
      }
      // Preenche total com número de colunas do grupo
      const total = cols.length;
      for (const apt of group) {
        const entry = result.get(apt.id);
        if (entry) entry.total = total;
      }
    }
    return result;
  };

  // ─────────────────────────── AptCard ─────────────────────────────────────
  // Defined as a render function (not JSX component) to avoid remount issues.
  const renderCard = (
    apt: Appointment,
    topPx: number,
    heightPx: number,
    scale = 1,
    weekDays?: Date[],
    colIndex = 0,
    totalCols = 1,
  ) => {
    const service  = services.find(s => s.id === apt.service_id);
    const prof     = professionals.find(p => p.id === apt.professional_id);
    const patName  = (apt as any).patient_name || patients.find(p => p.id === apt.patient_id)?.name || 'Paciente';
    const colors   = getProfColor(prof?.color || 'blue');

    // Compute time range string "HH:MM – HH:MM"
    const parsedTime   = parseAptDate(apt.date_time);
    const durMin       = apt.duration_minutes || service?.duration || 60;
    const endTotalMin  = parsedTime.hours * 60 + parsedTime.minutes + durMin;
    const endH         = Math.floor(endTotalMin / 60) % 24;
    const endM         = endTotalMin % 60;
    const timeStr      = `${String(parsedTime.hours).padStart(2,'0')}:${String(parsedTime.minutes).padStart(2,'0')} – ${String(endH).padStart(2,'0')}:${String(endM).padStart(2,'0')}`;

    const isDragging  = dragPreview?.aptId === apt.id;
    const previewTop  = isDragging ? dragPreview!.topPx    : topPx;
    const previewH    = isDragging ? dragPreview!.heightPx : heightPx;
    const origDate    = parseAptDate(apt.date_time).date;
    const movedAway   = isDragging && dragPreview!.date !== origDate;

    // Tempo dinâmico durante o drag — atualiza em tempo real
    const liveTimeStr = (() => {
      if (!isDragging) return timeStr;
      const pxPerMin = HOUR_HEIGHT / 60 * scale;
      const startMin = Math.round(previewTop / pxPerMin) + START_HOUR * 60;
      const durCur   = Math.round(previewH / pxPerMin);
      const endMin   = startMin + durCur;
      const sh = Math.floor(startMin / 60) % 24, sm = startMin % 60;
      const eh = Math.floor(endMin   / 60) % 24, em = endMin   % 60;
      return `${String(sh).padStart(2,'0')}:${String(sm).padStart(2,'0')} – ${String(eh).padStart(2,'0')}:${String(em).padStart(2,'0')}`;
    })();

    // If card is being dragged to a different column, show ghost on original position
    if (movedAway) {
      return (
        <div
          key={apt.id}
          style={{
            position: 'absolute',
            top: topPx + 2,
            left: `calc(${(colIndex / totalCols) * 100}% + ${scale > 1 ? 12 : 3}px)`,
            width: `calc(${(1 / totalCols) * 100}% - ${scale > 1 ? 24 : 6}px)`,
            height: Math.max(28, heightPx - 4),
            background: colors.bg,
            borderLeft: `${scale > 1 ? '4px' : '3px'} solid ${colors.border}`,
            opacity: 0.25, zIndex: 5,
          }}
          className={scale > 1 ? 'rounded-xl' : 'rounded-lg'}
        />
      );
    }

    if (topPx < 0 || topPx > HOURS.length * HOUR_HEIGHT * scale) return null;

    return (
      <div
        key={apt.id}
        style={{
          position: 'absolute',
          top: previewTop + 2,
          left: `calc(${(colIndex / totalCols) * 100}% + ${scale > 1 ? 12 : 3}px)`,
          width: `calc(${(1 / totalCols) * 100}% - ${scale > 1 ? 24 : 6}px)`,
          height: Math.max(28, previewH - 4),
          background:  colors.bg,
          borderLeft:  `${scale > 1 ? '4px' : '3px'} solid ${colors.border}`,
          color:        colors.text,
          zIndex:       isDragging ? 20 : 5,
          cursor:       isDragging ? 'grabbing' : 'grab',
          boxShadow:    isDragging ? '0 8px 30px rgba(0,0,0,0.18)' : undefined,
        }}
        className={`${scale > 1 ? 'rounded-xl px-3 py-2' : 'rounded-lg px-2 py-1'} overflow-hidden hover:brightness-95 transition-colors duration-150 shadow-sm select-none group/card`}
        onMouseDown={e => {
          // Don't start move-drag from name or resize handle
          const tgt = e.target as HTMLElement;
          if (tgt.closest('[data-apt-name]') || tgt.closest('[data-apt-resize]')) return;
          startDrag('move', apt, e, scale, weekDays);
        }}
        onClick={e => {
          if (didDragRef.current) return;
          e.stopPropagation();
          openEdit(apt);
        }}
      >
        {/* Time range — atualiza em tempo real durante o drag */}
        <div className={`flex items-center gap-0.5 ${scale > 1 ? 'text-[10px]' : 'text-[8px]'} font-bold leading-none mb-0.5 ${isDragging ? 'opacity-100' : 'opacity-75'}`}>
          <Clock className={scale > 1 ? 'w-3 h-3' : 'w-2.5 h-2.5'} />
          {isDragging ? (
            <span className="font-black" style={{ color: colors.border }}>{liveTimeStr}</span>
          ) : liveTimeStr}
        </div>

        {/* Patient name — click opens profile */}
        <p
          data-apt-name
          className={`${scale > 1 ? 'text-sm' : 'text-[10px]'} font-black leading-tight truncate hover:underline cursor-pointer`}
          onMouseDown={e => e.stopPropagation()}
          onClick={e => {
            e.stopPropagation();
            if (didDragRef.current) return;
            onSelectPatient(apt.patient_id);
          }}
        >
          {patName}
        </p>

        {previewH > (scale > 1 ? 44 : 38) && (
          <div className={`flex items-center gap-1.5 mt-0.5`}>
            {/* Avatar circular do profissional */}
            <div
              className="w-4 h-4 rounded-full overflow-hidden flex items-center justify-center text-white flex-shrink-0"
              style={{ background: colors.border, fontSize: '7px', fontWeight: 700 }}
            >
              {(prof as any)?.photo_url
                ? <img src={(prof as any).photo_url} alt={prof?.name} className="w-full h-full object-cover" />
                : (prof?.name?.slice(0, 2) || '?').toUpperCase()
              }
            </div>
            <p className={`${scale > 1 ? 'text-[11px]' : 'text-[9px]'} font-semibold opacity-70 truncate`}>
              {service?.name || 'Consulta'}{scale > 1 && prof ? ` · ${prof.name}` : ''}
            </p>
          </div>
        )}

        {/* Resize handle (bottom edge) */}
        {previewH > 32 && (
          <div
            data-apt-resize
            className="absolute bottom-0 left-0 right-0 h-4 flex items-center justify-center opacity-0 group-hover/card:opacity-100 transition-opacity cursor-s-resize z-10"
            onMouseDown={e => { e.stopPropagation(); startDrag('resize', apt, e, scale, weekDays); }}
            onClick={e => e.stopPropagation()}
          >
            <div className="w-8 h-0.5 rounded-full" style={{ background: colors.border, opacity: 0.5 }} />
          </div>
        )}
      </div>
    );
  };

  // Ghost card rendered on target column during cross-day drag
  const renderDragGhost = (targetDate: string, scale = 1) => {
    if (!dragPreview || dragPreview.date !== targetDate) return null;
    const apt = appointments.find(a => a.id === dragPreview.aptId);
    if (!apt) return null;
    const origDate = parseAptDate(apt.date_time).date;
    if (origDate === targetDate) return null; // same column: original card handles it

    const prof    = professionals.find(p => p.id === apt.professional_id);
    const colors  = getProfColor(prof?.color || 'blue');
    const patName = (apt as any).patient_name || patients.find(p => p.id === apt.patient_id)?.name || 'Paciente';

    return (
      <div
        style={{
          position: 'absolute',
          top: dragPreview.topPx + 2,
          left: scale > 1 ? 12 : 3, right: scale > 1 ? 12 : 3,
          height: Math.max(28, dragPreview.heightPx - 4),
          background: colors.bg,
          borderLeft: `${scale > 1 ? '4px' : '3px'} solid ${colors.border}`,
          color: colors.text,
          opacity: 0.85, zIndex: 20,
        }}
        className={`${scale > 1 ? 'rounded-xl px-3 py-2' : 'rounded-lg px-2 py-1'} pointer-events-none shadow-xl`}
      >
        <p className={`${scale > 1 ? 'text-sm' : 'text-[10px]'} font-black leading-tight truncate`}>{patName}</p>
      </div>
    );
  };

  // ─────────────────────────── TimeLine ────────────────────────────────────
  const TimeLine = ({ scale = 1 }: { scale?: number }) => (
    <div style={{ position: 'absolute', top: timeLineTop * scale, left: 0, right: 0, zIndex: 10 }} className="pointer-events-none">
      <div className="relative h-0.5 bg-rose-500">
        <div className="absolute -left-1.5 -top-[5px] w-3 h-3 rounded-full bg-rose-500 border-2 border-white shadow-sm" />
      </div>
    </div>
  );

  // ─────────────────────────── Mini Calendar ───────────────────────────────
  const renderMiniCal = () => {
    const year  = miniCalDate.getFullYear();
    const month = miniCalDate.getMonth();
    const first = new Date(year, month, 1).getDay();
    const total = new Date(year, month + 1, 0).getDate();
    const off   = first === 0 ? 6 : first - 1;
    const cells = Array.from({ length: 42 }, (_, i) => {
      const d = i - off + 1; return d > 0 && d <= total ? d : null;
    });
    const today = new Date();
    return (
      <div>
        <div className="flex items-center justify-between mb-3">
          <span className="text-xs font-black text-slate-800 capitalize">
            {miniCalDate.toLocaleDateString('pt-BR', { month: 'long', year: 'numeric' })}
          </span>
          <div className="flex gap-0.5">
            {([-1, 1] as const).map(dir => (
              <button key={dir}
                onClick={() => { const d = new Date(miniCalDate); d.setMonth(d.getMonth() + dir); setMiniCalDate(d); }}
                className="w-6 h-6 flex items-center justify-center rounded-lg hover:bg-slate-200 text-slate-400 hover:text-slate-700 transition-colors"
              >
                {dir === -1 ? <ChevronLeft className="w-3.5 h-3.5" /> : <ChevronRight className="w-3.5 h-3.5" />}
              </button>
            ))}
          </div>
        </div>
        <div className="grid grid-cols-7 mb-1">
          {['S','T','Q','Q','S','S','D'].map((d, i) => (
            <div key={i} className="text-center text-[9px] font-black text-slate-400 uppercase py-0.5">{d}</div>
          ))}
        </div>
        <div className="grid grid-cols-7 gap-0.5">
          {cells.map((day, i) => {
            if (!day) return <div key={i} />;
            const ds      = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
            const isToday = today.getFullYear() === year && today.getMonth() === month && today.getDate() === day;
            const isSel   = currentDate.getFullYear() === year && currentDate.getMonth() === month && currentDate.getDate() === day;
            const hasApt  = appointments.some(a => a.date_time?.startsWith(ds));
            return (
              <button key={i}
                onClick={() => { const c = new Date(year, month, day); setCurrentDate(c); setMiniCalDate(c); setView('diario'); }}
                className={`aspect-square flex flex-col items-center justify-center rounded-lg text-[11px] font-bold transition-all relative
                  ${isToday ? 'bg-indigo-600 text-white' : isSel ? 'bg-indigo-50 text-indigo-700 ring-1 ring-indigo-300' : 'text-slate-600 hover:bg-slate-200'}`}
              >
                {day}
                {hasApt && !isToday && <div className="absolute bottom-0.5 w-1 h-1 rounded-full" style={{ background: '#52c9c2' }} />}
              </button>
            );
          })}
        </div>
      </div>
    );
  };

  // ─────────────────────────── Weekly View ─────────────────────────────────
  const renderWeekly = () => {
    const monday   = getMonday(new Date(currentDate));
    const weekDays = Array.from({ length: 7 }, (_, i) => { const d = new Date(monday); d.setDate(monday.getDate() + i); return d; });

    return (
      <div className="flex flex-col flex-1 overflow-hidden">
        <div className="flex border-b border-slate-100 bg-white shrink-0">
          <div className="w-14 shrink-0" />
          {weekDays.map((day, idx) => {
            const ds      = toDateStr(day);
            const isToday = ds === todayStr;
            const cnt     = filtered.filter(a => a.date_time?.startsWith(ds)).length;
            return (
              <div key={idx}
                className={`flex-1 min-w-[90px] flex flex-col items-center py-2.5 border-l border-slate-100 cursor-pointer hover:bg-slate-50 transition-colors ${isToday ? 'bg-indigo-50/40' : ''}`}
                onClick={() => { setCurrentDate(day); setView('diario'); }}
              >
                <span className={`text-[9px] font-black uppercase tracking-widest ${isToday ? 'text-indigo-500' : 'text-slate-400'}`}>{DAYS_OF_WEEK[idx]}</span>
                <span className={`text-lg font-black mt-0.5 leading-none flex items-center justify-center ${isToday ? 'bg-indigo-600 text-white w-8 h-8 rounded-full' : 'text-slate-700'}`}>{day.getDate()}</span>
                {cnt > 0 && <span className={`mt-1 text-[9px] font-bold ${isToday ? 'text-indigo-500' : 'text-slate-400'}`}>{cnt} apt</span>}
              </div>
            );
          })}
        </div>

        <div ref={weekGridRef} className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="flex">
            <div className="w-14 shrink-0 border-r border-slate-100">
              {HOURS.map(h => (
                <div key={h} style={{ height: HOUR_HEIGHT }} className="flex items-start justify-center pt-1 text-[10px] font-bold text-slate-300">
                  {String(h).padStart(2, '0')}h
                </div>
              ))}
            </div>

            {weekDays.map((day, dIdx) => {
              const ds      = toDateStr(day);
              const isToday = ds === todayStr;
              const dayApts = filtered.filter(a => a.date_time?.startsWith(ds));
              const isDragTarget = dragPreview?.date === ds;

              return (
                <div key={dIdx}
                  className={`flex-1 min-w-[90px] relative border-l border-slate-100 ${isToday ? 'bg-indigo-50/15' : ''} ${isDragTarget ? 'bg-indigo-50/25' : ''}`}
                  style={{ height: HOURS.length * HOUR_HEIGHT }}
                >
                  {HOURS.map(h => (
                    <div key={h}
                      style={{ position: 'absolute', top: (h - START_HOUR) * HOUR_HEIGHT, left: 0, right: 0, height: HOUR_HEIGHT }}
                      className={`hover:bg-indigo-50/30 transition-colors cursor-pointer group ${dragPreview ? 'border-b border-slate-200' : 'border-b border-slate-100'}`}
                      onClick={() => openAdd(ds, `${String(h).padStart(2, '0')}:00`)}
                    >
                      {/* Linhas de 15 em 15 min visíveis durante o drag */}
                      {dragPreview && [15, 30, 45].map(m => (
                        <div key={m} style={{ position: 'absolute', top: m * (HOUR_HEIGHT / 60), left: 0, right: 0, height: 1 }}
                          className="border-t border-slate-100 border-dashed" />
                      ))}
                      <div className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                        <Plus className="w-3 h-3 text-indigo-300" />
                      </div>
                    </div>
                  ))}

                  {isToday && <TimeLine />}

                  {(() => {
                    const colMap = computeColumns(dayApts);
                    return dayApts.map(apt => {
                      const parsed  = parseAptDate(apt.date_time);
                      const service = services.find(s => s.id === apt.service_id);
                      const { col, total } = colMap.get(apt.id) || { col: 0, total: 1 };
                      return renderCard(
                        apt,
                        getTopOffset(parsed.hours, parsed.minutes),
                        (apt.duration_minutes || service?.duration || 60) * (HOUR_HEIGHT / 60),
                        1,
                        weekDays,
                        col,
                        total,
                      );
                    });
                  })()}

                  {/* Bloqueios de horário */}
                  {blockedSlots.filter(b => {
                    const bDate = b.start_datetime.slice(0, 10);
                    return bDate === ds && (selectedProf === 'all' || b.professional_id === selectedProf);
                  }).map(b => {
                    const prof = professionals.find(p => p.id === b.professional_id);
                    const startH = parseInt(b.start_datetime.slice(11, 13));
                    const startM = parseInt(b.start_datetime.slice(14, 16));
                    const endH   = parseInt(b.end_datetime.slice(11, 13));
                    const endM   = parseInt(b.end_datetime.slice(14, 16));
                    const topPx  = getTopOffset(startH, startM);
                    const hPx    = ((endH * 60 + endM) - (startH * 60 + startM)) * (HOUR_HEIGHT / 60);
                    const c      = getProfColor(prof?.color || 'blue');
                    return (
                      <div key={b.id} style={{
                        position: 'absolute', top: topPx + 2, left: 3, right: 3,
                        height: Math.max(24, hPx - 4), zIndex: 4,
                        background: `repeating-linear-gradient(45deg, ${c.bg}, ${c.bg} 6px, ${c.bg}cc 6px, ${c.bg}cc 12px)`,
                        border: `1.5px dashed ${c.border}`,
                        borderRadius: 8, opacity: 0.85,
                        // Quando "Todos" está selecionado, não bloqueia cliques de outros profissionais
                        pointerEvents: selectedProf === 'all' ? 'none' : 'auto',
                      }}
                        className="flex flex-col justify-between px-2 py-1 overflow-hidden"
                      >
                        <div className="flex items-center justify-between">
                          <span className="text-[9px] font-semibold" style={{ color: c.border }}>
                            🔒 {prof?.name?.split(' ')[0]} — {b.reason || 'Bloqueado'}
                          </span>
                          {selectedProf !== 'all' && (
                            <button onClick={() => deleteBlock(b.id)}
                              className="text-[10px] opacity-60 hover:opacity-100 transition-opacity ml-1"
                              style={{ color: c.border }}>✕</button>
                          )}
                        </div>
                        <span className="text-[8px] opacity-60" style={{ color: c.border }}>
                          {b.start_datetime.slice(11, 16)} – {b.end_datetime.slice(11, 16)}
                        </span>
                      </div>
                    );
                  })}

                  {/* Ghost on target column when dragging to a different day */}
                  {renderDragGhost(ds, 1)}
                </div>
              );
            })}
          </div>
        </div>
      </div>
    );
  };

  // ─────────────────────────── Daily View ──────────────────────────────────
  const renderDaily = () => {
    const ds      = toDateStr(currentDate);
    const isToday = ds === todayStr;
    const dayApts = filtered.filter(a => a.date_time?.startsWith(ds));
    const SCALE   = 1.5;

    return (
      <div className="flex flex-col flex-1 overflow-hidden">
        <div className="flex items-center justify-between px-6 py-3 border-b border-slate-100 bg-white shrink-0">
          <div>
            <h3 className="font-black text-slate-800 text-base capitalize">
              {currentDate.toLocaleDateString('pt-BR', { weekday: 'long', day: '2-digit', month: 'long' })}
            </h3>
            <p className="text-xs text-slate-400 font-semibold mt-0.5">
              {dayApts.length} agendamento{dayApts.length !== 1 ? 's' : ''}
            </p>
          </div>
        </div>

        <div ref={gridRef} className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="flex">
            <div className="w-16 shrink-0 border-r border-slate-100">
              {HOURS.map(h => (
                <div key={h} style={{ height: HOUR_HEIGHT * SCALE }} className="flex items-start justify-center pt-2 text-[11px] font-bold text-slate-300">
                  {String(h).padStart(2, '0')}h
                </div>
              ))}
            </div>
            <div className={`flex-1 relative ${isToday ? 'bg-indigo-50/10' : ''}`} style={{ height: HOURS.length * HOUR_HEIGHT * SCALE }}>
              {HOURS.map(h => (
                <div key={h}
                  style={{ position: 'absolute', top: (h - START_HOUR) * HOUR_HEIGHT * SCALE, left: 0, right: 0, height: HOUR_HEIGHT * SCALE }}
                  className="border-b border-slate-100 hover:bg-indigo-50/20 transition-colors cursor-pointer group"
                  onClick={() => openAdd(ds, `${String(h).padStart(2, '0')}:00`)}
                >
                  <div className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                    <div className="flex items-center gap-2 text-[11px] font-bold text-indigo-300 border border-dashed border-indigo-200 px-4 py-2 rounded-xl">
                      <Plus className="w-3.5 h-3.5" /> Agendar horário
                    </div>
                  </div>
                </div>
              ))}
              {isToday && <TimeLine scale={SCALE} />}
              {(() => {
                const colMap = computeColumns(dayApts);
                return dayApts.map(apt => {
                  const parsed  = parseAptDate(apt.date_time);
                  const service = services.find(s => s.id === apt.service_id);
                  const { col, total } = colMap.get(apt.id) || { col: 0, total: 1 };
                  return renderCard(
                    apt,
                    getTopOffset(parsed.hours, parsed.minutes) * SCALE,
                    (apt.duration_minutes || service?.duration || 60) * (HOUR_HEIGHT / 60) * SCALE,
                    SCALE,
                    undefined,
                    col,
                    total,
                  );
                });
              })()}
            </div>
          </div>
        </div>
      </div>
    );
  };

  // ─────────────────────────── Monthly View ────────────────────────────────
  const renderMonthly = () => {
    const year  = currentDate.getFullYear();
    const month = currentDate.getMonth();
    const first = new Date(year, month, 1).getDay();
    const total = new Date(year, month + 1, 0).getDate();
    const off   = first === 0 ? 6 : first - 1;
    const cells = Array.from({ length: 42 }, (_, i) => { const d = i - off + 1; return d > 0 && d <= total ? d : null; });
    const today = new Date();

    return (
      <div className="flex flex-col flex-1 overflow-hidden">
        <div className="grid grid-cols-7 border-b border-slate-100 bg-slate-50/50 shrink-0">
          {DAYS_OF_WEEK.map(d => (
            <div key={d} className="py-3 text-center text-[9px] font-black text-slate-400 uppercase tracking-widest">{d}</div>
          ))}
        </div>
        <div className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="grid grid-cols-7 auto-rows-[110px] divide-x divide-y divide-slate-100">
            {cells.map((day, idx) => {
              const ds      = day ? `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}` : '';
              const dayApts = day ? filtered.filter(a => a.date_time?.startsWith(ds)) : [];
              const isToday = day ? new Date(year, month, day).toDateString() === today.toDateString() : false;
              return (
                <div key={idx}
                  onClick={() => day && openAdd(ds)}
                  className={`p-2 transition-colors relative group ${day ? 'bg-white hover:bg-indigo-50/20 cursor-pointer' : 'bg-slate-50/50'}`}
                >
                  {day && (
                    <>
                      <div className="flex justify-between items-center mb-1">
                        <span className={`text-sm font-black w-7 h-7 flex items-center justify-center rounded-full ${isToday ? 'bg-indigo-600 text-white shadow-md' : 'text-slate-700 hover:bg-slate-100'}`}>{day}</span>
                        <Plus className="w-3 h-3 text-indigo-300 opacity-0 group-hover:opacity-100 transition-opacity" />
                      </div>
                      <div className="space-y-0.5 overflow-hidden max-h-[70px]">
                        {dayApts.slice(0, 3).map(apt => {
                          const prof    = professionals.find(p => p.id === apt.professional_id);
                          const colors  = getProfColor(prof?.color || 'blue');
                          const patName = (apt as any).patient_name || patients.find(p => p.id === apt.patient_id)?.name || 'Paciente';
                          return (
                            <div key={apt.id}
                              onClick={e => { e.stopPropagation(); openEdit(apt); }}
                              style={{ background: colors.bg, color: colors.text, borderLeft: `2px solid ${colors.border}` }}
                              className="text-[9px] font-bold px-1.5 py-0.5 rounded truncate hover:brightness-95 transition-all cursor-pointer"
                            >
                              {getTimeLabel(apt.date_time)} {patName}
                            </div>
                          );
                        })}
                        {dayApts.length > 3 && <p className="text-[9px] font-bold text-slate-400 px-1">+{dayApts.length - 3} mais</p>}
                      </div>
                    </>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      </div>
    );
  };

  // ─────────────────────────── Render ──────────────────────────────────────
  // Derived: paciente do agendamento em edição (para o modal Ficha)
  const editingPatient = editingApt ? patients.find(p => p.id === editingApt.patient_id) ?? null : null;
  const epName = editingPatient?.name || 'Paciente';

  return (
    <div className="flex h-full">

      {/* ── Sidebar ── */}
      <div className="w-52 shrink-0 bg-slate-50 border-r border-slate-100 flex flex-col gap-4 p-3.5 overflow-y-auto custom-scrollbar">
        <button
          onClick={() => openAdd(toDateStr(currentDate))}
          className="w-full flex items-center justify-center gap-1.5 bg-indigo-600 text-white rounded-xl py-2.5 px-3 text-xs font-semibold hover:bg-indigo-700 transition-all shadow-md shadow-indigo-900/10 active:scale-95"
        >
          <Plus className="w-3.5 h-3.5 shrink-0" />
          <span>Novo Agendamento</span>
        </button>
        <button
          onClick={() => setShowBlockModal(true)}
          className="w-full flex items-center justify-center gap-1.5 bg-slate-100 text-slate-600 rounded-xl py-2.5 px-3 text-xs font-semibold hover:bg-slate-200 transition-all active:scale-95"
        >
          <span>🔒</span>
          <span>Bloquear Horário</span>
        </button>

        {/* Lista de bloqueios futuros */}
        {blockedSlots.filter(b => b.start_datetime >= new Date().toISOString().slice(0, 10)).length > 0 && (
          <div className="mt-1">
            <p className="text-[9px] font-semibold text-slate-400 uppercase tracking-widest mb-1.5 px-1">Bloqueios</p>
            <div className="space-y-1 max-h-40 overflow-y-auto custom-scrollbar">
              {blockedSlots
                .filter(b => b.start_datetime >= new Date().toISOString().slice(0, 10))
                .sort((a, b) => a.start_datetime.localeCompare(b.start_datetime))
                .map(b => {
                  const prof = professionals.find(p => p.id === b.professional_id);
                  const c = getProfColor(prof?.color || 'blue');
                  const dateLabel = new Date(b.start_datetime).toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit' });
                  const isFullDay = b.start_datetime.includes('00:00') && b.end_datetime.includes('23:59');
                  return (
                    <div key={b.id} className="flex items-center gap-1.5 px-2 py-1.5 rounded-lg bg-white border border-slate-100 group">
                      <div className="w-2 h-2 rounded-full shrink-0" style={{ background: c.border }} />
                      <div className="flex-1 min-w-0">
                        <p className="text-[10px] font-medium text-slate-700 truncate">{prof?.name?.split(' ')[0]}</p>
                        <p className="text-[9px] text-slate-400 truncate">
                          {dateLabel} {isFullDay ? '· Dia inteiro' : `· ${b.start_datetime.slice(11,16)}–${b.end_datetime.slice(11,16)}`}
                          {b.reason ? ` · ${b.reason}` : ''}
                        </p>
                      </div>
                      <button onClick={() => deleteBlock(b.id)}
                        className="opacity-0 group-hover:opacity-100 text-slate-300 hover:text-rose-400 transition-all text-[10px] shrink-0">✕</button>
                    </div>
                  );
                })}
            </div>
          </div>
        )}

        <div className="bg-white rounded-2xl p-3.5 shadow-sm border border-slate-100">
          {renderMiniCal()}
        </div>

        <div>
          <p className="text-[9px] font-black text-slate-400 uppercase tracking-widest mb-2 px-1">Profissionais</p>
          <div className="space-y-0.5">
            <button onClick={() => setSelectedProf('all')}
              className={`w-full flex items-center gap-2.5 px-3 py-2 rounded-xl text-[11px] font-medium transition-all ${selectedProf === 'all' ? 'bg-white border border-slate-200 text-slate-800 shadow-sm' : 'text-slate-500 hover:bg-white/60'}`}>
              <div className="w-7 h-7 rounded-full bg-slate-200 flex items-center justify-center text-slate-500 text-[10px] font-bold shrink-0">
                Td
              </div>
              <span className="truncate">Todos</span>
            </button>
            {professionals.map(prof => {
              const c = getProfColor(prof.color);
              const initials2 = prof.name.trim().split(/\s+/).slice(0, 2).map((w: string) => w[0]).join('').toUpperCase();
              return (
                <button key={prof.id} onClick={() => setSelectedProf(prof.id)}
                  title={(() => {
                    const p = prof as any;
                    const conselho = [p.council, p.council_number, p.council_uf ? `/${p.council_uf}` : ''].filter(Boolean).join(' ');
                    return [prof.specialty, conselho].filter(Boolean).join(' · ') || undefined;
                  })()}
                  className={`w-full flex items-center gap-2.5 px-3 py-2 rounded-xl text-[11px] font-medium transition-all ${selectedProf === prof.id ? 'bg-white border border-slate-200 text-slate-800 shadow-sm' : 'text-slate-500 hover:bg-white/60'}`}>
                  {/* Avatar circular com foto ou iniciais */}
                  <div
                    className="w-7 h-7 rounded-full overflow-hidden flex items-center justify-center text-white text-[10px] font-bold shrink-0 ring-2 ring-offset-1"
                    style={{ background: c.border, outline: `2px solid ${c.border}`, outlineOffset: '1px' }}
                  >
                    {(prof as any).photo_url
                      ? <img src={(prof as any).photo_url} alt={prof.name} className="w-full h-full object-cover" />
                      : initials2
                    }
                  </div>
                  <span className="truncate">{prof.name}</span>
                </button>
              );
            })}
          </div>
        </div>


      </div>

      {/* ── Calendar area ── */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden bg-white">
        <div className="flex items-center gap-3 px-5 py-3 border-b border-slate-100 shrink-0">
          <div className="flex bg-slate-100 rounded-xl p-1 gap-0.5">
            {(['diario', 'semanal', 'mensal'] as ViewType[]).map(v => (
              <button key={v} onClick={() => setView(v)}
                className={`px-4 py-1.5 text-[10px] font-black uppercase tracking-widest rounded-lg transition-all ${view === v ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-400 hover:text-slate-600'}`}>
                {v === 'diario' ? 'Dia' : v === 'semanal' ? 'Semana' : 'Mês'}
              </button>
            ))}
          </div>
          <button onClick={goToday} className="px-4 py-1.5 text-[11px] font-bold border border-slate-200 rounded-xl text-slate-600 hover:bg-slate-50 transition-all">
            Hoje
          </button>
          <div className="flex items-center gap-2 ml-auto">
            <button onClick={() => navigate(-1)} className="w-8 h-8 flex items-center justify-center hover:bg-slate-100 rounded-xl transition-all text-slate-400 hover:text-indigo-600">
              <ChevronLeft className="w-4 h-4" />
            </button>
            <span className="text-sm font-black text-slate-800 min-w-[200px] text-center capitalize">{periodLabel()}</span>
            <button onClick={() => navigate(1)} className="w-8 h-8 flex items-center justify-center hover:bg-slate-100 rounded-xl transition-all text-slate-400 hover:text-indigo-600">
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        </div>

        {view === 'diario'  && renderDaily()}
        {view === 'semanal' && renderWeekly()}
        {view === 'mensal'  && renderMonthly()}
      </div>

      {/* ── Toast ── */}
      {toast && (
        <div className={`fixed bottom-6 right-6 z-[60] flex items-center gap-3 px-5 py-4 rounded-2xl shadow-2xl animate-in slide-in-from-bottom-4 duration-300 text-sm font-bold ${toast.type === 'success' ? 'bg-emerald-600 text-white' : 'bg-rose-600 text-white'}`}>
          {toast.type === 'success' ? <CheckCircle2 className="w-5 h-5 shrink-0" /> : <AlertCircle className="w-5 h-5 shrink-0" />}
          {toast.msg}
        </div>
      )}

      {/* ── Modal: Novo Agendamento ── */}
      {showQuickAdd && (
        <div className="fixed inset-0 bg-slate-950/60 backdrop-blur-xl z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-[2.5rem] w-full max-w-md p-8 shadow-2xl relative overflow-hidden">
            <div className="absolute top-0 right-0 w-32 h-32 bg-indigo-50 rounded-full -mr-16 -mt-16 blur-3xl opacity-50 pointer-events-none" />
            <div className="relative z-10">
              <div className="flex items-center justify-between mb-8">
                <div className="flex items-center gap-4">
                  <div className="w-11 h-11 bg-indigo-50 text-indigo-600 rounded-2xl flex items-center justify-center shadow-sm"><CalIcon size={22} /></div>
                  <div>
                    <h3 className="text-xl font-black text-slate-900 tracking-tight">Novo Agendamento</h3>
                    <p className="text-slate-400 text-xs font-semibold mt-0.5">{prefilled.date}</p>
                  </div>
                </div>
                <button onClick={() => setShowQuickAdd(false)} className="w-9 h-9 flex items-center justify-center hover:bg-slate-100 rounded-xl transition-all">
                  <X className="w-4 h-4 text-slate-400" />
                </button>
              </div>
              <form className="space-y-5" onSubmit={handleSubmit}>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-1.5">
                    <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Data</label>
                    <input type="date" value={formDate} onChange={e => setFormDate(e.target.value)} className="premium-input" required />
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Horário</label>
                    <input type="time" value={formTime} onChange={e => setFormTime(e.target.value)} className="premium-input" required />
                  </div>
                </div>
                <div className="space-y-1.5 relative" ref={searchRef}>
                  <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Paciente</label>
                  <div className="relative">
                    <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
                    <input type="text" placeholder="Digite o nome do paciente..."
                      value={selPatient ? selPatient.name : patientQuery}
                      onChange={e => { setPatientQuery(e.target.value); setSelPatient(null); setShowDrop(true); }}
                      onBlur={e => { if (!selPatient) setPatientQuery(toTitleCase(e.target.value)); }}
                      onFocus={() => { if (!selPatient) setShowDrop(true); }}
                      className={`premium-input ${selPatient ? 'bg-indigo-50 text-indigo-700 font-bold' : ''}`}
                      style={{ paddingLeft: '3rem' }}
                      autoComplete="off"
                    />
                    {selPatient && (
                      <button type="button" onClick={() => { setSelPatient(null); setPatientQuery(''); setShowDrop(false); }}
                        className="absolute right-3 top-1/2 -translate-y-1/2 w-6 h-6 flex items-center justify-center hover:bg-indigo-100 rounded-lg transition-colors">
                        <X className="w-3.5 h-3.5 text-indigo-400" />
                      </button>
                    )}
                  </div>
                  {/* Botão fixo quando há texto mas sem paciente selecionado */}
                  {!selPatient && patientQuery.trim().length >= 2 && !showDrop && (
                    <button type="button"
                      onClick={() => {
                        setSelPatient({ id: 'NEW_FROM_AGENDA', name: patientQuery.trim(), email: '', phone: '', status: 'lead' } as any);
                        setShowDrop(false);
                      }}
                      className="absolute z-20 left-0 right-0 top-full mt-1 w-full flex items-center gap-3 px-4 py-3 bg-white border border-emerald-200 rounded-2xl shadow-lg hover:bg-emerald-50 transition-colors text-left">
                      <div className="w-8 h-8 rounded-xl bg-emerald-100 text-emerald-600 flex items-center justify-center font-black text-sm shrink-0">+</div>
                      <div>
                        <p className="text-sm font-bold text-emerald-700">Criar "{patientQuery.trim()}"</p>
                        <p className="text-[10px] text-slate-400 font-semibold">Novo paciente — salvo ao confirmar</p>
                      </div>
                    </button>
                  )}

                  {showDrop && !selPatient && patientQuery.trim().length >= 1 && (
                    <div className="absolute z-20 left-0 right-0 top-full mt-1 bg-white border border-slate-100 rounded-2xl shadow-2xl overflow-hidden">
                      {patientSuggestions.length > 0
                        ? patientSuggestions.map(p => (
                            <button key={p.id} type="button"
                              onMouseDown={() => { setSelPatient(p); setPatientQuery(''); setShowDrop(false); }}
                              className="w-full flex items-center gap-3 px-4 py-3 hover:bg-slate-50 transition-colors text-left border-b border-slate-50 last:border-b-0">
                              <div className="w-8 h-8 rounded-xl bg-indigo-50 text-indigo-600 flex items-center justify-center font-black text-sm shrink-0">{p.name.charAt(0).toUpperCase()}</div>
                              <div className="min-w-0">
                                <p className="text-sm font-bold text-slate-800 truncate">{p.name}</p>
                                {p.phone && <p className="text-[10px] text-slate-400 font-semibold">{p.phone}</p>}
                              </div>
                            </button>
                          ))
                        : (
                          <button type="button"
                            onMouseDown={() => {
                              // Cria paciente temporário "novo" com o nome digitado
                              setSelPatient({ id: 'NEW_FROM_AGENDA', name: patientQuery.trim(), email: '', phone: '', status: 'lead' } as any);
                              setShowDrop(false);
                            }}
                            className="w-full flex items-center gap-3 px-4 py-3 hover:bg-emerald-50 transition-colors text-left">
                            <div className="w-8 h-8 rounded-xl bg-emerald-100 text-emerald-600 flex items-center justify-center font-black text-sm shrink-0">+</div>
                            <div>
                              <p className="text-sm font-bold text-emerald-700">Criar "{patientQuery.trim()}"</p>
                              <p className="text-[10px] text-slate-400 font-semibold">Novo paciente — salvo ao agendar</p>
                            </div>
                          </button>
                        )
                      }
                    </div>
                  )}
                </div>
                {/* Campo telefone — aparece apenas para paciente novo */}
                {selPatient?.id === 'NEW_FROM_AGENDA' && (
                  <div className="space-y-1.5 animate-in fade-in duration-200">
                    <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">
                      Telefone / WhatsApp *
                    </label>
                    <input
                      type="tel"
                      value={newPatPhone}
                      onChange={e => setNewPatPhone(e.target.value)}
                      placeholder="(00) 00000-0000"
                      className="premium-input"
                    />
                  </div>
                )}

                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-1.5">
                    <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Serviço</label>
                    <select value={formServiceId} onChange={e => {
                      setFormServiceId(e.target.value);
                      const svc = services.find(s => s.id === e.target.value);
                      if (svc) { const h = Math.floor(svc.duration / 60); const m = svc.duration % 60; setFormDuration(`${String(h).padStart(2,'0')}:${String(m).padStart(2,'0')}`); }
                    }} className="premium-input appearance-none">
                      {services.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                    </select>
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Profissional</label>
                    <select value={formProfId} onChange={e => setFormProfId(e.target.value)} className="premium-input appearance-none">
                      {professionals.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
                    </select>
                  </div>
                </div>
                <div className="space-y-1.5">
                  <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Duração do Atendimento</label>
                  <input type="time" value={formDuration} onChange={e => setFormDuration(e.target.value)} min="00:15" className="premium-input" />
                </div>
                {formTime && formDuration && (() => {
                  const [sh, sm] = formTime.split(':').map(Number);
                  const [dh, dm] = formDuration.split(':').map(Number);
                  const totalMin = (sh||0)*60 + (sm||0) + (dh||0)*60 + (dm||0);
                  const endH = Math.floor(totalMin / 60) % 24; const endM = totalMin % 60;
                  const durLabel = (dh||0) > 0 ? ((dm||0) > 0 ? `${dh}h${String(dm).padStart(2,'0')}min` : `${dh}h`) : `${dm}min`;
                  return (
                    <p className="text-[11px] text-slate-400 font-semibold flex items-center gap-1.5 -mt-1">
                      <Clock className="w-3.5 h-3.5" />
                      {durLabel} · Término aprox. às {String(endH).padStart(2,'0')}:{String(endM).padStart(2,'0')}
                    </p>
                  );
                })()}
                {/* ── Recorrência ── */}
                <div className="border border-slate-100 rounded-2xl p-4 space-y-3 bg-slate-50/50">
                  <label className="flex items-center gap-2.5 cursor-pointer" onClick={() => setUseRecurrence(v => !v)}>
                    <div className="relative">
                      <div className={`w-9 h-5 rounded-full transition-colors ${useRecurrence ? 'bg-indigo-600' : 'bg-slate-200'}`} />
                      <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${useRecurrence ? 'translate-x-4' : ''}`} />
                    </div>
                    <span className="text-sm font-medium text-slate-700">Agendar como pacote / recorrência</span>
                  </label>

                  {useRecurrence && (
                    <div className="space-y-3 pt-1">
                      <div>
                        <p className="text-[10px] text-slate-400 uppercase tracking-wider mb-2">Dias da semana</p>
                        <div className="flex gap-1.5 flex-wrap">
                          {DAYS_PT.map((d, i) => (
                            <button key={i} type="button"
                              onClick={() => toggleRecDay(i)}
                              className={`px-2.5 py-1 text-xs rounded-lg font-medium transition-all ${recDays.includes(i)
                                ? 'bg-indigo-600 text-white shadow-sm'
                                : 'bg-white text-slate-500 border border-slate-200 hover:border-indigo-300'}`}>
                              {d}
                            </button>
                          ))}
                        </div>
                      </div>

                      <div className="flex items-center gap-3">
                        <div className="flex-1">
                          <p className="text-[10px] text-slate-400 uppercase tracking-wider mb-1.5">Total de sessões</p>
                          <div className="flex items-center gap-2">
                            <button type="button" onClick={() => setRecSessions(s => Math.max(1, s - 1))}
                              className="w-7 h-7 rounded-lg bg-white border border-slate-200 text-slate-500 hover:bg-slate-50 flex items-center justify-center text-sm font-bold">−</button>
                            <span className="text-lg font-semibold text-slate-800 w-8 text-center">{recSessions}</span>
                            <button type="button" onClick={() => setRecSessions(s => Math.min(60, s + 1))}
                              className="w-7 h-7 rounded-lg bg-white border border-slate-200 text-slate-500 hover:bg-slate-50 flex items-center justify-center text-sm font-bold">+</button>
                            <span className="text-xs text-slate-400">sessões</span>
                          </div>
                        </div>
                        {recDays.length > 0 && (
                          <div className="text-right">
                            <p className="text-[10px] text-slate-400">Frequência</p>
                            <p className="text-sm font-medium text-indigo-600">{recDays.length}x/semana</p>
                          </div>
                        )}
                      </div>

                      {formDate && recDays.length > 0 && recSessions > 0 && (
                        <button type="button"
                          onClick={() => { setRecPreview(generateRecurrenceDates(formDate, recDays, recSessions)); setShowRecPreview(v => !v); }}
                          className="text-xs text-indigo-600 hover:text-indigo-800 font-medium underline">
                          {showRecPreview ? 'Ocultar' : 'Ver'} as {recSessions} datas →
                        </button>
                      )}

                      {showRecPreview && recPreview.length > 0 && (
                        <div className="bg-white rounded-xl border border-slate-100 p-3 overflow-y-auto custom-scrollbar space-y-1" style={{ maxHeight: '200px' }}>
                          <p className="text-[10px] text-slate-400 mb-2 font-medium">{recPreview.length} sessões geradas:</p>
                          {recPreview.map((d, i) => (
                            <div key={d} className="flex items-center gap-2 text-xs text-slate-600 py-0.5">
                              <span className="w-5 h-5 rounded-full bg-indigo-50 text-indigo-600 flex items-center justify-center text-[10px] font-bold shrink-0">{i+1}</span>
                              <span className="capitalize">{new Date(d + 'T12:00').toLocaleDateString('pt-BR', { weekday: 'long', day: '2-digit', month: '2-digit', year: '2-digit' })}</span>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>
                  )}
                </div>

                <button type="submit" disabled={saving || !selPatient || !selPatient.name.trim()}
                  className="w-full premium-button bg-indigo-600 text-white shadow-lg shadow-indigo-900/20 hover:bg-indigo-700 mt-2 disabled:opacity-60 disabled:cursor-not-allowed">
                  {saving
                    ? <><Loader2 className="w-4 h-4 animate-spin" /> Salvando...</>
                    : useRecurrence && recDays.length > 0
                      ? <><Check size={18} /> Agendar {recSessions} sessões</>
                      : <><Check size={18} /> Confirmar Agendamento</>
                  }
                </button>
              </form>
            </div>
          </div>
        </div>
      )}

      {/* ── Modal: Editar Agendamento ── */}
      {editingApt && (
        <div className="fixed inset-0 bg-slate-950/60 backdrop-blur-xl z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-[2rem] w-full max-w-lg shadow-2xl overflow-hidden flex flex-col max-h-[90vh]">

            {/* Header */}
            <div className="px-6 pt-6 pb-0 shrink-0">
              <div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-2xl bg-indigo-100 text-indigo-700 flex items-center justify-center font-black text-base shrink-0">
                    {epName.charAt(0).toUpperCase()}
                  </div>
                  <div>
                    <h3 className="text-base font-black text-slate-900 leading-tight">{epName}</h3>
                    <p className="text-[11px] text-slate-400 font-semibold">
                      {editDate && new Date(editDate + 'T00:00').toLocaleDateString('pt-BR', { day: '2-digit', month: 'short' })}
                      {editTime && ` · ${editTime}`}
                    </p>
                  </div>
                </div>
                <button onClick={() => setEditingApt(null)} className="w-9 h-9 flex items-center justify-center hover:bg-slate-100 rounded-xl transition-all">
                  <X className="w-4 h-4 text-slate-400" />
                </button>
              </div>

              {/* Tabs */}
              <div className="flex border-b border-slate-100 -mx-6 px-6">
                {[
                  { key: 'agendamento', label: 'Agendamento', Icon: CalIcon },
                  { key: 'ficha',       label: 'Ficha',       Icon: User },
                  { key: 'historico',   label: 'Histórico',   Icon: FileText },
                ].map(({ key, label, Icon }) => (
                  <button key={key}
                    onClick={() => setEditTab(key as EditTab)}
                    className={`flex items-center gap-1.5 px-4 py-3 text-[11px] font-black uppercase tracking-widest border-b-2 transition-all -mb-px
                      ${editTab === key ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-400 hover:text-slate-600'}`}
                  >
                    <Icon className="w-3.5 h-3.5" />
                    {label}
                  </button>
                ))}
              </div>
            </div>

            {/* Tab body */}
            <div className="flex-1 overflow-y-auto p-6 custom-scrollbar">

              {/* ── Tab: Agendamento ── */}
              {editTab === 'agendamento' && (
                <div className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-1.5">
                      <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Data</label>
                      <input type="date" value={editDate} onChange={e => setEditDate(e.target.value)} className="premium-input" />
                    </div>
                    <div className="space-y-1.5">
                      <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Horário</label>
                      <input type="time" value={editTime} onChange={e => setEditTime(e.target.value)} className="premium-input" />
                    </div>
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Duração</label>
                    <input type="time" value={editDuration} onChange={e => setEditDuration(e.target.value)} min="00:15" className="premium-input" />
                    {editTime && editDuration && (() => {
                      const [sh, sm] = editTime.split(':').map(Number);
                      const [dh, dm] = editDuration.split(':').map(Number);
                      const totalMin = (sh||0)*60 + (sm||0) + (dh||0)*60 + (dm||0);
                      const endH = Math.floor(totalMin / 60) % 24; const endM = totalMin % 60;
                      const durLabel = (dh||0) > 0 ? ((dm||0) > 0 ? `${dh}h${String(dm).padStart(2,'0')}min` : `${dh}h`) : `${dm}min`;
                      return (
                        <p className="text-[11px] text-slate-400 font-semibold flex items-center gap-1.5 mt-1">
                          <Clock className="w-3.5 h-3.5" />
                          {durLabel} · Término aprox. às {String(endH).padStart(2,'0')}:{String(endM).padStart(2,'0')}
                        </p>
                      );
                    })()}
                  </div>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="space-y-1.5">
                      <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Serviço</label>
                      <select value={editServiceId} onChange={e => {
                        setEditServiceId(e.target.value);
                        const svc = services.find(s => s.id === e.target.value);
                        if (svc) { const h = Math.floor(svc.duration / 60); const m = svc.duration % 60; setEditDuration(`${String(h).padStart(2,'0')}:${String(m).padStart(2,'0')}`); }
                      }} className="premium-input appearance-none">
                        <option value="">Selecione...</option>
                        {services.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                      </select>
                    </div>
                    <div className="space-y-1.5">
                      <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Profissional</label>
                      <select value={editProfId} onChange={e => setEditProfId(e.target.value)} className="premium-input appearance-none">
                        <option value="">Selecione...</option>
                        {professionals.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
                      </select>
                    </div>
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-[10px] font-black uppercase text-slate-400 ml-1 tracking-widest">Status</label>
                    <select value={editStatus} onChange={e => setEditStatus(e.target.value)} className="premium-input appearance-none">
                      {STATUS_OPTIONS.map(o => <option key={o.value} value={o.value}>{o.label}</option>)}
                    </select>
                  </div>
                </div>
              )}

              {/* ── Tab: Ficha ── */}
              {editTab === 'ficha' && (
                <div className="flex flex-col items-center py-4 gap-4">
                  <div className="w-20 h-20 bg-indigo-100 rounded-3xl flex items-center justify-center">
                    <span className="text-3xl font-black text-indigo-500">{epName.charAt(0).toUpperCase()}</span>
                  </div>
                  <div className="text-center">
                    <p className="text-lg font-black text-slate-800">{epName}</p>
                    {editingPatient?.phone && <p className="text-sm text-slate-400 mt-0.5">{editingPatient.phone}</p>}
                    {editingPatient?.email && <p className="text-sm text-slate-400">{editingPatient.email}</p>}
                    {editingPatient?.cpf   && <p className="text-xs text-slate-300 mt-1">CPF: {editingPatient.cpf}</p>}
                  </div>

                  {/* Quick info pills */}
                  <div className="flex flex-wrap gap-2 justify-center">
                    {editingPatient?.insurance && (
                      <span className="px-3 py-1 bg-blue-50 text-blue-700 text-xs font-bold rounded-full">{editingPatient.insurance}</span>
                    )}
                    {editingPatient?.blood_type && (
                      <span className="px-3 py-1 bg-rose-50 text-rose-700 text-xs font-bold rounded-full">Tipo {editingPatient.blood_type}</span>
                    )}
                    {editingPatient?.alerts && (
                      <span className="px-3 py-1 bg-amber-50 text-amber-700 text-xs font-bold rounded-full">⚠ {editingPatient.alerts}</span>
                    )}
                  </div>

                  {editingPatient?.observation && (
                    <div className="w-full bg-slate-50 rounded-2xl p-4 text-sm text-slate-600 font-medium leading-relaxed">
                      {editingPatient.observation}
                    </div>
                  )}

                  <button
                    onClick={() => { setEditingApt(null); onSelectPatient(editingApt.patient_id); }}
                    className="flex items-center gap-2 px-6 py-3 bg-indigo-600 text-white text-sm font-bold rounded-xl hover:bg-indigo-700 transition-colors"
                  >
                    <User className="w-4 h-4" /> Abrir ficha completa
                  </button>
                </div>
              )}

              {/* ── Tab: Histórico ── */}
              {editTab === 'historico' && (
                <div className="flex flex-col items-center justify-center py-12 text-slate-300">
                  <FileText className="w-12 h-12 mb-3 opacity-40" />
                  <p className="text-sm font-bold text-slate-500">Histórico em breve</p>
                  <p className="text-xs text-slate-400 mt-1 text-center max-w-[220px]">
                    Esta funcionalidade estará disponível em uma próxima versão do SintesIA.
                  </p>
                </div>
              )}
            </div>

            {/* Footer actions */}
            <div className="px-6 pb-6 pt-4 border-t border-slate-100 flex gap-2.5 shrink-0">
              <button onClick={handleDeleteApt} disabled={saving}
                className="px-4 py-2.5 bg-rose-50 text-rose-600 text-sm font-bold rounded-xl hover:bg-rose-100 transition-colors disabled:opacity-50">
                Excluir
              </button>
              <button onClick={() => setEditingApt(null)}
                className="px-4 py-2.5 border border-slate-200 text-slate-600 text-sm font-bold rounded-xl hover:bg-slate-50 transition-colors">
                        Cancelar
              </button>
              <button onClick={handleEditSave} disabled={saving}
                className="flex-1 px-4 py-2.5 bg-indigo-600 text-white text-sm font-bold rounded-xl hover:bg-indigo-700 transition-colors disabled:opacity-50 flex items-center justify-center gap-2 shadow-lg shadow-indigo-900/20">
                {saving ? <><Loader2 className="w-4 h-4 animate-spin" /> Salvando...</> : <><Check className="w-4 h-4" /> Salvar</>}
              </button>
            </div>
          </div>
        </div>
      )}
      {/* ── Modal: Bloquear Horário ── */}
      {showBlockModal && (
        <div className="fixed inset-0 bg-slate-950/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md">
            <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
              <div className="flex items-center gap-2">
                <span>🔒</span>
                <h3 className="text-base font-semibold text-slate-800">Bloquear Horário</h3>
              </div>
              <button onClick={() => setShowBlockModal(false)}
                className="w-8 h-8 flex items-center justify-center rounded-xl text-slate-400 hover:bg-slate-100 transition-all">
                <X className="w-4 h-4" />
              </button>
            </div>

            <div className="p-5 space-y-4">
              <div>
                <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Profissional *</label>
                <select className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white appearance-none"
                  value={blockForm.professional_id}
                  onChange={e => setBlockForm(f => ({ ...f, professional_id: e.target.value }))}>
                  <option value="">Selecione...</option>
                  {professionals.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
                </select>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Data início *</label>
                  <input type="date" className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                    value={blockForm.date}
                    onChange={e => setBlockForm(f => ({ ...f, date: e.target.value }))} />
                </div>
                <div>
                  <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Data fim (opcional)</label>
                  <input type="date" className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                    value={blockForm.end_date} min={blockForm.date}
                    onChange={e => setBlockForm(f => ({ ...f, end_date: e.target.value }))} />
                </div>
              </div>

              {/* Toggle: dia inteiro */}
              <label className="flex items-center gap-2.5 cursor-pointer" onClick={() => setBlockForm(f => ({ ...f, full_day: !f.full_day }))}>
                <div className="relative">
                  <div className={`w-9 h-5 rounded-full transition-colors ${blockForm.full_day ? 'bg-slate-700' : 'bg-slate-200'}`} />
                  <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${blockForm.full_day ? 'translate-x-4' : ''}`} />
                </div>
                <span className="text-sm text-slate-600">Bloquear dia inteiro</span>
              </label>

              {!blockForm.full_day && (
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Início</label>
                    <input type="time" className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                      value={blockForm.start}
                      onChange={e => setBlockForm(f => ({ ...f, start: e.target.value }))} />
                  </div>
                  <div>
                    <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Fim</label>
                    <input type="time" className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                      value={blockForm.end}
                      onChange={e => setBlockForm(f => ({ ...f, end: e.target.value }))} />
                  </div>
                </div>
              )}

              <div>
                <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Motivo (opcional)</label>
                <input className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                  placeholder="Ex: Folga, Reunião, Férias..."
                  value={blockForm.reason}
                  onChange={e => setBlockForm(f => ({ ...f, reason: e.target.value }))} />
              </div>
            </div>

            <div className="flex gap-2 px-5 py-4 border-t border-slate-100">
              <button onClick={() => setShowBlockModal(false)}
                className="px-4 py-2 text-sm text-slate-500 border border-slate-200 rounded-xl hover:bg-slate-50 transition-all">
                Cancelar
              </button>
              <button onClick={saveBlock} disabled={savingBlock || !blockForm.professional_id || !blockForm.date}
                className="flex-1 flex items-center justify-center gap-2 py-2 bg-slate-800 text-white text-sm font-medium rounded-xl hover:bg-slate-900 disabled:opacity-50 transition-all">
                {savingBlock ? <Loader2 className="w-4 h-4 animate-spin" /> : '🔒'}
                Bloquear Horário
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
};

export default Agenda;
