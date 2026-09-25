/**
 * HistoricoFeegowTab — Histórico Clínico importado do Feegow
 * Exibe prescrições, atestados e pedidos de exame da tabela patient_clinical_notes
 */
import React, { useState, useEffect } from 'react';
import { Loader2, AlertCircle, ChevronDown, ChevronUp, Pill, FileText, FlaskConical, Stethoscope } from 'lucide-react';
import { supabase } from '../services/supabaseClient';

interface ClinicalNote {
  id: string;
  type: 'prescricao' | 'atestado' | 'pedido_exame' | 'diagnostico' | 'nota';
  content: string | null;
  professional: string | null;
  note_date: string | null;
  created_at: string;
}

const TYPE_CONFIG: Record<string, { label: string; color: string; icon: React.ElementType }> = {
  prescricao:   { label: 'Prescrição',      color: 'bg-violet-100 text-violet-700 border-violet-200', icon: Pill         },
  atestado:     { label: 'Atestado',        color: 'bg-emerald-100 text-emerald-700 border-emerald-200', icon: FileText  },
  pedido_exame: { label: 'Pedido de Exame', color: 'bg-sky-100 text-sky-700 border-sky-200',          icon: FlaskConical },
  diagnostico:  { label: 'Diagnóstico',     color: 'bg-amber-100 text-amber-700 border-amber-200',    icon: Stethoscope  },
  nota:         { label: 'Nota',            color: 'bg-slate-100 text-slate-600 border-slate-200',    icon: FileText     },
};

function stripHtml(html: string): string {
  return html
    .replace(/<br\s*\/?>/gi, '\n')
    .replace(/<\/p>/gi, '\n')
    .replace(/<[^>]+>/g, '')
    .replace(/&quot;/g, '"')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&nbsp;/g, ' ')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function fmtDate(s: string | null) {
  if (!s) return '—';
  const d = new Date(s);
  return d.toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric' });
}

function NoteCard({ note }: { note: ClinicalNote }) {
  const [open, setOpen] = useState(false);
  const cfg = TYPE_CONFIG[note.type] ?? TYPE_CONFIG['nota'];
  const Icon = cfg.icon;
  const text = note.content ? stripHtml(note.content) : null;

  return (
    <div className="border border-slate-200 rounded-xl overflow-hidden bg-white">
      <button
        onClick={() => setOpen(o => !o)}
        className="w-full flex items-center gap-3 px-4 py-3 hover:bg-slate-50 transition-colors text-left"
      >
        <span className={`inline-flex items-center gap-1 text-xs font-semibold px-2 py-0.5 rounded-full border ${cfg.color}`}>
          <Icon size={11} />
          {cfg.label}
        </span>
        <span className="text-sm text-slate-700 font-medium flex-1 truncate">
          {note.professional ?? 'Profissional não informado'}
        </span>
        <span className="text-xs text-slate-400 shrink-0">{fmtDate(note.note_date)}</span>
        {open ? <ChevronUp size={14} className="text-slate-400 shrink-0" /> : <ChevronDown size={14} className="text-slate-400 shrink-0" />}
      </button>

      {open && text && (
        <div className="px-4 pb-4 pt-1 border-t border-slate-100">
          <pre className="text-sm text-slate-700 whitespace-pre-wrap font-mono leading-relaxed bg-slate-50 rounded-lg p-3">
            {text}
          </pre>
        </div>
      )}
      {open && !text && (
        <div className="px-4 pb-4 pt-2 border-t border-slate-100 text-sm text-slate-400 italic">
          Sem conteúdo registrado.
        </div>
      )}
    </div>
  );
}

const FILTERS = ['todos', 'prescricao', 'atestado', 'pedido_exame', 'diagnostico'] as const;
type Filter = typeof FILTERS[number];

interface Props {
  patientId: string;
}

export default function HistoricoFeegowTab({ patientId }: Props) {
  const [notes, setNotes] = useState<ClinicalNote[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filter, setFilter] = useState<Filter>('todos');

  useEffect(() => {
    async function load() {
      setLoading(true);
      const { data, error: err } = await supabase
        .from('patient_clinical_notes')
        .select('*')
        .eq('patient_id', patientId)
        .order('note_date', { ascending: false });

      if (err) { setError(err.message); }
      else { setNotes(data ?? []); }
      setLoading(false);
    }
    load();
  }, [patientId]);

  const filtered = filter === 'todos' ? notes : notes.filter(n => n.type === filter);

  if (loading) return (
    <div className="flex justify-center py-20">
      <Loader2 className="w-7 h-7 text-indigo-400 animate-spin" />
    </div>
  );

  if (error) return (
    <div className="flex items-center gap-2 text-red-500 px-6 py-8">
      <AlertCircle size={16} /> {error}
    </div>
  );

  return (
    <div className="px-6 py-5 max-w-3xl mx-auto">
      {/* Header */}
      <div className="flex items-center justify-between mb-4">
        <div>
          <h2 className="text-base font-semibold text-slate-800">Histórico Clínico</h2>
          <p className="text-xs text-slate-400">Importado do Feegow — {notes.length} registro{notes.length !== 1 ? 's' : ''}</p>
        </div>
      </div>

      {/* Filtros */}
      <div className="flex gap-2 mb-4 flex-wrap">
        {FILTERS.map(f => {
          const count = f === 'todos' ? notes.length : notes.filter(n => n.type === f).length;
          if (count === 0 && f !== 'todos') return null;
          return (
            <button
              key={f}
              onClick={() => setFilter(f)}
              className={`text-xs px-3 py-1 rounded-full border font-medium transition-colors ${
                filter === f
                  ? 'bg-indigo-600 text-white border-indigo-600'
                  : 'bg-white text-slate-600 border-slate-200 hover:border-indigo-300'
              }`}
            >
              {f === 'todos' ? 'Todos' : TYPE_CONFIG[f]?.label ?? f} ({count})
            </button>
          );
        })}
      </div>

      {/* Lista */}
      {filtered.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 text-center">
          <div className="w-14 h-14 rounded-2xl bg-slate-100 flex items-center justify-center mb-3">
            <FileText size={24} className="text-slate-300" />
          </div>
          <p className="text-sm text-slate-400">Nenhum registro encontrado</p>
        </div>
      ) : (
        <div className="flex flex-col gap-2">
          {filtered.map(note => <NoteCard key={note.id} note={note} />)}
        </div>
      )}
    </div>
  );
}
