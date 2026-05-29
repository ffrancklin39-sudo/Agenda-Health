import React, { useState, useEffect, useRef } from 'react';
import { DragDropContext, Droppable, Draggable, DropResult } from '@hello-pangea/dnd';
import { supabase } from '../services/supabaseClient'; 
import { Patient } from '../types';
import { phoneMatchKey } from '../phoneUtils';
import { Phone, MessageCircle, DollarSign, Check, UserPlus, BellRing, Bell, Edit2, Trash2, AlarmClock, AlignLeft, X, Stethoscope } from 'lucide-react';

// --- CONFIGURAÇÃO DAS COLUNAS ---
const COLUMNS = {
  'lead': { title: 'Novos Leads', color: 'bg-indigo-50/40', text: 'text-indigo-700', border: 'border-indigo-100' },
  'negotiation': { title: 'Em Conversa', color: 'bg-blue-50/40', text: 'text-blue-700', border: 'border-blue-100' },
  'waiting': { title: 'Atenção Humana', color: 'bg-amber-50/40', text: 'text-amber-700', border: 'border-amber-100' },
  'scheduled': { title: 'Agendados', color: 'bg-purple-50/40', text: 'text-purple-700', border: 'border-purple-100' },
  'discarded': { title: 'Leads Frios', color: 'bg-slate-50', text: 'text-slate-500', border: 'border-slate-200' }
};

interface CRMiProps {
  onSelectPatient?: (id: string) => void;
  patients: Patient[];
  onRefresh: () => void;
  onSaveReminder: (id: string, date: string, note: string) => Promise<void>;
  onUpdatePatient: (id: string, updates: Partial<Patient>) => void;
  session?: any;
}

