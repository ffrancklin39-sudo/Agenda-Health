import React, { useState, useEffect, useMemo } from 'react';
import {
  ArrowLeft, Download, RefreshCw, Users, ChevronDown,
  ChevronUp, CheckCircle2, Clock, AlertCircle,
} from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

// ─── Tipos ────────────────────────────────────────────────────

interface PatientRow {
  id: string;
  name: string;
  price: number;
  status: string;
  appointment_date: string | null;
  service_id: string | null;
  professional_id: string | null;
}

interface ProfessionalRow {
  id: string;
  name: string;
  specialty: string;
  color: string;
}

interface PricingRow {
  service_id: string;
  tax_percentage: number;
  commission_percentage: number;
  fee_pix: number;
}

interface ServiceRow {
  id: string;
  name: string;
}

interface ProfCommission {
  professional: ProfessionalRow;
  count: number;
  grossRevenue: number;
  netRevenue: number;
  commissionDue: number;
  commissionPaid: number;   // placeholder — futuramente via tabela payments
  items: CommissionItem[];
}

interface CommissionItem {
  patientName: string;
  date: string;
  serviceName: string;
  grossPrice: number;
  netRevenue: number;
  commissionPct: number;
  commissionAmount: number;
}

type PeriodKey = 'mes' | 'trimestre' | 'ano' | 'custom';
const MONTHS = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
const CONFIRMED = ['confirmed','confirmado','pago','completed'];
const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number) => `${v.toFixed(1)}%`;

function getPeriodRange(period: PeriodKey, customStart: string, customEnd: string) {
  const now = new Date(); const y = now.getFullYear(), m = now.getMonth();
  switch (period) {
    case 'mes':       return { start: new Date(y, m, 1),     end: new Date(y, m + 1, 0, 23, 59, 59) };
    case 'trimestre': return { start: new Date(y, m - 2, 1), end: new Date(y, m + 1, 0, 23, 59, 59) };
    case 'ano':       return { start: new Date(y, 0, 1),     end: new Date(y, 11, 31, 23, 59, 59) };
    default: return {
      start: customStart ? new Date(customStart) : new Date(y, m, 1),
      end:   customEnd   ? new Date(customEnd + 'T23:59:59') : new Date(y, m + 1, 0, 23, 59, 59),
    };
  }
}

function periodLabel(period: PeriodKey, cs: string, ce: string) {
  const now = new Date();
  if (period === 'mes')       return `${MONTHS[now.getMonth()]}/${now.getFullYear()}`;
  if (period === 'trimestre') return 'Último trimestre';
  if (period === 'ano')       return `Ano ${now.getFullYear()}`;
  if (cs && ce) return `${cs.split('-').reverse().join('/')} a ${ce.split('-').reverse().join('/')}`;
  return 'Personalizado';
}

const COLORS: Record<string, string> = {
  blue:    'bg-blue-500',
  purple:  'bg-purple-500',
  emerald: 'bg-emerald-500',
  rose:    'bg-rose-500',
  amber:   'bg-amber-500',
  indigo:  'bg-indigo-500',
  sky:     'bg-sky-500',
};

// ─── Componente principal ─────────────────────────────────────

interface Props { onBack: () => void }

