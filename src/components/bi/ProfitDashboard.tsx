import React, { useState, useEffect, useMemo } from 'react';
import {
  TrendingUp, TrendingDown, AlertTriangle, Award,
  Clock, DollarSign, BarChart3, ChevronUp, ChevronDown,
  RefreshCw, Plus, Info,
} from 'lucide-react';
import { ProcedureProfitability, ProfitBreakdown, PaymentMethod } from '../../types';
import { supabase } from '../../services/supabaseClient';
import ProcedurePricingForm from './ProcedurePricingForm';

// ─── Helpers ─────────────────────────────────────────────────────────────────

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number, decimals = 1) => `${v.toFixed(decimals)}%`;

function getBreakdownForMethod(row: ProcedureProfitability, method: PaymentMethod): ProfitBreakdown {
  switch (method) {
    case 'debit':         return row.profit_debit;
    case 'credit_1x':     return row.profit_credit_1x;
    case 'credit_2_6x':   return row.profit_credit_2_6x;
    default:              return row.profit_pix;
  }
}

const PAYMENT_LABELS: Record<PaymentMethod, string> = {
  pix:           'PIX',
  debit:         'Débito',
  credit_1x:     'Crédito 1x',
  credit_2_6x:   'Crédito 2–6x',
  credit_7x_plus:'Crédito 7x+',
};

// Interpola entre vermelho e verde com âmbar no meio
function marginColor(pct: number): string {
  if (pct >= 35) return 'text-emerald-400';
  if (pct >= 20) return 'text-green-400';
  if (pct >= 10) return 'text-amber-400';
  if (pct >= 0)  return 'text-orange-400';
  return 'text-rose-400';
}
function marginBg(pct: number): string {
  if (pct >= 35) return 'bg-emerald-500/15';
  if (pct >= 20) return 'bg-green-500/15';
  if (pct >= 10) return 'bg-amber-500/15';
  if (pct >= 0)  return 'bg-orange-500/15';
  return 'bg-rose-500/15';
}

type SortKey = 'margin_pct' | 'real_profit' | 'profit_per_minute' | 'base_price';
type SortDir = 'asc' | 'desc';

// ─── Barra de ranking ─────────────────────────────────────────────────────────

