// ConsentimentoWhatsApp.tsx — ver/editar o consentimento de WhatsApp de um
// lead ou paciente. Toda escrita passa pelas funções do banco
// (atualizar_consentimento, marcar_opt_out, reverter_opt_out), que validam,
// auditam e aplicam a regra "opt-out sempre vence".
import React, { useCallback, useEffect, useState } from 'react';
import { ShieldCheck, ShieldOff, Loader2, History, AlertTriangle } from 'lucide-react';
import { supabase } from '../services/supabaseClient';
import { UserRole } from '../types';
import {
  OptIn, OrigemOptIn, ORIGEM_LABEL, ORIGENS_EDITAVEIS, OPT_IN_LABEL,
  podeReceberDisparo, rotuloConsentimento,
} from '../lib/consentimento';

interface Props {
  patientId: string;
  userRole: UserRole;
}

interface Estado {
  phone: string | null;
  phone_e164: string | null;
  opt_in: OptIn;
  opt_in_origem: string | null;
  opt_in_data: string | null;
  opt_in_evidencia: string | null;
  opt_out: boolean;
  opt_out_data: string | null;
}

interface Evento {
  id: number;
  ocorrido_em: string;
  acao: string;
  opt_in_depois: OptIn | null;
  opt_out_depois: boolean | null;
  origem: string | null;
}

const ACAO_LABEL: Record<string, string> = {
  edicao: 'Edição', massa: 'Marcação em massa', entrada_automatica: 'Entrada automática',
  opt_out: 'Opt-out', reversao_opt_out: 'Opt-out revertido', supressao_propagada: 'Opt-out (mesmo número)',
  sistema: 'Sistema',
};

const fmt = (d: string | null) => (d ? new Date(d).toLocaleString('pt-BR') : '—');
const I = 'w-full px-3 py-2 rounded-lg border border-slate-200 bg-slate-50 focus:bg-white focus:ring-2 focus:ring-indigo-500 outline-none text-sm text-slate-800';
const LB = 'block text-[11px] font-bold uppercase text-slate-400 tracking-wider mb-1';

