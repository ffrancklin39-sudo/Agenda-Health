import React, { useState, useEffect, useMemo, useCallback } from 'react';
import {
  Plus, Download, RefreshCw, Check, Trash2, AlertTriangle,
  ChevronDown, ChevronUp, X, Save, Loader2, Calendar,
} from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

// ─── Tipos ────────────────────────────────────────────────────

interface Bill {
  id: string;
  description: string;
  category: string;
  supplier: string | null;
  amount: number;
  amount_paid: number | null;
  due_date: string;
  paid_at: string | null;
  status: string;
  recurrence: string;
  document_number: string | null;
  notes: string | null;
  created_at: string;
}

const CATEGORIES = [
  { value: 'aluguel',      label: 'Aluguel' },
  { value: 'salario',      label: 'Salário' },
  { value: 'insumos',      label: 'Insumos' },
  { value: 'equipamentos', label: 'Equipamentos' },
  { value: 'marketing',    label: 'Marketing' },
  { value: 'servicos',     label: 'Serviços' },
  { value: 'impostos',     label: 'Impostos' },
  { value: 'manutencao',   label: 'Manutenção' },
  { value: 'outros',       label: 'Outros' },
];

const RECURRENCES = [
  { value: 'none',      label: 'Não repete' },
  { value: 'weekly',    label: 'Semanal' },
  { value: 'monthly',   label: 'Mensal' },
  { value: 'quarterly', label: 'Trimestral' },
  { value: 'yearly',    label: 'Anual' },
];

const STATUS_STYLE: Record<string, string> = {
  pending:   'bg-amber-50 text-amber-700 border-amber-200',
  paid:      'bg-emerald-50 text-emerald-700 border-emerald-200',
  overdue:   'bg-rose-50 text-rose-600 border-rose-200',
  cancelled: 'bg-slate-100 text-slate-400 border-slate-200',
};
const STATUS_LABEL: Record<string, string> = {
  pending: 'Pendente', paid: 'Pago', overdue: 'Vencido', cancelled: 'Cancelado',
};
const CAT_LABEL: Record<string, string> = Object.fromEntries(CATEGORIES.map(c => [c.value, c.label]));

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtDate = (d: string) => new Date(d + 'T00:00:00').toLocaleDateString('pt-BR');

const inputCls = `w-full border border-slate-200 rounded-xl px-3 py-2.5 text-sm text-slate-800
  bg-white outline-none focus:border-indigo-400 focus:ring-2 focus:ring-indigo-400/20 transition-all`;

const blankBill = () => ({
  description: '', category: 'outros', supplier: '', amount: 0,
  due_date: new Date().toISOString().slice(0, 10),
  recurrence: 'none', document_number: '', notes: '',
});

// ─── Modal de cadastro ────────────────────────────────────────

