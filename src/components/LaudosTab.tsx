/**
 * LaudosTab — Laudos e Formulários por paciente
 * Mesma arquitetura de AnamnesisTab e PrescriptionsTab.
 * Cor âmbar para diferenciar visualmente.
 */
import React, { useState, useEffect, useCallback } from 'react';
import {
  Plus, Pencil, Trash2, Loader2, AlertCircle, ChevronLeft,
  FileText, ClipboardList, Settings, Eye, Printer,
  GripVertical, X, Save, CheckCircle2, ToggleLeft, ToggleRight,
  ScrollText,
} from 'lucide-react';
import {
  DragDropContext, Droppable, Draggable, DropResult,
} from '@hello-pangea/dnd';
import { supabase } from '../services/supabaseClient';

// ─── Tipos ────────────────────────────────────────────────────

type FieldType = 'title' | 'text' | 'memo' | 'radio' | 'checkbox' | 'select' | 'date' | 'divider';

interface TemplateField {
  id:       string;
  type:     FieldType;
  label:    string;
  options?: string[];
  required?: boolean;
}

interface LaudoTemplate {
  id:          string;
  name:        string;
  description: string | null;
  record_type: string;
  fields:      TemplateField[];
  is_active:   boolean;
  created_at:  string;
}

interface LaudoRecord {
  id:              string;
  patient_id:      string;
  professional_id: string | null;
  template_id:     string | null;
  template_name:   string;
  record_type:     string;
  answers:         Record<string, string | string[]>;
  is_active:       boolean;
  created_at:      string;
  professionals?:  { name: string } | null;
}

interface Professional { id: string; name: string; }
interface Props { patientId: string; }

// ─── Constantes ───────────────────────────────────────────────

const RECORD_TYPE_LABELS: Record<string, { label: string; color: string }> = {
  laudo:       { label: 'Laudo',       color: 'bg-amber-100 text-amber-700'    },
  formulario:  { label: 'Formulário',  color: 'bg-sky-100 text-sky-700'        },
  atestado:    { label: 'Atestado',    color: 'bg-emerald-100 text-emerald-700' },
  declaracao:  { label: 'Declaração',  color: 'bg-rose-100 text-rose-700'      },
};

const FIELD_TYPE_LABELS: Record<FieldType, string> = {
  title:    'Título / Seção',
  text:     'Texto curto',
  memo:     'Texto longo',
  radio:    'Escolha única',
  checkbox: 'Múltipla escolha',
  select:   'Lista suspensa',
  date:     'Data',
  divider:  'Separador',
};

const uid = () => Math.random().toString(36).slice(2, 9);
const blankField = (): TemplateField => ({ id: uid(), type: 'text', label: '', options: [], required: false });

// ─── RecordReadView ───────────────────────────────────────────

