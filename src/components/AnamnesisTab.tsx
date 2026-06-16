/**
 * AnamnesisTab — Aba "Anamnese e Evoluções" dentro do perfil do paciente.
 *
 * Views internas:
 *  'list'    → lista de registros do paciente + botão Inserir + Gerenciar modelos
 *  'manager' → CRUD de templates (lista)
 *  'builder' → editor de um template específico (campos drag-drop)
 *  'fill'    → preenchimento de um template para este paciente
 *  'read'    → leitura expandida de um registro existente
 */

import React, { useState, useEffect, useCallback } from 'react';
import {
  Plus, Settings2, ChevronDown, ChevronLeft, Trash2, Save,
  Loader2, FileText, Activity, GripVertical, X, Check,
  Type, AlignLeft, ToggleLeft, CheckSquare, List, CalendarDays,
  Minus, ChevronUp, User, Edit2, AlertCircle,
} from 'lucide-react';
import { DragDropContext, Droppable, Draggable, DropResult } from '@hello-pangea/dnd';
import { supabase } from '../services/supabaseClient';

// ─── Types ────────────────────────────────────────────────────────────────────

export type FieldType = 'title' | 'text' | 'memo' | 'radio' | 'checkbox' | 'select' | 'date' | 'divider';
export type TemplateType = 'anamnese' | 'evolucao' | 'laudo' | 'complemento';

export interface AnamnesisField {
  id: string;
  type: FieldType;
  label: string;
  required?: boolean;
  placeholder?: string;
  options?: string[];
}

export interface AnamnesisTemplate {
  id: string;
  name: string;
  type: TemplateType;
  specialties: string[];
  fields: AnamnesisField[];
  is_active: boolean;
  created_at: string;
}

export interface AnamnesisRecord {
  id: string;
  patient_id: string;
  template_id: string | null;
  template_name: string;
  professional_id: string | null;
  appointment_id: string | null;
  data: Record<string, unknown>;
  notes: string | null;
  created_at: string;
  professional_name?: string;
}

// ─── Constants ────────────────────────────────────────────────────────────────

const FIELD_TYPES: { type: FieldType; label: string; Icon: React.FC<{ className?: string }> }[] = [
  { type: 'title',    label: 'Título',       Icon: ({ className }) => <span className={`font-black text-base leading-none ${className}`}>H</span> },
  { type: 'text',     label: 'Texto',        Icon: ({ className }) => <Type className={className} /> },
  { type: 'memo',     label: 'Memo',         Icon: ({ className }) => <AlignLeft className={className} /> },
  { type: 'radio',    label: 'Radio',        Icon: ({ className }) => <ToggleLeft className={className} /> },
  { type: 'checkbox', label: 'Checkbox',     Icon: ({ className }) => <CheckSquare className={className} /> },
  { type: 'select',   label: 'Seleção',      Icon: ({ className }) => <List className={className} /> },
  { type: 'date',     label: 'Data',         Icon: ({ className }) => <CalendarDays className={className} /> },
  { type: 'divider',  label: 'Separador',    Icon: ({ className }) => <Minus className={className} /> },
];

const TYPE_LABELS: Record<TemplateType, string> = {
  anamnese:    'Anamnese',
  evolucao:    'Evolução',
  laudo:       'Laudo',
  complemento: 'Complemento',
};

const TYPE_COLORS: Record<TemplateType, string> = {
  anamnese:    'bg-indigo-50 text-indigo-600',
  evolucao:    'bg-emerald-50 text-emerald-600',
  laudo:       'bg-amber-50 text-amber-700',
  complemento: 'bg-slate-100 text-slate-600',
};

function genId(): string {
  return Math.random().toString(36).slice(2, 10);
}

// ─── Field Renderer (fill mode) ───────────────────────────────────────────────

