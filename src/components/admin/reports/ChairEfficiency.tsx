import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw, Clock, Award } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface PaymentRow {
  professional_id: string | null;
  professional_name: string | null;
  service_id: string | null;
  service_name: string | null;
  amount: number;
  real_profit: number | null;
  payment_date: string;
}

interface PricingRow { service_id: string; estimated_duration_minutes: number; }
interface ProfRow    { id: string; name: string; color: string; specialty: string; }

interface ProfEfficiency {
  profId: string;
  profName: string;
  specialty: string;
  color: string;
  sessions: number;
  totalMinutes: number;
  totalRevenue: number;
  totalProfit: number;
  profitPerMinute: number;
  revenuePerMinute: number;
  avgMargin: number;
  topService: string;
}

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number) => `${v.toFixed(1)}%`;
const COLORS: Record<string, string> = { blue:'bg-blue-500', purple:'bg-purple-500', emerald:'bg-emerald-500', rose:'bg-rose-500', amber:'bg-amber-500', indigo:'bg-indigo-500', sky:'bg-sky-500' };
type PeriodKey = 'mes' | 'trimestre' | 'ano';
const MONTHS = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];

function getPeriod(p: PeriodKey) {
  const now = new Date(); const y = now.getFullYear(), m = now.getMonth();
  if (p === 'mes')       return { start: new Date(y, m, 1),   end: new Date(y, m+1, 0, 23, 59) };
  if (p === 'trimestre') return { start: new Date(y, m-2, 1), end: new Date(y, m+1, 0, 23, 59) };
  return                        { start: new Date(y, 0, 1),   end: new Date(y, 11, 31, 23, 59) };
}
function periodLabel(p: PeriodKey) {
  const now = new Date();
  if (p === 'mes') return `${MONTHS[now.getMonth()]}/${now.getFullYear()}`;
  if (p === 'trimestre') return 'Último trimestre';
  return `Ano ${now.getFullYear()}`;
}

const DEFAULT_DURATION = 45; // minutos — fallback sem precificação

