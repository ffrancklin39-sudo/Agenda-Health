// consentimento.ts — regra ÚNICA de consentimento para WhatsApp (LGPD).
//
// Fonte da verdade: public.pode_receber_disparo() no banco
// (supabase/migrations/20261010120000_whatsapp_consentimento.sql).
// Este arquivo é o espelho para a interface (filtros, selos, botões).
// QUALQUER envio ativo real (n8n, Chatwoot, Edge Function) deve chamar a
// função do banco imediatamente antes de enviar — ela também confere a
// lista de supressão por telefone, que este helper não enxerga.

import { paraE164 } from '../phoneUtils';

export type OptIn = 'sim' | 'incerto' | 'nao';

export type OrigemOptIn =
  | 'click_to_whatsapp'
  | 'form_com_consentimento'
  | 'form_sem_consentimento'
  | 'lead_ad'
  | 'manual'
  | 'feegow'
  | 'whatsapp_legado';

export const ORIGEM_LABEL: Record<OrigemOptIn, string> = {
  click_to_whatsapp:      'Click-to-WhatsApp (lead mandou a 1ª mensagem)',
  form_com_consentimento: 'Formulário com aceite',
  form_sem_consentimento: 'Formulário sem campo de aceite',
  lead_ad:                'Anúncio de cadastro (Lead Ads)',
  manual:                 'Registro manual pela equipe',
  feegow:                 'Importado do Feegow',
  whatsapp_legado:        'WhatsApp antigo (WAHA)',
};

/** Origens que um usuário pode escolher ao editar um cadastro. */
export const ORIGENS_EDITAVEIS: OrigemOptIn[] = ['manual', 'form_com_consentimento', 'feegow', 'click_to_whatsapp', 'lead_ad'];
/** Origens aceitas na marcação em massa (mesma lista do banco). */
export const ORIGENS_MASSA: OrigemOptIn[] = ['form_com_consentimento', 'manual', 'feegow'];

export const OPT_IN_LABEL: Record<OptIn, string> = {
  sim: 'Aceitou', incerto: 'Sem registro', nao: 'Recusou',
};

export interface ConsentimentoLead {
  phone?: string | null;
  phone_e164?: string | null;
  opt_in?: string | null;
  opt_out?: boolean | null;
}

const optInDe = (lead: ConsentimentoLead | null | undefined): OptIn => {
  const v = lead?.opt_in;
  return v === 'sim' || v === 'nao' ? v : 'incerto';   // ausente/desconhecido = incerto
};

/**
 * Pode receber disparo ATIVO (campanha, promoção, mensagem iniciada pela clínica)?
 * opt_in = 'sim' E opt_out = false E telefone válido. Na dúvida, NÃO.
 */
export function podeReceberDisparo(lead: ConsentimentoLead | null | undefined): boolean {
  if (!lead) return false;
  if (lead.opt_out !== false) return false;               // undefined/null conta como bloqueado
  if (optInDe(lead) !== 'sim') return false;
  return !!(lead.phone_e164 || paraE164(lead.phone));
}

export type TipoContato =
  | 'prospeccao'    // conversa iniciada pela recepção para vender/reativar (CRM)
  | 'transacional'; // lembrete de consulta, cobrança, resposta dentro de 24h

export interface AvaliacaoContato {
  nivel: 'livre' | 'aviso' | 'bloqueado';
  motivo?: string;
}

/**
 * Contato manual 1:1 (link wa.me). Regras aprovadas:
 *  - prospecção: opt-out BLOQUEIA, 'nao' BLOQUEIA, 'incerto' libera com aviso.
 *  - transacional: opt-out e 'nao' mostram aviso (não bloqueiam).
 */
export function avaliarContatoManual(lead: ConsentimentoLead | null | undefined, tipo: TipoContato): AvaliacaoContato {
  const optIn = optInDe(lead);
  const optOut = lead?.opt_out === true;

  if (tipo === 'prospeccao') {
    if (optOut) return { nivel: 'bloqueado', motivo: 'Pediu para não receber mensagens (opt-out).' };
    if (optIn === 'nao') return { nivel: 'bloqueado', motivo: 'Recusou receber mensagens.' };
    if (optIn === 'incerto') return { nivel: 'aviso', motivo: 'Sem consentimento registrado. Converse só se fizer sentido para o atendimento.' };
    return { nivel: 'livre' };
  }

  if (optOut) return { nivel: 'aviso', motivo: 'Pediu opt-out: use só para assunto da consulta ou cobrança, nunca promoção.' };
  if (optIn === 'nao') return { nivel: 'aviso', motivo: 'Recusou mensagens: use só para assunto da consulta ou cobrança.' };
  return { nivel: 'livre' };
}

/** Rótulo curto para selos na interface. */
export function rotuloConsentimento(lead: ConsentimentoLead | null | undefined): { texto: string; cor: string } {
  if (lead?.opt_out === true) return { texto: 'Opt-out', cor: 'bg-rose-50 text-rose-700 border-rose-200' };
  const v = optInDe(lead);
  if (v === 'sim') return { texto: 'Opt-in', cor: 'bg-emerald-50 text-emerald-700 border-emerald-200' };
  if (v === 'nao') return { texto: 'Recusou', cor: 'bg-amber-50 text-amber-700 border-amber-200' };
  return { texto: 'Sem opt-in', cor: 'bg-slate-50 text-slate-500 border-slate-200' };
}

/**
 * Para usar no clique de links wa.me: mostra o aviso/bloqueio e devolve
 * true se o contato pode seguir. Não envia nada — só decide se o link abre.
 */
export function confirmarContato(lead: ConsentimentoLead | null | undefined, tipo: TipoContato): boolean {
  const aval = avaliarContatoManual(lead, tipo);
  if (aval.nivel === 'bloqueado') { window.alert(`Contato bloqueado: ${aval.motivo}`); return false; }
  if (aval.nivel === 'aviso') return window.confirm(`${aval.motivo}\n\nAbrir o WhatsApp mesmo assim?`);
  return true;
}
