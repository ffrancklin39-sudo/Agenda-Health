import React, { useState, useEffect, useCallback } from 'react';
import {
  X, Save, Loader2, Download,
  User, Phone, Heart, ClipboardList, Paperclip,
  FileText, FileImage, ChevronDown, ChevronUp,
  Mic, Brain, Stethoscope, Pill, Calendar,
  Image, Clock, Receipt, ChevronLeft, ChevronRight,
  AlertCircle, ShieldPlus, Activity, Trash2,
  Plus, DollarSign, TrendingUp, CheckCircle2, XCircle,
} from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { Patient, PaymentFull, PAYMENT_METHOD_LABELS } from '../types';
import { phoneMatchKey, toTitleCase } from '../phoneUtils';
import AvatarUpload from './AvatarUpload';
import PaymentRegisterModal from './admin/PaymentRegisterModal';

/* -------------------------------------------------
   Tipos auxiliares
------------------------------------------------- */
type SideTab =
  | 'dados'
  | 'anamnese'
  | 'ia'
  | 'laudos'
  | 'prescricoes'
  | 'agendamentos'
  | 'arquivos'
  | 'timeline'
  | 'financeiro';

interface ClinicalRecord {
  id: string;
  record_type: string;
  content_text: string | null;
  content_html: string | null;
  professional: string | null;
  record_date: string | null;
}

interface PatientFile {
  id: string;
  file_name: string;
  file_type: string | null;
  folder: string | null;
  storage_path: string | null;
  description: string | null;
  file_size: number | null;
  record_date: string | null;
}

interface Props {
  patient: Patient | any;
  onClose: () => void;
  onRefresh?: () => void;
  onDeleted?: () => void;
}

/* -------------------------------------------------
   Constantes de estilo
------------------------------------------------- */
const I  = 'w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-500 outline-none transition-all text-sm text-slate-800';
const IS = I + ' appearance-none';
const LB = 'block text-[11px] font-bold uppercase text-slate-400 tracking-wider mb-1';
const ESTADOS = ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'];

const RECORD_LABELS: Record<string, { label: string; color: string }> = {
  prescricao:     { label: 'Prescricao',     color: 'bg-indigo-100 text-indigo-700'   },
  atestado:       { label: 'Atestado',       color: 'bg-emerald-100 text-emerald-700' },
  evolucao:       { label: 'Evolucao',       color: 'bg-sky-100 text-sky-700'         },
  anamnese:       { label: 'Anamnese',       color: 'bg-violet-100 text-violet-700'   },
  laudo:          { label: 'Laudo',          color: 'bg-amber-100 text-amber-700'     },
  encaminhamento: { label: 'Encaminhamento', color: 'bg-rose-100 text-rose-700'       },
  exame:          { label: 'Exame',          color: 'bg-cyan-100 text-cyan-700'       },
};

/* -------------------------------------------------
   Sidebar nav items
------------------------------------------------- */
const NAV_ITEMS: { id: SideTab; label: string; icon: React.ElementType; badge?: string }[] = [
  { id: 'dados',        label: 'Dados Principais',     icon: User         },
  { id: 'ia',           label: 'Resumos de IA',        icon: Brain,       badge: 'NOVO' },
  { id: 'anamnese',     label: 'Anamnese e Evolucoes', icon: Activity     },
  { id: 'laudos',       label: 'Laudos e Formularios', icon: FileText     },
  { id: 'prescricoes',  label: 'Prescricoes',          icon: Pill         },
  { id: 'agendamentos', label: 'Agendamentos',         icon: Calendar     },
  { id: 'arquivos',     label: 'Arquivos',             icon: Paperclip    },
  { id: 'timeline',     label: 'Linha do Tempo',       icon: Clock        },
  { id: 'financeiro',   label: 'Recibos / Financeiro', icon: Receipt      },
];

/* -------------------------------------------------
   Placeholder para abas nao implementadas
------------------------------------------------- */
const Placeholder: React.FC<{ icon: React.ElementType; label: string }> = ({ icon: Icon, label }) => (
  <div className="flex flex-col items-center justify-center h-full py-24 text-center">
    <div className="w-16 h-16 rounded-2xl bg-indigo-50 flex items-center justify-center mb-4">
      <Icon size={28} className="text-indigo-400" />
    </div>
    <p className="text-base font-bold text-slate-700">{label}</p>
    <p className="text-sm text-slate-400 mt-1 max-w-xs">Esta secao esta em desenvolvimento e estara disponivel em breve.</p>
  </div>
);