function FieldRenderer({
  field,
  value,
  onChange,
}: {
  field: AnamnesisField;
  value: unknown;
  onChange: (v: unknown) => void;
}) {
  if (field.type === 'divider') return <hr className="border-slate-200 my-2" />;

  if (field.type === 'title') return (
    <h3 className="text-sm font-black text-slate-700 uppercase tracking-widest pt-2">{field.label}</h3>
  );

  return (
    <div className="space-y-1">
      <label className="text-[11px] font-bold text-slate-500 uppercase tracking-wider flex items-center gap-1">
        {field.label}
        {field.required && <span className="text-rose-400">*</span>}
      </label>

      {field.type === 'text' && (
        <input
          className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-white"
          placeholder={field.placeholder || ''}
          value={(value as string) || ''}
          onChange={e => onChange(e.target.value)}
        />
      )}

      {field.type === 'memo' && (
        <textarea
          rows={3}
          className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-white resize-none"
          placeholder={field.placeholder || ''}
          value={(value as string) || ''}
          onChange={e => onChange(e.target.value)}
        />
      )}

      {field.type === 'date' && (
        <input
          type="date"
          className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-white"
          value={(value as string) || ''}
          onChange={e => onChange(e.target.value)}
        />
      )}

      {field.type === 'radio' && (field.options || []).map(opt => (
        <label key={opt} className="flex items-center gap-2 cursor-pointer group">
          <div className={`w-4 h-4 rounded-full border-2 flex items-center justify-center transition-colors
            ${value === opt ? 'border-indigo-500 bg-indigo-500' : 'border-slate-300 group-hover:border-indigo-300'}`}
            onClick={() => onChange(opt)}
          >
            {value === opt && <div className="w-1.5 h-1.5 rounded-full bg-white" />}
          </div>
          <span className="text-sm text-slate-700">{opt}</span>
        </label>
      ))}

      {field.type === 'checkbox' && (field.options || []).map(opt => {
        const arr = (value as string[]) || [];
        const checked = arr.includes(opt);
        return (
          <label key={opt} className="flex items-center gap-2 cursor-pointer group">
            <div className={`w-4 h-4 rounded border-2 flex items-center justify-center transition-colors
              ${checked ? 'border-indigo-500 bg-indigo-500' : 'border-slate-300 group-hover:border-indigo-300'}`}
              onClick={() => onChange(checked ? arr.filter(a => a !== opt) : [...arr, opt])}
            >
              {checked && <Check className="w-2.5 h-2.5 text-white" />}
            </div>
            <span className="text-sm text-slate-700">{opt}</span>
          </label>
        );
      })}

      {field.type === 'select' && (
        <select
          className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-white appearance-none"
          value={(value as string) || ''}
          onChange={e => onChange(e.target.value)}
        >
          <option value="">Selecione...</option>
          {(field.options || []).map(opt => <option key={opt} value={opt}>{opt}</option>)}
        </select>
      )}
    </div>
  );
}

// ─── Field Record Reader (read mode) ──────────────────────────────────────────

function FieldReader({ field, value }: { field: AnamnesisField; value: unknown }) {
  if (field.type === 'divider') return <hr className="border-slate-100 my-1" />;
  if (field.type === 'title')   return <h4 className="text-xs font-black text-slate-600 uppercase tracking-wider pt-2">{field.label}</h4>;

  const display = Array.isArray(value) ? (value as string[]).join(', ') : (value as string);
  if (!display) return null;

  return (
    <div>
      <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">{field.label}</p>
      <p className="text-sm text-slate-700 whitespace-pre-wrap leading-snug">{display}</p>
    </div>
  );
}

// ─── Builder ──────────────────────────────────────────────────────────────────

