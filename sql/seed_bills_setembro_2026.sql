-- ============================================================
-- SintesIA — Contas a Pagar · Setembro 2026
-- Transcrição do caderno da Candia
-- Inserido em: 2026-09-28
-- ============================================================

INSERT INTO bills (description, category, supplier, amount, due_date, status, recurrence, notes) VALUES

-- ── Dia 02 ────────────────────────────────────────────────
('Pagamento Nayla (1ª quinzena)',          'salario',      'Nayla',             1200.00,  '2026-09-02', 'overdue', 'monthly',  NULL),
('Fatura Cartão Inter',                    'outros',        'Banco Inter',       2914.70,  '2026-09-02', 'overdue', 'monthly',  NULL),

-- ── Dia 04 ────────────────────────────────────────────────
('Empréstimo Roberto',                     'outros',        'Roberto',           1291.21,  '2026-09-04', 'overdue', 'monthly',  'Nº de parcelas a verificar'),
('1º Empréstimo Roberto (69/72)',           'outros',        'Roberto',            790.00,  '2026-09-04', 'overdue', 'monthly',  'Parcela 69/72'),

-- ── Dia 05 ────────────────────────────────────────────────
('Belfort',                                'servicos',      'Belfort',            167.94,  '2026-09-05', 'overdue', 'monthly',  NULL),

-- ── Dia 06 ────────────────────────────────────────────────
('Pagamento Ester',                        'salario',       'Ester',             2647.38,  '2026-09-06', 'overdue', 'monthly',  NULL),
('Pagamento Evelyn',                       'salario',       'Evelyn',            3034.84,  '2026-09-06', 'overdue', 'monthly',  NULL),

-- ── Dia 10 ────────────────────────────────────────────────
('Condomínio Salas 06 e 08',               'aluguel',       NULL,                2202.37,  '2026-09-10', 'overdue', 'monthly',  NULL),
('Aluguel Clínica',                        'aluguel',       NULL,                6055.26,  '2026-09-10', 'overdue', 'monthly',  NULL),
('Brand''s Royalties',                     'servicos',      'Brand''s',          1000.00,  '2026-09-10', 'overdue', 'monthly',  NULL),
('I9 Contabilidade',                       'servicos',      'I9 Contabilidade',   810.50,  '2026-09-10', 'overdue', 'monthly',  NULL),
('Faculdade Carol',                        'outros',        NULL,                 299.97,  '2026-09-10', 'overdue', 'monthly',  NULL),

-- ── Dia 12 ────────────────────────────────────────────────
('Salário Roberto',                        'salario',       'Roberto',           1500.00,  '2026-09-12', 'overdue', 'monthly',  NULL),

-- ── Dia 14 ────────────────────────────────────────────────
('Prestação Empréstimo CAIXA',             'outros',        'Caixa Econômica',   3086.00,  '2026-09-14', 'overdue', 'monthly',  'Parcela mensal'),
('IPTU Sala 8',                            'impostos',      'Prefeitura',         835.17,  '2026-09-14', 'overdue', 'none',     'Parcela 5/6'),

-- ── Dia 15 ────────────────────────────────────────────────
('Retirada Carol',                         'salario',       'Carol',             3000.00,  '2026-09-15', 'overdue', 'monthly',  'Pró-labore'),
('Pagamento Nayla (2ª quinzena)',           'salario',       'Nayla',             1200.00,  '2026-09-15', 'overdue', 'monthly',  NULL),

-- ── Dia 16 ────────────────────────────────────────────────
('IPTU Sala 06',                           'impostos',      'Prefeitura',         758.88,  '2026-09-16', 'overdue', 'none',     'Parcela 5/6'),
('Repasse Dra. Danielle',                  'salario',       'Dra. Danielle',     2000.00,  '2026-09-16', 'overdue', 'monthly',  NULL),
('Retirada Carol – Cartão Info.',          'outros',        'Carol',              134.00,  '2026-09-16', 'overdue', 'none',     'Parcela 1/6'),

-- ── Dia 17 ────────────────────────────────────────────────
('Cartão Santander',                       'outros',        'Santander',         3746.86,  '2026-09-17', 'overdue', 'monthly',  'Número de parcelas a verificar'),

-- ── Dia 18 ────────────────────────────────────────────────
('Energia Salas 6 e 8',                    'servicos',      NULL,                 400.00,  '2026-09-18', 'overdue', 'monthly',  NULL),
('FGTS',                                   'impostos',      'Caixa Econômica',    337.92,  '2026-09-18', 'overdue', 'monthly',  NULL),
('ISS',                                    'impostos',      'Prefeitura',        1099.94,  '2026-09-18', 'overdue', 'monthly',  NULL),
('MKT – Ícaro',                            'marketing',     'Ícaro',             1200.00,  '2026-09-18', 'overdue', 'monthly',  NULL),

-- ── Dia 20 ────────────────────────────────────────────────
('MKT – Meninas Maia',                     'marketing',     'Meninas Maia',      1800.00,  '2026-09-20', 'overdue', 'none',     'Parcela 3/6'),

-- ── Dia 25 ────────────────────────────────────────────────
('Feegow Agenda',                          'servicos',      'Feegow',             484.57,  '2026-09-25', 'overdue', 'monthly',  NULL),

-- ── Dia 26 ────────────────────────────────────────────────
('Cartão Caixa',                           'outros',        'Caixa Econômica',   4250.00,  '2026-09-26', 'overdue', 'monthly',  'Número de parcelas a verificar'),

-- ── Dia 27 ────────────────────────────────────────────────
('Devolução Cliente Tayla',                'outros',        NULL,                1005.00,  '2026-09-27', 'overdue', 'none',     'Parcela 3/6'),
('Devolução Cliente Nagela',               'outros',        NULL,                 986.67,  '2026-09-27', 'paid',    'none',     'Parcela 1/3 · Pago em 28/09/2026'),

-- ── Dia 30 ────────────────────────────────────────────────
('Impostos Geral',                         'impostos',      'Contabilidade',    11031.00,  '2026-09-30', 'pending', 'monthly',  NULL),
('Manutenção Carro',                       'manutencao',    NULL,                 600.00,  '2026-09-30', 'pending', 'none',     NULL)

ON CONFLICT DO NOTHING;

-- ── Verificação ──────────────────────────────────────────
SELECT
  due_date,
  description,
  amount,
  category,
  status,
  recurrence
FROM bills
WHERE due_date BETWEEN '2026-09-01' AND '2026-09-30'
ORDER BY due_date, description;
