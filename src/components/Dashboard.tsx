import React, { useMemo, useState, useEffect } from 'react';
import {
  Users, Calendar, TrendingUp, DollarSign, BarChart3,
  Target, BellRing, ChevronRight, CheckCircle2, UserPlus, Percent,
} from 'lucide-react';
import { Patient } from '../types';
import { supabase } from '../services/supabaseClient';

interface Props {
  patients: Patient[];
  dueReminders: Patient[];
}

const Dashboard: React.FC<Props> = ({ patients, dueReminders }) => {
  const now = new Date();
  const monthStart = new Date(now.getFullYear(), now.getMonth(), 1);
  const monthEnd   = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59);

  // Faturamento real — lê da tabela payments (status=paid, mês atual)
  const [realRevenue, setRealRevenue]   = useState<number | null>(null);
  const [realNetProfit, setRealNetProfit] = useState<number | null>(null);

  useEffect(() => {
    const from = monthStart.toISOString();
    const to   = monthEnd.toISOString();
    supabase
      .from('payments')
      .select('amount, net_profit')
      .eq('status', 'paid')
      .gte('payment_date', from)
      .lte('payment_date', to)
      .then(({ data, error }) => {
        if (error) { console.error('[Dashboard] payments error:', error); return; }
        const rows = data || [];
        setRealRevenue(rows.reduce((s, r) => s + (r.amount || 0), 0));
        setRealNetProfit(rows.reduce((s, r) => s + (r.net_profit || 0), 0));
      });
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const monthName = now.toLocaleDateString('pt-BR', { month: 'long', year: 'numeric' });

  // Pacientes criados ESTE MES
  const createdThisMonth = useMemo(() =>
    patients.filter(p => {
      if (!p.created_at) return false;
      const d = new Date(p.created_at);
      return d >= monthStart && d <= monthEnd;
    }), [patients]);

  // Leads reais = criados este mes com status de pipeline ativo
  const LEAD_STATUSES = ['lead', 'novos leads', 'new', 'novo', 'negotiation', 'em conversa', 'waiting', 'aguardando'];
  const leadsThisMonth = createdThisMonth.filter(p =>
    LEAD_STATUSES.includes((p.status || '').toLowerCase())
  );

  // Agendamentos este mes
  const scheduledThisMonth = useMemo(() =>
    patients.filter(p => {
      const d = p.appointment_date || p.appointmentDate;
      if (!d) return false;
      const dt = new Date(d);
      return dt >= monthStart && dt <= monthEnd;
    }), [patients]);

  // Convertidos este mes (agendados ou confirmados, criados este mes)
  const CONVERTED = ['scheduled', 'confirmed', 'confirmado', 'pago', 'active', 'agendado'];
  const convertedThisMonth = createdThisMonth.filter(p =>
    CONVERTED.includes((p.status || '').toLowerCase())
  );

  // Taxa de conversão do mes (convertidos / total criados este mes)
  const conversionRate = createdThisMonth.length > 0
    ? Math.round((convertedThisMonth.length / createdThisMonth.length) * 100)
    : 0;

  const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });

  const stats = [
    {
      label: 'Leads Captados',
      sublabel: 'este mês',
      value: leadsThisMonth.length,
      icon: UserPlus,
      color: 'text-indigo-600',
      bg: 'bg-indigo-50',
    },
    {
      label: 'Agendamentos',
      sublabel: 'este mês',
      value: scheduledThisMonth.length,
      icon: Calendar,
      color: 'text-sky-600',
      bg: 'bg-sky-50',
    },
    {
      label: 'Taxa de Conversão',
      sublabel: 'este mês',
      value: `${conversionRate}%`,
      icon: Percent,
      color: 'text-emerald-600',
      bg: 'bg-emerald-50',
    },
    {
      label: 'Faturamento',
      sublabel: realNetProfit !== null
        ? `líquido: ${fmt(realNetProfit)}`
        : 'carregando...',
      value: realRevenue !== null ? fmt(realRevenue) : '—',
      icon: DollarSign,
      color: 'text-amber-600',
      bg: 'bg-amber-50',
    },
  ];

  // Grafico: leads captados por mes (ultimos 6 meses)
  const chartData = useMemo(() => {
    const months = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
    const data = Array(6).fill(0).map((_, i) => {
      const d = new Date();
      d.setMonth(d.getMonth() - (5 - i));
      return { month: months[d.getMonth()], count: 0, year: d.getFullYear(), monthNum: d.getMonth() };
    });
    patients.forEach(p => {
      if (!p.created_at) return;
      // so conta leads reais (nao pacientes base)
      if (!LEAD_STATUSES.includes((p.status || '').toLowerCase())) return;
      const d = new Date(p.created_at);
      const target = data.find(m => m.monthNum === d.getMonth() && m.year === d.getFullYear());
      if (target) target.count++;
    });
    const maxCount = Math.max(...data.map(d => d.count), 1);
    return data.map(d => ({ ...d, height: `${Math.max((d.count / maxCount) * 100, 4)}%` }));
  }, [patients]);

  // Origem dos leads (apenas leads reais)
  const sourceStats = useMemo(() => {
    const sources = { meta: 0, google: 0, manual: 0 };
    patients
      .filter(p => LEAD_STATUSES.includes((p.status || '').toLowerCase()))
      .forEach(p => {
        const s = ((p as any).source || '').toLowerCase();
        if (s.includes('meta') || s.includes('instagram') || s.includes('facebook')) sources.meta++;
        else if (s.includes('google')) sources.google++;
        else sources.manual++;
      });
    return sources;
  }, [patients]);

  const totalLeads = patients.filter(p =>
    LEAD_STATUSES.includes((p.status || '').toLowerCase())
  ).length;

  return (
    <div className="space-y-8 animate-in fade-in duration-500">

      <div className="flex justify-between items-center">
        <div>
          <h2 className="text-2xl font-bold text-slate-900 tracking-tight">Relatório Comercial</h2>
          <p className="text-sm text-slate-500 font-medium mt-1 capitalize">{monthName} — métricas de captação e conversão</p>
        </div>
      </div>

      {/* Cards mensais */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {stats.map((stat, idx) => (
          <div key={idx} className="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all duration-300 flex items-center space-x-5 group">
            <div className={`p-4 rounded-xl ${stat.bg} ${stat.color} transition-transform duration-300 group-hover:scale-110`}>
              <stat.icon size={24} />
            </div>
            <div>
              <p className="text-[11px] font-bold text-slate-400 uppercase tracking-widest mb-0.5">{stat.label}</p>
              <p className="text-[10px] text-slate-400 mb-1">{stat.sublabel}</p>
              <p className="text-2xl font-extrabold text-slate-900 tracking-tight">{stat.value}</p>
            </div>
          </div>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Grafico de leads por mes */}
        <div className="lg:col-span-2 bg-white p-8 rounded-2xl border border-slate-100 shadow-sm flex flex-col">
          <div className="flex justify-between items-center mb-8">
            <div>
              <h3 className="text-lg font-bold text-slate-900 tracking-tight flex items-center gap-2">
                <BarChart3 className="text-indigo-600" size={20} /> Evolução de Leads Captados
              </h3>
              <p className="text-xs text-slate-500 font-medium mt-1">Novos leads por mês — últimos 6 meses</p>
            </div>
          </div>
          <div className="flex-1 flex items-end justify-between gap-2 h-48 mt-auto pt-8 border-b border-slate-100 pb-2">
            {chartData.map((data, i) => (
              <div key={i} className="flex flex-col items-center flex-1 group">
                <div className="opacity-0 group-hover:opacity-100 transition-opacity mb-2 text-[10px] font-bold bg-slate-800 text-white px-2 py-1 rounded">
                  {data.count}
                </div>
                <div className="w-full max-w-[40px] bg-slate-100 rounded-t-lg relative overflow-hidden flex items-end" style={{ height: '100%' }}>
                  <div className="w-full bg-indigo-600 rounded-t-lg transition-all duration-1000 ease-out" style={{ height: data.height }} />
                </div>
                <span className="text-xs font-bold text-slate-500 mt-3">{data.month}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Origem */}
        <div className="bg-white p-8 rounded-2xl border border-slate-100 shadow-sm flex flex-col">
          <h3 className="text-lg font-bold text-slate-900 tracking-tight flex items-center gap-2 mb-1">
            <Target className="text-indigo-600" size={20} /> Origem dos Leads
          </h3>
          <p className="text-xs text-slate-500 font-medium mb-8">De onde seus leads estão vindo</p>
          <div className="space-y-6 mt-auto">
            {[
              { label: 'Meta (Insta/FB)', value: sourceStats.meta, color: 'bg-blue-500' },
              { label: 'Google Ads/Orgânico', value: sourceStats.google, color: 'bg-emerald-500' },
              { label: 'Indicação / Manual', value: sourceStats.manual, color: 'bg-indigo-400' },
            ].map(src => (
              <div key={src.label}>
                <div className="flex justify-between text-sm font-bold text-slate-700 mb-2">
                  <span>{src.label}</span>
                  <span>{src.value}</span>
                </div>
                <div className="w-full h-2.5 bg-slate-100 rounded-full overflow-hidden">
                  <div
                    className={`h-full ${src.color} rounded-full`}
                    style={{ width: `${totalLeads ? (src.value / totalLeads) * 100 : 0}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Lembretes */}
        <div className="lg:col-span-2 bg-white p-8 rounded-2xl border border-slate-100 shadow-sm">
          <div className="flex justify-between items-center mb-6">
            <h3 className="text-lg font-bold text-slate-900 tracking-tight flex items-center gap-2">
              <BellRing className={`${dueReminders.length > 0 ? 'text-amber-500 animate-pulse' : 'text-slate-400'}`} size={20} />
              Lembretes Pendentes
            </h3>
            <span className="px-3 py-1 bg-amber-50 text-amber-600 text-[10px] font-black uppercase tracking-widest rounded-full">
              {dueReminders.length} pendentes
            </span>
          </div>
          <div className="space-y-3 max-h-[250px] overflow-y-auto custom-scrollbar pr-2">
            {dueReminders.length > 0 ? dueReminders.map(p => (
              <div key={p.id} className="flex items-center justify-between p-4 bg-amber-50/50 border border-amber-100 rounded-xl hover:bg-amber-50 transition-colors cursor-pointer">
                <div className="flex items-start gap-4">
                  <div className="mt-1 w-2 h-2 rounded-full bg-amber-500 shadow-[0_0_8px_rgba(245,158,11,0.6)]" />
                  <div>
                    <p className="font-bold text-sm text-slate-800">{p.name}</p>
                    <p className="text-xs text-slate-500 mt-0.5 line-clamp-1">{p.reminderNote || 'Sem mensagem especificada'}</p>
                  </div>
                </div>
                <div className="text-right shrink-0">
                  <p className="text-[10px] font-bold text-amber-600 uppercase tracking-widest flex items-center gap-1">
                    <Calendar size={12} />
                    {new Date(String(p.reminderDate).substring(0, 16)).toLocaleDateString('pt-BR')}
                  </p>
                  <button className="mt-2 text-xs font-bold text-indigo-600 hover:text-indigo-800 flex items-center gap-1">
                    Acessar CRM <ChevronRight size={12} />
                  </button>
                </div>
              </div>
            )) : (
              <div className="flex flex-col items-center justify-center py-10 text-center">
                <CheckCircle2 size={32} className="text-emerald-400 mb-3" />
                <p className="text-sm font-bold text-slate-700">Tudo limpo por aqui!</p>
                <p className="text-xs text-slate-500 mt-1">Nenhum alerta atrasado.</p>
              </div>
            )}
          </div>
        </div>

        {/* Resumo do mes */}
        <div className="bg-indigo-600 p-8 rounded-2xl shadow-lg text-white relative overflow-hidden flex flex-col justify-between">
          <div className="absolute top-0 right-0 w-48 h-48 bg-white/10 rounded-full -mr-24 -mt-24 blur-3xl" />
          <div className="relative z-10">
            <h3 className="text-lg font-bold mb-1 tracking-tight">Resumo do Mês</h3>
            <p className="text-indigo-200 text-xs capitalize">{monthName}</p>
          </div>
          <div className="relative z-10 space-y-3 mt-6">
            <div className="flex items-center justify-between bg-white/10 px-4 py-3 rounded-xl border border-white/10">
              <span className="text-xs font-semibold text-indigo-100">Leads captados</span>
              <span className="text-lg font-black">{leadsThisMonth.length}</span>
            </div>
            <div className="flex items-center justify-between bg-white/10 px-4 py-3 rounded-xl border border-white/10">
              <span className="text-xs font-semibold text-indigo-100">Agendamentos</span>
              <span className="text-lg font-black">{scheduledThisMonth.length}</span>
            </div>
            <div className="flex items-center justify-between bg-white/10 px-4 py-3 rounded-xl border border-white/10">
              <span className="text-xs font-semibold text-indigo-100">Taxa de conversão</span>
              <span className="text-lg font-black">{conversionRate}%</span>
            </div>
            <div className="flex items-center justify-between bg-white/10 px-4 py-3 rounded-xl border border-white/10">
              <span className="text-xs font-semibold text-indigo-100">Faturamento</span>
              <span className="text-sm font-black">
                {realRevenue !== null ? fmt(realRevenue) : '—'}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
