import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw, Calendar } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface AppointmentRow {
  id: string;
  professional_id: string | null;
  service_id: string | null;
  date_time: string;
  duration_minutes: number;
  status: string;
}

interface ProfessionalRow { id: string; name: string; color: string; }

type PeriodKey = 'mes' | 'trimestre' | 'ano';
const MONTHS = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
const DAYS   = ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb'];
const COMPLETED = ['completed', 'confirmed', 'confirmado'];
const CANCELLED = ['cancelled', 'cancelado', 'no_show'];

function getPeriod(period: PeriodKey) {
  const now = new Date(); const y = now.getFullYear(), m = now.getMonth();
  if (period === 'mes')       return { start: new Date(y, m, 1),     end: new Date(y, m+1, 0, 23, 59) };
  if (period === 'trimestre') return { start: new Date(y, m-2, 1),   end: new Date(y, m+1, 0, 23, 59) };
  return                             { start: new Date(y, 0, 1),     end: new Date(y, 11, 31, 23, 59) };
}

function periodLabel(p: PeriodKey) {
  const now = new Date();
  if (p === 'mes') return `${MONTHS[now.getMonth()]}/${now.getFullYear()}`;
  if (p === 'trimestre') return 'Último trimestre';
  return `Ano ${now.getFullYear()}`;
}

const COLORS: Record<string, string> = { blue:'bg-blue-500', purple:'bg-purple-500', emerald:'bg-emerald-500', rose:'bg-rose-500', amber:'bg-amber-500', indigo:'bg-indigo-500' };

