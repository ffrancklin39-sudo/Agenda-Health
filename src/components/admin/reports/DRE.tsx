import React, { useState, useEffect, useMemo } from 'react';
import {
  ArrowLeft, Download, RefreshCw,
  DollarSign, AlertCircle, ChevronDown, ChevronUp, Database,
} from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

// ─── Tipos ────────────────────────────────────────────────────

interface PaymentRow {
  amount: number;
  payment_date: string | null;
  tax_amount: number;
  payment_fee_amount: number;
  net_revenue: number;
  fixed_cost: number;
  commission_amount: number;
  real_profit: number;
  margin_pct: number;
  pricing_source: string;
}

interface PatientRow {
  id: string;
  price: number;
  status: string;
  appointment_date: string | null;
  service_id: string | null;
  professional_id: string | null;
}

interface PricingRow {
  service_id: string;
  tax_percentage: number;
  commission_percentage: number;
  fixed_cost: number;
  fee_pix: number;
  fee_debit: number;
  fee_credit_1x: number;
}

interface DRELine {
  label: string;
  value: number;
  indent?: boolean;
  bold?: boolean;
  separator?: boolean;
  color?: 'green' | 'red' | 'yellow' | 'default';
}

type PeriodKey = 'mes' | 'trimestre' | 'semestre' | 'ano' | 'custom';

const MONTHS = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];

const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number) => `${v.toFixed(1)}%`;

const CONFIRMED = ['confirmed', 'confirmado', 'pago', 'completed'];

// ─── Helpers ──────────────────────────────────────────────────

function getPeriodRange(period: PeriodKey, customStart: string, customEnd: string) {
  const now = new Date();
  const y = now.getFullYear(), m = now.getMonth();
  switch (period) {
    case 'mes':        return { start: new Date(y, m, 1),   end: new Date(y, m + 1, 0, 23, 59, 59) };
    case 'trimestre':  return { start: new Date(y, m - 2, 1), end: new Date(y, m + 1, 0, 23, 59, 59) };
    case 'semestre':   return { start: new Date(y, m - 5, 1), end: new Date(y, m + 1, 0, 23, 59, 59) };
    case 'ano':        return { start: new Date(y, 0, 1),   end: new Date(y, 11, 31, 23, 59, 59) };
    default: return {
      start: customStart ? new Date(customStart) : new Date(y, m, 1),
      end:   customEnd   ? new Date(customEnd + 'T23:59:59') : new Date(y, m + 1, 0, 23, 59, 59),
    };
  }
}

function periodLabel(period: PeriodKey, customStart: string, customEnd: string) {
  const now = new Date();
  if (period === 'mes')       return `${MONTHS[now.getMonth()]}/${now.getFullYear()}`;
  if (period === 'trimestre') return 'Último trimestre';
  if (period === 'semestre')  return 'Último semestre';
  if (period === 'ano')       return `Ano ${now.getFullYear()}`;
  if (customStart && customEnd)
    return `${customStart.split('-').reverse().join('/')} a ${customEnd.split('-').reverse().join('/')}`;
  return 'Período personalizado';
}

// ─── Sub-componentes ──────────────────────────────────────────

interface KpiProps { label: string; value: string; sub?: string; color?: string }
const Kpi: React.FC<KpiProps> = ({ label, value, sub, color = 'text-slate-800' }) => (
  <div className="bg-white border border-slate-200 rounded-xl p-4">
    <p className="text-xs text-slate-500 mb-1">{label}</p>
    <p className={`text-xl font-bold tabular-nums ${color}`}>{value}</p>
    {sub && <p className="text-xs text-slate-400 mt-0.5">{sub}</p>}
  </div>
);

interface DRERowProps { line: DRELine }
const DRERow: React.FC<DRERowProps> = ({ line }) => {
  if (line.separator) return <tr><td colSpan={3}><div className="border-t border-slate-200 my-1" /></td></tr>;
  const color = line.color === 'green'  ? 'text-emerald-600'
              : line.color === 'red'    ? 'text-rose-500'
              : line.color === 'yellow' ? 'text-amber-600'
              : 'text-slate-700';
  return (
    <tr className="hover:bg-slate-50 transition-colors">
      <td className={`py-2 pr-4 text-sm ${line.indent ? 'pl-6 text-slate-500' : line.bold ? 'font-semibold text-slate-800' : 'text-slate-700'}`}>
        {line.label}
      </td>
      <td className={`py-2 text-right text-sm tabular-nums ${line.bold ? 'font-bold' : ''} ${color}`}>
        {fmt(line.value)}
      </td>
      <td className="py-2 pl-4 text-right text-xs text-slate-400 tabular-nums w-16">
        {/* preenchido pelo componente pai */}
      </td>
    </tr>
  );
};

