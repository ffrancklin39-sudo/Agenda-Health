import React, { useState, useEffect, useMemo } from 'react';
import {
  ArrowLeft, Download, RefreshCw, BarChart3,
  ChevronDown, ChevronUp, TrendingUp, TrendingDown, AlertTriangle,
} from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

// ─── Tipos ────────────────────────────────────────────────────

interface PatientRow {
  price: number;
  status: string;
  appointment_date: string | null;
  service_id: string | null;
}

interface ServiceRow { id: string; name: string; category: string }

interface PricingRow {
  service_id: string;
  tax_percentage: number;
  commission_percentage: number;
  fixed_cost: number;
  fee_pix: number;
}

interface ServiceStats {
  serviceId: string;
  serviceName: string;
  category: string;
  count: number;
  grossRevenue: number;
  totalTax: number;
  totalFee: number;
  totalFixedCost: number;
  totalCommission: number;
  netRevenue: number;
  netProfit: number;
  marginPct: number;
  hasPricing: boolean;
}

type PeriodKey = 'mes' | 'trimestre' | 'ano' | 'custom';
type SortKey   = 'grossRevenue' | 'netProfit' | 'marginPct' | 'count';
const MONTHS   = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
const CONFIRMED = ['confirmed','confirmado','pago','completed'];
const fmt      = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct   = (v: number) => `${v.toFixed(1)}%`;

function getPeriodRange(period: PeriodKey, cs: string, ce: string) {
  const now = new Date(); const y = now.getFullYear(), m = now.getMonth();
  switch (period) {
    case 'mes':       return { start: new Date(y, m, 1),     end: new Date(y, m + 1, 0, 23, 59, 59) };
    case 'trimestre': return { start: new Date(y, m - 2, 1), end: new Date(y, m + 1, 0, 23, 59, 59) };
    case 'ano':       return { start: new Date(y, 0, 1),     end: new Date(y, 11, 31, 23, 59, 59) };
    default: return {
      start: cs ? new Date(cs) : new Date(y, m, 1),
      end:   ce ? new Date(ce + 'T23:59:59') : new Date(y, m + 1, 0, 23, 59, 59),
    };
  }
}
function periodLabel(period: PeriodKey, cs: string, ce: string) {
  const now = new Date();
  if (period === 'mes')       return `${MONTHS[now.getMonth()]}/${now.getFullYear()}`;
  if (period === 'trimestre') return 'Último trimestre';
  if (period === 'ano')       return `Ano ${now.getFullYear()}`;
  return cs && ce ? `${cs.split('-').reverse().join('/')} a ${ce.split('-').reverse().join('/')}` : 'Personalizado';
}

function marginColor(pct: number) {
  if (pct >= 30) return 'text-emerald-600';
  if (pct >= 15) return 'text-green-600';
  if (pct >= 0)  return 'text-amber-600';
  return 'text-rose-500';
}
function marginBg(pct: number) {
  if (pct >= 30) return 'bg-emerald-50 border-emerald-200';
  if (pct >= 15) return 'bg-green-50 border-green-200';
  if (pct >= 0)  return 'bg-amber-50 border-amber-200';
  return 'bg-rose-50 border-rose-200';
}

// ─── Componente principal ─────────────────────────────────────

interface Props { onBack: () => void }

