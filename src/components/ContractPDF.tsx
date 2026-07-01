/**
 * ContractPDF.tsx
 * Gera o PDF do contrato de prestação de serviços da Clínica Candia.
 * Layout fiel aos contratos originais. Cláusulas são fixas; só os dados
 * do paciente, itens e condições de pagamento são dinâmicos.
 *
 * Uso:
 *   import { pdf } from '@react-pdf/renderer';
 *   import ContractDocument from './ContractPDF';
 *   const blob = await pdf(<ContractDocument contract={contract} items={items} />).toBlob();
 */

import React from 'react';
import {
  Document, Page, Text, View, StyleSheet, Font, Image,
} from '@react-pdf/renderer';
import { Contract, ContractItem } from '../types';

const LOGO_URL =
  'https://iudghjdmfcxjcpspeify.supabase.co/storage/v1/object/public/Candia/Candia-LOGO-h%20mono%201.png';

// ─── Estilos ────────────────────────────────────────────────────────────────

const S = StyleSheet.create({
  page: {
    fontFamily: 'Helvetica',
    fontSize: 9,
    color: '#1a1a1a',
    paddingTop: 36,
    paddingBottom: 48,
    paddingHorizontal: 42,
    lineHeight: 1.45,
  },

  // Logo
  logo: {
    width: 140,
    marginBottom: 10,
    alignSelf: 'center',
  },
  logoWrap: {
    alignItems: 'center',
    marginBottom: 4,
  },

  // Título
  title: {
    fontSize: 14,
    fontFamily: 'Helvetica-Bold',
    textAlign: 'center',
    marginBottom: 16,
    textTransform: 'uppercase',
    letterSpacing: 1,
  },

  // Cabeçalho — bloco de dados do paciente
  headerBox: {
    border: '1px solid #333',
    marginBottom: 12,
  },
  headerTitle: {
    backgroundColor: '#1a1a1a',
    color: '#fff',
    fontFamily: 'Helvetica-Bold',
    fontSize: 8,
    padding: '3 6',
    textTransform: 'uppercase',
    letterSpacing: 0.5,
  },
  headerRow: {
    flexDirection: 'row',
    borderTop: '0.5px solid #999',
    paddingHorizontal: 6,
    paddingVertical: 3,
    flexWrap: 'wrap',
  },
  headerField: {
    flexDirection: 'row',
    marginRight: 16,
    marginBottom: 2,
    flex: 1,
    minWidth: 120,
  },
  fieldLabel: {
    fontFamily: 'Helvetica-Bold',
    fontSize: 8,
    color: '#555',
    marginRight: 3,
  },
  fieldValue: {
    fontSize: 8,
    borderBottom: '0.5px solid #aaa',
    flex: 1,
    minWidth: 60,
  },

  // Parágrafo de abertura
  openingPara: {
    marginBottom: 10,
    textAlign: 'justify',
    fontSize: 8.5,
  },

  // Cláusulas
  clauseTitle: {
    fontFamily: 'Helvetica-Bold',
    fontSize: 9,
    textTransform: 'uppercase',
    marginTop: 10,
    marginBottom: 3,
    borderBottom: '0.5px solid #333',
    paddingBottom: 2,
  },
  clauseSubtitle: {
    fontFamily: 'Helvetica-Bold',
    fontSize: 8.5,
    marginTop: 5,
    marginBottom: 2,
  },
  clauseText: {
    fontSize: 8.5,
    textAlign: 'justify',
    marginBottom: 4,
  },
  bold: {
    fontFamily: 'Helvetica-Bold',
  },

  // Tabela de tratamentos
  tableHeader: {
    flexDirection: 'row',
    backgroundColor: '#1a1a1a',
    color: '#fff',
    fontFamily: 'Helvetica-Bold',
    fontSize: 8,
    paddingVertical: 3,
    paddingHorizontal: 6,
  },
  tableRow: {
    flexDirection: 'row',
    borderBottom: '0.5px solid #ddd',
    paddingVertical: 3,
    paddingHorizontal: 6,
  },
  tableRowAlt: {
    backgroundColor: '#f5f5f5',
  },
  colDesc: { flex: 4 },
  colSess: { flex: 1, textAlign: 'center' },
  colVal:  { flex: 1.5, textAlign: 'right' },

  // Pagamento
  paymentBox: {
    border: '1px solid #333',
    marginTop: 8,
    marginBottom: 10,
  },
  paymentTitle: {
    backgroundColor: '#1a1a1a',
    color: '#fff',
    fontFamily: 'Helvetica-Bold',
    fontSize: 8,
    padding: '3 6',
    textTransform: 'uppercase',
  },
  paymentRow: {
    flexDirection: 'row',
    paddingHorizontal: 6,
    paddingVertical: 4,
    gap: 12,
  },
  paymentItem: {
    flexDirection: 'row',
    flex: 1,
  },

  // Assinaturas
  signatureSection: {
    marginTop: 24,
  },
  signatureRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 12,
  },
  signatureLine: {
    flex: 1,
    marginHorizontal: 10,
  },
  signatureBar: {
    borderTop: '1px solid #333',
    marginTop: 36,
    marginBottom: 3,
  },
  signatureLabel: {
    fontSize: 7.5,
    textAlign: 'center',
    color: '#555',
  },

  // Consentimento
  consentBox: {
    border: '1px solid #333',
    padding: 8,
    marginTop: 12,
  },
  consentTitle: {
    fontFamily: 'Helvetica-Bold',
    fontSize: 9,
    textAlign: 'center',
    marginBottom: 6,
    textTransform: 'uppercase',
  },

  // Footer
  footer: {
    position: 'absolute',
    bottom: 20,
    left: 42,
    right: 42,
    flexDirection: 'row',
    justifyContent: 'space-between',
    fontSize: 7,
    color: '#aaa',
    borderTop: '0.5px solid #ddd',
    paddingTop: 4,
  },
});