export default function AgendaOccupancy({ onBack }: { onBack: () => void }) {
  const [appointments, setAppointments] = useState<AppointmentRow[]>([]);
  const [professionals, setProfessionals] = useState<ProfessionalRow[]>([]);
  const [loading, setLoading]   = useState(true);
  const [period, setPeriod]     = useState<PeriodKey>('mes');

  useEffect(() => {
    Promise.all([
      supabase.from('appointments').select('id,professional_id,service_id,date_time,duration_minutes,status'),
      supabase.from('professionals').select('id,name,color'),
    ]).then(([aRes, pRes]) => {
      setAppointments((aRes.data ?? []) as AppointmentRow[]);
      setProfessionals((pRes.data ?? []) as ProfessionalRow[]);
      setLoading(false);
    });
  }, []);

  const { start, end } = useMemo(() => getPeriod(period), [period]);

  const inPeriod = (d: string) => { const dt = new Date(d); return dt >= start && dt <= end; };

  const periodAppts = useMemo(() =>
    appointments.filter(a => a.date_time && inPeriod(a.date_time)),
  [appointments, start, end]);

  // Por profissional
  const byProfessional = useMemo(() => {
    return professionals.map(prof => {
      const appts = periodAppts.filter(a => a.professional_id === prof.id);
      const completed = appts.filter(a => COMPLETED.includes((a.status ?? '').toLowerCase()));
      const cancelled = appts.filter(a => CANCELLED.includes((a.status ?? '').toLowerCase()));
      const totalMinutes = completed.reduce((s, a) => s + (a.duration_minutes ?? 30), 0);
      // Dias úteis no período
      const days = Math.ceil((end.getTime() - start.getTime()) / 86400000);
      const workDays = Math.round(days * 5 / 7);
      const availableMinutes = workDays * 8 * 60; // 8h/dia
      const occupancy = availableMinutes > 0 ? (totalMinutes / availableMinutes) * 100 : 0;
      return { prof, total: appts.length, completed: completed.length, cancelled: cancelled.length, totalMinutes, occupancy };
    }).filter(r => r.total > 0).sort((a, b) => b.occupancy - a.occupancy);
  }, [professionals, periodAppts, start, end]);

  // Por dia da semana
  const byDayOfWeek = useMemo(() => {
    const counts = Array(7).fill(0);
    periodAppts.forEach(a => { if (a.date_time) counts[new Date(a.date_time).getDay()]++; });
    const max = Math.max(...counts, 1);
    return counts.map((count, i) => ({ day: DAYS[i], count, pct: (count / max) * 100 }));
  }, [periodAppts]);

  // Por hora do dia
  const byHour = useMemo(() => {
    const counts: Record<number, number> = {};
    periodAppts.forEach(a => { if (a.date_time) { const h = new Date(a.date_time).getHours(); counts[h] = (counts[h] ?? 0) + 1; } });
    const max = Math.max(...Object.values(counts), 1);
    return Array.from({ length: 13 }, (_, i) => i + 7).map(h => ({
      hour: `${String(h).padStart(2,'0')}:00`, count: counts[h] ?? 0, pct: ((counts[h] ?? 0) / max) * 100,
    }));
  }, [periodAppts]);

  const totals = useMemo(() => ({
    total:     periodAppts.length,
    completed: periodAppts.filter(a => COMPLETED.includes((a.status ?? '').toLowerCase())).length,
    cancelled: periodAppts.filter(a => CANCELLED.includes((a.status ?? '').toLowerCase())).length,
  }), [periodAppts]);

  const handleExport = () => {
    const rows = [['Ocupação da Agenda — SintesIA'], [`Período: ${periodLabel(period)}`], [],
      ['Profissional', 'Total agendados', 'Realizados', 'Cancelados', 'Minutos trabalhados', 'Ocupação (%)'],
      ...byProfessional.map(r => [r.prof.name, String(r.total), String(r.completed), String(r.cancelled), String(r.totalMinutes), r.occupancy.toFixed(1)]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = `Ocupacao_Agenda_${periodLabel(period)}.csv`; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Ocupação da Agenda</h1>
          <p className="text-xs text-slate-500">{periodLabel(period)}</p>
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

      <div className="grid grid-cols-3 gap-3">
        <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Total agendado</p><p className="text-xl font-bold text-slate-800">{totals.total}</p></div>
        <div className="bg-emerald-50 border border-emerald-100 rounded-xl p-4"><p className="text-xs text-emerald-600">Realizados</p><p className="text-xl font-bold text-emerald-700">{totals.completed}</p></div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-4"><p className="text-xs text-rose-600">Cancelados</p><p className="text-xl font-bold text-rose-700">{totals.cancelled}</p></div>
      </div>

      {loading ? <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div> : (
        <>
          {/* Por profissional */}
          {byProfessional.length > 0 && (
            <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
              <p className="text-sm font-semibold text-slate-700">Ocupação por Profissional</p>
              {byProfessional.map(r => (
                <div key={r.prof.id} className="flex items-center gap-3">
                  <div className={`w-2 h-2 rounded-full shrink-0 ${COLORS[r.prof.color] ?? 'bg-slate-400'}`} />
                  <span className="text-xs text-slate-600 w-32 shrink-0 truncate">{r.prof.name}</span>
                  <div className="flex-1 h-2 bg-slate-100 rounded-full overflow-hidden">
                    <div className={`h-full rounded-full ${COLORS[r.prof.color] ?? 'bg-indigo-400'}`} style={{ width: `${Math.min(100, r.occupancy)}%` }} />
                  </div>
                  <span className={`text-xs font-bold w-10 text-right tabular-nums ${r.occupancy >= 60 ? 'text-emerald-600' : r.occupancy >= 30 ? 'text-amber-600' : 'text-rose-500'}`}>
                    {r.occupancy.toFixed(0)}%
                  </span>
                  <span className="text-xs text-slate-400 w-16 text-right">{r.completed} atend.</span>
                </div>
              ))}
            </div>
          )}

          {/* Por dia da semana */}
          <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
            <p className="text-sm font-semibold text-slate-700">Distribuição por Dia da Semana</p>
            <div className="flex items-end gap-2 h-24">
              {byDayOfWeek.map(({ day, count, pct }) => (
                <div key={day} className="flex-1 flex flex-col items-center gap-1">
                  <span className="text-[10px] text-slate-500 tabular-nums">{count}</span>
                  <div className="w-full bg-slate-100 rounded-t" style={{ height: `${Math.max(4, pct * 0.7)}px` }}>
                    <div className="w-full h-full bg-indigo-400 rounded-t" />
                  </div>
                  <span className="text-[10px] text-slate-400">{day}</span>
                </div>
              ))}
            </div>
          </div>

          {/* Por hora */}
          <div className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
            <p className="text-sm font-semibold text-slate-700">Horários de Pico</p>
            <div className="flex flex-col gap-1.5">
              {byHour.filter(h => h.count > 0).map(({ hour, count, pct }) => (
                <div key={hour} className="flex items-center gap-2">
                  <span className="text-[10px] text-slate-400 w-10 shrink-0">{hour}</span>
                  <div className="flex-1 h-2 bg-slate-100 rounded-full overflow-hidden">
                    <div className="h-full bg-purple-400 rounded-full" style={{ width: `${pct}%` }} />
                  </div>
                  <span className="text-[10px] text-slate-500 tabular-nums w-6 text-right">{count}</span>
                </div>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  );
}
