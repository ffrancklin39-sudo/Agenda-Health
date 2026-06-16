import React, { useState } from 'react';
import {
  Briefcase, Plus, DollarSign, Clock, X, Save, Loader2,
  Pencil, Trash2, Search, Tag,
} from 'lucide-react';
import { ClinicService } from '../types';
import { supabase } from '../services/supabaseClient';

interface Props {
  services: ClinicService[];
  onRefresh: () => void;
}

const CATEGORIES = [
  'Consulta', 'Biomedicina', 'Nutrição', 'Estética', 'Fisioterapia',
  'Psicologia', 'Acupuntura', 'Massoterapia', 'Outro',
];

const blank = () => ({ name: '', price: '', duration: '60', category: 'Consulta', description: '' });

const ServicesCatalog: React.FC<Props> = ({ services, onRefresh }) => {
  const [search, setSearch]         = useState('');
  const [showForm, setShowForm]     = useState(false);
  const [editingId, setEditingId]   = useState<string | null>(null);
  const [form, setForm]             = useState(blank());
  const [saving, setSaving]         = useState(false);
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const [error, setError]           = useState('');

  const filtered = services.filter(s =>
    s.name.toLowerCase().includes(search.toLowerCase()) ||
    (s.category || '').toLowerCase().includes(search.toLowerCase())
  );

  const openNew = () => {
    setForm(blank());
    setEditingId(null);
    setError('');
    setShowForm(true);
  };

  const openEdit = (s: ClinicService) => {
    setForm({
      name:        s.name,
      price:       String(s.price),
      duration:    String(s.duration || s.duration_minutes || 60),
      category:    s.category || 'Outro',
      description: s.description || '',
    });
    setEditingId(s.id);
    setError('');
    setShowForm(true);
  };

  const handleSave = async () => {
    if (!form.name.trim()) { setError('Nome é obrigatório.'); return; }
    if (!form.price || isNaN(Number(form.price))) { setError('Preço inválido.'); return; }
    setSaving(true); setError('');
    const payload = {
      name:        form.name.trim(),
      price:       parseFloat(form.price),
      duration:    parseInt(form.duration) || 60,
      category:    form.category,
      description: form.description.trim() || null,
    };
    const { error: sbErr } = editingId
      ? await supabase.from('services').update(payload).eq('id', editingId)
      : await supabase.from('services').insert(payload);
    setSaving(false);
    if (sbErr) { setError(sbErr.message); return; }
    setShowForm(false);
    onRefresh();
  };

  const handleDelete = async (s: ClinicService) => {
    setDeletingId(s.id);
    const { error: sbErr } = await supabase.from('services').delete().eq('id', s.id);
    setDeletingId(null);
    if (sbErr) { alert('Erro ao excluir: ' + sbErr.message); return; }
    onRefresh();
  };

  const ch = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) =>
    setForm(f => ({ ...f, [e.target.name]: e.target.value }));

  const fmt = (v: number) => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-900 tracking-tight">Catálogo de Serviços</h2>
          <p className="text-slate-500 text-sm mt-0.5">{services.length} procedimentos cadastrados</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
            <input
              className="pl-9 pr-4 py-2 border border-slate-200 rounded-xl text-sm bg-white focus:outline-none focus:ring-2 focus:ring-indigo-400 w-52"
              placeholder="Buscar serviço..."
              value={search}
              onChange={e => setSearch(e.target.value)}
            />
          </div>
          <button
            onClick={openNew}
            className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white text-sm font-bold rounded-xl hover:bg-indigo-700 transition-colors shadow-lg shadow-indigo-900/15"
          >
            <Plus className="w-4 h-4" /> Novo Serviço
          </button>
        </div>
      </div>

      {/* Grid */}
      {filtered.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-24 text-slate-400 gap-3">
          <Briefcase className="w-12 h-12 opacity-30" />
          <p className="font-semibold text-slate-500">
            {search ? 'Nenhum serviço encontrado' : 'Nenhum serviço cadastrado ainda'}
          </p>
          {!search && (
            <button onClick={openNew} className="text-sm text-indigo-600 font-bold hover:underline">
              Cadastrar primeiro serviço
            </button>
          )}
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {filtered.map(s => (
            <div
              key={s.id}
              className="bg-white border border-slate-200 rounded-2xl p-5 hover:border-indigo-200 hover:shadow-md transition-all duration-200 group flex flex-col"
            >
              <div className="flex items-start justify-between mb-4">
                <div className="w-10 h-10 rounded-xl bg-indigo-50 flex items-center justify-center text-indigo-600 group-hover:bg-indigo-600 group-hover:text-white transition-all duration-300">
                  <Briefcase className="w-5 h-5" />
                </div>
                <span className="text-[10px] font-bold px-2.5 py-1 bg-slate-100 text-slate-500 rounded-full uppercase tracking-wider">
                  {s.category || 'Geral'}
                </span>
              </div>

              <h3 className="font-black text-slate-800 text-base leading-snug mb-1">{s.name}</h3>
              {s.description && (
                <p className="text-xs text-slate-400 mb-3 line-clamp-2">{s.description}</p>
              )}

              <div className="flex items-center gap-4 mt-auto pt-3 border-t border-slate-100">
                <div className="flex items-center gap-1.5 text-emerald-600">
                  <DollarSign className="w-3.5 h-3.5" />
                  <span className="text-sm font-black">{fmt(s.price)}</span>
                </div>
                <div className="flex items-center gap-1.5 text-slate-400">
                  <Clock className="w-3.5 h-3.5" />
                  <span className="text-xs font-semibold">{s.duration || s.duration_minutes || '?'} min</span>
                </div>
                <div className="flex items-center gap-1 ml-auto">
                  <button
                    onClick={() => openEdit(s)}
                    className="p-1.5 hover:bg-indigo-50 rounded-lg text-slate-400 hover:text-indigo-600 transition-colors"
                    title="Editar"
                  >
                    <Pencil className="w-3.5 h-3.5" />
                  </button>
                  <button
                    onClick={() => handleDelete(s)}
                    disabled={deletingId === s.id}
                    className="p-1.5 hover:bg-rose-50 rounded-lg text-slate-400 hover:text-rose-500 transition-colors disabled:opacity-50"
                    title="Excluir"
                  >
                    {deletingId === s.id
                      ? <Loader2 className="w-3.5 h-3.5 animate-spin" />
                      : <Trash2 className="w-3.5 h-3.5" />}
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Modal create/edit */}
      {showForm && (
        <>
          <div className="fixed inset-0 bg-black/40 z-40" onClick={() => setShowForm(false)} />
          <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md">
              <div className="flex items-center justify-between px-6 py-4 border-b border-slate-100">
                <h3 className="font-black text-slate-800">
                  {editingId ? 'Editar Serviço' : 'Novo Serviço'}
                </h3>
                <button onClick={() => setShowForm(false)} className="p-1.5 hover:bg-slate-100 rounded-lg">
                  <X className="w-4 h-4 text-slate-500" />
                </button>
              </div>

              <div className="px-6 py-5 space-y-4">
                {error && (
                  <p className="text-xs text-rose-600 bg-rose-50 px-3 py-2 rounded-lg">{error}</p>
                )}

                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Nome *</label>
                  <input
                    name="name" value={form.name} onChange={ch}
                    placeholder="Ex.: Consulta de Biomedicina"
                    className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"
                  />
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1">
                    <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Preço (R$) *</label>
                    <input
                      name="price" value={form.price} onChange={ch} type="number" min="0" step="0.01"
                      placeholder="0,00"
                      className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"
                    />
                  </div>
                  <div className="space-y-1">
                    <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Duração (min)</label>
                    <input
                      name="duration" value={form.duration} onChange={ch} type="number" min="5" step="5"
                      className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"
                    />
                  </div>
                </div>

                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Categoria</label>
                  <select
                    name="category" value={form.category} onChange={ch}
                    className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-white appearance-none"
                  >
                    {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
                  </select>
                </div>

                <div className="space-y-1">
                  <label className="text-[10px] font-black uppercase tracking-wider text-slate-400">Descrição (opcional)</label>
                  <textarea
                    name="description" value={form.description} onChange={ch} rows={2}
                    placeholder="Breve descrição do procedimento..."
                    className="w-full px-3 py-2 border border-slate-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 resize-none"
                  />
                </div>
              </div>

              <div className="flex justify-end gap-3 px-6 py-4 border-t border-slate-100">
                <button
                  onClick={() => setShowForm(false)}
                  className="px-4 py-2 text-sm text-slate-600 hover:bg-slate-100 rounded-xl transition-colors"
                >
                  Cancelar
                </button>
                <button
                  onClick={handleSave}
                  disabled={saving}
                  className="flex items-center gap-2 px-5 py-2 bg-indigo-600 text-white text-sm font-bold rounded-xl hover:bg-indigo-700 disabled:opacity-50 transition-colors"
                >
                  {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                  {editingId ? 'Salvar' : 'Criar Serviço'}
                </button>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default ServicesCatalog;
