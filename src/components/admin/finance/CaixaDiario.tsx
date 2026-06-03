import React, { useState, useEffect, useMemo } from 'react';
import { RefreshCw, TrendingUp, TrendingDown, Minus } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface CashEntry {
  id: string;
  date: string;
  flow_type: 'income' | 'expense';
  description: string;
  counterpart: string;
  gross_amount: number;
  payment_method: string;
  category: string;
  status: string;
}

interface DayBalance {
  day: string;
  label: string;
  income: number;
  expense: number;
  balance: number;
  entries: CashEntry[];
}

const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const DAYS_PT = ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb'];
const MONTHS_PT = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];

type RangeKey = 'today' | 'week' | 'month';

export default function CaixaDiario() {
  const [entries, setEntries]   = useState<CashEntry[]>([]);
  const [loading, setLoading]   = useState(true);
  const [range, setRange]       = useState<RangeKey>('week');
  const [expanded, setExpanded] = useState<string | null>(null);

  const now = new Date();

  const { start, end } = useMemo(() => {
    const y = now.getFullYear(), m = now.getMonth(), d = now.getDate();
    if (range === 'today') return { start: new Date(y, m, d, 0, 0, 0), end: new Date(y, m, d, 23, 59, 59) };
    if (range === 'week')  return { start: new Date(y, m, d - 6, 0, 0, 0), end: new Date(y, m, d, 23, 59, 59) };
    return                        { start: new Date(y, m, 1), end: new Date(y, m+1, 0, 23, 59, 59) };
  }, [range]);

  useEffect(() => {
    setLoading(true);
    supabase.from('vw_cash_flow')
      .select('id,date,flow_type,description,counterpart,gross_amount,payment_method,category,status')
      .gte('date', start.toISOString())
      .lte('date', end.toISOString())
      .order('date', { ascending: false })
      .then(({ data }) => {
        setEntries((data ?? []) as CashEntry[]);
        setLoading(false);
      });
  }, [range]);

  const byDay = useMemo((): DayBalance[] => {
    const map = new Map<string, DayBalance>();
    entries.forEach(e => {
      const d   = new Date(e.date);
      const key = d.toISOString().slice(0, 10);
      if (!map.has(key)) {
        const dayOfWeek = DAYS_PT[d.getDay()];
        const dayNum    = d.getDate();
        const month     = MONTHS_PT[d.getMonth()];
        map.set(key, { day: key, label: `${dayOfWeek}, ${dayNum} ${month}`, income: 0, expense: 0, balance: 0, entries: [] });
      }
      const day = map.get(key)!;
      day.entries.push(e);
      if (e.flow_type === 'income')  day.income  += e.gross_amount;
      if (e.flow_type === 'expense') day.expense += e.gross_amount;
    });
    return Array.from(map.values())
      .map(d => ({ ...d, balance: d.income - d.expense }))
      .sort((a, b) => b.day.localeCompare(a.day));
  }, [entries]);

  const totals = useMemo(() => ({
    income:  entries.filter(e => e.flow_type === 'income').reduce((s, e) => s + e.gross_amount, 0),
    expense: entries.filter(e => e.flow_type === 'expense').reduce((s, e) => s + e.gross_amount, 0),
    balance: entries.reduce((s, e) => s + (e.flow_type === 'income' ? e.gross_amount : -e.gross_amount), 0),
  }), [entries]);

  const METHOD_LABELS: Record<string, string> = {
    pix: 'PIX', debit: 'Débito', credit_1x: 'Crédito 1x', credit_2_6x: 'Créd. 2-6x',
    credit_7x_plus: 'Créd. 7x+', cash: 'Dinheiro', transfer: 'Transf.', check: 'Cheque',
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3 flex-wrap">
        <div className="flex-1">
          <h2 className="text-base font-bold text-slate-800">Caixa</h2>
          <p className="text-xs text-slate-400">Entradas e saídas consolidadas</p>
        </div>
        <div className="flex gap-1.5">
          {(['today','week','month'] as RangeKey[]).map(r => (
            <button key={r} onClick={() => setRange(r)}
              className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${range === r ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
              {{ today: 'Hoje', week: '7 dias', month: 'Mês' }[r]}
            </button>
          ))}
        </div>
      </div>

      {/* Saldo do período */}
      <div className="grid grid-cols-3 gap-3">
        <div className="bg-emerald-50 border border-emerald-100 rounded-xl p-4 flex items-center gap-3">
          <div className="p-2 bg-emerald-100 rounded-lg"><TrendingUp className="w-4 h-4 text-emerald-600" /></div>
          <div><p className="text-[10px] text-emerald-600 font-semibold uppercase">Entradas</p><p className="text-base font-bold text-emerald-700 tabular-nums">{fmt(totals.income)}</p></div>
        </div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-4 flex items-center gap-3">
          <div className="p-2 bg-rose-100 rounded-lg"><TrendingDown className="w-4 h-4 text-rose-600" /></div>
          <div><p className="text-[10px] text-rose-600 font-semibold uppercase">Saídas</p><p className="text-base font-bold text-rose-700 tabular-nums">{fmt(totals.expense)}</p></div>
        </div>
        <div className={`border rounded-xl p-4 flex items-center gap-3 ${totals.balance >= 0 ? 'bg-indigo-50 border-indigo-100' : 'bg-amber-50 border-amber-100'}`}>
          <div className={`p-2 rounded-lg ${totals.balance >= 0 ? 'bg-indigo-100' : 'bg-amber-100'}`}>
            <Minus className={`w-4 h-4 ${totals.balance >= 0 ? 'text-indigo-600' : 'text-amber-600'}`} />
          </div>
          <div>
            <p className={`text-[10px] font-semibold uppercase ${totals.balance >= 0 ? 'text-indigo-600' : 'text-amber-600'}`}>Saldo</p>
            <p className={`text-base font-bold tabular-nums ${totals.balance >= 0 ? 'text-indigo-700' : 'text-amber-700'}`}>{fmt(totals.balance)}</p>
          </div>
        </div>
      </div>

      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div>
      ) : byDay.length === 0 ? (
        <div className="flex flex-col items-center py-16 gap-2 text-center">
          <p className="text-slate-400 text-sm">Nenhum movimento no período.</p>
          <p className="text-xs text-slate-400">Registre pagamentos recebidos e despesas pagas para ver o caixa.</p>
        </div>
      ) : (
        <div className="flex flex-col gap-3">
          {byDay.map(day => (
            <div key={day.day} className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
              {/* Header do dia */}
              <button
                onClick={() => setExpanded(e => e === day.day ? null : day.day)}
                className="w-full flex items-center gap-3 px-4 py-3 hover:bg-slate-50 transition-colors"
              >
                <div className="flex-1 text-left">
                  <p className="text-sm font-semibold text-slate-800">{day.label}</p>
                  <p className="text-xs text-slate-400">{day.entries.length} lançamento{day.entries.length !== 1 ? 's' : ''}</p>
                </div>
                <div className="flex items-center gap-4">
                  <span className="text-xs text-emerald-600 tabular-nums">+{fmt(day.income)}</span>
                  <span className="text-xs text-rose-500 tabular-nums">-{fmt(day.expense)}</span>
                  <span className={`text-sm font-bold tabular-nums ${day.balance >= 0 ? 'text-indigo-600' : 'text-amber-600'}`}>{fmt(day.balance)}</span>
                </div>
              </button>

              {/* Lançamentos do dia */}
              {expanded === day.day && (
                <div className="border-t border-slate-100 divide-y divide-slate-50">
                  {day.entries.map(e => (
                    <div key={e.id} className="flex items-center gap-3 px-4 py-2.5">
                      <div className={`w-1.5 h-6 rounded-full shrink-0 ${e.flow_type === 'income' ? 'bg-emerald-400' : 'bg-rose-400'}`} />
                      <div className="flex-1 min-w-0">
                        <p className="text-xs font-medium text-slate-700 truncate">{e.description}</p>
                        <p className="text-[10px] text-slate-400">{e.counterpart} · {METHOD_LABELS[e.payment_method] ?? e.payment_method}</p>
                      </div>
                      <span className={`text-xs font-semibold tabular-nums ${e.flow_type === 'income' ? 'text-emerald-600' : 'text-rose-500'}`}>
                        {e.flow_type === 'income' ? '+' : '-'}{fmt(e.gross_amount)}
                      </span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