const ConsentimentoWhatsApp: React.FC<Props> = ({ patientId, userRole }) => {
  const [estado, setEstado]     = useState<Estado | null>(null);
  const [eventos, setEventos]   = useState<Evento[]>([]);
  const [carregando, setCarregando] = useState(true);
  const [salvando, setSalvando] = useState(false);
  const [erro, setErro]         = useState<string | null>(null);
  const [ok, setOk]             = useState<string | null>(null);

  // formulário de edição
  const [optIn, setOptIn]       = useState<OptIn>('incerto');
  const [origem, setOrigem]     = useState<string>('');
  const [evidencia, setEvidencia] = useState('');

  // modais
  const [modal, setModal]       = useState<null | 'optout' | 'reverter'>(null);
  const [motivo, setMotivo]     = useState('');

  const carregar = useCallback(async () => {
    setCarregando(true);
    setErro(null);
    const [p, e] = await Promise.all([
      supabase.from('patients')
        .select('phone, phone_e164, opt_in, opt_in_origem, opt_in_data, opt_in_evidencia, opt_out, opt_out_data')
        .eq('id', patientId).single(),
      supabase.from('consentimento_eventos')
        .select('id, ocorrido_em, acao, opt_in_depois, opt_out_depois, origem')
        .eq('patient_id', patientId).order('ocorrido_em', { ascending: false }).limit(10),
    ]);
    if (p.error || !p.data) {
      setErro('Não foi possível carregar o consentimento. A migration já foi aplicada no banco?');
      setCarregando(false);
      return;
    }
    const d = p.data as Estado;
    const normal: Estado = {
      ...d,
      opt_in: d.opt_in === 'sim' || d.opt_in === 'nao' ? d.opt_in : 'incerto',
      opt_out: d.opt_out === true,
    };
    setEstado(normal);
    setOptIn(normal.opt_in);
    setOrigem(normal.opt_in_origem ?? '');
    setEvidencia(normal.opt_in_evidencia ?? '');
    setEventos((e.data ?? []) as Evento[]);
    setCarregando(false);
  }, [patientId]);

  useEffect(() => { carregar(); }, [carregar]);

  const salvar = async () => {
    setErro(null); setOk(null);
    if (optIn === 'sim') {
      if (!origem) { setErro('Escolha a origem do consentimento.'); return; }
      if (evidencia.trim().length < 10) { setErro('Descreva a evidência (mín. 10 caracteres): onde e como a pessoa aceitou.'); return; }
    }
    setSalvando(true);
    const { error } = await supabase.rpc('atualizar_consentimento', {
      p_patient_id: patientId, p_opt_in: optIn,
      p_origem: origem || null, p_evidencia: evidencia.trim() || null,
    });
    setSalvando(false);
    if (error) { setErro(error.message); return; }
    setOk('Consentimento salvo.');
    carregar();
  };

  const confirmarModal = async () => {
    setErro(null); setOk(null);
    if (modal === 'reverter' && motivo.trim().length < 10) { setErro('Informe o motivo (mín. 10 caracteres).'); return; }
    setSalvando(true);
    const { error } = modal === 'optout'
      ? await supabase.rpc('marcar_opt_out', { p_patient_id: patientId, p_motivo: motivo.trim() || null })
      : await supabase.rpc('reverter_opt_out', { p_patient_id: patientId, p_motivo: motivo.trim() });
    setSalvando(false);
    if (error) { setErro(error.message); return; }
    setOk(modal === 'optout' ? 'Opt-out registrado. Este número não recebe mais disparos.' : 'Opt-out revertido. O consentimento voltou para "sem registro".');
    setModal(null); setMotivo('');
    carregar();
  };

  if (carregando) {
    return <div className="flex items-center gap-2 text-sm text-slate-400 py-8"><Loader2 className="w-4 h-4 animate-spin" /> Carregando consentimento…</div>;
  }
  if (!estado) {
    return <p className="text-sm text-rose-600 py-6">{erro}</p>;
  }

  const elegivel = podeReceberDisparo(estado);
  const selo = rotuloConsentimento(estado);

  return (
    <div className="space-y-5 max-w-2xl">
      {/* Situação */}
      <div className="flex flex-wrap items-center gap-3 p-4 rounded-xl border border-slate-200 bg-slate-50">
        <span className={`text-xs font-bold px-2.5 py-1 rounded-full border ${selo.cor}`}>{selo.texto}</span>
        <span className={`text-xs font-semibold ${elegivel ? 'text-emerald-700' : 'text-slate-500'}`}>
          {elegivel ? 'Elegível para disparo' : 'Não elegível para disparo'}
        </span>
        <span className="text-xs text-slate-400 ml-auto">
          Número para WhatsApp: <b className="text-slate-600">{estado.phone_e164 ?? 'inválido ou ausente'}</b>
        </span>
      </div>

      {estado.opt_out && (
        <div className="flex gap-2 p-3 rounded-xl border border-rose-200 bg-rose-50 text-rose-700 text-sm">
          <ShieldOff className="w-4 h-4 shrink-0 mt-0.5" />
          <div>
            Pediu para não receber mensagens em {fmt(estado.opt_out_data)}. Nenhum disparo é permitido para este número,
            em nenhum cadastro. Lembrete de consulta ou cobrança só com cuidado, nunca promoção.
          </div>
        </div>
      )}
      {!estado.phone_e164 && (
        <div className="flex gap-2 p-3 rounded-xl border border-amber-200 bg-amber-50 text-amber-700 text-sm">
          <AlertTriangle className="w-4 h-4 shrink-0 mt-0.5" />
          Telefone ausente ou fora do padrão brasileiro. Corrija em "Dados Principais" para o cadastro poder receber mensagens.
        </div>
      )}

      {/* Edição */}
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className={LB}>Consentimento</label>
          <select className={I} value={optIn} onChange={e => setOptIn(e.target.value as OptIn)} disabled={salvando}>
            {(['incerto', 'sim', 'nao'] as OptIn[]).map(v => <option key={v} value={v}>{OPT_IN_LABEL[v]}</option>)}
          </select>
        </div>
        <div>
          <label className={LB}>Origem</label>
          <select className={I} value={origem} onChange={e => setOrigem(e.target.value)} disabled={salvando}>
            <option value="">—</option>
            {/* mantém visível uma origem gravada por integração, mesmo que não seja editável */}
            {estado.opt_in_origem && !ORIGENS_EDITAVEIS.includes(estado.opt_in_origem as OrigemOptIn) && (
              <option value={estado.opt_in_origem}>{ORIGEM_LABEL[estado.opt_in_origem as OrigemOptIn] ?? estado.opt_in_origem}</option>
            )}
            {ORIGENS_EDITAVEIS.map(o => <option key={o} value={o}>{ORIGEM_LABEL[o]}</option>)}
          </select>
        </div>
        <div className="col-span-2">
          <label className={LB}>Evidência {optIn === 'sim' && <span className="text-rose-500">*</span>}</label>
          <textarea
            className={I + ' min-h-[72px]'}
            value={evidencia}
            onChange={e => setEvidencia(e.target.value)}
            disabled={salvando}
            placeholder="Ex.: ficha de cadastro em papel assinada em 10/10/2026, modelo com aceite de WhatsApp v1"
          />
          <p className="text-[11px] text-slate-400 mt-1">
            Registrado em {fmt(estado.opt_in_data)}. Descreva onde e como a pessoa aceitou (formulário, anúncio, texto exibido, data). Não cole telefone nem dados de saúde aqui.
          </p>
        </div>
      </div>

      {erro && <p className="text-sm text-rose-600 bg-rose-50 px-3 py-2 rounded-lg">{erro}</p>}
      {ok && <p className="text-sm text-emerald-700 bg-emerald-50 px-3 py-2 rounded-lg">{ok}</p>}

      <div className="flex flex-wrap gap-2">
        <button onClick={salvar} disabled={salvando}
          className="flex items-center gap-1.5 px-4 py-2 rounded-lg bg-indigo-600 text-white text-sm font-semibold hover:bg-indigo-700 disabled:opacity-60">
          {salvando ? <Loader2 className="w-4 h-4 animate-spin" /> : <ShieldCheck className="w-4 h-4" />} Salvar consentimento
        </button>
        {!estado.opt_out && (
          <button onClick={() => { setModal('optout'); setMotivo(''); setErro(null); }} disabled={salvando}
            className="flex items-center gap-1.5 px-4 py-2 rounded-lg border border-rose-200 text-rose-600 text-sm font-semibold hover:bg-rose-50">
            <ShieldOff className="w-4 h-4" /> Marcar opt-out
          </button>
        )}
        {estado.opt_out && userRole === 'ADMIN' && (
          <button onClick={() => { setModal('reverter'); setMotivo(''); setErro(null); }} disabled={salvando}
            className="px-4 py-2 rounded-lg border border-slate-200 text-slate-600 text-sm font-semibold hover:bg-slate-50">
            Reverter opt-out (ADMIN)
          </button>
        )}
      </div>

      {/* Histórico (sem telefone/nome: só ações) */}
      <div>
        <p className="flex items-center gap-1.5 text-[11px] font-bold uppercase text-slate-400 tracking-wider mb-2">
          <History className="w-3.5 h-3.5" /> Histórico de consentimento
        </p>
        {eventos.length === 0 ? (
          <p className="text-xs text-slate-400">Nenhuma alteração registrada.</p>
        ) : (
          <ul className="text-xs text-slate-600 divide-y divide-slate-100 border border-slate-100 rounded-lg">
            {eventos.map(ev => (
              <li key={ev.id} className="px-3 py-2 flex gap-3">
                <span className="text-slate-400 w-36 shrink-0">{fmt(ev.ocorrido_em)}</span>
                <span className="font-semibold w-40 shrink-0">{ACAO_LABEL[ev.acao] ?? ev.acao}</span>
                <span>
                  {ev.opt_out_depois ? 'opt-out' : (ev.opt_in_depois ? OPT_IN_LABEL[ev.opt_in_depois] : '—')}
                  {ev.origem ? ` · ${ORIGEM_LABEL[ev.origem as OrigemOptIn] ?? ev.origem}` : ''}
                </span>
              </li>
            ))}
          </ul>
        )}
      </div>

      {/* Modal opt-out / reversão */}
      {modal && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center p-4 bg-black/40">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-5 space-y-4">
            <h3 className="text-sm font-bold text-slate-800">
              {modal === 'optout' ? 'Registrar opt-out' : 'Reverter opt-out'}
            </h3>
            <p className="text-sm text-slate-600">
              {modal === 'optout'
                ? 'A pessoa não receberá mais nenhum disparo. Vale para TODOS os cadastros com este mesmo número. Só um ADMIN consegue desfazer.'
                : 'Só reverta se a pessoa pediu, por escrito, para voltar a receber mensagens. O consentimento volta para "sem registro" e precisará ser registrado de novo.'}
            </p>
            <div>
              <label className={LB}>Motivo {modal === 'reverter' && <span className="text-rose-500">*</span>}</label>
              <textarea className={I + ' min-h-[64px]'} value={motivo} onChange={e => setMotivo(e.target.value)}
                placeholder={modal === 'optout' ? 'Ex.: respondeu "parar" no WhatsApp' : 'Ex.: pediu por e-mail em 10/10/2026 para voltar'} />
            </div>
            {erro && <p className="text-sm text-rose-600">{erro}</p>}
            <div className="flex justify-end gap-2">
              <button onClick={() => { setModal(null); setErro(null); }} className="px-4 py-2 text-sm text-slate-500 border border-slate-200 rounded-lg">Cancelar</button>
              <button onClick={confirmarModal} disabled={salvando}
                className={`px-4 py-2 text-sm font-semibold text-white rounded-lg disabled:opacity-60 ${modal === 'optout' ? 'bg-rose-600 hover:bg-rose-700' : 'bg-indigo-600 hover:bg-indigo-700'}`}>
                {salvando ? 'Salvando…' : 'Confirmar'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ConsentimentoWhatsApp;
