import React, { useState, useEffect } from 'react';
import {
  Save, Loader2, CheckCircle2, AlertCircle, Percent,
  Building2, CreditCard, Info, RefreshCw,
} from 'lucide-react';
import { supabase } from '../../services/supabaseClient';

// ─── Tipos ────────────────────────────────────────────────────

interface ClinicSetting {
  key: string;
  value: any;
  label: string;
  description: string;
  category: string;
}

type SettingsMap = Record<string, any>;

// ─── Helpers ──────────────────────────────────────────────────

const TAX_REGIMES = [
  { value: 'simples',          label: 'Simples Nacional' },
  { value: 'lucro_presumido',  label: 'Lucro Presumido' },
  { value: 'lucro_real',       label: 'Lucro Real' },
  { value: 'mei',              label: 'MEI' },
];

interface FieldProps { label: string; hint?: string; children: React.ReactNode }
const Field: React.FC<FieldProps> = ({ label, hint, children }) => (
  <div className="flex flex-col gap-1.5">
    <div className="flex items-center gap-1.5">
      <label className="text-xs font-semibold text-slate-600">{label}</label>
      {hint && (
        <span className="group relative cursor-default">
          <Info className="w-3 h-3 text-slate-400" />
          <span className="absolute left-5 top-0 z-10 hidden group-hover:block bg-slate-800 text-slate-200
                           text-xs rounded px-2 py-1.5 w-52 shadow-lg leading-relaxed">
            {hint}
          </span>
        </span>
      )}
    </div>
    {children}
  </div>
);

const inputCls = `w-full border border-slate-200 rounded-xl px-3 py-2.5 text-sm text-slate-800
  bg-white outline-none focus:border-indigo-400 focus:ring-2 focus:ring-indigo-400/20 transition-all`;

