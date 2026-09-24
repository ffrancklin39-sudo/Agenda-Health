import React, { useState, useEffect, useCallback } from 'react';
import CurrencyInput from 'react-currency-input-field';
import {
  Landmark, Plus, Pencil, Trash2, X, TrendingUp, TrendingDown,
  Wallet, PiggyBank, Banknote, BarChart2, RefreshCw, ChevronRight,
  ArrowUpRight, ArrowDownRight, CircleDollarSign,
} from 'lucide-react';
import { supabase } from '../../../services/supabaseClient';

// ─── Tipos ───────────────────────────────────────────────────────────────────

type AccountType = 'checking' | 'savings' | 'cash' | 'investment';

interface BankAccount {
  id: string;
  name: string;
  bank: string | null;
  type: AccountType;
  initial_balance: number;
  color: string;
  notes: string | null;
  is_active: boolean;
  // da view
  total_income?: number;
  total_expenses?: number;
  current_balance?: number;
  income_count?: number;
  expense_count?: number;
}

interface Transaction {
  id: string;
  date: string;
  description: string;
  counterpart: string;
  amount: number;
  flow_type: 'income' | 'expense';
  payment_method: string;
  status: string;
}

interface AccountForm {
  name: string;
  bank: string;
  type: AccountType;
  initial_balance: string;
  color: string;
  notes: string;
}

// ─── Constantes ──────────────────────────────────────────────────────────────

const ACCOUNT_TYPES: { value: AccountType; label: string; icon: React.ElementType }[] = [
  { value: 'checking',   label: 'Conta Corrente', icon: Landmark },
  { value: 'savings',    label: 'Poupança',        icon: PiggyBank },
  { value: 'cash',       label: 'Caixa/Espécie',  icon: Banknote },
  { value: 'investment', label: 'Investimento',    icon: BarChart2 },
];

const PRESET_COLORS = [
  '#6366f1', // indigo
  '#10b981', // emerald
  '#0ea5e9', // sky
  '#f59e0b', // amber
  '#ef4444', // rose
  '#8b5cf6', // violet
  '#f97316', // orange
  '#14b8a6', // teal
];

const EMPTY_FORM: AccountForm = {
  name: '', bank: '', type: 'checking', initial_balance: '', color: '#6366f1', notes: '',
};

// ─── Helpers ─────────────────────────────────────────────────────────────────

const fmt = (v: number) =>
  v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });

const fmtDate = (s: string) =>
  new Date(s).toLocaleDateString('pt-BR', { day: '2-digit', month: 'short' });

const parseAmt = (v: string | number): number => {
  const s = String(v ?? '').trim().replace(/R\$\s?/g, '').replace(/\s/g, '');
  if (!s) return 0;
  if (s.includes(',')) return parseFloat(s.replace(/\./g, '').replace(',', '.')) || 0;
  return parseFloat(s) || 0;
};

const typeIcon = (t: AccountType) => {
  const found = ACCOUNT_TYPES.find(a => a.value === t);
  return found ? found.icon : Landmark;
};

const typeLabel = (t: AccountType) =>
  ACCOUNT_TYPES.find(a => a.value === t)?.label ?? t;

// ─── Input comum ─────────────────────────────────────────────────────────────

const inputCls =
  'w-full px-3 py-2 rounded-lg border border-slate-200 text-sm bg-white outline-none focus:ring-2 focus:ring-indigo-300 focus:border-indigo-400 transition';
const labelCls = 'block text-xs font-semibold text-slate-600 mb-1';

// ─── Modal de Cadastro/Edição ─────────────────────────────────────────────────

interface AccountModalProps {
  initial: AccountForm;
  onSave: (data: AccountForm) => Promise<void>;
  onClose: () => void;
  title: string;
}

