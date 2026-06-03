# Manual do Módulo Financeiro — SintesIA
**Para: Gestoras e Recepcionistas da Clínica**
**Versão:** Junho 2026

---

## Como usar o Módulo Financeiro do SintesIA

---

### PASSO 1 — Configure uma vez só (5 minutos)

**Onde:** Menu lateral → **Configurações** → aba **Financeiro**

Esta é a única configuração que precisa ser feita antes de tudo. Você define os dados da sua clínica que o sistema vai usar em todos os cálculos automaticamente.

**O que preencher:**

**Dados da Clínica**
- Nome da clínica (aparece nos relatórios)

**Configurações Fiscais**
- Regime tributário (Simples Nacional, MEI, Lucro Presumido)
- Alíquota padrão — ex: 6% para ISS no Simples
- Comissão padrão dos profissionais — ex: 40%

**Taxas da Maquininha**
- PIX: geralmente 0%
- Débito: consulte seu contrato (ex: 1.5%)
- Crédito 1x, 2–6x, 7x+: consulte seu contrato

Clique em **Salvar configurações**. Pronto — esses valores serão usados em todos os cálculos daqui pra frente.

---

### PASSO 2 — Registre as despesas (Contas a Pagar)

**Onde:** Menu lateral → **Financeiro** → aba **Contas a Pagar**

Aqui você cadastra tudo que a clínica paga: aluguel, salários, insumos, materiais, impostos, manutenção.

**Como cadastrar uma conta:**

1. Clique em **Nova conta**
2. Preencha:
   - **Descrição:** ex: "Aluguel sala dezembro"
   - **Categoria:** Aluguel, Salário, Insumos, etc.
   - **Valor:** ex: R$ 3.500,00
   - **Vencimento:** a data que precisa pagar
   - **Recorrência:** se for todo mês, selecione *Mensal* — o sistema vai gerar automaticamente os próximos meses
   - **Fornecedor:** ex: "Imobiliária Central"
3. Clique em **Salvar**

**Como marcar como pago:**

Quando você efetuar o pagamento, clique no botão ✓ verde na linha da conta. O sistema registra a data e o valor pago automaticamente.

**Exemplos do que cadastrar para começar:**
- Aluguel (mensal)
- Salário fixo de cada funcionário (mensal)
- Materiais e insumos comprados
- Conta de luz/água/internet (mensal)
- Mensalidade de sistemas e softwares

---

### PASSO 3 — Registre os pagamentos dos pacientes

**Onde:** Perfil do paciente → aba **Recibos / Financeiro** → botão **Registrar pagamento**

Ou: **CRM** → arrastar o card do paciente para a coluna **Confirmado** → modal abre automaticamente

Este é o passo mais importante. Quando um paciente pagar, você registra aqui e o sistema calcula sozinho: impostos, taxa da maquininha, comissão do profissional e lucro real da clínica — sem nenhuma conta manual.

**Como registrar:**

1. Abra o perfil do paciente (ou arraste no CRM)
2. Clique em **Registrar pagamento**
3. Preencha apenas 3 campos:
   - **Valor recebido** — o valor que o paciente pagou
   - **Forma de pagamento** — PIX, débito, crédito 1x, etc.
   - **Data/hora** — já vem preenchida com agora
4. Veja o preview automático que aparece mostrando:
   - Quanto foi de taxa da maquininha
   - Quanto foi de imposto
   - Quanto é a comissão do profissional
   - Qual é o lucro real da clínica
5. Clique em **Confirmar pagamento**

---

### PASSO 4 — Acompanhe o Caixa

**Onde:** Menu lateral → **Financeiro** → aba **Caixa**

Depois de registrar pagamentos e marcar despesas como pagas, o caixa se atualiza automaticamente. Você vê:

- **Entradas** — tudo que entrou (pagamentos de pacientes)
- **Saídas** — tudo que saiu (despesas pagas)
- **Saldo** — a diferença em tempo real

Use os botões **Hoje**, **7 dias** ou **Mês** para escolher o período. Clique em qualquer dia para ver os lançamentos daquele dia em detalhe.

---

### PASSO 5 — Veja o que está em aberto

**Onde:** Menu lateral → **Financeiro** → aba **Contas a Receber**

Esta tela mostra dois grupos:

**Pagamentos pendentes registrados** — pacientes que têm pagamento no sistema ainda com status "pendente". Você pode marcar como pago ou clicar no WhatsApp para entrar em contato.

**Atendimentos sem pagamento registrado** — pacientes que foram confirmados no CRM mas não têm nenhum pagamento registrado no sistema ainda. Estes são a sua prioridade para regularizar.

---

### PASSO 6 — Confira os Lançamentos

**Onde:** Menu lateral → **Financeiro** → aba **Lançamentos**

Histórico completo de tudo que entrou e saiu, com filtros por período, tipo e busca por nome. Use o botão **CSV** para exportar para Excel quando precisar.

---

## Resumo do fluxo diário

```
Manhã
  → Verificar Contas a Pagar: tem algo vencendo hoje?
  → Verificar Contas a Receber: tem paciente sem pagamento?

Durante o dia
  → Paciente pagou → Registrar pagamento no perfil ou CRM
  → Comprou insumo → Cadastrar em Contas a Pagar e marcar pago

Final do dia
  → Caixa → ver o saldo do dia
```

---

## O que o sistema faz sozinho (sem intervenção)

- Calcula imposto, taxa da maquininha e comissão a cada pagamento registrado
- Gera as próximas parcelas de contas recorrentes
- Atualiza o caixa e os relatórios em tempo real
- Sinaliza contas vencidas automaticamente

---

*SintesIA — Ecossistema de Receita para Clínicas de Saúde Integrada*
