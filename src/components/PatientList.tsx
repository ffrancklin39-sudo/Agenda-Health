import React, { useState, useMemo, useEffect } from 'react';
import {
  Search, UserPlus, Calendar, Edit2, DollarSign, X,
  ChevronLeft, ChevronRight
} from 'lucide-react';
import { Patient, PatientStatus } from '../types';

interface Props {
  patients: Patient[];
  updateStatus: (id: string, status: PatientStatus) => void;
  onSelectPatient: (id: string) => void;
  onRefresh: () => void;
  session?: any;
  initialSearch?: string;
}

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

const PatientList: React.FC<Props> = ({ patients, onSelectPatient, initialSearch = '' }) => {
  const [searchTerm, setSearchTerm] = useState(initialSearch);

  // Sincroniza busca global vinda do header
  useEffect(() => { setSearchTerm(initialSearch); }, [initialSearch]);
  const [letterFilter, setLetterFilter] = useState('TODOS');
  const [showInactive, setShowInactive] = useState(false);
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [page, setPage] = useState(1);

  const filtered = useMemo(() => {
    let list = patients;

    if (showInactive) {
      list = list.filter(p => p.status === 'discarded');
    } else {
      list = list.filter(p => p.status !== 'discarded');
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
  }, [patients, searchTerm, letterFilter, showInactive]);

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

        {/* Tabela — ocupa o espaço restante com scroll só vertical */}
        <div className="flex-1 overflow-y-auto overflow-x-hidden">
          <table className="w-full text-left border-collapse" style={{ tableLayout: 'fixed' }}>
            <colgroup>
              <col style={{ width: '2%' }} />   {/* checkbox */}
              <col style={{ width: '7%' }} />   {/* prontuário */}
              <col style={{ width: '20%' }} />  {/* nome */}
              <col style={{ width: '10%' }} />  {/* CPF */}
              <col style={{ width: '9%' }} />   {/* convênio */}
              <col style={{ width: '8%' }} />   {/* nascimento */}
              <col style={{ width: '7%' }} />   {/* sexo */}
              <col style={{ width: '10%' }} />  {/* celular */}
              <col style={{ width: '11%' }} />  {/* últ. agend. */}
              <col style={{ width: '11%' }} />  {/* próx. agend. */}
              <col style={{ width: '5%' }} />   {/* ações */}
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
    </div>
  );
};

export default PatientList;
