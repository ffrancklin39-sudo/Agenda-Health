import React, { useState, useMemo, useEffect } from 'react';
import {
  DollarSign, Percent, Clock, AlertCircle, CheckCircle2,
  ChevronDown, ChevronUp, Info, Save, X,
} from 'lucide-react';
import { ProcedurePricing, ProfitBreakdown, PaymentMethod } from '../../types';
import { supabase } from '../../services/supabaseClient';

// ─── Helpers ────────────────────────────────────────────────────────────────

const PAYMENT_FEE_LABELS: Record<PaymentMethod, string> = {
  pix:           'PIX',
  debit:         'Débito',
  credit_1x:     'Crédito 1x',
  credit_2_6x:   'Crédito 2–6x',
  credit_7x_plus:'Crédito 7x+',
};

function calculateProfit(
  basePrice: number,
  fixedCost: number,
  taxPct: number,
  commissionPct: number,
  paymentFee: number,
): ProfitBreakdown {
  const taxAmount        = basePrice * (taxPct / 100);
  const paymentFeeAmount = basePrice * (paymentFee / 100);
  const netRevenue       = basePrice - taxAmount - paymentFeeAmount;
  const commissionAmount = netRevenue * (commissionPct / 100);
  const realProfit       = netRevenue - fixedCost - commissionAmount;
  const marginPercentage = basePrice > 0 ? (realProfit / basePrice) * 100 : 0;
  return {
    base_price: basePrice,
    tax_amount: taxAmount,
    payment_fee_amount: paymentFeeAmount,
    net_revenue: netRevenue,
    commission_amount: commissionAmount,
    fixed_cost: fixedCost,
    real_profit: realProfit,
    margin_percentage: marginPercentage,
  };
}

const fmt = (v: number) =>
  v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number) => `${v.toFixed(1)}%`;

// ─── Sub-componentes ─────────────────────────────────────────────────────────

interface FieldProps {
  label: string;
  hint?: string;
  icon?: React.ReactNode;
  children: React.ReactNode;
}
const Field: React.FC<FieldProps> = ({ label, hint, icon, children }) => (
  <div className="flex flex-col gap-1">
    <label className="text-xs font-medium text-slate-400 flex items-center gap-1">
      {icon && <span className="w-3.5 h-3.5">{icon}</span>}
      {label}
      {hint && (
        <span className="group relative cursor-default">
          <Info className="w-3 h-3 text-slate-500" />
          <span className="absolute left-5 top-0 z-10 hidden group-hover:block
                           bg-slate-800 text-slate-200 text-xs rounded px-2 py-1 w-48 shadow-lg">
            {hint}
          </span>
        </span>
      )}
    </label>
    {children}
  </div>
);