function TemplateBuilder({
  template,
  onSave,
  onBack,
}: {
  template: Partial<AnamnesisTemplate> | null;
  onSave: () => void;
  onBack: () => void;
}) {
  const [name, setName]                   = useState(template?.name || '');
  const [type, setType]                   = useState<TemplateType>(template?.type || 'anamnese');
  const [fields, setFields]               = useState<AnamnesisField[]>(template?.fields || []);
  const [editingField, setEditingField]   = useState<string | null>(null);
  const [saving, setSaving]               = useState(false);
  const [toast, setToast]                 = useState('');

  // Editing state for the inline field editor
  const [fLabel, setFLabel]       = useState('');
  const [fRequired, setFRequired] = useState(false);
  const [fPlaceholder, setFPlaceholder] = useState('');
  const [fOptions, setFOptions]   = useState('');

  const openEditField = (f: AnamnesisField) => {
    setEditingField(f.id);
    setFLabel(f.label);
    setFRequired(!!f.required);
    setFPlaceholder(f.placeholder || '');
    setFOptions((f.options || []).join('\n'));
  };

  const saveFieldEdit = () => {
    if (!editingField) return;
    setFields(prev => prev.map(f =>
      f.id === editingField
        ? { ...f, label: fLabel, required: fRequired, placeholder: fPlaceholder,
            options: ['radio','checkbox','select'].includes(f.type) ? fOptions.split('\n').map(s=>s.trim()).filter(Boolean) : f.options }
        : f
    ));
    setEditingField(null);
  };

  const addField = (type: FieldType) => {
    const newField: AnamnesisField = {
      id: genId(),
      type,
      label: FIELD_TYPES.find(f => f.type === type)?.label || '',
      required: false,
      options: ['radio','checkbox','select'].includes(type) ? ['Opção 1','Opção 2'] : undefined,
    };
    setFields(prev => [...prev, newField]);
    openEditField(newField);
  };

  const removeField = (id: string) => {
    setFields(prev => prev.filter(f => f.id !== id));
    if (editingField === id) setEditingField(null);
  };

  const onDragEnd = (result: DropResult) => {
    if (!result.destination) return;
    const arr = [...fields];
    const [removed] = arr.splice(result.source.index, 1);
    arr.splice(result.destination.index, 0, removed);
    setFields(arr);
  };

  const handleSave = async () => {
    if (!name.trim()) { setToast('Dê um nome ao template.'); return; }
    if (editingField) saveFieldEdit();
    setSaving(true);
    try {
      const payload = { name: name.trim(), type, fields, is_active: true };
      let sbError: { message: string } | null = null;
      if (template?.id) {
        const res = await supabase.from('anamnesis_templates').update(payload).eq('id', template.id);
        sbError = res.error;
      } else {
        const res = await supabase.from('anamnesis_templates').insert(payload);
        sbError = res.error;
      }
      if (sbError) {
        setToast(`Erro ao salvar: ${sbError.message}`);
        return;
      }
      onSave();
    } catch (e: unknown) {
      setToast(e instanceof Error ? e.message : 'Erro inesperado ao salvar');
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="flex items-center gap-3 px-5 py-3 border-b border-slate-100 shrink-0 bg-white">
        <button onClick={onBack} className="p-1.5 hover:bg-slate-100 rounded-lg transition-colors">
          <ChevronLeft className="w-4 h-4 text-slate-500" />
        </button>
        <div className="flex-1 flex items-center gap-3">
          <input
            className="flex-1 text-base font-bold text-slate-800 border-0 outline-none bg-transparent placeholder:text-slate-300"
            placeholder="Nome do formulário..."
            value={name}
            onChange={e => setName(e.target.value)}
          />
          <select
            className="text-xs border border-slate-200 rounded-lg px-2 py-1.5 bg-white text-slate-600 font-semibold"
            value={type}
            onChange={e => setType(e.target.value as TemplateType)}
          >
            {Object.entries(TYPE_LABELS).map(([v, l]) => <option key={v} value={v}>{l}</option>)}
          </select>
        </div>
        <button
          onClick={handleSave}
          disabled={saving}
          className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white text-sm font-bold rounded-xl hover:bg-indigo-700 disabled:opacity-50 transition-colors shadow-lg shadow-indigo-900/15"
        >
          {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
          Salvar
        </button>
      </div>

      {toast && (
        <div className="mx-5 mt-3 px-3 py-2 bg-rose-50 border border-rose-200 text-rose-700 text-xs rounded-xl flex items-center gap-2">
          <AlertCircle className="w-3.5 h-3.5 shrink-0" /> {toast}
          <button onClick={() => setToast('')} className="ml-auto"><X className="w-3 h-3" /></button>
        </div>
      )}

      <div className="flex flex-1 overflow-hidden">
        {/* Left: field type palette */}
        <div className="w-36 shrink-0 border-r border-slate-100 p-3 bg-slate-50 overflow-y-auto">
          <p className="text-[9px] font-black uppercase tracking-widest text-slate-400 mb-2">+ Campo</p>
          <div className="grid grid-cols-2 gap-1.5">
            {FIELD_TYPES.map(({ type: ft, label, Icon }) => (
              <button
                key={ft}
                onClick={() => addField(ft)}
                className="flex flex-col items-center gap-1 p-2 bg-white border border-slate-200 rounded-xl hover:border-indigo-300 hover:bg-indigo-50 transition-all text-slate-600 hover:text-indigo-600 group"
              >
                <Icon className="w-4 h-4" />
                <span className="text-[9px] font-bold">{label}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Center: field list */}
        <div className="flex-1 overflow-y-auto p-4 custom-scrollbar">
          {fields.length === 0 ? (
            <div className="flex flex-col items-center justify-center h-full text-slate-300 gap-2">
              <FileText className="w-10 h-10 opacity-40" />
              <p className="text-sm font-semibold text-slate-400">Adicione campos usando o painel à esquerda</p>
            </div>
          ) : (
            <DragDropContext onDragEnd={onDragEnd}>
              <Droppable droppableId="fields">
                {provided => (
                  <div ref={provided.innerRef} {...provided.droppableProps} className="space-y-2">
                    {fields.map((field, index) => (
                      <Draggable key={field.id} draggableId={field.id} index={index}>
                        {(prov, snap) => (
                          <div
                            ref={prov.innerRef}
                            {...prov.draggableProps}
                            className={`bg-white border rounded-xl transition-shadow ${snap.isDragging ? 'shadow-lg border-indigo-200' : 'border-slate-200'}`}
                          >
                            {/* Field header */}
                            <div className="flex items-center gap-2 px-3 py-2">
                              <div {...prov.dragHandleProps} className="text-slate-300 hover:text-slate-500 cursor-grab">
                                <GripVertical className="w-4 h-4" />
                              </div>
                              <span className="text-[9px] font-black uppercase tracking-widest text-slate-400 w-14 shrink-0">
                                {FIELD_TYPES.find(f => f.type === field.type)?.label}
                              </span>
                              <span className="flex-1 text-sm font-semibold text-slate-700 truncate">{field.label}</span>
                              {field.required && <span className="text-[9px] text-rose-400 font-bold">obrig.</span>}
                              <button
                                onClick={() => editingField === field.id ? setEditingField(null) : openEditField(field)}
                                className="p-1 hover:bg-slate-100 rounded-lg transition-colors text-slate-400 hover:text-slate-600"
                              >
                                <Edit2 className="w-3.5 h-3.5" />
                              </button>
                              <button
                                onClick={() => removeField(field.id)}
                                className="p-1 hover:bg-rose-50 rounded-lg transition-colors text-slate-400 hover:text-rose-500"
                              >
                                <Trash2 className="w-3.5 h-3.5" />
                              </button>
                            </div>

                            {/* Inline editor */}
                            {editingField === field.id && (
                              <div className="border-t border-slate-100 px-3 py-3 space-y-2.5 bg-slate-50 rounded-b-xl">
                                <div>
                                  <label className="text-[9px] font-black uppercase tracking-wider text-slate-400">Rótulo</label>
                                  <input
                                    className="w-full mt-0.5 px-2 py-1.5 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-indigo-400"
                                    value={fLabel}
                                    onChange={e => setFLabel(e.target.value)}
                                  />
                                </div>
                                {!['title','divider'].includes(field.type) && (
                                  <>
                                    {['text','memo'].includes(field.type) && (
                                      <div>
                                        <label className="text-[9px] font-black uppercase tracking-wider text-slate-400">Placeholder</label>
                                        <input
                                          className="w-full mt-0.5 px-2 py-1.5 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-indigo-400"
                                          value={fPlaceholder}
                                          onChange={e => setFPlaceholder(e.target.value)}
                                        />
                                      </div>
                                    )}
                                    {['radio','checkbox','select'].includes(field.type) && (
                                      <div>
                                        <label className="text-[9px] font-black uppercase tracking-wider text-slate-400">Opções (uma por linha)</label>
                                        <textarea
                                          rows={3}
                                          className="w-full mt-0.5 px-2 py-1.5 border border-slate-200 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-indigo-400 resize-none"
                                          value={fOptions}
                                          onChange={e => setFOptions(e.target.value)}
                                        />
                                      </div>
                                    )}
                                    <label className="flex items-center gap-2 cursor-pointer" onClick={() => setFRequired(!fRequired)}>
                                      <div className={`w-4 h-4 rounded border-2 flex items-center justify-center transition-colors ${fRequired ? 'bg-indigo-500 border-indigo-500' : 'border-slate-300'}`}>
                                        {fRequired && <Check className="w-2.5 h-2.5 text-white" />}
                                      </div>
                                      <span className="text-xs text-slate-600 font-medium">Campo obrigatório</span>
                                    </label>
                                  </>
                                )}
                                <button
                                  onClick={saveFieldEdit}
                                  className="w-full py-1.5 bg-indigo-600 text-white text-xs font-bold rounded-lg hover:bg-indigo-700 transition-colors"
                                >
                                  Confirmar
                                </button>
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
          )}
        </div>
      </div>
    </div>
  );
}

// ─── Main AnamnesisTab ────────────────────────────────────────────────────────

interface Props {
  patientId: string;
}

type View = 'list' | 'manager' | 'builder' | 'fill' | 'read';

export default function AnamnesisTab({ patientId }: Props) {
  const [view, setView]                       = useState<View>('list');
  const [professionals, setProfessionals]     = useState<{ id: string; name: string }[]>([]);
  const [records, setRecords]                 = useState<AnamnesisRecord[]>([]);
  const [templates, setTemplates]             = useState<AnamnesisTemplate[]>([]);
  const [loading, setLoading]                 = useState(true);
  const [showInsertMenu, setShowInsertMenu]   = useState(false);

  // Fill state
  const [fillTemplate, setFillTemplate]       = useState<AnamnesisTemplate | null>(null);
  const [fillData, setFillData]               = useState<Record<string, unknown>>({});
  const [fillProfId, setFillProfId]           = useState('');
  const [fillNotes, setFillNotes]             = useState('');
  const [fillSaving, setFillSaving]           = useState(false);

  // Builder state
  const [builderTemplate, setBuilderTemplate] = useState<Partial<AnamnesisTemplate> | null>(null);

  // Read state
  const [readRecord, setReadRecord]           = useState<AnamnesisRecord | null>(null);

  // Toast
  const [toast, setToast]                     = useState('');
  const showToast = (msg: string) => { setToast(msg); setTimeout(() => setToast(''), 3500); };

  const fetchAll = useCallback(async () => {
    setLoading(true);
    const [tRes, rRes, pRes] = await Promise.all([
      supabase.from('anamnesis_templates').select('*').eq('is_active', true).order('created_at'),
      supabase.from('anamnesis_records')
        .select('*, professionals(name)')
        .eq('patient_id', patientId),
      supabase.from('professionals').select('id, name').eq('is_active', true).order('name'),
    ]);
    if (tRes.error) console.error('[AnamnesisTab] templates error:', tRes.error);
    if (rRes.error) console.error('[AnamnesisTab] records error:', rRes.error);
    if (pRes.error) console.error('[AnamnesisTab] professionals error:', pRes.error);
    // records sorted by created_at desc
    const sortedRecords = (rRes.data || []).sort((a: AnamnesisRecord, b: AnamnesisRecord) =>
      (b.created_at || '').localeCompare(a.created_at || ''));
    setTemplates((tRes.data || []) as AnamnesisTemplate[]);
    setRecords(sortedRecords.map((r: AnamnesisRecord & { professionals?: { name: string } }) => ({
      ...r,
      professional_name: r.professionals?.name || '',
    })));
    setProfessionals((pRes.data || []) as { id: string; name: string }[]);
    setLoading(false);
  }, [patientId]);

  useEffect(() => { fetchAll(); }, [fetchAll]);

  // ── Fill submit ──
  const handleFillSave = async () => {
    if (!fillTemplate) return;
    const missing = fillTemplate.fields.filter(f => f.required && !fillData[f.id]);
    if (missing.length > 0) { showToast(`Campo obrigatório: ${missing[0].label}`); return; }
    setFillSaving(true);
    try {
      const { error: sbError } = await supabase.from('anamnesis_records').insert({
        patient_id:      patientId,
        template_id:     fillTemplate.id,
        template_name:   fillTemplate.name,
        professional_id: fillProfId || null,
        data:            fillData,
        notes:           fillNotes.trim() || null,
      });
      if (sbError) {
        showToast(`Erro ao salvar: ${sbError.message}`);
        return;
      }
      showToast('Registro salvo!');
      await fetchAll();
      setView('list');
    } catch (e: unknown) {
      showToast(e instanceof Error ? e.message : 'Erro inesperado ao salvar');
    } finally {
      setFillSaving(false);
    }
  };

  // ── Delete record ──
  const deleteRecord = async (id: string) => {
    if (!window.confirm('Remover este registro? Esta ação não pode ser desfeita.')) return;
    await supabase.from('anamnesis_records').delete().eq('id', id);
    await fetchAll();
  };

  // ── Delete template ──
  const deleteTemplate = async (id: string) => {
    if (!window.confirm('Desativar este template? Os registros existentes não serão apagados.')) return;
    await supabase.from('anamnesis_templates').update({ is_active: false }).eq('id', id);
    await fetchAll();
  };

  const fmtDate = (iso: string) => new Date(iso).toLocaleDateString('pt-BR', {
    day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit',
  });

  // ── VIEW: READ ──
  if (view === 'read' && readRecord) {
    const tpl = templates.find(t => t.id === readRecord.template_id);
    return (
      <div className="flex flex-col h-full">
        <div className="flex items-center gap-3 px-5 py-3 border-b border-slate-100 bg-white shrink-0">
          <button onClick={() => setView('list')} className="p-1.5 hover:bg-slate-100 rounded-lg">
            <ChevronLeft className="w-4 h-4 text-slate-500" />
          </button>
          <div className="flex-1">
            <p className="font-bold text-slate-800 text-sm">{readRecord.template_name}</p>
            <p className="text-[11px] text-slate-400">
              {readRecord.professional_name} · {fmtDate(readRecord.created_at)}
            </p>
          </div>
        </div>
        <div className="flex-1 overflow-y-auto p-5 custom-scrollbar">
          {tpl ? (
            <div className="space-y-4 max-w-2xl">
              {tpl.fields.map(f => (
                <FieldReader key={f.id} field={f} value={readRecord.data[f.id]} />
              ))}
              {readRecord.notes && (
                <div className="mt-4 p-3 bg-slate-50 rounded-xl">
                  <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1">Observações adicionais</p>
                  <p className="text-sm text-slate-700 whitespace-pre-wrap">{readRecord.notes}</p>
                </div>
              )}
            </div>
          ) : (
            <div className="space-y-4 max-w-2xl">
              {Object.entries(readRecord.data).map(([k, v]) => (
                <div key={k}>
                  <p className="text-[10px] font-bold text-slate-400 uppercase tracking-wider">{k}</p>
                  <p className="text-sm text-slate-700">{String(v)}</p>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    );
  }

  // ── VIEW: BUILDER ──
  if (view === 'builder') {
    return (
      <TemplateBuilder
        template={builderTemplate}
        onBack={() => setView('manager')}
        onSave={async () => { await fetchAll(); setView('manager'); }}
      />
    );
  }

  // ── VIEW: MANAGER ──
  if (view === 'manager') {
    return (
      <div className="flex flex-col h-full">
        <div className="flex items-center gap-3 px-5 py-3 border-b border-slate-100 bg-white shrink-0">
          <button onClick={() => setView('list')} className="p-1.5 hover:bg-slate-100 rounded-lg">
            <ChevronLeft className="w-4 h-4 text-slate-500" />
          </button>
          <h2 className="flex-1 font-black text-slate-800 text-sm">Modelos de Anamnese</h2>
          <button
            onClick={() => { setBuilderTemplate(null); setView('builder'); }}
            className="flex items-center gap-2 px-3 py-1.5 bg-indigo-600 text-white text-xs font-bold rounded-xl hover:bg-indigo-700 transition-colors"
          >
            <Plus className="w-3.5 h-3.5" /> Novo modelo
          </button>
        </div>
        <div className="flex-1 overflow-y-auto p-4 custom-scrollbar">
          {templates.length === 0 ? (
            <div className="flex flex-col items-center justify-center h-full text-slate-300 gap-2">
              <FileText className="w-10 h-10 opacity-40" />
              <p className="text-sm font-semibold text-slate-400">Nenhum modelo criado ainda</p>
            </div>
          ) : (
            <div className="space-y-2">
              {templates.map(t => (
                <div key={t.id} className="flex items-center gap-3 p-3 bg-white border border-slate-200 rounded-xl hover:border-slate-300 transition-colors">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2">
                      <p className="font-bold text-slate-800 text-sm truncate">{t.name}</p>
                      <span className={`text-[9px] font-bold px-2 py-0.5 rounded-full ${TYPE_COLORS[t.type]}`}>
                        {TYPE_LABELS[t.type]}
                      </span>
                    </div>
                    <p className="text-[11px] text-slate-400 mt-0.5">
                      {t.fields.filter(f => !['title','divider'].includes(f.type)).length} campos
                      {t.specialties.length > 0 && ` · ${t.specialties.join(', ')}`}
                    </p>
                  </div>
                  <button
                    onClick={() => { setBuilderTemplate(t); setView('builder'); }}
                    className="p-2 hover:bg-indigo-50 rounded-lg text-slate-400 hover:text-indigo-600 transition-colors"
                  >
                    <Edit2 className="w-4 h-4" />
                  </button>
                  <button
                    onClick={() => deleteTemplate(t.id)}
                    className="p-2 hover:bg-rose-50 rounded-lg text-slate-400 hover:text-rose-500 transition-colors"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    );
  }

  // ── VIEW: FILL ──
  if (view === 'fill' && fillTemplate) {
    return (
      <div className="flex flex-col h-full">
        <div className="flex items-center gap-3 px-5 py-3 border-b border-slate-100 bg-white shrink-0">
          <button onClick={() => setView('list')} className="p-1.5 hover:bg-slate-100 rounded-lg">
            <ChevronLeft className="w-4 h-4 text-slate-500" />
          </button>
          <div className="flex-1">
            <p className="font-bold text-slate-800 text-sm">{fillTemplate.name}</p>
            <span className={`text-[9px] font-bold px-2 py-0.5 rounded-full ${TYPE_COLORS[fillTemplate.type]}`}>
              {TYPE_LABELS[fillTemplate.type]}
            </span>
          </div>
          <button
            onClick={handleFillSave}
            disabled={fillSaving}
            className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white text-sm font-bold rounded-xl hover:bg-indigo-700 disabled:opacity-50 transition-colors shadow-lg shadow-indigo-900/15"
          >
            {fillSaving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
            Salvar
          </button>
        </div>
        {toast && (
          <div className="mx-5 mt-3 px-3 py-2 bg-rose-50 border border-rose-200 text-rose-700 text-xs rounded-xl flex items-center gap-2">
            <AlertCircle className="w-3.5 h-3.5" /> {toast}
          </div>
        )}
        <div className="flex-1 overflow-y-auto p-5 custom-scrollbar">
          <div className="max-w-2xl space-y-4">
            {/* Profissional */}
            <div className="space-y-1">
              <label className="text-[11px] font-bold text-slate-500 uppercase tracking-wider flex items-center gap-1.5">
                <User className="w-3 h-3" /> Profissional responsável
              </label>
              <select
                className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-white appearance-none"
                value={fillProfId}
                onChange={e => setFillProfId(e.target.value)}
              >
                <option value="">Selecione...</option>
                {professionals.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
              </select>
            </div>

            <hr className="border-slate-100" />

            {/* Template fields */}
            {fillTemplate.fields.map(field => (
              <FieldRenderer
                key={field.id}
                field={field}
                value={fillData[field.id]}
                onChange={v => setFillData(prev => ({ ...prev, [field.id]: v }))}
              />
            ))}

            {/* Observações adicionais */}
            <div className="space-y-1 pt-2">
              <label className="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Observações adicionais</label>
              <textarea
                rows={3}
                className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-white resize-none"
                placeholder="Anotações livres, conduta, próximos passos..."
                value={fillNotes}
                onChange={e => setFillNotes(e.target.value)}
              />
            </div>
          </div>
        </div>
      </div>
    );
  }

  // ── VIEW: LIST ──
  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="flex items-center gap-3 px-5 py-3 border-b border-slate-100 bg-white shrink-0">
        <h2 className="flex-1 font-black text-slate-800 text-sm">Anamnese e Evoluções</h2>
        <button
          onClick={() => setView('manager')}
          className="flex items-center gap-1.5 px-3 py-1.5 border border-slate-200 text-slate-500 text-xs font-semibold rounded-xl hover:bg-slate-50 transition-colors"
        >
          <Settings2 className="w-3.5 h-3.5" /> Gerenciar modelos
        </button>

        {/* Insert button + dropdown */}
        <div className="relative">
          <button
            onClick={() => setShowInsertMenu(v => !v)}
            className="flex items-center gap-2 px-3 py-1.5 bg-indigo-600 text-white text-xs font-bold rounded-xl hover:bg-indigo-700 transition-colors shadow-lg shadow-indigo-900/15"
          >
            <Plus className="w-3.5 h-3.5" />
            Inserir Anamnese / Evolução
            <ChevronDown className="w-3 h-3" />
          </button>
          {showInsertMenu && (
            <>
              <div className="fixed inset-0 z-30" onClick={() => setShowInsertMenu(false)} />
              <div className="absolute right-0 top-full mt-1 bg-white rounded-xl shadow-xl border border-slate-100 py-1.5 z-40 min-w-[200px]">
                {templates.length === 0 ? (
                  <p className="px-4 py-2 text-xs text-slate-400">Nenhum modelo disponível.<br />Crie um em "Gerenciar modelos".</p>
                ) : (
                  templates.map(t => (
                    <button
                      key={t.id}
                      onClick={() => {
                        setFillTemplate(t);
                        setFillData({});
                        setFillProfId('');
                        setFillNotes('');
                        setShowInsertMenu(false);
                        setView('fill');
                      }}
                      className="w-full flex items-center gap-3 px-4 py-2.5 hover:bg-indigo-50 transition-colors text-left"
                    >
                      <span className={`text-[9px] font-bold px-1.5 py-0.5 rounded-full ${TYPE_COLORS[t.type]}`}>
                        {TYPE_LABELS[t.type]}
                      </span>
                      <span className="text-sm text-slate-700 font-medium">{t.name}</span>
                    </button>
                  ))
                )}
              </div>
            </>
          )}
        </div>
      </div>

      {toast && (
        <div className="mx-5 mt-3 px-3 py-2 bg-emerald-50 border border-emerald-200 text-emerald-700 text-xs rounded-xl flex items-center gap-2">
          <Check className="w-3.5 h-3.5" /> {toast}
        </div>
      )}

      {/* Records list */}
      <div className="flex-1 overflow-y-auto p-4 custom-scrollbar">
        {loading ? (
          <div className="flex justify-center py-16">
            <Loader2 className="w-6 h-6 text-indigo-400 animate-spin" />
          </div>
        ) : records.length === 0 ? (
          <div className="flex flex-col items-center justify-center h-full gap-3 text-slate-300">
            <Activity className="w-12 h-12 opacity-40" />
            <p className="text-sm font-semibold text-slate-400">Nenhum registro ainda</p>
            <p className="text-xs text-slate-300">Clique em "+ Inserir" para adicionar a primeira anamnese.</p>
          </div>
        ) : (
          <div className="space-y-2 max-w-3xl">
            {records.map(rec => (
              <div key={rec.id} className="bg-white border border-slate-200 rounded-xl overflow-hidden hover:border-slate-300 transition-colors">
                <button
                  className="w-full flex items-center gap-3 px-4 py-3 text-left hover:bg-slate-50 transition-colors"
                  onClick={() => { setReadRecord(rec); setView('read'); }}
                >
                  {/* Type badge */}
                  {(() => {
                    const tpl = templates.find(t => t.id === rec.template_id);
                    return tpl ? (
                      <span className={`text-[9px] font-bold px-2 py-0.5 rounded-full shrink-0 ${TYPE_COLORS[tpl.type]}`}>
                        {TYPE_LABELS[tpl.type]}
                      </span>
                    ) : null;
                  })()}
                  <span className="font-bold text-slate-800 text-sm flex-1 truncate">{rec.template_name}</span>
                  {rec.professional_name && (
                    <span className="text-xs text-slate-400 shrink-0 hidden sm:block">{rec.professional_name}</span>
                  )}
                  <span className="text-xs text-slate-400 shrink-0">{fmtDate(rec.created_at)}</span>
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
