import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw, AlertTriangle, CheckCircle2 } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface AppointmentRow {
  id: string;
  patient_id: string;
  professional_id: string | null;
  date_time: string;
  duration_minutes: number;
  status: string;
}

interface PatientRow { id: string; name: string; phone: string; }
interface ProfRow    { id: string; name: string; color: string; }

type PeriodKey = 'mes' | 'trimestre' | 'ano';
const MONTHS   = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
const COMPLETED = ['completed', 'confirmed', 'confirmado'];
const NO_SHOW   = ['no_show', 'noshow', 'faltou'];
const CANCELLED = ['cancelled', 'cancelado'];

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
const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const AVG_TICKET = 300; // estimativa de perda por no-show

export default function NoShow({ onBack }: { onBack: () => void }) {
  const [appointments, setAppointments] = useState<AppointmentRow[]>([]);
  const [patients, setPatients]         = useState<PatientRow[]>([]);
  const [professionals, setProfessionals] = useState<ProfRow[]>([]);
  const [loading, setLoading]           = useState(true);
  const [period, setPeriod]             = useState<PeriodKey>('mes');

  useEffect(() => {
    Promise.all([
      supabase.from('appointments').select('id,patient_id,professional_id,date_time,duration_minutes,status'),
      supabase.from('patients').select('id,name,phone'),
      supabase.from('professionals').select('id,name,color'),
    ]).then(([aRes, pRes, profRes]) => {
      setAppointments((aRes.data ?? []) as AppointmentRow[]);
      setPatients((pRes.data ?? []) as PatientRow[]);
      setProfessionals((profRes.data ?? []) as ProfRow[]);
      setLoading(false);
    });
  }, []);

  const { start, end } = useMemo(() => getPeriod(period), [period]);

  const periodAppts = useMemo(() =>
    appointments.filter(a => a.date_time && (() => { const dt = new Date(a.date_time); return dt >= start && dt <= end; })()),
  [appointments, start, end]);

  const stats = useMemo(() => {
    const total     = periodAppts.length;
    const completed = periodAppts.filter(a => COMPLETED.includes((a.status ?? '').toLowerCase())).length;
    const noShow    = periodAppts.filter(a => NO_SHOW.includes((a.status ?? '').toLowerCase())).length;
    const cancelled = periodAppts.filter(a => CANCELLED.includes((a.status ?? '').toLowerCase())).length;
    const noShowRate = total > 0 ? (noShow / total) * 100 : 0;
    const lostRevenue = noShow * AVG_TICKET;

    // No-show por profissional
    const byProf = professionals.map(prof => {
      const profAppts = periodAppts.filter(a => a.professional_id === prof.id);
      const profNS    = profAppts.filter(a => NO_SHOW.includes((a.status ?? '').toLowerCase())).length;
      return { prof, total: profAppts.length, noShow: profNS, rate: profAppts.length > 0 ? (profNS / profAppts.length) * 100 : 0 };
    }).filter(r => r.total > 0).sort((a, b) => b.rate - a.rate);

    // Dias da semana com mais no-show
    const byDay = Array(7).fill(0);
    periodAppts.filter(a => NO_SHOW.includes((a.status ?? '').toLowerCase()))
      .forEach(a => { if (a.date_time) byDay[new Date(a.date_time).getDay()]++; });

    // Pacientes recorrentes de no-show
    const patientNS = new Map<string, number>();
    periodAppts.filter(a => NO_SHOW.includes((a.status ?? '').toLowerCase()))
      .forEach(a => patientNS.set(a.patient_id, (patientNS.get(a.patient_id) ?? 0) + 1));
    const topPatients = Array.from(patientNS.entries())
      .map(([id, count]) => ({ patient: patients.find(p => p.id === id), count }))
      .filter(r => r.patient && r.count >= 2)
      .sort((a, b) => b.count - a.count)
      .slice(0, 5);

    return { total, completed, noShow, cancelled, noShowRate, lostRevenue, byProf, byDay, topPatients };
  }, [periodAppts, professionals, patients]);

  const DAYS = ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb'];
  const maxDay = Math.max(...stats.byDay, 1);

  const handleExport = () => {
    const rows = [
      ['Taxa de No-Show — SintesIA'], [`Período: ${periodLabel(period)}`], [],
      ['Métrica', 'Valor'],
      ['Total agendado', String(stats.total)],
      ['Realizados', String(stats.completed)],
      ['No-Show', String(stats.noShow)],
      ['Cancelados', String(stats.cancelled)],
      ['Taxa no-show (%)', stats.noShowRate.toFixed(1)],
      ['Receita estimada perdida (R$)', stats.lostRevenue.toFixed(2)],
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = `NoShow_${periodLabel(period)}.csv`; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Taxa de No-Show</h1>
          <p className="text-xs text-slate-500">Cancelamentos e não comparecimentos — {periodLabel(period)}</p>
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

      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
        <div className="bg-white border border-slate-200 rounded-xl p-4">
          <p className="text-xs text-slate-500">Taxa de No-Show</p>
          <p className={`text-xl font-bold ${stats.noShowRate <= 10 ? 'text-emerald-600' : stats.noShowRate <= 20 ? 'text-amber-600' : 'text-rose-500'}`}>{stats.noShowRate.toFixed(1)}%</p>
          <p className="text-xs text-slate-400">{stats.noShow} de {stats.total}</p>
        </div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-4">
          <p className="text-xs text-rose-600">No-Shows</p>
          <p className="text-xl font-bold text-rose-700">{stats.noShow}</p>
        </div>
        <div className="bg-amber-50 border border-amber-100 rounded-xl p-4">
          <p className="text-xs text-amber-600">Cancelados</p>
          <p className="text-xl font-bold text-amber-700">{stats.cancelled}</p>
        </div>
        <div className="bg-slate-50 border border-slate-200 rounded-xl p-4">
          <p className="text-xs text-slate-500">Receita estimada perdida</p>
          <p className="text-base font-bold text-slate-700 tabular-nums">{fmt(stats.lostRevenue)}</p>
          <p className="text-[10px] text-slate-400">ticket médio estimado: {fmt(AVG_TICKET)}</p>
        </div>
      </div>

      {loading ? <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div> : (
        <>
          {/* Por profissional */}
          {stats.byProf.length > 0 && (
            <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
              <p className="text-sm font-semibold text-slate-700">No-Show por Profissional</p>
              {stats.byProf.map(r => (
                <div key={r.prof.id} className="flex items-center gap-3">
                  <span className="text-xs text-slate-600 w-28 shrink-0 truncate">{r.prof.name}</span>
                  <div className="flex-1 h-2 bg-slate-100 rounded-full overflow-hidden">
                    <div className="h-full bg-rose-400 rounded-full" style={{ width: `${r.rate}%` }} />
                  </div>
                  <span className={`text-xs font-bold w-10 text-right ${r.rate <= 10 ? 'text-emerald-600' : r.rate <= 20 ? 'text-amber-600' : 'text-rose-500'}`}>{r.rate.toFixed(0)}%</span>
                  <span className="text-xs text-slate-400 w-16 text-right">{r.noShow}/{r.total}</span>
                </div>
              ))}
            </div>
          )}

          {/* Por dia da semana */}
          <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
            <p className="text-sm font-semibold text-slate-700">No-Show por Dia da Semana</p>
            <div className="flex items-end gap-2 h-20">
              {stats.byDay.map((count, i) => (
                <div key={i} className="flex-1 flex flex-col items-center gap-1">
                  <span className="text-[10px] text-slate-500">{count > 0 ? count : ''}</span>
                  <div className="w-full bg-slate-100 rounded-t" style={{ height: `${Math.max(4, (count / maxDay) * 56)}px` }}>
                    <div className="w-full h-full bg-rose-400 rounded-t" />
                  </div>
                  <span className="text-[10px] text-slate-400">{DAYS[i]}</span>
                </div>
              ))}
            </div>
          </div>

          {/* Pacientes recorrentes */}
          {stats.topPatients.length > 0 && (
            <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
              <p className="text-sm font-semibold text-slate-700 flex items-center gap-2">
                <AlertTriangle className="w-4 h-4 text-amber-500" />
                Pacientes com No-Show Recorrente
              </p>
              {stats.topPatients.map(({ patient, count }) => (
                <div key={patient!.id} className="flex items-center justify-between py-1.5 border-b border-slate-50 last:border-0">
                  <div>
                    <p className="text-sm font-medium text-slate-700">{patient!.name}</p>
                    <p className="text-xs text-slate-400">{patient!.phone}</p>
                  </div>
                  <span className="text-xs font-bold text-rose-600 bg-rose-50 border border-rose-200 rounded-full px-2 py-0.5">{count}x no-show</span>
                </div>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}
