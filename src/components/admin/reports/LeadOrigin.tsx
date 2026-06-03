import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface PatientRow { id: string; source: string | null; status: string; price: number; created_at: string | null; }

const CONFIRMED = ['confirmed', 'confirmado', 'pago', 'completed'];
const DISCARDED = ['discarded', 'perdido', 'lead frio'];
const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });

function normalizeSource(s: string | null): string {
  if (!s) return 'Não informado';
  const lower = s.toLowerCase();
  if (lower.includes('meta') || lower.includes('instagram') || lower.includes('facebook')) return 'Meta (Instagram/Facebook)';
  if (lower.includes('google')) return 'Google';
  if (lower.includes('indicação') || lower.includes('indicacao') || lower.includes('indica')) return 'Indicação';
  if (lower.includes('whatsapp') || lower.includes('zap')) return 'WhatsApp';
  if (lower.includes('site') || lower.includes('web')) return 'Site';
  return s.charAt(0).toUpperCase() + s.slice(1);
}

const CHANNEL_COLORS: Record<string, string> = {
  'Meta (Instagram/Facebook)': 'bg-blue-500',
  'Google':       'bg-red-500',
  'Indicação':    'bg-emerald-500',
  'WhatsApp':     'bg-green-400',
  'Site':         'bg-purple-500',
  'Não informado':'bg-slate-300',
};

export default function LeadOrigin({ onBack }: { onBack: () => void }) {
  const [patients, setPatients] = useState<PatientRow[]>([]);
  const [loading, setLoading]   = useState(true);

  useEffect(() => {
    supabase.from('patients').select('id,source,status,price,created_at')
      .then(({ data }) => { setPatients((data ?? []) as PatientRow[]); setLoading(false); });
  }, []);

  const channelStats = useMemo(() => {
    const map = new Map<string, { leads: number; confirmed: number; discarded: number; revenue: number }>();
    patients.forEach(p => {
      const channel = normalizeSource(p.source);
      if (!map.has(channel)) map.set(channel, { leads: 0, confirmed: 0, discarded: 0, revenue: 0 });
      const entry = map.get(channel)!;
      entry.leads++;
      if (CONFIRMED.includes((p.status ?? '').toLowerCase())) { entry.confirmed++; entry.revenue += p.price ?? 0; }
      if (DISCARDED.includes((p.status ?? '').toLowerCase())) entry.discarded++;
    });

    return Array.from(map.entries()).map(([channel, stats]) => ({
      channel,
      ...stats,
      conversionRate: stats.leads > 0 ? (stats.confirmed / stats.leads) * 100 : 0,
      avgTicket: stats.confirmed > 0 ? stats.revenue / stats.confirmed : 0,
      color: CHANNEL_COLORS[channel] ?? 'bg-indigo-400',
    })).sort((a, b) => b.revenue - a.revenue);
  }, [patients]);

  const totals = useMemo(() => ({
    leads: channelStats.reduce((s, c) => s + c.leads, 0),
    confirmed: channelStats.reduce((s, c) => s + c.confirmed, 0),
    revenue: channelStats.reduce((s, c) => s + c.revenue, 0),
  }), [channelStats]);

  const maxRevenue = useMemo(() => Math.max(...channelStats.map(c => c.revenue), 1), [channelStats]);

  const handleExport = () => {
    const rows = [
      ['Origem dos Leads — SintesIA'], [],
      ['Canal', 'Leads', 'Convertidos', 'Taxa conversão (%)', 'Receita gerada (R$)', 'Ticket médio (R$)'],
      ...channelStats.map(c => [c.channel, String(c.leads), String(c.confirmed), c.conversionRate.toFixed(1), c.revenue.toFixed(2), c.avgTicket.toFixed(2)]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'Origem_Leads.csv'; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Origem dos Leads</h1>
          <p className="text-xs text-slate-500">Performance e conversão por canal de aquisição</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      <div className="grid grid-cols-3 gap-3">
        <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Total de leads</p><p className="text-xl font-bold text-slate-800">{totals.leads}</p></div>
        <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Convertidos</p><p className="text-xl font-bold text-emerald-600">{totals.confirmed}</p><p className="text-xs text-slate-400">{totals.leads > 0 ? ((totals.confirmed/totals.leads)*100).toFixed(1) : 0}% de conversão geral</p></div>
        <div className="bg-white border border-slate-200 rounded-xl p-4"><p className="text-xs text-slate-500">Receita gerada</p><p className="text-xl font-bold text-indigo-600 tabular-nums">{fmt(totals.revenue)}</p></div>
      </div>

      {loading ? <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div> : (
        <div className="flex flex-col gap-3">
          {channelStats.map(c => (
            <div key={c.channel} className="bg-white border border-slate-200 rounded-2xl p-4 flex flex-col gap-3">
              <div className="flex items-center gap-3">
                <div className={`w-3 h-8 rounded-full ${c.color} shrink-0`} />
                <div className="flex-1">
                  <p className="text-sm font-semibold text-slate-800">{c.channel}</p>
                  <p className="text-xs text-slate-400">{c.leads} leads · {c.confirmed} convertidos</p>
                </div>
                <div className="text-right">
                  <p className="text-sm font-bold text-indigo-600 tabular-nums">{fmt(c.revenue)}</p>
                  <p className="text-xs text-slate-400">ticket: {fmt(c.avgTicket)}</p>
                </div>
              </div>

              {/* Barra de conversão */}
              <div className="flex flex-col gap-1">
                <div className="flex justify-between text-[10px] text-slate-400">
                  <span>Taxa de conversão</span>
                  <span className={`font-bold ${c.conversionRate >= 40 ? 'text-emerald-600' : c.conversionRate >= 20 ? 'text-amber-600' : 'text-rose-500'}`}>
                    {c.conversionRate.toFixed(1)}%
                  </span>
                </div>
                <div className="w-full h-2 bg-slate-100 rounded-full overflow-hidden">
                  <div className={`h-full rounded-full ${c.color}`} style={{ width: `${c.conversionRate}%` }} />
                </div>
              </div>

              {/* Barra de receita relativa */}
              <div className="flex flex-col gap-1">
                <div className="flex justify-between text-[10px] text-slate-400">
                  <span>Participação na receita</span>
                  <span>{totals.revenue > 0 ? ((c.revenue/totals.revenue)*100).toFixed(1) : 0}%</span>
                </div>
                <div className="w-full h-2 bg-slate-100 rounded-full overflow-hidden">
                  <div className="h-full bg-indigo-400 rounded-full" style={{ width: `${(c.revenue/maxRevenue)*100}%` }} />
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