// ─── Helpers ────────────────────────────────────────────────────────────────

const fmt = (v?: number | null) =>
  v != null ? `R$ ${v.toFixed(2).replace('.', ',').replace(/\B(?=(\d{3})+(?!\d))/g, '.')}` : '—';

const fmtDate = (d?: string | null) => {
  if (!d) return '___/___/______';
  const dt = new Date(d + 'T12:00:00');
  return dt.toLocaleDateString('pt-BR');
};

const age = (birth?: string | null) => {
  if (!birth) return '';
  const b = new Date(birth);
  const today = new Date();
  let a = today.getFullYear() - b.getFullYear();
  if (today < new Date(today.getFullYear(), b.getMonth(), b.getDate())) a--;
  return `${a} anos`;
};

// ─── Componente ─────────────────────────────────────────────────────────────

interface Props {
  contract: Contract;
  items: ContractItem[];
}

const ContractDocument: React.FC<Props> = ({ contract, items }) => {
  const today = new Date().toLocaleDateString('pt-BR', {
    day: '2-digit', month: 'long', year: 'numeric',
  });

  const totalSessions = items.reduce((s, i) => s + (i.sessions || 0), 0);

  return (
    <Document
      title={`Contrato - ${contract.patient_name || 'Paciente'}`}
      author="Candia Saúde e Bem-Estar"
    >
      {/* ── PÁGINA 1: Contrato ──────────────────────────────────────────── */}
      <Page size="A4" style={S.page}>

        {/* Logo */}
        <View style={S.logoWrap}>
          <Image style={S.logo} src={LOGO_URL} />
        </View>

        {/* Título */}
        <Text style={S.title}>Contrato de Prestação de Serviços</Text>

        {/* Dados do paciente */}
        <View style={S.headerBox}>
          <Text style={S.headerTitle}>Dados Pessoais</Text>

          <View style={S.headerRow}>
            <View style={[S.headerField, { flex: 3 }]}>
              <Text style={S.fieldLabel}>Nome do Paciente:</Text>
              <Text style={S.fieldValue}>{contract.patient_name || ''}</Text>
            </View>
            <View style={[S.headerField, { flex: 0.5 }]}>
              <Text style={S.fieldLabel}>Idade:</Text>
              <Text style={S.fieldValue}>{age(contract.patient_birth_date)}</Text>
            </View>
          </View>

          <View style={S.headerRow}>
            <View style={[S.headerField, { flex: 2 }]}>
              <Text style={S.fieldLabel}>Data Nasc.:</Text>
              <Text style={S.fieldValue}>{fmtDate(contract.patient_birth_date)}</Text>
            </View>
            <View style={[S.headerField, { flex: 2 }]}>
              <Text style={S.fieldLabel}>CPF:</Text>
              <Text style={S.fieldValue}>{contract.patient_cpf || ''}</Text>
            </View>
            <View style={[S.headerField, { flex: 2 }]}>
              <Text style={S.fieldLabel}>Telefone:</Text>
              <Text style={S.fieldValue}>{contract.patient_phone || ''}</Text>
            </View>
          </View>

          <View style={S.headerRow}>
            <View style={[S.headerField, { flex: 3 }]}>
              <Text style={S.fieldLabel}>Endereço:</Text>
              <Text style={S.fieldValue}>
                {[contract.patient_address, contract.address_number, contract.neighborhood]
                  .filter(Boolean).join(', ')}
              </Text>
            </View>
            <View style={[S.headerField, { flex: 1 }]}>
              <Text style={S.fieldLabel}>Cidade:</Text>
              <Text style={S.fieldValue}>{contract.patient_city || ''}</Text>
            </View>
          </View>

          <View style={S.headerRow}>
            <View style={[S.headerField, { flex: 3 }]}>
              <Text style={S.fieldLabel}>E-mail:</Text>
              <Text style={S.fieldValue}>{contract.patient_email || ''}</Text>
            </View>
            <View style={[S.headerField, { flex: 1.5 }]}>
              <Text style={S.fieldLabel}>CEP:</Text>
              <Text style={S.fieldValue}>{contract.patient_zip || ''}</Text>
            </View>
          </View>
        </View>

        {/* Abertura */}
        <Text style={S.openingPara}>
          Pelo presente contrato particular, o usuário a seguir signatário e qualificado acima,
          adiante denominado <Text style={S.bold}>PACIENTE ou RESPONSÁVEL</Text>, vem contratar a
          prestação de serviços especializados da{' '}
          <Text style={S.bold}>CANDIA ATIVIDADES MÉDICAS E BEM ESTAR LTDA</Text>, inscrita no
          CNPJ nº 17.200.067/0001-72, com sede no SGAS 616, Lote 116/117, Centro Clínico Línea
          Vitta, Bloco B, Salas 11, 13, 15 e 16, Asa Sul, Brasília – DF, CEP: 70.200-760, neste
          ato denominada <Text style={S.bold}>CONTRATADA</Text>, estando ciente de que as
          particularidades de tratamento reger-se-ão mediante as seguintes condições:
        </Text>

        {/* Cl. 1 – Objeto */}
        <Text style={S.clauseTitle}>Cláusula Primeira – Do Objeto</Text>
        <Text style={S.clauseText}>
          Constitui-se objeto deste instrumento a prestação de serviços conforme enumerados ao
          final deste, sob o subtítulo "Tratamentos Contratados".
        </Text>
        {contract.treatment_description ? (
          <Text style={S.clauseText}>{contract.treatment_description}</Text>
        ) : null}
        <Text style={S.clauseText}>
          <Text style={S.bold}>Parágrafo Primeiro: </Text>
          O PACIENTE (e/ou seu RESPONSÁVEL) neste momento tem acesso a todas as informações sobre
          os serviços prestados e sobre as rotinas de atendimento da CONTRATADA, bem como ao preço
          desses serviços.
        </Text>
        <Text style={S.clauseText}>
          <Text style={S.bold}>Parágrafo Segundo: </Text>
          Os tratamentos contratados podem ser realizados por auxiliares com conhecimento técnico
          e sob supervisão da CONTRATADA.
        </Text>

        {/* Cl. 2 – Prazo */}
        <Text style={S.clauseTitle}>Cláusula Segunda – Do Prazo</Text>
        <Text style={S.clauseText}>
          O atendimento ora contratado tem seu início em{' '}
          <Text style={S.bold}>{fmtDate(contract.start_date)}</Text>
          {contract.end_date ? (
            <Text>, encerrando-se em <Text style={S.bold}>{fmtDate(contract.end_date)}</Text></Text>
          ) : null}
          , de pleno direito, após a conclusão do serviço proposto.
        </Text>

        {/* Cl. 3 – Preço */}
        <Text style={S.clauseTitle}>Cláusula Terceira – Do Preço</Text>
        <Text style={S.clauseText}>
          O valor cobrado pela CONTRATADA, discriminado no verso, inclui o pagamento de todos os
          honorários referentes ao procedimento proposto.
        </Text>

        {/* Cl. 4 – Pagamento */}
        <Text style={S.clauseTitle}>Cláusula Quarta – Do Pagamento</Text>
        <Text style={S.clauseText}>
          O valor acertado entre as partes, discriminado no verso, quando à vista, deverá ser
          repassado à CONTRATADA antes da realização do serviço contratado; quando a prazo, a
          entrada deverá ser quitada antes da realização do serviço e as demais parcelas garantidas
          conforme condições acordadas.
        </Text>

        {/* Cl. 5 – Rescisão */}
        <Text style={S.clauseTitle}>Cláusula Quinta – Da Rescisão Contratual</Text>
        <Text style={S.clauseText}>
          <Text style={S.bold}>I –</Text> Em caso de desistência do tratamento antes do início da
          primeira sessão, por iniciativa da CONTRATANTE, a CONTRATADA poderá reter{' '}
          <Text style={S.bold}>30% (trinta por cento)</Text> dos valores efetivamente pagos,
          destinados à compensação dos custos administrativos, planejamento terapêutico
          individualizado, reserva exclusiva de agenda, mobilização da equipe e demais despesas
          operacionais decorrentes da contratação, sendo restituído à CONTRATANTE o saldo
          remanescente.
        </Text>
        <Text style={S.clauseText}>
          <Text style={S.bold}>II –</Text> Em caso de desistência após o início do tratamento,
          por iniciativa da CONTRATANTE, serão descontados os valores correspondentes aos serviços
          efetivamente prestados até a data da rescisão. Sobre o saldo remanescente, se houver, a
          CONTRATADA poderá reter <Text style={S.bold}>40% (quarenta por cento)</Text>, destinados
          à compensação dos custos administrativos, planejamento terapêutico, reserva de agenda,
          mobilização da equipe e demais despesas operacionais, sendo restituído à CONTRATANTE o
          valor restante.
        </Text>

        {/* Cl. 6 – Faltas */}
        <Text style={S.clauseTitle}>Cláusula Sexta – Das Faltas</Text>
        <Text style={S.clauseText}>
          <Text style={S.bold}>Parágrafo Primeiro: </Text>
          As sessões poderão ser desmarcadas sempre que o paciente tiver necessidade, com direito
          a reposição, desde que o mesmo avise com no mínimo{' '}
          <Text style={S.bold}>24 (vinte e quatro) horas</Text> de antecedência; caso contrário,
          será considerada sessão realizada e o valor proporcional a ela será cobrado.
        </Text>
        <Text style={S.clauseText}>
          <Text style={S.bold}>Parágrafo Segundo: </Text>
          Uma sessão remarcada pelo paciente não poderá ser desmarcada novamente. Caso o paciente
          falte à sessão remarcada, será considerada sessão realizada e o valor proporcional a ela
          será cobrado.
        </Text>
        <Text style={S.clauseText}>
          <Text style={S.bold}>Parágrafo Terceiro: </Text>
          Para que o tratamento não seja prejudicado, é importante que o paciente realize as
          reposições dentro da mesma semana que houve a desmarcação, desde que a clínica apresente
          data e horário disponíveis. O tratamento não será estendido além da data final contratada.
        </Text>

        {/* Cl. 7 – Responsabilidade */}
        <Text style={S.clauseTitle}>Cláusula Sétima – Da Responsabilidade do Paciente</Text>
        <Text style={S.clauseText}>
          O PACIENTE E/OU RESPONSÁVEL, abaixo signatário, declara sua inteira responsabilidade
          quanto à veracidade das informações prestadas e seu pleno conhecimento quanto ao teor do
          descrito nas cláusulas do presente contrato, previamente lido e esclarecido em todas as
          suas páginas.
        </Text>
        <Text style={S.clauseText}>
          <Text style={S.bold}>Parágrafo Único: </Text>
          A natureza do contrato estabelecido entre as partes é sui generis, de meio, onde a
          CONTRATADA conduzir-se-á com toda a diligência na aplicação de conhecimentos técnicos
          para alcançar, tanto quanto possível, dentro dos limites de que dispõe, o objetivo de
          melhorar a saúde e preservar a vida dos pacientes enquanto estiverem sob seus cuidados
          profissionais.
        </Text>

        {/* Cl. 8 – Foro */}
        <Text style={S.clauseTitle}>Cláusula Oitava – Do Foro</Text>
        <Text style={S.clauseText}>
          Fica eleito o Foro de <Text style={S.bold}>Brasília – DF</Text> para dirimir quaisquer
          dúvidas emergentes deste contrato.
        </Text>

        {/* Footer */}
        <View style={S.footer} fixed>
          <Text>Candia Saúde e Bem-Estar — CNPJ 17.200.067/0001-72</Text>
          <Text render={({ pageNumber, totalPages }) => `${pageNumber} / ${totalPages}`} />
        </View>
      </Page>

      {/* ── PÁGINA 2: Tratamentos + Consentimento ───────────────────────── */}
      <Page size="A4" style={S.page}>

        {/* Logo */}
        <View style={S.logoWrap}>
          <Image style={S.logo} src={LOGO_URL} />
        </View>

        {/* Tratamentos contratados */}
        <Text style={[S.clauseTitle, { marginTop: 0 }]}>Tratamentos Contratados</Text>
        <Text style={S.clauseText}>
          Data de início: <Text style={S.bold}>{fmtDate(contract.start_date)}</Text>
          {'   '}Data máxima para finalizar: <Text style={S.bold}>{fmtDate(contract.end_date)}</Text>
        </Text>

        {/* Tabela de itens */}
        <View style={S.tableHeader}>
          <Text style={S.colDesc}>Descrição do Serviço / Pacote</Text>
          <Text style={S.colSess}>Sessões</Text>
          <Text style={S.colVal}>Valor</Text>
        </View>
        {items.map((item, i) => (
          <View key={i} style={[S.tableRow, i % 2 === 1 ? S.tableRowAlt : {}]}>
            <View style={S.colDesc}>
              <Text>{item.description}</Text>
              {item.notes ? <Text style={{ color: '#666', fontSize: 7.5 }}>{item.notes}</Text> : null}
            </View>
            <Text style={S.colSess}>{item.sessions || '—'}</Text>
            <Text style={S.colVal}>{fmt(item.subtotal ?? item.unit_price)}</Text>
          </View>
        ))}
        {/* Total */}
        <View style={[S.tableRow, { backgroundColor: '#1a1a1a' }]}>
          <Text style={[S.colDesc, { color: '#fff', fontFamily: 'Helvetica-Bold' }]}>Total</Text>
          <Text style={[S.colSess, { color: '#fff' }]}>{totalSessions > 0 ? totalSessions : '—'}</Text>
          <Text style={[S.colVal, { color: '#fff', fontFamily: 'Helvetica-Bold' }]}>
            {fmt(contract.total_amount)}
          </Text>
        </View>

        {/* Condições de pagamento */}
        <View style={S.paymentBox}>
          <Text style={S.paymentTitle}>Condições de Pagamento</Text>
          <View style={S.paymentRow}>
            <View style={S.paymentItem}>
              <Text style={S.fieldLabel}>Valor do Serviço: </Text>
              <Text>{fmt(contract.total_amount)}</Text>
            </View>
          </View>
          {contract.payment_notes && (
            <View style={[S.paymentRow, { paddingTop: 0 }]}>
              <Text style={S.fieldLabel}>Forma de Pagamento: </Text>
              <Text>{contract.payment_notes}</Text>
            </View>
          )}
          {contract.down_payment && (
            <View style={[S.paymentRow, { paddingTop: 0 }]}>
              <Text style={S.fieldLabel}>Entrada: </Text>
              <Text>{fmt(contract.down_payment)}</Text>
              {contract.installments && contract.installments > 1 && (
                <Text style={{ marginLeft: 12 }}>
                  + {contract.installments}x de {fmt(contract.installment_value)}
                </Text>
              )}
            </View>
          )}
        </View>

        {/* Local e data */}
        <Text style={[S.clauseText, { marginTop: 6 }]}>
          Brasília – DF, {today}.
        </Text>

        {/* Assinaturas */}
        <View style={S.signatureRow}>
          <View style={S.signatureLine}>
            <View style={S.signatureBar} />
            <Text style={S.signatureLabel}>Paciente / Responsável (CONTRATANTE)</Text>
          </View>
          <View style={S.signatureLine}>
            <View style={S.signatureBar} />
            <Text style={S.signatureLabel}>Candia – Saúde e Bem-Estar (CONTRATADA)</Text>
          </View>
        </View>

        <View style={[S.signatureRow, { marginTop: 16 }]}>
          <View style={S.signatureLine}>
            <View style={S.signatureBar} />
            <Text style={S.signatureLabel}>Testemunha</Text>
          </View>
          <View style={S.signatureLine}>
            <View style={S.signatureBar} />
            <Text style={S.signatureLabel}>Testemunha</Text>
          </View>
        </View>

        {/* Termo de Consentimento Informado */}
        <View style={S.consentBox}>
          <Text style={S.consentTitle}>Termo de Consentimento Informado</Text>

          <Text style={S.clauseText}>
            Eu, <Text style={{ borderBottom: '0.5px solid #333', flex: 1 }}>
              {'_'.repeat(55)}
            </Text>, autorizo a profissional{' '}
            <Text style={S.bold}>{contract.professional_name || 'Ana Carolina Candia'}</Text> a
            realizar o(s) procedimento(s) descritos no verso em "Tratamentos Contratados", bem
            como os demais procedimentos pré e pós-tratamentos recomendados;
          </Text>

          <Text style={S.clauseText}>
            Declaro estar ciente de que <Text style={S.bold}>não há garantias de resultado</Text>,
            pois este depende de fatores tais como minhas características fisiológicas, minhas
            condições clínicas, da ausência de intercorrência durante o procedimento e da
            observação dos cuidados pós-tratamento;
          </Text>

          <Text style={S.clauseText}>
            Declaro que fui informado suficientemente para entender o propósito deste tratamento,
            que seus benefícios são limitados e dependentes de fatores como os já mencionados, e
            que sempre haverá o risco de complicações, em qualquer procedimento estético,
            independentemente de sua extensão e gravidade;
          </Text>

          <Text style={S.clauseText}>
            Comprometo-me a seguir todas as prescrições e cuidados indicados, oralmente ou por
            escrito, pois, do contrário, poderei pôr minha saúde ou bem-estar em perigo, ou
            ainda, ocasionar sequelas temporárias ou permanentes;
          </Text>

          <Text style={S.clauseText}>
            Tenho conhecimento que qualquer omissão da minha parte poderá me trazer prejuízos,
            comprometer o procedimento a que me submeto, causar sequelas ou acarretar danos a
            minha saúde;
          </Text>

          <Text style={S.clauseText}>
            Concordo em que sejam tiradas fotografias da região em tratamento, dando total direito
            ao profissional para publicá-las em livros, revistas, artigos e em vários outros
            veículos de divulgação da técnica, desde que tal procedimento não venha causar qualquer
            tipo de dolo à minha pessoa.
          </Text>

          <Text style={S.clauseText}>
            O grau do resultado final do tratamento não pode ser previsto ou garantido pelo
            profissional. Os representantes legais do paciente declaram assumir plena
            responsabilidade pelas informações e consentimentos prestados neste termo, bem como
            estar de acordo com o conteúdo destas páginas.
          </Text>

          {/* Assinatura do consentimento */}
          <View style={[S.signatureRow, { marginTop: 14 }]}>
            <View style={S.signatureLine}>
              <View style={S.signatureBar} />
              <Text style={S.signatureLabel}>Paciente ou Responsável (CONTRATANTE)</Text>
            </View>
            <View style={[S.signatureLine, { flex: 0.4 }]}>
              <View style={S.signatureBar} />
              <Text style={S.signatureLabel}>Data</Text>
            </View>
          </View>
        </View>

        {/* Footer */}
        <View style={S.footer} fixed>
          <Text>Candia Saúde e Bem-Estar — CNPJ 17.200.067/0001-72</Text>
          <Text render={({ pageNumber, totalPages }) => `${pageNumber} / ${totalPages}`} />
        </View>
      </Page>
    </Document>
  );
};

export default ContractDocument;
