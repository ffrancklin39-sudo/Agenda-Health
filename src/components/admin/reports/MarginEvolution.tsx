import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw, TrendingUp, TrendingDown } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface PaymentRow {
  amount: number;
  real_profit: number | null;
  margin_pct: number | null;
  tax_amount: number | null;
  payment_fee_amount: number | null;
  commission_amount: number | null;
  fixed_cost: number | null;
  service_id: string | null;
  service_name: string | null;
  payment_date: string;
}

interface MonthStats {
  month: string;
  label: string;
  grossRevenue: number;
  netProfit: number;
  marginPct: number;
  count: number;
  tax: number;
  fees: number;
  commissions: number;
  costs: number;
}

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number) => `${v.toFixed(1)}%`;
const MONTHS = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];

export default function MarginEvolution({ onBack }: { onBack: () => void }) {
  const [payments, setPayments] = useState<PaymentRow[]>([]);
  const [loading, setLoading]   = useState(true);
  const [months, setMonths]     = useState(12);
  const [serviceFilter, setServiceFilter] = useState<string>('all');

  useEffect(() => {
    supabase.from('vw_payments_full')
      .select('amount,real_profit,margin_pct,tax_amount,payment_fee_amount,commission_amount,fixed_cost,service_id,service_name,payment_date')
      .eq('status', 'paid')
      .order('payment_date')
      .then(({ data }) => { setPayments((data ?? []) as PaymentRow[]); setLoading(false); });
  }, []);

  const services = useMemo(() => {
    const s = new Map<string, string>();
    payments.forEach(p => { if (p.service_id && p.service_name) s.set(p.service_id, p.service_name); });
    return Array.from(s.entries());
  }, [payments]);

  const monthlyStats = useMemo((): MonthStats[] => {
    const now = new Date();
    const cutoff = new Date(now.getFullYear(), now.getMonth() - months + 1, 1);

    const filtered = payments.filter(p => {
      const d = new Date(p.payment_date);
      if (d < cutoff) return false;
      if (serviceFilter !== 'all' && p.service_id !== serviceFilter) return false;
      return true;
    });

    const map = new Map<string, MonthStats>();
    filtered.forEach(p => {
      const d = new Date(p.payment_date);
      const key = `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}`;
      if (!map.has(key)) {
        map.set(key, { month: key, label: `${MONTHS[d.getMonth()]}/${d.getFullYear()}`, grossRevenue: 0, netProfit: 0, marginPct: 0, count: 0, tax: 0, fees: 0, commissions: 0, costs: 0 });
      }
      const m = map.get(key)!;
      m.grossRevenue  += p.amount;
      m.netProfit     += p.real_profit ?? 0;
      m.tax           += p.tax_amount ?? 0;
      m.fees          += p.payment_fee_amount ?? 0;
      m.commissions   += p.commission_amount ?? 0;
      m.costs         += p.fixed_cost ?? 0;
      m.count++;
    });

    return Array.from(map.values())
      .map(m => ({ ...m, marginPct: m.grossRevenue > 0 ? (m.netProfit / m.grossRevenue) * 100 : 0 }))
      .sort((a, b) => a.month.localeCompare(b.month));
  }, [payments, months, serviceFilter]);

  const maxRevenue = useMemo(() => Math.max(...monthlyStats.map(m => m.grossRevenue), 1), [monthlyStats]);
  const maxMargin  = useMemo(() => Math.max(...monthlyStats.map(m => Math.abs(m.marginPct)), 1), [monthlyStats]);

  const trend = useMemo(() => {
    if (monthlyStats.length < 2) return null;
    const last  = monthlyStats[monthlyStats.length - 1].marginPct;
    const prev  = monthlyStats[monthlyStats.length - 2].marginPct;
    return { diff: last - prev, direction: last >= prev ? 'up' : 'down' };
  }, [monthlyStats]);

  const kpis = useMemo(() => {
    if (!monthlyStats.length) return null;
    const avgMargin  = monthlyStats.reduce((s, m) => s + m.marginPct, 0) / monthlyStats.length;
    const totalRev   = monthlyStats.reduce((s, m) => s + m.grossRevenue, 0);
    const totalProfit= monthlyStats.reduce((s, m) => s + m.netProfit, 0);
    const best       = [...monthlyStats].sort((a, b) => b.marginPct - a.marginPct)[0];
    return { avgMargin, totalRev, totalProfit, best };
  }, [monthlyStats]);

  const handleExport = () => {
    const rows = [['Evolução de Margem — SintesIA'], [],
      ['Mês', 'Transações', 'Receita Bruta', 'Lucro Líquido', 'Margem (%)', 'Impostos', 'Taxas', 'Comissões', 'Insumos'],
      ...monthlyStats.map(m => [m.label, String(m.count), m.grossRevenue.toFixed(2), m.netProfit.toFixed(2), m.marginPct.toFixed(1), m.tax.toFixed(2), m.fees.toFixed(2), m.commissions.toFixed(2), m.costs.toFixed(2)]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'Margem_por_Periodo.csv'; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3 flex-wrap">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800 flex items-center gap-2">
            Margem Real por Período
            {trend && (
              <span className={`flex items-center gap-1 text-sm font-bold ${trend.direction === 'up' ? 'text-emerald-600' : 'text-rose-500'}`}>
                {trend.direction === 'up' ? <TrendingUp className="w-4 h-4" /> : <TrendingDown className="w-4 h-4" />}
                {trend.diff > 0 ? '+' : ''}{fmtPct(trend.diff)}
              </span>
            )}
          </h1>
          <p className="text-xs text-slate-500">Evolução da margem de lucro real mês a mês</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      {/* Filtros */}
      <div className="flex items-center gap-2 flex-wrap">
        {[6, 12, 24].map(m => (
          <button key={m} onClick={() => setMonths(m)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${months === m ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            Últimos {m} meses
          </button>
        ))}
        {services.length > 0 && (
          <select value={serviceFilter} onChange={e => setServiceFilter(e.target.value)}
            className="ml-2 text-xs border border-slate-200 rounded-xl px-3 py-1.5 outline-none focus:border-indigo-400 bg-white">
            <option value="all">Todos os serviços</option>
            {services.map(([id, name]) => <option key={id} value={id}>{name}</option>)}
          </select>
        )}
      </div>

      {kpis && (
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Margem média</p><p className={`text-xl font-bold ${kpis.avgMargin >= 20 ? 'text-emerald-600' : kpis.avgMargin >= 10 ? 'text-amber-600' : 'text-rose-500'}`}>{fmtPct(kpis.avgMargin)}</p></div>
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Receita total</p><p className="text-xl font-bold text-slate-800 tabular-nums">{fmt(kpis.totalRev)}</p></div>
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Lucro total</p><p className={`text-xl font-bold tabular-nums ${kpis.totalProfit >= 0 ? 'text-emerald-600' : 'text-rose-500'}`}>{fmt(kpis.totalProfit)}</p></div>
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Melhor mês</p><p className="text-sm font-bold text-indigo-600">{kpis.best.label}</p><p className="text-xs text-slate-400">{fmtPct(kpis.best.marginPct)} de margem</p></div>
        </div>
      )}

      {loading ? <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div> :
       monthlyStats.length === 0 ? (
        <div className="flex flex-col items-center py-16 gap-2 text-center">
          <p className="text-slate-400 text-sm">Nenhum pagamento registrado no período.</p>
          <p className="text-xs text-slate-400">Registre pagamentos no modal de pagamento para ver a evolução.</p>
        </div>
       ) : (
        <>
          {/* Gráfico de barras: receita vs lucro */}
          <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-4">
            <p className="text-sm font-semibold text-slate-700">Receita Bruta vs Lucro Líquido</p>
            <div className="flex items-end gap-1.5 h-32 overflow-x-auto pb-2">
              {monthlyStats.map(m => (
                <div key={m.month} className="flex flex-col items-center gap-1 min-w-[40px] flex-1">
                  <div className="w-full flex flex-col justify-end gap-0.5" style={{ height: '100px' }}>
                    <div className="w-full bg-indigo-200 rounded-t-sm" style={{ height: `${(m.grossRevenue / maxRevenue) * 88}px` }} />
                    <div className={`w-full rounded-t-sm ${m.netProfit >= 0 ? 'bg-emerald-500' : 'bg-rose-400'}`}
                      style={{ height: `${Math.abs(m.netProfit) / maxRevenue * 88}px` }} />
                  </div>
                  <span className="text-[9px] text-slate-400 whitespace-nowrap">{m.label.split('/')[0]}</span>
                </div>
              ))}
            </div>
            <div className="flex items-center gap-4 text-[10px] text-slate-500">
              <span className="flex items-center gap-1"><span className="w-3 h-2 bg-indigo-200 rounded inline-block" /> Receita bruta</span>
              <span className="flex items-center gap-1"><span className="w-3 h-2 bg-emerald-500 rounded inline-block" /> Lucro líquido</span>
            </div>
          </div>

          {/* Gráfico de linha: margem % */}
          <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
            <p className="text-sm font-semibold text-slate-700">Evolução da Margem (%)</p>
            <div className="flex items-end gap-1.5 h-20 overflow-x-auto pb-2">
              {monthlyStats.map(m => (
                <div key={m.month} className="flex flex-col items-center gap-1 min-w-[40px] flex-1">
                  <span className={`text-[9px] font-bold ${m.marginPct >= 20 ? 'text-emerald-600' : m.marginPct >= 10 ? 'text-amber-600' : 'text-rose-500'}`}>
                    {fmtPct(m.marginPct)}
                  </span>
                  <div className="w-full bg-slate-100 rounded-t" style={{ height: `${(Math.abs(m.marginPct) / maxMargin) * 40}px` }}>
                    <div className={`w-full h-full rounded-t ${m.marginPct >= 20 ? 'bg-emerald-500' : m.marginPct >= 10 ? 'bg-amber-400' : m.marginPct >= 0 ? 'bg-orange-400' : 'bg-rose-400'}`} />
                  </div>
                  <span className="text-[9px] text-slate-400">{m.label.split('/')[0]}</span>
                </div>
              ))}
            </div>
          </div>

          {/* Tabela detalhada */}
          <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
            <div className="grid grid-cols-[100px_60px_1fr_1fr_80px] gap-2 px-4 py-2.5 bg-slate-50 border-b border-slate-100 text-[10px] font-bold text-slate-400 uppercase">
              <span>Mês</span><span className="text-center">Transações</span><span className="text-right">Receita</span><span className="text-right">Lucro</span><span className="text-right">Margem</span>
            </div>
            <div className="divide-y divide-slate-50">
              {[...monthlyStats].reverse().map(m => (
                <div key={m.month} className="grid grid-cols-[100px_60px_1fr_1fr_80px] gap-2 px-4 py-3 hover:bg-slate-50 transition-colors items-center">
                  <span className="text-xs font-medium text-slate-700">{m.label}</span>
                  <span className="text-xs text-slate-400 text-center">{m.count}x</span>
                  <span className="text-xs text-slate-600 text-right tabular-nums">{fmt(m.grossRevenue)}</span>
                  <span className={`text-xs font-medium text-right tabular-nums ${m.netProfit >= 0 ? 'text-emerald-600' : 'text-rose-500'}`}>{fmt(m.netProfit)}</span>
                  <span className={`text-xs font-bold text-right ${m.marginPct >= 20 ? 'text-emerald-600' : m.marginPct >= 10 ? 'text-amber-600' : 'text-rose-500'}`}>{fmtPct(m.marginPct)}</span>
                </div>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  );
}
