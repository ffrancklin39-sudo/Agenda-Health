import React, { useState, useEffect, useMemo } from 'react';
import { Download, RefreshCw, TrendingUp, TrendingDown, Search } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface CashEntry {
  id: string;
  date: string;
  flow_type: 'income' | 'expense';
  description: string;
  counterpart: string;
  gross_amount: number;
  net_amount: number | null;
  payment_method: string;
  category: string;
  status: string;
}

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtDate = (d: string | null) => d ? new Date(d).toLocaleDateString('pt-BR') : '—';

type PeriodKey  = 'mes' | 'trimestre' | 'ano' | 'custom';
type FlowFilter = 'all' | 'income' | 'expense';
const MONTHS = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];

const METHOD_LABELS: Record<string, string> = {
  pix: 'PIX', debit: 'Débito', credit_1x: 'Crédito 1x', credit_2_6x: 'Créd. 2-6x',
  credit_7x_plus: 'Créd. 7x+', cash: 'Dinheiro', transfer: 'Transf.', check: 'Cheque', '—': '—',
};

function getPeriod(period: PeriodKey, cs: string, ce: string) {
  const now = new Date(); const y = now.getFullYear(), m = now.getMonth();
  if (period === 'mes')       return { start: new Date(y, m, 1),     end: new Date(y, m+1, 0, 23, 59) };
  if (period === 'trimestre') return { start: new Date(y, m-2, 1),   end: new Date(y, m+1, 0, 23, 59) };
  if (period === 'ano')       return { start: new Date(y, 0, 1),     end: new Date(y, 11, 31, 23, 59) };
  return { start: cs ? new Date(cs) : new Date(y, m, 1), end: ce ? new Date(ce+'T23:59:59') : new Date(y, m+1, 0, 23, 59) };
}
function periodLabel(p: PeriodKey, cs: string, ce: string) {
  const now = new Date();
  if (p === 'mes') return `${MONTHS[now.getMonth()]}/${now.getFullYear()}`;
  if (p === 'trimestre') return 'Último trimestre';
  if (p === 'ano') return `Ano ${now.getFullYear()}`;
  return cs && ce ? `${cs.split('-').reverse().join('/')} a ${ce.split('-').reverse().join('/')}` : 'Personalizado';
}

