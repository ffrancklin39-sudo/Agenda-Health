import React, { useState, useEffect, useMemo } from 'react';
import { ArrowLeft, Download, RefreshCw, AlertTriangle, CheckCircle2, Phone, MessageCircle } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

interface PaymentRow {
  id: string;
  patient_id: string;
  patient_name: string;
  service_name: string;
  amount: number;
  status: string;
  payment_method: string;
  payment_date: string | null;
  due_date: string | null;
  created_at: string;
}

interface PatientRow {
  id: string;
  name: string;
  phone: string;
  price: number;
  status: string;
  appointment_date: string | null;
  service_id: string | null;
}

interface DebtRecord {
  patientId: string;
  patientName: string;
  phone: string;
  totalDebt: number;
  payments: PaymentRow[];
  daysOverdue: number;
}

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const CONFIRMED = ['confirmed', 'confirmado', 'pago', 'completed'];

export default function Inadimplencia({ onBack }: { onBack: () => void }) {
  const [payments, setPayments]   = useState<PaymentRow[]>([]);
  const [patients, setPatients]   = useState<PatientRow[]>([]);
  const [loading, setLoading]     = useState(true);
  const [filter, setFilter]       = useState<'all' | 'overdue' | 'pending'>('all');
  const [expanded, setExpanded]   = useState<string | null>(null);
  const [marking, setMarking]     = useState<string | null>(null);

  useEffect(() => {
    Promise.all([
      supabase.from('vw_payments_full').select('id,patient_id,patient_name,service_name,amount,status,payment_method,payment_date,due_date,created_at').in('status', ['pending']),
      supabase.from('patients').select('id,name,phone,price,status,appointment_date,service_id').in('status', CONFIRMED),
    ]).then(([payRes, patRes]) => {
      setPayments((payRes.data ?? []) as PaymentRow[]);
      // Pacientes confirmados SEM pagamento registrado
      setPatients((patRes.data ?? []) as PatientRow[]);
      setLoading(false);
    });
  }, []);

  const debtors = useMemo((): DebtRecord[] => {
    const now = new Date();

    // Fonte 1: pagamentos pendentes na tabela payments
    const byPatient = new Map<string, { name: string; phone: string; pays: PaymentRow[] }>();
    payments.forEach(p => {
      if (!byPatient.has(p.patient_id)) {
        byPatient.set(p.patient_id, { name: p.patient_name ?? '—', phone: '', pays: [] });
      }
      byPatient.get(p.patient_id)!.pays.push(p);
    });

    // Fonte 2: pacientes confirmados sem pagamento na tabela payments
    const paidPatientIds = new Set(payments.map(p => p.patient_id));
    patients.forEach(p => {
      if (!paidPatientIds.has(p.id) && (p.price ?? 0) > 0) {
        byPatient.set(p.id, {
          name:  p.name,
          phone: p.phone,
          pays:  [{
            id: `legacy-${p.id}`, patient_id: p.id, patient_name: p.name,
            service_name: '—', amount: p.price ?? 0, status: 'pending',
            payment_method: '—', payment_date: null,
            due_date: p.appointment_date, created_at: p.appointment_date ?? '',
          }],
        });
      }
    });

    return Array.from(byPatient.entries()).map(([id, { name, phone, pays }]) => {
      const totalDebt = pays.reduce((s, p) => s + p.amount, 0);
      const oldest = pays.reduce((min, p) => {
        const d = p.due_date ?? p.created_at;
        return d < min ? d : min;
      }, pays[0]?.due_date ?? pays[0]?.created_at ?? '');
      const daysOverdue = oldest
        ? Math.floor((now.getTime() - new Date(oldest).getTime()) / 86400000)
        : 0;
      return { patientId: id, patientName: name, phone, totalDebt, payments: pays, daysOverdue };
    }).sort((a, b) => b.totalDebt - a.totalDebt);
  }, [payments, patients]);

  const filtered = useMemo(() => {
    if (filter === 'overdue')  return debtors.filter(d => d.daysOverdue > 30);
    if (filter === 'pending')  return debtors.filter(d => d.daysOverdue <= 30);
    return debtors;
  }, [debtors, filter]);

  const totals = useMemo(() => ({
    total: filtered.reduce((s, d) => s + d.totalDebt, 0),
    count: filtered.length,
    critical: filtered.filter(d => d.daysOverdue > 30).length,
  }), [filtered]);

  const markAsPaid = async (paymentId: string) => {
    if (paymentId.startsWith('legacy-')) return;
    setMarking(paymentId);
    await supabase.from('payments').update({ status: 'paid', payment_date: new Date().toISOString() }).eq('id', paymentId);
    setPayments(prev => prev.filter(p => p.id !== paymentId));
    setMarking(null);
  };

  const handleExport = () => {
    const rows = [
      ['Inadimplência — SintesIA'],
      [`Total em aberto: ${fmt(totals.total)} · ${totals.count} pacientes`],
      [],
      ['Paciente', 'Telefone', 'Valor em aberto (R$)', 'Dias em atraso'],
      ...filtered.map(d => [d.patientName, d.phone, d.totalDebt.toFixed(2), String(d.daysOverdue)]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'Inadimplencia.csv'; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3 flex-wrap">
        <button onClick={onBack} className="p-2 rounded-xl hover:bg-slate-100 text-slate-400 transition-colors"><ArrowLeft className="w-4 h-4" /></button>
        <div className="flex-1">
          <h1 className="text-lg font-bold text-slate-800">Inadimplência</h1>
          <p className="text-xs text-slate-500">Pagamentos pendentes e pacientes com débitos em aberto</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> Exportar CSV
        </button>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-3 gap-3">
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-4">
          <p className="text-xs text-rose-600">Total em aberto</p>
          <p className="text-xl font-bold text-rose-700 tabular-nums">{fmt(totals.total)}</p>
        </div>
        <div className="bg-amber-50 border border-amber-100 rounded-xl p-4">
          <p className="text-xs text-amber-600">Pacientes devedores</p>
          <p className="text-xl font-bold text-amber-700">{totals.count}</p>
        </div>
        <div className="bg-slate-50 border border-slate-200 rounded-xl p-4">
          <p className="text-xs text-slate-500">Críticos (+30 dias)</p>
          <p className="text-xl font-bold text-slate-700">{totals.critical}</p>
        </div>
      </div>

      {/* Filtros */}
      <div className="flex gap-2">
        {(['all','pending','overdue'] as const).map(f => (
          <button key={f} onClick={() => setFilter(f)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${filter === f ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            {{ all: 'Todos', pending: 'Recentes (≤30d)', overdue: 'Críticos (+30d)' }[f]}
          </button>
        ))}
      </div>

      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div>
      ) : filtered.length === 0 ? (
        <div className="flex flex-col items-center py-16 gap-3">
          <CheckCircle2 className="w-10 h-10 text-emerald-400" />
          <p className="text-slate-500 text-sm font-medium">Nenhuma inadimplência encontrada! 🎉</p>
        </div>
      ) : (
        <div className="flex flex-col gap-2">
          {filtered.map(d => (
            <div key={d.patientId} className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
              <button onClick={() => setExpanded(e => e === d.patientId ? null : d.patientId)}
                className="w-full flex items-center gap-3 px-4 py-3 hover:bg-slate-50 transition-colors">
                <div className={`w-2 h-8 rounded-full flex-shrink-0 ${d.daysOverdue > 30 ? 'bg-rose-400' : 'bg-amber-400'}`} />
                <div className="flex-1 text-left min-w-0">
                  <p className="text-sm font-semibold text-slate-800 truncate">{d.patientName}</p>
                  <p className="text-xs text-slate-400">{d.daysOverdue} dias em atraso · {d.payments.length} pendência{d.payments.length > 1 ? 's' : ''}</p>
                </div>
                {d.phone && (
                  <a href={`https://wa.me/55${d.phone.replace(/\D/g,'')}`} target="_blank" rel="noreferrer"
                    onClick={e => e.stopPropagation()}
                    className="p-1.5 rounded-lg bg-green-50 text-green-600 hover:bg-green-100 transition-colors">
                    <MessageCircle className="w-3.5 h-3.5" />
                  </a>
                )}
                <div className={`text-sm font-bold tabular-nums px-2 py-1 rounded-lg ${d.daysOverdue > 30 ? 'bg-rose-50 text-rose-600' : 'bg-amber-50 text-amber-700'}`}>
                  {fmt(d.totalDebt)}
                </div>
              </button>

              {expanded === d.patientId && (
                <div className="border-t border-slate-100">
                  {d.payments.map(p => (
                    <div key={p.id} className="flex items-center gap-3 px-4 py-3 border-b border-slate-50 last:border-0">
                      <div className="flex-1 min-w-0">
                        <p className="text-xs font-medium text-slate-700">{p.service_name ?? '—'}</p>
                        <p className="text-[10px] text-slate-400">
                          {p.due_date ? `Venceu em ${new Date(p.due_date).toLocaleDateString('pt-BR')}` : 'Sem vencimento'}
                        </p>
                      </div>
                      <span className="text-xs font-semibold text-slate-600 tabular-nums">{fmt(p.amount)}</span>
                      {!p.id.startsWith('legacy-') && (
                        <button onClick={() => markAsPaid(p.id)} disabled={marking === p.id}
                          className="text-[10px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 rounded-lg px-2 py-1 hover:bg-emerald-100 transition-colors disabled:opacity-50">
                          {marking === p.id ? '...' : 'Marcar pago'}
                        </button>
                      )}
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
