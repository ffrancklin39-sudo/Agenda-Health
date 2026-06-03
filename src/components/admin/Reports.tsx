import React, { useState } from 'react';
import {
  FileText, TrendingUp, Users, Calendar, DollarSign,
  Download, ChevronRight, Clock, BarChart3, Layers,
  AlertTriangle,
} from 'lucide-react';

// Relatórios implementados
import DRE              from './reports/DRE';
import CommissionsReport from './reports/CommissionsReport';
import RevenueByService  from './reports/RevenueByService';
import Inadimplencia     from './reports/Inadimplencia';
import PatientRetention  from './reports/PatientRetention';
import LTV               from './reports/LTV';
import LeadOrigin        from './reports/LeadOrigin';
import AgendaOccupancy   from './reports/AgendaOccupancy';
import NoShow            from './reports/NoShow';
import MarginEvolution   from './reports/MarginEvolution';
import ChairEfficiency   from './reports/ChairEfficiency';

// ─── Tipos ───────────────────────────────────────────────────

type ReportId =
  | 'dre' | 'comissoes' | 'receita-servico' | 'inadimplencia'
  | 'retencao' | 'ltv' | 'origem-leads'
  | 'ocupacao' | 'no-show'
  | 'margem-periodo' | 'eficiencia-cadeira';

interface ReportCard {
  id: ReportId;
  title: string;
  description: string;
  icon: React.ElementType;
  color: string;
  iconBg: string;
  category: string;
}

// ─── Catálogo completo ────────────────────────────────────────

const REPORTS: ReportCard[] = [
  // Financeiro
  { id: 'dre',            title: 'DRE Simplificado',          description: 'Receitas, custos operacionais e lucro líquido por período.',              icon: DollarSign, color: 'text-emerald-400', iconBg: 'bg-emerald-500/10', category: 'Financeiro' },
  { id: 'comissoes',      title: 'Comissões por Profissional', description: 'Total de comissões devidas e pagas por profissional no período.',         icon: Users,      color: 'text-indigo-400',  iconBg: 'bg-indigo-500/10',  category: 'Financeiro' },
  { id: 'receita-servico',title: 'Receita por Serviço',        description: 'Ranking de faturamento bruto e líquido por tipo de procedimento.',        icon: BarChart3,   color: 'text-purple-400',  iconBg: 'bg-purple-500/10',  category: 'Financeiro' },
  { id: 'inadimplencia',  title: 'Inadimplência',              description: 'Pagamentos pendentes e pacientes com débitos em aberto.',                  icon: AlertTriangle, color: 'text-rose-400', iconBg: 'bg-rose-500/10',    category: 'Financeiro' },
  // Pacientes
  { id: 'retencao',       title: 'Retenção de Pacientes',      description: 'Taxa de retorno, churn e tempo médio entre consultas.',                   icon: Users,      color: 'text-amber-400',   iconBg: 'bg-amber-500/10',   category: 'Pacientes' },
  { id: 'ltv',            title: 'LTV por Paciente',           description: 'Valor total gerado por cada paciente ao longo do tempo.',                 icon: TrendingUp, color: 'text-emerald-400', iconBg: 'bg-emerald-500/10', category: 'Pacientes' },
  { id: 'origem-leads',   title: 'Origem dos Leads',           description: 'De onde vieram os pacientes: Meta, Google, indicação, etc.',              icon: Layers,     color: 'text-sky-400',     iconBg: 'bg-sky-500/10',     category: 'Pacientes' },
  // Agenda
  { id: 'ocupacao',       title: 'Ocupação da Agenda',         description: 'Taxa de ocupação por profissional, dia da semana e horário.',              icon: Calendar,   color: 'text-indigo-400',  iconBg: 'bg-indigo-500/10',  category: 'Agenda' },
  { id: 'no-show',        title: 'Taxa de No-Show',            description: 'Consultas canceladas e não comparecimentos por período.',                  icon: Clock,      color: 'text-orange-400',  iconBg: 'bg-orange-500/10',  category: 'Agenda' },
  // BI
  { id: 'margem-periodo', title: 'Margem Real por Período',    description: 'Evolução da margem de lucro real mês a mês, por procedimento.',           icon: BarChart3,  color: 'text-purple-400',  iconBg: 'bg-purple-500/10',  category: 'BI' },
  { id: 'eficiencia-cadeira', title: 'Eficiência de Cadeira',  description: 'Lucro por minuto de sala/cadeira ocupada, por profissional.',             icon: TrendingUp, color: 'text-emerald-400', iconBg: 'bg-emerald-500/10', category: 'BI' },
];

