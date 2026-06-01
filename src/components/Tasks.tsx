import React, { useState, useEffect } from 'react';
import {
  Plus, Check, Clock, AlertCircle, ChevronDown,
  CheckCircle2, Circle, Loader2, Trash2, User, Calendar,
  Filter, X, Flag,
} from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { Professional } from '../types';

interface Task {
  id: string;
  title: string;
  description?: string;
  priority: 'baixa' | 'normal' | 'alta' | 'urgente';
  status: 'pending' | 'in_progress' | 'done' | 'cancelled';
  created_by?: string;
  created_by_name?: string;
  assigned_to_id?: string;
  assigned_to_name?: string;
  due_date?: string;
  due_time?: string;
  completed_at?: string;
  created_at: string;
}

interface Props {
  professionals: Professional[];
  session: any;
  onPendingCountChange?: (count: number) => void;
}

const PRIORITY_CONFIG = {
  baixa:   { label: 'Baixa',   color: 'bg-slate-100 text-slate-500',   dot: 'bg-slate-400'   },
  normal:  { label: 'Normal',  color: 'bg-blue-50 text-blue-600',      dot: 'bg-blue-500'    },
  alta:    { label: 'Alta',    color: 'bg-amber-50 text-amber-600',    dot: 'bg-amber-500'   },
  urgente: { label: 'Urgente', color: 'bg-rose-50 text-rose-600',      dot: 'bg-rose-500'    },
};

const STATUS_CONFIG = {
  pending:     { label: 'Pendente',     color: 'text-amber-600',   bg: 'bg-amber-50'   },
  in_progress: { label: 'Em andamento', color: 'text-blue-600',    bg: 'bg-blue-50'    },
  done:        { label: 'Concluída',    color: 'text-emerald-600', bg: 'bg-emerald-50' },
  cancelled:   { label: 'Cancelada',   color: 'text-slate-400',   bg: 'bg-slate-100'  },
};

const blankTask = () => ({
  title: '',
  description: '',
  priority: 'normal' as const,
  assigned_to_id: '',
  assigned_to_name: '',
  due_date: '',
  due_time: '',
});