interface RankBarProps {
  row: ProcedureProfitability;
  rank: number;
  method: PaymentMethod;
  maxProfit: number;
  onEdit: () => void;
}
const RankBar: React.FC<RankBarProps> = ({ row, rank, method, maxProfit, onEdit }) => {
  const [expanded, setExpanded] = useState(false);
  const bd     = getBreakdownForMethod(row, method);
  const pct    = bd.margin_percentage;
  const barW   = maxProfit > 0 ? Math.max(4, (bd.real_profit / maxProfit) * 100) : 4;
  const rankBg = rank === 1 ? 'bg-amber-500/20 text-amber-300 border-amber-500/40'
               : rank === 2 ? 'bg-slate-500/20 text-slate-300 border-slate-500/40'
               : rank === 3 ? 'bg-orange-500/20 text-orange-400 border-orange-500/40'
               : 'bg-slate-800 text-slate-500 border-slate-700';

  return (
    <div className="group">
      <div
        className="flex items-center gap-3 px-4 py-3 hover:bg-slate-800/50 rounded-xl
                   cursor-pointer transition-colors select-none"
        onClick={() => setExpanded(v => !v)}
      >
        {/* Rank badge */}
        <span className={`flex-shrink-0 w-7 h-7 flex items-center justify-center
                          rounded-lg border text-xs font-bold ${rankBg}`}>
          {rank}
        </span>

        {/* Nome + categoria */}
        <div className="flex-1 min-w-0">
          <p className="text-sm font-medium text-white truncate">{row.service_name}</p>
          <p className="text-xs text-slate-500 truncate">{row.service_category}</p>
        </div>

        {/* Barra de lucro */}
        <div className="hidden sm:flex flex-col gap-1 w-28">
          <div className="w-full h-1.5 bg-slate-700 rounded-full overflow-hidden">
            <div
              className={`h-full rounded-full transition-all duration-500 ${
                pct >= 20 ? 'bg-emerald-500' : pct >= 0 ? 'bg-amber-500' : 'bg-rose-500'
              }`}
              style={{ width: `${barW}%` }}
            />
          </div>
          <span className="text-xs text-slate-500 tabular-nums">{fmt(bd.real_profit)}</span>
        </div>

        {/* Margem % */}
        <div className={`flex-shrink-0 w-16 text-right rounded-lg px-2 py-1 ${marginBg(pct)}`}>
          <span className={`text-sm font-bold tabular-nums ${marginColor(pct)}`}>
            {fmtPct(pct)}
          </span>
        </div>

        {/* Lucro/min */}
        <div className="hidden md:flex flex-col items-end flex-shrink-0 w-20">
          <span className="text-xs font-medium text-purple-400 tabular-nums">
            {fmt(row.profit_per_minute)}/min
          </span>
          <span className="text-xs text-slate-500">{row.estimated_duration_minutes}min</span>
        </div>

        {expanded ? (
          <ChevronUp className="w-4 h-4 text-slate-500 flex-shrink-0" />
        ) : (
          <ChevronDown className="w-4 h-4 text-slate-500 flex-shrink-0 opacity-0 group-hover:opacity-100 transition-opacity" />
        )}
      </div>

      {/* Detalhe expandido */}
      {expanded && (
        <div className="mx-4 mb-3 bg-slate-800/60 border border-slate-700 rounded-xl p-4
                        grid grid-cols-2 sm:grid-cols-4 gap-3 animate-in fade-in duration-150">
          <MetricMini label="Preço bruto"        value={fmt(bd.base_price)} />
          <MetricMini label="(-) Impostos"        value={fmt(bd.tax_amount)} color="text-rose-400" />
          <MetricMini label="(-) Taxa pagamento"  value={fmt(bd.payment_fee_amount)} color="text-rose-400" />
          <MetricMini label="Receita líquida"     value={fmt(bd.net_revenue)} color="text-amber-400" />
          <MetricMini label="(-) Comissão"        value={fmt(bd.commission_amount)} color="text-rose-400" />
          <MetricMini label="(-) Insumos"         value={fmt(bd.fixed_cost)} color="text-rose-400" />
          <MetricMini label="Lucro real"          value={fmt(bd.real_profit)} color={bd.real_profit >= 0 ? 'text-emerald-400' : 'text-rose-400'} />
          <MetricMini label="Margem"              value={fmtPct(pct)} color={marginColor(pct)} />

          <div className="col-span-2 sm:col-span-4 flex justify-end mt-1">
            <button
              onClick={e => { e.stopPropagation(); onEdit(); }}
              className="text-xs text-indigo-400 hover:text-indigo-300 transition-colors"
            >
              Editar precificação →
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

interface MetricMiniProps { label: string; value: string; color?: string }
const MetricMini: React.FC<MetricMiniProps> = ({ label, value, color = 'text-white' }) => (
  <div>
    <p className="text-xs text-slate-500">{label}</p>
    <p className={`text-sm font-semibold tabular-nums ${color}`}>{value}</p>
  </div>
);

// ─── KPI cards ────────────────────────────────────────────────────────────────

interface KpiCardProps { label: string; value: string; sub?: string; icon: React.ReactNode; color: string }
const KpiCard: React.FC<KpiCardProps> = ({ label, value, sub, icon, color }) => (
  <div className="bg-slate-800/50 border border-slate-700 rounded-xl p-4 flex items-start gap-3">
    <div className={`p-2 rounded-lg ${color}`}>{icon}</div>
    <div className="flex-1 min-w-0">
      <p className="text-xs text-slate-400">{label}</p>
      <p className="text-lg font-bold text-white tabular-nums truncate">{value}</p>
      {sub && <p className="text-xs text-slate-500 truncate">{sub}</p>}
    </div>
  </div>
);

// ─── Dashboard principal ─────────────────────────────────────────────────────

const ProfitDashboard: React.FC = () => {
  const [rows, setRows]           = useState<ProcedureProfitability[]>([]);
  const [loading, setLoading]     = useState(true);
  const [error, setError]         = useState<string | null>(null);
  const [method, setMethod]       = useState<PaymentMethod>('pix');
  const [sortKey, setSortKey]     = useState<SortKey>('margin_pct');
  const [sortDir, setSortDir]     = useState<SortDir>('desc');
  const [editRow, setEditRow]     = useState<ProcedureProfitability | null>(null);
  const [showForm, setShowForm]   = useState(false);
  const [search, setSearch]       = useState('');

  const load = async () => {
    setLoading(true);
    setError(null);
    const { data, error: err } = await supabase
      .from('vw_procedure_profitability')
      .select('*');
    if (err) { setError(err.message); setLoading(false); return; }
    setRows((data ?? []) as ProcedureProfitability[]);
    setLoading(false);
  };

  useEffect(() => { load(); }, []);

  const filtered = useMemo(() => {
    let r = rows.filter(row =>
      !search || row.service_name.toLowerCase().includes(search.toLowerCase()),
    );
    r = r.sort((a, b) => {
      const bdA = getBreakdownForMethod(a, method);
      const bdB = getBreakdownForMethod(b, method);
      const va = sortKey === 'margin_pct'        ? bdA.margin_percentage
               : sortKey === 'real_profit'       ? bdA.real_profit
               : sortKey === 'profit_per_minute' ? a.profit_per_minute
               : a.base_price;
      const vb = sortKey === 'margin_pct'        ? bdB.margin_percentage
               : sortKey === 'real_profit'       ? bdB.real_profit
               : sortKey === 'profit_per_minute' ? b.profit_per_minute
               : b.base_price;
      return sortDir === 'desc' ? vb - va : va - vb;
    });
    return r;
  }, [rows, method, sortKey, sortDir, search]);

  const kpis = useMemo(() => {
    if (!filtered.length) return null;
    const margins = filtered.map(r => getBreakdownForMethod(r, method).margin_percentage);
    const avg     = margins.reduce((a, b) => a + b, 0) / margins.length;
    const best    = filtered[0];
    const worst   = [...filtered].reverse()[0];
    const negative = filtered.filter(r => getBreakdownForMethod(r, method).real_profit < 0).length;
    return { avg, best, worst, negative };
  }, [filtered, method]);

  const maxProfit = useMemo(
    () => Math.max(...filtered.map(r => getBreakdownForMethod(r, method).real_profit), 1),
    [filtered, method],
  );

  const toggleSort = (key: SortKey) => {
    if (sortKey === key) setSortDir(d => d === 'desc' ? 'asc' : 'desc');
    else { setSortKey(key); setSortDir('desc'); }
  };

  // ─── Render: loading ────────────────────────────────────────────────────────
  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <RefreshCw className="w-6 h-6 text-indigo-400 animate-spin" />
      </div>
    );
  }

  // ─── Render: form de cadastro/edição ────────────────────────────────────────
  if (showForm || editRow) {
    return (
      <div className="p-4">
        <ProcedurePricingForm
          initialData={editRow ?? undefined}
          onSave={() => { setShowForm(false); setEditRow(null); load(); }}
          onCancel={() => { setShowForm(false); setEditRow(null); }}
        />
      </div>
    );
  }

  // ─── Render: estado vazio ────────────────────────────────────────────────────
  if (!rows.length) {
    return (
      <div className="flex flex-col items-center justify-center h-64 gap-4">
        <BarChart3 className="w-12 h-12 text-slate-600" />
        <div className="text-center">
          <p className="text-slate-300 font-medium">Nenhum procedimento precificado</p>
          <p className="text-slate-500 text-sm mt-1">Cadastre a precificação dos serviços para ver a lucratividade real.</p>
        </div>
        <button
          onClick={() => setShowForm(true)}
          className="flex items-center gap-2 bg-indigo-600 hover:bg-indigo-500 text-white
                     text-sm font-medium rounded-xl px-4 py-2 transition-colors"
        >
          <Plus className="w-4 h-4" />
          Cadastrar precificação
        </button>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-5">

      {/* Header */}
      <div className="flex items-center justify-between flex-wrap gap-3">
        <div>
          <h1 className="text-lg font-bold text-white flex items-center gap-2">
            <BarChart3 className="w-5 h-5 text-indigo-400" />
            Lucratividade por Procedimento
          </h1>
          <p className="text-xs text-slate-500 mt-0.5">
            Faturamento é vaidade — aqui vemos o lucro real, deduzidos impostos, taxas e comissões.
          </p>
        </div>
        <button
          onClick={() => setShowForm(true)}
          className="flex items-center gap-2 bg-indigo-600 hover:bg-indigo-500 text-white
                     text-sm font-medium rounded-xl px-3 py-2 transition-colors"
        >
          <Plus className="w-4 h-4" />
          Novo
        </button>
      </div>

      {/* KPI cards */}
      {kpis && (
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
          <KpiCard
            label="Margem média"
            value={fmtPct(kpis.avg)}
            sub={`${filtered.length} procedimentos`}
            icon={<TrendingUp className="w-4 h-4 text-emerald-400" />}
            color="bg-emerald-500/10"
          />
          <KpiCard
            label="Mais lucrativo"
            value={fmtPct(getBreakdownForMethod(kpis.best, method).margin_percentage)}
            sub={kpis.best.service_name}
            icon={<Award className="w-4 h-4 text-amber-400" />}
            color="bg-amber-500/10"
          />
          <KpiCard
            label="Menor margem"
            value={fmtPct(getBreakdownForMethod(kpis.worst, method).margin_percentage)}
            sub={kpis.worst.service_name}
            icon={<TrendingDown className="w-4 h-4 text-rose-400" />}
            color="bg-rose-500/10"
          />
          <KpiCard
            label="Abaixo do zero"
            value={`${kpis.negative} proc.`}
            sub={kpis.negative > 0 ? 'Atenção: prejuízo!' : 'Todos lucrativos ✓'}
            icon={<AlertTriangle className={`w-4 h-4 ${kpis.negative > 0 ? 'text-rose-400' : 'text-emerald-400'}`} />}
            color={kpis.negative > 0 ? 'bg-rose-500/10' : 'bg-emerald-500/10'}
          />
        </div>
      )}

      {/* Método de pagamento + Busca */}
      <div className="flex items-center gap-3 flex-wrap">
        <div className="flex items-center gap-1 bg-slate-800 border border-slate-700 rounded-xl p-1">
          {(Object.keys(PAYMENT_LABELS) as PaymentMethod[])
            .filter(m => m !== 'credit_7x_plus')
            .map(m => (
            <button
              key={m}
              onClick={() => setMethod(m)}
              className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-colors ${
                method === m
                  ? 'bg-indigo-600 text-white'
                  : 'text-slate-400 hover:text-white'
              }`}
            >
              {PAYMENT_LABELS[m]}
            </button>
          ))}
        </div>

        <input
          type="text"
          placeholder="Buscar procedimento…"
          value={search}
          onChange={e => setSearch(e.target.value)}
          className="flex-1 min-w-40 bg-slate-800 border border-slate-700 rounded-xl px-3 py-2
                     text-sm text-white placeholder-slate-600 outline-none
                     focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500/40 transition-all"
        />

        <button
          onClick={load}
          className="p-2 rounded-xl border border-slate-700 bg-slate-800 hover:bg-slate-700
                     text-slate-400 hover:text-white transition-colors"
          title="Recarregar"
        >
          <RefreshCw className="w-4 h-4" />
        </button>
      </div>

      {/* Tabela / ranking */}
      <div className="bg-slate-900 border border-slate-800 rounded-2xl overflow-hidden">
        {/* Cabeçalho da tabela */}
        <div className="flex items-center gap-3 px-4 py-2.5 border-b border-slate-800 bg-slate-800/30">
          <span className="w-7 text-xs text-slate-500">#</span>
          <span className="flex-1 text-xs text-slate-500">Procedimento</span>
          <span className="hidden sm:block w-28 text-xs text-slate-500">Lucro (R$)</span>

          {/* Sorter: Margem */}
          <button
            onClick={() => toggleSort('margin_pct')}
            className={`w-16 text-right text-xs flex items-center justify-end gap-0.5 transition-colors ${
              sortKey === 'margin_pct' ? 'text-indigo-400' : 'text-slate-500 hover:text-slate-300'
            }`}
          >
            Margem
            {sortKey === 'margin_pct' && (
              sortDir === 'desc' ? <ChevronDown className="w-3 h-3" /> : <ChevronUp className="w-3 h-3" />
            )}
          </button>

          {/* Sorter: Lucro/min */}
          <button
            onClick={() => toggleSort('profit_per_minute')}
            className={`hidden md:flex w-20 text-right text-xs items-center justify-end gap-0.5 transition-colors ${
              sortKey === 'profit_per_minute' ? 'text-indigo-400' : 'text-slate-500 hover:text-slate-300'
            }`}
          >
            <Clock className="w-3 h-3" />
            /min
            {sortKey === 'profit_per_minute' && (
              sortDir === 'desc' ? <ChevronDown className="w-3 h-3" /> : <ChevronUp className="w-3 h-3" />
            )}
          </button>

          <span className="w-4" /> {/* expand icon space */}
        </div>

        {/* Linhas */}
        <div className="divide-y divide-slate-800/50">
          {filtered.map((row, i) => (
            <RankBar
              key={row.id}
              row={row}
              rank={i + 1}
              method={method}
              maxProfit={maxProfit}
              onEdit={() => setEditRow(row)}
            />
          ))}
        </div>
      </div>

      {/* Aviso se há procedimento negativo */}
      {kpis && kpis.negative > 0 && (
        <div className="flex items-start gap-3 bg-rose-500/10 border border-rose-500/30 rounded-xl px-4 py-3">
          <AlertTriangle className="w-4 h-4 text-rose-400 flex-shrink-0 mt-0.5" />
          <div>
            <p className="text-sm font-medium text-rose-300">
              {kpis.negative} procedimento{kpis.negative > 1 ? 's' : ''} com margem negativa
            </p>
            <p className="text-xs text-rose-400/80 mt-0.5">
              Esses procedimentos geram prejuízo com o método de pagamento selecionado.
              Revise a precificação ou renegocie comissões.
            </p>
          </div>
        </div>
      )}

      {/* Legenda de margem */}
      <div className="flex items-center gap-4 flex-wrap text-xs text-slate-500">
        <span className="flex items-center gap-1"><Info className="w-3 h-3" /> Legenda:</span>
        <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-emerald-500 inline-block" /> ≥35% Excelente</span>
        <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-green-500 inline-block" /> 20–35% Boa</span>
        <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-amber-500 inline-block" /> 10–20% Atenção</span>
        <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-rose-500 inline-block" /> &lt;0% Prejuízo</span>
      </div>
    </div>
  );
};

export default ProfitDashboard;
