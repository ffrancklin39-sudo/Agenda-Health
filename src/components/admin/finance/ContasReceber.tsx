import React, { useState, useEffect, useMemo, useCallback } from 'react';
import { Download, RefreshCw, MessageCircle, Check, Loader2, TrendingUp } from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';
import PaymentRegisterModal from '../PaymentRegisterModal';
import { Patient } from '../../../types';

interface PendingPayment {
  id: string;
  patient_id: string;
  patient_name: string;
  patient_phone?: string;
  service_name: string;
  amount: number;
  due_date: string | null;
  status: string;
  payment_method: string;
  created_at: string;
}

interface PatientFull extends Patient {
  phone?: string;
}

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtDate = (d: string | null) => d ? new Date(d).toLocaleDateString('pt-BR') : '—';

type FilterKey = 'all' | 'pending' | 'overdue';
type PeriodKey = 'mes' | 'trimestre' | 'ano' | 'all';

export default function ContasReceber() {
  const [pending, setPending]         = useState<PendingPayment[]>([]);
  const [patients, setPatients]       = useState<PatientFull[]>([]);
  const [loading, setLoading]         = useState(true);
  const [filter, setFilter]           = useState<FilterKey>('all');
  const [period, setPeriod]           = useState<PeriodKey>('mes');
  const [marking, setMarking]         = useState<string | null>(null);
  const [payModal, setPayModal]       = useState<Patient | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    const [payRes, patRes] = await Promise.all([
      supabase.from('vw_payments_full').select('id,patient_id,patient_name,service_name,amount,due_date,status,payment_method,created_at').in('status', ['pending']),
      supabase.from('patients').select('*'),
    ]);
    setPending((payRes.data ?? []) as PendingPayment[]);
    setPatients((patRes.data ?? []) as PatientFull[]);
    setLoading(false);
  }, []);

  useEffect(() => { load(); }, [load]);

  const now = new Date();
  const filtered = useMemo(() => {
    return pending.filter(p => {
      if (filter === 'overdue') {
        const d = p.due_date ? new Date(p.due_date) : null;
        if (!d || d >= now) return false;
      }
      if (filter === 'pending') {
        const d = p.due_date ? new Date(p.due_date) : null;
        if (d && d < now) return false;
      }
      if (period !== 'all') {
        const d = new Date(p.created_at);
        const y = now.getFullYear(), m = now.getMonth();
        if (period === 'mes'       && !(d.getFullYear() === y && d.getMonth() === m)) return false;
        if (period === 'trimestre' && !(d >= new Date(y, m-2, 1) && d <= new Date(y, m+1, 0))) return false;
        if (period === 'ano'       && d.getFullYear() !== y) return false;
      }
      return true;
    });
  }, [pending, filter, period]);

  const totals = useMemo(() => ({
    total:   filtered.reduce((s, p) => s + p.amount, 0),
    overdue: filtered.filter(p => p.due_date && new Date(p.due_date) < now).reduce((s, p) => s + p.amount, 0),
    count:   filtered.length,
  }), [filtered]);

  // Também mostra pacientes confirmados SEM pagamento registrado
  const confirmedNoPay = useMemo(() => {
    const paidPatientIds = new Set(pending.map(p => p.patient_id));
    return patients
      .filter(p => ['confirmed','confirmado','pago'].includes((p.status ?? '').toLowerCase()) && (p.price ?? 0) > 0 && !paidPatientIds.has(p.id))
      .slice(0, 20);
  }, [patients, pending]);

  const markPaid = async (id: string) => {
    setMarking(id);
    await supabase.from('payments').update({ status: 'paid', payment_date: new Date().toISOString() }).eq('id', id);
    await load();
    setMarking(null);
  };

  const openPayModal = (patientId: string) => {
    const pat = patients.find(p => p.id === patientId);
    if (pat) setPayModal(pat as Patient);
  };

  const handleExport = () => {
    const rows = [
      ['Contas a Receber — SintesIA'], [],
      ['Paciente', 'Serviço', 'Valor (R$)', 'Vencimento', 'Status'],
      ...filtered.map(p => [p.patient_name, p.service_name ?? '—', p.amount.toFixed(2), fmtDate(p.due_date), p.status]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'Contas_a_Receber.csv'; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      <div className="flex items-center gap-3 flex-wrap">
        <div className="flex-1">
          <h2 className="text-base font-bold text-slate-800">Contas a Receber</h2>
          <p className="text-xs text-slate-400">{totals.count} pagamento{totals.count !== 1 ? 's' : ''} pendente{totals.count !== 1 ? 's' : ''}</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> CSV
        </button>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-3 gap-3">
        <div className="bg-indigo-50 border border-indigo-100 rounded-xl p-3">
          <p className="text-[10px] text-indigo-600 font-semibold uppercase">A receber</p>
          <p className="text-base font-bold text-indigo-700 tabular-nums">{fmt(totals.total)}</p>
        </div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-3">
          <p className="text-[10px] text-rose-600 font-semibold uppercase">Vencidos</p>
          <p className="text-base font-bold text-rose-700 tabular-nums">{fmt(totals.overdue)}</p>
        </div>
        <div className="bg-slate-50 border border-slate-200 rounded-xl p-3">
          <p className="text-[10px] text-slate-500 font-semibold uppercase">Sem pgto. registrado</p>
          <p className="text-base font-bold text-slate-700">{confirmedNoPay.length} pac.</p>
        </div>
      </div>

      {/* Filtros */}
      <div className="flex items-center gap-2 flex-wrap">
        {(['all','pending','overdue'] as FilterKey[]).map(f => (
          <button key={f} onClick={() => setFilter(f)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${filter === f ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            {{ all: 'Todos', pending: 'Em dia', overdue: 'Vencidos' }[f]}
          </button>
        ))}
        <select value={period} onChange={e => setPeriod(e.target.value as PeriodKey)}
          className="text-xs border border-slate-200 rounded-xl px-3 py-1.5 outline-none focus:border-indigo-400 bg-white text-slate-600">
          <option value="mes">Mês atual</option>
          <option value="trimestre">Trimestre</option>
          <option value="ano">Ano</option>
          <option value="all">Todos</option>
        </select>
      </div>

      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div>
      ) : (
        <>
          {/* Pagamentos pendentes registrados */}
          {filtered.length > 0 && (
            <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
              <div className="px-4 py-2.5 bg-slate-50 border-b border-slate-100">
                <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wide">Pagamentos registrados pendentes</p>
              </div>
              <div className="divide-y divide-slate-50">
                {filtered.map(p => {
                  const isOverdue = p.due_date && new Date(p.due_date) < now;
                  const pat = patients.find(pat => pat.id === p.patient_id);
                  return (
                    <div key={p.id} className="flex items-center gap-3 px-4 py-3 hover:bg-slate-50 transition-colors">
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium text-slate-700 truncate">{p.patient_name}</p>
                        <p className="text-xs text-slate-400">{p.service_name ?? '—'} · criado {fmtDate(p.created_at)}</p>
                      </div>
                      {isOverdue && <span className="text-[10px] font-bold text-rose-600 bg-rose-50 border border-rose-200 rounded-full px-2 py-0.5">Vencido</span>}
                      <span className="text-sm font-semibold text-slate-700 tabular-nums">{fmt(p.amount)}</span>
                      {pat?.phone && (
                        <a href={`https://wa.me/55${pat.phone.replace(/\D/g,'')}`} target="_blank" rel="noreferrer"
                          className="p-1.5 rounded-lg bg-green-50 text-green-600 hover:bg-green-100 transition-colors">
                          <MessageCircle className="w-3.5 h-3.5" />
                        </a>
                      )}
                      <button onClick={() => markPaid(p.id)} disabled={marking === p.id}
                        className="flex items-center gap-1 text-[10px] font-bold text-emerald-600 bg-emerald-50 border border-emerald-200 rounded-lg px-2 py-1 hover:bg-emerald-100 transition-colors disabled:opacity-50">
                        {marking === p.id ? <Loader2 className="w-3 h-3 animate-spin" /> : <Check className="w-3 h-3" />}
                        Pago
                      </button>
                    </div>
                  );
                })}
              </div>
            </div>
          )}

          {/* Pacientes confirmados sem pagamento registrado */}
          {confirmedNoPay.length > 0 && (
            <div className="bg-white border border-amber-200 rounded-2xl overflow-hidden">
              <div className="px-4 py-2.5 bg-amber-50 border-b border-amber-100">
                <p className="text-[10px] font-bold text-amber-600 uppercase tracking-wide flex items-center gap-1.5">
                  ⚠ Atendimentos sem pagamento registrado
                </p>
              </div>
              <div className="divide-y divide-slate-50">
                {confirmedNoPay.map(p => (
                  <div key={p.id} className="flex items-center gap-3 px-4 py-3 hover:bg-slate-50 transition-colors">
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-medium text-slate-700 truncate">{p.name}</p>
                      <p className="text-xs text-slate-400">Confirmado · sem pagamento no sistema</p>
                    </div>
                    <span className="text-sm font-semibold text-slate-700 tabular-nums">{fmt(p.price ?? 0)}</span>
                    {p.phone && (
                      <a href={`https://wa.me/55${p.phone.replace(/\D/g,'')}`} target="_blank" rel="noreferrer"
                        className="p-1.5 rounded-lg bg-green-50 text-green-600 hover:bg-green-100 transition-colors">
                        <MessageCircle className="w-3.5 h-3.5" />
                      </a>
                    )}
                    <button onClick={() => openPayModal(p.id)}
                      className="flex items-center gap-1 text-[10px] font-bold text-indigo-600 bg-indigo-50 border border-indigo-200 rounded-lg px-2 py-1 hover:bg-indigo-100 transition-colors">
                      <TrendingUp className="w-3 h-3" /> Registrar
                    </button>
                  </div>
                ))}
              </div>
            </div>
          )}

          {filtered.length === 0 && confirmedNoPay.length === 0 && (
            <div className="flex flex-col items-center py-16 gap-2">
              <Check className="w-10 h-10 text-emerald-400" />
              <p className="text-slate-400 text-sm font-medium">Tudo em dia! Nenhuma pendência encontrada.</p>
            </div>
          )}
        </>
      )}

      {payModal && (
        <PaymentRegisterModal
          patient={payModal}
          onClose={() => setPayModal(null)}
          onSuccess={() => { setPayModal(null); load(); }}
        />
      )}
    </div>
  );
}
