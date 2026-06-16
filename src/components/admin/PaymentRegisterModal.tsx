import React, { useState, useEffect, useMemo } from 'react';
import {
  X, DollarSign, CreditCard, CheckCircle2, AlertCircle,
  Loader2, Receipt, ChevronDown,
} from 'lucide-react';
import { supabase } from '../../services/supabaseClient';
import {
  PaymentMethodFull, PAYMENT_METHOD_LABELS, Patient,
} from '../../types';

// ─── Tipos locais ─────────────────────────────────────────────

interface PricingRow {
  service_id: string;
  tax_percentage: number;
  commission_percentage: number;
  fixed_cost: number;
  fee_pix: number;
  fee_debit: number;
  fee_credit_1x: number;
  fee_credit_2_6x: number;
  fee_credit_7x_plus: number;
}

interface BreakdownPreview {
  feeAmount:    number;
  taxAmount:    number;
  netRevenue:   number;
  commission:   number;
  fixedCost:    number;
  realProfit:   number;
  marginPct:    number;
}

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number) => `${v.toFixed(1)}%`;

const METHOD_ICONS: Record<PaymentMethodFull, string> = {
  pix:            '🔵',
  debit:          '💳',
  credit_1x:      '💳',
  credit_2_6x:    '💳',
  credit_7x_plus: '💳',
  cash:           '💵',
  transfer:       '🏦',
  check:          '📄',
};

// ─── Preview de breakdown ─────────────────────────────────────

const BreakdownLine: React.FC<{ label: string; value: number; highlight?: string; indent?: boolean }> = ({
  label, value, highlight, indent,
}) => (
  <div className={`flex justify-between items-center py-0.5 ${indent ? 'pl-3' : ''}`}>
    <span className={`text-xs ${indent ? 'text-slate-500' : 'text-slate-600'}`}>{label}</span>
    <span className={`text-xs font-medium tabular-nums ${highlight ?? 'text-slate-700'}`}>{fmt(value)}</span>
  </div>
);

// ─── Componente principal ─────────────────────────────────────

interface Props {
  patient: Patient;
  onClose: () => void;
  onSuccess: () => void;
}

