import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw, Users, TrendingDown, TrendingUp, Clock } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface PatientRow {
  id: string;
  name: string;
  status: string;
  created_at: string | null;
  appointment_date: string | null;
}

interface PaymentRow {
  patient_id: string;
  payment_date: string;
  amount: number;
}

interface RetentionStats {
  patientId: string;
  name: string;
  visits: number;
  firstVisit: string;
  lastVisit: string;
  daysSinceLast: number;
  avgDaysBetween: number;
  totalRevenue: number;
  status: 'active' | 'at_risk' | 'churned';
}

const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const CONFIRMED = ['confirmed', 'confirmado', 'pago', 'completed'];

const STATUS_CONFIG = {
  active:   { label: 'Ativo',       color: 'text-emerald-600', bg: 'bg-emerald-50 border-emerald-200' },
  at_risk:  { label: 'Em risco',    color: 'text-amber-600',   bg: 'bg-amber-50 border-amber-200' },
  churned:  { label: 'Perdido',     color: 'text-rose-500',    bg: 'bg-rose-50 border-rose-200' },
};

export default function PatientRetention({ onBack }: { onBack: () => void }) {
  const [patients, setPatients] = useState<PatientRow[]>([]);
  const [payments, setPayments] = useState<PaymentRow[]>([]);
  const [loading, setLoading]   = useState(true);
  const [filter, setFilter]     = useState<'all' | 'active' | 'at_risk' | 'churned'>('all');
  const [search, setSearch]     = useState('');

  useEffect(() => {
    Promise.all([
      supabase.from('patients').select('id,name,status,created_at,appointment_date'),
      supabase.from('payments').select('patient_id,payment_date,amount').eq('status', 'paid').order('payment_date'),
    ]).then(([pRes, payRes]) => {
      setPatients((pRes.data ?? []) as PatientRow[]);
      setPayments((payRes.data ?? []) as PaymentRow[]);
      setLoading(false);
    });
  }, []);

  const stats = useMemo((): RetentionStats[] => {
    const now = new Date();

    // Agrupa pagamentos por paciente
    const byPatient = new Map<string, PaymentRow[]>();
    payments.forEach(p => {
      if (!byPatient.has(p.patient_id)) byPatient.set(p.patient_id, []);
      byPatient.get(p.patient_id)!.push(p);
    });

    // Pacientes confirmados (com ou sem pagamento registrado)
    const confirmed = patients.filter(p => CONFIRMED.includes((p.status ?? '').toLowerCase()));

    return confirmed.map(p => {
      const pays = byPatient.get(p.id) ?? [];
      const dates = [
        ...pays.map(pay => pay.payment_date),
        ...(p.appointment_date ? [p.appointment_date] : []),
      ].filter(Boolean).sort();

      const firstVisit = dates[0] ?? p.created_at ?? '';
      const lastVisit  = dates[dates.length - 1] ?? '';
      const visits     = Math.max(dates.length, 1);
      const daysSinceLast = lastVisit
        ? Math.floor((now.getTime() - new Date(lastVisit).getTime()) / 86400000)
        : 999;

      // Tempo médio entre visitas
      let avgDaysBetween = 0;
      if (dates.length > 1) {
        const gaps = dates.slice(1).map((d, i) =>
          (new Date(d).getTime() - new Date(dates[i]).getTime()) / 86400000
        );
        avgDaysBetween = gaps.reduce((s, g) => s + g, 0) / gaps.length;
      }

      const totalRevenue = pays.reduce((s, pay) => s + pay.amount, 0);

      const status: RetentionStats['status'] =
        daysSinceLast <= 60  ? 'active' :
        daysSinceLast <= 180 ? 'at_risk' : 'churned';

      return { patientId: p.id, name: p.name, visits, firstVisit, lastVisit, daysSinceLast, avgDaysBetween, totalRevenue, status };
    }).sort((a, b) => b.totalRevenue - a.totalRevenue);
  }, [patients, payments]);

  const filtered = useMemo(() => {
    let r = filter === 'all' ? stats : stats.filter(s => s.status === filter);
    if (search) r = r.filter(s => s.name.toLowerCase().includes(search.toLowerCase()));
    return r;
  }, [stats, filter, search]);

  const kpis = useMemo(() => {
    const active  = stats.filter(s => s.status === 'active').length;
    const at_risk = stats.filter(s => s.status === 'at_risk').length;
    const churned = stats.filter(s => s.status === 'churned').length;
    const total   = stats.length;
    const retentionRate = total > 0 ? ((active / total) * 100) : 0;
    const avgVisits = total > 0 ? stats.reduce((s, p) => s + p.visits, 0) / total : 0;
    return { active, at_risk, churned, total, retentionRate, avgVisits };
  }, [stats]);

  const handleExport = () => {
    const rows = [
      ['Retenção de Pacientes — SintesIA'],
      [],
      ['Paciente', 'Status', 'Visitas', 'Última visita', 'Dias desde última', 'Média entre visitas', 'Receita total'],
      ...filtered.map(s => [
        s.name, STATUS_CONFIG[s.status].label, String(s.visits),
        s.lastVisit ? new Date(s.lastVisit).toLocaleDateString('pt-BR') : '—',
        String(s.daysSinceLast),
        s.avgDaysBetween > 0 ? `${Math.round(s.avgDaysBetween)} dias` : '—',
        s.totalRevenue.toFixed(2),
      ]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'Retencao_Pacientes.csv'; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3 flex-wrap">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Retenção de Pacientes</h1>
          <p className="text-xs text-slate-500">Taxa de retorno e tempo médio entre consultas</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
        <div className="bg-white border border-slate-200 rounded-xl p-4">
          <p className="text-xs text-slate-500">Taxa de retenção</p>
          <p className={`text-xl font-bold ${kpis.retentionRate >= 60 ? 'text-emerald-600' : kpis.retentionRate >= 40 ? 'text-amber-600' : 'text-rose-500'}`}>
            {kpis.retentionRate.toFixed(1)}%
          </p>
          <p className="text-xs text-slate-400">{kpis.active} de {kpis.total} ativos</p>
        </div>
        <div className="bg-emerald-50 border border-emerald-100 rounded-xl p-4">
          <p className="text-xs text-emerald-600">Ativos (≤60 dias)</p>
          <p className="text-xl font-bold text-emerald-700">{kpis.active}</p>
        </div>
        <div className="bg-amber-50 border border-amber-100 rounded-xl p-4">
          <p className="text-xs text-amber-600">Em risco (61–180 dias)</p>
          <p className="text-xl font-bold text-amber-700">{kpis.at_risk}</p>
        </div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-4">
          <p className="text-xs text-rose-600">Perdidos (+180 dias)</p>
          <p className="text-xl font-bold text-rose-700">{kpis.churned}</p>
        </div>
      </div>

      {/* Filtros */}
      <div className="flex items-center gap-2 flex-wrap">
        {(['all','active','at_risk','churned'] as const).map(f => (
          <button key={f} onClick={() => setFilter(f)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${filter === f ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            {{ all: 'Todos', active: 'Ativos', at_risk: 'Em risco', churned: 'Perdidos' }[f]}
          </button>
        ))}
        <input value={search} onChange={e => setSearch(e.target.value)} placeholder="Buscar paciente..."
          className="ml-auto text-xs border border-slate-200 rounded-xl px-3 py-1.5 outline-none focus:border-indigo-400 w-44" />
      </div>

      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div>
      ) : (
        <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
          <div className="grid grid-cols-[1fr_90px_70px_100px_80px_90px] gap-2 px-4 py-2.5 bg-slate-50 border-b border-slate-100 text-[10px] font-bold text-slate-400 uppercase tracking-wide">
            <span>Paciente</span><span className="text-center">Status</span><span className="text-center">Visitas</span>
            <span className="text-right">Última visita</span><span className="text-right">Intervalo</span><span className="text-right">Receita</span>
          </div>
          <div className="divide-y divide-slate-50">
            {filtered.map(s => {
              const cfg = STATUS_CONFIG[s.status];
              return (
                <div key={s.patientId} className="grid grid-cols-[1fr_90px_70px_100px_80px_90px] gap-2 px-4 py-3 hover:bg-slate-50 transition-colors items-center">
                  <span className="text-sm font-medium text-slate-700 truncate">{s.name}</span>
                  <span className={`text-[10px] font-bold border rounded-full px-2 py-0.5 text-center ${cfg.bg} ${cfg.color}`}>{cfg.label}</span>
                  <span className="text-sm text-slate-500 text-center">{s.visits}x</span>
                  <span className="text-xs text-slate-500 text-right tabular-nums">
                    {s.lastVisit ? new Date(s.lastVisit).toLocaleDateString('pt-BR') : '—'}
                  </span>
                  <span className="text-xs text-slate-500 text-right">
                    {s.avgDaysBetween > 0 ? `${Math.round(s.avgDaysBetween)}d` : '—'}
                  </span>
                  <span className="text-xs font-medium text-indigo-600 text-right tabular-nums">{fmt(s.totalRevenue)}</span>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
