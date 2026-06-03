-- ============================================================
-- SintesIA — Seed: procedures_pricing
-- Gerado em 2026-06-02
--
-- ⚠️  ESTIMATIVAS — revise comissão e custo fixo antes de
--     usar os dados em relatórios de gestão.
--
-- Critérios adotados:
--   tax_percentage    = 6%  (ISS / Simples Nacional padrão saúde)
--   fee_pix           = 0%
--   fee_debit         = 1.5%
--   fee_credit_1x     = 2.5%
--   fee_credit_2_6x   = 3.5%
--   fee_credit_7x_plus= 4.5%
--
-- Comissão estimada por categoria:
--   Consultas médicas           → 40%
--   Aplicações IM / injetáveis  → 35%
--   Procedimentos estéticos     → 30%
--   Terapias / exames           → 35%
--
-- Custo fixo estimado por tipo:
--   Consulta simples            → R$ 15 (descartáveis, ficha)
--   Aplicação IM                → R$ 30–80 (medicamento + consumíveis)
--   Procedimento estético/corp. → R$ 80–200 (insumos + manutenção equipamento)
--   Bioimpedância / análise     → R$ 10
--   Tratamentos de entrada      → R$ 100–250
--
-- Cada INSERT usa WHERE NOT EXISTS para ser idempotente.
-- ============================================================

-- ─── Consultas ───────────────────────────────────────────────

-- Acompanhamento nutricional e terapêutico em grupo (R$500)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '03f1f2de-54f7-4425-9fa1-ce58b0a0f2f1', 500.00, 20.00, 90, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Grupo terapêutico — custo fixo estimado (sala + material). Ajustar conforme nº de participantes.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '03f1f2de-54f7-4425-9fa1-ce58b0a0f2f1');

-- Bioimpedânciometria (R$220)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '38b0be29-b9d5-42f7-b885-4c9c664a2306', 220.00, 10.00, 30, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Exame de composição corporal — custo baixo (descartáveis). Deprec. do equipamento não incluída.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '38b0be29-b9d5-42f7-b885-4c9c664a2306');

-- Consulta 5S (R$450)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '138cb65f-7ca5-4acc-8fe1-45fc842ce0ac', 450.00, 15.00, 60, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Consulta protocolo 5S — primeira consulta mais longa. Ajuste duração se for retorno.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '138cb65f-7ca5-4acc-8fe1-45fc842ce0ac');

-- Consulta Acompanhamento (R$381,02)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'e6d49c2f-7a72-49e0-ac13-11c71a8ae8af', 381.02, 15.00, 45, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Retorno de acompanhamento — valor médio histórico do Feegow.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'e6d49c2f-7a72-49e0-ac13-11c71a8ae8af');

-- Consulta Avaliativa Emagrecimento (R$150)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '5dd0aa98-7355-4d98-bac9-96fab9b85f3b', 150.00, 15.00, 45, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Avaliação inicial — ticket mais baixo, função de conversão para tratamento.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '5dd0aa98-7355-4d98-bac9-96fab9b85f3b');

-- Consulta Emagrecimento (R$250)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '80660974-8492-4482-8b46-f5b85df130eb', 250.00, 15.00, 45, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '80660974-8492-4482-8b46-f5b85df130eb');

-- Consulta Estética (R$260)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'fb1e7a18-cc3d-4e45-987c-2ffbe7e9aa46', 260.00, 20.00, 45, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'fb1e7a18-cc3d-4e45-987c-2ffbe7e9aa46');

-- Consulta Estética Integrativa (R$450)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '3cba0a0d-f014-4573-b476-152ec3a43b2f', 450.00, 25.00, 60, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '3cba0a0d-f014-4573-b476-152ec3a43b2f');

-- Consulta Integrativa - Biorressonância (R$515,99)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '62119542-6cc4-41f0-8147-6cdffd7ea816', 515.99, 25.00, 60, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Inclui uso de equipamento de biorressonância — depreciar custo do equip. no fixed_cost.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '62119542-6cc4-41f0-8147-6cdffd7ea816');