export default function Lancamentos() {
  const [entries, setEntries]     = useState<CashEntry[]>([]);
  const [loading, setLoading]     = useState(true);
  const [period, setPeriod]       = useState<PeriodKey>('mes');
  const [customStart, setCS]      = useState('');
  const [customEnd, setCE]        = useState('');
  const [flowFilter, setFlow]     = useState<FlowFilter>('all');
  const [search, setSearch]       = useState('');
  const [page, setPage]           = useState(0);
  const PAGE_SIZE = 50;

  const { start, end } = useMemo(() => getPeriod(period, customStart, customEnd), [period, customStart, customEnd]);

  useEffect(() => {
    setLoading(true); setPage(0);
    supabase.from('vw_cash_flow')
      .select('id,date,flow_type,description,counterpart,gross_amount,net_amount,payment_method,category,status')
      .gte('date', start.toISOString())
      .lte('date', end.toISOString())
      .order('date', { ascending: false })
      .then(({ data }) => { setEntries((data ?? []) as CashEntry[]); setLoading(false); });
  }, [period, customStart, customEnd]);

  const filtered = useMemo(() => {
    let r = entries;
    if (flowFilter !== 'all') r = r.filter(e => e.flow_type === flowFilter);
    if (search) r = r.filter(e =>
      e.description.toLowerCase().includes(search.toLowerCase()) ||
      e.counterpart.toLowerCase().includes(search.toLowerCase())
    );
    return r;
  }, [entries, flowFilter, search]);

  const paginated = useMemo(() => filtered.slice(page * PAGE_SIZE, (page + 1) * PAGE_SIZE), [filtered, page]);
  const totalPages = Math.ceil(filtered.length / PAGE_SIZE);

  const totals = useMemo(() => ({
    income:  filtered.filter(e => e.flow_type === 'income').reduce((s, e) => s + e.gross_amount, 0),
    expense: filtered.filter(e => e.flow_type === 'expense').reduce((s, e) => s + e.gross_amount, 0),
    balance: filtered.reduce((s, e) => s + (e.flow_type === 'income' ? e.gross_amount : -e.gross_amount), 0),
  }), [filtered]);

  const handleExport = () => {
    const rows = [
      [`Lançamentos — SintesIA · ${periodLabel(period, customStart, customEnd)}`], [],
      ['Data', 'Tipo', 'Descrição', 'Contraparte', 'Valor (R$)', 'Método', 'Categoria'],
      ...filtered.map(e => [
        fmtDate(e.date),
        e.flow_type === 'income' ? 'Entrada' : 'Saída',
        e.description, e.counterpart,
        e.gross_amount.toFixed(2),
        METHOD_LABELS[e.payment_method] ?? e.payment_method,
        e.category,
      ]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = `Lancamentos_${periodLabel(period, customStart, customEnd)}.csv`; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3 flex-wrap">
        <div className="flex-1">
          <h2 className="text-base font-bold text-slate-800">Lançamentos</h2>
          <p className="text-xs text-slate-400">{filtered.length} transação{filtered.length !== 1 ? 'ões' : ''} · {periodLabel(period, customStart, customEnd)}</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> CSV
        </button>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-3 gap-3">
        <div className="bg-emerald-50 border border-emerald-100 rounded-xl p-3 flex items-center gap-2">
          <TrendingUp className="w-4 h-4 text-emerald-600 shrink-0" />
          <div><p className="text-[10px] text-emerald-600 font-semibold uppercase">Entradas</p><p className="text-base font-bold text-emerald-700 tabular-nums">{fmt(totals.income)}</p></div>
        </div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-3 flex items-center gap-2">
          <TrendingDown className="w-4 h-4 text-rose-600 shrink-0" />
          <div><p className="text-[10px] text-rose-600 font-semibold uppercase">Saídas</p><p className="text-base font-bold text-rose-700 tabular-nums">{fmt(totals.expense)}</p></div>
        </div>
        <div className={`border rounded-xl p-3 flex items-center gap-2 ${totals.balance >= 0 ? 'bg-indigo-50 border-indigo-100' : 'bg-amber-50 border-amber-100'}`}>
          <div><p className={`text-[10px] font-semibold uppercase ${totals.balance >= 0 ? 'text-indigo-600' : 'text-amber-600'}`}>Saldo</p><p className={`text-base font-bold tabular-nums ${totals.balance >= 0 ? 'text-indigo-700' : 'text-amber-700'}`}>{fmt(totals.balance)}</p></div>
        </div>
      </div>

      {/* Filtros */}
      <div className="flex items-center gap-2 flex-wrap">
        {(['mes','trimestre','ano','custom'] as PeriodKey[]).map(p => (
          <button key={p} onClick={() => setPeriod(p)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${period === p ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            {{ mes: 'Mês', trimestre: 'Trimestre', ano: 'Ano', custom: 'Personalizado' }[p]}
          </button>
        ))}
        {period === 'custom' && (
          <>
            <input type="date" value={customStart} onChange={e => setCS(e.target.value)} className="text-xs border border-slate-200 rounded-xl px-2 py-1.5 outline-none focus:border-indigo-400" />
            <span className="text-xs text-slate-400">até</span>
            <input type="date" value={customEnd} onChange={e => setCE(e.target.value)} className="text-xs border border-slate-200 rounded-xl px-2 py-1.5 outline-none focus:border-indigo-400" />
          </>
        )}
        <div className="flex gap-1 ml-2">
          {(['all','income','expense'] as FlowFilter[]).map(f => (
            <button key={f} onClick={() => setFlow(f)}
              className={`px-2.5 py-1 rounded-lg text-xs font-semibold transition-colors ${flowFilter === f ? 'bg-slate-700 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
              {{ all: 'Todos', income: 'Entradas', expense: 'Saídas' }[f]}
            </button>
          ))}
        </div>
        <div className="flex items-center gap-2 border border-slate-200 rounded-xl px-3 py-1.5 focus-within:border-indigo-400 transition-all ml-auto">
          <Search className="w-3.5 h-3.5 text-slate-400 shrink-0" />
          <input value={search} onChange={e => { setSearch(e.target.value); setPage(0); }} placeholder="Buscar..."
            className="text-xs outline-none bg-transparent w-32 text-slate-700 placeholder-slate-400" />
        </div>
      </div>

      {/* Tabela */}
      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div>
      ) : filtered.length === 0 ? (
        <div className="flex flex-col items-center py-16 gap-2">
          <p className="text-slate-400 text-sm">Nenhum lançamento no período.</p>
        </div>
      ) : (
        <>
          <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
            <div className="grid grid-cols-[90px_20px_1fr_90px_80px_80px] gap-2 px-4 py-2.5 bg-slate-50 border-b border-slate-100 text-[10px] font-bold text-slate-400 uppercase tracking-wide">
              <span>Data</span><span></span><span>Descrição</span><span className="text-right">Valor</span><span className="text-right">Método</span><span className="text-right">Tipo</span>
            </div>
            <div className="divide-y divide-slate-50">
              {paginated.map(e => (
                <div key={e.id} className="grid grid-cols-[90px_20px_1fr_90px_80px_80px] gap-2 px-4 py-3 hover:bg-slate-50 transition-colors items-center">
                  <span className="text-xs text-slate-500 tabular-nums">{fmtDate(e.date)}</span>
                  <div className={`w-1.5 h-5 rounded-full ${e.flow_type === 'income' ? 'bg-emerald-400' : 'bg-rose-400'}`} />
                  <div className="min-w-0">
                    <p className="text-sm font-medium text-slate-700 truncate">{e.description}</p>
                    <p className="text-[10px] text-slate-400 truncate">{e.counterpart}</p>
                  </div>
                  <span className={`text-sm font-semibold tabular-nums text-right ${e.flow_type === 'income' ? 'text-emerald-600' : 'text-rose-500'}`}>
                    {e.flow_type === 'income' ? '+' : '-'}{fmt(e.gross_amount)}
                  </span>
                  <span className="text-[10px] text-slate-400 text-right truncate">{METHOD_LABELS[e.payment_method] ?? e.payment_method}</span>
                  <span className={`text-[10px] font-bold rounded-full px-2 py-0.5 text-center ${e.flow_type === 'income' ? 'bg-emerald-50 text-emerald-700 border border-emerald-200' : 'bg-rose-50 text-rose-600 border border-rose-200'}`}>
                    {e.flow_type === 'income' ? 'Entrada' : 'Saída'}
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* Paginação */}
          {totalPages > 1 && (
            <div className="flex items-center justify-center gap-2">
              <button disabled={page === 0} onClick={() => setPage(p => p-1)}
                className="text-xs px-3 py-1.5 border border-slate-200 rounded-xl disabled:opacity-40 hover:bg-slate-50 transition-colors">← Anterior</button>
              <span className="text-xs text-slate-400">{page+1} / {totalPages}</span>
              <button disabled={page >= totalPages-1} onClick={() => setPage(p => p+1)}
                className="text-xs px-3 py-1.5 border border-slate-200 rounded-xl disabled:opacity-40 hover:bg-slate-50 transition-colors">Próxima →</button>
            </div>
          )}
        </>
      )}
    </div>
  );
}