const RevenueByService: React.FC<Props> = ({ onBack }) => {
  const [period, setPeriod]           = useState<PeriodKey>('mes');
  const [customStart, setCustomStart] = useState('');
  const [customEnd, setCustomEnd]     = useState('');
  const [patients, setPatients]       = useState<PatientRow[]>([]);
  const [services, setServices]       = useState<ServiceRow[]>([]);
  const [pricing, setPricing]         = useState<PricingRow[]>([]);
  const [loading, setLoading]         = useState(true);
  const [sortKey, setSortKey]         = useState<SortKey>('grossRevenue');
  const [sortDir, setSortDir]         = useState<'desc' | 'asc'>('desc');
  const [categoryFilter, setCategoryFilter] = useState('Todos');
  const [expandedId, setExpandedId]   = useState<string | null>(null);

  useEffect(() => {
    Promise.all([
      supabase.from('patients').select('price,status,appointment_date,service_id'),
      supabase.from('services').select('id,name,category'),
      supabase.from('procedures_pricing').select('service_id,tax_percentage,commission_percentage,fixed_cost,fee_pix'),
    ]).then(([pRes, sRes, prRes]) => {
      setPatients((pRes.data ?? []) as PatientRow[]);
      setServices((sRes.data ?? []) as ServiceRow[]);
      setPricing((prRes.data ?? []) as PricingRow[]);
      setLoading(false);
    });
  }, []);

  const { start, end } = useMemo(() => getPeriodRange(period, customStart, customEnd), [period, customStart, customEnd]);

  const stats = useMemo((): ServiceStats[] => {
    const inPeriod = (d: string | null) => {
      if (!d) return false;
      const dt = new Date(d);
      return dt >= start && dt <= end;
    };

    const attended = patients.filter(p =>
      CONFIRMED.includes((p.status ?? '').toLowerCase()) && inPeriod(p.appointment_date)
    );

    // Agrupar por service_id
    const map = new Map<string, PatientRow[]>();
    attended.forEach(p => {
      const key = p.service_id ?? '__sem_servico__';
      if (!map.has(key)) map.set(key, []);
      map.get(key)!.push(p);
    });

    return Array.from(map.entries()).map(([serviceId, rows]) => {
      const svc = services.find(s => s.id === serviceId);
      const pr  = pricing.find(x => x.service_id === serviceId);

      let grossRevenue = 0, totalTax = 0, totalFee = 0, totalFixedCost = 0, totalCommission = 0;

      rows.forEach(p => {
        const price = p.price ?? 0;
        grossRevenue += price;
        if (pr) {
          const tax  = price * (pr.tax_percentage / 100);
          const fee  = price * (pr.fee_pix / 100);
          const net  = price - tax - fee;
          const comm = net * (pr.commission_percentage / 100);
          totalTax        += tax;
          totalFee        += fee;
          totalFixedCost  += pr.fixed_cost;
          totalCommission += comm;
        } else {
          totalTax        += price * 0.06;
          totalCommission += price * 0.40 * 0.94;
        }
      });

      const netRevenue = grossRevenue - totalTax - totalFee;
      const netProfit  = netRevenue - totalFixedCost - totalCommission;
      const marginPct  = grossRevenue > 0 ? (netProfit / grossRevenue) * 100 : 0;

      return {
        serviceId,
        serviceName:  svc?.name ?? 'Serviço não identificado',
        category:     svc?.category ?? 'Outros',
        count:        rows.length,
        grossRevenue, totalTax, totalFee, totalFixedCost, totalCommission,
        netRevenue, netProfit, marginPct,
        hasPricing:   !!pr,
      };
    });
  }, [patients, services, pricing, start, end]);

  const categories = useMemo(() => ['Todos', ...Array.from(new Set(stats.map(s => s.category)))], [stats]);

  const sorted = useMemo(() => {
    let r = categoryFilter === 'Todos' ? stats : stats.filter(s => s.category === categoryFilter);
    return r.sort((a, b) => {
      const va = a[sortKey], vb = b[sortKey];
      return sortDir === 'desc' ? vb - va : va - vb;
    });
  }, [stats, sortKey, sortDir, categoryFilter]);

  const totals = useMemo(() => ({
    count:        sorted.reduce((s, r) => s + r.count, 0),
    grossRevenue: sorted.reduce((s, r) => s + r.grossRevenue, 0),
    netProfit:    sorted.reduce((s, r) => s + r.netProfit, 0),
  }), [sorted]);

  const maxGross = useMemo(() => Math.max(...sorted.map(r => r.grossRevenue), 1), [sorted]);

  const toggleSort = (key: SortKey) => {
    if (sortKey === key) setSortDir(d => d === 'desc' ? 'asc' : 'desc');
    else { setSortKey(key); setSortDir('desc'); }
  };

  const handleExport = () => {
    const rows: string[][] = [
      ['Receita por Serviço — SintesIA'],
      [`Período: ${periodLabel(period, customStart, customEnd)}`],
      [],
      ['#', 'Serviço', 'Categoria', 'Atendimentos', 'Receita Bruta', 'Receita Líquida', 'Lucro Líquido', 'Margem (%)'],
      ...sorted.map((r, i) => [
        String(i + 1), r.serviceName, r.category, String(r.count),
        r.grossRevenue.toFixed(2), r.netRevenue.toFixed(2),
        r.netProfit.toFixed(2), r.marginPct.toFixed(1),
      ]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = `Receita_por_Servico_${periodLabel(period, customStart, customEnd).replace(/\//g, '-')}.csv`;
    a.click();
  };

  const SortBtn: React.FC<{ k: SortKey; label: string; align?: string }> = ({ k, label, align = 'text-right' }) => (
    <button onClick={() => toggleSort(k)}
      className={`${align} flex items-center gap-0.5 ${sortKey === k ? 'text-indigo-600' : 'text-slate-400 hover:text-slate-600'} transition-colors text-[10px] font-bold uppercase tracking-wide`}>
      {label}
      {sortKey === k && (sortDir === 'desc' ? <ChevronDown className="w-3 h-3" /> : <ChevronUp className="w-3 h-3" />)}
    </button>
  );

  return (
    <div className="flex flex-col gap-5">

      {/* Header */}
      <div className="flex items-center gap-3 flex-wrap">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 hover:text-slate-700 transition-colors">
          <ArrowLeft className="w-4 h-4" />
        </button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Receita por Serviço</h1>
          <p className="text-xs text-slate-500">{periodLabel(period, customStart, customEnd)} · faturamento bruto vs lucro real</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 hover:text-indigo-600 border border-slate-200 hover:border-indigo-300 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      {/* Filtros */}
      <div className="flex items-center gap-2 flex-wrap">
        {(['mes','trimestre','ano','custom'] as PeriodKey[]).map(p => (
          <button key={p} onClick={() => setPeriod(p)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${period === p ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            {{ mes: 'Mês atual', trimestre: 'Trimestre', ano: 'Ano', custom: 'Personalizado' }[p]}
          </button>
        ))}
        {period === 'custom' && (
          <div className="flex items-center gap-2 ml-2">
            <input type="date" value={customStart} onChange={e => setCustomStart(e.target.value)}
              className="text-xs border border-slate-200 rounded-lg px-2 py-1.5 outline-none focus:border-indigo-400" />
            <span className="text-slate-400 text-xs">até</span>
            <input type="date" value={customEnd} onChange={e => setCustomEnd(e.target.value)}
              className="text-xs border border-slate-200 rounded-lg px-2 py-1.5 outline-none focus:border-indigo-400" />
          </div>
        )}
      </div>

      {/* Filtro categoria */}
      {categories.length > 2 && (
        <div className="flex items-center gap-1.5 flex-wrap">
          {categories.map(cat => (
            <button key={cat} onClick={() => setCategoryFilter(cat)}
              className={`px-2.5 py-1 rounded-lg text-xs font-semibold transition-colors ${categoryFilter === cat ? 'bg-slate-700 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
              {cat}
            </button>
          ))}
        </div>
      )}

      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-6 h-6 text-indigo-400 animate-spin" /></div>
      ) : sorted.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 gap-3">
          <BarChart3 className="w-10 h-10 text-slate-300" />
          <p className="text-slate-500 text-sm">Nenhum atendimento no período selecionado.</p>
        </div>
      ) : (
        <>
          {/* KPIs */}
          <div className="grid grid-cols-3 gap-3">
            <div className="bg-white border border-slate-200 rounded-xl p-4">
              <p className="text-xs text-slate-500">Serviços ativos</p>
              <p className="text-xl font-bold text-slate-800">{sorted.length}</p>
              <p className="text-xs text-slate-400">{totals.count} atendimentos</p>
            </div>
            <div className="bg-white border border-slate-200 rounded-xl p-4">
              <p className="text-xs text-slate-500">Receita Bruta</p>
              <p className="text-xl font-bold text-slate-800 tabular-nums">{fmt(totals.grossRevenue)}</p>
            </div>
            <div className="bg-white border border-slate-200 rounded-xl p-4">
              <p className="text-xs text-slate-500">Lucro Líquido</p>
              <p className={`text-xl font-bold tabular-nums ${totals.netProfit >= 0 ? 'text-emerald-600' : 'text-rose-500'}`}>{fmt(totals.netProfit)}</p>
              <p className="text-xs text-slate-400">{totals.grossRevenue > 0 ? fmtPct(totals.netProfit / totals.grossRevenue * 100) : '—'} de margem</p>
            </div>
          </div>

          {/* Alerta serviços sem precificação */}
          {sorted.some(s => !s.hasPricing) && (
            <div className="flex items-start gap-2 bg-amber-50 border border-amber-200 rounded-xl px-4 py-3">
              <AlertTriangle className="w-4 h-4 text-amber-500 shrink-0 mt-0.5" />
              <p className="text-xs text-amber-700">
                {sorted.filter(s => !s.hasPricing).length} serviço(s) sem precificação cadastrada — custos estimados com valores padrão.
                Cadastre em <strong>BI &amp; Margem</strong> para dados precisos.
              </p>
            </div>
          )}

          {/* Tabela ranking */}
          <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
            <div className="grid grid-cols-[32px_1fr_80px_100px_100px_90px] gap-2 px-4 py-2.5 bg-slate-50 border-b border-slate-100">
              <span className="text-[10px] font-bold text-slate-400">#</span>
              <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wide">Serviço</span>
              <SortBtn k="count"        label="Atend."    align="text-right" />
              <SortBtn k="grossRevenue" label="Bruto"     align="text-right" />
              <SortBtn k="netProfit"    label="Líquido"   align="text-right" />
              <SortBtn k="marginPct"    label="Margem"    align="text-right" />
            </div>

            <div className="divide-y divide-slate-50">
              {sorted.map((row, i) => {
                const isExp = expandedId === row.serviceId;
                return (
                  <div key={row.serviceId} className="group">
                    <button
                      onClick={() => setExpandedId(isExp ? null : row.serviceId)}
                      className="w-full grid grid-cols-[32px_1fr_80px_100px_100px_90px] gap-2 px-4 py-3 hover:bg-slate-50 transition-colors items-center"
                    >
                      {/* Rank */}
                      <span className={`text-xs font-bold w-6 h-6 rounded-lg flex items-center justify-center ${
                        i === 0 ? 'bg-amber-100 text-amber-600' : i === 1 ? 'bg-slate-100 text-slate-500' : i === 2 ? 'bg-orange-100 text-orange-500' : 'text-slate-400'
                      }`}>{i + 1}</span>

                      {/* Nome + barra */}
                      <div className="text-left min-w-0">
                        <div className="flex items-center gap-1.5">
                          <p className="text-sm font-medium text-slate-700 truncate">{row.serviceName}</p>
                          {!row.hasPricing && <AlertTriangle className="w-3 h-3 text-amber-400 shrink-0" />}
                        </div>
                        <div className="flex items-center gap-1.5 mt-0.5">
                          <span className="text-[10px] text-slate-400">{row.category}</span>
                          <div className="flex-1 h-1 bg-slate-100 rounded-full overflow-hidden max-w-[80px]">
                            <div className="h-full bg-indigo-400 rounded-full"
                              style={{ width: `${(row.grossRevenue / maxGross) * 100}%` }} />
                          </div>
                        </div>
                      </div>

                      {/* Atend. */}
                      <span className="text-sm text-slate-500 tabular-nums text-right">{row.count}x</span>

                      {/* Bruto */}
                      <span className="text-sm text-slate-600 tabular-nums text-right">{fmt(row.grossRevenue)}</span>

                      {/* Líquido */}
                      <span className={`text-sm font-medium tabular-nums text-right ${row.netProfit >= 0 ? 'text-emerald-600' : 'text-rose-500'}`}>
                        {fmt(row.netProfit)}
                      </span>

                      {/* Margem */}
                      <div className={`text-xs font-bold tabular-nums text-right rounded-lg border px-2 py-1 ${marginBg(row.marginPct)}`}>
                        <span className={marginColor(row.marginPct)}>{fmtPct(row.marginPct)}</span>
                      </div>
                    </button>

                    {/* Breakdown expandido */}
                    {isExp && (
                      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 px-4 pb-4 pt-1 bg-slate-50/50 border-t border-slate-100">
                        <div>
                          <p className="text-[10px] text-slate-400">Impostos</p>
                          <p className="text-sm font-medium text-rose-500 tabular-nums">-{fmt(row.totalTax)}</p>
                        </div>
                        <div>
                          <p className="text-[10px] text-slate-400">Taxas de pagamento</p>
                          <p className="text-sm font-medium text-rose-500 tabular-nums">-{fmt(row.totalFee)}</p>
                        </div>
                        <div>
                          <p className="text-[10px] text-slate-400">Insumos</p>
                          <p className="text-sm font-medium text-rose-500 tabular-nums">-{fmt(row.totalFixedCost)}</p>
                        </div>
                        <div>
                          <p className="text-[10px] text-slate-400">Comissões</p>
                          <p className="text-sm font-medium text-rose-500 tabular-nums">-{fmt(row.totalCommission)}</p>
                        </div>
                        <div>
                          <p className="text-[10px] text-slate-400">Ticket médio bruto</p>
                          <p className="text-sm font-medium text-slate-600 tabular-nums">{fmt(row.count > 0 ? row.grossRevenue / row.count : 0)}</p>
                        </div>
                        <div>
                          <p className="text-[10px] text-slate-400">Ticket médio líquido</p>
                          <p className="text-sm font-medium text-emerald-600 tabular-nums">{fmt(row.count > 0 ? row.netProfit / row.count : 0)}</p>
                        </div>
                        <div>
                          <p className="text-[10px] text-slate-400">Receita líquida</p>
                          <p className="text-sm font-medium text-amber-600 tabular-nums">{fmt(row.netRevenue)}</p>
                        </div>
                        <div>
                          <p className="text-[10px] text-slate-400">Precificação</p>
                          <p className={`text-xs font-semibold ${row.hasPricing ? 'text-emerald-600' : 'text-amber-500'}`}>
                            {row.hasPricing ? '✓ Cadastrada' : '⚠ Estimada'}
                          </p>
                        </div>
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default RevenueByService;
