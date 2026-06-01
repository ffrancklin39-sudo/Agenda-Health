import React, { useState, useEffect } from 'react';
import {
  LayoutDashboard, Users, Calendar, Zap, Wallet, Briefcase,
  Settings as SettingsIcon, Kanban as KanbanIcon, ChevronLeft, ChevronRight,
  UserCheck, TrendingUp, ListChecks,
} from 'lucide-react';
import { UserRole, Patient } from '../types';

interface SidebarProps {
  activeTab: string;
  setActiveTab: (tab: any) => void;
  userRole: UserRole;
  patients: Patient[];
}

const Sidebar: React.FC<SidebarProps> = ({ activeTab, setActiveTab, userRole, patients }) => {
  const [collapsed, setCollapsed] = useState(false);
  const [clock, setClock] = useState('');

  useEffect(() => {
    const tick = () => {
      const now = new Date();
      setClock(now.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' }));
    };
    tick();
    const id = setInterval(tick, 10000);
    return () => clearInterval(id);
  }, []);

  const menuItems = [
    { id: 'dashboard',   label: 'Dashboard',    icon: LayoutDashboard, roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
    { id: 'agenda',      label: 'Agenda',        icon: Calendar,        roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
    { id: 'kanban',      label: 'CRMi',          icon: KanbanIcon,      roles: ['ADMIN','RECEPTIONIST'],          ready: true  },
    { id: 'patients',    label: 'Pacientes',     icon: Users,           roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
    { id: 'tasks',       label: 'Tarefas',       icon: ListChecks,      roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
    { id: 'automations', label: 'Automacoes',    icon: Zap,             roles: ['ADMIN','DOCTOR'],                ready: false },
    { id: 'services',    label: 'Servicos',      icon: Briefcase,       roles: ['ADMIN','RECEPTIONIST'],          ready: false },
    { id: 'finance',     label: 'Financeiro',    icon: Wallet,          roles: ['ADMIN'],                         ready: true  },
    { id: 'settings',    label: 'Configuracoes', icon: SettingsIcon,    roles: ['ADMIN'],                         ready: true  },
  ];

  const visibleItems = menuItems.filter(i => i.roles.includes(userRole) && i.ready);

  const dateStr = new Date().toLocaleDateString('pt-BR', {
    weekday: 'short', day: '2-digit', month: 'short',
  });

  // Pacientes com agendamento hoje
  const todayStr = new Date().toISOString().slice(0, 10);
  const todayCount = patients.filter(p => {
    const d = p.appointment_date || p.appointmentDate;
    return d && String(d).slice(0, 10) === todayStr;
  }).length;

  // Leads novos (status lead)
  const newLeads = patients.filter(p =>
    ['lead', 'novos leads', 'new'].includes((p.status || '').toLowerCase())
  ).length;

  return (
    <aside className={`bg-slate-100 flex flex-col h-full shadow-sm z-20 border-r border-slate-200 transition-all duration-300 ease-in-out ${collapsed ? 'w-[66px]' : 'w-64'}`}>

      <div className="flex items-center justify-between px-3 py-3 border-b border-slate-200 min-h-[64px]">
        {!collapsed && (
          <img
            src="https://iudghjdmfcxjcpspeify.supabase.co/storage/v1/object/public/Public%20SintesIA/SintesIA-Hz-sidebar.png"
            alt="SintesIA"
            className="h-9 w-auto object-contain ml-2"
          />
        )}
        <button
          onClick={() => setCollapsed(!collapsed)}
          title={collapsed ? 'Expandir menu' : 'Recolher menu'}
          className={`w-8 h-8 rounded-xl bg-white border border-slate-200 flex items-center justify-center text-slate-400 hover:text-indigo-600 hover:border-indigo-200 transition-all shadow-sm shrink-0 ${collapsed ? 'mx-auto' : 'ml-auto'}`}
        >
          {collapsed ? <ChevronRight className="w-4 h-4" /> : <ChevronLeft className="w-4 h-4" />}
        </button>
      </div>

      <nav className="flex-1 mt-3 px-2 space-y-1 overflow-y-auto custom-scrollbar">
        {visibleItems.map((item) => (
          <button
            key={item.id}
            onClick={() => setActiveTab(item.id)}
            title={collapsed ? item.label : undefined}
            className={`w-full flex items-center gap-3 px-3 py-3 rounded-xl transition-all duration-200 group ${collapsed ? 'justify-center' : ''} ${activeTab === item.id ? 'bg-white text-indigo-700 shadow-sm border border-slate-200' : 'text-slate-500 hover:bg-slate-200/60 hover:text-slate-900 border border-transparent'}`}
          >
            <item.icon className={`w-5 h-5 shrink-0 transition-colors ${activeTab === item.id ? 'text-indigo-600' : 'text-slate-400 group-hover:text-slate-600'}`} />
            {!collapsed && <span className="font-semibold text-sm tracking-wide">{item.label}</span>}
          </button>
        ))}
      </nav>

      {!collapsed ? (
        <div className="p-3 bg-white m-3 rounded-xl border border-slate-200 shadow-sm space-y-2">
          {/* Hora e data */}
          <div className="flex items-center justify-between">
            <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest capitalize">{dateStr}</p>
            <span className="text-xs font-bold text-slate-600 tabular-nums">{clock}</span>
          </div>

          {/* Agendamentos hoje */}
          <div
            className="flex items-center justify-between bg-indigo-50 rounded-lg px-2.5 py-1.5 cursor-pointer hover:bg-indigo-100 transition-colors"
            onClick={() => setActiveTab('agenda')}
            title="Ver agenda de hoje"
          >
            <div className="flex items-center gap-1.5">
              <UserCheck size={12} className="text-indigo-500" />
              <span className="text-[11px] font-semibold text-slate-600">Hoje</span>
            </div>
            <span className="text-sm font-black text-indigo-600">{todayCount}</span>
          </div>

          {/* Leads novos */}
          <div
            className="flex items-center justify-between bg-emerald-50 rounded-lg px-2.5 py-1.5 cursor-pointer hover:bg-emerald-100 transition-colors"
            onClick={() => setActiveTab('kanban')}
            title="Ver leads no CRM"
          >
            <div className="flex items-center gap-1.5">
              <TrendingUp size={12} className="text-emerald-500" />
              <span className="text-[11px] font-semibold text-slate-600">Leads</span>
            </div>
            <span className="text-sm font-black text-emerald-600">{newLeads}</span>
          </div>
        </div>
      ) : (
        <div className="flex flex-col items-center gap-2 pb-5">
          <div title="Sistema Online" className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" style={{boxShadow:'0 0 8px rgba(16,185,129,0.4)'}} />
        </div>
      )}
    </aside>
  );
};

export default Sidebar;
