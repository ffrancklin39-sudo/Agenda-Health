import React, { useState, useEffect, useMemo, useCallback } from 'react';
import { ChevronLeft, ChevronRight, RefreshCw, TrendingUp, TrendingDown, Minus } from 'lucide-react';
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
  ResponsiveContainer, PieChart, Pie, Cell,
} from 'recharts';
import { supabase } from '../../../services/supabaseClient';

// ── Constantes ────────────────────────────────────────────────

const MONTHS_PT = [
  'Janeiro','Fevereiro','Março','Abril','Maio','Junho',
  'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro',
];

const CATEGORY_LABEL: Record<string, string> = {
  aluguel: 'Aluguel',
  salario: 'Salário',
  insumos: 'Insumos',
  equipamentos: 'Equipamentos',
  marketing: 'Marketing',
  servicos: 'Serviços',
  impostos: 'Impostos',
  manutencao: 'Manutenção',
  outros: 'Outros',
};

const CATEGORY_COLOR: Record<string, string> = {
  aluguel:      '#6366f1',
  salario:      '#8b5cf6',
  insumos:      '#ec4899',
  equipamentos: '#f59e0b',
  marketing:    '#10b981',
  servicos:     '#3b82f6',
  impostos:     '#ef4444',
  manutencao:   '#f97316',
  outros:       '#94a3b8',
};

const DEFAULT_COLOR = '#94a3b8';

const fmt = (v: number) =>
  v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL', maximumFractionDigits: 0 });

const pct = (real: number, est: number) =>
  est > 0 ? Math.min(Math.round((real / est) * 100), 100) : 0;

// ── Tipos ─────────────────────────────────────────────────────

interface CatRow {
  category: string;
  estimado: number;
  realizado: number;
  color: string;
}

// ── Tooltip customizado ───────────────────────────────────────

const CustomTooltip = ({ active, payload, label }: any) => {
  if (!active || !payload?.length) return null;
  return (
    <div className="bg-white border border-slate-200 rounded-xl shadow-lg px-4 py-3 text-xs">
      <p className="font-bold text-slate-700 mb-1.5">{label}</p>
      {payload.map((p: any) => (
        <p key={p.name} className="flex items-center gap-2">
          <span className="inline-block w-2.5 h-2.5 rounded-sm" style={{ background: p.fill }} />
          <span className="text-slate-500">{p.name}:</span>
          <span className="font-semibold text-slate-800">{fmt(p.value)}</span>
        </p>
      ))}
    </div>
  );
};

// ── Componente principal ───────────────────────────────────────