const RecordReadView: React.FC<{
  record:   LaudoRecord;
  template: LaudoTemplate | null;
  onBack:   () => void;
}> = ({ record, template, onBack }) => {
  const typeInfo = RECORD_TYPE_LABELS[record.record_type] ?? { label: record.record_type, color: 'bg-slate-100 text-slate-600' };
  const date = new Date(record.created_at).toLocaleDateString('pt-BR', { day: '2-digit', month: 'long', year: 'numeric' });

  return (
    <div className="flex flex-col h-full">
      <div className="flex items-center gap-3 mb-5 print:hidden">
        <button onClick={onBack} className="p-1.5 hover:bg-slate-100 rounded-lg transition-colors">
          <ChevronLeft className="w-4 h-4 text-slate-500" />
        </button>
        <h3 className="font-bold text-slate-800 flex-1">{record.template_name}</h3>
        <button
          onClick={() => window.print()}
          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold bg-amber-600 text-white rounded-lg hover:bg-amber-700 transition-colors"
        >
          <Printer className="w-3.5 h-3.5" /> Imprimir
        </button>
      </div>

      <div className="bg-white border border-slate-200 rounded-xl p-6 space-y-4 print:border-none print:p-0">
        <div className="flex items-start justify-between border-b border-slate-100 pb-4">
          <div>
            <h2 className="text-lg font-black text-slate-900">{record.template_name}</h2>
            <p className="text-sm text-slate-500 mt-0.5">
              {record.professionals?.name ?? 'Profissional não informado'} · {date}
            </p>
          </div>
          <span className={`text-xs font-bold px-2.5 py-1 rounded-full ${typeInfo.color}`}>
            {typeInfo.label}
          </span>
        </div>

        {template ? (
          template.fields.map(field => {
            if (field.type === 'divider') return <hr key={field.id} className="border-slate-200" />;
            if (field.type === 'title')   return <h3 key={field.id} className="font-bold text-slate-700 text-base pt-2">{field.label}</h3>;
            const answer = record.answers[field.id];
            if (!answer || (Array.isArray(answer) && answer.length === 0)) return null;
            return (
              <div key={field.id} className="space-y-1">
                <p className="text-[11px] font-bold uppercase tracking-wider text-slate-400">{field.label}</p>
                <p className="text-sm text-slate-800 whitespace-pre-wrap">
                  {Array.isArray(answer) ? answer.join(', ') : answer}
                </p>
              </div>
            );
          })
        ) : (
          <div className="space-y-3">
            {Object.entries(record.answers).map(([k, v]) => (
              <div key={k} className="space-y-1">
                <p className="text-[11px] font-bold uppercase tracking-wider text-slate-400">{k}</p>
                <p className="text-sm text-slate-800 whitespace-pre-wrap">{Array.isArray(v) ? v.join(', ') : v}</p>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

// ─── TemplateBuilder ──────────────────────────────────────────

const TemplateBuilder: React.FC<{
  editing: LaudoTemplate | null;
  onSave:  () => void;
  onBack:  () => void;
}> = ({ editing, onSave, onBack }) => {
  const [name,       setName]       = useState(editing?.name ?? '');
  const [desc,       setDesc]       = useState(editing?.description ?? '');
  const [recType,    setRecType]    = useState(editing?.record_type ?? 'laudo');
  const [fields,     setFields]     = useState<TemplateField[]>(editing?.fields ?? []);
  const [saving,     setSaving]     = useState(false);
  const [error,      setError]      = useState<string | null>(null);
  const [addingType, setAddingType] = useState<FieldType | null>(null);

  const addField    = (type: FieldType) => { setFields(f => [...f, { ...blankField(), type }]); setAddingType(null); };
  const updateField = (id: string, patch: Partial<TemplateField>) => setFields(f => f.map(x => x.id === id ? { ...x, ...patch } : x));
  const removeField = (id: string) => setFields(f => f.filter(x => x.id !== id));

  const onDragEnd = (result: DropResult) => {
    if (!result.destination) return;
    const next = Array.from(fields);
    const [moved] = next.splice(result.source.index, 1);
    next.splice(result.destination.index, 0, moved);
    setFields(next);
  };

  const handleSave = async () => {
    if (!name.trim()) { setError('Informe o nome do modelo.'); return; }
    if (fields.length === 0) { setError('Adicione pelo menos um campo.'); return; }
    setSaving(true); setError(null);
    const payload = { name: name.trim(), description: desc.trim() || null, record_type: recType, fields, is_active: true };
    const { error: sbErr } = editing?.id
      ? await supabase.from('laudo_templates').update(payload).eq('id', editing.id)
      : await supabase.from('laudo_templates').insert(payload);
    setSaving(false);
    if (sbErr) { setError(`Erro ao salvar: ${sbErr.message}`); return; }
    onSave();
  };

  return (
    <div className="flex flex-col h-full gap-4">
      <div className="flex items-center gap-3">
        <button onClick={onBack} className="p-1.5 hover:bg-slate-100 rounded-lg transition-colors">
          <ChevronLeft className="w-4 h-4 text-slate-500" />
        </button>
        <h3 className="font-bold text-slate-800 flex-1">{editing ? 'Editar modelo' : 'Novo modelo'}</h3>
        <button
          onClick={handleSave} disabled={saving}
          className="flex items-center gap-1.5 px-4 py-1.5 text-xs font-bold bg-amber-600 text-white rounded-lg hover:bg-amber-700 disabled:opacity-60 transition-colors"
        >
          {saving ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Save className="w-3.5 h-3.5" />}
          Salvar modelo
        </button>
      </div>

      {error && (
        <div className="flex items-center gap-2 text-xs text-rose-600 bg-rose-50 border border-rose-200 rounded-lg px-3 py-2">
          <AlertCircle className="w-3.5 h-3.5 shrink-0" /> {error}
        </div>
      )}

      <div className="grid grid-cols-3 gap-3">
        <div className="col-span-2 space-y-1">
          <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Nome do modelo *</label>
          <input value={name} onChange={e => setName(e.target.value)} placeholder="Ex.: Laudo de Bioimpedância"
            className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-400" />
        </div>
        <div className="space-y-1">
          <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Tipo</label>
          <select value={recType} onChange={e => setRecType(e.target.value)}
            className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-amber-400">
            <option value="laudo">Laudo</option>
            <option value="formulario">Formulário</option>
            <option value="atestado">Atestado</option>
            <option value="declaracao">Declaração</option>
          </select>
        </div>
        <div className="col-span-3 space-y-1">
          <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Descrição (opcional)</label>
          <input value={desc} onChange={e => setDesc(e.target.value)} placeholder="Breve descrição"
            className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-400" />
        </div>
      </div>

      <div className="flex-1 overflow-y-auto space-y-2 pr-1">
        <DragDropContext onDragEnd={onDragEnd}>
          <Droppable droppableId="laudo-fields">
            {provided => (
              <div ref={provided.innerRef} {...provided.droppableProps} className="space-y-2">
                {fields.map((field, idx) => (
                  <Draggable key={field.id} draggableId={field.id} index={idx}>
                    {(drag) => (
                      <div ref={drag.innerRef} {...drag.draggableProps} className="bg-slate-50 border border-slate-200 rounded-xl p-3 space-y-2">
                        <div className="flex items-center gap-2">
                          <span {...drag.dragHandleProps} className="cursor-grab text-slate-300 hover:text-slate-500">
                            <GripVertical className="w-4 h-4" />
                          </span>
                          <span className="text-[10px] font-bold uppercase tracking-wider text-amber-600">
                            {FIELD_TYPE_LABELS[field.type]}
                          </span>
                          <button onClick={() => removeField(field.id)}
                            className="ml-auto p-1 hover:bg-rose-50 rounded text-slate-400 hover:text-rose-500 transition-colors">
                            <X className="w-3.5 h-3.5" />
                          </button>
                        </div>
                        {field.type !== 'divider' && (
                          <input value={field.label} onChange={e => updateField(field.id, { label: e.target.value })}
                            placeholder={field.type === 'title' ? 'Título da seção' : 'Rótulo do campo'}
                            className="w-full px-2.5 py-1.5 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-amber-400" />
                        )}
                        {['radio', 'checkbox', 'select'].includes(field.type) && (
                          <div className="space-y-1">
                            <p className="text-[10px] text-slate-400 font-semibold">Opções (uma por linha)</p>
                            <textarea rows={3} value={(field.options ?? []).join('\n')}
                              onChange={e => updateField(field.id, { options: e.target.value.split('\n') })}
                              className="w-full px-2.5 py-1.5 border border-slate-200 rounded-lg text-xs bg-white focus:outline-none focus:ring-2 focus:ring-amber-400 resize-none" />
                          </div>
                        )}
                      </div>
                    )}
                  </Draggable>
                ))}
                {provided.placeholder}
              </div>
            )}
          </Droppable>
        </DragDropContext>

        {addingType === null ? (
          <button onClick={() => setAddingType('text')}
            className="w-full py-2.5 border-2 border-dashed border-amber-200 rounded-xl text-xs font-bold text-amber-500 hover:border-amber-400 hover:bg-amber-50 transition-all flex items-center justify-center gap-2">
            <Plus className="w-3.5 h-3.5" /> Adicionar campo
          </button>
        ) : (
          <div className="bg-white border border-slate-200 rounded-xl p-3">
            <p className="text-[10px] font-black uppercase tracking-wider text-slate-400 mb-2">Tipo de campo</p>
            <div className="grid grid-cols-2 gap-1.5">
              {(Object.keys(FIELD_TYPE_LABELS) as FieldType[]).map(t => (
                <button key={t} onClick={() => addField(t)}
                  className="text-left px-3 py-2 text-xs font-medium text-slate-700 bg-slate-50 hover:bg-amber-50 hover:text-amber-700 rounded-lg transition-colors">
                  {FIELD_TYPE_LABELS[t]}
                </button>
              ))}
            </div>
            <button onClick={() => setAddingType(null)} className="mt-2 text-xs text-slate-400 hover:text-slate-600">Cancelar</button>
          </div>
        )}
      </div>
    </div>
  );
};

// ─── FillForm ─────────────────────────────────────────────────

const FillForm: React.FC<{
  template:      LaudoTemplate;
  professionals: Professional[];
  patientId:     string;
  onSaved:       () => void;
  onBack:        () => void;
}> = ({ template, professionals, patientId, onSaved, onBack }) => {
  const [answers, setAnswers] = useState<Record<string, string | string[]>>({});
  const [profId,  setProfId]  = useState('');
  const [saving,  setSaving]  = useState(false);
  const [error,   setError]   = useState<string | null>(null);

  const set = (id: string, val: string | string[]) => setAnswers(a => ({ ...a, [id]: val }));
  const toggleCheck = (id: string, opt: string) => {
    const cur = (answers[id] as string[] | undefined) ?? [];
    set(id, cur.includes(opt) ? cur.filter(x => x !== opt) : [...cur, opt]);
  };

  const handleSave = async () => {
    setSaving(true); setError(null);
    const { error: sbErr } = await supabase.from('laudo_records').insert({
      patient_id: patientId, professional_id: profId || null,
      template_id: template.id, template_name: template.name,
      record_type: template.record_type, answers, is_active: true,
    });
    setSaving(false);
    if (sbErr) { setError(sbErr.message); return; }
    onSaved();
  };

  return (
    <div className="flex flex-col h-full gap-4">
      <div className="flex items-center gap-3">
        <button onClick={onBack} className="p-1.5 hover:bg-slate-100 rounded-lg transition-colors">
          <ChevronLeft className="w-4 h-4 text-slate-500" />
        </button>
        <div className="flex-1">
          <h3 className="font-bold text-slate-800">{template.name}</h3>
          <p className="text-xs text-slate-400">{RECORD_TYPE_LABELS[template.record_type]?.label}</p>
        </div>
        <button onClick={handleSave} disabled={saving}
          className="flex items-center gap-1.5 px-4 py-1.5 text-xs font-bold bg-amber-600 text-white rounded-lg hover:bg-amber-700 disabled:opacity-60 transition-colors">
          {saving ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <CheckCircle2 className="w-3.5 h-3.5" />}
          Salvar
        </button>
      </div>

      {error && (
        <div className="flex items-center gap-2 text-xs text-rose-600 bg-rose-50 border border-rose-200 rounded-lg px-3 py-2">
          <AlertCircle className="w-3.5 h-3.5 shrink-0" /> {error}
        </div>
      )}

      <div className="space-y-1">
        <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Profissional responsável</label>
        <select value={profId} onChange={e => setProfId(e.target.value)}
          className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-amber-400">
          <option value="">Selecione o profissional</option>
          {professionals.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
        </select>
      </div>

      <div className="flex-1 overflow-y-auto space-y-4 pr-1">
        {template.fields.map(field => {
          if (field.type === 'divider') return <hr key={field.id} className="border-slate-200" />;
          if (field.type === 'title')   return <h4 key={field.id} className="font-bold text-slate-700 text-sm pt-1">{field.label}</h4>;

          return (
            <div key={field.id} className="space-y-1">
              <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">
                {field.label}{field.required && ' *'}
              </label>
              {field.type === 'text' && (
                <input value={(answers[field.id] as string) ?? ''} onChange={e => set(field.id, e.target.value)}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-400" />
              )}
              {field.type === 'memo' && (
                <textarea rows={4} value={(answers[field.id] as string) ?? ''} onChange={e => set(field.id, e.target.value)}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-400 resize-none" />
              )}
              {field.type === 'date' && (
                <input type="date" value={(answers[field.id] as string) ?? ''} onChange={e => set(field.id, e.target.value)}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-400" />
              )}
              {field.type === 'radio' && (field.options ?? []).filter(Boolean).map(opt => (
                <label key={opt} className="flex items-center gap-2 cursor-pointer">
                  <input type="radio" name={field.id} value={opt}
                    checked={(answers[field.id] as string) === opt} onChange={() => set(field.id, opt)} className="accent-amber-600" />
                  <span className="text-sm text-slate-700">{opt}</span>
                </label>
              ))}
              {field.type === 'checkbox' && (field.options ?? []).filter(Boolean).map(opt => (
                <label key={opt} className="flex items-center gap-2 cursor-pointer">
                  <input type="checkbox" checked={((answers[field.id] as string[]) ?? []).includes(opt)}
                    onChange={() => toggleCheck(field.id, opt)} className="accent-amber-600" />
                  <span className="text-sm text-slate-700">{opt}</span>
                </label>
              ))}
              {field.type === 'select' && (
                <select value={(answers[field.id] as string) ?? ''} onChange={e => set(field.id, e.target.value)}
                  className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-amber-400">
                  <option value="">Selecione...</option>
                  {(field.options ?? []).filter(Boolean).map(opt => <option key={opt} value={opt}>{opt}</option>)}
                </select>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
};

// ─── Componente principal ─────────────────────────────────────

type View = 'list' | 'manager' | 'builder' | 'fill' | 'read';

const LaudosTab: React.FC<Props> = ({ patientId }) => {
  const [view,          setView]          = useState<View>('list');
  const [templates,     setTemplates]     = useState<LaudoTemplate[]>([]);
  const [records,       setRecords]       = useState<LaudoRecord[]>([]);
  const [professionals, setProfessionals] = useState<Professional[]>([]);
  const [loading,       setLoading]       = useState(true);
  const [selectedTemplate, setSelectedTemplate] = useState<LaudoTemplate | null>(null);
  const [editingTemplate,  setEditingTemplate]  = useState<LaudoTemplate | null>(null);
  const [selectedRecord,   setSelectedRecord]   = useState<LaudoRecord | null>(null);
  const [filterType,       setFilterType]       = useState<string>('all');

  const filteredRecords = filterType === 'all' ? records : records.filter(r => r.record_type === filterType);

  const fetchAll = useCallback(async () => {
    setLoading(true);
    const [tRes, rRes, pRes] = await Promise.all([
      supabase.from('laudo_templates').select('*').eq('is_active', true).order('created_at'),
      supabase.from('laudo_records').select('*, professionals(name)').eq('patient_id', patientId).order('created_at', { ascending: false }),
      supabase.from('professionals').select('id, name').eq('is_active', true).order('name'),
    ]);
    if (tRes.error) console.error('[LaudosTab] templates:', tRes.error);
    if (rRes.error) console.error('[LaudosTab] records:',   rRes.error);
    setTemplates((tRes.data ?? []) as LaudoTemplate[]);
    setRecords((rRes.data ?? []) as LaudoRecord[]);
    setProfessionals((pRes.data ?? []) as Professional[]);
    setLoading(false);
  }, [patientId]);

  useEffect(() => { fetchAll(); }, [fetchAll]);

  const toggleActive = async (record: LaudoRecord) => {
    await supabase.from('laudo_records').update({ is_active: !record.is_active }).eq('id', record.id);
    setRecords(rs => rs.map(r => r.id === record.id ? { ...r, is_active: !r.is_active } : r));
  };

  const deleteTemplate = async (id: string) => {
    if (!confirm('Excluir este modelo?')) return;
    await supabase.from('laudo_templates').update({ is_active: false }).eq('id', id);
    setTemplates(ts => ts.filter(t => t.id !== id));
  };

  if (loading) return (
    <div className="flex items-center justify-center h-full py-24">
      <Loader2 className="w-8 h-8 text-amber-500 animate-spin" />
    </div>
  );

  // ─── VIEW: list ──────────────────────────────────────────────
  if (view === 'list') return (
    <div className="flex flex-col h-full">
      <div className="flex items-center gap-3 mb-4 flex-wrap">
        <div className="flex items-center gap-2 flex-1">
          <ScrollText className="w-4 h-4 text-amber-500" />
          <span className="font-bold text-slate-800">Laudos e Formulários</span>
          <span className="text-xs font-semibold bg-amber-100 text-amber-700 px-2 py-0.5 rounded-full">{records.length}</span>
        </div>
        <div className="flex items-center gap-2">
          <select value={filterType} onChange={e => setFilterType(e.target.value)}
            className="text-xs border border-slate-200 rounded-lg px-2 py-1.5 bg-white text-slate-600 focus:outline-none focus:ring-2 focus:ring-amber-400">
            <option value="all">Todos os tipos</option>
            <option value="laudo">Laudo</option>
            <option value="formulario">Formulário</option>
            <option value="atestado">Atestado</option>
            <option value="declaracao">Declaração</option>
          </select>
          <button onClick={() => setView('manager')}
            className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold text-slate-600 border border-slate-200 rounded-lg hover:bg-slate-50 transition-colors">
            <Settings className="w-3.5 h-3.5" /> Modelos
          </button>
          <button onClick={() => setView('manager')}
            className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold bg-amber-600 text-white rounded-lg hover:bg-amber-700 transition-colors">
            <Plus className="w-3.5 h-3.5" /> Novo
          </button>
        </div>
      </div>

      {filteredRecords.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 text-center">
          <div className="w-14 h-14 rounded-2xl bg-amber-50 flex items-center justify-center mb-3">
            <ScrollText className="w-7 h-7 text-amber-300" />
          </div>
          <p className="font-bold text-slate-700">Nenhum laudo registrado</p>
          <p className="text-sm text-slate-400 mt-1">Clique em "Novo" para criar um laudo ou formulário.</p>
        </div>
      ) : (
        <div className="flex-1 overflow-y-auto space-y-3 pr-1">
          {filteredRecords.map(record => {
            const typeInfo = RECORD_TYPE_LABELS[record.record_type] ?? { label: record.record_type, color: 'bg-slate-100 text-slate-600' };
            const date = new Date(record.created_at).toLocaleDateString('pt-BR', { day: '2-digit', month: 'short', year: 'numeric' });
            const time = new Date(record.created_at).toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });

            return (
              <div key={record.id}
                className={`border rounded-xl p-4 transition-all ${record.is_active ? 'bg-white border-slate-200 hover:border-amber-200 hover:shadow-sm' : 'bg-slate-50 border-slate-200 opacity-60'}`}>
                <div className="flex items-start gap-3">
                  <div className="w-9 h-9 rounded-lg bg-amber-50 flex items-center justify-center shrink-0">
                    <FileText className="w-4 h-4 text-amber-500" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 flex-wrap mb-0.5">
                      <span className="font-bold text-sm text-slate-800 truncate">
                        {record.professionals?.name ?? 'Profissional não informado'}
                      </span>
                      <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full shrink-0 ${typeInfo.color}`}>
                        {typeInfo.label}
                      </span>
                    </div>
                    <p className="text-xs text-slate-500">{record.template_name} · {date} às {time}</p>
                    <div className="mt-2 text-xs text-slate-600 line-clamp-2">
                      {Object.values(record.answers).flat().filter(Boolean).join(' · ') || '—'}
                    </div>
                  </div>
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      onClick={() => { setSelectedRecord(record); setSelectedTemplate(templates.find(t => t.id === record.template_id) ?? null); setView('read'); }}
                      className="p-1.5 hover:bg-amber-50 rounded-lg text-slate-400 hover:text-amber-600 transition-colors" title="Visualizar / Imprimir">
                      <Eye className="w-3.5 h-3.5" />
                    </button>
                    <button onClick={() => toggleActive(record)}
                      className="p-1.5 hover:bg-slate-100 rounded-lg text-slate-400 hover:text-slate-600 transition-colors"
                      title={record.is_active ? 'Inativar' : 'Ativar'}>
                      {record.is_active
                        ? <ToggleRight className="w-3.5 h-3.5 text-emerald-500" />
                        : <ToggleLeft className="w-3.5 h-3.5" />}
                    </button>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );

  // ─── VIEW: manager ────────────────────────────────────────────
  if (view === 'manager') return (
    <div className="flex flex-col h-full gap-4">
      <div className="flex items-center gap-3">
        <button onClick={() => setView('list')} className="p-1.5 hover:bg-slate-100 rounded-lg transition-colors">
          <ChevronLeft className="w-4 h-4 text-slate-500" />
        </button>
        <h3 className="font-bold text-slate-800 flex-1">Escolher modelo</h3>
        <button onClick={() => { setEditingTemplate(null); setView('builder'); }}
          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold bg-amber-600 text-white rounded-lg hover:bg-amber-700 transition-colors">
          <Plus className="w-3.5 h-3.5" /> Novo modelo
        </button>
      </div>

      {templates.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 text-center">
          <div className="w-14 h-14 rounded-2xl bg-amber-50 flex items-center justify-center mb-3">
            <FileText className="w-7 h-7 text-amber-300" />
          </div>
          <p className="font-bold text-slate-700">Nenhum modelo cadastrado</p>
          <p className="text-sm text-slate-400 mt-1">Crie um modelo para começar a emitir laudos.</p>
          <button onClick={() => { setEditingTemplate(null); setView('builder'); }}
            className="mt-3 text-sm font-bold text-amber-600 hover:underline">Criar primeiro modelo</button>
        </div>
      ) : (
        <div className="flex-1 overflow-y-auto space-y-2 pr-1">
          {templates.map(t => {
            const typeInfo = RECORD_TYPE_LABELS[t.record_type] ?? { label: t.record_type, color: 'bg-slate-100 text-slate-600' };
            return (
              <div key={t.id} className="flex items-center gap-3 bg-white border border-slate-200 rounded-xl p-3 hover:border-amber-200 transition-all group">
                <div className="w-8 h-8 rounded-lg bg-amber-50 flex items-center justify-center shrink-0">
                  <ClipboardList className="w-4 h-4 text-amber-400" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="font-bold text-sm text-slate-800 truncate">{t.name}</p>
                  <div className="flex items-center gap-2 mt-0.5">
                    <span className={`text-[10px] font-bold px-1.5 py-0.5 rounded-full ${typeInfo.color}`}>{typeInfo.label}</span>
                    <span className="text-[10px] text-slate-400">{t.fields.length} campos</span>
                  </div>
                </div>
                <div className="flex items-center gap-1">
                  <button onClick={() => { setEditingTemplate(t); setView('builder'); }}
                    className="p-1.5 hover:bg-indigo-50 rounded-lg text-slate-400 hover:text-indigo-600 transition-colors opacity-0 group-hover:opacity-100">
                    <Pencil className="w-3.5 h-3.5" />
                  </button>
                  <button onClick={() => deleteTemplate(t.id)}
                    className="p-1.5 hover:bg-rose-50 rounded-lg text-slate-400 hover:text-rose-500 transition-colors opacity-0 group-hover:opacity-100">
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                  <button onClick={() => { setSelectedTemplate(t); setView('fill'); }}
                    className="px-3 py-1.5 text-xs font-bold bg-amber-50 text-amber-700 rounded-lg hover:bg-amber-600 hover:text-white transition-all">
                    Usar
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );

  if (view === 'builder') return (
    <TemplateBuilder editing={editingTemplate} onSave={() => { fetchAll(); setView('manager'); }} onBack={() => setView('manager')} />
  );

  if (view === 'fill' && selectedTemplate) return (
    <FillForm template={selectedTemplate} professionals={professionals} patientId={patientId}
      onSaved={() => { fetchAll(); setView('list'); }} onBack={() => setView('manager')} />
  );

  if (view === 'read' && selectedRecord) return (
    <RecordReadView record={selectedRecord} template={selectedTemplate} onBack={() => setView('list')} />
  );

  return null;
};

export default LaudosTab;