const AccountModal: React.FC<AccountModalProps> = ({ initial, onSave, onClose, title }) => {
  const [data, setData] = useState<AccountForm>(initial);
  const [saving, setSaving] = useState(false);
  const set = (k: keyof AccountForm, v: string) => setData(d => ({ ...d, [k]: v }));

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!data.name.trim()) return;
    setSaving(true);
    await onSave(data);
    setSaving(false);
  };

  return (
    <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-md">
        <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
          <h3 className="text-sm font-bold text-slate-800">{title}</h3>
          <button onClick={onClose} className="p-1 rounded-lg hover:bg-slate-100 text-slate-400">
            <X size={16} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-5 space-y-4">
          {/* Nome */}
          <div>
            <label className={labelCls}>Nome da conta *</label>
            <input
              className={inputCls}
              value={data.name}
              onChange={e => set('name', e.target.value)}
              placeholder="Ex: Nubank Clínica"
              required
            />
          </div>

          {/* Banco */}
          <div>
            <label className={labelCls}>Banco / Instituição</label>
            <input
              className={inputCls}
              value={data.bank}
              onChange={e => set('bank', e.target.value)}
              placeholder="Ex: Nubank, Bradesco, Inter…"
            />
          </div>

          {/* Tipo */}
          <div>
            <label className={labelCls}>Tipo</label>
            <div className="grid grid-cols-2 gap-2">
              {ACCOUNT_TYPES.map(({ value, label, icon: Icon }) => (
                <button
                  key={value}
                  type="button"
                  onClick={() => set('type', value)}
                  className={`flex items-center gap-2 px-3 py-2 rounded-lg border text-xs font-semibold transition ${
                    data.type === value
                      ? 'border-indigo-500 bg-indigo-50 text-indigo-700'
                      : 'border-slate-200 text-slate-600 hover:bg-slate-50'
                  }`}
                >
                  <Icon size={14} />
                  {label}
                </button>
              ))}
            </div>
          </div>

          {/* Saldo inicial */}
          <div>
            <label className={labelCls}>Saldo inicial</label>
            <CurrencyInput
              className={inputCls}
              prefix="R$ "
              decimalSeparator=","
              groupSeparator="."
              decimalsLimit={2}
              defaultValue={parseAmt(data.initial_balance) || undefined}
              onValueChange={val => set('initial_balance', val ?? '')}
              placeholder="R$ 0,00"
            />
            <p className="text-[10px] text-slate-400 mt-1">
              Saldo existente na conta antes de começar a usar o SintesIA
            </p>
          </div>

          {/* Cor */}
          <div>
            <label className={labelCls}>Cor</label>
            <div className="flex items-center gap-2 flex-wrap">
              {PRESET_COLORS.map(c => (
                <button
                  key={c}
                  type="button"
                  onClick={() => set('color', c)}
                  className={`w-7 h-7 rounded-full transition ${
                    data.color === c ? 'ring-2 ring-offset-2 ring-slate-400' : ''
                  }`}
                  style={{ backgroundColor: c }}
                />
              ))}
            </div>
          </div>

          {/* Observações */}
          <div>
            <label className={labelCls}>Observações</label>
            <textarea
              className={inputCls + ' resize-none'}
              rows={2}
              value={data.notes}
              onChange={e => set('notes', e.target.value)}
              placeholder="Opcional"
            />
          </div>

          <div className="flex gap-2 pt-1">
            <button type="button" onClick={onClose}
              className="flex-1 px-4 py-2 rounded-lg border border-slate-200 text-sm font-semibold text-slate-600 hover:bg-slate-50 transition">
              Cancelar
            </button>
            <button type="submit" disabled={saving}
              className="flex-1 px-4 py-2 rounded-lg bg-indigo-600 text-white text-sm font-semibold hover:bg-indigo-700 disabled:opacity-50 transition">
              {saving ? 'Salvando…' : 'Salvar'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

// ─── Detalhe de conta ─────────────────────────────────────────────────────────

interface AccountDetailProps {
  account: BankAccount;
  onClose: () => void;
}

const AccountDetail: React.FC<AccountDetailProps> = ({ account, onClose }) => {
  const [txFilter, setTxFilter] = useState<'all' | 'income' | 'expense'>('all');
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const load = async () => {
      setLoading(true);
      const [{ data: payments }, { data: bills }] = await Promise.all([
        supabase
          .from('payments')
          .select('id, payment_date, amount, payment_method, status')
          .eq('bank_account', account.name)
          .eq('status', 'paid')
          .order('payment_date', { ascending: false })
          .limit(100),
        supabase
          .from('bills')
          .select('id, paid_at, due_date, description, amount_paid, amount, payment_method, supplier, status')
          .eq('bank_account', account.name)
          .eq('status', 'paid')
          .order('paid_at', { ascending: false })
          .limit(100),
      ]);

      const txs: Transaction[] = [
        ...((payments ?? []).map(p => ({
          id: p.id,
          date: p.payment_date,
          description: 'Atendimento',
          counterpart: '—',
          amount: p.amount,
          flow_type: 'income' as const,
          payment_method: p.payment_method ?? '—',
          status: p.status,
        }))),
        ...((bills ?? []).map(b => ({
          id: b.id,
          date: b.paid_at ?? b.due_date,
          description: b.description,
          counterpart: b.supplier ?? '—',
          amount: b.amount_paid ?? b.amount,
          flow_type: 'expense' as const,
          payment_method: b.payment_method ?? '—',
          status: b.status,
        }))),
      ].sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

      setTransactions(txs);
      setLoading(false);
    };
    load();
  }, [account.name]);

  const filtered = txFilter === 'all' ? transactions
    : transactions.filter(t => t.flow_type === txFilter);

  const TypeIcon = typeIcon(account.type);

  return (
    <div className="fixed inset-0 bg-black/40 z-50 flex items-end sm:items-center justify-center p-0 sm:p-4">
      <div className="bg-white rounded-t-2xl sm:rounded-2xl shadow-xl w-full sm:max-w-lg max-h-[90vh] flex flex-col">

        {/* Header */}
        <div className="flex items-center gap-3 px-5 py-4 border-b border-slate-100">
          <div className="p-2 rounded-xl" style={{ backgroundColor: account.color + '20' }}>
            <TypeIcon size={16} style={{ color: account.color }} />
          </div>
          <div className="flex-1 min-w-0">
            <h3 className="text-sm font-bold text-slate-800 truncate">{account.name}</h3>
            <p className="text-xs text-slate-400">{account.bank ?? typeLabel(account.type)}</p>
          </div>
          <button onClick={onClose} className="p-1 rounded-lg hover:bg-slate-100 text-slate-400">
            <X size={16} />
          </button>
        </div>

        {/* Saldo */}
        <div className="px-5 py-4 flex gap-4 border-b border-slate-100">
          <div className="flex-1">
            <p className="text-[10px] font-bold uppercase tracking-widest text-slate-400 mb-0.5">Saldo atual</p>
            <p className={`text-2xl font-extrabold ${(account.current_balance ?? 0) >= 0 ? 'text-emerald-600' : 'text-rose-600'}`}>
              {fmt(account.current_balance ?? 0)}
            </p>
          </div>
          <div className="text-right">
            <p className="text-[10px] font-bold uppercase tracking-widest text-slate-400 mb-1">Entradas</p>
            <p className="text-sm font-bold text-emerald-600">{fmt(account.total_income ?? 0)}</p>
          </div>
          <div className="text-right">
            <p className="text-[10px] font-bold uppercase tracking-widest text-slate-400 mb-1">Saídas</p>
            <p className="text-sm font-bold text-rose-600">{fmt(account.total_expenses ?? 0)}</p>
          </div>
        </div>

        {/* Filtros */}
        <div className="flex gap-1 px-5 py-3 border-b border-slate-100">
          {(['all', 'income', 'expense'] as const).map(f => (
            <button key={f} onClick={() => setTxFilter(f)}
              className={`px-3 py-1 rounded-lg text-xs font-semibold transition ${
                txFilter === f
                  ? 'bg-indigo-600 text-white'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}>
              {f === 'all' ? 'Todos' : f === 'income' ? 'Entradas' : 'Saídas'}
            </button>
          ))}
          <span className="ml-auto text-xs text-slate-400 self-center">{filtered.length} transações</span>
        </div>

        {/* Lista de transações */}
        <div className="flex-1 overflow-y-auto">
          {loading ? (
            <div className="flex items-center justify-center h-24 text-slate-400 text-sm">Carregando…</div>
          ) : filtered.length === 0 ? (
            <div className="flex flex-col items-center justify-center h-24 text-slate-400">
              <CircleDollarSign size={24} className="mb-1 opacity-30" />
              <p className="text-xs">Nenhuma transação encontrada</p>
            </div>
          ) : (
            <div className="divide-y divide-slate-50">
              {filtered.map(tx => (
                <div key={tx.id} className="flex items-center gap-3 px-5 py-3 hover:bg-slate-50 transition">
                  <div className={`p-1.5 rounded-lg shrink-0 ${
                    tx.flow_type === 'income' ? 'bg-emerald-50' : 'bg-rose-50'
                  }`}>
                    {tx.flow_type === 'income'
                      ? <ArrowUpRight size={14} className="text-emerald-600" />
                      : <ArrowDownRight size={14} className="text-rose-600" />
                    }
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-xs font-semibold text-slate-700 truncate">{tx.description}</p>
                    <p className="text-[10px] text-slate-400">{fmtDate(tx.date)} · {tx.payment_method}</p>
                  </div>
                  <p className={`text-sm font-bold tabular-nums shrink-0 ${
                    tx.flow_type === 'income' ? 'text-emerald-600' : 'text-rose-600'
                  }`}>
                    {tx.flow_type === 'income' ? '+' : '-'}{fmt(tx.amount)}
                  </p>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// ─── Componente principal ─────────────────────────────────────────────────────

const ContasBancarias: React.FC = () => {
  const [accounts, setAccounts] = useState<BankAccount[]>([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editingAccount, setEditingAccount] = useState<BankAccount | null>(null);
  const [selectedAccount, setSelectedAccount] = useState<BankAccount | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    // Tenta buscar da view; fallback para tabela base se a view ainda não existir
    const { data, error } = await supabase
      .from('vw_bank_account_balances')
      .select('*');

    if (error) {
      // view pode não ter sido criada ainda
      const { data: fallback } = await supabase
        .from('bank_accounts')
        .select('*')
        .eq('is_active', true)
        .order('name');
      setAccounts((fallback ?? []) as BankAccount[]);
    } else {
      setAccounts((data ?? []) as BankAccount[]);
    }
    setLoading(false);
  }, []);

  useEffect(() => { load(); }, [load]);

  const handleSave = async (formData: AccountForm) => {
    const payload = {
      name: formData.name.trim(),
      bank: formData.bank.trim() || null,
      type: formData.type,
      initial_balance: parseAmt(formData.initial_balance),
      color: formData.color,
      notes: formData.notes.trim() || null,
      is_active: true,
    };

    if (editingAccount) {
      await supabase.from('bank_accounts').update(payload).eq('id', editingAccount.id);
    } else {
      await supabase.from('bank_accounts').insert(payload);
    }

    setShowModal(false);
    setEditingAccount(null);
    await load();
  };

  const handleDelete = async (account: BankAccount) => {
    if (!confirm(`Deseja desativar a conta "${account.name}"?\n\nO histórico de transações será mantido.`)) return;
    await supabase.from('bank_accounts').update({ is_active: false }).eq('id', account.id);
    await load();
  };

  const openEdit = (account: BankAccount) => {
    setEditingAccount(account);
    setShowModal(true);
  };

  const openNew = () => {
    setEditingAccount(null);
    setShowModal(true);
  };

  // Totais consolidados
  const totalBalance  = accounts.reduce((s, a) => s + (a.current_balance ?? a.initial_balance ?? 0), 0);
  const totalIncome   = accounts.reduce((s, a) => s + (a.total_income ?? 0), 0);
  const totalExpenses = accounts.reduce((s, a) => s + (a.total_expenses ?? 0), 0);

  return (
    <div className="space-y-4">

      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-base font-bold text-slate-800">Contas Bancárias</h2>
          <p className="text-xs text-slate-400 mt-0.5">Saldo calculado a partir das transações registradas</p>
        </div>
        <div className="flex items-center gap-2">
          <button onClick={load}
            className="p-2 rounded-lg border border-slate-200 text-slate-500 hover:bg-slate-50 transition"
            title="Atualizar">
            <RefreshCw size={14} />
          </button>
          <button onClick={openNew}
            className="flex items-center gap-1.5 px-3 py-2 rounded-lg bg-indigo-600 text-white text-xs font-semibold hover:bg-indigo-700 transition">
            <Plus size={14} /> Nova Conta
          </button>
        </div>
      </div>

      {/* Cards de resumo */}
      <div className="grid grid-cols-3 gap-3">
        {[
          { label: 'Saldo Total', value: totalBalance, icon: Wallet,
            color: totalBalance >= 0 ? 'text-emerald-600' : 'text-rose-600',
            bg: totalBalance >= 0 ? 'bg-emerald-50' : 'bg-rose-50' },
          { label: 'Total Entradas', value: totalIncome, icon: TrendingUp,
            color: 'text-sky-600', bg: 'bg-sky-50' },
          { label: 'Total Saídas', value: totalExpenses, icon: TrendingDown,
            color: 'text-orange-600', bg: 'bg-orange-50' },
        ].map((c, i) => (
          <div key={i} className="bg-white rounded-xl border border-slate-100 shadow-sm p-4 flex items-center gap-3">
            <div className={`p-2.5 rounded-lg shrink-0 ${c.bg}`}>
              <c.icon size={16} className={c.color} />
            </div>
            <div className="min-w-0">
              <p className="text-[10px] font-bold uppercase tracking-widest text-slate-400 truncate">{c.label}</p>
              <p className={`text-sm font-extrabold tabular-nums ${c.color}`}>{fmt(c.value)}</p>
            </div>
          </div>
        ))}
      </div>

      {/* Lista de contas */}
      {loading ? (
        <div className="flex items-center justify-center h-32 text-slate-400 text-sm">Carregando…</div>
      ) : accounts.length === 0 ? (
        <div className="flex flex-col items-center justify-center h-40 bg-white rounded-xl border border-slate-100 text-slate-400">
          <Landmark size={32} className="mb-2 opacity-20" />
          <p className="text-sm font-semibold">Nenhuma conta cadastrada</p>
          <button onClick={openNew}
            className="mt-3 flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-indigo-600 text-white text-xs font-semibold hover:bg-indigo-700 transition">
            <Plus size={13} /> Adicionar conta
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          {accounts.map(account => {
            const TypeIcon = typeIcon(account.type);
            const balance = account.current_balance ?? account.initial_balance ?? 0;
            return (
              <div key={account.id}
                className="bg-white rounded-xl border border-slate-100 shadow-sm overflow-hidden group">

                {/* Barra colorida topo */}
                <div className="h-1" style={{ backgroundColor: account.color }} />

                <div className="p-4">
                  {/* Header do card */}
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex items-center gap-2.5">
                      <div className="p-2 rounded-lg" style={{ backgroundColor: account.color + '18' }}>
                        <TypeIcon size={16} style={{ color: account.color }} />
                      </div>
                      <div>
                        <p className="text-sm font-bold text-slate-800 leading-tight">{account.name}</p>
                        <p className="text-[10px] text-slate-400">{account.bank ?? typeLabel(account.type)}</p>
                      </div>
                    </div>
                    {/* Ações */}
                    <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                      <button onClick={() => openEdit(account)}
                        className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 hover:text-slate-600">
                        <Pencil size={13} />
                      </button>
                      <button onClick={() => handleDelete(account)}
                        className="p-1.5 rounded-lg hover:bg-rose-50 text-slate-400 hover:text-rose-500">
                        <Trash2 size={13} />
                      </button>
                    </div>
                  </div>

                  {/* Saldo */}
                  <div className="mb-3">
                    <p className="text-[10px] font-bold uppercase tracking-widest text-slate-400 mb-0.5">Saldo atual</p>
                    <p className={`text-xl font-extrabold tabular-nums ${balance >= 0 ? 'text-slate-900' : 'text-rose-600'}`}>
                      {fmt(balance)}
                    </p>
                  </div>

                  {/* Entradas / Saídas */}
                  <div className="flex gap-3 mb-3">
                    <div className="flex-1 bg-emerald-50 rounded-lg p-2">
                      <p className="text-[9px] font-bold uppercase text-emerald-600 mb-0.5">Entradas</p>
                      <p className="text-xs font-bold text-emerald-700 tabular-nums">
                        {fmt(account.total_income ?? 0)}
                      </p>
                    </div>
                    <div className="flex-1 bg-rose-50 rounded-lg p-2">
                      <p className="text-[9px] font-bold uppercase text-rose-600 mb-0.5">Saídas</p>
                      <p className="text-xs font-bold text-rose-700 tabular-nums">
                        {fmt(account.total_expenses ?? 0)}
                      </p>
                    </div>
                  </div>

                  {/* Ver extrato */}
                  <button
                    onClick={() => setSelectedAccount(account)}
                    className="w-full flex items-center justify-center gap-1.5 py-1.5 rounded-lg border border-slate-200 text-xs font-semibold text-slate-600 hover:bg-slate-50 hover:border-slate-300 transition">
                    Ver extrato
                    <ChevronRight size={12} />
                  </button>
                </div>
              </div>
            );
          })}

          {/* Card de adicionar nova conta */}
          <button onClick={openNew}
            className="bg-slate-50 rounded-xl border border-dashed border-slate-200 p-4 flex flex-col items-center justify-center gap-2 text-slate-400 hover:border-indigo-300 hover:text-indigo-500 hover:bg-indigo-50/30 transition min-h-[160px]">
            <Plus size={20} />
            <span className="text-xs font-semibold">Adicionar conta</span>
          </button>
        </div>
      )}

      {/* Modal de cadastro/edição */}
      {showModal && (
        <AccountModal
          title={editingAccount ? 'Editar Conta' : 'Nova Conta Bancária'}
          initial={editingAccount
            ? {
                name: editingAccount.name,
                bank: editingAccount.bank ?? '',
                type: editingAccount.type,
                initial_balance: String(editingAccount.initial_balance ?? 0),
                color: editingAccount.color,
                notes: editingAccount.notes ?? '',
              }
            : EMPTY_FORM
          }
          onSave={handleSave}
          onClose={() => { setShowModal(false); setEditingAccount(null); }}
        />
      )}

      {/* Modal de extrato */}
      {selectedAccount && (
        <AccountDetail
          account={selectedAccount}
          onClose={() => setSelectedAccount(null)}
        />
      )}
    </div>
  );
};

export default ContasBancarias;