interface NumberInputProps {
  value: number;
  onChange: (v: number) => void;
  prefix?: string;
  suffix?: string;
  step?: number;
  min?: number;
  max?: number;
}
const NumberInput: React.FC<NumberInputProps> = ({
  value, onChange, prefix, suffix, step = 0.1, min = 0, max,
}) => (
  <div className="flex items-center bg-slate-800 border border-slate-700 rounded-lg
                  focus-within:border-indigo-500 focus-within:ring-1 focus-within:ring-indigo-500/40
                  transition-all overflow-hidden">
    {prefix && (
      <span className="px-2.5 text-slate-400 text-sm border-r border-slate-700 bg-slate-750 select-none">
        {prefix}
      </span>
    )}
    <input
      type="number"
      value={value}
      min={min}
      max={max}
      step={step}
      onChange={e => onChange(parseFloat(e.target.value) || 0)}
      className="flex-1 bg-transparent px-3 py-2 text-sm text-white outline-none
                 [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none
                 [&::-webkit-inner-spin-button]:appearance-none"
    />
    {suffix && (
      <span className="px-2.5 text-slate-400 text-sm border-l border-slate-700 select-none">
        {suffix}
      </span>
    )}
  </div>
);

// ─── Preview de Breakdown ────────────────────────────────────────────────────

interface BreakdownRowProps { label: string; value: number; sub?: boolean; highlight?: 'green' | 'red' | 'yellow' }
const BreakdownRow: React.FC<BreakdownRowProps> = ({ label, value, sub, highlight }) => {
  const color = highlight === 'green'  ? 'text-emerald-400'
              : highlight === 'red'    ? 'text-rose-400'
              : highlight === 'yellow' ? 'text-amber-400'
              : sub ? 'text-slate-400' : 'text-slate-200';
  return (
    <div className={`flex justify-between items-center py-0.5 ${sub ? 'pl-3' : ''}`}>
      <span className={`text-xs ${sub ? 'text-slate-500' : 'text-slate-400'}`}>{label}</span>
      <span className={`text-xs font-medium tabular-nums ${color}`}>{fmt(value)}</span>
    </div>
  );
};

interface ProfitPreviewProps {
  breakdown: ProfitBreakdown;
  paymentMethod: PaymentMethod;
  onChangeMethod: (m: PaymentMethod) => void;
}
const ProfitPreview: React.FC<ProfitPreviewProps> = ({ breakdown, paymentMethod, onChangeMethod }) => {
  const { margin_percentage, real_profit } = breakdown;
  const marginColor = margin_percentage >= 30 ? 'text-emerald-400'
                    : margin_percentage >= 15 ? 'text-amber-400'
                    : 'text-rose-400';
  const marginBg    = margin_percentage >= 30 ? 'bg-emerald-500/10 border-emerald-500/30'
                    : margin_percentage >= 15 ? 'bg-amber-500/10 border-amber-500/30'
                    : 'bg-rose-500/10 border-rose-500/30';
  const Icon        = margin_percentage >= 30 ? CheckCircle2 : AlertCircle;

  return (
    <div className="bg-slate-800/60 border border-slate-700 rounded-xl p-4 flex flex-col gap-3">
      <div className="flex items-center justify-between">
        <span className="text-xs font-semibold text-slate-300 uppercase tracking-wide">
          Simulador de Margem
        </span>
        <select
          value={paymentMethod}
          onChange={e => onChangeMethod(e.target.value as PaymentMethod)}
          className="text-xs bg-slate-700 border border-slate-600 rounded px-2 py-1
                     text-slate-300 outline-none focus:border-indigo-500"
        >
          {(Object.keys(PAYMENT_FEE_LABELS) as PaymentMethod[]).map(m => (
            <option key={m} value={m}>{PAYMENT_FEE_LABELS[m]}</option>
          ))}
        </select>
      </div>

      {/* Big margin indicator */}
      <div className={`flex items-center gap-3 rounded-lg border px-3 py-2 ${marginBg}`}>
        <Icon className={`w-5 h-5 flex-shrink-0 ${marginColor}`} />
        <div>
          <p className={`text-2xl font-bold tabular-nums ${marginColor}`}>
            {fmtPct(margin_percentage)}
          </p>
          <p className="text-xs text-slate-400">Margem de Lucro Real</p>
        </div>
        <div className="ml-auto text-right">
          <p className={`text-lg font-semibold tabular-nums ${real_profit >= 0 ? 'text-emerald-400' : 'text-rose-400'}`}>
            {fmt(real_profit)}
          </p>
          <p className="text-xs text-slate-400">Lucro / atend.</p>
        </div>
      </div>

      {/* Breakdown detalhado */}
      <div className="flex flex-col gap-0.5">
        <BreakdownRow label="Preço bruto" value={breakdown.base_price} />
        <BreakdownRow label="(-) Impostos" value={-breakdown.tax_amount} sub highlight="red" />
        <BreakdownRow label="(-) Taxa pagamento" value={-breakdown.payment_fee_amount} sub highlight="red" />
        <div className="border-t border-slate-700 my-1" />
        <BreakdownRow label="= Receita Líquida" value={breakdown.net_revenue} highlight="yellow" />
        <BreakdownRow label="(-) Comissão profissional" value={-breakdown.commission_amount} sub highlight="red" />
        <BreakdownRow label="(-) Custo de insumos" value={-breakdown.fixed_cost} sub highlight="red" />
        <div className="border-t border-slate-700 my-1" />
        <BreakdownRow label="= Lucro Real da Clínica" value={breakdown.real_profit} highlight={real_profit >= 0 ? 'green' : 'red'} />
      </div>
    </div>
  );
};

// ─── Formulário principal ────────────────────────────────────────────────────

interface Service { id: string; name: string; category: string; price: number; duration_minutes?: number; }

interface Props {
  onSave?: (pricing: ProcedurePricing) => void;
  onCancel?: () => void;
  initialData?: Partial<ProcedurePricing>;
}

const EMPTY: Omit<ProcedurePricing, 'id' | 'created_at' | 'updated_at'> = {
  service_id:                  '',
  base_price:                  0,
  fixed_cost:                  0,
  estimated_duration_minutes:  30,
  tax_percentage:              6,      // ISS padrão
  commission_percentage:       40,
  fee_pix:                     0,
  fee_debit:                   1.5,
  fee_credit_1x:               2.5,
  fee_credit_2_6x:             3.5,
  fee_credit_7x_plus:          4.5,
  active:                      true,
  notes:                       '',
};

const ProcedurePricingForm: React.FC<Props> = ({ onSave, onCancel, initialData }) => {
  const [form, setForm]               = useState({ ...EMPTY, ...initialData });
  const [services, setServices]       = useState<Service[]>([]);
  const [loading, setLoading]         = useState(false);
  const [saving, setSaving]           = useState(false);
  const [error, setError]             = useState<string | null>(null);
  const [previewMethod, setPreviewMethod] = useState<PaymentMethod>('pix');
  const [showAdvanced, setShowAdvanced]   = useState(false);

  // Carrega serviços cadastrados
  useEffect(() => {
    setLoading(true);
    supabase
      .from('services')
      .select('id, name, category, price, duration_minutes')
      .order('name')
      .then(({ data, error: err }) => {
        if (!err && data) setServices(data as Service[]);
        setLoading(false);
      });
  }, []);

  // Preenche automaticamente quando seleciona um serviço
  const handleServiceChange = (id: string) => {
    const svc = services.find(s => s.id === id);
    setForm(f => ({
      ...f,
      service_id:                 id,
      base_price:                 svc?.price ?? f.base_price,
      estimated_duration_minutes: svc?.duration_minutes ?? f.estimated_duration_minutes,
    }));
  };

  const paymentFeeForMethod: Record<PaymentMethod, keyof typeof form> = {
    pix:           'fee_pix',
    debit:         'fee_debit',
    credit_1x:     'fee_credit_1x',
    credit_2_6x:   'fee_credit_2_6x',
    credit_7x_plus:'fee_credit_7x_plus',
  };

  const preview = useMemo(() =>
    calculateProfit(
      form.base_price,
      form.fixed_cost,
      form.tax_percentage,
      form.commission_percentage,
      form[paymentFeeForMethod[previewMethod]] as number,
    ),
  [form, previewMethod]);

  const set = <K extends keyof typeof form>(key: K, value: typeof form[K]) =>
    setForm(f => ({ ...f, [key]: value }));

  const handleSave = async () => {
    if (!form.service_id) { setError('Selecione um procedimento/serviço.'); return; }
    if (form.base_price <= 0) { setError('Preço base deve ser maior que zero.'); return; }
    setSaving(true);
    setError(null);

    const payload = { ...form };
    const { data, error: dbErr } = initialData?.id
      ? await supabase.from('procedures_pricing').update(payload).eq('id', initialData.id).select().single()
      : await supabase.from('procedures_pricing').insert(payload).select().single();

    setSaving(false);
    if (dbErr) { setError(dbErr.message); return; }
    onSave?.(data as ProcedurePricing);
  };

  return (
    <div className="bg-slate-900 border border-slate-700 rounded-2xl overflow-hidden">
      {/* Header */}
      <div className="flex items-center justify-between px-5 py-4 border-b border-slate-800">
        <div className="flex items-center gap-2">
          <div className="p-1.5 bg-indigo-500/10 rounded-lg">
            <DollarSign className="w-4 h-4 text-indigo-400" />
          </div>
          <div>
            <h2 className="text-sm font-semibold text-white">Precificação do Procedimento</h2>
            <p className="text-xs text-slate-500">Faturamento é vaidade, lucro é sanidade.</p>
          </div>
        </div>
        {onCancel && (
          <button onClick={onCancel} className="p-1.5 rounded-lg hover:bg-slate-800 text-slate-400 hover:text-white transition-colors">
            <X className="w-4 h-4" />
          </button>
        )}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-0 md:divide-x md:divide-slate-800">
        {/* Coluna esquerda: Formulário */}
        <div className="p-5 flex flex-col gap-4">

          {/* Serviço */}
          <Field label="Procedimento / Serviço" icon={<Info className="w-3.5 h-3.5" />}>
            {loading ? (
              <div className="h-9 bg-slate-800 rounded-lg animate-pulse" />
            ) : (
              <select
                value={form.service_id}
                onChange={e => handleServiceChange(e.target.value)}
                className="w-full bg-slate-800 border border-slate-700 rounded-lg px-3 py-2
                           text-sm text-white outline-none focus:border-indigo-500 focus:ring-1
                           focus:ring-indigo-500/40 transition-all"
              >
                <option value="">Selecione um serviço…</option>
                {services.map(s => (
                  <option key={s.id} value={s.id}>{s.name} ({s.category})</option>
                ))}
              </select>
            )}
          </Field>

          {/* Linha: Preço + Custo */}
          <div className="grid grid-cols-2 gap-3">
            <Field
              label="Preço cobrado"
              hint="Valor cobrado do paciente"
              icon={<DollarSign className="w-3.5 h-3.5" />}
            >
              <NumberInput
                value={form.base_price}
                onChange={v => set('base_price', v)}
                prefix="R$"
                step={5}
              />
            </Field>
            <Field
              label="Custo de insumos"
              hint="Materiais consumidos no procedimento"
              icon={<DollarSign className="w-3.5 h-3.5" />}
            >
              <NumberInput
                value={form.fixed_cost}
                onChange={v => set('fixed_cost', v)}
                prefix="R$"
                step={1}
              />
            </Field>
          </div>

          {/* Linha: Impostos + Comissão */}
          <div className="grid grid-cols-2 gap-3">
            <Field
              label="Imposto (%)"
              hint="ISS, DAS, Simples etc."
              icon={<Percent className="w-3.5 h-3.5" />}
            >
              <NumberInput
                value={form.tax_percentage}
                onChange={v => set('tax_percentage', v)}
                suffix="%"
                max={100}
              />
            </Field>
            <Field
              label="Comissão (%)"
              hint="Calculada sobre receita líquida (após impostos e taxas)"
              icon={<Percent className="w-3.5 h-3.5" />}
            >
              <NumberInput
                value={form.commission_percentage}
                onChange={v => set('commission_percentage', v)}
                suffix="%"
                max={100}
              />
            </Field>
          </div>

          {/* Duração */}
          <Field
            label="Duração estimada"
            hint="Tempo de cadeira/sala bloqueado"
            icon={<Clock className="w-3.5 h-3.5" />}
          >
            <NumberInput
              value={form.estimated_duration_minutes}
              onChange={v => set('estimated_duration_minutes', v)}
              suffix="min"
              step={5}
              min={5}
            />
          </Field>

          {/* Taxas avançadas */}
          <button
            type="button"
            onClick={() => setShowAdvanced(v => !v)}
            className="flex items-center gap-2 text-xs text-slate-400 hover:text-slate-200 transition-colors"
          >
            {showAdvanced ? <ChevronUp className="w-3.5 h-3.5" /> : <ChevronDown className="w-3.5 h-3.5" />}
            Taxas por forma de pagamento
          </button>

          {showAdvanced && (
            <div className="grid grid-cols-2 gap-3 animate-in fade-in duration-200">
              {(Object.keys(PAYMENT_FEE_LABELS) as PaymentMethod[]).map(method => (
                <Field key={method} label={`Taxa ${PAYMENT_FEE_LABELS[method]}`} icon={<Percent className="w-3.5 h-3.5" />}>
                  <NumberInput
                    value={form[paymentFeeForMethod[method]] as number}
                    onChange={v => set(paymentFeeForMethod[method], v)}
                    suffix="%"
                    step={0.1}
                    max={20}
                  />
                </Field>
              ))}
            </div>
          )}

          {/* Observações */}
          <Field label="Observações">
            <textarea
              rows={2}
              value={form.notes ?? ''}
              onChange={e => set('notes', e.target.value)}
              placeholder="Ex: procedimento sazonal, precificação negociada…"
              className="w-full bg-slate-800 border border-slate-700 rounded-lg px-3 py-2
                         text-sm text-white placeholder-slate-600 outline-none resize-none
                         focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500/40 transition-all"
            />
          </Field>

          {/* Erro */}
          {error && (
            <div className="flex items-center gap-2 text-xs text-rose-400 bg-rose-500/10 border border-rose-500/30 rounded-lg px-3 py-2">
              <AlertCircle className="w-3.5 h-3.5 flex-shrink-0" />
              {error}
            </div>
          )}

          {/* Botão salvar */}
          <button
            onClick={handleSave}
            disabled={saving}
            className="flex items-center justify-center gap-2 bg-indigo-600 hover:bg-indigo-500
                       disabled:opacity-50 disabled:cursor-not-allowed text-white text-sm font-medium
                       rounded-xl px-4 py-2.5 transition-colors mt-1"
          >
            <Save className="w-4 h-4" />
            {saving ? 'Salvando…' : 'Salvar Precificação'}
          </button>
        </div>

        {/* Coluna direita: Preview */}
        <div className="p-5">
          <ProfitPreview
            breakdown={preview}
            paymentMethod={previewMethod}
            onChangeMethod={setPreviewMethod}
          />

          {/* Eficiência de agenda */}
          {form.estimated_duration_minutes > 0 && (
            <div className="mt-4 bg-slate-800/40 border border-slate-700 rounded-xl p-4">
              <p className="text-xs font-semibold text-slate-400 uppercase tracking-wide mb-3">
                Eficiência de Agenda
              </p>
              <div className="grid grid-cols-2 gap-3">
                <div className="text-center">
                  <p className="text-lg font-bold text-indigo-400 tabular-nums">
                    {preview.real_profit > 0
                      ? fmt(preview.real_profit / form.estimated_duration_minutes)
                      : 'R$ 0,00'}
                    <span className="text-xs font-normal text-slate-500">/min</span>
                  </p>
                  <p className="text-xs text-slate-500 mt-0.5">Lucro por minuto</p>
                </div>
                <div className="text-center">
                  <p className="text-lg font-bold text-purple-400 tabular-nums">
                    {form.estimated_duration_minutes}min
                  </p>
                  <p className="text-xs text-slate-500 mt-0.5">Tempo de cadeira</p>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default ProcedurePricingForm;
