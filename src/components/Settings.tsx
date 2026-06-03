import React, { useState } from 'react';
import {
  User, Briefcase, Building2, Shield, Clock,
  Plus, Pencil, Trash2, Check, X, Loader2, CheckCircle2, AlertCircle,
  Wallet,
} from 'lucide-react';
import { Professional, ClinicService } from '../types';
import { supabase } from '../services/supabaseClient';
import AvatarUpload from './AvatarUpload';
import FinancialSettings from './admin/FinancialSettings';

type SettingsTab = 'profissionais' | 'servicos' | 'clinica' | 'financeiro' | 'usuarios';
type ProfTab = 'dados' | 'horarios';
type Toast = { type: 'success' | 'error'; msg: string } | null;

const DAYS = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'];
const blankSchedule = () => DAYS.map(d => ({ day: d, active: d !== 'Domingo', start: '08:00', end: '18:00' }));

const PROF_COLORS: Record<string, { bg: string; border: string; label: string }> = {
  blue:    { bg: '#dbeafe', border: '#3b82f6', label: 'Azul'   },
  purple:  { bg: '#f3e8ff', border: '#9333ea', label: 'Roxo'   },
  emerald: { bg: '#d1fae5', border: '#10b981', label: 'Verde'  },
  teal:    { bg: '#ccfbf1', border: '#14b8a6', label: 'Teal'   },
  rose:    { bg: '#ffe4e6', border: '#f43f5e', label: 'Rosa'   },
  amber:   { bg: '#fef3c7', border: '#f59e0b', label: 'Ambar'  },
  indigo:  { bg: '#e0e7ff', border: '#6366f1', label: 'Indigo' },
};

const SERVICE_CATEGORIES = ['Consultas', 'Procedimentos', 'Estetica', 'Reabilitacao', 'Exames', 'Outros'];

interface Props {
  professionals: Professional[];
  services: ClinicService[];
  onRefreshProfessionals: () => void;
  onRefreshServices: () => void;
  session: any;
}

const TITLES = ['Nenhum', 'Sr.', 'Sra.', 'Dr.', 'Dra.', 'Prof.', 'Profa.'];
const COUNCILS = ['CRM', 'CRN', 'CRP', 'CRO', 'CREFITO', 'CRF', 'COREN', 'CFN', 'CRBM', 'CRTH', 'Outro'];
const UF_LIST = ['AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO'];

const blankProf = () => ({
  title: 'Nenhum', name: '', social_name: '', specialty: '', color: 'blue',
  email: '', phone: '', phone2: '', gender: '', birth_date: '',
  cpf: '', cns: '', council: 'CRM', council_number: '', council_uf: 'DF',
  rqe: '', observation: '', active: true,
});
const blankSvc  = () => ({ name: '', price: 0, duration: 60, duration_minutes: 60, category: 'Consultas', description: '' });

