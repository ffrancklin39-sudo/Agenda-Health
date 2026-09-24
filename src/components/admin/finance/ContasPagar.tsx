import React, { useState, useEffect, useMemo, useCallback } from 'react';
import {
  Plus, Download, RefreshCw, Check, Trash2, AlertTriangle,
  ChevronDown, X, Save, Loader2, Calendar,
  ChevronLeft, ChevronRight, Tag, Settings2, CreditCard,
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
  recurrence_end: string | null;
  payment_method: string | null;
  bank_account: string | null;
  document_number: string | null;
  notes: string | null;
  boleto_url: string | null;
  created_at: string;
}

interface PayData {
  amount_paid: number | '';
  payment_method: string;
  bank_account: string;
  paid_at: string;
}

const DEFAULT_CATEGORIES = [
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

const PAYMENT_METHODS = [
  { value: 'pix',         label: 'PIX' },
  { value: 'debit',       label: 'Débito' },
  { value: 'cash',        label: 'Dinheiro' },
  { value: 'transfer',    label: 'Transferência' },
  { value: 'boleto',      label: 'Boleto' },
  { value: 'credit_1x',  label: 'Crédito 1x' },
  { value: 'credit_2_6x',label: 'Crédito 2–6x' },
  { value: 'credit_7x_plus', label: 'Crédito 7x+' },
  { value: 'check',       label: 'Cheque' },
];

const MONTHS_PT = [
  'Janeiro','Fevereiro','Março','Abril','Maio','Junho',
  'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro',
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

const fmt      = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtDate  = (d: string) => new Date(d + 'T00:00:00').toLocaleDateString('pt-BR');
const monthLabel = (d: Date) => `${MONTHS_PT[d.getMonth()]} ${d.getFullYear()}`;

/** Converte entrada do usuário (com vírgula ou ponto) para float */
const parseAmt = (v: string | number): number =>
  parseFloat(String(v).replace(/\./g, '').replace(',', '.')) || 0;

/** Adiciona N períodos a uma data ISO (YYYY-MM-DD) */
function addPeriods(dateStr: string, recurrence: string, n: number): string {
  const d = new Date(dateStr + 'T00:00:00');
  switch (recurrence) {
    case 'weekly':    d.setDate(d.getDate() + 7 * n);   break;
    case 'monthly':   d.setMonth(d.getMonth() + n);      break;
    case 'quarterly': d.setMonth(d.getMonth() + 3 * n);  break;
    case 'yearly':    d.setFullYear(d.getFullYear() + n); break;
  }
  return d.toISOString().slice(0, 10);
}

const inputCls = `w-full border border-slate-200 rounded-xl px-3 py-2.5 text-sm text-slate-800
  bg-white outline-none focus:border-indigo-400 focus:ring-2 focus:ring-indigo-400/20 transition-all`;

const blankBill = () => ({
  description: '', category: 'outros', supplier: '', amount: '' as number | '',
  due_date: new Date().toISOString().slice(0, 10),
  recurrence: 'none', document_number: '', notes: '', boleto_url: '',
});

// ─── Modal: Registrar Pagamento ───────────────────────────────

interface PayBillModalProps {
  bill: Bill;
  onPay: (data: PayData) => void;
  onClose: () => void;
  saving: boolean;
}

const PayBillModal: React.FC<PayBillModalProps> = ({ bill, onPay, onClose, saving }) => {
  const [data, setData] = useState<PayData>({
    amount_paid: bill.amount,
    payment_method: 'pix',
    bank_account: '',
    paid_at: new Date().toISOString().slice(0, 10),
  });
  const [error, setError] = useState<string | null>(null);

  const set = (k: keyof PayData, v: any) => setData(d => ({ ...d, [k]: v }));

  const handlePay = () => {
    const amt = parseAmt(String(data.amount_paid));
    if (!amt || amt <= 0) { setError('Informe o valor pago.'); return; }
    setError(null);
    onPay({ ...data, amount_paid: amt });
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden">
        <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
          <div className="flex items-center gap-2">
            <CreditCard className="w-4 h-4 text-indigo-500" />
            <h2 className="text-sm font-bold text-slate-800">Registrar pagamento</h2>
          </div>
          <button onClick={onClose} className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 transition-colors">
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Info da conta */}
        <div className="mx-5 mt-4 bg-slate-50 border border-slate-100 rounded-xl px-4 py-3">
          <p className="text-sm font-semibold text-slate-700 truncate">{bill.description}</p>
          <p className="text-xs text-slate-400 mt-0.5">
            Vencimento: {fmtDate(bill.due_date)} · Valor original: <span className="font-semibold text-slate-600">{fmt(bill.amount)}</span>
          </p>
          {bill.supplier && <p className="text-xs text-slate-400">{bill.supplier}</p>}
        </div>

        <div className="p-5 grid grid-cols-2 gap-4">
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Valor pago (R$) *</label>
            <input
              type="text" inputMode="decimal"
              className={inputCls}
              value={data.amount_paid}
              onChange={e => set('amount_paid', e.target.value)}
              onFocus={() => { if (!data.amount_paid || data.amount_paid === 0) set('amount_paid', ''); }}
              placeholder="0,00"
            />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Data do pagamento</label>
            <input
              type="date" className={inputCls}
              value={data.paid_at}
              onChange={e => set('paid_at', e.target.value)}
            />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Forma de pagamento</label>
            <select className={inputCls} value={data.payment_method} onChange={e => set('payment_method', e.target.value)}>
              {PAYMENT_METHODS.map(m => <option key={m.value} value={m.value}>{m.label}</option>)}
            </select>
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Conta / Origem</label>
            <input
              className={inputCls}
              value={data.bank_account}
              onChange={e => set('bank_account', e.target.value)}
              placeholder="Ex: Nubank, Caixa Pequeno..."
            />
          </div>

          {error && (
            <div className="col-span-2 flex items-center gap-2 text-xs text-rose-600 bg-rose-50 border border-rose-200 rounded-xl px-3 py-2">
              <AlertTriangle className="w-3.5 h-3.5 shrink-0" />{error}
            </div>
          )}

          <button onClick={onClose}
            className="py-2.5 text-sm font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors">
            Cancelar
          </button>
          <button onClick={handlePay} disabled={saving}
            className="flex items-center justify-center gap-2 py-2.5 text-sm font-semibold text-white bg-emerald-600 hover:bg-emerald-500 disabled:opacity-60 rounded-xl transition-colors">
            {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Check className="w-4 h-4" />}
            {saving ? 'Salvando...' : 'Confirmar'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ─── Modal: Gerenciar Categorias ──────────────────────────────

interface CategoryManagerProps {
  categories: { value: string; label: string }[];
  onSave: (cats: { value: string; label: string }[]) => void;
  onClose: () => void;
}

const CategoryManager: React.FC<CategoryManagerProps> = ({ categories, onSave, onClose }) => {
  const [cats, setCats] = useState(categories);
  const [newLabel, setNewLabel] = useState('');
  const [err, setErr] = useState('');

  const addCat = () => {
    const label = newLabel.trim();
    if (!label) { setErr('Informe o nome.'); return; }
    const value = label.toLowerCase()
      .normalize('NFD').replace(/[̀-ͯ]/g, '')
      .replace(/[^a-z0-9]+/g, '_').replace(/^_|_$/g, '');
    if (cats.find(c => c.value === value)) { setErr('Categoria já existe.'); return; }
    setCats(prev => [...prev, { value, label }]);
    setNewLabel(''); setErr('');
  };

  const removeCat = (value: string) => {
    if (DEFAULT_CATEGORIES.find(c => c.value === value)) return; // padrões não deletam
    setCats(prev => prev.filter(c => c.value !== value));
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-sm overflow-hidden">
        <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
          <div className="flex items-center gap-2">
            <Tag className="w-4 h-4 text-indigo-500" />
            <h2 className="text-sm font-bold text-slate-800">Gerenciar categorias</h2>
          </div>
          <button onClick={onClose} className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 transition-colors">
            <X className="w-4 h-4" />
          </button>
        </div>

        <div className="p-5">
          {/* Lista de categorias */}
          <div className="space-y-1 mb-4 max-h-64 overflow-y-auto">
            {cats.map(c => {
              const isDefault = !!DEFAULT_CATEGORIES.find(d => d.value === c.value);
              return (
                <div key={c.value} className="flex items-center justify-between py-1.5 px-3 rounded-lg bg-slate-50 hover:bg-slate-100 transition-colors">
                  <span className="text-sm text-slate-700">{c.label}</span>
                  {isDefault ? (
                    <span className="text-[10px] text-slate-400 font-semibold">padrão</span>
                  ) : (
                    <button onClick={() => removeCat(c.value)}
                      className="p-1 rounded text-slate-400 hover:text-rose-500 hover:bg-rose-50 transition-colors">
                      <X className="w-3 h-3" />
                    </button>
                  )}
                </div>
              );
            })}
          </div>

          {/* Adicionar nova */}
          <div className="flex gap-2">
            <input
              className={inputCls + ' flex-1'}
              value={newLabel}
              onChange={e => { setNewLabel(e.target.value); setErr(''); }}
              onKeyDown={e => e.key === 'Enter' && addCat()}
              placeholder="Nova categoria..."
            />
            <button onClick={addCat}
              className="px-3 py-2.5 text-sm font-semibold text-indigo-600 bg-indigo-50 hover:bg-indigo-100 rounded-xl transition-colors">
              <Plus className="w-4 h-4" />
            </button>
          </div>
          {err && <p className="text-xs text-rose-500 mt-1.5">{err}</p>}

          <div className="flex gap-2 mt-4">
            <button onClick={onClose}
              className="flex-1 py-2.5 text-sm font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors">
              Cancelar
            </button>
            <button onClick={() => onSave(cats)}
              className="flex-1 flex items-center justify-center gap-2 py-2.5 text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-500 rounded-xl transition-colors">
              <Save className="w-4 h-4" /> Salvar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

// ─── Modal de cadastro de conta ────────────────────────────────

interface BillFormProps {
  initial?: Partial<Bill>;
  allCategories: { value: string; label: string }[];
  onSave: () => void;
  onClose: () => void;
}

const BillForm: React.FC<BillFormProps> = ({ initial, allCategories, onSave, onClose }) => {
  const [form, setForm] = useState<any>({
    ...blankBill(), ...initial,
    amount: initial?.amount != null ? String(initial.amount).replace('.', ',') : '',
  });
  const [saving, setSaving] = useState(false);
  const [error, setError]   = useState<string | null>(null);

  // Controles de recorrência expandida
  type RecMode = 'forever' | 'installments' | 'end_date';
  const [recMode, setRecMode]       = useState<RecMode>(
    initial?.recurrence_end ? 'end_date' : 'forever',
  );
  const [numInstallments, setNumInstallments] = useState<number | ''>(12);
  const [endDate, setEndDate] = useState<string>(initial?.recurrence_end ?? '');

  const set = (k: string, v: any) => setForm((f: any) => ({ ...f, [k]: v }));

  // Calcula data final e total para o resumo de parcelas
  const installmentSummary = useMemo(() => {
    const amt   = parseAmt(String(form.amount));
    const n     = Number(numInstallments);
    if (!n || n < 2 || !amt || form.recurrence === 'none') return null;
    const lastDate = addPeriods(form.due_date, form.recurrence, n - 1);
    return { total: amt * n, lastDate, n };
  }, [form.amount, form.due_date, form.recurrence, numInstallments]);

  const handleSave = async () => {
    if (!form.description) { setError('Informe a descrição.'); return; }
    const amt = parseAmt(String(form.amount));
    if (!amt || amt <= 0) { setError('Informe o valor (ex: 150,00).'); return; }
    setSaving(true); setError(null);

    // Calcula recurrence_end
    let recurrenceEnd: string | null = null;
    if (form.recurrence !== 'none') {
      if (recMode === 'installments' && numInstallments && Number(numInstallments) >= 2) {
        recurrenceEnd = addPeriods(form.due_date, form.recurrence, Number(numInstallments) - 1);
      } else if (recMode === 'end_date' && endDate) {
        recurrenceEnd = endDate;
      }
    }

    const payload = {
      description:     form.description,
      category:        form.category,
      supplier:        form.supplier || null,
      amount:          amt,
      due_date:        form.due_date,
      recurrence:      form.recurrence,
      recurrence_end:  recurrenceEnd,
      document_number: form.document_number || null,
      notes:           form.notes || null,
      boleto_url:      form.boleto_url || null,
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
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden">
        <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
          <h2 className="text-sm font-bold text-slate-800">{initial?.id ? 'Editar conta' : 'Nova conta a pagar'}</h2>
          <button onClick={onClose} className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 transition-colors">
            <X className="w-4 h-4" />
          </button>
        </div>
        <div className="p-5 grid grid-cols-2 gap-4">
          <div className="col-span-2">
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Descrição *</label>
            <input className={inputCls} value={form.description} onChange={e => set('description', e.target.value)} placeholder="Ex: Aluguel sala dezembro" />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Categoria</label>
            <select className={inputCls} value={form.category} onChange={e => set('category', e.target.value)}>
              {allCategories.map(c => <option key={c.value} value={c.value}>{c.label}</option>)}
            </select>
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Valor (R$) *</label>
            <input
              type="text" inputMode="decimal"
              className={inputCls}
              value={form.amount}
              onChange={e => set('amount', e.target.value)}
              onFocus={e => { if (!form.amount || form.amount === '0') set('amount', ''); }}
              placeholder="0,00"
            />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Vencimento *</label>
            <input type="date" className={inputCls} value={form.due_date} onChange={e => set('due_date', e.target.value)} />
          </div>
          <div className={form.recurrence !== 'none' ? '' : 'col-span-1'}>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Repetição</label>
            <select className={inputCls} value={form.recurrence} onChange={e => { set('recurrence', e.target.value); setRecMode('forever'); }}>
              {RECURRENCES.map(r => <option key={r.value} value={r.value}>{r.label}</option>)}
            </select>
          </div>

          {/* Recorrência expandida */}
          {form.recurrence !== 'none' && (
            <div className="col-span-2 bg-indigo-50 border border-indigo-100 rounded-xl p-3 space-y-2">
              <p className="text-[10px] font-bold text-indigo-500 uppercase tracking-wide">Quando termina?</p>
              <div className="flex flex-col gap-1.5">
                {/* Opção 1: nunca */}
                <label className="flex items-center gap-2 cursor-pointer">
                  <input type="radio" name="recMode" checked={recMode === 'forever'}
                    onChange={() => setRecMode('forever')}
                    className="accent-indigo-600" />
                  <span className="text-xs text-slate-700">Nunca (repetição contínua)</span>
                </label>

                {/* Opção 2: N parcelas */}
                <label className="flex items-center gap-2 cursor-pointer">
                  <input type="radio" name="recMode" checked={recMode === 'installments'}
                    onChange={() => setRecMode('installments')}
                    className="accent-indigo-600" />
                  <span className="text-xs text-slate-700">Após</span>
                  <input
                    type="number" min={2} max={360}
                    className="w-16 border border-slate-200 rounded-lg px-2 py-1 text-xs text-center outline-none focus:border-indigo-400 bg-white"
                    value={numInstallments}
                    onChange={e => setNumInstallments(e.target.value === '' ? '' : parseInt(e.target.value))}
                    onClick={() => setRecMode('installments')}
                  />
                  <span className="text-xs text-slate-700">vezes</span>
                  {installmentSummary && recMode === 'installments' && (
                    <span className="text-[10px] text-indigo-600 font-semibold ml-1">
                      Total: {fmt(installmentSummary.total)} · até {fmtDate(installmentSummary.lastDate)}
                    </span>
                  )}
                </label>

                {/* Opção 3: até uma data */}
                <label className="flex items-center gap-2 cursor-pointer">
                  <input type="radio" name="recMode" checked={recMode === 'end_date'}
                    onChange={() => setRecMode('end_date')}
                    className="accent-indigo-600" />
                  <span className="text-xs text-slate-700">Até</span>
                  <input
                    type="date"
                    className="border border-slate-200 rounded-lg px-2 py-1 text-xs outline-none focus:border-indigo-400 bg-white"
                    value={endDate}
                    onChange={e => { setEndDate(e.target.value); setRecMode('end_date'); }}
                  />
                </label>
              </div>
            </div>
          )}
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Fornecedor / Credor</label>
            <input className={inputCls} value={form.supplier ?? ''} onChange={e => set('supplier', e.target.value)} placeholder="Ex: Imobiliária Central" />
          </div>
          <div>
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Nº Documento</label>
            <input className={inputCls} value={form.document_number ?? ''} onChange={e => set('document_number', e.target.value)} placeholder="NF, boleto, contrato..." />
          </div>
          <div className="col-span-2">
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Link do Boleto</label>
            <input className={inputCls} value={form.boleto_url ?? ''} onChange={e => set('boleto_url', e.target.value)} placeholder="https://..." />
            <p className="text-[10px] text-slate-400 mt-1">Será enviado no lembrete WhatsApp junto com os dados da conta.</p>
          </div>
          <div className="col-span-2">
            <label className="text-xs font-semibold text-slate-500 block mb-1.5">Observações</label>
            <textarea rows={2} className={inputCls + ' resize-none'} value={form.notes ?? ''} onChange={e => set('notes', e.target.value)} placeholder="Detalhes adicionais..." />
          </div>

          {error && (
            <div className="col-span-2 flex items-center gap-2 text-xs text-rose-600 bg-rose-50 border border-rose-200 rounded-xl px-3 py-2">
              <AlertTriangle className="w-3.5 h-3.5 shrink-0" />{error}
            </div>
          )}

          <button onClick={onClose} className="py-2.5 text-sm font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors">Cancelar</button>
          <button onClick={handleSave} disabled={saving}
            className="flex items-center justify-center gap-2 py-2.5 text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-500 disabled:opacity-60 rounded-xl transition-colors">
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

const ContasPagar: React.FC = () => {
  const [bills, setBills]               = useState<Bill[]>([]);
  const [loading, setLoading]           = useState(true);
  const [showForm, setShowForm]         = useState(false);
  const [editBill, setEditBill]         = useState<Bill | null>(null);
  const [statusFilter, setStatusFilter] = useState<FilterStatus>('all');
  const [catFilter, setCatFilter]       = useState('all');
  const [viewMonth, setViewMonth]       = useState<Date | null>(new Date());
  const [payingBill, setPayingBill]     = useState<Bill | null>(null);
  const [marking, setMarking]           = useState<string | null>(null);
  const [showCatManager, setShowCatManager] = useState(false);
  const [extraCategories, setExtraCategories] = useState<{ value: string; label: string }[]>([]);

  const allCategories = useMemo(() => [
    ...DEFAULT_CATEGORIES,
    ...extraCategories.filter(c => !DEFAULT_CATEGORIES.find(d => d.value === c.value)),
  ], [extraCategories]);

  const catLabel = useMemo(() => Object.fromEntries(allCategories.map(c => [c.value, c.label])), [allCategories]);

  // Carrega contas + gera ocorrências recorrentes futuras
  const load = useCallback(async () => {
    setLoading(true);
    // Gera os próximos 12 meses de contas recorrentes (idempotente)
    await supabase.rpc('fn_generate_recurring_bills', { p_months_ahead: 12 });
    const { data } = await supabase.from('bills').select('*').order('due_date', { ascending: true });
    setBills((data ?? []) as Bill[]);
    setLoading(false);
  }, []);

  // Carrega categorias customizadas
  const loadCategories = useCallback(async () => {
    const { data } = await supabase
      .from('clinic_settings').select('value').eq('key', 'bill_categories').maybeSingle();
    if (!data) return;
    const val = data.value;
    // value pode vir como array (JSONB já parsed) ou string
    const parsed: { value: string; label: string }[] = Array.isArray(val)
      ? val
      : typeof val === 'string'
        ? JSON.parse(val)
        : [];
    if (parsed.length > 0) setExtraCategories(parsed);
  }, []);

  useEffect(() => { load(); loadCategories(); }, [load, loadCategories]);

  // Navegação de mês
  const goPrev = () => setViewMonth(prev => {
    const d = prev ? new Date(prev) : new Date();
    d.setMonth(d.getMonth() - 1); return new Date(d);
  });
  const goNext = () => setViewMonth(prev => {
    const d = prev ? new Date(prev) : new Date();
    d.setMonth(d.getMonth() + 1); return new Date(d);
  });

  // Filtragem
  const filtered = useMemo(() => {
    return bills.filter(b => {
      if (statusFilter !== 'all') {
        if (b.status !== statusFilter) return false;
      }
      if (catFilter !== 'all' && b.category !== catFilter) return false;
      if (viewMonth !== null) {
        const d = new Date(b.due_date + 'T00:00:00');
        if (d.getFullYear() !== viewMonth.getFullYear() || d.getMonth() !== viewMonth.getMonth()) return false;
      }
      return true;
    });
  }, [bills, statusFilter, catFilter, viewMonth]);

  const totals = useMemo(() => ({
    pending: filtered.filter(b => b.status === 'pending').reduce((s, b) => s + b.amount, 0),
    overdue: filtered.filter(b => b.status === 'overdue').reduce((s, b) => s + b.amount, 0),
    paid:    filtered.filter(b => b.status === 'paid').reduce((s, b) => s + (b.amount_paid ?? b.amount), 0),
  }), [filtered]);

  // Pagamento via modal
  const confirmPay = async (data: PayData) => {
    if (!payingBill) return;
    setMarking(payingBill.id);
    await supabase.from('bills').update({
      status:         'paid',
      amount_paid:    Number(data.amount_paid),
      payment_method: data.payment_method,
      bank_account:   data.bank_account || null,
      paid_at:        new Date(data.paid_at + 'T12:00:00').toISOString(),
    }).eq('id', payingBill.id);
    setPayingBill(null);
    setMarking(null);
    await load();
  };

  const deleteBill = async (id: string) => {
    if (!confirm('Excluir esta conta?')) return;
    await supabase.from('bills').delete().eq('id', id);
    setBills(prev => prev.filter(b => b.id !== id));
  };

  const saveCategories = async (cats: { value: string; label: string }[]) => {
    const extra = cats.filter(c => !DEFAULT_CATEGORIES.find(d => d.value === c.value));

    // Usa função SECURITY DEFINER para ignorar RLS no upsert
    const { error } = await supabase.rpc('save_bill_categories', { p_categories: extra });
    if (error) {
      console.error('saveCategories RPC error:', error.message);
      alert('Erro ao salvar categorias: ' + error.message);
      return;
    }

    setExtraCategories(extra);
    setShowCatManager(false);
  };

  const handleExport = () => {
    const rows = [
      ['Contas a Pagar — SintesIA'], [],
      ['Descrição', 'Categoria', 'Fornecedor', 'Valor (R$)', 'Vencimento', 'Status', 'Recorrência', 'Conta Pagamento'],
      ...filtered.map(b => [
        b.description, catLabel[b.category] ?? b.category,
        b.supplier ?? '—', b.amount.toFixed(2),
        fmtDate(b.due_date), STATUS_LABEL[b.status] ?? b.status,
        b.recurrence, b.bank_account ?? '—',
      ]),
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
        <button onClick={handleExport}
          className="flex items-center gap-2 text-xs font-semibold text-slate-600 border border-slate-200 hover:border-indigo-300 hover:text-indigo-600 rounded-xl px-3 py-2 transition-colors">
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

      {/* Navegação mês + Filtros */}
      <div className="flex flex-col gap-2">
        {/* Linha 1: navegação de mês */}
        <div className="flex items-center gap-2">
          <button onClick={goPrev}
            className="p-1.5 rounded-lg border border-slate-200 text-slate-500 hover:border-indigo-300 hover:text-indigo-600 transition-colors">
            <ChevronLeft className="w-4 h-4" />
          </button>
          <div className="flex-1 text-center">
            <span className="text-sm font-semibold text-slate-700">
              {viewMonth ? monthLabel(viewMonth) : 'Todos os períodos'}
            </span>
          </div>
          <button onClick={goNext}
            className="p-1.5 rounded-lg border border-slate-200 text-slate-500 hover:border-indigo-300 hover:text-indigo-600 transition-colors">
            <ChevronRight className="w-4 h-4" />
          </button>
          <button
            onClick={() => setViewMonth(viewMonth ? null : new Date())}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors border ${
              !viewMonth
                ? 'bg-indigo-600 text-white border-indigo-600'
                : 'bg-white text-slate-500 border-slate-200 hover:border-indigo-300 hover:text-indigo-600'
            }`}>
            Todos
          </button>
        </div>

        {/* Linha 2: filtros status + categoria */}
        <div className="flex items-center gap-2 flex-wrap">
          {(['all','pending','overdue','paid'] as FilterStatus[]).map(s => (
            <button key={s} onClick={() => setStatusFilter(s)}
              className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-colors ${
                statusFilter === s ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'
              }`}>
              {{ all: 'Todos', pending: 'Pendentes', overdue: 'Vencidos', paid: 'Pagos' }[s]}
            </button>
          ))}
          <div className="flex items-center gap-1 ml-auto">
            <select
              value={catFilter} onChange={e => setCatFilter(e.target.value)}
              className="text-xs border border-slate-200 rounded-xl px-3 py-1.5 outline-none focus:border-indigo-400 bg-white text-slate-600">
              <option value="all">Todas categorias</option>
              {allCategories.map(c => <option key={c.value} value={c.value}>{c.label}</option>)}
            </select>
            <button
              onClick={() => setShowCatManager(true)}
              title="Gerenciar categorias"
              className="p-1.5 rounded-xl border border-slate-200 text-slate-400 hover:border-indigo-300 hover:text-indigo-500 transition-colors">
              <Settings2 className="w-3.5 h-3.5" />
            </button>
          </div>
        </div>
      </div>

      {/* Lista */}
      {loading ? (
        <div className="flex justify-center py-16">
          <RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" />
        </div>
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
            <span>Descrição</span>
            <span className="text-right">Valor</span>
            <span className="text-center">Vencimento</span>
            <span className="text-center">Status</span>
            <span className="text-right">Ações</span>
          </div>
          <div className="divide-y divide-slate-50">
            {filtered.map(b => (
              <div key={b.id} className="grid grid-cols-[1fr_100px_100px_90px_110px] gap-2 px-4 py-3 hover:bg-slate-50 transition-colors items-center">
                <div className="min-w-0">
                  <p className="text-sm font-medium text-slate-700 truncate">{b.description}</p>
                  <div className="flex items-center gap-1 flex-wrap">
                    <p className="text-[10px] text-slate-400">
                      {catLabel[b.category] ?? b.category}
                      {b.supplier ? ` · ${b.supplier}` : ''}
                      {b.recurrence !== 'none' ? ` · ${RECURRENCES.find(r => r.value === b.recurrence)?.label}` : ''}
                    </p>
                    {b.status === 'paid' && b.bank_account && (
                      <span className="text-[10px] text-emerald-600 bg-emerald-50 border border-emerald-100 rounded-full px-1.5 py-0.5">
                        {b.bank_account}
                      </span>
                    )}
                  </div>
                </div>
                <div className="text-right">
                  <span className="text-sm font-semibold text-slate-700 tabular-nums">{fmt(b.amount)}</span>
                  {b.amount_paid != null && b.amount_paid !== b.amount && (
                    <p className="text-[10px] text-emerald-600">pago: {fmt(b.amount_paid)}</p>
                  )}
                </div>
                <span className={`text-xs tabular-nums text-center ${b.status === 'overdue' ? 'text-rose-500 font-semibold' : 'text-slate-500'}`}>
                  {fmtDate(b.due_date)}
                </span>
                <span className={`text-[10px] font-bold border rounded-full px-2 py-0.5 text-center ${STATUS_STYLE[b.status] ?? STATUS_STYLE.pending}`}>
                  {STATUS_LABEL[b.status] ?? b.status}
                </span>
                <div className="flex items-center justify-end gap-1">
                  {b.status !== 'paid' && (
                    <button
                      onClick={() => setPayingBill(b)}
                      disabled={marking === b.id}
                      title="Registrar pagamento"
                      className="p-1.5 rounded-lg bg-emerald-50 text-emerald-600 hover:bg-emerald-100 transition-colors disabled:opacity-50">
                      {marking === b.id
                        ? <Loader2 className="w-3.5 h-3.5 animate-spin" />
                        : <Check className="w-3.5 h-3.5" />}
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

      {/* Modal: cadastro/edição */}
      {showForm && (
        <BillForm
          initial={editBill ?? undefined}
          allCategories={allCategories}
          onSave={() => { setShowForm(false); setEditBill(null); load(); }}
          onClose={() => { setShowForm(false); setEditBill(null); }}
        />
      )}

      {/* Modal: registrar pagamento */}
      {payingBill && (
        <PayBillModal
          bill={payingBill}
          saving={marking === payingBill.id}
          onPay={confirmPay}
          onClose={() => setPayingBill(null)}
        />
      )}

      {/* Modal: gerenciar categorias */}
      {showCatManager && (
        <CategoryManager
          categories={allCategories}
          onSave={saveCategories}
          onClose={() => setShowCatManager(false)}
        />
      )}
    </div>
  );
};

export default ContasPagar;
