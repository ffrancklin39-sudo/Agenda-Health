import React, { useState, useMemo, useEffect } from 'react';
import {
  Search, UserPlus, Calendar, Edit2, DollarSign, X,
  ChevronLeft, ChevronRight, ShieldCheck, Loader2
} from 'lucide-react';
import { Patient, PatientStatus, UserRole } from '../types';
import { supabase } from '../services/supabaseClient';
import { podeReceberDisparo, rotuloConsentimento, ORIGENS_MASSA, ORIGEM_LABEL, OrigemOptIn } from '../lib/consentimento';

interface Props {
  patients: Patient[];
  updateStatus: (id: string, status: PatientStatus) => void;
  onSelectPatient: (id: string) => void;
  onRefresh: () => void;
  session?: any;
  initialSearch?: string;
  userRole: UserRole;
}

interface ResultadoMassa { marcados: number; ja_sim: number; pulados_opt_out: number; pulados_nao: number; nao_encontrados: number }

const ALPHABET = ['TODOS','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
const ITEMS_PER_PAGE = 20;

function formatDateTime(dateStr?: string | null) {
  if (!dateStr || dateStr === 'Não agendado') return null;
  const d = new Date(dateStr);
  if (isNaN(d.getTime())) return null;
  return d.toLocaleDateString('pt-BR') + ' - ' + d.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });
}

function formatBirth(dateStr?: string | null) {
  if (!dateStr) return '';
  // Feegow envia apenas "YYYY-MM-DD"
  const d = new Date(dateStr + (dateStr.includes('T') ? '' : 'T00:00:00'));
  if (isNaN(d.getTime())) return dateStr;
  return d.toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric' });
}