interface PctInputProps { value: number; onChange: (v: number) => void }
const PctInput: React.FC<PctInputProps> = ({ value, onChange }) => (
  <div className="flex items-center border border-slate-200 rounded-xl overflow-hidden
                  focus-within:border-indigo-400 focus-within:ring-2 focus-within:ring-indigo-400/20 transition-all">
    <input
      type="number" min={0} max={100} step={0.1}
      value={value}
      onChange={e => onChange(parseFloat(e.target.value) || 0)}
      className="flex-1 px-3 py-2.5 text-sm text-slate-800 outline-none
                 [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none
                 [&::-webkit-inner-spin-button]:appearance-none"
    />
    <span className="px-3 text-slate-400 text-sm border-l border-slate-200 bg-slate-50 select-none">%</span>
  </div>
);

// ─── Componente principal ─────────────────────────────────────

const FinancialSettings: React.FC = () => {
  const [settings, setSettings] = useState<SettingsMap>({});
  const [loading, setLoading]   = useState(true);
  const [saving, setSaving]     = useState(false);
  const [toast, setToast]       = useState<{ type: 'success' | 'error'; msg: string } | null>(null);

  const showToast = (type: 'success' | 'error', msg: string) => {
    setToast({ type, msg });
    setTimeout(() => setToast(null), 3000);
  };

  useEffect(() => {
    supabase.from('clinic_settings').select('key,value,label,description,category')
      .then(({ data, error }) => {
        if (error) { showToast('error', 'Erro ao carregar configurações'); return; }
        const map: SettingsMap = {};
        (data ?? []).forEach((s: ClinicSetting) => {
          try { map[s.key] = typeof s.value === 'string' ? JSON.parse(s.value) : s.value; }
          catch { map[s.key] = s.value; }
        });
        setSettings(map);
        setLoading(false);
      });
  }, []);

  const set = (key: string, value: any) =>
    setSettings(prev => ({ ...prev, [key]: value }));

  const save = async () => {
    setSaving(true);
    const updates = Object.entries(settings).map(([key, value]) =>
      supabase.from('clinic_settings')
        .update({ value: JSON.stringify(value), updated_at: new Date().toISOString() })
        .eq('key', key)
    );
    const results = await Promise.all(updates);
    const failed  = results.filter(r => r.error);
    setSaving(false);
    if (failed.length) showToast('error', `${failed.length} configuração(ões) não salva(s).`);
    else showToast('success', 'Configurações salvas com sucesso!');
  };

  if (loading) return (
    <div className="flex justify-center py-20">
      <RefreshCw className="w-5 h-5 text-indigo-400 animate-spin" />
    </div>
  );

  return (
    <div className="max-w-2xl space-y-6 py-2 pb-10">

      {/* Toast */}
      {toast && (
        <div className={`fixed top-6 right-6 z-50 flex items-center gap-3 px-4 py-3 rounded-2xl shadow-2xl text-sm font-bold
          ${toast.type === 'success' ? 'bg-emerald-600 text-white' : 'bg-rose-600 text-white'}`}>
          {toast.type === 'success' ? <CheckCircle2 className="w-4 h-4" /> : <AlertCircle className="w-4 h-4" />}
          {toast.msg}
        </div>
      )}

      {/* ── Dados da Clínica ── */}
      <section className="bg-white border border-slate-200 rounded-2xl p-5 shadow-sm">
        <div className="flex items-center gap-2 mb-4">
          <Building2 className="w-4 h-4 text-indigo-500" />
          <h3 className="text-sm font-bold text-slate-800">Dados da Clínica</h3>
        </div>
        <div className="grid grid-cols-1 gap-4">
          <Field label="Nome da Clínica" hint="Exibido em recibos e relatórios">
            <input
              className={inputCls}
              value={settings.clinic_name ?? ''}
              onChange={e => set('clinic_name', e.target.value)}
              placeholder="Ex: Clínica Saúde Integrada"
            />
          </Field>
        </div>
      </section>

      {/* ── Regime Fiscal ── */}
      <section className="bg-white border border-slate-200 rounded-2xl p-5 shadow-sm">
        <div className="flex items-center gap-2 mb-4">
          <Percent className="w-4 h-4 text-indigo-500" />
          <h3 className="text-sm font-bold text-slate-800">Configurações Fiscais</h3>
          <span className="ml-auto text-[10px] text-slate-400 bg-slate-100 rounded-full px-2 py-0.5">
            Usadas como padrão em todos os serviços
          </span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <Field label="Regime Tributário">
            <select
              value={settings.tax_regime ?? 'simples'}
              onChange={e => set('tax_regime', e.target.value)}
              className={inputCls}
            >
              {TAX_REGIMES.map(r => (
                <option key={r.value} value={r.value}>{r.label}</option>
              ))}
            </select>
          </Field>

          <Field
            label="Alíquota padrão (%)"
            hint="ISS ou alíquota efetiva do Simples sobre serviços de saúde. Pode variar por município."
          >
            <PctInput
              value={parseFloat(settings.default_tax_pct ?? 6)}
              onChange={v => set('default_tax_pct', v)}
            />
          </Field>

          <Field label="Município ISSQN" hint="Município onde o ISS é recolhido">
            <input
              className={inputCls}
              value={settings.issqn_city ?? ''}
              onChange={e => set('issqn_city', e.target.value)}
              placeholder="Ex: Brasília"
            />
          </Field>

          <Field
            label="Comissão padrão (%)"
            hint="Comissão padrão dos profissionais. Calculada sobre receita líquida (após impostos e taxas)."
          >
            <PctInput
              value={parseFloat(settings.default_commission_pct ?? 40)}
              onChange={v => set('default_commission_pct', v)}
            />
          </Field>
        </div>

        <div className="mt-4 flex items-start gap-2 bg-amber-50 border border-amber-200 rounded-xl px-3 py-2.5">
          <Info className="w-3.5 h-3.5 text-amber-500 shrink-0 mt-0.5" />
          <p className="text-xs text-amber-700">
            Ao salvar, novos serviços cadastrados em <strong>BI &amp; Margem</strong> usarão esses valores como padrão.
            Serviços já cadastrados não são alterados automaticamente.
          </p>
        </div>
      </section>

      {/* ── Taxas da Maquininha ── */}
      <section className="bg-white border border-slate-200 rounded-2xl p-5 shadow-sm">
        <div className="flex items-center gap-2 mb-1">
          <CreditCard className="w-4 h-4 text-indigo-500" />
          <h3 className="text-sm font-bold text-slate-800">Taxas da Maquininha</h3>
        </div>
        <p className="text-xs text-slate-400 mb-4">
          Cobradas pela operadora sobre cada transação. Deduzidas antes do cálculo de comissão.
        </p>

        <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
          {[
            { key: 'fee_pix',            label: 'PIX',              hint: 'Geralmente 0% no PIX' },
            { key: 'fee_debit',          label: 'Débito',           hint: 'Tipicamente 1.5–2%' },
            { key: 'fee_credit_1x',      label: 'Crédito 1x',       hint: 'Tipicamente 2–3%' },
            { key: 'fee_credit_2_6x',    label: 'Crédito 2–6x',     hint: 'Tipicamente 3–4%' },
            { key: 'fee_credit_7x_plus', label: 'Crédito 7x+',      hint: 'Tipicamente 4–5%' },
          ].map(({ key, label, hint }) => (
            <Field key={key} label={label} hint={hint}>
              <PctInput
                value={parseFloat(settings[key] ?? 0)}
                onChange={v => set(key, v)}
              />
            </Field>
          ))}
        </div>

        <div className="mt-4 flex items-start gap-2 bg-slate-50 border border-slate-200 rounded-xl px-3 py-2.5">
          <Info className="w-3.5 h-3.5 text-slate-400 shrink-0 mt-0.5" />
          <p className="text-xs text-slate-500">
            As taxas podem variar por operadora e volume mensal. Consulte seu contrato com Stone, Cielo, Rede etc.
            No <strong>BI &amp; Margem</strong> é possível definir taxas diferentes por procedimento.
          </p>
        </div>
      </section>

      {/* ── Alertas ── */}
      <section className="bg-white border border-slate-200 rounded-2xl p-5 shadow-sm">
        <div className="flex items-center gap-2 mb-4">
          <AlertCircle className="w-4 h-4 text-indigo-500" />
          <h3 className="text-sm font-bold text-slate-800">Alertas Automáticos</h3>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <Field
            label="Alerta de retenção (dias)"
            hint="Pacientes sem visita há mais do que X dias são marcados como 'em risco' no relatório de retenção."
          >
            <input
              type="number" min={1} max={365}
              value={parseInt(settings.retention_alert_days ?? 60)}
              onChange={e => set('retention_alert_days', parseInt(e.target.value) || 60)}
              className={inputCls}
            />
          </Field>
        </div>
      </section>

      {/* Botão salvar */}
      <div className="flex justify-end">
        <button
          onClick={save}
          disabled={saving}
          className="flex items-center gap-2 bg-indigo-600 hover:bg-indigo-500 disabled:opacity-60
                     text-white text-sm font-semibold rounded-xl px-5 py-2.5 transition-colors"
        >
          {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
          {saving ? 'Salvando...' : 'Salvar configurações'}
        </button>
      </div>
    </div>
  );
};

export default FinancialSettings;