const VisaoGeralFinanceira: React.FC = () => {
  const [viewDate, setViewDate] = useState(() => new Date());
  const [loading, setLoading] = useState(true);

  // Dados
  const [recReal,  setRecReal]  = useState(0);
  const [recEst,   setRecEst]   = useState(0);
  const [despReal, setDespReal] = useState(0);
  const [despEst,  setDespEst]  = useState(0);
  const [cats,     setCats]     = useState<CatRow[]>([]);

  // ── Computed dates ──────────────────────────────────────────
  const { startStr, endStr, monthLabel, monthYear } = useMemo(() => {
    const y = viewDate.getFullYear();
    const m = viewDate.getMonth();
    const start = new Date(y, m, 1);
    const end   = new Date(y, m + 1, 0);
    return {
      startStr:   start.toISOString().slice(0, 10),
      endStr:     end.toISOString().slice(0, 10),
      monthLabel: MONTHS_PT[m],
      monthYear:  `${MONTHS_PT[m]} ${y}`,
    };
  }, [viewDate]);

  // ── Busca de dados ─────────────────────────────────────────
  const load = useCallback(async () => {
    setLoading(true);
    try {
      // 1. Receitas realizadas (payments pagos no mês)
      const { data: payments } = await supabase
        .from('payments')
        .select('amount')
        .eq('status', 'paid')
        .gte('payment_date', startStr)
        .lte('payment_date', endStr);

      const recRealVal = (payments ?? []).reduce((s, p) => s + (p.amount ?? 0), 0);
      setRecReal(recRealVal);

      // 2. Receitas estimadas (agendamentos com serviço no mês)
      //    Tenta buscar appointments + service price; graceful fallback
      let recEstVal = 0;
      try {
        const { data: appts } = await supabase
          .from('appointments')
          .select('services(price)')
          .gte('date', startStr)
          .lte('date', endStr)
          .not('status', 'in', '("cancelled","cancelado","no_show","noshow")');

        if (appts && appts.length > 0) {
          recEstVal = appts.reduce((s, a) => {
            const price = (a as any).services?.price ?? 0;
            return s + price;
          }, 0);
        }
      } catch {
        // appointments query failed — use payments as fallback
      }
      // Fallback: se não tiver agendamentos, usa realizado como estimado
      setRecEst(recEstVal > 0 ? recEstVal : recRealVal);

      // 3. Despesas (bills do mês, não canceladas)
      const { data: bills } = await supabase
        .from('bills')
        .select('amount, amount_paid, status, category')
        .gte('due_date', startStr)
        .lte('due_date', endStr)
        .neq('status', 'cancelled');

      const billsArr = bills ?? [];

      const despEstVal  = billsArr.reduce((s, b) => s + (b.amount ?? 0), 0);
      const despRealVal = billsArr
        .filter(b => b.status === 'paid')
        .reduce((s, b) => s + (b.amount_paid ?? b.amount ?? 0), 0);

      setDespEst(despEstVal);
      setDespReal(despRealVal);

      // 4. Categorias de despesa
      const catMap: Record<string, { estimado: number; realizado: number }> = {};
      for (const b of billsArr) {
        const cat = b.category || 'outros';
        if (!catMap[cat]) catMap[cat] = { estimado: 0, realizado: 0 };
        catMap[cat].estimado += b.amount ?? 0;
        if (b.status === 'paid') catMap[cat].realizado += b.amount_paid ?? b.amount ?? 0;
      }

      const catRows: CatRow[] = Object.entries(catMap)
        .map(([cat, vals]) => ({
          category: cat,
          estimado: vals.estimado,
          realizado: vals.realizado,
          color: CATEGORY_COLOR[cat] ?? DEFAULT_COLOR,
        }))
        .sort((a, b) => b.estimado - a.estimado);

      setCats(catRows);
    } catch (e) {
      console.error('VisaoGeralFinanceira load error:', e);
    }
    setLoading(false);
  }, [startStr, endStr]);

  useEffect(() => { load(); }, [load]);

  // ── Navegar mês ────────────────────────────────────────────
  const prevMonth = () => setViewDate(d => { const n = new Date(d); n.setMonth(n.getMonth() - 1); return n; });
  const nextMonth = () => setViewDate(d => { const n = new Date(d); n.setMonth(n.getMonth() + 1); return n; });

  // ── Dados para gráficos ────────────────────────────────────
  const barData = [
    { name: 'Receitas',  Estimado: recEst,  Realizado: recReal  },
    { name: 'Despesas',  Estimado: despEst, Realizado: despReal },
  ];

  const pieData = cats
    .filter(c => c.estimado > 0)
    .map(c => ({
      name:  CATEGORY_LABEL[c.category] ?? c.category,
      value: c.estimado,
      color: c.color,
    }));

  const saldoEst  = recEst  - despEst;
  const saldoReal = recReal - despReal;

  // ── Skeleton ───────────────────────────────────────────────
  if (loading) {
    return (
      <div className="space-y-4 animate-pulse">
        <div className="h-10 bg-slate-100 rounded-xl w-64" />
        <div className="grid grid-cols-12 gap-4">
          <div className="col-span-12 lg:col-span-8 h-72 bg-slate-100 rounded-xl" />
          <div className="col-span-12 lg:col-span-4 h-72 bg-slate-100 rounded-xl" />
        </div>
        <div className="grid grid-cols-12 gap-4">
          <div className="col-span-12 lg:col-span-5 h-60 bg-slate-100 rounded-xl" />
          <div className="col-span-12 lg:col-span-7 h-60 bg-slate-100 rounded-xl" />
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-4 animate-in fade-in duration-300">

      {/* ── Header + navegação ──────────────────────────────── */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <h2 className="text-base font-bold text-slate-900">Visão Geral Financeira</h2>
          <span className="text-xs text-slate-400">{monthYear}</span>
        </div>
        <div className="flex items-center gap-1">
          <button
            onClick={prevMonth}
            className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-500 hover:text-slate-800 transition-colors"
          >
            <ChevronLeft size={16} />
          </button>
          <span className="min-w-[80px] text-center text-xs font-semibold text-slate-700">
            {monthLabel}
          </span>
          <button
            onClick={nextMonth}
            className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-500 hover:text-slate-800 transition-colors"
          >
            <ChevronRight size={16} />
          </button>
          <button
            onClick={load}
            className="ml-1 p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 hover:text-indigo-600 transition-colors"
            title="Recarregar"
          >
            <RefreshCw size={14} />
          </button>
        </div>
      </div>

      {/* ── Layout principal: gráfico + painel direito ──────── */}
      <div className="grid grid-cols-12 gap-4">

        {/* Coluna esquerda: BarChart */}
        <div className="col-span-12 lg:col-span-8">
          <div className="bg-white rounded-xl border border-slate-100 shadow-sm p-4">
            <p className="text-xs font-bold text-slate-500 uppercase tracking-wider mb-4">
              Estimado vs Realizado
            </p>
            <ResponsiveContainer width="100%" height={240}>
              <BarChart data={barData} barGap={4} barCategoryGap="32%">
                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#f1f5f9" />
                <XAxis
                  dataKey="name"
                  tick={{ fontSize: 11, fontWeight: 600, fill: '#64748b' }}
                  axisLine={false}
                  tickLine={false}
                />
                <YAxis
                  tickFormatter={v => v >= 1000 ? `R$${(v/1000).toFixed(0)}k` : `R$${v}`}
                  tick={{ fontSize: 10, fill: '#94a3b8' }}
                  axisLine={false}
                  tickLine={false}
                  width={54}
                />
                <Tooltip content={<CustomTooltip />} />
                <Legend
                  wrapperStyle={{ fontSize: 11, fontWeight: 600, paddingTop: 8 }}
                  formatter={(value) => (
                    <span style={{ color: '#475569' }}>{value}</span>
                  )}
                />
                <Bar dataKey="Estimado" fill="#c7d2fe" radius={[4, 4, 0, 0]} maxBarSize={48} />
                <Bar dataKey="Realizado" fill="#6366f1" radius={[4, 4, 0, 0]} maxBarSize={48} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Coluna direita: resumo */}
        <div className="col-span-12 lg:col-span-4">
          <div className="bg-white rounded-xl border border-slate-100 shadow-sm p-4 h-full flex flex-col gap-3">
            <p className="text-xs font-bold text-slate-500 uppercase tracking-wider">Resumo</p>

            {/* Tabela Estimado / Realizado */}
            <div className="rounded-lg overflow-hidden border border-slate-100">
              <table className="w-full text-xs">
                <thead>
                  <tr className="bg-slate-50 text-[10px] font-bold uppercase tracking-wide text-slate-400">
                    <th className="text-left px-3 py-2">Item</th>
                    <th className="text-right px-3 py-2">Estimado</th>
                    <th className="text-right px-3 py-2">Realizado</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-50">
                  <tr className="hover:bg-slate-50">
                    <td className="px-3 py-2.5 font-semibold text-emerald-700 flex items-center gap-1.5">
                      <TrendingUp size={11} className="text-emerald-500" /> Receitas
                    </td>
                    <td className="px-3 py-2.5 text-right tabular-nums text-slate-500">{fmt(recEst)}</td>
                    <td className="px-3 py-2.5 text-right tabular-nums font-bold text-emerald-600">{fmt(recReal)}</td>
                  </tr>
                  <tr className="hover:bg-slate-50">
                    <td className="px-3 py-2.5 font-semibold text-rose-700">
                      <span className="flex items-center gap-1.5">
                        <TrendingDown size={11} className="text-rose-500" /> Despesas
                      </span>
                    </td>
                    <td className="px-3 py-2.5 text-right tabular-nums text-slate-500">{fmt(despEst)}</td>
                    <td className="px-3 py-2.5 text-right tabular-nums font-bold text-rose-600">{fmt(despReal)}</td>
                  </tr>
                  <tr className="bg-slate-50">
                    <td className="px-3 py-2.5 font-bold text-slate-700">
                      <span className="flex items-center gap-1.5">
                        <Minus size={11} className="text-slate-400" /> Saldo
                      </span>
                    </td>
                    <td className={`px-3 py-2.5 text-right tabular-nums font-bold ${saldoEst >= 0 ? 'text-emerald-600' : 'text-rose-600'}`}>
                      {fmt(saldoEst)}
                    </td>
                    <td className={`px-3 py-2.5 text-right tabular-nums font-bold ${saldoReal >= 0 ? 'text-emerald-600' : 'text-rose-600'}`}>
                      {fmt(saldoReal)}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            {/* Indicador de saúde financeira */}
            {(recReal > 0 || despReal > 0) && (
              <div className={`rounded-lg px-3 py-2 text-xs font-semibold border ${
                saldoReal >= 0
                  ? 'bg-emerald-50 text-emerald-700 border-emerald-100'
                  : 'bg-rose-50 text-rose-700 border-rose-100'
              }`}>
                {saldoReal >= 0
                  ? `✓ Margem realizada: ${recReal > 0 ? Math.round((saldoReal / recReal) * 100) : 0}%`
                  : `⚠ Despesas ${fmt(Math.abs(saldoReal))} acima das receitas`
                }
              </div>
            )}

            {/* Progresso do mês */}
            {despEst > 0 && (
              <div className="space-y-1">
                <div className="flex justify-between text-[10px] font-semibold text-slate-400">
                  <span>Despesas pagas</span>
                  <span>{pct(despReal, despEst)}% do previsto</span>
                </div>
                <div className="h-1.5 bg-slate-100 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-rose-400 rounded-full transition-all duration-500"
                    style={{ width: `${pct(despReal, despEst)}%` }}
                  />
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* ── Segunda linha: Donut + Categorias ───────────────── */}
      <div className="grid grid-cols-12 gap-4">

        {/* Donut: despesas por categoria */}
        <div className="col-span-12 lg:col-span-5">
          <div className="bg-white rounded-xl border border-slate-100 shadow-sm p-4">
            <p className="text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">
              Despesas por Categoria
            </p>
            {pieData.length === 0 ? (
              <div className="flex items-center justify-center h-[200px] text-xs text-slate-400">
                Sem despesas neste mês
              </div>
            ) : (
              <div className="flex items-center gap-4">
                <div className="shrink-0">
                  <PieChart width={160} height={160}>
                    <Pie
                      data={pieData}
                      cx={75}
                      cy={75}
                      innerRadius={48}
                      outerRadius={72}
                      paddingAngle={2}
                      dataKey="value"
                      strokeWidth={0}
                    >
                      {pieData.map((entry, i) => (
                        <Cell key={i} fill={entry.color} />
                      ))}
                    </Pie>
                    <Tooltip
                      formatter={(v: any) => fmt(v)}
                      contentStyle={{ fontSize: 11, borderRadius: 8, border: '1px solid #e2e8f0' }}
                    />
                  </PieChart>
                </div>
                <div className="flex-1 space-y-1.5 min-w-0">
                  {pieData.map((d, i) => (
                    <div key={i} className="flex items-center gap-2 text-xs">
                      <span
                        className="inline-block w-2 h-2 rounded-full shrink-0"
                        style={{ background: d.color }}
                      />
                      <span className="text-slate-600 truncate flex-1">{d.name}</span>
                      <span className="font-semibold text-slate-700 tabular-nums shrink-0">
                        {fmt(d.value)}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Lista de categorias com barras de progresso */}
        <div className="col-span-12 lg:col-span-7">
          <div className="bg-white rounded-xl border border-slate-100 shadow-sm p-4">
            <div className="flex items-center justify-between mb-3">
              <p className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                Execução por Categoria
              </p>
              <div className="flex items-center gap-3 text-[10px] font-semibold text-slate-400">
                <span className="flex items-center gap-1"><span className="inline-block w-2 h-2 rounded bg-slate-200" /> Estimado</span>
                <span className="flex items-center gap-1"><span className="inline-block w-2 h-2 rounded bg-indigo-500" /> Realizado</span>
              </div>
            </div>

            {cats.length === 0 ? (
              <div className="flex items-center justify-center h-40 text-xs text-slate-400">
                Sem despesas neste mês
              </div>
            ) : (
              <div className="space-y-3.5">
                {cats.map(c => {
                  const p = pct(c.realizado, c.estimado);
                  const catLabel = CATEGORY_LABEL[c.category] ?? c.category;
                  return (
                    <div key={c.category}>
                      <div className="flex items-center justify-between text-xs mb-1">
                        <div className="flex items-center gap-2">
                          <span
                            className="inline-block w-2 h-2 rounded-full"
                            style={{ background: c.color }}
                          />
                          <span className="font-semibold text-slate-700">{catLabel}</span>
                        </div>
                        <div className="flex items-center gap-3 tabular-nums">
                          <span className="text-slate-400 text-[10px]">{fmt(c.estimado)}</span>
                          <span className="font-bold text-slate-800">{fmt(c.realizado)}</span>
                          <span className={`text-[10px] font-bold px-1.5 py-0.5 rounded-full ${
                            p >= 100 ? 'bg-rose-100 text-rose-600' :
                            p >= 75  ? 'bg-amber-100 text-amber-600' :
                                       'bg-slate-100 text-slate-500'
                          }`}>
                            {p}%
                          </span>
                        </div>
                      </div>
                      <div className="h-1.5 bg-slate-100 rounded-full overflow-hidden">
                        <div
                          className="h-full rounded-full transition-all duration-500"
                          style={{ width: `${p}%`, background: c.color, opacity: p >= 100 ? 1 : 0.75 }}
                        />
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default VisaoGeralFinanceira;