interface BillFormProps {
  initial?: Partial<Bill>;
  onSave: () => void;
  onClose: () => void;
}
const BillForm: React.FC<BillFormProps> = ({ initial, onSave, onClose }) => {
  const [form, setForm] = useState({ ...blankBill(), ...initial });
  const [saving, setSaving] = useState(false);
  const [error, setError]   = useState<string | null>(null);

  const set = (k: string, v: any) => setForm(f => ({ ...f, [k]: v }));

  const handleSave = async () => {
    if (!form.description) { setError('Informe a descrição.'); return; }
    if (!form.amount || form.amount <= 0) { setError('Informe o valor.'); return; }
    setSaving(true); setError(null);
    const payload = {
      description:     form.description,
      category:        form.category,
      supplier:        form.supplier || null,
      amount:          form.amount,
      due_date:        form.due_date,
      recurrence:      form.recurrence,
      document_number: form.document_number || null,
      notes:           form.notes || null,
    };
    const { error: err } = initial?.id
      ? await supabase.from('bills').update(payload).eq('id', initial.id)
      : await supabase.from('bills').insert(payload);
    setSaving(false);
    if (err) { setError(err.message); return; }
    onSave();
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden animate-in fade-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
          <h2 className="text-sm font-bold text-slate-800">{initial?.id ? 'Editar conta' : 'Nova conta a pagar'}</h2>
          <button onClick={onClose} className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 transition-colors"><X className="w-4 h-4" /></button>
        </div>
        <div className="p-5 grid grid-cols-2 gap-4">
          <div className="col-span-2">
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Descrição *</label>
            <input className={inputCls} value={form.description} onChange={e => set('description', e.target.value)} placeholder="Ex: Aluguel sala dezembro" />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Categoria</label>
            <select className={inputCls} value={form.category} onChange={e => set('category', e.target.value)}>
              {CATEGORIES.map(c => <option key={c.value} value={c.value}>{c.label}</option>)}
            </select>
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Valor (R$) *</label>
            <input type="number" min={0} step={0.01} className={inputCls} value={form.amount} onChange={e => set('amount', parseFloat(e.target.value) || 0)} />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Vencimento *</label>
            <input type="date" className={inputCls} value={form.due_date} onChange={e => set('due_date', e.target.value)} />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Recorrência</label>
            <select className={inputCls} value={form.recurrence} onChange={e => set('recurrence', e.target.value)}>
              {RECURRENCES.map(r => <option key={r.value} value={r.value}>{r.label}</option>)}
            </select>
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Fornecedor / Credor</label>
            <input className={inputCls} value={form.supplier} onChange={e => set('supplier', e.target.value)} placeholder="Ex: Imobiliária Central" />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Nº Documento</label>
            <input className={inputCls} value={form.document_number} onChange={e => set('document_number', e.target.value)} placeholder="NF, boleto, contrato..." />
          </div>
          <div className="col-span-2">
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Observações</label>
            <textarea rows={2} className={inputCls + ' resize-none'} value={form.notes} onChange={e => set('notes', e.target.value)} placeholder="Detalhes adicionais..." />
          </div>

          {error && (
            <div className="col-span-2 flex items-center gap-2 text-xs text-rose-600 bg-rose-50 border border-rose-200 rounded-xl px-3 py-2">
              <AlertTriangle className="w-3.5 h-3.5 shrink-0" />{error}
            </div>
          )}

          <button onClick={onClose} className="col-span-1 py-2.5 text-sm font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors">Cancelar</button>
          <button onClick={handleSave} disabled={saving}
            className="col-span-1 flex items-center justify-center gap-2 py-2.5 text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-500 disabled:opacity-60 rounded-xl transition-colors">
            {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            {saving ? 'Salvando...' : 'Salvar'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ─── Componente principal ─────────────────────────────────────

type FilterStatus = 'all' | 'pending' | 'overdue' | 'paid';
type PeriodKey    = 'mes' | 'trimestre' | 'ano' | 'all';

const ContasPagar: React.FC = () => {
  const [bills, setBills]       = useState<Bill[]>([]);
  const [loading, setLoading]   = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editBill, setEditBill] = useState<Bill | null>(null);
  const [status, setStatus]     = useState<FilterStatus>('all');
  const [period, setPeriod]     = useState<PeriodKey>('mes');
  const [catFilter, setCatFilter] = useState('all');
  const [marking, setMarking]   = useState<string | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    const { data } = await supabase.from('bills').select('*').order('due_date', { ascending: true });
    setBills((data ?? []) as Bill[]);
    setLoading(false);
  }, []);

  useEffect(() => { load(); }, [load]);

  const now = new Date();
  const filtered = useMemo(() => {
    return bills.filter(b => {
      // Status
      if (status === 'overdue' && b.status !== 'overdue') return false;
      if (status === 'pending' && b.status !== 'pending') return false;
      if (status === 'paid'    && b.status !== 'paid')    return false;
      // Categoria
      if (catFilter !== 'all' && b.category !== catFilter) return false;
      // Período
      if (period !== 'all') {
        const d = new Date(b.due_date + 'T00:00:00');
        const y = now.getFullYear(), m = now.getMonth();
        if (period === 'mes'       && !(d.getFullYear() === y && d.getMonth() === m)) return false;
        if (period === 'trimestre' && !(d >= new Date(y, m-2, 1) && d <= new Date(y, m+1, 0))) return false;
        if (period === 'ano'       && d.getFullYear() !== y) return false;
      }
      return true;
    });
  }, [bills, status, period, catFilter]);

  const totals = useMemo(() => ({
    pending: filtered.filter(b => b.status === 'pending').reduce((s, b) => s + b.amount, 0),
    overdue: filtered.filter(b => b.status === 'overdue').reduce((s, b) => s + b.amount, 0),
    paid:    filtered.filter(b => b.status === 'paid').reduce((s, b) => s + (b.amount_paid ?? b.amount), 0),
  }), [filtered]);

  const markPaid = async (bill: Bill) => {
    setMarking(bill.id);
    await supabase.from('bills').update({ status: 'paid', amount_paid: bill.amount, paid_at: new Date().toISOString() }).eq('id', bill.id);
    await load();
    setMarking(null);
  };

  const deleteBill = async (id: string) => {
    if (!confirm('Excluir esta conta?')) return;
    await supabase.from('bills').delete().eq('id', id);
    setBills(prev => prev.filter(b => b.id !== id));
  };

  const handleExport = () => {
    const rows = [
      ['Contas a Pagar — SintesIA'], [],
      ['Descrição', 'Categoria', 'Fornecedor', 'Valor (R$)', 'Vencimento', 'Status', 'Recorrência'],
      ...filtered.map(b => [b.description, CAT_LABEL[b.category] ?? b.category, b.supplier ?? '—', b.amount.toFixed(2), fmtDate(b.due_date), STATUS_LABEL[b.status] ?? b.status, b.recurrence]),
    ];
    const csv = rows.map(r => r.join(';')).join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'Contas_a_Pagar.csv'; a.click();
  };

  return (
    <div className="flex flex-col gap-5">
      {/* Header */}
      <div className="flex items-center gap-3 flex-wrap">
        <div className="flex-1">
          <h2 className="text-base font-bold text-slate-800">Contas a Pagar</h2>
          <p className="text-xs text-slate-400">{filtered.length} lançamento{filtered.length !== 1 ? 's' : ''}</p>
        </div>
        <button onClick={handleExport} className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
          <Download className="w-3.5 h-3.5" /> CSV
        </button>
        <button onClick={() => { setEditBill(null); setShowForm(true); }}
          className="flex items-center gap-2 bg-indigo-600 hover:bg-indigo-500 text-white text-xs font-semibold rounded-xl px-3 py-2 transition-colors">
          <Plus className="w-3.5 h-3.5" /> Nova conta
        </button>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-3 gap-3">
        <div className="bg-amber-50 border border-amber-100 rounded-xl p-3">
          <p className="text-[10px] text-amber-600 font-semibold uppercase">A pagar</p>
          <p className="text-base font-bold text-amber-700 tabular-nums">{fmt(totals.pending)}</p>
        </div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-3">
          <p className="text-[10px] text-rose-600 font-semibold uppercase">Vencido</p>
          <p className="text-base font-bold text-rose-700 tabular-nums">{fmt(totals.overdue)}</p>
        </div>
        <div className="bg-emerald-50 border border-emerald-100 rounded-xl p-3">
          <p className="text-[10px] text-emerald-600 font-semibold uppercase">Pago no período</p>
          <p className="text-base font-bold text-emerald-700 tabular-nums">{fmt(totals.paid)}</p>
        </div>
      </div>

      {/* Filtros */}
      <div className="flex items-center gap-2 flex-wrap">
        {(['all','pending','overdue','paid'] as FilterStatus[]).map(s => (
          <button key={s} onClick={() => setStatus(s)}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${status === s ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}`}>
            {{ all: 'Todos', pending: 'Pendentes', overdue: 'Vencidos', paid: 'Pagos' }[s]}
          </button>
        ))}
        <select value={catFilter} onChange={e => setCatFilter(e.target.value)}
          className="text-xs border border-slate-200 rounded-xl px-3 py-1.5 outline-none focus:border-indigo-400 bg-white text-slate-600">
          <option value="all">Todas categorias</option>
          {CATEGORIES.map(c => <option key={c.value} value={c.value}>{c.label}</option>)}
        </select>
        <select value={period} onChange={e => setPeriod(e.target.value as PeriodKey)}
          className="text-xs border border-slate-200 rounded-xl px-3 py-1.5 outline-none focus:border-indigo-400 bg-white text-slate-600">
          <option value="mes">Mês atual</option>
          <option value="trimestre">Trimestre</option>
          <option value="ano">Ano</option>
          <option value="all">Todos</option>
        </select>
      </div>

      {/* Lista */}
      {loading ? (
        <div className="flex justify-center py-16"><RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" /></div>
      ) : filtered.length === 0 ? (
        <div className="flex flex-col items-center py-16 gap-3">
          <Calendar className="w-10 h-10 text-slate-200" />
          <p className="text-slate-400 text-sm">Nenhuma conta encontrada.</p>
          <button onClick={() => { setEditBill(null); setShowForm(true); }}
            className="text-xs text-indigo-500 hover:text-indigo-700 font-semibold transition-colors">
            Cadastrar primeira conta →
          </button>
        </div>
      ) : (
        <div className="bg-white border border-slate-200 rounded-2xl overflow-hidden">
          <div className="grid grid-cols-[1fr_100px_100px_90px_110px] gap-2 px-4 py-2.5 bg-slate-50 border-b border-slate-100 text-[10px] font-bold text-slate-400 uppercase tracking-wide">
            <span>Descrição</span><span className="text-right">Valor</span><span className="text-center">Vencimento</span><span className="text-center">Status</span><span className="text-right">Ações</span>
          </div>
          <div className="divide-y divide-slate-50">
            {filtered.map(b => (
              <div key={b.id} className="grid grid-cols-[1fr_100px_100px_90px_110px] gap-2 px-4 py-3 hover:bg-slate-50 transition-colors items-center">
                <div className="min-w-0">
                  <p className="text-sm font-medium text-slate-700 truncate">{b.description}</p>
                  <p className="text-[10px] text-slate-400">{CAT_LABEL[b.category] ?? b.category}{b.supplier ? ` · ${b.supplier}` : ''}{b.recurrence !== 'none' ? ` · ${RECURRENCES.find(r=>r.value===b.recurrence)?.label}` : ''}</p>
                </div>
                <span className="text-sm font-semibold text-slate-700 tabular-nums text-right">{fmt(b.amount)}</span>
                <span className={`text-xs tabular-nums text-center ${b.status === 'overdue' ? 'text-rose-500 font-semibold' : 'text-slate-500'}`}>{fmtDate(b.due_date)}</span>
                <span className={`text-[10px] font-bold border rounded-full px-2 py-0.5 text-center ${STATUS_STYLE[b.status] ?? STATUS_STYLE.pending}`}>
                  {STATUS_LABEL[b.status] ?? b.status}
                </span>
                <div className="flex items-center justify-end gap-1">
                  {b.status !== 'paid' && (
                    <button onClick={() => markPaid(b)} disabled={marking === b.id} title="Marcar como pago"
                      className="p-1.5 rounded-lg bg-emerald-50 text-emerald-600 hover:bg-emerald-100 transition-colors disabled:opacity-50">
                      {marking === b.id ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Check className="w-3.5 h-3.5" />}
                    </button>
                  )}
                  <button onClick={() => { setEditBill(b); setShowForm(true); }} title="Editar"
                    className="p-1.5 rounded-lg bg-slate-50 text-slate-500 hover:bg-indigo-50 hover:text-indigo-600 transition-colors">
                    <ChevronDown className="w-3.5 h-3.5" />
                  </button>
                  <button onClick={() => deleteBill(b.id)} title="Excluir"
                    className="p-1.5 rounded-lg bg-slate-50 text-slate-400 hover:bg-rose-50 hover:text-rose-500 transition-colors">
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Modal */}
      {showForm && (
        <BillForm
          initial={editBill ?? undefined}
          onSave={() => { setShowForm(false); setEditBill(null); load(); }}
          onClose={() => { setShowForm(false); setEditBill(null); }}
        />
      )}
    </div>
  );
};

export default ContasPagar;