const CommissionsReport: React.FC<Props> = ({ onBack }) => {
  const [period, setPeriod]           = useState<PeriodKey>('mes');
  const [customStart, setCustomStart] = useState('');
  const [customEnd, setCustomEnd]     = useState('');
  const [patients, setPatients]       = useState<PatientRow[]>([]);
  const [professionals, setProfessionals] = useState<ProfessionalRow[]>([]);
  const [pricing, setPricing]         = useState<PricingRow[]>([]);
  const [services, setServices]       = useState<ServiceRow[]>([]);
  const [loading, setLoading]         = useState(true);
  const [expanded, setExpanded]       = useState<string | null>(null);

  useEffect(() => {
    Promise.all([
      supabase.from('patients').select('id,name,price,status,appointment_date,service_id,professional_id'),
      supabase.from('professionals').select('id,name,specialty,color').eq('active', true),
      supabase.from('procedures_pricing').select('service_id,tax_percentage,commission_percentage,fee_pix'),
      supabase.from('services').select('id,name'),
    ]).then(([pRes, profRes, prRes, sRes]) => {
      setPatients((pRes.data ?? []) as PatientRow[]);
      setProfessionals((profRes.data ?? []) as ProfessionalRow[]);
      setPricing((prRes.data ?? []) as PricingRow[]);
      setServices((sRes.data ?? []) as ServiceRow[]);
      setLoading(false);
    });
  }, []);

  const { start, end } = useMemo(() => getPeriodRange(period, customStart, customEnd), [period, customStart, customEnd]);

  const commissions = useMemo((): ProfCommission[] => {
    const inPeriod = (d: string | null) => {
      if (!d) return false;
      const dt = new Date(d);
      return dt >= start && dt <= end;
    };

    const attended = patients.filter(p =>
      CONFIRMED.includes((p.status ?? '').toLowerCase()) && inPeriod(p.appointment_date)
    );

    return professionals.map(prof => {
      const profPatients = attended.filter(p => p.professional_id === prof.id);

      const items: CommissionItem[] = profPatients.map(p => {
        const pr      = pricing.find(x => x.service_id === p.service_id);
        const svc     = services.find(s => s.id === p.service_id);
        const price   = p.price ?? 0;
        const taxPct  = pr?.tax_percentage ?? 6;
        const feePct  = pr?.fee_pix ?? 0;
        const commPct = pr?.commission_percentage ?? 40;
        const tax     = price * (taxPct / 100);
        const fee     = price * (feePct / 100);
        const net     = price - tax - fee;
        const comm    = net * (commPct / 100);
        return {
          patientName:     p.name ?? '—',
          date:            p.appointment_date?.slice(0, 10) ?? '—',
          serviceName:     svc?.name ?? 'Serviço não identificado',
          grossPrice:      price,
          netRevenue:      net,
          commissionPct:   commPct,
          commissionAmount: comm,
        };
      });

      const grossRevenue  = items.reduce((s, i) => s + i.grossPrice, 0);
      const netRevenue    = items.reduce((s, i) => s + i.netRevenue, 0);
      const commissionDue = items.reduce((s, i) => s + i.commissionAmount, 0);

      return {
        professional:   prof,
        count:          items.length,
        grossRevenue,
        netRevenue,
        commissionDue,
        commissionPaid: 0, // implementar quando tabela de pagamentos de comissão existir
        items: items.sort((a, b) => b.date.localeCompare(a.date)),
      };
    }).filter(p => p.count > 0)
      .sort((a, b) => b.commissionDue - a.commissionDue);
  }, [patients, professionals, pricing, services, start, end]);

  const totals = useMemo(() => ({
    count:      commissions.reduce((s, c) => s + c.count, 0),
    gross:      commissions.reduce((s, c) => s + c.grossRevenue, 0),
    commission: commissions.reduce((s, c) => s + c.commissionDue, 0),
  }), [commissions]);

  const handleExport = () => {
    const rows: string[][] = [
      ['Relatório de Comissões — SintesIA'],
      [`Período: ${periodLabel(period, customStart, customEnd)}`],
      [],
      ['Profissional', 'Atendimentos', 'Receita Bruta (R$)', 'Receita Líquida (R$)', 'Comissão Devida (R$)'],
      ...commissions.map(c => [
        c.professional.name,
        String(c.count),
        c.grossRevenue.toFixed(2),
        c.netRevenue.toFixed(2),
        c.commissionDue.toFixed(2),
      ]),
      [],
      ['TOTAL', String(totals.count), totals.gross.toFixed(2), '', totals.commission.toFixed(2)],
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = `Comissoes_${periodLabel(period, customStart, customEnd).replace(/\//g, '-')}.csv`;
    a.click();
  };

  return (
    <div className="flex flex-col gap-5">

      {/* Header */}
      <div className="flex items-center gap-3 flex-wrap">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 hover:text-slate-700 transition-colors">
          <ArrowLeft className="w-4 h-4" />
        </button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Comissões por Profissional</h1>
          <p className="text-xs text-slate-500">{periodLabel(period, customStart, customEnd)} · comissão calculada sobre receita líquida</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 hover:text-indigo-600 border border-slate-200 hover:border-indigo-300 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      {/* Filtro período */}
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

      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-6 h-6 text-indigo-400 animate-spin" /></div>
      ) : commissions.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 gap-3">
          <Users className="w-10 h-10 text-slate-300" />
          <p className="text-slate-500 text-sm">Nenhum atendimento com profissional vinculado neste período.</p>
        </div>
      ) : (
        <>
          {/* KPIs de totais */}
          <div className="grid grid-cols-3 gap-3">
            <div className="bg-white border border-slate-200 rounded-xl p-4">
              <p className="text-xs text-slate-500">Atendimentos</p>
              <p className="text-xl font-bold text-slate-800">{totals.count}</p>
            </div>
            <div className="bg-white border border-slate-200 rounded-xl p-4">
              <p className="text-xs text-slate-500">Receita Bruta Total</p>
              <p className="text-xl font-bold text-slate-800 tabular-nums">{fmt(totals.gross)}</p>
            </div>
            <div className="bg-white border border-slate-200 rounded-xl p-4">
              <p className="text-xs text-slate-500">Total de Comissões</p>
              <p className="text-xl font-bold text-rose-500 tabular-nums">{fmt(totals.commission)}</p>
              <p className="text-xs text-slate-400">{totals.gross > 0 ? fmtPct(totals.commission / totals.gross * 100) : '—'} da receita bruta</p>
            </div>
          </div>

          {/* Cards por profissional */}
          <div className="flex flex-col gap-3">
            {commissions.map(c => {
              const colorClass = COLORS[c.professional.color] ?? 'bg-slate-500';
              const isExpanded = expanded === c.professional.id;
              const commPct = c.grossRevenue > 0 ? c.commissionDue / c.grossRevenue * 100 : 0;

              return (
                <div key={c.professional.id} className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
                  {/* Cabeçalho do profissional */}
                  <button
                    onClick={() => setExpanded(isExpanded ? null : c.professional.id)}
                    className="w-full flex items-center gap-4 px-5 py-4 hover:bg-slate-50 transition-colors"
                  >
                    {/* Avatar colorido */}
                    <div className={`w-9 h-9 rounded-xl ${colorClass} flex items-center justify-center text-white font-bold text-sm shrink-0`}>
                      {c.professional.name.charAt(0).toUpperCase()}
                    </div>

                    <div className="flex-1 text-left min-w-0">
                      <p className="text-sm font-semibold text-slate-800 truncate">{c.professional.name}</p>
                      <p className="text-xs text-slate-500">{c.professional.specialty} · {c.count} atend.</p>
                    </div>

                    {/* Barra de comissão */}
                    <div className="hidden sm:flex flex-col gap-1 w-32">
                      <div className="w-full h-1.5 bg-slate-100 rounded-full overflow-hidden">
                        <div className="h-full bg-rose-400 rounded-full" style={{ width: `${Math.min(100, commPct * 2)}%` }} />
                      </div>
                      <span className="text-[10px] text-slate-400">{fmtPct(commPct)} da receita</span>
                    </div>

                    <div className="text-right shrink-0">
                      <p className="text-sm font-bold text-rose-500 tabular-nums">{fmt(c.commissionDue)}</p>
                      <p className="text-xs text-slate-400">a pagar</p>
                    </div>

                    <div className="flex items-center gap-1 shrink-0">
                      <span className="flex items-center gap-1 text-[10px] font-semibold text-amber-600 bg-amber-50 border border-amber-200 rounded-full px-2 py-0.5">
                        <Clock className="w-3 h-3" /> Pendente
                      </span>
                      {isExpanded ? <ChevronUp className="w-4 h-4 text-slate-400 ml-1" /> : <ChevronDown className="w-4 h-4 text-slate-400 ml-1" />}
                    </div>
                  </button>

                  {/* Detalhe por atendimento */}
                  {isExpanded && (
                    <div className="border-t border-slate-100">
                      <table className="w-full text-xs">
                        <thead>
                          <tr className="bg-slate-50 text-slate-400 uppercase text-[10px] tracking-wide">
                            <th className="text-left px-5 py-2 font-semibold">Paciente</th>
                            <th className="text-left px-3 py-2 font-semibold hidden sm:table-cell">Serviço</th>
                            <th className="text-left px-3 py-2 font-semibold">Data</th>
                            <th className="text-right px-3 py-2 font-semibold">Bruto</th>
                            <th className="text-right px-3 py-2 font-semibold">Líquido</th>
                            <th className="text-right px-5 py-2 font-semibold">Comissão</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-50">
                          {c.items.map((item, i) => (
                            <tr key={i} className="hover:bg-slate-50 transition-colors">
                              <td className="px-5 py-2.5 font-medium text-slate-700">{item.patientName}</td>
                              <td className="px-3 py-2.5 text-slate-500 hidden sm:table-cell max-w-[200px] truncate">{item.serviceName}</td>
                              <td className="px-3 py-2.5 text-slate-500 tabular-nums">
                                {item.date !== '—' ? item.date.split('-').reverse().join('/') : '—'}
                              </td>
                              <td className="px-3 py-2.5 text-right text-slate-600 tabular-nums">{fmt(item.grossPrice)}</td>
                              <td className="px-3 py-2.5 text-right text-amber-600 tabular-nums">{fmt(item.netRevenue)}</td>
                              <td className="px-5 py-2.5 text-right font-semibold text-rose-500 tabular-nums">
                                {fmt(item.commissionAmount)}
                                <span className="text-[10px] text-slate-400 ml-1">({fmtPct(item.commissionPct)})</span>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                        <tfoot>
                          <tr className="border-t-2 border-slate-200 bg-slate-50">
                            <td colSpan={3} className="px-5 py-2.5 text-xs font-bold text-slate-600">Total {c.professional.name}</td>
                            <td className="px-3 py-2.5 text-right font-bold text-slate-700 tabular-nums">{fmt(c.grossRevenue)}</td>
                            <td className="px-3 py-2.5 text-right font-bold text-amber-600 tabular-nums">{fmt(c.netRevenue)}</td>
                            <td className="px-5 py-2.5 text-right font-bold text-rose-500 tabular-nums">{fmt(c.commissionDue)}</td>
                          </tr>
                        </tfoot>
                      </table>
                    </div>
                  )}
                </div>
              );
            })}
          </div>

          {/* Aviso sobre pagamentos */}
          <div className="flex items-start gap-2 bg-slate-50 border border-slate-200 rounded-xl px-4 py-3">
            <AlertCircle className="w-4 h-4 text-slate-400 flex-shrink-0 mt-0.5" />
            <p className="text-xs text-slate-500">
              O status <strong>Pendente</strong> indica que não há registro de pagamento de comissão confirmado.
              Quando a tabela de pagamentos de comissão for implementada, este relatório exibirá automaticamente o que já foi pago.
            </p>
          </div>
        </>
      )}
    </div>
  );
};

export default CommissionsReport;