const PaymentRegisterModal: React.FC<Props> = ({ patient, onClose, onSuccess }) => {
  const [amount, setAmount]         = useState<number>(patient.price ?? 0);
  const [method, setMethod]         = useState<PaymentMethodFull>('pix');
  const [paymentDate, setPaymentDate] = useState(new Date().toISOString().slice(0, 16));
  const [notes, setNotes]           = useState('');
  const [pricing, setPricing]       = useState<PricingRow | null>(null);
  const [saving, setSaving]           = useState(false);
  const [saved, setSaved]             = useState(false);
  const [error, setError]             = useState<string | null>(null);
  const [dupWarning, setDupWarning]   = useState<string | null>(null);

  // Carrega precificação do serviço do paciente
  useEffect(() => {
    const serviceId = patient.service_id ?? patient.serviceId;
    if (!serviceId) return;
    supabase
      .from('procedures_pricing')
      .select('*')
      .eq('service_id', serviceId)
      .eq('active', true)
      .single()
      .then(({ data }) => { if (data) setPricing(data as PricingRow); });
  }, [patient]);

  // Preview calculado no front (mesmo algoritmo do trigger)
  const preview = useMemo((): BreakdownPreview => {
    const feePct = pricing
      ? ({
          pix:            pricing.fee_pix,
          debit:          pricing.fee_debit,
          credit_1x:      pricing.fee_credit_1x,
          credit_2_6x:    pricing.fee_credit_2_6x,
          credit_7x_plus: pricing.fee_credit_7x_plus,
          cash:           0,
          transfer:       0,
          check:          0,
        })[method]
      : ({ pix: 0, debit: 1.5, credit_1x: 2.5, credit_2_6x: 3.5, credit_7x_plus: 4.5, cash: 0, transfer: 0, check: 0 })[method];

    const taxPct    = pricing?.tax_percentage    ?? 6;
    const commPct   = pricing?.commission_percentage ?? 40;
    const fixedCost = pricing?.fixed_cost        ?? 0;

    const feeAmount  = amount * (feePct  / 100);
    const taxAmount  = amount * (taxPct  / 100);
    const netRevenue = amount - feeAmount - taxAmount;
    const commission = netRevenue * (commPct / 100);
    const realProfit = netRevenue - fixedCost - commission;
    const marginPct  = amount > 0 ? (realProfit / amount) * 100 : 0;

    return { feeAmount, taxAmount, netRevenue, commission, fixedCost, realProfit, marginPct };
  }, [amount, method, pricing]);

  const doInsert = async () => {
    setSaving(true);
    setError(null);
    setDupWarning(null);

    const { error: err } = await supabase.from('payments').insert({
      patient_id:      patient.id,
      professional_id: patient.professional_id ?? patient.professionalId ?? null,
      service_id:      patient.service_id ?? patient.serviceId ?? null,
      amount,
      payment_method:  method,
      status:          'paid',
      payment_date:    new Date(paymentDate).toISOString(),
      notes:           notes || null,
    });

    setSaving(false);
    if (err) { setError(err.message); return; }
    setSaved(true);
    setTimeout(() => { onSuccess(); onClose(); }, 1200);
  };

  const handleSave = async () => {
    if (!amount || amount <= 0) { setError('Informe o valor recebido.'); return; }

    // Verificar pagamento duplicado no mesmo dia
    const dayStart = new Date(); dayStart.setHours(0, 0, 0, 0);
    const dayEnd   = new Date(); dayEnd.setHours(23, 59, 59, 999);
    const { data: existing } = await supabase
      .from('payments')
      .select('id, amount, payment_date')
      .eq('patient_id', patient.id)
      .eq('status', 'paid')
      .gte('payment_date', dayStart.toISOString())
      .lte('payment_date', dayEnd.toISOString());

    if (existing && existing.length > 0) {
      setDupWarning(
        `Já existe ${existing.length} pagamento(s) registrado(s) hoje para este paciente. Confirma mesmo assim?`
      );
      return;
    }

    await doInsert();
  };

  const marginColor = preview.marginPct >= 25 ? 'text-emerald-600'
                    : preview.marginPct >= 10  ? 'text-amber-600'
                    : 'text-rose-500';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40 backdrop-blur-sm">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden animate-in fade-in zoom-in-95 duration-200">

        {/* Header */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-slate-100">
          <div className="flex items-center gap-2">
            <div className="p-1.5 bg-emerald-50 rounded-lg">
              <Receipt className="w-4 h-4 text-emerald-600" />
            </div>
            <div>
              <p className="text-sm font-semibold text-slate-800">Registrar Pagamento</p>
              <p className="text-xs text-slate-500">{patient.name}</p>
            </div>
          </div>
          <button onClick={onClose} className="p-1.5 rounded-lg hover:bg-slate-100 text-slate-400 transition-colors">
            <X className="w-4 h-4" />
          </button>
        </div>

        <div className="p-5 flex flex-col gap-4">

          {/* Valor */}
          <div className="flex flex-col gap-1">
            <label className="text-xs font-medium text-slate-500">Valor recebido</label>
            <div className="flex items-center bg-slate-50 border border-slate-200 rounded-xl focus-within:border-emerald-400 focus-within:ring-2 focus-within:ring-emerald-400/20 transition-all overflow-hidden">
              <span className="px-3 text-slate-400 text-sm border-r border-slate-200 py-3 bg-slate-100">R$</span>
              <input
                type="number"
                value={amount}
                min={0}
                step={0.01}
                onChange={e => setAmount(parseFloat(e.target.value) || 0)}
                className="flex-1 bg-transparent px-3 py-3 text-base font-semibold text-slate-800 outline-none [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none"
              />
            </div>
            {patient.price && patient.price !== amount && (
              <p className="text-xs text-amber-600">
                Valor tabelado: {fmt(patient.price)} — você alterou o valor cobrado.
              </p>
            )}
          </div>

          {/* Método de pagamento */}
          <div className="flex flex-col gap-1">
            <label className="text-xs font-medium text-slate-500">Forma de pagamento</label>
            <div className="grid grid-cols-4 gap-2">
              {(['pix', 'debit', 'credit_1x', 'credit_2_6x', 'credit_7x_plus', 'cash', 'transfer', 'check'] as PaymentMethodFull[]).map(m => (
                <button
                  key={m}
                  onClick={() => setMethod(m)}
                  className={`flex flex-col items-center gap-1 px-2 py-2.5 rounded-xl border text-center transition-all text-xs font-medium ${
                    method === m
                      ? 'bg-indigo-50 border-indigo-400 text-indigo-700'
                      : 'border-slate-200 text-slate-500 hover:border-slate-300 hover:bg-slate-50'
                  }`}
                >
                  <span className="text-base">{METHOD_ICONS[m]}</span>
                  <span className="leading-tight">{PAYMENT_METHOD_LABELS[m]}</span>
                </button>
              ))}
            </div>
          </div>

          {/* Data */}
          <div className="flex flex-col gap-1">
            <label className="text-xs font-medium text-slate-500">Data/hora do pagamento</label>
            <input
              type="datetime-local"
              value={paymentDate}
              onChange={e => setPaymentDate(e.target.value)}
              className="border border-slate-200 rounded-xl px-3 py-2.5 text-sm text-slate-700 outline-none focus:border-indigo-400 focus:ring-2 focus:ring-indigo-400/20 transition-all"
            />
          </div>

          {/* Preview de breakdown */}
          {amount > 0 && (
            <div className="bg-slate-50 border border-slate-200 rounded-xl p-4">
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs font-semibold text-slate-500 uppercase tracking-wide">Breakdown automático</span>
                <span className={`text-sm font-bold tabular-nums ${marginColor}`}>
                  {fmtPct(preview.marginPct)} margem
                </span>
              </div>
              <div className="flex flex-col gap-0.5">
                <BreakdownLine label="Valor cobrado"          value={amount} />
                <BreakdownLine label="(-) Taxa pagamento"     value={-preview.feeAmount}  indent highlight="text-rose-500" />
                <BreakdownLine label="(-) Impostos"           value={-preview.taxAmount}  indent highlight="text-rose-500" />
                <div className="border-t border-slate-200 my-1" />
                <BreakdownLine label="Receita líquida"        value={preview.netRevenue}  highlight="text-amber-600" />
                <BreakdownLine label="(-) Insumos"            value={-preview.fixedCost}  indent highlight="text-rose-500" />
                <BreakdownLine label="(-) Comissão profiss."  value={-preview.commission} indent highlight="text-rose-500" />
                <div className="border-t border-slate-200 my-1" />
                <BreakdownLine label="Lucro real da clínica"  value={preview.realProfit}
                  highlight={preview.realProfit >= 0 ? 'text-emerald-600 font-bold' : 'text-rose-500 font-bold'} />
              </div>
              {!pricing && (
                <p className="text-[10px] text-amber-600 mt-2">⚠ Usando estimativas padrão — serviço sem precificação cadastrada.</p>
              )}
            </div>
          )}

          {/* Observações */}
          <div className="flex flex-col gap-1">
            <label className="text-xs font-medium text-slate-500">Observações (opcional)</label>
            <textarea
              rows={2}
              value={notes}
              onChange={e => setNotes(e.target.value)}
              placeholder="Ex: parcela 1/3, desconto concedido..."
              className="border border-slate-200 rounded-xl px-3 py-2 text-sm text-slate-700 placeholder-slate-400 outline-none focus:border-indigo-400 focus:ring-2 focus:ring-indigo-400/20 transition-all resize-none"
            />
          </div>

          {/* Erro */}
          {error && (
            <div className="flex items-center gap-2 text-xs text-rose-600 bg-rose-50 border border-rose-200 rounded-xl px-3 py-2">
              <AlertCircle className="w-3.5 h-3.5 shrink-0" />
              {error}
            </div>
          )}

          {/* Aviso de pagamento duplicado */}
          {dupWarning && (
            <div className="bg-amber-50 border border-amber-300 rounded-xl p-3 flex flex-col gap-2">
              <div className="flex items-start gap-2 text-xs text-amber-800">
                <AlertCircle className="w-3.5 h-3.5 shrink-0 mt-0.5 text-amber-500" />
                <span>{dupWarning}</span>
              </div>
              <div className="flex gap-2">
                <button
                  onClick={() => setDupWarning(null)}
                  className="flex-1 py-1.5 text-xs font-semibold text-slate-600 bg-white border border-slate-200 rounded-lg hover:bg-slate-50 transition-colors"
                >
                  Cancelar
                </button>
                <button
                  onClick={doInsert}
                  disabled={saving}
                  className="flex-1 py-1.5 text-xs font-semibold text-white bg-amber-500 hover:bg-amber-600 rounded-lg transition-colors disabled:opacity-60"
                >
                  {saving ? 'Salvando...' : 'Registrar mesmo assim'}
                </button>
              </div>
            </div>
          )}

          {/* Botão principal */}
          {!dupWarning && (
            <button
              onClick={handleSave}
              disabled={saving || saved}
              className={`flex items-center justify-center gap-2 w-full py-3 rounded-xl font-semibold text-sm transition-all ${
                saved
                  ? 'bg-emerald-500 text-white'
                  : 'bg-indigo-600 hover:bg-indigo-500 text-white disabled:opacity-60'
              }`}
            >
              {saved   ? <><CheckCircle2 className="w-4 h-4" /> Pagamento registrado!</> :
               saving  ? <><Loader2 className="w-4 h-4 animate-spin" /> Salvando...</> :
                         <><DollarSign className="w-4 h-4" /> Confirmar pagamento</>}
            </button>
          )}

          <p className="text-[10px] text-slate-400 text-center">
            O cálculo de impostos, taxas e comissão é gerado automaticamente pelo sistema.
          </p>
        </div>
      </div>
    </div>
  );
};

export default PaymentRegisterModal;
