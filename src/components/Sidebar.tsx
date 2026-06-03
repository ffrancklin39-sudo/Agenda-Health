import React, { useState, useEffect } from 'react';
import {
  LayoutDashboard, Users, Calendar, Zap, Wallet, Briefcase,
  Settings as SettingsIcon, Kanban as KanbanIcon, ChevronLeft, ChevronRight,
  UserCheck, TrendingUp, ListChecks, BarChart3, FileText, ChevronDown,
} from 'lucide-react';
import { UserRole, Patient } from '../types';

interface SidebarProps {
  activeTab: string;
  setActiveTab: (tab: any) => void;
  userRole: UserRole;
  patients: Patient[];
}

interface MenuItem {
  id: string;
  label: string;
  icon: React.ElementType;
  roles: string[];
  ready: boolean;
}

interface MenuGroup {
  id: string;
  label: string;
  items: MenuItem[];
}

// ─── Grupos de menu ──────────────────────────────────────────

const GROUPS: MenuGroup[] = [
  {
    id: 'operacional',
    label: 'Operacional',
    items: [
      { id: 'dashboard',   label: 'Dashboard',   icon: LayoutDashboard, roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
      { id: 'agenda',      label: 'Agenda',       icon: Calendar,        roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
      { id: 'kanban',      label: 'CRMi',         icon: KanbanIcon,      roles: ['ADMIN','RECEPTIONIST'],          ready: true  },
      { id: 'patients',    label: 'Pacientes',    icon: Users,           roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
      { id: 'tasks',       label: 'Tarefas',      icon: ListChecks,      roles: ['ADMIN','DOCTOR','RECEPTIONIST'], ready: true  },
      { id: 'automations', label: 'Automacoes',   icon: Zap,             roles: ['ADMIN','DOCTOR'],                ready: false },
      { id: 'services',    label: 'Servicos',     icon: Briefcase,       roles: ['ADMIN','RECEPTIONIST'],          ready: false },
    ],
  },
  {
    id: 'administrativo',
    label: 'Administrativo',
    items: [
      { id: 'finance',  label: 'Financeiro',  icon: Wallet,    roles: ['ADMIN'], ready: true },
      { id: 'bi',       label: 'BI & Margem', icon: BarChart3, roles: ['ADMIN'], ready: true },
      { id: 'reports',  label: 'Relatórios',  icon: FileText,  roles: ['ADMIN'], ready: true },
    ],
  },
];

// Item de menu isolado (Configurações fica fora dos grupos)
const SOLO_ITEMS: MenuItem[] = [
  { id: 'settings', label: 'Configuracoes', icon: SettingsIcon, roles: ['ADMIN'], ready: true },
];

// ─── Sub-componente: botão de item ───────────────────────────

interface NavItemProps {
  item: MenuItem;
  active: boolean;
  collapsed: boolean;
  onClick: () => void;
  indent?: boolean;
}
const NavItem: React.FC<NavItemProps> = ({ item, active, collapsed, onClick, indent }) => (
  <button
    key={item.id}
    onClick={onClick}
    title={collapsed ? item.label : undefined}
    className={`
      w-full flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-150 group border
      ${collapsed ? 'justify-center' : indent ? 'pl-4' : ''}
      ${active
        ? 'bg-white text-indigo-700 shadow-sm border-slate-200'
        : 'text-slate-500 hover:bg-slate-200/60 hover:text-slate-900 border-transparent'}
    `}
  >
    <item.icon className={`w-4 h-4 shrink-0 transition-colors ${active ? 'text-indigo-600' : 'text-slate-400 group-hover:text-slate-600'}`} />
    {!collapsed && <span className="font-semibold text-sm tracking-wide">{item.label}</span>}
  </button>
);

// ─── Sub-componente: grupo colapsável ────────────────────────

interface NavGroupProps {
  group: MenuGroup;
  activeTab: string;
  sidebarCollapsed: boolean;
  userRole: string;
  onSelect: (id: string) => void;
  defaultOpen?: boolean;
}
const NavGroup: React.FC<NavGroupProps> = ({
  group, activeTab, sidebarCollapsed, userRole, onSelect, defaultOpen = true,
}) => {
  const visibleItems = group.items.filter(i => i.roles.includes(userRole) && i.ready);
  if (!visibleItems.length) return null;

  const hasActive = visibleItems.some(i => i.id === activeTab);
  const [open, setOpen] = useState(defaultOpen || hasActive);

  // Se o item ativo está neste grupo e o grupo fechou, reabre
  useEffect(() => {
    if (hasActive) setOpen(true);
  }, [hasActive]);

  // Sidebar colapsada: não mostra label/toggle, só os ícones
  if (sidebarCollapsed) {
    return (
      <div className="flex flex-col gap-0.5">
        {visibleItems.map(item => (
          <NavItem
            key={item.id}
            item={item}
            active={activeTab === item.id}
            collapsed
            onClick={() => onSelect(item.id)}
          />
        ))}
        <div className="my-1 border-t border-slate-200/80" />
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-0.5">
      {/* Header do grupo */}
      <button
        onClick={() => setOpen(v => !v)}
        className="flex items-center justify-between px-2 py-1.5 rounded-lg
                   text-slate-400 hover:text-slate-600 transition-colors group"
      >
        <span className="text-[10px] font-bold uppercase tracking-widest">
          {group.label}
        </span>
        <ChevronDown
          className={`w-3 h-3 transition-transform duration-200 ${open ? '' : '-rotate-90'}`}
        />
      </button>

      {/* Itens */}
      {open && (
        <div className="flex flex-col gap-0.5 pl-1">
          {visibleItems.map(item => (
            <NavItem
              key={item.id}
              item={item}
              active={activeTab === item.id}
              collapsed={false}
              onClick={() => onSelect(item.id)}
            />
          ))}
        </div>
      )}

      <div className="my-1.5 border-t border-slate-200/60" />
    </div>
  );
};

// ─── Sidebar principal ────────────────────────────────────────

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

  const dateStr = new Date().toLocaleDateString('pt-BR', {
    weekday: 'short', day: '2-digit', month: 'short',
  });

  const todayStr = new Date().toISOString().slice(0, 10);
  const todayCount = patients.filter(p => {
    const d = p.appointment_date || p.appointmentDate;
    return d && String(d).slice(0, 10) === todayStr;
  }).length;

  const newLeads = patients.filter(p =>
    ['lead', 'novos leads', 'new'].includes((p.status || '').toLowerCase())
  ).length;

  const visibleSolo = SOLO_ITEMS.filter(i => i.roles.includes(userRole) && i.ready);

  return (
    <aside className={`bg-slate-100 flex flex-col h-full shadow-sm z-20 border-r border-slate-200 transition-all duration-300 ease-in-out ${collapsed ? 'w-[66px]' : 'w-64'}`}>

      {/* Logo + toggle */}
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

      {/* Nav */}
      <nav className="flex-1 mt-2 px-2 overflow-y-auto custom-scrollbar">
        {GROUPS.map(group => (
          <NavGroup
            key={group.id}
            group={group}
            activeTab={activeTab}
            sidebarCollapsed={collapsed}
            userRole={userRole}
            onSelect={setActiveTab}
            defaultOpen={group.id === 'operacional'}
          />
        ))}

        {/* Itens solo (Configurações) */}
        {visibleSolo.map(item => (
          <NavItem
            key={item.id}
            item={item}
            active={activeTab === item.id}
            collapsed={collapsed}
            onClick={() => setActiveTab(item.id)}
          />
        ))}
      </nav>

      {/* Footer: data/hora + stats */}
      {!collapsed ? (
        <div className="p-3 bg-white m-3 rounded-xl border border-slate-200 shadow-sm space-y-2">
          <div className="flex items-center justify-between">
            <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest capitalize">{dateStr}</p>
            <span className="text-xs font-bold text-slate-600 tabular-nums">{clock}</span>
          </div>
          <div
            className="flex items-center justify-between bg-indigo-50 rounded-lg px-2.5 py-1.5 cursor-pointer hover:bg-indigo-100 transition-colors"
            onClick={() => setActiveTab('agenda')}
          >
            <div className="flex items-center gap-1.5">
              <UserCheck size={12} className="text-indigo-500" />
              <span className="text-[11px] font-semibold text-slate-600">Hoje</span>
            </div>
            <span className="text-sm font-black text-indigo-600">{todayCount}</span>
          </div>
          <div
            className="flex items-center justify-between bg-emerald-50 rounded-lg px-2.5 py-1.5 cursor-pointer hover:bg-emerald-100 transition-colors"
            onClick={() => setActiveTab('kanban')}
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