export default function ChairEfficiency({ onBack }: { onBack: () => void }) {
  const [payments, setPayments]       = useState<PaymentRow[]>([]);
  const [pricing, setPricing]         = useState<PricingRow[]>([]);
  const [professionals, setProfessionals] = useState<ProfRow[]>([]);
  const [loading, setLoading]         = useState(true);
  const [period, setPeriod]           = useState<PeriodKey>('mes');

  useEffect(() => {
    Promise.all([
      supabase.from('vw_payments_full').select('professional_id,professional_name,service_id,service_name,amount,real_profit,payment_date').eq('status', 'paid'),
      supabase.from('procedures_pricing').select('service_id,estimated_duration_minutes'),
      supabase.from('professionals').select('id,name,color,specialty'),
    ]).then(([payRes, prRes, profRes]) => {
      setPayments((payRes.data ?? []) as PaymentRow[]);
      setPricing((prRes.data ?? []) as PricingRow[]);
      setProfessionals((profRes.data ?? []) as ProfRow[]);
      setLoading(false);
    });
  }, []);

  const { start, end } = useMemo(() => getPeriod(period), [period]);

  const efficiencies = useMemo((): ProfEfficiency[] => {
    const inPeriod = (d: string) => { const dt = new Date(d); return dt >= start && dt <= end; };
    const periodPays = payments.filter(p => p.payment_date && inPeriod(p.payment_date));

    return professionals.map(prof => {
      const profPays = periodPays.filter(p => p.professional_id === prof.id);
      if (profPays.length === 0) return null;

      let totalMinutes = 0;
      const serviceCount = new Map<string, number>();

      profPays.forEach(p => {
        const pr = pricing.find(x => x.service_id === p.service_id);
        const duration = pr?.estimated_duration_minutes || DEFAULT_DURATION;
        totalMinutes += duration;
        if (p.service_name) serviceCount.set(p.service_name, (serviceCount.get(p.service_name) ?? 0) + 1);
      });

      const totalRevenue  = profPays.reduce((s, p) => s + p.amount, 0);
      const totalProfit   = profPays.reduce((s, p) => s + (p.real_profit ?? 0), 0);
      const profitPerMin  = totalMinutes > 0 ? totalProfit  / totalMinutes : 0;
      const revenuePerMin = totalMinutes > 0 ? totalRevenue / totalMinutes : 0;
      const avgMargin     = totalRevenue > 0 ? (totalProfit / totalRevenue) * 100 : 0;
      const topService    = Array.from(serviceCount.entries()).sort((a, b) => b[1] - a[1])[0]?.[0] ?? '—';

      return { profId: prof.id, profName: prof.name, specialty: prof.specialty, color: prof.color, sessions: profPays.length, totalMinutes, totalRevenue, totalProfit, profitPerMinute: profitPerMin, revenuePerMinute: revenuePerMin, avgMargin, topService };
    }).filter(Boolean).sort((a, b) => b!.profitPerMinute - a!.profitPerMinute) as ProfEfficiency[];
  }, [payments, pricing, professionals, start, end]);

  const maxPPM = useMemo(() => Math.max(...efficiencies.map(e => e.profitPerMinute), 0.01), [efficiencies]);

  const handleExport = () => {
    const rows = [['Eficiência de Cadeira — SintesIA'], [`Período: ${periodLabel(period)}`], [],
      ['Profissional', 'Especialidade', 'Sessões', 'Min. trabalhados', 'Receita total', 'Lucro total', 'Lucro/min (R$)', 'Margem (%)'],
      ...efficiencies.map(e => [e.profName, e.specialty, String(e.sessions), String(e.totalMinutes), e.totalRevenue.toFixed(2), e.totalProfit.toFixed(2), e.profitPerMinute.toFixed(2), e.avgMargin.toFixed(1)]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = `Eficiencia_Cadeira_${periodLabel(period)}.csv`; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Eficiência de Cadeira</h1>
          <p className="text-xs text-slate-500">Lucro por minuto de sala/cadeira por profissional — {periodLabel(period)}</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      <div className="flex gap-2">
        {(['mes','trimestre','ano'] as PeriodKey[]).map(p => (
          <button key={p} onClick={() => setPeriod(p)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${period === p ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            {{ mes: 'Mês atual', trimestre: 'Trimestre', ano: 'Ano' }[p]}
          </button>
        ))}
      </div>

      {loading ? <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div> :
       efficiencies.length === 0 ? (
        <div className="flex flex-col items-center py-16 gap-2 text-center">
          <Clock className="w-10 h-10 text-slate-300" />
          <p className="text-slate-400 text-sm">Nenhum pagamento com profissional vinculado no período.</p>
        </div>
       ) : (
        <>
          {/* Ranking */}
          <div className="flex flex-col gap-3">
            {efficiencies.map((e, i) => {
              const colorClass = COLORS[e.color] ?? 'bg-slate-400';
              const barWidth = (e.profitPerMinute / maxPPM) * 100;
              return (
                <div key={e.profId} className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
                  {/* Header */}
                  <div className="flex items-center gap-3">
                    <span className={`w-7 h-7 flex items-center justify-center rounded-lg text-xs font-bold shrink-0 ${i === 0 ? 'bg-amber-100 text-amber-600' : i === 1 ? 'bg-slate-100 text-slate-500' : i === 2 ? 'bg-orange-100 text-orange-500' : 'bg-slate-50 text-slate-400'}`}>{i+1}</span>
                    <div className={`w-8 h-8 rounded-xl ${colorClass} flex items-center justify-center text-white font-bold text-sm shrink-0`}>{e.profName.charAt(0)}</div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-semibold text-slate-800 truncate">{e.profName}</p>
                      <p className="text-xs text-slate-400">{e.specialty} · {e.sessions} sessões · {Math.round(e.totalMinutes / 60)}h trabalhadas</p>
                    </div>
                    <div className="text-right shrink-0">
                      <p className="text-base font-bold text-emerald-600 tabular-nums">{fmt(e.profitPerMinute)}<span className="text-xs font-normal text-slate-400">/min</span></p>
                      <p className="text-[10px] text-slate-400">{fmtPct(e.avgMargin)} margem</p>
                    </div>
                  </div>

                  {/* Barra de eficiência */}
                  <div className="flex flex-col gap-1">
                    <div className="w-full h-2 bg-slate-100 rounded-full overflow-hidden">
                      <div className={`h-full rounded-full ${colorClass}`} style={{ width: `${barWidth}%` }} />
                    </div>
                  </div>

                  {/* Stats */}
                  <div className="grid grid-cols-4 gap-2 pt-1 border-t border-slate-100">
                    <div className="text-center">
                      <p className="text-[10px] text-slate-400">Receita</p>
                      <p className="text-xs font-semibold text-slate-700 tabular-nums">{fmt(e.totalRevenue)}</p>
                    </div>
                    <div className="text-center">
                      <p className="text-[10px] text-slate-400">Lucro</p>
                      <p className={`text-xs font-semibold tabular-nums ${e.totalProfit >= 0 ? 'text-emerald-600' : 'text-rose-500'}`}>{fmt(e.totalProfit)}</p>
                    </div>
                    <div className="text-center">
                      <p className="text-[10px] text-slate-400">Rec./min</p>
                      <p className="text-xs font-semibold text-indigo-600 tabular-nums">{fmt(e.revenuePerMinute)}</p>
                    </div>
                    <div className="text-center">
                      <p className="text-[10px] text-slate-400">Top serviço</p>
                      <p className="text-[10px] font-medium text-slate-600 truncate">{e.topService}</p>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>

          <div className="flex items-start gap-2 bg-slate-50 border border-slate-200 rounded-xl px-4 py-3">
            <Clock className="w-4 h-4 text-slate-400 shrink-0 mt-0.5" />
            <p className="text-xs text-slate-500">
              A duração usada no cálculo vem da <strong>precificação cadastrada em BI &amp; Margem</strong>.
              Serviços sem precificação usam {DEFAULT_DURATION} minutos como padrão — cadastre a duração real para maior precisão.
            </p>
          </div>
        </>
      )}
    </div>
  );
}