const Tasks: React.FC<Props> = ({ professionals, session, onPendingCountChange }) => {
  const [tasks, setTasks]           = useState<Task[]>([]);
  const [loading, setLoading]       = useState(true);
  const [showModal, setShowModal]   = useState(false);
  const [saving, setSaving]         = useState(false);
  const [form, setForm]             = useState(blankTask());

  // Filtros
  const [filterStatus, setFilterStatus]     = useState<string>('all');
  const [filterAssigned, setFilterAssigned] = useState<string>('all');
  const [filterPriority, setFilterPriority] = useState<string>('all');

  const userName = session?.user?.user_metadata?.full_name
    || session?.user?.email?.split('@')[0]
    || 'Usuário';

  const fetchTasks = async () => {
    const { data } = await supabase
      .from('tasks')
      .select('*')
      .order('created_at', { ascending: false });
    const list = (data || []) as Task[];
    setTasks(list);
    setLoading(false);
    const pending = list.filter(t => t.status === 'pending' || t.status === 'in_progress').length;
    onPendingCountChange?.(pending);
  };

  useEffect(() => {
    fetchTasks();
    const ch = supabase
      .channel('tasks-realtime')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'tasks' }, fetchTasks)
      .subscribe();
    return () => { supabase.removeChannel(ch); };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleAssign = (profId: string) => {
    const prof = professionals.find(p => p.id === profId);
    setForm(f => ({ ...f, assigned_to_id: profId, assigned_to_name: prof?.name || '' }));
  };

  const saveTask = async () => {
    if (!form.title.trim()) return;
    setSaving(true);
    await supabase.from('tasks').insert({
      title:            form.title,
      description:      form.description || null,
      priority:         form.priority,
      status:           'pending',
      created_by:       session?.user?.id,
      created_by_name:  userName,
      assigned_to_id:   form.assigned_to_id || null,
      assigned_to_name: form.assigned_to_name || null,
      due_date:         form.due_date || null,
      due_time:         form.due_time || null,
    });
    setSaving(false);
    setShowModal(false);
    setForm(blankTask());
    fetchTasks(); // atualiza imediatamente sem depender do realtime
  };

  const updateStatus = async (task: Task, status: Task['status']) => {
    await supabase.from('tasks').update({
      status,
      completed_at: status === 'done' ? new Date().toISOString() : null,
    }).eq('id', task.id);
    fetchTasks();
  };

  const deleteTask = async (id: string) => {
    if (!confirm('Remover esta tarefa?')) return;
    await supabase.from('tasks').delete().eq('id', id);
    fetchTasks();
  };

  const filtered = tasks.filter(t => {
    if (filterStatus !== 'all' && t.status !== filterStatus) return false;
    if (filterAssigned !== 'all' && t.assigned_to_id !== filterAssigned) return false;
    if (filterPriority !== 'all' && t.priority !== filterPriority) return false;
    return true;
  });

  const isOverdue = (t: Task) =>
    t.due_date && t.status !== 'done' && new Date(t.due_date) < new Date();

  const fmtDate = (d?: string) => d
    ? new Date(d + 'T00:00').toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: '2-digit' })
    : '';

  return (
    <div className="h-full flex flex-col">

      {/* Header */}
      <div className="flex items-center justify-between mb-5">
        <div>
          <h2 className="text-xl font-semibold text-slate-800">Tarefas</h2>
          <p className="text-slate-400 text-sm mt-0.5">
            {tasks.filter(t => t.status === 'pending' || t.status === 'in_progress').length} pendente(s) · {tasks.filter(t => t.status === 'done').length} concluída(s)
          </p>
        </div>
        <button
          onClick={() => setShowModal(true)}
          className="flex items-center gap-1.5 px-4 py-2 bg-indigo-600 text-white text-sm font-medium rounded-xl hover:bg-indigo-700 transition-all shadow-sm"
        >
          <Plus className="w-4 h-4" /> Nova Tarefa
        </button>
      </div>

      {/* Filtros */}
      <div className="flex gap-2 flex-wrap mb-4">
        <div className="flex items-center gap-1.5 text-xs text-slate-400">
          <Filter className="w-3.5 h-3.5" /> Filtrar:
        </div>

        <select value={filterStatus} onChange={e => setFilterStatus(e.target.value)}
          className="text-xs border border-slate-200 rounded-lg px-2.5 py-1.5 bg-white text-slate-600 focus:outline-none focus:ring-1 focus:ring-indigo-400">
          <option value="all">Todos os status</option>
          {Object.entries(STATUS_CONFIG).map(([k, v]) => <option key={k} value={k}>{v.label}</option>)}
        </select>

        <select value={filterPriority} onChange={e => setFilterPriority(e.target.value)}
          className="text-xs border border-slate-200 rounded-lg px-2.5 py-1.5 bg-white text-slate-600 focus:outline-none focus:ring-1 focus:ring-indigo-400">
          <option value="all">Todas as prioridades</option>
          {Object.entries(PRIORITY_CONFIG).map(([k, v]) => <option key={k} value={k}>{v.label}</option>)}
        </select>

        <select value={filterAssigned} onChange={e => setFilterAssigned(e.target.value)}
          className="text-xs border border-slate-200 rounded-lg px-2.5 py-1.5 bg-white text-slate-600 focus:outline-none focus:ring-1 focus:ring-indigo-400">
          <option value="all">Todos os destinatários</option>
          {professionals.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
        </select>

        {(filterStatus !== 'all' || filterPriority !== 'all' || filterAssigned !== 'all') && (
          <button onClick={() => { setFilterStatus('all'); setFilterPriority('all'); setFilterAssigned('all'); }}
            className="flex items-center gap-1 text-xs text-rose-500 hover:text-rose-700 px-2 py-1 rounded-lg hover:bg-rose-50 transition-colors">
            <X className="w-3 h-3" /> Limpar
          </button>
        )}
      </div>

      {/* Lista */}
      <div className="flex-1 overflow-y-auto custom-scrollbar space-y-2">
        {loading ? (
          <div className="flex justify-center py-12">
            <Loader2 className="w-6 h-6 animate-spin text-slate-300" />
          </div>
        ) : filtered.length === 0 ? (
          <div className="text-center py-16">
            <CheckCircle2 className="w-10 h-10 mx-auto mb-3 text-slate-200" />
            <p className="text-slate-400 text-sm">Nenhuma tarefa encontrada</p>
          </div>
        ) : filtered.map(task => {
          const prio = PRIORITY_CONFIG[task.priority] || PRIORITY_CONFIG.normal;
          const stat = STATUS_CONFIG[task.status] || STATUS_CONFIG.pending;
          const overdue = isOverdue(task);

          return (
            <div key={task.id}
              className={`bg-white border rounded-2xl px-4 py-3.5 shadow-sm hover:shadow-md transition-shadow
                ${task.status === 'done' ? 'opacity-60' : ''}
                ${overdue ? 'border-rose-200' : 'border-slate-100'}`}>
              <div className="flex items-start gap-3">

                {/* Checkbox de status */}
                <button
                  onClick={() => updateStatus(task, task.status === 'done' ? 'pending' : 'done')}
                  className="mt-0.5 flex-shrink-0 transition-transform hover:scale-110"
                >
                  {task.status === 'done'
                    ? <CheckCircle2 className="w-5 h-5 text-emerald-500" />
                    : <Circle className="w-5 h-5 text-slate-300 hover:text-indigo-400" />
                  }
                </button>

                <div className="flex-1 min-w-0">
                  {/* Título */}
                  <p className={`text-sm font-medium text-slate-800 leading-snug ${task.status === 'done' ? 'line-through text-slate-400' : ''}`}>
                    {task.title}
                  </p>

                  {/* Descrição */}
                  {task.description && (
                    <p className="text-xs text-slate-400 mt-1 line-clamp-2">{task.description}</p>
                  )}

                  {/* Tags */}
                  <div className="flex items-center gap-2 flex-wrap mt-2">
                    {/* Prioridade */}
                    <span className={`flex items-center gap-1 text-[10px] font-medium px-2 py-0.5 rounded-full ${prio.color}`}>
                      <div className={`w-1.5 h-1.5 rounded-full ${prio.dot}`} />
                      {prio.label}
                    </span>

                    {/* Status */}
                    <span className={`text-[10px] font-medium px-2 py-0.5 rounded-full ${stat.bg} ${stat.color}`}>
                      {stat.label}
                    </span>

                    {/* Destinatário */}
                    {task.assigned_to_name && (
                      <span className="flex items-center gap-1 text-[10px] text-slate-500">
                        <User className="w-3 h-3" /> {task.assigned_to_name}
                      </span>
                    )}

                    {/* Prazo */}
                    {task.due_date && (
                      <span className={`flex items-center gap-1 text-[10px] font-medium ${overdue ? 'text-rose-500' : 'text-slate-400'}`}>
                        <Calendar className="w-3 h-3" />
                        {overdue && <AlertCircle className="w-3 h-3" />}
                        {fmtDate(task.due_date)}{task.due_time ? ` ${task.due_time.slice(0, 5)}` : ''}
                      </span>
                    )}

                    {/* Criado por */}
                    <span className="text-[10px] text-slate-300">por {task.created_by_name}</span>
                  </div>
                </div>

                {/* Ações */}
                <div className="flex items-center gap-1 shrink-0">
                  {task.status === 'pending' && (
                    <button onClick={() => updateStatus(task, 'in_progress')}
                      className="text-[10px] text-blue-500 hover:text-blue-700 px-2 py-1 rounded-lg hover:bg-blue-50 transition-colors font-medium">
                      Iniciar
                    </button>
                  )}
                  <button onClick={() => deleteTask(task.id)}
                    className="w-7 h-7 flex items-center justify-center rounded-lg text-slate-300 hover:text-rose-400 hover:bg-rose-50 transition-all">
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Modal Nova Tarefa */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg">

            <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
              <h3 className="text-base font-semibold text-slate-800">Nova Tarefa</h3>
              <button onClick={() => { setShowModal(false); setForm(blankTask()); }}
                className="w-8 h-8 flex items-center justify-center rounded-xl text-slate-400 hover:bg-slate-100 transition-all">
                <X className="w-4 h-4" />
              </button>
            </div>

            <div className="p-5 space-y-4">
              {/* Título */}
              <div>
                <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Título *</label>
                <input
                  className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                  placeholder="O que precisa ser feito?"
                  value={form.title}
                  onChange={e => setForm(f => ({ ...f, title: e.target.value }))}
                  autoFocus
                />
              </div>

              {/* Descrição */}
              <div>
                <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Descrição</label>
                <textarea
                  className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white resize-none h-20"
                  placeholder="Detalhes adicionais..."
                  value={form.description}
                  onChange={e => setForm(f => ({ ...f, description: e.target.value }))}
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                {/* Prioridade */}
                <div>
                  <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Prioridade</label>
                  <select
                    className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white appearance-none"
                    value={form.priority}
                    onChange={e => setForm(f => ({ ...f, priority: e.target.value as any }))}
                  >
                    <option value="baixa">Baixa</option>
                    <option value="normal">Normal</option>
                    <option value="alta">Alta</option>
                    <option value="urgente">Urgente</option>
                  </select>
                </div>

                {/* Destinatário */}
                <div>
                  <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Para</label>
                  <select
                    className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white appearance-none"
                    value={form.assigned_to_id}
                    onChange={e => handleAssign(e.target.value)}
                  >
                    <option value="">Selecione</option>
                    {professionals.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
                  </select>
                </div>

                {/* Data prazo */}
                <div>
                  <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Data Prazo</label>
                  <input type="date"
                    className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                    value={form.due_date}
                    onChange={e => setForm(f => ({ ...f, due_date: e.target.value }))}
                  />
                </div>

                {/* Hora prazo */}
                <div>
                  <label className="text-[10px] text-slate-400 uppercase tracking-wider mb-1 block">Hora Prazo</label>
                  <input type="time"
                    className="w-full px-3 py-2.5 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white"
                    value={form.due_time}
                    onChange={e => setForm(f => ({ ...f, due_time: e.target.value }))}
                  />
                </div>
              </div>
            </div>

            <div className="flex justify-end gap-2 px-5 py-4 border-t border-slate-100">
              <button onClick={() => { setShowModal(false); setForm(blankTask()); }}
                className="px-4 py-2 text-sm text-slate-500 border border-slate-200 rounded-xl hover:bg-slate-50 transition-all">
                Cancelar
              </button>
              <button onClick={saveTask} disabled={saving || !form.title.trim()}
                className="flex items-center gap-1.5 px-4 py-2 bg-indigo-600 text-white text-sm font-medium rounded-xl hover:bg-indigo-700 disabled:opacity-50 transition-all">
                {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Check className="w-4 h-4" />}
                Criar Tarefa
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Tasks;