const Settings: React.FC<Props> = ({
  professionals, services, onRefreshProfessionals, onRefreshServices, session,
}) => {
  const [tab, setTab]     = useState<SettingsTab>('profissionais');
  const [toast, setToast] = useState<Toast>(null);
  const [saving, setSaving] = useState(false);

  const showToast = (type: 'success' | 'error', msg: string) => {
    setToast({ type, msg });
    setTimeout(() => setToast(null), 3500);
  };

  // Professional state
  const [editingProf, setEditingProf]   = useState<Professional | null>(null);
  const [profForm, setProfForm]         = useState(blankProf());
  const [showProfForm, setShowProfForm] = useState(false);
  const [profTab, setProfTab]           = useState<ProfTab>('dados');
  const [schedule, setSchedule]         = useState(blankSchedule());
  const [profPhoto, setProfPhoto]       = useState<string>('');

  const openNewProf  = () => { setProfForm(blankProf()); setEditingProf(null); setProfPhoto(''); setSchedule(blankSchedule()); setProfTab('dados'); setShowProfForm(true); };
  const openEditProf = (p: Professional) => {
    setEditingProf(p);
    setProfPhoto((p as any).photo_url || '');
    setSchedule(blankSchedule());
    setProfTab('dados');
    setProfForm({
      title: p.title || 'Nenhum', name: p.name, social_name: p.social_name || '',
      specialty: p.specialty, color: p.color, email: p.email || '', phone: p.phone || '',
      phone2: p.phone2 || '', gender: p.gender || '', birth_date: p.birth_date || '',
      cpf: p.cpf || '', cns: p.cns || '', council: p.council || 'CRM',
      council_number: p.council_number || '', council_uf: p.council_uf || 'DF',
      rqe: p.rqe || '', observation: p.observation || '', active: p.active ?? true,
    });
    setShowProfForm(true);
  };
  const cancelProfForm = () => { setShowProfForm(false); setEditingProf(null); };

  const saveProf = async () => {
    if (!profForm.name.trim()) { showToast('error', 'Nome e obrigatorio'); return; }
    try {
      setSaving(true);
      const payload = {
        title: profForm.title === 'Nenhum' ? null : profForm.title,
        name: profForm.name, social_name: profForm.social_name || null,
        specialty: profForm.specialty, color: profForm.color,
        email: profForm.email || null, phone: profForm.phone || null, phone2: profForm.phone2 || null,
        gender: profForm.gender || null, birth_date: profForm.birth_date || null,
        cpf: profForm.cpf || null, cns: profForm.cns || null,
        council: profForm.council || null, council_number: profForm.council_number || null,
        council_uf: profForm.council_uf || null, rqe: profForm.rqe || null,
        observation: profForm.observation || null, active: profForm.active,
        photo_url: profPhoto || null,
      };
      if (editingProf) {
        const { error } = await supabase.from('professionals').update(payload).eq('id', editingProf.id);
        if (error) throw error;
        showToast('success', 'Profissional atualizado!');
      } else {
        const { error } = await supabase.from('professionals').insert(payload);
        if (error) throw error;
        showToast('success', 'Profissional adicionado!');
      }
      cancelProfForm();
      onRefreshProfessionals();
    } catch (err: any) {
      showToast('error', err?.message || 'Erro ao salvar');
    } finally {
      setSaving(false);
    }
  };

  const deleteProf = async (p: Professional) => {
    if (!confirm('Remover "' + p.name + '"? Esta acao nao pode ser desfeita.')) return;
    try {
      setSaving(true);
      const { error } = await supabase.from('professionals').delete().eq('id', p.id);
      if (error) throw error;
      showToast('success', p.name + ' removido.');
      onRefreshProfessionals();
    } catch (err: any) {
      showToast('error', err?.message || 'Erro ao remover');
    } finally {
      setSaving(false);
    }
  };

  // Service state
  const [editingSvc, setEditingSvc]   = useState<ClinicService | null>(null);
  const [svcForm, setSvcForm]         = useState(blankSvc());
  const [showSvcForm, setShowSvcForm] = useState(false);

  const openNewSvc  = () => { setSvcForm(blankSvc()); setEditingSvc(null); setShowSvcForm(true); };
  const openEditSvc = (s: ClinicService) => {
    setEditingSvc(s);
    setSvcForm({ name: s.name, price: s.price, duration: s.duration || s.duration_minutes || 60,
      duration_minutes: s.duration_minutes || s.duration || 60, category: s.category, description: s.description || '' });
    setShowSvcForm(true);
  };
  const cancelSvcForm = () => { setShowSvcForm(false); setEditingSvc(null); };

  const saveSvc = async () => {
    if (!svcForm.name.trim()) { showToast('error', 'Nome e obrigatorio'); return; }
    const payload = { name: svcForm.name, price: svcForm.price, duration_minutes: svcForm.duration,
      category: svcForm.category, description: svcForm.description };
    try {
      setSaving(true);
      if (editingSvc) {
        const { error } = await supabase.from('services').update(payload).eq('id', editingSvc.id);
        if (error) throw error;
        showToast('success', 'Servico atualizado!');
      } else {
        const { error } = await supabase.from('services').insert(payload);
        if (error) throw error;
        showToast('success', 'Servico adicionado!');
      }
      cancelSvcForm();
      onRefreshServices();
    } catch (err: any) {
      showToast('error', err?.message || 'Erro ao salvar');
    } finally {
      setSaving(false);
    }
  };

  const deleteSvc = async (s: ClinicService) => {
    if (!confirm('Remover "' + s.name + '"? Esta acao nao pode ser desfeita.')) return;
    try {
      setSaving(true);
      const { error } = await supabase.from('services').delete().eq('id', s.id);
      if (error) throw error;
      showToast('success', s.name + ' removido.');
      onRefreshServices();
    } catch (err: any) {
      showToast('error', err?.message || 'Erro ao remover');
    } finally {
      setSaving(false);
    }
  };

  const TABS: { id: SettingsTab; label: string; Icon: React.ElementType }[] = [
    { id: 'profissionais', label: 'Profissionais', Icon: User      },
    { id: 'servicos',      label: 'Servicos',      Icon: Briefcase },
    { id: 'clinica',       label: 'Clinica',       Icon: Building2 },
    { id: 'financeiro',    label: 'Financeiro',    Icon: Wallet    },
    { id: 'usuarios',      label: 'Usuarios',      Icon: Shield    },
  ];

  return (
    <div className="h-full flex flex-col">

      {toast && (
        <div className={`fixed top-6 right-6 z-50 flex items-center gap-3 px-4 py-3 rounded-2xl shadow-2xl text-sm font-bold
          ${toast.type === 'success' ? 'bg-emerald-600 text-white' : 'bg-rose-600 text-white'}`}>
          {toast.type === 'success' ? <CheckCircle2 className="w-4 h-4" /> : <AlertCircle className="w-4 h-4" />}
          {toast.msg}
        </div>
      )}

      <div className="mb-6">
        <h2 className="text-2xl font-black text-slate-900 tracking-tight">Configuracoes</h2>
        <p className="text-slate-500 text-sm mt-1">Gerencie profissionais, servicos e dados da clinica</p>
      </div>

      <div className="flex gap-1 border-b border-slate-100 mb-6">
        {TABS.map(({ id, label, Icon }) => (
          <button key={id} onClick={() => setTab(id)}
            className={`flex items-center gap-2 px-4 py-3 text-[11px] font-black uppercase tracking-widest border-b-2 -mb-px transition-all
              ${tab === id ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-400 hover:text-slate-600'}`}
          >
            <Icon className="w-4 h-4" />
            {label}
          </button>
        ))}
      </div>

      {/* Profissionais */}
      {tab === 'profissionais' && (
        <div className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="flex items-center justify-between mb-4">
            <p className="text-xs text-slate-400 font-semibold">{professionals.length} cadastrado(s)</p>
            <button onClick={openNewProf}
              className="flex items-center gap-1.5 px-4 py-2 bg-indigo-600 text-white text-xs font-black rounded-xl hover:bg-indigo-700 transition-all shadow-md shadow-indigo-900/15">
              <Plus className="w-3.5 h-3.5" /> Novo Profissional
            </button>
          </div>

          {showProfForm && (
            <div className="mb-5 bg-white border border-slate-200 rounded-2xl shadow-sm overflow-hidden">

              {/* Header com foto + nome + toggle ativo */}
              <div className="flex items-center gap-4 px-5 py-4 bg-slate-50 border-b border-slate-100">
                <AvatarUpload
                  currentUrl={profPhoto}
                  name={profForm.name || 'Novo'}
                  color={PROF_COLORS[profForm.color]?.border || '#6366f1'}
                  size="md"
                  folder="professionals"
                  onUpload={url => setProfPhoto(url)}
                />
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-semibold text-slate-800">
                    {profForm.title && profForm.title !== 'Nenhum' ? profForm.title + ' ' : ''}{profForm.name || 'Novo Profissional'}
                  </p>
                  <p className="text-xs text-slate-400">{profForm.specialty || 'Especialidade não definida'}</p>
                </div>
                <label className="flex items-center gap-2 cursor-pointer shrink-0">
                  <span className="text-xs text-slate-500">Ativo</span>
                  <div className="relative" onClick={() => setProfForm(f => ({ ...f, active: !f.active }))}>
                    <div className={`w-9 h-5 rounded-full transition-colors ${profForm.active ? 'bg-indigo-600' : 'bg-slate-300'}`} />
                    <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${profForm.active ? 'translate-x-4' : ''}`} />
                  </div>
                </label>
              </div>

              {/* Abas */}
              <div className="flex border-b border-slate-100">
                {([
                  { id: 'dados',    label: 'Dados Principais', Icon: User  },
                  { id: 'horarios', label: 'Horários',         Icon: Clock },
                ] as { id: ProfTab; label: string; Icon: React.ElementType }[]).map(({ id, label, Icon }) => (
                  <button key={id} onClick={() => setProfTab(id)}
                    className={`flex items-center gap-1.5 px-4 py-2.5 text-xs font-medium border-b-2 -mb-px transition-all
                      ${profTab === id ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-400 hover:text-slate-600'}`}>
                    <Icon className="w-3.5 h-3.5" />{label}
                  </button>
                ))}
              </div>

              <div className="p-5 space-y-5">

                {/* ── ABA: DADOS PRINCIPAIS ── */}
                {profTab === 'dados' && (
                  <>
                    <div>
                      <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-widest mb-3">Identificação</p>
                      <div className="grid grid-cols-6 gap-3">
                        <div className="col-span-1 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Título</label>
                          <select className="premium-input appearance-none" value={profForm.title}
                            onChange={e => setProfForm(f => ({ ...f, title: e.target.value }))}>
                            {TITLES.map(t => <option key={t} value={t}>{t}</option>)}
                          </select>
                        </div>
                        <div className="col-span-3 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Nome *</label>
                          <input className="premium-input" placeholder="Nome completo"
                            value={profForm.name} onChange={e => setProfForm(f => ({ ...f, name: e.target.value }))} />
                        </div>
                        <div className="col-span-2 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Nome Social</label>
                          <input className="premium-input" placeholder="Como prefere ser chamado(a)"
                            value={profForm.social_name} onChange={e => setProfForm(f => ({ ...f, social_name: e.target.value }))} />
                        </div>
                        <div className="col-span-2 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Nascimento</label>
                          <input type="date" className="premium-input" value={profForm.birth_date}
                            onChange={e => setProfForm(f => ({ ...f, birth_date: e.target.value }))} />
                        </div>
                        <div className="col-span-2 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Sexo</label>
                          <select className="premium-input appearance-none" value={profForm.gender}
                            onChange={e => setProfForm(f => ({ ...f, gender: e.target.value }))}>
                            <option value="">Selecione</option>
                            <option>Masculino</option><option>Feminino</option><option>Outro</option>
                          </select>
                        </div>
                        <div className="col-span-2 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">CPF</label>
                          <input className="premium-input" placeholder="000.000.000-00" value={profForm.cpf}
                            onChange={e => setProfForm(f => ({ ...f, cpf: e.target.value }))} />
                        </div>
                        <div className="col-span-3 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Especialidade</label>
                          <input className="premium-input" placeholder="Ex: Nutrição, Fisioterapia" value={profForm.specialty}
                            onChange={e => setProfForm(f => ({ ...f, specialty: e.target.value }))} />
                        </div>
                        <div className="col-span-3 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">CNS</label>
                          <input className="premium-input" placeholder="Cartão Nacional de Saúde" value={profForm.cns}
                            onChange={e => setProfForm(f => ({ ...f, cns: e.target.value }))} />
                        </div>
                      </div>
                    </div>

                    <div>
                      <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-widest mb-3">Registro no Conselho</p>
                      <div className="grid grid-cols-6 gap-3">
                        <div className="col-span-2 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Conselho</label>
                          <select className="premium-input appearance-none" value={profForm.council}
                            onChange={e => setProfForm(f => ({ ...f, council: e.target.value }))}>
                            {COUNCILS.map(c => <option key={c} value={c}>{c}</option>)}
                          </select>
                        </div>
                        <div className="col-span-2 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Número</label>
                          <input className="premium-input" placeholder="Ex: 18400" value={profForm.council_number}
                            onChange={e => setProfForm(f => ({ ...f, council_number: e.target.value }))} />
                        </div>
                        <div className="col-span-1 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">UF</label>
                          <select className="premium-input appearance-none" value={profForm.council_uf}
                            onChange={e => setProfForm(f => ({ ...f, council_uf: e.target.value }))}>
                            {UF_LIST.map(uf => <option key={uf} value={uf}>{uf}</option>)}
                          </select>
                        </div>
                        <div className="col-span-1 space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">RQE</label>
                          <input className="premium-input" placeholder="RQE" value={profForm.rqe}
                            onChange={e => setProfForm(f => ({ ...f, rqe: e.target.value }))} />
                        </div>
                      </div>
                    </div>

                    <div>
                      <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-widest mb-3">Contato</p>
                      <div className="grid grid-cols-3 gap-3">
                        <div className="space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Celular</label>
                          <input className="premium-input" placeholder="(61) 99999-9999" value={profForm.phone}
                            onChange={e => setProfForm(f => ({ ...f, phone: e.target.value }))} />
                        </div>
                        <div className="space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">Telefone</label>
                          <input className="premium-input" placeholder="(61) 3333-4444" value={profForm.phone2}
                            onChange={e => setProfForm(f => ({ ...f, phone2: e.target.value }))} />
                        </div>
                        <div className="space-y-1">
                          <label className="text-[10px] text-slate-400 uppercase tracking-wider">E-mail</label>
                          <input type="email" className="premium-input" placeholder="email@clinica.com" value={profForm.email}
                            onChange={e => setProfForm(f => ({ ...f, email: e.target.value }))} />
                        </div>
                      </div>
                    </div>

                    <div className="grid grid-cols-2 gap-5">
                      <div>
                        <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-widest mb-3">Cor na Agenda</p>
                        <div className="flex gap-2 flex-wrap">
                          {Object.entries(PROF_COLORS).map(([key, val]) => (
                            <button key={key} type="button" title={val.label}
                              onClick={() => setProfForm(f => ({ ...f, color: key }))}
                              style={{ background: val.bg, border: '2px solid ' + val.border }}
                              className={`w-7 h-7 rounded-lg transition-all ${profForm.color === key ? 'ring-2 ring-offset-1 ring-slate-600 scale-110' : 'opacity-70 hover:opacity-100'}`}
                            />
                          ))}
                        </div>
                      </div>
                      <div>
                        <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-widest mb-3">Observações</p>
                        <textarea className="premium-input resize-none h-16 text-sm" placeholder="Observações internas..."
                          value={profForm.observation}
                          onChange={e => setProfForm(f => ({ ...f, observation: e.target.value }))} />
                      </div>
                    </div>
                  </>
                )}

                {/* ── ABA: HORÁRIOS ── */}
                {profTab === 'horarios' && (
                  <div>
                    <p className="text-[10px] font-semibold text-slate-400 uppercase tracking-widest mb-4">Horários de Atendimento</p>
                    <div className="space-y-2">
                      {schedule.map((row, i) => (
                        <div key={row.day} className="flex items-center gap-3">
                          <button type="button"
                            onClick={() => setSchedule(s => s.map((r, j) => j === i ? { ...r, active: !r.active } : r))}
                            className={`w-5 h-5 rounded flex items-center justify-center border transition-all shrink-0
                              ${row.active ? 'bg-indigo-600 border-indigo-600 text-white' : 'border-slate-300 bg-white'}`}>
                            {row.active && <Check className="w-3 h-3" />}
                          </button>
                          <span className={`text-xs w-20 shrink-0 ${row.active ? 'text-slate-700 font-medium' : 'text-slate-400'}`}>
                            {row.day}
                          </span>
                          {row.active ? (
                            <div className="flex items-center gap-2 flex-1">
                              <input type="time" value={row.start}
                                onChange={e => setSchedule(s => s.map((r, j) => j === i ? { ...r, start: e.target.value } : r))}
                                className="premium-input py-1.5 text-sm w-28" />
                              <span className="text-slate-400 text-xs">até</span>
                              <input type="time" value={row.end}
                                onChange={e => setSchedule(s => s.map((r, j) => j === i ? { ...r, end: e.target.value } : r))}
                                className="premium-input py-1.5 text-sm w-28" />
                            </div>
                          ) : (
                            <span className="text-xs text-slate-400 italic">Não atende</span>
                          )}
                        </div>
                      ))}
                    </div>
                    <p className="text-[10px] text-slate-400 mt-4">
                      * Os horários são salvos localmente por enquanto. Integração com banco de dados em breve.
                    </p>
                  </div>
                )}

                <div className="flex gap-2 pt-1 border-t border-slate-100">
                  <button onClick={cancelProfForm} className="px-4 py-2 border border-slate-200 text-slate-500 text-xs font-medium rounded-xl hover:bg-slate-100 transition-all">
                    Cancelar
                  </button>
                  <button onClick={saveProf} disabled={saving}
                    className="flex items-center gap-1.5 px-4 py-2 bg-indigo-600 text-white text-xs font-medium rounded-xl hover:bg-indigo-700 disabled:opacity-50 transition-all">
                    {saving ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Check className="w-3.5 h-3.5" />}
                    Salvar Profissional
                  </button>
                </div>
              </div>
            </div>
          )}

          <div className="space-y-2">
            {professionals.length === 0 ? (
              <div className="text-center py-12">
                <User className="w-10 h-10 mx-auto mb-2 opacity-20 text-slate-400" />
                <p className="text-sm font-bold text-slate-400">Nenhum profissional cadastrado</p>
                <p className="text-xs text-slate-400 mt-1">Clique em "Novo Profissional" para comecar</p>
              </div>
            ) : professionals.map(p => {
              const colors = PROF_COLORS[p.color] || PROF_COLORS['blue'];
              return (
                <div key={p.id} className="flex items-center gap-4 bg-white border border-slate-100 rounded-2xl px-4 py-3.5 shadow-sm hover:shadow-md transition-shadow">
                  <div className="w-10 h-10 rounded-full overflow-hidden flex items-center justify-center font-semibold text-sm shrink-0"
                    style={{ background: colors.bg, color: colors.border }}>
                    {(p as any).photo_url
                      ? <img src={(p as any).photo_url} alt={p.name} className="w-full h-full object-cover" />
                      : p.name.slice(0, 2).toUpperCase()}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-semibold text-slate-800 truncate">
                      {p.title && p.title !== 'Nenhum' ? p.title + ' ' : ''}{p.name}
                    </p>
                    <p className="text-xs text-slate-400">
                      {p.specialty || 'Sem especialidade'}
                      {(p as any).council && (p as any).council_number && (
                        <span className="ml-2 text-slate-300">·</span>
                      )}
                      {(p as any).council && (p as any).council_number && (
                        <span className="ml-1 text-indigo-400 font-medium">
                          {(p as any).council} {(p as any).council_number}{(p as any).council_uf ? `/${(p as any).council_uf}` : ''}
                        </span>
                      )}
                    </p>
                  </div>
                  <div className="flex items-center gap-1 shrink-0">
                    <div className="w-3 h-3 rounded-full mr-2" style={{ background: colors.border }} />
                    <button onClick={() => openEditProf(p)} className="w-8 h-8 flex items-center justify-center rounded-xl text-slate-400 hover:bg-slate-100 hover:text-indigo-600 transition-all">
                      <Pencil className="w-3.5 h-3.5" />
                    </button>
                    <button onClick={() => deleteProf(p)} className="w-8 h-8 flex items-center justify-center rounded-xl text-slate-400 hover:bg-rose-50 hover:text-rose-500 transition-all">
                      <Trash2 className="w-3.5 h-3.5" />
                    </button>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Servicos */}
      {tab === 'servicos' && (
        <div className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="flex items-center justify-between mb-4">
            <p className="text-xs text-slate-400 font-semibold">{services.length} cadastrado(s)</p>
            <button onClick={openNewSvc}
              className="flex items-center gap-1.5 px-4 py-2 bg-indigo-600 text-white text-xs font-black rounded-xl hover:bg-indigo-700 transition-all shadow-md shadow-indigo-900/15">
              <Plus className="w-3.5 h-3.5" /> Novo Servico
            </button>
          </div>

          {showSvcForm && (
            <div className="mb-5 bg-slate-50 border border-slate-200 rounded-2xl p-5 space-y-4">
              <h4 className="text-sm font-black text-slate-800">{editingSvc ? 'Editar Servico' : 'Novo Servico'}</h4>
              <div className="grid grid-cols-2 gap-3">
                <div className="col-span-2 space-y-1">
                  <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Nome *</label>
                  <input className="premium-input" placeholder="Ex: Consulta Medica"
                    value={svcForm.name} onChange={e => setSvcForm(f => ({ ...f, name: e.target.value }))} />
                </div>
                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Categoria</label>
                  <select className="premium-input appearance-none" value={svcForm.category}
                    onChange={e => setSvcForm(f => ({ ...f, category: e.target.value }))}>
                    {SERVICE_CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
                  </select>
                </div>
                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Duracao (min)</label>
                  <input type="number" min={15} step={15} className="premium-input" placeholder="60"
                    value={svcForm.duration}
                    onChange={e => setSvcForm(f => ({ ...f, duration: Number(e.target.value), duration_minutes: Number(e.target.value) }))} />
                </div>
                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Preco (R$)</label>
                  <input type="number" min={0} step={0.01} className="premium-input" placeholder="0,00"
                    value={svcForm.price} onChange={e => setSvcForm(f => ({ ...f, price: Number(e.target.value) }))} />
                </div>
                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Descricao</label>
                  <input className="premium-input" placeholder="Descricao opcional"
                    value={svcForm.description} onChange={e => setSvcForm(f => ({ ...f, description: e.target.value }))} />
                </div>
              </div>
              <div className="flex gap-2 pt-1">
                <button onClick={cancelSvcForm} className="px-4 py-2 border border-slate-200 text-slate-500 text-xs font-bold rounded-xl hover:bg-slate-100 transition-all">
                  Cancelar
                </button>
                <button onClick={saveSvc} disabled={saving}
                  className="flex items-center gap-1.5 px-4 py-2 bg-indigo-600 text-white text-xs font-bold rounded-xl hover:bg-indigo-700 disabled:opacity-50 transition-all">
                  {saving ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Check className="w-3.5 h-3.5" />}
                  Salvar
                </button>
              </div>
            </div>
          )}

          <div className="space-y-2">
            {services.length === 0 ? (
              <div className="text-center py-12">
                <Briefcase className="w-10 h-10 mx-auto mb-2 opacity-20 text-slate-400" />
                <p className="text-sm font-bold text-slate-400">Nenhum servico cadastrado</p>
                <p className="text-xs text-slate-400 mt-1">Clique em "Novo Servico" para comecar</p>
              </div>
            ) : services.map(s => (
              <div key={s.id} className="flex items-center gap-4 bg-white border border-slate-100 rounded-2xl px-4 py-3.5 shadow-sm hover:shadow-md transition-shadow">
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <p className="text-sm font-black text-slate-800 truncate">{s.name}</p>
                    <span className="px-2 py-0.5 bg-slate-100 text-slate-500 text-[10px] font-black rounded-full uppercase tracking-wide shrink-0">
                      {s.category}
                    </span>
                  </div>
                  <div className="flex items-center gap-3 mt-0.5">
                    <p className="text-xs text-slate-400 font-semibold">{s.duration_minutes || s.duration || 60} min</p>
                    {s.price > 0 && (
                      <p className="text-xs font-bold text-emerald-600">
                        R$ {Number(s.price).toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
                      </p>
                    )}
                  </div>
                </div>
                <div className="flex items-center gap-1 shrink-0">
                  <button onClick={() => openEditSvc(s)} className="w-8 h-8 flex items-center justify-center rounded-xl text-slate-400 hover:bg-slate-100 hover:text-indigo-600 transition-all">
                    <Pencil className="w-3.5 h-3.5" />
                  </button>
                  <button onClick={() => deleteSvc(s)} className="w-8 h-8 flex items-center justify-center rounded-xl text-slate-400 hover:bg-rose-50 hover:text-rose-500 transition-all">
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Clinica */}
      {tab === 'clinica' && (
        <div className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="max-w-lg space-y-5">
            <div className="bg-amber-50 border border-amber-100 rounded-2xl px-4 py-3 flex items-center gap-3">
              <AlertCircle className="w-4 h-4 text-amber-500 shrink-0" />
              <p className="text-xs font-semibold text-amber-700">
                Configuracoes da clinica serao salvas no Supabase em uma proxima versao.
              </p>
            </div>
            <div className="space-y-4">
              <div className="space-y-1">
                <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Nome da Clinica</label>
                <input className="premium-input" placeholder="Ex: Clinica Saude Integrada" />
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Telefone</label>
                  <input className="premium-input" placeholder="(11) 3333-4444" />
                </div>
                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">CNPJ</label>
                  <input className="premium-input" placeholder="00.000.000/0001-00" />
                </div>
              </div>
              <div className="space-y-1">
                <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest">Endereco</label>
                <input className="premium-input" placeholder="Rua, numero, cidade, estado" />
              </div>
              <div className="pt-2">
                <label className="text-[10px] font-black uppercase text-slate-400 tracking-widest block mb-2">Horario de Funcionamento</label>
                <div className="space-y-2">
                  {[
                    { day: 'Segunda - Sexta', def: '08:00 - 18:00' },
                    { day: 'Sabado',          def: '08:00 - 13:00' },
                    { day: 'Domingo',         def: 'Fechado'       },
                  ].map(row => (
                    <div key={row.day} className="flex items-center gap-3">
                      <span className="text-xs font-bold text-slate-500 w-36 shrink-0">{row.day}</span>
                      <input className="premium-input" defaultValue={row.def} />
                    </div>
                  ))}
                </div>
              </div>
            </div>
            <button disabled className="flex items-center gap-2 px-5 py-2.5 bg-indigo-100 text-indigo-400 text-sm font-bold rounded-xl cursor-not-allowed">
              <Check className="w-4 h-4" /> Salvar (em breve)
            </button>
          </div>
        </div>
      )}

      {/* Financeiro */}
      {tab === 'financeiro' && (
        <div className="flex-1 overflow-y-auto custom-scrollbar">
          <FinancialSettings />
        </div>
      )}

      {/* Usuarios */}
      {tab === 'usuarios' && (
        <div className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="max-w-lg space-y-5">
            <div className="bg-white border border-slate-100 rounded-2xl p-5 shadow-sm">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 bg-indigo-100 rounded-2xl flex items-center justify-center">
                  <Shield className="w-5 h-5 text-indigo-600" />
                </div>
                <div>
                  <p className="text-sm font-black text-slate-800">Usuario Atual</p>
                  <p className="text-xs text-slate-400 font-semibold">{session?.user?.email || '—'}</p>
                </div>
                <span className="ml-auto px-3 py-1 bg-indigo-100 text-indigo-700 text-[10px] font-black uppercase rounded-full tracking-widest">
                  ADMIN
                </span>
              </div>
              <div className="bg-slate-50 rounded-xl p-3 text-xs text-slate-500 font-semibold leading-relaxed">
                Voce tem acesso total ao sistema. O gerenciamento de multiplos usuarios com roles diferentes estara disponivel em uma proxima versao.
              </div>
            </div>
            <div className="bg-amber-50 border border-amber-100 rounded-2xl px-4 py-3 flex items-center gap-3">
              <AlertCircle className="w-4 h-4 text-amber-500 shrink-0" />
              <p className="text-xs font-semibold text-amber-700">
                Multi-usuario, convites por e-mail e controle de permissoes por role estarao disponiveis em breve.
              </p>
            </div>
          </div>
        </div>
      )}

    </div>
  );
};

export default Settings;