-- Consulta Integrativa Completa (R$461,25)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'f5e603f3-5c84-4cdc-8cca-088dd85326fb', 461.25, 20.00, 60, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'f5e603f3-5c84-4cdc-8cca-088dd85326fb');

-- Consulta Lipedema (R$350)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '8b2b9b2e-08a7-40cd-80be-3a60a17e8fb9', 350.00, 15.00, 60, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '8b2b9b2e-08a7-40cd-80be-3a60a17e8fb9');

-- Consulta Médica - Telemedicina (R$780)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '6245d2f4-02a1-4c79-9916-829609de1c5f', 780.00, 10.00, 45, 6.0, 45.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Telemedicina — custo fixo reduzido (sem insumos físicos). Plataforma pode ter custo extra.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '6245d2f4-02a1-4c79-9916-829609de1c5f');

-- Consulta Mounjaro (R$300)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '249972b8-333f-4dae-bb53-c8a966f62bcf', 300.00, 15.00, 30, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Acompanhamento Mounjaro — medicamento não incluso no preço da consulta.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '249972b8-333f-4dae-bb53-c8a966f62bcf');

-- Consulta Nutricional Integrativa (R$1.750)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'eddf3a79-8826-4465-93af-839fe0e6edb4', 1750.00, 30.00, 90, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Pacote nutricional completo — verificar se inclui exames ou apenas consultas.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'eddf3a79-8826-4465-93af-839fe0e6edb4');

-- Consulta Nutrologia Integrativa (R$721,35)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'ae1634b0-331f-4f93-a5c2-6ef36c827761', 721.35, 20.00, 60, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'ae1634b0-331f-4f93-a5c2-6ef36c827761');

-- Consulta Ozempic (R$300)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'dc41b6fa-cf98-4c8f-b375-df9797bec026', 300.00, 15.00, 30, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Acompanhamento Ozempic — medicamento não incluso no preço da consulta.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'dc41b6fa-cf98-4c8f-b375-df9797bec026');

-- ─── Aplicações IM / Injetáveis ──────────────────────────────

-- Aplicação IM - Metilcobalamina B12 (R$230,80)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '09bc8200-7794-4ade-b9f8-2405b1aa0a4a', 230.80, 55.00, 15, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Custo fixo estimado = ampola + seringa + luva + algodão (~R$55). Ajustar pelo preço atual do insumo.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '09bc8200-7794-4ade-b9f8-2405b1aa0a4a');

-- Aplicação IM - NAC (R$150)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'ee1c85e3-a3e6-49a5-a551-ad7c5097dead', 150.00, 35.00, 15, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Custo fixo estimado = ampola NAC + descartáveis (~R$35).'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'ee1c85e3-a3e6-49a5-a551-ad7c5097dead');

-- Aplicação IM - Vitamina D3 10000UI (R$161,33)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '079513f0-1014-445b-99b9-2087ffa998d5', 161.33, 40.00, 15, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Custo fixo estimado = ampola D3 + descartáveis (~R$40). Ajustar conforme fornecedor.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '079513f0-1014-445b-99b9-2087ffa998d5');

-- Aplicação IM - Vitamina D3 600000UI (R$161,33)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '1bbfd8b2-c243-49d9-b20e-5192f737f631', 161.33, 45.00, 15, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Mega-dose 600kUI — ampola de maior custo. Ajustar fixed_cost pelo preço real da ampola.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '1bbfd8b2-c243-49d9-b20e-5192f737f631');

-- Aplicação IM - Vitamina K1 (R$161,33)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'ac9bca76-5002-4e28-b00e-58b4be8c3137', 161.33, 40.00, 15, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'ac9bca76-5002-4e28-b00e-58b4be8c3137');

-- ─── Procedimentos Estéticos / Corporais ─────────────────────

-- Criolipólise (R$499,64)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '2637c6a1-cce4-4e15-b43f-e069f9940eb1', 499.64, 80.00, 90, 6.0, 30.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Custo fixo estimado: gel anticongelante + consumível do aplicador (~R$80). Incluir deprec. do equipamento.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '2637c6a1-cce4-4e15-b43f-e069f9940eb1');