/* -------------------------------------------------
   Componente principal
------------------------------------------------- */
const PatientProfile: React.FC<Props> = ({ patient, onClose, onRefresh, onDeleted }) => {
  const [activeTab, setActiveTab]     = useState<SideTab>('dados');
  const [isSaving,  setIsSaving]      = useState(false);
  const [saveMsg,   setSaveMsg]       = useState('');
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
  const [isDeleting, setIsDeleting]   = useState(false);
  const [clinicalRecords, setClinicalRecords] = useState<ClinicalRecord[]>([]);
  const [patientFiles,    setPatientFiles]    = useState<PatientFile[]>([]);
  const [loadingRecords,  setLoadingRecords]  = useState(false);
  const [expandedRecord,  setExpandedRecord]  = useState<string | null>(null);

  /* Form */
  const empty = {
    name: '', social_name: '', cpf: '', rg: '', cns: '',
    birth_date: '', gender: '', skin_color: '', civil_status: '',
    profession: '', education: '', religion: '', nationality: '', birthplace: '',
    height: '', weight: '', record_number: '', priority: 'normal', alerts: '',
    phone: '', phone2: '', cell2: '', email: '', email2: '', instagram: '',
    address: '', address_number: '', address_complement: '',
    neighborhood: '', zip_code: '', city: '', state: '', country: 'Brasil',
    blood_type: '', insurance: '', insurance_plan: '', insurance_card: '',
    insurance_expires: '', insurance_holder: '',
    medical_notes: '', observation: '',
  };
  const [form, setForm] = useState(empty);

  useEffect(() => {
    if (patient?.id !== 'NEW') {
      setForm({
        name:               patient.name          || '',
        social_name:        patient.social_name   || '',
        cpf:                patient.cpf           || '',
        rg:                 patient.rg            || '',
        cns:                patient.cns           || '',
        birth_date:         patient.birth_date    || patient.date_of_birth || '',
        gender:             patient.gender        || '',
        skin_color:         patient.skin_color    || '',
        civil_status:       patient.civil_status  || '',
        profession:         patient.profession    || '',
        education:          patient.education     || '',
        religion:           patient.religion      || '',
        nationality:        patient.nationality   || '',
        birthplace:         patient.birthplace    || '',
        height:             patient.height   != null ? String(patient.height) : '',
        weight:             patient.weight   != null ? String(patient.weight) : '',
        record_number:      patient.record_number || '',
        priority:           patient.priority      || 'normal',
        alerts:             patient.alerts        || '',
        phone:              patient.phone         || '',
        phone2:             patient.phone2        || '',
        cell2:              patient.cell2         || '',
        email:              patient.email         || '',
        email2:             patient.email2        || '',
        instagram:          patient.instagram     || '',
        address:            patient.address       || '',
        address_number:     patient.address_number     || '',
        address_complement: patient.address_complement || '',
        neighborhood:       patient.neighborhood  || '',
        zip_code:           patient.zip_code      || '',
        city:               patient.city          || '',
        state:              patient.state         || '',
        country:            patient.country       || 'Brasil',
        blood_type:         patient.blood_type    || '',
        insurance:          patient.insurance     || '',
        insurance_plan:     patient.insurance_plan  || '',
        insurance_card:     patient.insurance_card  || '',
        insurance_expires:  patient.insurance_expires || '',
        insurance_holder:   patient.insurance_holder  || '',
        medical_notes:      patient.medical_notes || '',
        observation:        patient.observation   || '',
      });
    } else {
      setForm(empty);
    }
  }, [patient]);

  useEffect(() => {
    if (!patient?.id || patient.id === 'NEW') return;
    setLoadingRecords(true);
    Promise.all([
      supabase.from('clinical_records')
        .select('id, record_type, content_text, content_html, professional, record_date')
        .eq('patient_id', patient.id)
        .order('record_date', { ascending: false }),
      supabase.from('patient_files')
        .select('id, file_name, file_type, folder, storage_path, description, file_size, record_date')
        .eq('patient_id', patient.id)
        .order('record_date', { ascending: false }),
    ]).then(([recRes, filesRes]) => {
      setClinicalRecords(recRes.data || []);
      setPatientFiles(filesRes.data || []);
    }).finally(() => setLoadingRecords(false));
  }, [patient?.id]);

  const ch = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    setForm(f => ({ ...f, [e.target.name]: e.target.value }));
  };

  // Title Case aplicado apenas ao sair do campo (evita reset de cursor ao digitar)
  const chBlur = (e: React.FocusEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    if (name === 'name' || name === 'social_name') {
      setForm(f => ({ ...f, [name]: toTitleCase(value) }));
    }
  };

  const imc = (() => {
    const h = parseFloat(String(form.height).replace(',', '.'));
    const w = parseFloat(String(form.weight).replace(',', '.'));
    if (!h || !w || h <= 0) return null;
    const v = w / (h * h);
    const label = v < 18.5 ? 'Abaixo do peso' : v < 25 ? 'Peso normal' : v < 30 ? 'Sobrepeso' : 'Obesidade';
    const color = v < 18.5 ? 'text-blue-500' : v < 25 ? 'text-emerald-600' : v < 30 ? 'text-amber-500' : 'text-rose-500';
    return { value: v.toFixed(1), label, color };
  })();

  const handleSave = async () => {
    setIsSaving(true); setSaveMsg('');
    try {
      const payload: Record<string, any> = {
        name: form.name, social_name: form.social_name,
        email: form.email, email2: form.email2,
        phone: form.phone, phone2: form.phone2, cell2: form.cell2,
        cpf: form.cpf, rg: form.rg, cns: form.cns,
        birth_date: form.birth_date || null,
        gender: form.gender, skin_color: form.skin_color,
        civil_status: form.civil_status, profession: form.profession,
        education: form.education, religion: form.religion,
        nationality: form.nationality, birthplace: form.birthplace,
        height: form.height ? parseFloat(String(form.height).replace(',', '.')) : null,
        weight: form.weight ? parseFloat(String(form.weight).replace(',', '.')) : null,
        blood_type: form.blood_type,
        record_number: form.record_number, priority: form.priority, alerts: form.alerts,
        instagram: form.instagram,
        address: form.address, address_number: form.address_number,
        address_complement: form.address_complement, neighborhood: form.neighborhood,
        zip_code: form.zip_code, city: form.city, state: form.state, country: form.country,
        insurance: form.insurance, insurance_plan: form.insurance_plan,
        insurance_card: form.insurance_card,
        insurance_expires: form.insurance_expires || null,
        insurance_holder: form.insurance_holder,
        medical_notes: form.medical_notes, observation: form.observation,
      };

      if (patient.id === 'NEW') {
        const key = phoneMatchKey(form.phone);
        if (key) {
          const { data: existing } = await supabase.from('patients').select('id, phone');
          if (existing?.find((p: any) => phoneMatchKey(p.phone) === key)) {
            alert('Ja existe um paciente com esse telefone.');
            onRefresh?.(); onClose(); return;
          }
        }
        const { error } = await supabase.from('patients').insert([{ ...payload, status: 'lead' }]);
        if (error) throw error;
      } else {
        const { error } = await supabase.from('patients').update(payload).eq('id', patient.id);
        if (error) throw error;
      }

      setSaveMsg('Salvo com sucesso!');
      onRefresh?.();
      setTimeout(() => { setSaveMsg(''); if (patient.id === 'NEW') onClose(); }, 2000);
    } catch (err: any) {
      alert('Erro ao salvar: ' + err.message);
    } finally {
      setIsSaving(false);
    }
  };

  const handleDelete = async () => {
    if (patient.id === 'NEW') return;
    setIsDeleting(true);
    try {
      // Cancela agendamentos futuros antes de deletar
      await supabase.from('appointments').delete().eq('patient_id', patient.id);
      const { error } = await supabase.from('patients').delete().eq('id', patient.id);
      if (error) throw error;
      onRefresh?.();
      onDeleted?.();  // avisa a Agenda para recarregar imediatamente
      onClose();
    } catch (err: any) {
      alert('Erro ao excluir: ' + err.message);
    } finally {
      setIsDeleting(false);
      setShowDeleteConfirm(false);
    }
  };

  const handleDownload = async (file: PatientFile) => {
    if (!file.storage_path) return;
    const { data, error } = await supabase.storage.from('patient-files').createSignedUrl(file.storage_path, 3600);
    if (error || !data?.signedUrl) { alert('Erro ao gerar link.'); return; }
    window.open(data.signedUrl, '_blank');
  };

  const fmtDate = (iso: string | null) => {
    if (!iso) return '-';
    return new Date(iso).toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric' });
  };
  const fmtSize = (bytes: number | null) => {
    if (!bytes) return '';
    if (bytes < 1024) return bytes + ' B';
    if (bytes < 1048576) return (bytes / 1024).toFixed(0) + ' KB';
    return (bytes / 1048576).toFixed(1) + ' MB';
  };

  const initials = (name: string) =>
    name ? name.split(' ').filter(Boolean).map(n => n[0]).join('').substring(0, 2).toUpperCase() : 'PT';

  const age = (() => {
    if (!form.birth_date) return null;
    const d = new Date(form.birth_date);
    if (isNaN(d.getTime())) return null;
    const today = new Date();
    let a = today.getFullYear() - d.getFullYear();
    if (today.getMonth() < d.getMonth() || (today.getMonth() === d.getMonth() && today.getDate() < d.getDate())) a--;
    return a;
  })();

  type DataSection = 'pessoais' | 'contatos' | 'saude';
  const [dataSection, setDataSection] = useState<DataSection>('pessoais');
  const DATA_TABS: { id: DataSection; label: string }[] = [
    { id: 'pessoais', label: 'Dados Pessoais'    },
    { id: 'contatos', label: 'Contato e Endereco' },
    { id: 'saude',    label: 'Saude e Convenio'  },
  ];

  /* -------------------------------------------------
     RENDER
  ------------------------------------------------- */
  return (
    <div className="fixed inset-0 z-[200] flex flex-col bg-white overflow-hidden">

      {/* TOPBAR */}
      <div className="flex items-center gap-3 px-4 py-2.5 text-white flex-shrink-0" style={{ backgroundColor: '#123451' }}>
        <div className="flex items-center gap-3 flex-1 min-w-0">
          <div className="flex-shrink-0">
            <AvatarUpload
              currentUrl={(form as any).photo_url || null}
              name={form.name || 'Paciente'}
              color="#1e3a5f"
              size="sm"
              folder="patients"
              onUpload={url => {
                (form as any).photo_url = url;
                supabase.from('patients').update({ photo_url: url }).eq('id', patient.id);
              }}
            />
          </div>
          <div className="min-w-0">
            <div className="flex items-center gap-2 flex-wrap">
              <h1 className="text-sm font-bold truncate">{form.name || 'Novo Paciente'}</h1>
              {form.birth_date && (
                <span className="text-slate-400 text-xs">
                  {age ? `${age} anos` : ''} {form.birth_date ? `· Nasc. ${fmtDate(form.birth_date)}` : ''}
                </span>
              )}
            </div>
            <div className="flex items-center gap-2 mt-0.5 flex-wrap">
              {form.record_number && (
                <span className="text-[10px] bg-slate-700 px-1.5 py-0.5 rounded font-semibold">Pront. {form.record_number}</span>
              )}
              {form.alerts && (
                <span className="text-[10px] bg-amber-500/20 text-amber-300 px-1.5 py-0.5 rounded font-semibold flex items-center gap-1">
                  <AlertCircle size={9} /> Aviso
                </span>
              )}
              {form.priority === 'urgente' && (
                <span className="text-[10px] bg-rose-500/20 text-rose-300 px-1.5 py-0.5 rounded font-semibold">Urgente</span>
              )}
            </div>
          </div>
        </div>

        <div className="flex items-center gap-1">
          <button className="p-1.5 rounded hover:bg-slate-700 transition-colors" title="Paciente anterior">
            <ChevronLeft size={16} />
          </button>
          <button className="p-1.5 rounded hover:bg-slate-700 transition-colors" title="Proximo paciente">
            <ChevronRight size={16} />
          </button>
        </div>

        <button className="flex items-center gap-1.5 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold px-3 py-2 rounded transition-colors">
          <Stethoscope size={13} />
          Iniciar Atendimento
        </button>

        {saveMsg && (
          <span className="text-xs text-emerald-300 font-semibold">{saveMsg}</span>
        )}

        <button
          onClick={handleSave}
          disabled={isSaving}
          className="flex items-center gap-1.5 bg-emerald-500 hover:bg-emerald-600 text-white text-xs font-bold px-4 py-2 rounded transition-colors disabled:opacity-70"
        >
          {isSaving ? <Loader2 size={13} className="animate-spin" /> : <Save size={13} />}
          {isSaving ? 'Salvando...' : 'SALVAR'}
        </button>

        <button onClick={onClose} className="p-1.5 rounded hover:bg-slate-700 transition-colors ml-1" title="Fechar">
          <X size={18} />
        </button>
      </div>

      {/* CORPO */}
      <div className="flex flex-1 min-h-0 overflow-hidden">

        {/* Sidebar esquerda */}
        <aside className="w-52 flex-shrink-0 bg-slate-50 border-r border-slate-200 flex flex-col overflow-y-auto py-2">
          {NAV_ITEMS.map(item => (
            <button
              key={item.id}
              onClick={() => setActiveTab(item.id)}
              className={`flex items-center gap-2.5 px-4 py-2.5 text-left text-xs font-semibold transition-colors border-l-2 ${
                activeTab === item.id
                  ? 'bg-white border-indigo-600 text-indigo-700'
                  : 'border-transparent text-slate-600 hover:bg-white hover:text-slate-900'
              }`}
            >
              <item.icon size={14} className={activeTab === item.id ? 'text-indigo-600' : 'text-slate-400'} />
              <span className="flex-1">{item.label}</span>
              {item.badge && (
                <span className="text-[9px] font-black bg-indigo-100 text-indigo-600 px-1 py-0.5 rounded">{item.badge}</span>
              )}
            </button>
          ))}

          {/* Botao deletar — discreto, no final da sidebar, nao aparece para paciente novo */}
          {patient.id !== 'NEW' && (
            <div className="mt-auto px-3 pb-3 pt-2 border-t border-slate-200">
              {!showDeleteConfirm ? (
                <button
                  onClick={() => setShowDeleteConfirm(true)}
                  className="w-full flex items-center gap-2 px-3 py-2 rounded-lg text-[11px] font-semibold text-slate-400 hover:text-rose-500 hover:bg-rose-50 transition-colors"
                >
                  <Trash2 size={12} />
                  Excluir cadastro
                </button>
              ) : (
                <div className="bg-rose-50 border border-rose-200 rounded-lg p-2.5">
                  <p className="text-[10px] font-bold text-rose-700 mb-2">Confirmar exclusao?</p>
                  <p className="text-[9px] text-rose-500 mb-2">Remove o paciente e todos os agendamentos.</p>
                  <div className="flex gap-1.5">
                    <button
                      onClick={() => setShowDeleteConfirm(false)}
                      className="flex-1 py-1 text-[10px] font-bold text-slate-500 bg-white border border-slate-200 rounded hover:bg-slate-50 transition-colors"
                    >
                      Cancelar
                    </button>
                    <button
                      onClick={handleDelete}
                      disabled={isDeleting}
                      className="flex-1 py-1 text-[10px] font-bold text-white bg-rose-500 hover:bg-rose-600 rounded transition-colors disabled:opacity-70"
                    >
                      {isDeleting ? '...' : 'Excluir'}
                    </button>
                  </div>
                </div>
              )}
            </div>
          )}
        </aside>

        {/* Area de conteudo */}
        <main className="flex-1 min-w-0 overflow-y-auto bg-white">

          {/* DADOS PRINCIPAIS */}
          {activeTab === 'dados' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              <div className="flex gap-0 mb-5 border-b border-slate-200">
                {DATA_TABS.map(t => (
                  <button
                    key={t.id}
                    onClick={() => setDataSection(t.id)}
                    className={`px-4 py-2.5 text-xs font-bold border-b-2 transition-colors ${
                      dataSection === t.id
                        ? 'border-indigo-600 text-indigo-600'
                        : 'border-transparent text-slate-400 hover:text-slate-700'
                    }`}
                  >
                    {t.label}
                  </button>
                ))}
              </div>

              {/* Dados Pessoais */}
              {dataSection === 'pessoais' && (
                <div className="grid grid-cols-3 gap-x-4 gap-y-4">
                  <div className="col-span-2 space-y-1">
                    <label className={LB}>Nome Completo *</label>
                    <input name="name" value={form.name} onChange={ch} onBlur={chBlur} className={I} placeholder="Nome do paciente" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Prontuario</label>
                    <input name="record_number" value={form.record_number} onChange={ch} className={I} placeholder="0000" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Nome Social</label>
                    <input name="social_name" value={form.social_name} onChange={ch} onBlur={chBlur} className={I} placeholder="Como prefere ser chamado(a)" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>CPF *</label>
                    <input name="cpf" value={form.cpf} onChange={ch} className={I} placeholder="000.000.000-00" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>RG</label>
                    <input name="rg" value={form.rg} onChange={ch} className={I} placeholder="00.000.000-0" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Data de Nascimento</label>
                    <input name="birth_date" type="date" value={form.birth_date} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Sexo</label>
                    <select name="gender" value={form.gender} onChange={ch} className={IS}>
                      <option value="">Selecione</option>
                      <option>Masculino</option>
                      <option>Feminino</option>
                      <option>Indefinido</option>
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>CNS (Cartao SUS)</label>
                    <input name="cns" value={form.cns} onChange={ch} className={I} placeholder="000 0000 0000 0000" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Estado Civil</label>
                    <select name="civil_status" value={form.civil_status} onChange={ch} className={IS}>
                      <option value="">Selecione</option>
                      <option>Solteiro(a)</option>
                      <option>Casado(a)</option>
                      <option>Uniao Estavel</option>
                      <option>Divorciado(a)</option>
                      <option>Viuvo(a)</option>
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Cor da Pele</label>
                    <select name="skin_color" value={form.skin_color} onChange={ch} className={IS}>
                      <option value="">Selecione</option>
                      <option>Branca</option>
                      <option>Preta</option>
                      <option>Parda</option>
                      <option>Amarela</option>
                      <option>Indigena</option>
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Profissao</label>
                    <input name="profession" value={form.profession} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Escolaridade</label>
                    <select name="education" value={form.education} onChange={ch} className={IS}>
                      <option value="">Selecione</option>
                      <option>Fundamental Incompleto</option>
                      <option>Fundamental Completo</option>
                      <option>Medio Incompleto</option>
                      <option>Medio Completo</option>
                      <option>Superior Incompleto</option>
                      <option>Superior Completo</option>
                      <option>Pos-Graduacao</option>
                      <option>Mestrado</option>
                      <option>Doutorado</option>
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Naturalidade</label>
                    <input name="birthplace" value={form.birthplace} onChange={ch} className={I} placeholder="Cidade natal" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Nacionalidade</label>
                    <input name="nationality" value={form.nationality} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Religiao</label>
                    <input name="religion" value={form.religion} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Prioridade</label>
                    <select name="priority" value={form.priority} onChange={ch} className={IS}>
                      <option value="normal">Normal</option>
                      <option value="alta">Alta</option>
                      <option value="urgente">Urgente</option>
                    </select>
                  </div>
                  <div className="col-span-3 space-y-1">
                    <label className={LB}>Avisos e Pendencias</label>
                    <textarea
                      name="alerts" value={form.alerts} onChange={ch} rows={3}
                      placeholder="Alergias, alertas importantes, pendencias financeiras..."
                      className="w-full px-3 py-2 rounded-lg border border-amber-200 bg-amber-50/40 focus:bg-white focus:ring-2 focus:ring-amber-400 outline-none text-sm text-slate-800 resize-none transition-all"
                    />
                  </div>
                  <div className="col-span-3 space-y-1">
                    <label className={LB}>Observacoes Gerais</label>
                    <textarea
                      name="observation" value={form.observation} onChange={ch} rows={3}
                      placeholder="Notas internas sobre o paciente..."
                      className="w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-400 outline-none text-sm text-slate-800 resize-none transition-all"
                    />
                  </div>
                </div>
              )}

              {/* Contato e Endereco */}
              {dataSection === 'contatos' && (
                <div className="grid grid-cols-3 gap-x-4 gap-y-4">
                  <div className="space-y-1">
                    <label className={LB}>Celular / WhatsApp *</label>
                    <input name="phone" value={form.phone} onChange={ch} className={I} placeholder="(00) 00000-0000" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Celular 2</label>
                    <input name="cell2" value={form.cell2} onChange={ch} className={I} placeholder="(00) 00000-0000" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Telefone Fixo</label>
                    <input name="phone2" value={form.phone2} onChange={ch} className={I} placeholder="(00) 0000-0000" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>E-mail</label>
                    <input name="email" value={form.email} onChange={ch} className={I} type="email" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>E-mail 2</label>
                    <input name="email2" value={form.email2} onChange={ch} className={I} type="email" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Instagram</label>
                    <input name="instagram" value={form.instagram} onChange={ch} className={I} placeholder="@usuario" />
                  </div>
                  <p className="col-span-3 text-[11px] font-bold uppercase tracking-widest text-slate-400 border-t border-slate-100 pt-3">Endereco</p>
                  <div className="space-y-1">
                    <label className={LB}>CEP</label>
                    <input name="zip_code" value={form.zip_code} onChange={ch} className={I} placeholder="00000-000" />
                  </div>
                  <div className="col-span-2 space-y-1">
                    <label className={LB}>Logradouro</label>
                    <input name="address" value={form.address} onChange={ch} className={I} placeholder="Rua, Av., Quadra..." />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Numero</label>
                    <input name="address_number" value={form.address_number} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Complemento</label>
                    <input name="address_complement" value={form.address_complement} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Bairro</label>
                    <input name="neighborhood" value={form.neighborhood} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Cidade</label>
                    <input name="city" value={form.city} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Estado</label>
                    <select name="state" value={form.state} onChange={ch} className={IS}>
                      <option value="">Selecione</option>
                      {ESTADOS.map(s => <option key={s}>{s}</option>)}
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Pais</label>
                    <input name="country" value={form.country} onChange={ch} className={I} />
                  </div>
                </div>
              )}

              {/* Saude e Convenio */}
              {dataSection === 'saude' && (
                <div className="grid grid-cols-3 gap-x-4 gap-y-4">
                  <p className="col-span-3 text-[11px] font-bold uppercase tracking-widest text-slate-400">Biometria</p>
                  <div className="space-y-1">
                    <label className={LB}>Altura (m)</label>
                    <input name="height" value={form.height} onChange={ch} className={I} placeholder="Ex: 1.70" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Peso (kg)</label>
                    <input name="weight" value={form.weight} onChange={ch} className={I} placeholder="Ex: 70.5" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Tipo Sanguineo</label>
                    <select name="blood_type" value={form.blood_type} onChange={ch} className={IS}>
                      <option value="">Selecione</option>
                      {['A+','A-','B+','B-','AB+','AB-','O+','O-'].map(t => <option key={t}>{t}</option>)}
                    </select>
                  </div>
                  {imc && (
                    <div className="col-span-3 p-3 bg-slate-50 rounded-lg border border-slate-200 flex items-center gap-3">
                      <span className="text-xs text-slate-500">IMC calculado:</span>
                      <span className={`text-sm font-black ${imc.color}`}>{imc.value}</span>
                      <span className={`text-xs font-semibold ${imc.color}`}>— {imc.label}</span>
                    </div>
                  )}
                  <div className="col-span-3 space-y-1 border-t border-slate-100 pt-3">
                    <label className={LB}>Notas Medicas e Alergias</label>
                    <textarea
                      name="medical_notes" value={form.medical_notes} onChange={ch} rows={4}
                      placeholder="Alergias, medicamentos em uso, condicoes cronicas..."
                      className="w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-400 outline-none text-sm text-slate-800 resize-none transition-all"
                    />
                  </div>
                  <p className="col-span-3 text-[11px] font-bold uppercase tracking-widest text-slate-400 border-t border-slate-100 pt-3">Convenio</p>
                  <div className="space-y-1">
                    <label className={LB}>Convenio</label>
                    <input name="insurance" value={form.insurance} onChange={ch} className={I} placeholder="Nome do convenio" />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Plano</label>
                    <input name="insurance_plan" value={form.insurance_plan} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Carteirinha</label>
                    <input name="insurance_card" value={form.insurance_card} onChange={ch} className={I} />
                  </div>
                  <div className="space-y-1">
                    <label className={LB}>Validade</label>
                    <input name="insurance_expires" type="date" value={form.insurance_expires} onChange={ch} className={I} />
                  </div>
                  <div className="col-span-2 space-y-1">
                    <label className={LB}>Titular do Convenio</label>
                    <input name="insurance_holder" value={form.insurance_holder} onChange={ch} className={I} />
                  </div>
                </div>
              )}
            </div>
          )}

          {/* RESUMOS DE IA */}
          {activeTab === 'ia' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              <Placeholder icon={Brain} label="Resumos de IA" />
            </div>
          )}

          {/* ANAMNESE E EVOLUCOES */}
          {activeTab === 'anamnese' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              {loadingRecords ? (
                <div className="flex justify-center py-20">
                  <Loader2 className="w-8 h-8 text-indigo-500 animate-spin" />
                </div>
              ) : clinicalRecords.filter(r => r.record_type === 'anamnese' || r.record_type === 'evolucao').length === 0 ? (
                <Placeholder icon={Activity} label="Anamnese e Evolucoes" />
              ) : (
                <div className="space-y-3">
                  {clinicalRecords
                    .filter(r => r.record_type === 'anamnese' || r.record_type === 'evolucao')
                    .map(rec => {
                      const meta = RECORD_LABELS[rec.record_type] || { label: rec.record_type, color: 'bg-slate-100 text-slate-600' };
                      const isOpen = expandedRecord === rec.id;
                      return (
                        <div key={rec.id} className="border border-slate-200 rounded-xl overflow-hidden">
                          <button
                            className="w-full flex items-center justify-between px-4 py-3 hover:bg-slate-50 transition-colors"
                            onClick={() => setExpandedRecord(isOpen ? null : rec.id)}
                          >
                            <div className="flex items-center gap-3">
                              <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${meta.color}`}>{meta.label}</span>
                              <span className="text-xs font-semibold text-slate-700">{rec.professional || 'Profissional'}</span>
                              <span className="text-xs text-slate-400">{fmtDate(rec.record_date)}</span>
                            </div>
                            {isOpen ? <ChevronUp size={14} className="text-slate-400" /> : <ChevronDown size={14} className="text-slate-400" />}
                          </button>
                          {isOpen && (
                            <div className="px-4 pb-4 text-sm text-slate-700 whitespace-pre-wrap border-t border-slate-100 pt-3">
                              {rec.content_text || 'Sem conteudo.'}
                            </div>
                          )}
                        </div>
                      );
                    })}
                </div>
              )}
            </div>
          )}

          {/* LAUDOS E FORMULARIOS */}
          {activeTab === 'laudos' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              <Placeholder icon={FileText} label="Laudos e Formularios" />
            </div>
          )}

          {/* PRESCRICOES */}
          {activeTab === 'prescricoes' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              <Placeholder icon={Pill} label="Prescricoes" />
            </div>
          )}

          {/* AGENDAMENTOS */}
          {activeTab === 'agendamentos' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              <Placeholder icon={Calendar} label="Historico de Agendamentos" />
            </div>
          )}

          {/* ARQUIVOS */}
          {activeTab === 'arquivos' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              {loadingRecords ? (
                <div className="flex justify-center py-20">
                  <Loader2 className="w-8 h-8 text-indigo-500 animate-spin" />
                </div>
              ) : patientFiles.length === 0 ? (
                <Placeholder icon={Paperclip} label="Arquivos do Paciente" />
              ) : (
                <div className="space-y-2">
                  {patientFiles.map(file => (
                    <div key={file.id} className="flex items-center justify-between px-4 py-3 bg-slate-50 rounded-xl border border-slate-200 hover:bg-white transition-colors group">
                      <div className="flex items-center gap-3 min-w-0">
                        <FileImage size={16} className="text-slate-400 flex-shrink-0" />
                        <div className="min-w-0">
                          <p className="text-sm font-semibold text-slate-800 truncate">{file.file_name}</p>
                          <p className="text-xs text-slate-400">{file.folder || 'Geral'} {file.file_size ? '· ' + fmtSize(file.file_size) : ''} {file.record_date ? '· ' + fmtDate(file.record_date) : ''}</p>
                        </div>
                      </div>
                      <button
                        onClick={() => handleDownload(file)}
                        className="opacity-0 group-hover:opacity-100 transition-opacity p-1.5 rounded-lg hover:bg-indigo-100 text-indigo-600"
                        title="Baixar"
                      >
                        <Download size={14} />
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* LINHA DO TEMPO */}
          {activeTab === 'timeline' && (
            <div className="max-w-4xl mx-auto px-6 py-5">
              {loadingRecords ? (
                <div className="flex justify-center py-20">
                  <Loader2 className="w-8 h-8 text-indigo-500 animate-spin" />
                </div>
              ) : clinicalRecords.length === 0 ? (
                <Placeholder icon={Clock} label="Linha do Tempo" />
              ) : (
                <div className="relative pl-6 space-y-4">
                  <div className="absolute left-2 top-0 bottom-0 w-0.5 bg-slate-200" />
                  {clinicalRecords.map(rec => {
                    const meta = RECORD_LABELS[rec.record_type] || { label: rec.record_type, color: 'bg-slate-100 text-slate-600' };
                    return (
                      <div key={rec.id} className="relative">
                        <div className="absolute -left-4 top-3 w-2.5 h-2.5 rounded-full bg-indigo-500 border-2 border-white" />
                        <div className="bg-white border border-slate-200 rounded-xl px-4 py-3">
                          <div className="flex items-center gap-2 mb-1">
                            <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${meta.color}`}>{meta.label}</span>
                            <span className="text-xs text-slate-400">{fmtDate(rec.record_date)}</span>
                            {rec.professional && <span className="text-xs text-slate-500">{rec.professional}</span>}
                          </div>
                          {rec.content_text && (
                            <p className="text-xs text-slate-600 line-clamp-2">{rec.content_text}</p>
                          )}
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          )}

          {/* FINANCEIRO */}
          {activeTab === 'financeiro' && (
            <PatientFinanceiro patient={patient} />
          )}

        </main>
      </div>
    </div>
  );
};

// ─── Aba Financeiro ──────────────────────────────────────────

const fmt    = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const fmtPct = (v: number) => `${v.toFixed(1)}%`;

const STATUS_STYLE: Record<string, string> = {
  paid:      'bg-emerald-50 text-emerald-700 border-emerald-200',
  pending:   'bg-amber-50 text-amber-700 border-amber-200',
  refunded:  'bg-slate-100 text-slate-500 border-slate-200',
  cancelled: 'bg-rose-50 text-rose-600 border-rose-200',
};
const STATUS_LABEL: Record<string, string> = {
  paid: 'Pago', pending: 'Pendente', refunded: 'Estornado', cancelled: 'Cancelado',
};

const PatientFinanceiro: React.FC<{ patient: Patient }> = ({ patient }) => {
  const [payments, setPayments]       = useState<PaymentFull[]>([]);
  const [loading, setLoading]         = useState(true);
  const [showModal, setShowModal]     = useState(false);

  const loadPayments = useCallback(async () => {
    setLoading(true);
    const { data } = await supabase
      .from('vw_payments_full')
      .select('*')
      .eq('patient_id', patient.id)
      .order('payment_date', { ascending: false });
    setPayments((data ?? []) as PaymentFull[]);
    setLoading(false);
  }, [patient.id]);

  useEffect(() => { loadPayments(); }, [loadPayments]);

  const totals = payments.reduce((acc, p) => {
    if (p.status === 'paid') {
      acc.paid        += p.amount ?? 0;
      acc.profit      += p.real_profit ?? 0;
      acc.commission  += p.commission_amount ?? 0;
    }
    if (p.status === 'pending') acc.pending += p.amount ?? 0;
    return acc;
  }, { paid: 0, pending: 0, profit: 0, commission: 0 });

  return (
    <div className="max-w-3xl mx-auto px-6 py-5 flex flex-col gap-5">

      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-sm font-bold text-slate-700">Histórico Financeiro</h2>
          <p className="text-xs text-slate-400">{payments.length} transação{payments.length !== 1 ? 'ões' : ''} registrada{payments.length !== 1 ? 's' : ''}</p>
        </div>
        <button
          onClick={() => setShowModal(true)}
          className="flex items-center gap-2 bg-indigo-600 hover:bg-indigo-500 text-white
                     text-xs font-semibold rounded-xl px-3 py-2 transition-colors"
        >
          <Plus className="w-3.5 h-3.5" />
          Registrar pagamento
        </button>
      </div>

      {/* KPI cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <div className="bg-emerald-50 border border-emerald-100 rounded-xl p-3">
          <p className="text-[10px] text-emerald-600 font-semibold uppercase tracking-wide">Total pago</p>
          <p className="text-base font-bold text-emerald-700 tabular-nums mt-0.5">{fmt(totals.paid)}</p>
        </div>
        <div className="bg-amber-50 border border-amber-100 rounded-xl p-3">
          <p className="text-[10px] text-amber-600 font-semibold uppercase tracking-wide">Pendente</p>
          <p className="text-base font-bold text-amber-700 tabular-nums mt-0.5">{fmt(totals.pending)}</p>
        </div>
        <div className="bg-indigo-50 border border-indigo-100 rounded-xl p-3">
          <p className="text-[10px] text-indigo-600 font-semibold uppercase tracking-wide">Lucro clínica</p>
          <p className="text-base font-bold text-indigo-700 tabular-nums mt-0.5">{fmt(totals.profit)}</p>
        </div>
        <div className="bg-rose-50 border border-rose-100 rounded-xl p-3">
          <p className="text-[10px] text-rose-600 font-semibold uppercase tracking-wide">Comissões</p>
          <p className="text-base font-bold text-rose-700 tabular-nums mt-0.5">{fmt(totals.commission)}</p>
        </div>
      </div>

      {/* Lista de pagamentos */}
      {loading ? (
        <div className="flex justify-center py-10"><Loader2 className="w-5 h-5 text-indigo-400 animate-spin" /></div>
      ) : payments.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-14 gap-3 text-center">
          <Receipt className="w-10 h-10 text-slate-200" />
          <p className="text-sm text-slate-400">Nenhum pagamento registrado ainda.</p>
          <button
            onClick={() => setShowModal(true)}
            className="text-xs text-indigo-500 hover:text-indigo-700 font-semibold transition-colors"
          >
            Registrar primeiro pagamento →
          </button>
        </div>
      ) : (
        <div className="flex flex-col gap-2">
          {payments.map(p => {
            const margin = p.margin_pct ?? 0;
            return (
              <div key={p.id} className="bg-white border border-slate-200 rounded-xl p-4 flex flex-col gap-3">
                {/* Linha principal */}
                <div className="flex items-center gap-3">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 flex-wrap">
                      <p className="text-sm font-semibold text-slate-800 tabular-nums">{fmt(p.amount)}</p>
                      <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full border ${STATUS_STYLE[p.status] ?? STATUS_STYLE.pending}`}>
                        {STATUS_LABEL[p.status] ?? p.status}
                      </span>
                      <span className="text-[10px] text-slate-400 bg-slate-100 rounded-full px-2 py-0.5">
                        {PAYMENT_METHOD_LABELS[p.payment_method] ?? p.payment_method}
                      </span>
                    </div>
                    <p className="text-xs text-slate-400 mt-0.5">
                      {p.service_name ?? '—'}
                      {p.payment_date && ` · ${new Date(p.payment_date).toLocaleDateString('pt-BR')}`}
                    </p>
                  </div>

                  {/* Margem */}
                  {p.status === 'paid' && (
                    <div className={`text-xs font-bold tabular-nums px-2 py-1 rounded-lg ${
                      margin >= 25 ? 'bg-emerald-50 text-emerald-700' :
                      margin >= 0  ? 'bg-amber-50 text-amber-700' :
                                     'bg-rose-50 text-rose-600'
                    }`}>
                      {fmtPct(margin)}
                    </div>
                  )}
                </div>

                {/* Breakdown (só se tiver dados calculados) */}
                {p.status === 'paid' && p.net_revenue != null && (
                  <div className="grid grid-cols-3 sm:grid-cols-5 gap-2 pt-2 border-t border-slate-100">
                    {[
                      { label: 'Taxa',       value: -(p.payment_fee_amount ?? 0), color: 'text-rose-500' },
                      { label: 'Imposto',    value: -(p.tax_amount ?? 0),         color: 'text-rose-500' },
                      { label: 'Rec. líq.',  value:   p.net_revenue ?? 0,         color: 'text-amber-600' },
                      { label: 'Comissão',   value: -(p.commission_amount ?? 0),  color: 'text-rose-500' },
                      { label: 'Lucro',      value:   p.real_profit ?? 0,         color: p.real_profit! >= 0 ? 'text-emerald-600' : 'text-rose-500' },
                    ].map(({ label, value, color }) => (
                      <div key={label} className="text-center">
                        <p className="text-[10px] text-slate-400">{label}</p>
                        <p className={`text-xs font-semibold tabular-nums ${color}`}>{fmt(value)}</p>
                      </div>
                    ))}
                  </div>
                )}

                {p.pricing_source === 'default' && (
                  <p className="text-[10px] text-amber-600">⚠ Valores estimados — serviço sem precificação cadastrada no BI.</p>
                )}
              </div>
            );
          })}
        </div>
      )}

      {/* Modal */}
      {showModal && (
        <PaymentRegisterModal
          patient={patient}
          onClose={() => setShowModal(false)}
          onSuccess={loadPayments}
        />
      )}
    </div>
  );
};

export default PatientProfile;
