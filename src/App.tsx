import React, { useState, useEffect, useMemo } from 'react';
import { Search, Bell, Loader2, LogOut, AlertCircle, CheckCircle2, ListChecks } from 'lucide-react';
import { Patient, PatientStatus, UserRole, Professional, ClinicService } from './types';
import Sidebar from './components/Sidebar';
import Dashboard from './components/Dashboard';
import PatientList from './components/PatientList';
import Agenda from './components/Agenda';
import Automations from './components/Automations';
import Finance from './components/Finance';
import ServicesCatalog from './components/ServicesCatalog';
import Settings from './components/Settings';
import PatientProfile from './components/PatientProfile';
import CRMi from './components/CRMi';
import Login from './components/Login';
import PasswordReset from './components/PasswordReset';
import Tasks from './components/Tasks';
import ProfitDashboard from './components/bi/ProfitDashboard';
import Reports from './components/admin/Reports';
import { supabase } from './services/supabaseClient';

const App: React.FC = () => {
  const [session, setSession] = useState<any>(null);
  const [authLoading, setAuthLoading] = useState(true);
  const [isRecovery, setIsRecovery] = useState(false);
  const [activeTab, setActiveTab] = useState<'dashboard'|'kanban'|'patients'|'agenda'|'automations'|'finance'|'services'|'settings'|'tasks'|'bi'|'reports'>('dashboard');
  const [selectedPatientId, setSelectedPatientId] = useState<string | null>(null);
  const [agendaRefreshTrigger, setAgendaRefreshTrigger] = useState(0);
  const [pendingTasksCount, setPendingTasksCount] = useState(0);
  const [userRole, setUserRole] = useState<UserRole>('ADMIN');
  const [patients, setPatients] = useState<Patient[]>([]);
  const [professionals, setProfessionals] = useState<Professional[]>([]);
  const [services, setServices] = useState<ClinicService[]>([]);
  const [loading, setLoading] = useState(true);
  const [showNotifications, setShowNotifications] = useState(false);
  const [globalSearch, setGlobalSearch] = useState('');

  const selectedPatient = selectedPatientId === 'NEW'
    ? { id: 'NEW', name: '', email: '', phone: '', status: 'lead' } as any
    : patients.find(p => p.id === selectedPatientId);

  // Lembretes vencidos — calculado uma unica vez, passado como prop
  const dueReminders = useMemo(() => {
    const now = new Date();
    return patients
      .filter(p => {
        if (!p.reminderDate) return false;
        return new Date(String(p.reminderDate).substring(0, 16)) <= now;
      })
      .sort((a, b) => new Date(b.reminderDate!).getTime() - new Date(a.reminderDate!).getTime());
  }, [patients]);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
      setAuthLoading(false);
    });
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, s) => {
      if (event === 'PASSWORD_RECOVERY') {
        setIsRecovery(true);
        setSession(s);
      } else {
        setIsRecovery(false);
        setSession(s);
      }
    });
    return () => subscription.unsubscribe();
  }, []);

  // Busca role do usuário na tabela profiles
  useEffect(() => {
    if (!session) return;
    supabase
      .from('profiles')
      .select('role')
      .eq('id', session.user.id)
      .single()
      .then(({ data }) => {
        if (data?.role) setUserRole(data.role as UserRole);
      });
  }, [session]);

  const mapPatientRow = (p: any): Patient => {
    const genderMap: Record<string,string> = { '1':'Masculino','2':'Feminino','3':'Indefinido' };
    const rawGender = p.gender || p.sexo || '';
    const gender = genderMap[String(rawGender)] || rawGender;
    return {
      ...p,
      id: String(p.id),
      name: p.name || p.nome_paciente || p.nome || 'Sem Nome',
      email: p.email || '',
      phone: p.phone || p.fixo_1 || p.telefone || '',
      phone2: p.phone2 || p.celular_2 || '',
      cell2: p.cell2 || p.celular || '',
      cpf: p.cpf || '',
      record_number: p.record_number || String(p.id || ''),
      birth_date: p.birth_date || p.nascimento || p.date_of_birth || '',
      gender,
      insurance: p.insurance || p.convenio || '',
      status: p.status || PatientStatus.LEAD,
      appointment_date: p.appointment_date || p.appointmentDate || null,
      appointmentDate: p.appointmentDate || p.appointment_date || null,
      history: Array.isArray(p.history) ? p.history : [],
      attachments: Array.isArray(p.attachments) ? p.attachments : [],
      price: p.price || 0,
      reminderDate: p.reminder_date || '',
      reminderNote: p.reminder_note || '',
      reminderExecuted: p.reminder_executed || false,
      created_at: p.created_at ?? null,
      source: p.source || p.origem_id || '',
    };
  };

  const fetchPatients = async () => {
    try {
      setLoading(true);
      // Supabase limita 1000 por query — buscamos em lotes até carregar todos
      let all: any[] = [];
      let from = 0;
      const batch = 1000;
      while (true) {
        const { data, error } = await supabase
          .from('patients')
          .select('*')
          .order('name', { ascending: true })
          .range(from, from + batch - 1);
        if (error) throw error;
        all = all.concat(data || []);
        if (!data || data.length < batch) break;
        from += batch;
      }
      setPatients(all.map((p: any) => mapPatientRow(p)));
    } catch (e) {
      console.error('Erro ao buscar pacientes:', e);
    } finally {
      setLoading(false);
    }
  };

  const fetchProfessionals = async () => {
    try {
      const { data, error } = await supabase.from('professionals').select('*').order('name', { ascending: true });
      if (error) throw error;
      setProfessionals((data || []).map((p: any) => ({
        id: String(p.id), name: p.name, specialty: p.specialty || '',
        color: p.color || 'blue', email: p.email || '', phone: p.phone || '',
        phone2: p.phone2 || '', title: p.title || '', social_name: p.social_name || '',
        gender: p.gender || '', birth_date: p.birth_date || '', cpf: p.cpf || '',
        cns: p.cns || '', council: p.council || '', council_number: p.council_number || '',
        council_uf: p.council_uf || '', rqe: p.rqe || '', observation: p.observation || '',
        active: p.active ?? true, photo_url: p.photo_url || '',
        created_at: p.created_at,
      })));
    } catch (e) { console.error('Erro ao buscar profissionais:', e); }
  };

  const fetchServices = async () => {
    try {
      const { data, error } = await supabase.from('services').select('*').order('name', { ascending: true });
      if (error) throw error;
      setServices((data || []).map((s: any) => ({
        id: String(s.id), name: s.name, price: s.price || 0,
        duration: s.duration_minutes || 60, duration_minutes: s.duration_minutes || 60,
        category: s.category || 'Consultas', description: s.description || '', created_at: s.created_at,
      })));
    } catch (e) { console.error('Erro ao buscar servicos:', e); }
  };

  useEffect(() => {
    if (session) { fetchPatients(); fetchProfessionals(); fetchServices(); }
  }, [session]);

  // Realtime — unica fonte de verdade apos o load inicial
  useEffect(() => {
    if (!session) return;
    const sort = (arr: Patient[]) => [...arr].sort((a, b) => (a.name||'').localeCompare(b.name||'', 'pt-BR'));
    const channel = supabase.channel('patients-realtime').on(
      'postgres_changes',
      { event: '*', schema: 'public', table: 'patients' },
      (payload: any) => {
        const { eventType } = payload;
        if ((eventType === 'INSERT' || eventType === 'UPDATE') && payload.new) {
          const incoming = mapPatientRow(payload.new);
          setPatients(prev => {
            const idx = prev.findIndex(p => String(p.id) === String(incoming.id));
            return sort(idx >= 0 ? prev.map((p, i) => i === idx ? incoming : p) : [...prev, incoming]);
          });
        }
        if (eventType === 'DELETE' && payload.old?.id != null) {
          setPatients(prev => sort(prev.filter(p => String(p.id) !== String(payload.old.id))));
        }
      }
    ).subscribe();
    return () => { supabase.removeChannel(channel); };
  }, [session]);

  const handlePatientSelect = async (id: string) => {
    // Se paciente ja esta no array, abre direto
    if (id === 'NEW' || patients.find(p => p.id === id)) {
      setSelectedPatientId(id);
      return;
    }
    // Paciente novo ainda nao chegou via realtime — busca direto do banco
    const { data } = await supabase.from('patients').select('*').eq('id', id).single();
    if (data) {
      setPatients(prev => {
        if (prev.find(p => p.id === String(data.id))) return prev;
        return [...prev, mapPatientRow(data)].sort((a, b) => (a.name||'').localeCompare(b.name||'', 'pt-BR'));
      });
    }
    setSelectedPatientId(id);
  };

  // Sem fetchPatients() redundante — realtime cuida das atualizacoes
  const updatePatientStatus = async (id: string, status: PatientStatus) => {
    const { error } = await supabase.from('patients').update({ status }).eq('id', id);
    if (error) console.error(error);
  };
  const saveReminder = async (id: string, date: string, note: string) => {
    const { error } = await supabase.from('patients').update({ reminder_date: date, reminder_note: note, reminder_executed: false }).eq('id', id);
    if (error) console.error(error);
  };
  const updatePatient = async (id: string, updates: Partial<Patient>) => {
    const { error } = await supabase.from('patients').update(updates).eq('id', id);
    if (error) throw error;
  };

  if (authLoading) return (
    <div className="min-h-screen bg-slate-50 flex items-center justify-center">
      <div className="flex flex-col items-center space-y-4 bg-white/80 backdrop-blur-xl rounded-2xl shadow-md px-8 py-6">
        <Loader2 className="w-10 h-10 text-indigo-600 animate-spin" />
        <p className="text-slate-500 text-xs font-semibold uppercase tracking-[0.2em]">SintesIA</p>
      </div>
    </div>
  );

  if (!session) return <Login />;

  // Usuário clicou no link de reset de senha — mostra tela de redefinição
  if (isRecovery) return <PasswordReset onDone={() => setIsRecovery(false)} />;

  const nopad = activeTab === 'agenda' || activeTab === 'patients';

  return (
    <div className="flex h-screen bg-slate-50 font-sans text-slate-900 overflow-hidden">
      <Sidebar activeTab={activeTab} setActiveTab={setActiveTab} userRole={userRole} patients={patients} />

      <main className="flex-1 flex flex-col min-w-0 overflow-hidden">

        {/* Header */}
        <header className="h-16 bg-white/90 backdrop-blur-xl border-b border-slate-200 flex items-center justify-between px-6 shrink-0 z-10">
          <div className="flex-1 max-w-lg relative">
            <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400" size={16} />
            <input
              type="text"
              placeholder="Pesquisar paciente por nome, CPF ou telefone..."
              value={globalSearch}
              onChange={e => {
                setGlobalSearch(e.target.value);
                if (e.target.value && activeTab !== 'patients') setActiveTab('patients');
              }}
              onKeyDown={e => { if (e.key === 'Escape') setGlobalSearch(''); }}
              className="w-full pl-10 pr-4 py-2 bg-slate-100 rounded-lg text-sm focus:bg-white focus:ring-2 focus:ring-indigo-400/30 focus:outline-none transition-all placeholder:text-slate-400"
            />
          </div>

          <div className="flex items-center gap-4 ml-4">
            {/* Sininho */}
            {/* Badge de tarefas pendentes */}
            <button
              onClick={() => setActiveTab('tasks')}
              className="relative p-2 rounded-xl text-slate-400 hover:text-indigo-600 hover:bg-indigo-50 transition-all"
              title="Tarefas"
            >
              <ListChecks size={19} />
              {pendingTasksCount > 0 && (
                <span className="absolute -top-0.5 -right-0.5 min-w-[18px] h-[18px] bg-indigo-600 text-white text-[10px] font-bold rounded-full flex items-center justify-center px-1 shadow">
                  {pendingTasksCount > 99 ? '99+' : pendingTasksCount}
                </span>
              )}
            </button>

            <div className="relative">
              <button
                onClick={() => setShowNotifications(!showNotifications)}
                className={`relative p-2 rounded-xl transition-all ${showNotifications ? 'bg-indigo-50 text-indigo-600' : 'text-slate-400 hover:text-indigo-600 hover:bg-indigo-50'}`}
              >
                <Bell size={19} />
                {dueReminders.length > 0 && (
                  <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-rose-500 rounded-full border-2 border-white animate-pulse" />
                )}
              </button>
              {showNotifications && (
                <div className="absolute right-0 mt-2 w-80 bg-white rounded-2xl shadow-2xl border border-slate-100 z-50 overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200">
                  <div className="px-4 py-3 border-b border-slate-100 bg-slate-50 flex justify-between items-center">
                    <h3 className="text-sm font-bold text-slate-800">Notificacoes</h3>
                    <span className="px-2 py-0.5 bg-rose-100 text-rose-600 text-[10px] font-bold uppercase rounded-full">
                      {dueReminders.length} pendentes
                    </span>
                  </div>
                  <div className="max-h-72 overflow-y-auto custom-scrollbar">
                    {dueReminders.length > 0 ? dueReminders.map(r => (
                      <div
                        key={r.id}
                        onClick={() => { setActiveTab('kanban'); setShowNotifications(false); }}
                        className="p-4 border-b border-slate-50 hover:bg-slate-50 cursor-pointer transition-colors"
                      >
                        <p className="text-sm font-bold text-slate-800">{r.name}</p>
                        <p className="text-xs text-slate-500 line-clamp-1 mt-0.5">{r.reminderNote || 'Lembrete sem detalhes.'}</p>
                        <p className="text-[10px] font-bold text-amber-500 uppercase mt-1.5 flex items-center gap-1">
                          <AlertCircle size={10} /> Requer Atencao
                        </p>
                      </div>
                    )) : (
                      <div className="p-6 text-center">
                        <CheckCircle2 size={22} className="text-emerald-400 mx-auto mb-2" />
                        <p className="text-sm font-bold text-slate-600">Tudo em dia!</p>
                      </div>
                    )}
                  </div>
                  {dueReminders.length > 0 && (
                    <div
                      className="p-3 text-center text-xs font-bold text-indigo-600 bg-slate-50 hover:bg-slate-100 cursor-pointer transition-colors"
                      onClick={() => { setActiveTab('kanban'); setShowNotifications(false); }}
                    >
                      Ir para o CRM
                    </div>
                  )}
                </div>
              )}
            </div>

            <div className="w-px h-6 bg-slate-200" />

            <div className="flex items-center gap-3">
              <div className="text-right hidden sm:block">
                <p className="text-sm font-bold text-slate-800 leading-none">{session.user.email?.split('@')[0]}</p>
                <p className="text-[10px] font-semibold text-indigo-600 uppercase tracking-widest mt-0.5">{userRole}</p>
              </div>
              <button
                onClick={() => supabase.auth.signOut()}
                className="w-9 h-9 rounded-xl bg-slate-100 text-slate-400 flex items-center justify-center hover:bg-rose-50 hover:text-rose-500 transition-all"
                title="Sair"
              >
                <LogOut size={16} />
              </button>
            </div>
          </div>
        </header>

        {/* Conteudo */}
        <div
          className={`flex-1 min-h-0 ${nopad ? 'overflow-hidden' : 'overflow-y-auto px-6 py-6 custom-scrollbar'}`}
          onClick={() => showNotifications && setShowNotifications(false)}
        >
          <div className={nopad ? 'h-full' : 'max-w-7xl mx-auto'}>
            <div className={`bg-white rounded-2xl shadow-sm ${nopad ? 'h-full overflow-hidden' : 'px-6 py-6 lg:px-8 lg:py-8'}`}>
              {loading && patients.length === 0 ? (
                <div className="h-full flex flex-col items-center justify-center gap-4">
                  <Loader2 className="w-10 h-10 text-indigo-500 animate-spin" />
                  <p className="text-slate-400 text-sm font-medium">Sincronizando dados...</p>
                </div>
              ) : (
                <>
                  {activeTab === 'dashboard'   && <Dashboard patients={patients} dueReminders={dueReminders} />}
                  {activeTab === 'kanban'       && <CRMi onSelectPatient={handlePatientSelect} patients={patients} onRefresh={fetchPatients} onSaveReminder={saveReminder} onUpdatePatient={updatePatient} session={session} professionals={professionals} />}
                  {activeTab === 'patients'     && <PatientList patients={patients} updateStatus={updatePatientStatus} onSelectPatient={handlePatientSelect} onRefresh={fetchPatients} session={session} initialSearch={globalSearch} />}
                  {activeTab === 'agenda'       && <Agenda patients={patients} professionals={professionals} services={services} onSelectPatient={handlePatientSelect} onRefresh={fetchPatients} refreshTrigger={agendaRefreshTrigger} />}
                  {activeTab === 'automations'  && <Automations patients={patients} />}
                  {activeTab === 'finance'      && <Finance userRole={userRole} patients={patients} />}
                  {activeTab === 'services'     && <ServicesCatalog services={services} onRefresh={fetchServices} />}
                  {activeTab === 'settings'     && <Settings professionals={professionals} services={services} onRefreshProfessionals={fetchProfessionals} onRefreshServices={fetchServices} session={session} />}
                  {activeTab === 'tasks'        && <Tasks professionals={professionals} session={session} onPendingCountChange={setPendingTasksCount} />}
                  {activeTab === 'bi'           && <ProfitDashboard />}
                  {activeTab === 'reports'      && <Reports />}
                </>
              )}
            </div>
          </div>
        </div>
      </main>

      {selectedPatient && (
        <PatientProfile
          patient={selectedPatient}
          onClose={() => setSelectedPatientId(null)}
          onRefresh={fetchPatients}
          onDeleted={() => { setAgendaRefreshTrigger(t => t + 1); setSelectedPatientId(null); }}
        />
      )}
    </div>
  );
};

export default App;
