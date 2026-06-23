# Node PODE_SOFIA_RESPONDER — código

**Status:** Proposta para revisão (ainda não implementada no n8n)
**Data:** 2026-06-17
**Referência:** docs/sofia-arquitetura-definitiva.md, seções 2, 4 e 5

Node único de **Code**, depois de `RESOLVE_IDENTIDADE` + busca do paciente por `from_real`. Substitui `If`, `If1`, `IF_FROM_ME`, `IF_JA_WAITING`, `IF_WAITING_STOP`. Saída: um objeto com a decisão e o motivo (pra log/debug), que alimenta um node `IF` simples (`pode_responder === true`) logo depois.

```javascript
// PODE_SOFIA_RESPONDER
// Única fonte de verdade sobre se a Sofia pode falar nesta conversa.
// Fail-safe: em qualquer caso ambíguo, retorna false (não responde).

const { from_real, fromMe } = $('RESOLVE_IDENTIDADE').item.json;
const patient = $('GET_PATIENT_FINAL').item.json; // null se não existir registro

// --- Caso 1: esta é uma mensagem ENVIADA pela conta conectada (fromMe: true) ---
// Como cada chip (Sofia/Nayla/recepção) é uma sessão própria, qualquer fromMe:true
// na sessão da Sofia, em teoria, só deveria acontecer quando a própria Sofia
// responde. Mas a sessão também pode ser usada manualmente em emergência.
// Tratamento conservador: SE o paciente já estava em SOFIA_ATIVA/NOVO_LEAD/LEAD_FRIO
// e chega um fromMe:true que NÃO foi originado por este fluxo (sem tag interna de
// "enviado pela Sofia"), assumimos handoff humano por segurança.
//
// ATENÇÃO — ponto a validar no teste real (ver tarefa de teste com leads de baixo
// risco): confirmar como o WAHA marca mensagens que a própria Sofia envia via API,
// pra não disparar HUMANO_ASSUMIU toda vez que a Sofia responde a si mesma.
if (fromMe === true) {
  const sentByAutomation = $json.sent_by_sofia_flow === true; // setado pelo node que envia a resposta da Sofia
  if (!sentByAutomation) {
    return {
      json: {
        pode_responder: false,
        motivo: 'fromMe=true não originado pelo fluxo — assume handoff humano',
        novo_conversation_state: 'HUMANO_ASSUMIU',
      },
    };
  }
  // Mensagem da própria Sofia sendo ecoada pelo webhook: não é uma pergunta a
  // responder, só ignora.
  return { json: { pode_responder: false, motivo: 'eco da própria Sofia', novo_conversation_state: null } };
}

// --- Caso 2: paciente não existe no banco — lead 100% novo ---
if (!patient) {
  return {
    json: {
      pode_responder: true,
      motivo: 'lead novo, sem registro prévio',
      novo_conversation_state: 'NOVO_LEAD',
    },
  };
}

const state = patient.conversation_state;

// --- Caso 3: humano já assumiu esta conversa — pausa indefinida ---
if (state === 'HUMANO_ASSUMIU') {
  return { json: { pode_responder: false, motivo: 'HUMANO_ASSUMIU — pausa indefinida', novo_conversation_state: null } };
}

// --- Caso 4: paciente convertido / com histórico ativo — Sofia nunca entra ---
if (state === 'CONVERTIDO') {
  return { json: { pode_responder: false, motivo: 'paciente convertido — fora do escopo da Sofia', novo_conversation_state: null } };
}

// --- Caso 5: tem consulta futura agendada — vai para fila humana, não é escopo da Sofia ---
if (patient.has_future_appointment === true) {
  return { json: { pode_responder: false, motivo: 'paciente com consulta futura agendada — fora do escopo', novo_conversation_state: 'HUMANO_ASSUMIU' } };
}

// --- Caso 6: lead frio (Projeto Lázaro) respondendo a uma reativação ---
if (state === 'LEAD_FRIO') {
  return { json: { pode_responder: true, motivo: 'lead frio reativado pelo Lázaro', novo_conversation_state: 'SOFIA_ATIVA' } };
}

// --- Caso 7: estados normais de atuação da Sofia ---
if (state === 'NOVO_LEAD' || state === 'SOFIA_ATIVA') {
  return { json: { pode_responder: true, motivo: 'dentro do escopo normal', novo_conversation_state: 'SOFIA_ATIVA' } };
}

// --- Fail-safe: qualquer estado não previsto/nulo cai aqui — NÃO responde ---
return { json: { pode_responder: false, motivo: `estado não reconhecido (${state}) — fail-safe`, novo_conversation_state: null } };
```

## Notas

- `novo_conversation_state` (quando não-nulo) deve ser gravado em `patients.conversation_state` por um node `Update a row` logo depois deste, **antes** de qualquer resposta ser enviada — assim, mesmo que a chamada à IA falhe depois, o estado já reflete a realidade.
- O ponto marcado como "ATENÇÃO" (diferenciar mensagem da própria Sofia de um humano usando a sessão manualmente) é a maior incerteza deste design e **precisa ser confirmado contra o payload real do WAHA** durante o teste com leads de baixo risco (próxima tarefa) — não dá pra validar isso sem rodar contra o webhook de verdade.
- `has_future_appointment` assume um campo/lookup que hoje pode não existir pronto — pode ser uma subquery contra `appointments` (`exists (select 1 from appointments where patient_id = X and starts_at > now() and status != 'cancelled')`) feita no node `GET_PATIENT_FINAL` ou em um node separado antes deste.