const PatientList: React.FC<Props> = ({ patients, onSelectPatient, initialSearch = '', userRole }) => {
  const [searchTerm, setSearchTerm] = useState(initialSearch);

  // Sincroniza busca global vinda do header
  useEffect(() => { setSearchTerm(initialSearch); }, [initialSearch]);
  const [letterFilter, setLetterFilter] = useState('TODOS');
  const [showInactive, setShowInactive] = useState(false);
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [page, setPage] = useState(1);
  const [soElegiveis, setSoElegiveis] = useState(false);

  // Marcação de opt-in em massa (somente ADMIN; o banco confere de novo)
  const [massaAberta, setMassaAberta] = useState(false);
  const [massaOrigem, setMassaOrigem] = useState<OrigemOptIn>('form_com_consentimento');
  const [massaEvidencia, setMassaEvidencia] = useState('');
  const [massaConfirma, setMassaConfirma] = useState('');
  const [massaSalvando, setMassaSalvando] = useState(false);
  const [massaErro, setMassaErro] = useState<string | null>(null);
  const [massaResultado, setMassaResultado] = useState<ResultadoMassa | null>(null);
  const isAdmin = userRole === 'ADMIN';
  const FRASE_CONFIRMA = 'CONFIRMO';

  const abrirMassa = () => {
    setMassaErro(null); setMassaResultado(null); setMassaConfirma(''); setMassaEvidencia('');
    setMassaAberta(true);
  };

  const executarMassa = async () => {
    setMassaErro(null);
    if (massaEvidencia.trim().length < 20) { setMassaErro('Descreva a evidência (mín. 20 caracteres).'); return; }
    if (massaConfirma.trim().toUpperCase() !== FRASE_CONFIRMA) { setMassaErro(`Digite ${FRASE_CONFIRMA} para confirmar.`); return; }
    const ids = Array.from(selectedIds).filter(Boolean);
    if (ids.length === 0) { setMassaErro('Nenhum cadastro selecionado.'); return; }
    if (ids.length > 500) { setMassaErro('Máximo de 500 cadastros por vez.'); return; }
    setMassaSalvando(true);
    const { data, error } = await supabase.rpc('marcar_opt_in_em_massa', {
      p_ids: ids, p_origem: massaOrigem, p_evidencia: massaEvidencia.trim(),
    });
    setMassaSalvando(false);
    if (error) { setMassaErro(error.message); return; }
    const r = (Array.isArray(data) ? data[0] : data) as ResultadoMassa | undefined;
    setMassaResultado(r ?? { marcados: 0, ja_sim: 0, pulados_opt_out: 0, pulados_nao: 0, nao_encontrados: 0 });
    setSelectedIds(new Set());
  };

  const filtered = useMemo(() => {
    let list = patients;

    if (showInactive) {
      list = list.filter(p => p.status === 'discarded');
    } else {
      list = list.filter(p => p.status !== 'discarded');
    }

    if (soElegiveis) {
      list = list.filter(p => podeReceberDisparo(p));
    }

    if (letterFilter !== 'TODOS') {
      list = list.filter(p => p.name.toUpperCase().startsWith(letterFilter));
    }

    if (searchTerm) {
      const q = searchTerm.toLowerCase();
      list = list.filter(p =>
        p.name.toLowerCase().includes(q) ||
        (p.cpf && p.cpf.includes(q)) ||
        (p.phone && p.phone.includes(q)) ||
        (p.record_number && p.record_number.includes(q))
      );
    }

    return list.sort((a, b) => a.name.localeCompare(b.name, 'pt-BR'));
  }, [patients, searchTerm, letterFilter, showInactive, soElegiveis]);

  const totalPages = Math.max(1, Math.ceil(filtered.length / ITEMS_PER_PAGE));
  const paginated = filtered.slice((page - 1) * ITEMS_PER_PAGE, page * ITEMS_PER_PAGE);

  const toggleSelect = (id: string) => {
    setSelectedIds(prev => {
      const next = new Set(prev);
      next.has(id) ? next.delete(id) : next.add(id);
      return next;
    });
  };

  const toggleSelectAll = () => {
    setSelectedIds(
      selectedIds.size === paginated.length
        ? new Set()
        : new Set(paginated.map(p => String(p.id)))
    );
  };

  const handleLetter = (l: string) => { setLetterFilter(l); setPage(1); };
  const handleSearch = (v: string) => { setSearchTerm(v); setPage(1); };

  return (
    <div className="flex h-full min-h-0 overflow-hidden" style={{ fontFamily: 'system-ui, sans-serif' }}>

      {/* ── Sidebar esquerda ── */}
      <div className="w-40 flex-shrink-0 bg-white border-r border-slate-200 flex flex-col py-4 px-2 gap-1">
        <p className="text-[10px] font-bold text-slate-400 uppercase tracking-widest px-2 mb-2">
          Outros Pacientes
        </p>
        <button
          onClick={() => { setShowInactive(true); setPage(1); }}
          className={`text-left px-3 py-2 rounded text-xs font-semibold transition-colors ${
            showInactive ? 'bg-indigo-600 text-white' : 'text-slate-600 hover:bg-slate-100'
          }`}
        >
          Inativos
        </button>
        <button
          onClick={() => { setShowInactive(false); setPage(1); }}
          className={`text-left px-3 py-2 rounded text-xs font-semibold transition-colors ${
            !showInactive ? 'bg-indigo-600 text-white' : 'text-slate-600 hover:bg-slate-100'
          }`}
        >
          Ativos
        </button>
      </div>

      {/* ── Área principal ── */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden bg-slate-50">

        {/* Topbar */}
        <div className="flex items-center gap-2 px-3 py-2 bg-white border-b border-slate-200 flex-shrink-0">
          <div className="relative w-48">
            <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 text-slate-400" size={13} />
            <input
              type="text"
              placeholder="Busca rápida..."
              className="w-full pl-8 pr-2 py-1.5 text-xs border border-slate-200 rounded focus:outline-none focus:ring-2 focus:ring-indigo-400 bg-slate-50"
              value={searchTerm}
              onChange={e => handleSearch(e.target.value)}
            />
          </div>
          <button
            onClick={() => { setSoElegiveis(v => !v); setPage(1); }}
            title="Mostra só quem tem opt-in, sem opt-out e com telefone válido"
            className={`flex items-center gap-1 px-2.5 py-1.5 rounded text-xs font-semibold border transition-colors ${
              soElegiveis ? 'bg-emerald-600 text-white border-emerald-600' : 'text-slate-600 border-slate-200 hover:bg-slate-100'
            }`}
          >
            <ShieldCheck size={12} /> Elegíveis para disparo
          </button>
          {isAdmin && selectedIds.size > 0 && (
            <button
              onClick={abrirMassa}
              className="flex items-center gap-1 px-2.5 py-1.5 rounded text-xs font-semibold bg-indigo-600 text-white hover:bg-indigo-700"
            >
              Marcar opt-in ({selectedIds.size})
            </button>
          )}
          <div className="flex-1" />
          <span className="text-xs text-slate-400">{filtered.length} pacientes</span>
          <button
            onClick={() => onSelectPatient('NEW')}
            className="flex items-center gap-1 bg-emerald-500 hover:bg-emerald-600 text-white text-xs font-bold px-3 py-1.5 rounded transition-colors whitespace-nowrap"
          >
            <UserPlus size={13} />
            + INSERIR
          </button>
        </div>

        {/* Filtro A-Z */}
        <div className="flex items-center gap-px px-3 py-1.5 bg-white border-b border-slate-200 flex-shrink-0 flex-wrap">
          {ALPHABET.map(l => (
            <button
              key={l}
              onClick={() => handleLetter(l)}
              className={`px-1.5 py-0.5 text-[11px] font-semibold rounded transition-colors ${
                letterFilter === l
                  ? 'bg-slate-700 text-white'
                  : 'text-slate-500 hover:bg-slate-100'
              }`}
            >
              {l}
            </button>
          ))}
        </div>

        {/* Tabela — scroll vertical e horizontal quando necessário */}
        <div className="flex-1 overflow-auto">
          <table className="text-left border-collapse" style={{ tableLayout: 'fixed', minWidth: '1080px', width: '100%' }}>
            <colgroup>
              <col style={{ width: '32px' }} />   {/* checkbox */}
              <col style={{ width: '80px' }} />   {/* prontuário */}
              <col style={{ width: '200px' }} />  {/* nome */}
              <col style={{ width: '110px' }} />  {/* CPF */}
              <col style={{ width: '100px' }} />  {/* convênio */}
              <col style={{ width: '90px' }} />   {/* nascimento */}
              <col style={{ width: '65px' }} />   {/* sexo */}
              <col style={{ width: '120px' }} />  {/* celular */}
              <col style={{ width: '140px' }} />  {/* últ. agend. */}
              <col style={{ width: '140px' }} />  {/* próx. agend. */}
              <col style={{ width: '73px' }} />   {/* ações */}
            </colgroup>

            <thead>
              <tr className="bg-white border-b border-slate-200 sticky top-0 z-10 text-[11px]">
                <th className="px-2 py-2">
                  <input
                    type="checkbox"
                    checked={paginated.length > 0 && selectedIds.size === paginated.length}
                    onChange={toggleSelectAll}
                    className="cursor-pointer"
                  />
                </th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Pront.</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Nome</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">CPF</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Convênio</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Nascimento</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Sexo</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Celular</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Últ. Agend.</th>
                <th className="px-2 py-2 text-slate-500 font-semibold">Próx. Agend.</th>
                <th className="px-2 py-2"></th>
              </tr>
            </thead>

            <tbody className="text-xs">
              {paginated.map(patient => {
                const id = String(patient.id);
                const lastAppt = formatDateTime(patient.appointment_date || patient.appointmentDate);

                return (
                  <tr
                    key={id}
                    className="border-b border-slate-100 hover:bg-blue-50/50 transition-colors group"
                  >
                    {/* Checkbox */}
                    <td className="px-2 py-1" onClick={e => e.stopPropagation()}>
                      <input
                        type="checkbox"
                        checked={selectedIds.has(id)}
                        onChange={() => toggleSelect(id)}
                        className="cursor-pointer"
                      />
                    </td>

                    {/* Prontuário */}
                    <td className="px-2 py-1 text-slate-500 truncate">
                      {patient.record_number || id.slice(0, 6)}
                    </td>

                    {/* Nome — link azul */}
                    <td className="px-2 py-1">
                      <button
                        onClick={() => onSelectPatient(id)}
                        className="text-blue-600 hover:underline font-medium text-left truncate w-full block"
                        title={patient.name}
                      >
                        {patient.name}
                      </button>
                    </td>

                    {/* CPF */}
                    <td className="px-2 py-1 text-slate-600 truncate">
                      {patient.cpf || ''}
                    </td>

                    {/* Convênio */}
                    <td className="px-2 py-1 text-slate-600 truncate">
                      {patient.insurance || ''}
                    </td>

                    {/* Nascimento */}
                    <td className="px-2 py-1 text-slate-600 whitespace-nowrap">
                      {formatBirth(patient.birth_date || patient.date_of_birth)}
                    </td>

                    {/* Sexo */}
                    <td className="px-2 py-1 text-slate-600 truncate">
                      {patient.gender || ''}
                    </td>

                    {/* Celular */}
                    <td className="px-2 py-1 text-slate-600 truncate">
                      {patient.phone || patient.cell2 || ''}
                      {(() => { const r = rotuloConsentimento(patient); return (
                        <span className={`ml-1.5 text-[9px] font-bold px-1.5 py-0.5 rounded-full border ${r.cor}`}>{r.texto}</span>
                      ); })()}
                    </td>

                    {/* Últ. Agend. */}
                    <td className="px-2 py-1">
                      {lastAppt ? (
                        <span className="flex items-center gap-1 border-l-2 border-indigo-400 pl-1.5 text-slate-600 truncate">
                          <Calendar size={10} className="text-indigo-400 flex-shrink-0" />
                          <span className="truncate">{lastAppt}</span>
                        </span>
                      ) : null}
                    </td>

                    {/* Próx. Agend. — futuro */}
                    <td className="px-2 py-1 text-slate-400" />

                    {/* Ações */}
                    <td className="px-2 py-1" onClick={e => e.stopPropagation()}>
                      <div className="flex items-center gap-0.5">
                        <button
                          onClick={() => onSelectPatient(id)}
                          title="Editar"
                          className="w-5 h-5 flex items-center justify-center rounded bg-cyan-500 hover:bg-cyan-600 text-white transition-colors"
                        >
                          <Edit2 size={10} />
                        </button>
                        <button
                          title="Financeiro"
                          className="w-5 h-5 flex items-center justify-center rounded bg-emerald-500 hover:bg-emerald-600 text-white transition-colors"
                        >
                          <DollarSign size={10} />
                        </button>
                        <button
                          title="Inativar"
                          className="w-5 h-5 flex items-center justify-center rounded bg-red-500 hover:bg-red-600 text-white transition-colors"
                        >
                          <X size={10} />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}

              {paginated.length === 0 && (
                <tr>
                  <td colSpan={11} className="py-10 text-center text-slate-400">
                    Nenhum paciente encontrado.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Paginação */}
        <div className="flex items-center justify-between px-3 py-2 bg-white border-t border-slate-200 text-xs text-slate-500 flex-shrink-0">
          <span>
            {(page - 1) * ITEMS_PER_PAGE + 1}–{Math.min(page * ITEMS_PER_PAGE, filtered.length)} de {filtered.length}
          </span>
          <div className="flex items-center gap-2">
            <button
              onClick={() => setPage(p => Math.max(1, p - 1))}
              disabled={page === 1}
              className="p-1 rounded hover:bg-slate-100 disabled:opacity-30 transition-colors"
            >
              <ChevronLeft size={13} />
            </button>
            <span>Página {page} de {totalPages}</span>
            <button
              onClick={() => setPage(p => Math.min(totalPages, p + 1))}
              disabled={page === totalPages}
              className="p-1 rounded hover:bg-slate-100 disabled:opacity-30 transition-colors"
            >
              <ChevronRight size={13} />
            </button>
          </div>
        </div>

      </div>

      {massaAberta && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg p-5 space-y-4">
            <h3 className="text-sm font-bold text-slate-800">Marcar opt-in em massa</h3>
            {massaResultado ? (
              <>
                <ul className="text-sm text-slate-700 space-y-1">
                  <li><b>{massaResultado.marcados}</b> marcados como opt-in</li>
                  <li>{massaResultado.ja_sim} já tinham opt-in</li>
                  <li>{massaResultado.pulados_opt_out} pulados por opt-out (opt-out sempre vence)</li>
                  <li>{massaResultado.pulados_nao} pulados por recusa ("Recusou" só muda na ficha, um a um)</li>
                  {massaResultado.nao_encontrados > 0 && <li>{massaResultado.nao_encontrados} não encontrados</li>}
                </ul>
                <p className="text-xs text-slate-400">Registrado com seu usuário, data e hora no histórico de cada cadastro.</p>
                <div className="flex justify-end">
                  <button onClick={() => setMassaAberta(false)} className="px-4 py-2 text-sm font-semibold text-white bg-indigo-600 rounded-lg">Fechar</button>
                </div>
              </>
            ) : (
              <>
                <p className="text-sm text-slate-600">
                  Você vai registrar que <b>{selectedIds.size}</b> cadastro(s) <b>aceitaram</b> receber mensagens no WhatsApp.
                  Só faça isso se tiver a prova do aceite de cada um. Quem tem opt-out ou recusou não é alterado.
                </p>
                <div>
                  <label className="block text-[11px] font-bold uppercase text-slate-400 tracking-wider mb-1">Origem</label>
                  <select value={massaOrigem} onChange={e => setMassaOrigem(e.target.value as OrigemOptIn)}
                    className="w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 text-sm">
                    {ORIGENS_MASSA.map(o => <option key={o} value={o}>{ORIGEM_LABEL[o]}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-[11px] font-bold uppercase text-slate-400 tracking-wider mb-1">Evidência *</label>
                  <textarea value={massaEvidencia} onChange={e => setMassaEvidencia(e.target.value)}
                    placeholder="Ex.: fichas de cadastro em papel com aceite de WhatsApp (modelo v1, vigente desde 01/10/2026), arquivadas na recepção"
                    className="w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 text-sm min-h-[72px]" />
                </div>
                <div>
                  <label className="block text-[11px] font-bold uppercase text-slate-400 tracking-wider mb-1">Digite {FRASE_CONFIRMA} para confirmar</label>
                  <input value={massaConfirma} onChange={e => setMassaConfirma(e.target.value)}
                    className="w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 text-sm" />
                </div>
                {massaErro && <p className="text-sm text-rose-600 bg-rose-50 px-3 py-2 rounded-lg">{massaErro}</p>}
                <div className="flex justify-end gap-2">
                  <button onClick={() => setMassaAberta(false)} className="px-4 py-2 text-sm text-slate-500 border border-slate-200 rounded-lg">Cancelar</button>
                  <button onClick={executarMassa} disabled={massaSalvando}
                    className="flex items-center gap-1.5 px-4 py-2 text-sm font-semibold text-white bg-indigo-600 rounded-lg disabled:opacity-60">
                    {massaSalvando && <Loader2 size={14} className="animate-spin" />} Marcar opt-in
                  </button>
                </div>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default PatientList;