-- Criomodelagem Facial (R$1.733,40)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '83b1218c-2a74-4e2b-9491-c544914f0c70', 1733.40, 150.00, 90, 6.0, 30.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Procedimento facial de alto ticket — rever custo fixo com insumos reais.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '83b1218c-2a74-4e2b-9491-c544914f0c70');

-- Drenagem Linfática (R$177)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '639f7f3c-fb9c-4868-9bf4-9267588ff727', 177.00, 15.00, 60, 6.0, 40.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Mão de obra intensiva (60min). Custo fixo baixo (luvas + lençol descartável).'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '639f7f3c-fb9c-4868-9bf4-9267588ff727');

-- Enema - Café ou Ozônio (R$180)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'ce4ac794-b2e4-4dae-80ff-f60ad422b511', 180.00, 30.00, 45, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Custo fixo estimado: kit descartável de enema + café ou ozônio (~R$30).'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'ce4ac794-b2e4-4dae-80ff-f60ad422b511');

-- Harmonização Corporal - Criomodelagem (R$4.629,08)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '021858a7-d0d6-4183-843f-cae02fe3280c', 4629.08, 250.00, 120, 6.0, 30.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Pacote completo de alto ticket. Custo fixo estimado — revisar insumos reais do protocolo.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '021858a7-d0d6-4183-843f-cae02fe3280c');

-- Hidrovitallis (R$376,60)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '662f2106-9002-44ee-877f-be0e85eb5266', 376.60, 60.00, 60, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Procedimento de hidratação/vitalidade — custo fixo inclui insumos do kit.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '662f2106-9002-44ee-877f-be0e85eb5266');

-- ─── Kits / Entradas de Tratamento ───────────────────────────

-- Entrada de tratamento (R$2.354)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '1ca8443c-8bc2-406f-8751-f16939cf66e4', 2354.00, 200.00, 90, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Entrada de protocolo completo — custo fixo estimado. Detalhar insumos do pacote específico.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '1ca8443c-8bc2-406f-8751-f16939cf66e4');

-- Entrada do tratamento (R$1.456,12)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  'e5ec669d-2ecf-4298-be04-5dfafa4becc1', 1456.12, 150.00, 90, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  NULL
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = 'e5ec669d-2ecf-4298-be04-5dfafa4becc1');

-- Kit Desparasitação (R$750)
INSERT INTO procedures_pricing
  (service_id, base_price, fixed_cost, estimated_duration_minutes, tax_percentage, commission_percentage,
   fee_pix, fee_debit, fee_credit_1x, fee_credit_2_6x, fee_credit_7x_plus,
   notes)
SELECT
  '036055c3-1451-4b44-bd06-8d49278dfb1d', 750.00, 120.00, 30, 6.0, 35.0,
  0.0, 1.5, 2.5, 3.5, 4.5,
  'Custo fixo estimado = insumos do kit de desparasitação. Ajustar pelo custo real dos suplementos.'
WHERE NOT EXISTS (SELECT 1 FROM procedures_pricing WHERE service_id = '036055c3-1451-4b44-bd06-8d49278dfb1d');


-- ============================================================
-- ✅ Verificação pós-seed
-- Rode esta query para confirmar o que foi inserido e revisar:
-- ============================================================
-- SELECT
--   s.name,
--   s.category,
--   pp.base_price,
--   pp.fixed_cost,
--   pp.commission_percentage,
--   pp.estimated_duration_minutes,
--   ROUND(
--     (pp.base_price
--      - pp.base_price * pp.tax_percentage / 100
--      - pp.fixed_cost
--      - (pp.base_price - pp.base_price * pp.tax_percentage / 100) * pp.commission_percentage / 100
--     ) / pp.base_price * 100, 1
--   ) AS margem_pix_pct
-- FROM procedures_pricing pp
-- JOIN services s ON s.id = pp.service_id
-- ORDER BY margem_pix_pct DESC;