const CATEGORIES = ['Todos', 'Financeiro', 'Pacientes', 'Agenda', 'BI'];

// ─── Roteamento interno ───────────────────────────────────────

function renderReport(id: ReportId, onBack: () => void) {
  const props = { onBack };
  switch (id) {
    case 'dre':                return <DRE {...props} />;
    case 'comissoes':          return <CommissionsReport {...props} />;
    case 'receita-servico':    return <RevenueByService {...props} />;
    case 'inadimplencia':      return <Inadimplencia {...props} />;
    case 'retencao':           return <PatientRetention {...props} />;
    case 'ltv':                return <LTV {...props} />;
    case 'origem-leads':       return <LeadOrigin {...props} />;
    case 'ocupacao':           return <AgendaOccupancy {...props} />;
    case 'no-show':            return <NoShow {...props} />;
    case 'margem-periodo':     return <MarginEvolution {...props} />;
    case 'eficiencia-cadeira': return <ChairEfficiency {...props} />;
  }
}

// ─── Componente principal ─────────────────────────────────────

const Reports: React.FC = () => {
  const [activeCategory, setActiveCategory] = useState('Todos');
  const [openReport, setOpenReport]         = useState<ReportId | null>(null);

  if (openReport) return renderReport(openReport, () => setOpenReport(null));

  const filtered = activeCategory === 'Todos'
    ? REPORTS
    : REPORTS.filter(r => r.category === activeCategory);

  const grouped = CATEGORIES.slice(1).reduce<Record<string, ReportCard[]>>((acc, cat) => {
    const items = filtered.filter(r => r.category === cat);
    if (items.length) acc[cat] = items;
    return acc;
  }, {});

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="text-lg font-bold text-slate-800 flex items-center gap-2">
          <FileText className="w-5 h-5 text-indigo-500" />
          Relatórios
        </h1>
        <p className="text-sm text-slate-500 mt-0.5">
          {REPORTS.length} relatórios disponíveis — todos com exportação CSV.
        </p>
      </div>

      {/* Filtros */}
      <div className="flex items-center gap-1.5 flex-wrap">
        {CATEGORIES.map(cat => (
          <button key={cat} onClick={() => setActiveCategory(cat)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${activeCategory === cat ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200 hover:text-slate-800'}`}>
            {cat}
          </button>
        ))}
        <span className="ml-auto text-xs text-slate-400">{filtered.length} relatório{filtered.length !== 1 ? 's' : ''}</span>
      </div>

      {/* Cards */}
      {activeCategory === 'Todos'
        ? Object.entries(grouped).map(([cat, items]) => (
            <section key={cat} className="flex flex-col gap-3">
              <h2 className="text-xs font-bold text-slate-400 uppercase tracking-widest px-1">{cat}</h2>
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
                {items.map(r => <ReportCardItem key={r.id} report={r} onOpen={() => setOpenReport(r.id)} />)}
              </div>
            </section>
          ))
        : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
            {filtered.map(r => <ReportCardItem key={r.id} report={r} onOpen={() => setOpenReport(r.id)} />)}
          </div>
        )
      }
    </div>
  );
};

// ─── Card individual ──────────────────────────────────────────

const ReportCardItem: React.FC<{ report: ReportCard; onOpen: () => void }> = ({ report, onOpen }) => {
  const Icon = report.icon;
  return (
    <div onClick={onOpen}
      className="group bg-white border border-slate-200 hover:border-indigo-300 hover:shadow-md rounded-2xl p-4 flex flex-col gap-3 cursor-pointer transition-all duration-150">
      <div className="flex items-start justify-between">
        <div className={`p-2 rounded-xl ${report.iconBg}`}><Icon className={`w-4 h-4 ${report.color}`} /></div>
        <span className="text-[10px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 rounded-full px-2 py-0.5">Disponível</span>
      </div>
      <div className="flex flex-col gap-1 flex-1">
        <p className="text-sm font-semibold text-slate-800">{report.title}</p>
        <p className="text-xs text-slate-500 leading-relaxed">{report.description}</p>
      </div>
      <div className="flex items-center gap-1.5 text-xs font-semibold text-indigo-500 group-hover:text-indigo-600 mt-auto">
        <Download className="w-3.5 h-3.5" />
        Abrir relatório
        <ChevronRight className="w-3.5 h-3.5 ml-auto transition-transform group-hover:translate-x-0.5" />
      </div>
    </div>
  );
};

export default Reports;
