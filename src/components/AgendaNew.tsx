import React, { useState, useEffect } from 'react';
import { Clock, ChevronLeft, ChevronRight, Calendar as CalIcon, User, Plus, X, Loader2, AlertCircle, CheckCircle2 } from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { Appointment, Patient, Professional, ClinicService } from '../types';

interface AgendaNewProps {
  patients: Patient[];
  professionals: Professional[];
  services: ClinicService[];
  onSelectPatient: (id: string) => void;
}

type ViewType = 'diario' | 'semanal' | 'mensal';
type AppointmentStatus = 'scheduled' | 'confirmed' | 'completed' | 'cancelled' | 'no_show';

const AgendaNew: React.FC<AgendaNewProps> = ({
  patients,
  professionals,
  services,
  onSelectPatient,
}) => {
  const [view, setView] = useState<ViewType>('semanal');
  const [selectedProfessional, setSelectedProfessional] = useState<string>('all');
  const [currentDate, setCurrentDate] = useState(new Date());
  const [appointments, setAppointments] = useState<Appointment[]>([]);
  const [loading, setLoading] = useState(false);

  // Modal
  const [showModal, setShowModal] = useState(false);
  const [formData, setFormData] = useState({
    patient_id: '',
    professional_id: '',
    service_id: '',
    date_time: '',
    duration_minutes: 60,
    status: 'scheduled' as AppointmentStatus,
    notes: '',
  });
  const [editingId, setEditingId] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  // Fetch appointments
  useEffect(() => {
    fetchAppointments();
  }, []);

  const fetchAppointments = async () => {
    try {
      setLoading(true);
      const { data, error: err } = await supabase
        .from('appointments')
        .select('*')
        .gte('date_time', new Date(currentDate.getFullYear(), currentDate.getMonth() - 1, 1).toISOString())
        .lte('date_time', new Date(currentDate.getFullYear(), currentDate.getMonth() + 2, 1).toISOString());

      if (err) throw err;
      setAppointments(data || []);
    } catch (err) {
      console.error('Erro ao buscar agendamentos:', err);
      setError('Erro ao carregar agendamentos');
    } finally {
      setLoading(false);
    }
  };

  const handleSave = async () => {
    try {
      setSubmitting(true);
      setError(null);

      // Validações
      if (!formData.patient_id || !formData.professional_id || !formData.service_id || !formData.date_time) {
        setError('Preencha todos os campos obrigatórios');
        return;
      }

      // Validar conflito de horário
      const appointmentDateTime = new Date(formData.date_time);
      const hasConflict = appointments.some(apt => {
        if (editingId && apt.id === editingId) return false;
        if (apt.professional_id !== formData.professional_id) return false;

        const aptStart = new Date(apt.date_time);
        const aptEnd = new Date(aptStart.getTime() + apt.duration_minutes * 60000);

        const newStart = appointmentDateTime;
        const newEnd = new Date(newStart.getTime() + formData.duration_minutes * 60000);

        return newStart < aptEnd && newEnd > aptStart;
      });

      if (hasConflict) {
        setError('Conflito de horário com outro agendamento');
        return;
      }

      if (editingId) {
        // UPDATE
        const { error: err } = await supabase
          .from('appointments')
          .update(formData)
          .eq('id', editingId);
        if (err) throw err;
      } else {
        // INSERT
        const { error: err } = await supabase
          .from('appointments')
          .insert([formData]);
        if (err) throw err;
      }

      await fetchAppointments();
      setShowModal(false);
      setFormData({
        patient_id: '',
        professional_id: '',
        service_id: '',
        date_time: '',
        duration_minutes: 60,
        status: 'scheduled',
        notes: '',
      });
      setEditingId(null);
    } catch (err) {
      console.error('Erro ao salvar:', err);
      setError('Erro ao salvar agendamento');
    } finally {
      setSubmitting(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!window.confirm('Deseja deletar este agendamento?')) return;

    try {
      const { error: err } = await supabase
        .from('appointments')
        .delete()
        .eq('id', id);

      if (err) throw err;
      await fetchAppointments();
    } catch (err) {
      console.error('Erro ao deletar:', err);
      setError('Erro ao deletar agendamento');
    }
  };

  const openModal = (
    patientId?: string,
    professionalId?: string,
    dateTime?: string,
  ) => {
    setEditingId(null);
    setFormData({
      patient_id: patientId || '',
      professional_id: professionalId || '',
      service_id: '',
      date_time: dateTime || new Date().toISOString().slice(0, 16),
      duration_minutes: 60,
      status: 'scheduled',
      notes: '',
    });
    setShowModal(true);
  };

  // Filter appointments by professional
  const filteredAppointments = selectedProfessional === 'all'
    ? appointments
    : appointments.filter(a => a.professional_id === selectedProfessional);

  // Navigation
  const handlePrev = () => {
    const newDate = new Date(currentDate);
    if (view === 'diario') newDate.setDate(newDate.getDate() - 1);
    else if (view === 'semanal') newDate.setDate(newDate.getDate() - 7);
    else if (view === 'mensal') newDate.setMonth(newDate.getMonth() - 1);
    setCurrentDate(newDate);
  };

  const handleNext = () => {
    const newDate = new Date(currentDate);
    if (view === 'diario') newDate.setDate(newDate.getDate() + 1);
    else if (view === 'semanal') newDate.setDate(newDate.getDate() + 7);
    else if (view === 'mensal') newDate.setMonth(newDate.getMonth() + 1);
    setCurrentDate(newDate);
  };

  const getStatusColor = (status: AppointmentStatus) => {
    const colors: Record<AppointmentStatus, string> = {
      scheduled: 'bg-blue-100 text-blue-800',
      confirmed: 'bg-emerald-100 text-emerald-800',
      completed: 'bg-slate-100 text-slate-800',
      cancelled: 'bg-rose-100 text-rose-800',
      no_show: 'bg-amber-100 text-amber-800',
    };
    return colors[status] || 'bg-slate-100 text-slate-800';
  };

  const getStatusLabel = (status: AppointmentStatus) => {
    const labels: Record<AppointmentStatus, string> = {
      scheduled: 'Agendado',
      confirmed: 'Confirmado',
      completed: 'Realizado',
      cancelled: 'Cancelado',
      no_show: 'Não Compareceu',
    };
    return labels[status] || status;
  };

  // Render views
  const renderWeeklyView = () => {
    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(currentDate.getDate() - currentDate.getDay() + (currentDate.getDay() === 0 ? -6 : 1));

    const weekDays = Array.from({ length: 7 }, (_, i) => {
      const d = new Date(startOfWeek);
      d.setDate(startOfWeek.getDate() + i);
      return d;
    });

    const timeSlots = Array.from({ length: 13 }, (_, i) => `${(i + 8).toString().padStart(2, '0')}:00`);

    return (
      <div className="flex flex-col min-h-[600px] overflow-auto">
        <div className="flex border-b border-slate-200 bg-slate-50 sticky top-0 z-20">
          <div className="w-20 shrink-0"></div>
          {weekDays.map((day, idx) => {
            const isToday = day.toDateString() === new Date().toDateString();
            return (
              <div
                key={idx}
                className={`flex-1 min-w-[140px] p-3 text-center border-l border-slate-200 ${
                  isToday ? 'bg-indigo-600 text-white' : 'bg-slate-50'
                }`}
              >
                <p className="text-[10px] font-bold uppercase">
                  {['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'][day.getDay()]}
                </p>
                <p className="text-xl font-bold">{day.getDate()}</p>
              </div>
            );
          })}
        </div>

        <div className="flex-1">
          {timeSlots.map((slot) => (
            <div key={slot} className="flex border-b border-slate-50 min-h-[60px] group">
              <div className="w-20 shrink-0 flex items-center justify-center border-r border-slate-200 bg-slate-50 text-[9px] font-bold text-slate-400">
                {slot}
              </div>
              {weekDays.map((day, dIdx) => {
                const dayStr = day.toISOString().split('T')[0];
                const dayAppts = filteredAppointments.filter(apt => {
                  const aptDate = new Date(apt.date_time);
                  return (
                    aptDate.toISOString().split('T')[0] === dayStr &&
                    aptDate.getHours() === parseInt(slot.split(':')[0])
                  );
                });

                return (
                  <div
                    key={dIdx}
                    onClick={() => openModal('', selectedProfessional === 'all' ? '' : selectedProfessional, `${dayStr}T${slot}`)}
                    className="flex-1 min-w-[140px] border-l border-slate-100 p-1 relative hover:bg-indigo-50 transition-colors cursor-pointer group"
                  >
                    {dayAppts.map((apt) => {
                      const patient = patients.find(p => p.id === apt.patient_id);
                      const service = services.find(s => s.id === apt.service_id);
                      return (
                        <div
                          key={apt.id}
                          className={`w-full p-1.5 rounded-lg shadow-sm text-white mb-0.5 cursor-pointer hover:shadow-md transition-shadow ${
                            apt.status === 'scheduled'
                              ? 'bg-blue-500'
                              : apt.status === 'confirmed'
                                ? 'bg-emerald-500'
                                : 'bg-slate-400'
                          }`}
                          onClick={(e) => {
                            e.stopPropagation();
                            onSelectPatient(apt.patient_id);
                          }}
                        >
                          <p className="text-[8px] font-bold truncate">{patient?.name}</p>
                          <p className="text-[7px] opacity-90 truncate">{service?.name}</p>
                        </div>
                      );
                    })}
                    {dayAppts.length === 0 && (
                      <div className="h-full w-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                        <Plus className="w-4 h-4 text-indigo-300" />
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          ))}
        </div>
      </div>
    );
  };

  return (
    <div className="flex flex-col h-full space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center space-x-4">
          <h2 className="text-2xl font-bold text-slate-900">Agenda</h2>
          <div className="flex items-center space-x-2 bg-slate-100 rounded-lg p-1">
            {(['diario', 'semanal', 'mensal'] as const).map((v) => (
              <button
                key={v}
                onClick={() => setView(v)}
                className={`px-3 py-1.5 rounded-md text-xs font-bold uppercase transition-all ${
                  view === v
                    ? 'bg-white text-indigo-600 shadow-sm'
                    : 'text-slate-600 hover:text-slate-900'
                }`}
              >
                {v === 'diario' ? 'Diário' : v === 'semanal' ? 'Semanal' : 'Mensal'}
              </button>
            ))}
          </div>
        </div>

        <div className="flex items-center space-x-3">
          <select
            value={selectedProfessional}
            onChange={(e) => setSelectedProfessional(e.target.value)}
            className="px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
          >
            <option value="all">Todos os profissionais</option>
            {professionals.map((p) => (
              <option key={p.id} value={p.id}>
                {p.name}
              </option>
            ))}
          </select>

          <button
            onClick={() => openModal()}
            className="flex items-center space-x-2 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors"
          >
            <Plus size={18} />
            <span className="text-sm font-bold">Novo Agendamento</span>
          </button>
        </div>
      </div>

      {/* Navigation */}
      <div className="flex items-center justify-between">
        <button
          onClick={handlePrev}
          className="flex items-center space-x-1 px-3 py-2 hover:bg-slate-100 rounded-lg transition-colors"
        >
          <ChevronLeft size={20} />
          <span className="text-sm font-bold">Anterior</span>
        </button>

        <h3 className="text-lg font-bold text-slate-900">
          {currentDate.toLocaleDateString('pt-BR', {
            month: 'long',
            year: 'numeric',
          })}
        </h3>

        <button
          onClick={handleNext}
          className="flex items-center space-x-1 px-3 py-2 hover:bg-slate-100 rounded-lg transition-colors"
        >
          <span className="text-sm font-bold">Próximo</span>
          <ChevronRight size={20} />
        </button>
      </div>

      {/* Error message */}
      {error && (
        <div className="flex items-center space-x-3 p-4 bg-rose-50 border border-rose-200 rounded-lg">
          <AlertCircle size={20} className="text-rose-600" />
          <p className="text-sm text-rose-800">{error}</p>
          <button
            onClick={() => setError(null)}
            className="ml-auto text-rose-600 hover:text-rose-800"
          >
            <X size={18} />
          </button>
        </div>
      )}

      {/* Loading */}
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <Loader2 className="w-8 h-8 text-indigo-600 animate-spin" />
        </div>
      ) : (
        <div className="flex-1 bg-white rounded-xl border border-slate-200 overflow-auto">
          {renderWeeklyView()}
        </div>
      )}

      {/* Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-md w-full mx-4 p-6 space-y-4">
            <div className="flex items-center justify-between">
              <h3 className="text-xl font-bold">
                {editingId ? 'Editar' : 'Novo'} Agendamento
              </h3>
              <button
                onClick={() => setShowModal(false)}
                className="text-slate-400 hover:text-slate-600"
              >
                <X size={24} />
              </button>
            </div>

            <div className="space-y-3">
              <div>
                <label className="block text-sm font-bold text-slate-700 mb-1">
                  Paciente
                </label>
                <select
                  value={formData.patient_id}
                  onChange={(e) => setFormData({ ...formData, patient_id: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                >
                  <option value="">Selecione um paciente</option>
                  {patients.map((p) => (
                    <option key={p.id} value={p.id}>
                      {p.name}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-bold text-slate-700 mb-1">
                  Profissional
                </label>
                <select
                  value={formData.professional_id}
                  onChange={(e) => setFormData({ ...formData, professional_id: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                >
                  <option value="">Selecione um profissional</option>
                  {professionals.map((p) => (
                    <option key={p.id} value={p.id}>
                      {p.name}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-bold text-slate-700 mb-1">
                  Serviço
                </label>
                <select
                  value={formData.service_id}
                  onChange={(e) => setFormData({ ...formData, service_id: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                >
                  <option value="">Selecione um serviço</option>
                  {services.map((s) => (
                    <option key={s.id} value={s.id}>
                      {s.name} ({s.duration_minutes || s.duration}min)
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-bold text-slate-700 mb-1">
                  Data e Hora
                </label>
                <input
                  type="datetime-local"
                  value={formData.date_time}
                  onChange={(e) => setFormData({ ...formData, date_time: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-sm font-bold text-slate-700 mb-1">
                  Duração (minutos)
                </label>
                <input
                  type="number"
                  value={formData.duration_minutes}
                  onChange={(e) => setFormData({ ...formData, duration_minutes: parseInt(e.target.value) })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                />
              </div>

              <div>
                <label className="block text-sm font-bold text-slate-700 mb-1">
                  Status
                </label>
                <select
                  value={formData.status}
                  onChange={(e) => setFormData({ ...formData, status: e.target.value as AppointmentStatus })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                >
                  <option value="scheduled">Agendado</option>
                  <option value="confirmed">Confirmado</option>
                  <option value="completed">Realizado</option>
                  <option value="cancelled">Cancelado</option>
                  <option value="no_show">Não Compareceu</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-bold text-slate-700 mb-1">
                  Observações
                </label>
                <textarea
                  value={formData.notes}
                  onChange={(e) => setFormData({ ...formData, notes: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  rows={2}
                  placeholder="Adicione observações..."
                />
              </div>
            </div>

            <div className="flex items-center space-x-3 pt-4">
              <button
                onClick={handleSave}
                disabled={submitting}
                className="flex-1 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors disabled:opacity-50 font-bold"
              >
                {submitting ? 'Salvando...' : 'Salvar'}
              </button>
              <button
                onClick={() => setShowModal(false)}
                className="flex-1 px-4 py-2 bg-slate-200 text-slate-900 rounded-lg hover:bg-slate-300 transition-colors font-bold"
              >
                Cancelar
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AgendaNew;