// ─── Componente principal ─────────────────────────────────────

interface Props { onBack: () => void }

const DRE: React.FC<Props> = ({ onBack }) => {
  const [period, setPeriod]           = useState<PeriodKey>('mes');
  const [customStart, setCustomStart] = useState('');
  const [customEnd, setCustomEnd]     = useState('');
  const [payments, setPayments]       = useState<PaymentRow[]>([]);
  const [patients, setPatients]       = useState<PatientRow[]>([]);
  const [pricing, setPricing]         = useState<PricingRow[]>([]);
  const [loading, setLoading]         = useState(true);
  const [showDetail, setShowDetail]   = useState(true);
  const [dataSource, setDataSource]   = useState<'payments' | 'patients'>('patients');

  useEffect(() => {
    Promise.all([
      supabase.from('payments').select('amount,payment_date,tax_amount,payment_fee_amount,net_revenue,fixed_cost,commission_amount,real_profit,margin_pct,pricing_source').eq('status', 'paid'),
      supabase.from('patients').select('id,price,status,appointment_date,service_id,professional_id'),
      supabase.from('procedures_pricing').select('service_id,tax_percentage,commission_percentage,fixed_cost,fee_pix,fee_debit,fee_credit_1x'),
    ]).then(([payRes, pRes, prRes]) => {
      const pays = (payRes.data ?? []) as PaymentRow[];
      setPayments(pays);
      setPatients((pRes.data ?? []) as PatientRow[]);
      setPricing((prRes.data ?? []) as PricingRow[]);
      // Usa payments se já houver dados reais
      setDataSource(pays.length > 0 ? 'payments' : 'patients');
      setLoading(false);
    });
  }, []);

  const { start, end } = useMemo(() => getPeriodRange(period, customStart, customEnd), [period, customStart, customEnd]);

  const dre = useMemo(() => {
    const inPeriod = (d: string | null) => {
      if (!d) return false;
      const dt = new Date(d);
      return dt >= start && dt <= end;
    };

    // ── Fonte 1: tabela payments (dados reais com método de pagamento) ──
    if (dataSource === 'payments' && payments.length > 0) {
      const inRange = payments.filter(p => inPeriod(p.payment_date));
      const count        = inRange.length;
      const grossRevenue = inRange.reduce((s, p) => s + p.amount, 0);
      const totalTax     = inRange.reduce((s, p) => s + (p.tax_amount ?? 0), 0);
      const totalPaymentFee = inRange.reduce((s, p) => s + (p.payment_fee_amount ?? 0), 0);
      const netRevenue   = inRange.reduce((s, p) => s + (p.net_revenue ?? 0), 0);
      const totalFixedCost  = inRange.reduce((s, p) => s + (p.fixed_cost ?? 0), 0);
      const totalCommission = inRange.reduce((s, p) => s + (p.commission_amount ?? 0), 0);
      const netProfit    = inRange.reduce((s, p) => s + (p.real_profit ?? 0), 0);
      const margin       = grossRevenue > 0 ? (netProfit / grossRevenue) * 100 : 0;
      const ticket       = count > 0 ? grossRevenue / count : 0;
      return { count, grossRevenue, totalTax, totalPaymentFee, netRevenue, totalFixedCost, totalCommission, netProfit: netProfit, margin, ticket };
    }

    // ── Fonte 2: fallback patients (sem método de pagamento real) ──
    const attended = patients.filter(p =>
      CONFIRMED.includes((p.status ?? '').toLowerCase()) && inPeriod(p.appointment_date)
    );

    const grossRevenue = attended.reduce((s, p) => s + (p.price ?? 0), 0);
    const count = attended.length;

    let totalTax        = 0;
    let totalPaymentFee = 0;
    let totalCommission = 0;
    let totalFixedCost  = 0;

    attended.forEach(p => {
      const pr = pricing.find(x => x.service_id === p.service_id);
      const price = p.price ?? 0;

      if (pr) {
        const tax        = price * (pr.tax_percentage / 100);
        const fee        = price * (pr.fee_pix / 100); // padrão PIX
        const net        = price - tax - fee;
        const commission = net * (pr.commission_percentage / 100);
        totalTax        += tax;
        totalPaymentFee += fee;
        totalCommission += commission;
        totalFixedCost  += pr.fixed_cost;
      } else {
        // sem precificação: estimativas conservadoras
        totalTax        += price * 0.06;
        totalCommission += price * 0.40 * 0.94; // 40% sobre líquido estimado
      }
    });

    const netRevenue  = grossRevenue - totalTax - totalPaymentFee;
    const grossProfit = netRevenue - totalFixedCost;
    const netProfit   = grossProfit - totalCommission;
    const margin      = grossRevenue > 0 ? (netProfit / grossRevenue) * 100 : 0;
    const ticket      = count > 0 ? grossRevenue / count : 0;

    return {
      count, grossRevenue, totalTax, totalPaymentFee, netRevenue,
      totalFixedCost, totalCommission, grossProfit, netProfit, margin, ticket,
    };
  }, [patients, pricing, start, end]);

  const lines: DRELine[] = [
    { label: '(+) Receita Bruta',              value: dre.grossRevenue,    bold: true, color: 'default' },
    { label: '(-) Impostos (ISS/DAS)',          value: -dre.totalTax,       indent: true, color: 'red' },
    { label: '(-) Taxas de Pagamento',          value: -dre.totalPaymentFee,indent: true, color: 'red' },
    { separator: true } as DRELine,
    { label: '(=) Receita Líquida',             value: dre.netRevenue,      bold: true, color: 'yellow' },
    { label: '(-) Custo de Insumos/Materiais',  value: -dre.totalFixedCost, indent: true, color: 'red' },
    { separator: true } as DRELine,
    { label: '(=) Lucro Bruto',                 value: dre.grossProfit,     bold: true, color: dre.grossProfit >= 0 ? 'green' : 'red' },
    { label: '(-) Comissões de Profissionais',  value: -dre.totalCommission,indent: true, color: 'red' },
    { separator: true } as DRELine,
    { label: '(=) Lucro Líquido da Clínica',    value: dre.netProfit,       bold: true, color: dre.netProfit >= 0 ? 'green' : 'red' },
  ];

  const handleExport = () => {
    const rows = [
      ['DRE Simplificado — SintesIA'],
      [`Período: ${periodLabel(period, customStart, customEnd)}`],
      [`Atendimentos: ${dre.count}`],
      [],
      ['Item', 'Valor (R$)'],
      ['Receita Bruta', dre.grossRevenue.toFixed(2)],
      ['(-) Impostos',  (-dre.totalTax).toFixed(2)],
      ['(-) Taxas de Pagamento', (-dre.totalPaymentFee).toFixed(2)],
      ['(=) Receita Líquida', dre.netRevenue.toFixed(2)],
      ['(-) Custo de Insumos', (-dre.totalFixedCost).toFixed(2)],
      ['(=) Lucro Bruto', dre.grossProfit.toFixed(2)],
      ['(-) Comissões', (-dre.totalCommission).toFixed(2)],
      ['(=) Lucro Líquido', dre.netProfit.toFixed(2)],
      ['Margem Líquida (%)', dre.margin.toFixed(1)],
      ['Ticket Médio', dre.ticket.toFixed(2)],
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = `DRE_${periodLabel(period, customStart, customEnd).replace(/\//g, '-')}.csv`;
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
          <h1 className="text-lg font-bold text-slate-800 flex items-center gap-2">
            DRE Simplificado
            <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full border ${
              dataSource === 'payments'
                ? 'bg-emerald-50 text-emerald-700 border-emerald-200'
                : 'bg-amber-50 text-amber-700 border-amber-200'
            }`}>
              {dataSource === 'payments' ? '✓ Dados reais' : '⚠ Estimativa'}
            </span>
          </h1>
          <p className="text-xs text-slate-500">Demonstrativo de Resultado — {periodLabel(period, customStart, customEnd)}</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 hover:text-indigo-600 border border-slate-200 hover:border-indigo-300 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      {/* Filtro de período */}
      <div className="flex items-center gap-2 flex-wrap">
        {(['mes','trimestre','semestre','ano','custom'] as PeriodKey[]).map(p => (
          <button
            key={p}
            onClick={() => setPeriod(p)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${
              period === p ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'
            }`}
          >
            {{ mes: 'Mês atual', trimestre: 'Trimestre', semestre: 'Semestre', ano: 'Ano', custom: 'Personalizado' }[p]}
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
      ) : (
        <>
          {/* KPIs */}
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
            <Kpi label="Receita Bruta"    value={fmt(dre.grossRevenue)} sub={`${dre.count} atendimentos`} />
            <Kpi label="Lucro Líquido"    value={fmt(dre.netProfit)}    color={dre.netProfit >= 0 ? 'text-emerald-600' : 'text-rose-500'} />
            <Kpi label="Margem Líquida"   value={fmtPct(dre.margin)}    color={dre.margin >= 20 ? 'text-emerald-600' : dre.margin >= 0 ? 'text-amber-600' : 'text-rose-500'} />
            <Kpi label="Ticket Médio"     value={fmt(dre.ticket)} />
          </div>

          {/* Aviso de dados sem precificação */}
          {patients.some(p => CONFIRMED.includes((p.status ?? '').toLowerCase()) && !pricing.find(x => x.service_id === p.service_id)) && (
            <div className="flex items-start gap-2 bg-amber-50 border border-amber-200 rounded-xl px-4 py-3">
              <AlertCircle className="w-4 h-4 text-amber-500 flex-shrink-0 mt-0.5" />
              <p className="text-xs text-amber-700">
                Alguns atendimentos não têm precificação cadastrada no módulo BI — impostos e comissões estimados com valores padrão (6% / 40%).
                <span className="font-semibold"> Cadastre a precificação em BI &amp; Margem para maior precisão.</span>
              </p>
            </div>
          )}

          {/* Tabela DRE */}
          <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
            <button
              onClick={() => setShowDetail(v => !v)}
              className="w-full flex items-center justify-between px-5 py-3 border-b border-slate-100 hover:bg-slate-50 transition-colors"
            >
              <span className="text-sm font-semibold text-slate-700">Demonstrativo Detalhado</span>
              {showDetail ? <ChevronUp className="w-4 h-4 text-slate-400" /> : <ChevronDown className="w-4 h-4 text-slate-400" />}
            </button>

            {showDetail && (
              <div className="px-5 py-2">
                <table className="w-full">
                  <tbody>
                    {lines.map((line, i) => (
                      line.separator
                        ? <tr key={i}><td colSpan={2}><div className="border-t border-slate-200 my-1" /></td></tr>
                        : (
                          <tr key={i} className="hover:bg-slate-50 transition-colors">
                            <td className={`py-2 pr-4 text-sm ${line.indent ? 'pl-6 text-slate-500' : line.bold ? 'font-semibold text-slate-800' : 'text-slate-700'}`}>
                              {line.label}
                            </td>
                            <td className={`py-2 text-right text-sm tabular-nums ${line.bold ? 'font-bold' : ''} ${
                              line.color === 'green'  ? 'text-emerald-600' :
                              line.color === 'red'    ? 'text-rose-500' :
                              line.color === 'yellow' ? 'text-amber-600' : 'text-slate-700'
                            }`}>
                              {fmt(line.value)}
                            </td>
                            <td className="py-2 pl-4 text-right text-xs text-slate-400 tabular-nums w-16">
                              {dre.grossRevenue > 0 ? fmtPct(Math.abs(line.value) / dre.grossRevenue * 100) : '—'}
                            </td>
                          </tr>
                        )
                    ))}
                  </tbody>
                </table>

                {/* Legenda % */}
                <p className="text-[10px] text-slate-400 text-right pb-3">% = proporção sobre receita bruta</p>
              </div>
            )}
          </div>

          {/* Gráfico de waterfall simplificado (barras horizontais) */}
          <div className="bg-white border border-slate-200 rounded-2xl p-5">
            <p className="text-sm font-semibold text-slate-700 mb-4">Decomposição da Receita</p>
            <div className="flex flex-col gap-2">
              {[
                { label: 'Receita Bruta',  value: dre.grossRevenue,    color: 'bg-indigo-500' },
                { label: 'Impostos',       value: dre.totalTax,        color: 'bg-rose-400' },
                { label: 'Taxas pagto.',   value: dre.totalPaymentFee, color: 'bg-orange-400' },
                { label: 'Insumos',        value: dre.totalFixedCost,  color: 'bg-amber-400' },
                { label: 'Comissões',      value: dre.totalCommission, color: 'bg-red-400' },
                { label: 'Lucro Líquido',  value: Math.max(0, dre.netProfit), color: 'bg-emerald-500' },
              ].map(({ label, value, color }) => (
                <div key={label} className="flex items-center gap-3">
                  <span className="text-xs text-slate-500 w-28 shrink-0 text-right">{label}</span>
                  <div className="flex-1 bg-slate-100 rounded-full h-5 overflow-hidden">
                    <div
                      className={`h-full rounded-full ${color} transition-all duration-500`}
                      style={{ width: dre.grossRevenue > 0 ? `${Math.min(100, value / dre.grossRevenue * 100)}%` : '0%' }}
                    />
                  </div>
                  <span className="text-xs font-medium text-slate-600 tabular-nums w-24 text-right">{fmt(value)}</span>
                </div>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default DRE;