const CRMi: React.FC<CRMiProps> = ({ onSelectPatient, patients: initialPatients, onRefresh, onSaveReminder, onUpdatePatient }) => {
  // ⚙️ PLANO B: Referência e Estado do Motor de Rolagem
  const scrollContainerRef = useRef<HTMLDivElement>(null);
  const [isDragging, setIsDragging] = useState(false);

  // Modais de Arraste
  const [showPaymentModal, setShowPaymentModal] = useState(false);
  const [showRefundModal, setShowRefundModal] = useState(false);
  const [pendingDrag, setPendingDrag] = useState<{ draggableId: string, source: any, destination: any } | null>(null);

  // Modais Comuns
  const [showAddModal, setShowAddModal] = useState(false);
  const [showReminderModal, setShowReminderModal] = useState(false);
  
  // Formulários e Estados
  const [editingPatientId, setEditingPatientId] = useState<string | null>(null);
  const [showConfirmModal, setShowConfirmModal] = useState(false);
  const [confirmingPatient, setConfirmingPatient] = useState<Patient | null>(null);
  const [confirmValue, setConfirmValue] = useState('');
  const [confirmSuccess, setConfirmSuccess] = useState<string | null>(null);
  const [dealValue, setDealValue] = useState('');
  const [refundData, setRefundData] = useState<{ name: string, price: number } | null>(null);
  const [newPatientData, setNewPatientData] = useState({ name: '', phone: '', email: '' });
  const [isSubmitting, setIsSubmitting] = useState(false);
  
  // Lembretes
  const [selectedForReminder, setSelectedForReminder] = useState<Patient | null>(null);
  const [reminderDate, setReminderDate] = useState('');
  const [reminderNote, setReminderNote] = useState('');
  const [dueReminders, setDueReminders] = useState<Patient[]>([]);

  // Sincronização Local
  const [localPatients, setLocalPatients] = useState<Patient[]>(initialPatients);

  useEffect(() => {
    setLocalPatients(initialPatients);
  }, [initialPatients]);

  // 🚀 PLANO B: O Motor de Rolagem Manual (Força Bruta)
  useEffect(() => {
    if (!isDragging) return; // Só liga o motor se estiver arrastando um card

    let animationFrameId: number;

    const handleMouseMove = (e: MouseEvent) => {
      if (!scrollContainerRef.current) return;

      const container = scrollContainerRef.current;
      const rect = container.getBoundingClientRect();
      const edgeThreshold = 100; // Distância da borda para acionar o motor (em pixels)
      const scrollSpeed = 15; // Velocidade da rolagem (quanto maior, mais rápido)

      // Verifica se o mouse está nas bordas da tela
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

  useEffect(() => {
    const checkReminders = () => {
      const now = new Date();
      const due = localPatients.filter(p => {
        if (!p.reminderDate) return false;
        const rawDate = String(p.reminderDate);
        const localDateStr = rawDate.substring(0, 16);
        const rDate = new Date(localDateStr);
        return rDate <= now; 
      });
      setDueReminders(due);
    };

    checkReminders(); 
    const interval = setInterval(checkReminders, 60000); 
    return () => clearInterval(interval);
  }, [localPatients]);

  const safeParseFloat = (val: any) => {
    if (typeof val === 'number') return val;
    if (!val) return 0;
    const clean = String(val).replace('R$', '').replace(/\./g, '').replace(',', '.').trim();
    return parseFloat(clean) || 0;
  };

  const getPatientsByStatus = (columnId: string) => {
    return localPatients.filter(p => {
      const statusBanco = (p.status || 'lead').toLowerCase();
      if (columnId === 'lead') return ['lead', 'novos leads', 'new', 'novo'].includes(statusBanco);
      if (columnId === 'negotiation') return ['negotiation', 'em conversa', 'negociacao'].includes(statusBanco);
      if (columnId === 'waiting') return ['waiting', 'aguardando', 'humano', 'human', 'atencao'].includes(statusBanco);
      if (columnId === 'discarded') return ['discarded', 'descartado', 'lixo', 'arquivado', 'lost', 'perda', 'leads frios'].includes(statusBanco);
      if (columnId === 'scheduled') return ['scheduled', 'agendado', 'agenda'].includes(statusBanco);
      if (columnId === 'confirmed') return ['confirmed', 'confirmado', 'pago', 'paid', 'active'].includes(statusBanco);
      return statusBanco === columnId;
    });
  };

  const openEditModal = (patient: Patient) => {
    setNewPatientData({ name: patient.name || '', phone: patient.phone || '', email: patient.email || '' });
    setDealValue(patient.price ? String(patient.price) : '');
    setEditingPatientId(String(patient.id));
    setShowAddModal(true);
  };

  const openAddModal = () => {
    setNewPatientData({ name: '', phone: '', email: '' });
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
        name: newPatientData.name, phone: newPatientData.phone, email: newPatientData.email, price: safeParseFloat(dealValue)
      };

      if (editingPatientId) {
        const { error } = await supabase.from('patients').update(payload).eq('id', editingPatientId);
        if (error) throw error;
      } else {
        // Evita criar pacientes duplicados a partir do telefone do lead.
        const incomingPhone = phoneMatchKey(payload.phone);
        if (incomingPhone) {
          const existing = localPatients.find(p => phoneMatchKey(p.phone) === incomingPhone);
          if (existing) {
            alert(`Já existe um paciente com o telefone informado (${payload.phone}). Abra/atualize o paciente existente.`);
            onSelectPatient?.(String(existing.id));
            setShowAddModal(false);
            return;
          }
        }

        const { error } = await supabase.from('patients').insert([{ ...payload, status: 'lead' }]);
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
    setLocalPatients(prev => prev.map(p => String(p.id) === patientId ? { ...p, observation: newObservation } : p));
    try {
      await supabase.from('patients').update({ observation: newObservation }).eq('id', patientId);
    } catch (error) {
      console.error("Erro ao salvar anotação", error);
    }
  };

  const handleSaveReminder = async () => {
    if (!selectedForReminder || !reminderDate) return;
    setIsSubmitting(true);
    try {
      await onSaveReminder(String(selectedForReminder.id), reminderDate, reminderNote);
      setLocalPatients(prev => prev.map(p => String(p.id) === String(selectedForReminder.id) ? { ...p, reminderDate, reminderNote } : p));
      setShowReminderModal(false);
      setReminderDate('');
      setReminderNote('');
    } catch (error) {
      alert("Erro ao salvar lembrete.");
    } finally {
      setIsSubmitting(false);
    }
  };

  const clearReminder = async (patientId: string) => {
    setDueReminders(prev => prev.filter(p => String(p.id) !== patientId));
    setLocalPatients(prev => prev.map(p => String(p.id) === patientId ? { ...p, reminderDate: undefined, reminderNote: undefined } : p));
    setShowReminderModal(false);
    try {
      await supabase.from('patients').update({ reminder_date: null, reminder_note: null }).eq('id', patientId);
      onRefresh(); 
    } catch (e) {
      console.error("Erro ao limpar no banco", e);
    }
  };

  const updateStatusInDB = async (id: string, status: string, price?: number) => {
    try {
      const updates: any = { status };
      if (price !== undefined) updates.price = price;
      setLocalPatients(prev => prev.map(p => String(p.id) === id ? { ...p, ...updates } : p));
      const { error } = await supabase.from('patients').update(updates).eq('id', id);
      if (error) throw error;
      onRefresh();
    } catch (error) {
      alert('Erro ao sincronizar com o banco de dados.');
      onRefresh(); 
    }
  };

  const handleConfirmAtendimento = async () => {
    if (!confirmingPatient) return;
    const price = safeParseFloat(confirmValue);
    await updateStatusInDB(String(confirmingPatient.id), 'confirmed', price || confirmingPatient.price || undefined);
    setConfirmSuccess(confirmingPatient.name);
    setShowConfirmModal(false);
    setConfirmingPatient(null);
    setConfirmValue('');
    setTimeout(() => setConfirmSuccess(null), 3000);
  };

  const confirmPayment = () => {
    if (!pendingDrag) return;
    updateStatusInDB(pendingDrag.draggableId, 'confirmed', safeParseFloat(dealValue));
    setShowPaymentModal(false);
    setPendingDrag(null);
  };

  const handleRefundDecision = (shouldRefund: boolean) => {
    if (!pendingDrag) return;
    updateStatusInDB(pendingDrag.draggableId, pendingDrag.destination.droppableId, shouldRefund ? 0 : refundData?.price);
    setShowRefundModal(false);
    setPendingDrag(null);
  };

  // Liga o motor quando começa a arrastar
  const onDragStart = () => {
    setIsDragging(true);
  };

  // Desliga o motor quando solta o card
  const onDragEnd = async (result: DropResult) => {
    setIsDragging(false); 

    const { destination, source, draggableId } = result;
    if (!destination) return;
    if (destination.droppableId === source.droppableId && destination.index === source.index) return;

    const newStatus = destination.droppableId;
    const oldStatus = source.droppableId;
    const currentPatient = localPatients.find(p => String(p.id) === draggableId);
    const currentPrice = safeParseFloat(currentPatient?.price);

    if (newStatus === 'confirmed' && oldStatus !== 'confirmed') {
      setPendingDrag({ draggableId, source, destination });
      setDealValue(''); 
      setShowPaymentModal(true);
      return; 
    }

    if (oldStatus === 'confirmed' && newStatus !== 'confirmed' && currentPrice > 0) {
      setPendingDrag({ draggableId, source, destination });
      setRefundData({ name: currentPatient?.name || 'Paciente', price: currentPrice });
      setShowRefundModal(true);
      return;
    }

    updateStatusInDB(draggableId, newStatus);
  };

  return (
    <div className="h-full flex flex-col space-y-6 bg-white rounded-2xl p-6">
      
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h2 className="text-xl font-bold text-slate-900 tracking-tight">Pipeline de Vendas</h2>
          <p className="text-slate-500 text-xs mt-1">Gerencie o fluxo de atendimento da clínica de ponta a ponta.</p>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={openAddModal} className="flex items-center gap-2 px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white text-sm font-semibold rounded-lg shadow-sm transition-colors">
            <UserPlus size={16} /> <span>Novo Lead</span>
          </button>
        </div>
      </div>

      <div className="flex-1 overflow-hidden flex flex-col">
        {/* Adicionei o onDragStart aqui para avisar o nosso Motor */}
        <DragDropContext onDragStart={onDragStart} onDragEnd={onDragEnd}>
          
          {/* AQUI ESTÁ A MÁGICA: Conectamos a nossa referência (ref={scrollContainerRef}) na esteira principal */}
          <div 
            ref={scrollContainerRef}
            className="flex gap-4 overflow-x-auto pb-4 custom-scrollbar h-full items-start"
          >
            {Object.entries(COLUMNS).map(([columnId, config]) => {
               const columnPatients = getPatientsByStatus(columnId);
               const totalValue = columnPatients.reduce((acc, curr) => acc + safeParseFloat(curr.price), 0);

               return (
                <div key={columnId} className={`w-[280px] flex flex-col max-h-full rounded-xl border ${config.border} bg-slate-50/50 shrink-0`}>
                  
                  <div className={`p-3 border-b ${config.border} flex justify-between items-center ${config.color} rounded-t-xl`}>
                    <div>
                      <h3 className={`font-bold text-xs uppercase tracking-wider ${config.text}`}>{config.title}</h3>
                      {totalValue > 0 && <p className={`text-[10px] font-semibold mt-0.5 opacity-80 ${config.text}`}>R$ {totalValue.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</p>}
                    </div>
                    <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold bg-white/60 ${config.text}`}>
                      {columnPatients.length}
                    </span>
                  </div>

                  <Droppable droppableId={columnId}>
                    {(provided, snapshot) => (
                      <div 
                        {...provided.droppableProps} 
                        ref={provided.innerRef} 
                        className={`flex-1 p-3 overflow-y-auto min-h-[150px] ${snapshot.isDraggingOver ? 'bg-indigo-50/30' : ''}`}
                      >
                        {columnPatients.map((patient, index) => (
                          <Draggable key={patient.id} draggableId={String(patient.id)} index={index}>
                            {(provided, snapshot) => (
                              
                              <div 
                                ref={provided.innerRef} 
                                {...provided.draggableProps} 
                                {...provided.dragHandleProps} 
                                style={{
                                  userSelect: 'none',
                                  marginBottom: '12px',
                                  ...provided.draggableProps.style,
                                }}
                                className={`bg-white p-4 rounded-lg border flex flex-col ${snapshot.isDragging ? 'border-indigo-500 shadow-xl' : 'border-slate-200 shadow-sm hover:border-indigo-300'}`}
                              >
                                  
                                <div className="flex justify-between items-start mb-2">
                                  <h4 
                                    onClick={() => onSelectPatient && onSelectPatient(String(patient.id))}
                                    className="font-bold text-sm text-slate-800 tracking-tight truncate pr-2 cursor-pointer hover:text-indigo-600 hover:underline transition-all"
                                    title="Abrir Prontuário Completo"
                                  >
                                    {patient.name || 'Sem nome'}
                                  </h4>
                                  {patient.reminderDate && <BellRing size={14} className="text-amber-500 shrink-0" />}
                                </div>
                                
                                <div className="flex items-center text-xs text-slate-500 font-medium mb-3">
                                  <Phone size={12} className="mr-1.5 text-slate-400" /> {patient.phone || '--'}
                                </div>
                                
                                {safeParseFloat(patient.price) > 0 && (
                                  <div className="mb-3 px-2 py-1 bg-emerald-50 text-emerald-700 rounded text-[11px] font-bold inline-flex items-center gap-1 border border-emerald-100">
                                    <DollarSign size={12} />
                                    {safeParseFloat(patient.price).toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
                                  </div>
                                )}

                                <div className="mb-3 bg-slate-50/80 border border-slate-100 rounded-md p-2 group/note relative">
                                  <AlignLeft size={10} className="absolute top-2.5 left-2 text-slate-400" />
                                  <textarea
                                    className="w-full text-[11px] text-slate-600 bg-transparent outline-none resize-none pl-4 placeholder-slate-400"
                                    placeholder="Anotação rápida..."
                                    rows={2}
                                    defaultValue={patient.observation || ''}
                                    onBlur={(e) => handleSaveObservation(String(patient.id), e.target.value)}
                                  />
                                </div>

                                <div className="flex items-center gap-1.5 pt-2 border-t border-slate-100 mt-auto">
                                  <button onClick={(e) => e.stopPropagation()} className="p-1.5 text-slate-400 hover:text-green-600 hover:bg-green-50 rounded-md transition-colors" title="WhatsApp">
                                    <MessageCircle size={14} />
                                  </button>
                                  
                                  <button onClick={(e) => { e.stopPropagation(); openEditModal(patient); }} className="p-1.5 text-slate-400 hover:text-indigo-600 hover:bg-indigo-50 rounded-md transition-colors" title="Editar Informações">
                                    <Edit2 size={14} />
                                  </button>
                                  
                                  <button 
                                    onClick={(e) => { 
                                      e.stopPropagation(); 
                                      setSelectedForReminder(patient); 
                                      setReminderDate(patient.reminderDate ? String(patient.reminderDate).substring(0, 16) : '');
                                      setReminderNote(patient.reminderNote || '');
                                      setShowReminderModal(true); 
                                    }}
                                    className={`p-1.5 rounded-md transition-colors ml-auto ${patient.reminderDate ? 'text-amber-600 bg-amber-50' : 'text-slate-400 hover:text-amber-600 hover:bg-amber-50'}`}
                                    title="Lembrete"
                                  >
                                    <Bell size={14} />
                                  </button>
                                </div>

                                {columnId === 'scheduled' && (
                                  <button
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      setConfirmingPatient(patient);
                                      setConfirmValue(String(patient.price || ''));
                                      setShowConfirmModal(true);
                                    }}
                                    className="mt-2 w-full flex items-center justify-center gap-1.5 bg-emerald-500 hover:bg-emerald-600 text-white text-[11px] font-bold py-1.5 rounded-md transition-colors"
                                    title="Confirmar atendimento realizado"
                                  >
                                    <Stethoscope size={12} />
                                    Confirmar Atendimento
                                  </button>
                                )}

                              </div>
                            )}
                          </Draggable>
                        ))}
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
      
      {/* 💸 MODAL DE PAGAMENTO */}
      {showPaymentModal && (
        <div className="fixed inset-0 z-100 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6 animate-in zoom-in-95 duration-200">
            <h3 className="text-lg font-bold text-emerald-600 mb-2 flex items-center gap-2">
              <DollarSign size={20}/> Confirmar Fechamento
            </h3>
            <p className="text-sm text-slate-500 font-medium mb-6">Qual foi o valor acordado/pago por este paciente?</p>

            <div className="space-y-4">
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Valor (R$)</label>
                <input 
                  type="text" 
                  value={dealValue}
                  onChange={(e) => setDealValue(e.target.value)}
                  placeholder="Ex: 1500.00"
                  className="w-full px-3 py-3 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none font-bold text-slate-800"
                />
              </div>
            </div>

            <div className="flex gap-3 mt-6">
              <button 
                onClick={() => { setShowPaymentModal(false); setPendingDrag(null); }} 
                className="flex-1 py-2 text-sm font-bold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors"
              >
                Cancelar
              </button>
              <button 
                onClick={confirmPayment} 
                className="flex-1 py-2 text-sm font-bold text-white bg-emerald-500 hover:bg-emerald-600 rounded-lg transition-colors"
              >
                Confirmar
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ⚠️ MODAL DE REEMBOLSO/ALTERAÇÃO */}
      {showRefundModal && refundData && (
        <div className="fixed inset-0 z-100 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6 animate-in zoom-in-95 duration-200">
            <h3 className="text-lg font-bold text-rose-600 mb-2 flex items-center gap-2">
              <AlertClock size={20}/> Atenção ao Valor!
            </h3>
            <p className="text-sm text-slate-600 font-medium mb-4">
              Você está tirando o paciente <strong>{refundData.name}</strong> da coluna de confirmados. Ele tinha um valor pago de <span className="font-bold text-emerald-600">R$ {refundData.price}</span>.
            </p>
            <p className="text-sm text-slate-500 font-medium mb-6">O que deseja fazer com este valor?</p>

            <div className="flex flex-col gap-3">
              <button 
                onClick={() => handleRefundDecision(false)} 
                className="w-full py-2.5 text-sm font-bold text-indigo-700 bg-indigo-50 hover:bg-indigo-100 border border-indigo-200 rounded-lg transition-colors"
              >
                Manter o valor no sistema
              </button>
              <button 
                onClick={() => handleRefundDecision(true)} 
                className="w-full py-2.5 text-sm font-bold text-rose-700 bg-rose-50 hover:bg-rose-100 border border-rose-200 rounded-lg transition-colors"
              >
                Zerar o valor (Estorno)
              </button>
              <button 
                onClick={() => { setShowRefundModal(false); setPendingDrag(null); }} 
                className="w-full py-2.5 text-sm font-bold text-slate-500 hover:bg-slate-50 rounded-lg transition-colors mt-2"
              >
                Cancelar Movimento
              </button>
            </div>
          </div>
        </div>
      )}

      {/* MODAL DE LEMBRETE */}
      {showReminderModal && selectedForReminder && (
        <div className="fixed inset-0 z-100 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6">
            <h3 className="text-lg font-bold text-slate-900 mb-1 flex items-center gap-2">
              <BellRing className="text-amber-500" size={20}/>
              Lembrete de Atenção
            </h3>
            <p className="text-xs text-slate-500 font-medium mb-4">Paciente: <span className="font-bold text-slate-700">{selectedForReminder.name}</span></p>

            <div className="space-y-4">
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Data e Hora</label>
                <input type="datetime-local" value={reminderDate} onChange={(e) => setReminderDate(e.target.value)} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-amber-500 outline-none" />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Motivo / Mensagem</label>
                <textarea value={reminderNote} onChange={(e) => setReminderNote(e.target.value)} placeholder="Ex: Retornar para reagendamento..." className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-amber-500 outline-none resize-none" rows={3} />
              </div>
            </div>

            <div className="flex gap-2 mt-6">
              <button onClick={() => setShowReminderModal(false)} className="flex-1 py-2 text-xs font-bold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors">Cancelar</button>
              {selectedForReminder.reminderDate && (
                <button onClick={() => clearReminder(String(selectedForReminder.id))} className="flex flex-col items-center justify-center px-3 py-2 text-rose-500 bg-rose-50 hover:bg-rose-100 rounded-lg transition-colors" title="Apagar Lembrete">
                  <Trash2 size={16} />
                </button>
              )}
              <button onClick={handleSaveReminder} disabled={isSubmitting || !reminderDate} className="flex-[1.5] py-2 text-xs font-bold text-white bg-amber-500 hover:bg-amber-600 rounded-lg transition-colors disabled:opacity-50">
                {isSubmitting ? 'Salvando...' : 'Salvar Alerta'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* MODAL NOVO LEAD */}
      {showAddModal && (
        <div className="fixed inset-0 z-100 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6">
            <h3 className="text-lg font-bold text-slate-900 mb-4 flex items-center gap-2">
              <UserPlus className="text-indigo-600" size={20}/>
              {editingPatientId ? 'Editar Informações' : 'Adicionar Novo Lead'}
            </h3>

            <form onSubmit={handleSavePatient} className="space-y-4">
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Nome do Paciente</label>
                <input type="text" required value={newPatientData.name} onChange={(e) => setNewPatientData({...newPatientData, name: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-600 outline-none" placeholder="Nome completo..." />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Telefone (WhatsApp)</label>
                <input type="text" value={newPatientData.phone} onChange={(e) => setNewPatientData({...newPatientData, phone: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-600 outline-none" placeholder="(00) 00000-0000" />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">E-mail</label>
                <input type="email" value={newPatientData.email} onChange={(e) => setNewPatientData({...newPatientData, email: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-600 outline-none" placeholder="paciente@email.com" />
              </div>
              <div>
                <label className="block text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-1">Valor do Fechamento (Opcional)</label>
                <input type="text" value={dealValue} onChange={(e) => setDealValue(e.target.value)} className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-600 outline-none" placeholder="Ex: 150.00" />
              </div>

              <div className="flex gap-3 mt-6 pt-2 border-t border-slate-100">
                <button type="button" onClick={() => setShowAddModal(false)} className="flex-1 py-2 text-sm font-bold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors">Cancelar</button>
                <button type="submit" disabled={isSubmitting} className="flex-1 py-2 text-sm font-bold text-white bg-indigo-600 hover:bg-indigo-700 rounded-lg transition-colors disabled:opacity-50">
                  {isSubmitting ? 'Salvando...' : 'Salvar Dados'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}


      {/* Toast de sucesso */}
      {confirmSuccess && (
        <div className="fixed bottom-6 right-6 z-[300] bg-emerald-500 text-white px-5 py-3 rounded-xl shadow-2xl flex items-center gap-2.5 animate-in slide-in-from-bottom-4 duration-300">
          <Check size={16} />
          <span className="text-sm font-bold">{confirmSuccess} — atendimento confirmado!</span>
        </div>
      )}

      {/* Modal Confirmar Atendimento */}
      {showConfirmModal && confirmingPatient && (
        <div className="fixed inset-0 z-[200] bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-sm shadow-2xl p-6 animate-in zoom-in-95 duration-200">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-10 h-10 rounded-xl bg-emerald-100 flex items-center justify-center">
                <Stethoscope size={20} className="text-emerald-600" />
              </div>
              <div>
                <h3 className="text-base font-bold text-slate-800">Confirmar Atendimento</h3>
                <p className="text-xs text-slate-500">{confirmingPatient.name}</p>
              </div>
            </div>
            <p className="text-sm text-slate-600 mb-4">
              O paciente será marcado como <span className="font-bold text-emerald-600">atendido</span> e sairá do funil do CRM. O histórico fica salvo no perfil.
            </p>
            <div className="mb-5">
              <label className="block text-[11px] font-bold uppercase text-slate-400 tracking-wider mb-1.5">Valor do Atendimento (R$)</label>
              <input
                type="number"
                value={confirmValue}
                onChange={e => setConfirmValue(e.target.value)}
                placeholder="0,00"
                className="w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 focus:bg-white focus:ring-2 focus:ring-emerald-400 outline-none text-sm"
              />
            </div>
            <div className="flex gap-2">
              <button
                onClick={() => { setShowConfirmModal(false); setConfirmingPatient(null); }}
                className="flex-1 py-2.5 rounded-xl border border-slate-200 text-sm font-semibold text-slate-600 hover:bg-slate-50 transition-colors"
              >
                Cancelar
              </button>
              <button
                onClick={handleConfirmAtendimento}
                className="flex-1 py-2.5 rounded-xl bg-emerald-500 hover:bg-emerald-600 text-white text-sm font-bold transition-colors flex items-center justify-center gap-2"
              >
                <Check size={15} /> Confirmar
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
};

function AlertClock(props: any) {
  return <AlarmClock {...props} />;
}

export default CRMi;