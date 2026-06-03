import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw, TrendingUp, Award } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface PaymentRow { patient_id: string; patient_name: string; amount: number; real_profit: number | null; payment_date: string; }
interface PatientRow { id: string; name: string; price: number; status: string; appointment_date: string | null; created_at: string | null; }

interface LTVRecord {
  patientId: string;
  name: string;
  visits: number;
  totalRevenue: number;
  totalProfit: number;
  firstDate: string;
  lastDate: string;
  tenureMonths: number;
  monthlyAvgRevenue: number;
  projectedLTV12m: number;
}

const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const CONFIRMED = ['confirmed', 'confirmado', 'pago', 'completed'];

type SortKey = 'totalRevenue' | 'totalProfit' | 'projectedLTV12m' | 'visits';

export default function LTV({ onBack }: { onBack: () => void }) {
  const [payments, setPayments] = useState<PaymentRow[]>([]);
  const [patients, setPatients] = useState<PatientRow[]>([]);
  const [loading, setLoading]   = useState(true);
  const [sortKey, setSortKey]   = useState<SortKey>('totalRevenue');
  const [search, setSearch]     = useState('');

  useEffect(() => {
    Promise.all([
      supabase.from('vw_payments_full').select('patient_id,patient_name,amount,real_profit,payment_date').eq('status', 'paid'),
      supabase.from('patients').select('id,name,price,status,appointment_date,created_at'),
    ]).then(([payRes, patRes]) => {
      setPayments((payRes.data ?? []) as PaymentRow[]);
      setPatients((patRes.data ?? []) as PatientRow[]);
      setLoading(false);
    });
  }, []);

  const records = useMemo((): LTVRecord[] => {
    const now = new Date();
    const byPatient = new Map<string, PaymentRow[]>();
    payments.forEach(p => {
      if (!byPatient.has(p.patient_id)) byPatient.set(p.patient_id, []);
      byPatient.get(p.patient_id)!.push(p);
    });

    const confirmed = patients.filter(p => CONFIRMED.includes((p.status ?? '').toLowerCase()));

    return confirmed.map(p => {
      const pays = byPatient.get(p.id) ?? [];
      const totalRevenue = pays.length > 0
        ? pays.reduce((s, pay) => s + pay.amount, 0)
        : (p.price ?? 0);
      const totalProfit = pays.reduce((s, pay) => s + (pay.real_profit ?? 0), 0);
      const visits = Math.max(pays.length, p.price ? 1 : 0);

      const dates = pays.map(pay => pay.payment_date).filter(Boolean).sort();
      const firstDate = dates[0] ?? p.created_at ?? p.appointment_date ?? '';
      const lastDate  = dates[dates.length - 1] ?? p.appointment_date ?? '';

      const tenureMonths = firstDate
        ? Math.max(1, (now.getTime() - new Date(firstDate).getTime()) / (1000 * 60 * 60 * 24 * 30))
        : 1;
      const monthlyAvgRevenue = totalRevenue / tenureMonths;
      const projectedLTV12m   = monthlyAvgRevenue * 12;

      return { patientId: p.id, name: p.name, visits, totalRevenue, totalProfit, firstDate, lastDate, tenureMonths, monthlyAvgRevenue, projectedLTV12m };
    }).filter(r => r.totalRevenue > 0);
  }, [payments, patients]);

  const sorted = useMemo(() => {
    let r = search ? records.filter(r => r.name.toLowerCase().includes(search.toLowerCase())) : records;
    return r.sort((a, b) => b[sortKey] - a[sortKey]);
  }, [records, sortKey, search]);

  const kpis = useMemo(() => {
    if (!sorted.length) return null;
    const avgLTV = sorted.reduce((s, r) => s + r.totalRevenue, 0) / sorted.length;
    const top10  = sorted.slice(0, 10).reduce((s, r) => s + r.totalRevenue, 0);
    const total  = sorted.reduce((s, r) => s + r.totalRevenue, 0);
    const avgVisits = sorted.reduce((s, r) => s + r.visits, 0) / sorted.length;
    return { avgLTV, top10, total, avgVisits };
  }, [sorted]);

  const maxRevenue = useMemo(() => Math.max(...sorted.map(r => r.totalRevenue), 1), [sorted]);

  const handleExport = () => {
    const rows = [
      ['LTV por Paciente — SintesIA'], [],
      ['#', 'Paciente', 'Visitas', 'Receita total', 'Lucro gerado', 'Tenure (meses)', 'Receita/mês', 'LTV proj. 12m'],
      ...sorted.map((r, i) => [
        String(i+1), r.name, String(r.visits), r.totalRevenue.toFixed(2), r.totalProfit.toFixed(2),
        r.tenureMonths.toFixed(1), r.monthlyAvgRevenue.toFixed(2), r.projectedLTV12m.toFixed(2),
      ]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'LTV_Pacientes.csv'; a.click();
  };

  const SortBtn = ({ k, label }: { k: SortKey; label: string }) => (
    <button onClick={() => setSortKey(k)}
      className={`text-[10px] font-bold uppercase tracking-wide transition-colors ${sortKey === k ? 'text-indigo-600' : 'text-slate-400 hover:text-slate-600'}`}>
      {label}{sortKey === k ? ' ↓' : ''}
    </button>
  );

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3 flex-wrap">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">LTV por Paciente</h1>
          <p className="text-xs text-slate-500">Valor total gerado por cada paciente ao longo do tempo</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      {kpis && (
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">LTV médio</p><p className="text-xl font-bold text-indigo-600 tabular-nums">{fmt(kpis.avgLTV)}</p></div>
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Receita total</p><p className="text-xl font-bold text-emerald-600 tabular-nums">{fmt(kpis.total)}</p></div>
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Top 10 pacientes</p><p className="text-xl font-bold text-amber-600 tabular-nums">{fmt(kpis.top10)}</p><p className="text-xs text-slate-400">{kpis.total > 0 ? ((kpis.top10/kpis.total)*100).toFixed(0) : 0}% da receita</p></div>
          <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Visitas médias</p><p className="text-xl font-bold text-slate-800">{kpis.avgVisits.toFixed(1)}x</p></div>
        </div>
      )}

      <div className="flex items-center gap-2">
        {(['totalRevenue','totalProfit','projectedLTV12m','visits'] as SortKey[]).map(k => (
          <SortBtn key={k} k={k} label={{ totalRevenue: 'Receita', totalProfit: 'Lucro', projectedLTV12m: 'LTV 12m', visits: 'Visitas' }[k]} />
        ))}
        <input value={search} onChange={e => setSearch(e.target.value)} placeholder="Buscar..." className="ml-auto text-xs border border-slate-200 rounded-xl px-3 py-1.5 outline-none focus:border-indigo-400 w-40" />
      </div>

      {loading ? <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div> : (
        <div className="flex flex-col gap-2">
          {sorted.map((r, i) => (
            <div key={r.patientId} className="bg-white border border-slate-200 rounded-xl px-4 py-3 flex items-center gap-3">
              <span className={`w-7 h-7 flex items-center justify-center rounded-lg text-xs font-bold shrink-0 ${i === 0 ? 'bg-amber-100 text-amber-600' : i === 1 ? 'bg-slate-100 text-slate-500' : i === 2 ? 'bg-orange-100 text-orange-500' : 'text-slate-400'}`}>{i+1}</span>
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 flex-wrap">
                  <p className="text-sm font-semibold text-slate-800 truncate">{r.name}</p>
                  <span className="text-[10px] text-slate-400">{r.visits}x · {r.tenureMonths.toFixed(0)} meses</span>
                </div>
                <div className="w-full h-1.5 bg-slate-100 rounded-full mt-1 overflow-hidden">
                  <div className="h-full bg-indigo-400 rounded-full" style={{ width: `${(r.totalRevenue / maxRevenue) * 100}%` }} />
                </div>
              </div>
              <div className="text-right shrink-0">
                <p className="text-sm font-bold text-indigo-600 tabular-nums">{fmt(r.totalRevenue)}</p>
                <p className="text-[10px] text-slate-400">proj. 12m: {fmt(r.projectedLTV12m)}</p>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
