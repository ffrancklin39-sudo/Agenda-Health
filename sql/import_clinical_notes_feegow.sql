-- ============================================================
-- SintesIA — Importação: Prescrições e Atestados do Feegow
-- 684 registros (prescrições, atestados, pedidos de exame)
-- Gerado em: 2026-09-25 20:53
-- Requer: tabela patient_clinical_notes criada via clinical_notes.sql
-- ============================================================

INSERT INTO patient_clinical_notes (patient_id, type, content, professional, note_date)
SELECT p.id, v.type, v.content, v.professional, v.note_date
FROM (VALUES
  ('06335546930', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso INTERNO</strong><br />
<strong>1.</strong> PARACETAMOL ...........................................1 CAIXA </span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>TOMAR 1 CP AO DIA</span></p>

<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>2.</strong> PARACETAMOL ...........................................1 CAIXA </span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>TOMAR 1 CP AO DIA</span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2025-07-08 15:22:03'),
  ('06335546930', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso INTERNO</strong><br />
<strong>1.</strong> PARACETAMOL ...........................................1 CAIXA </span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>TOMAR 1 CP AO DIA</span></p>

<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>2.</strong> PARACETAMOL ...........................................1 CAIXA </span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>TOMAR 1 CP AO DIA</span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2025-07-08 16:03:40'),
  ('10717573770', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................450mg<br />
Rutina.................................................100mg<br />
Centella Asiatica......................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 Dose ao dia, no lanche da manhã. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-07-11 13:53:48'),
  ('10717573770', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C ( ácido ascórbico)..........................500mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 4 x ao dia, café da manhã, almoço, lanche&nbsp;da tarde e jantar. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-07-11 13:55:10'),
  ('01322144150', 'prescricao', '1-<br />
Cloridrato de Tiamina 10mg<br />
Riboflavina 15mg<br />
Nicotinamida 20mg<br />
Pantotenato de cálcio 20mg<br />
Piridoxidina 10mg<br />
Biotina 100mcg<br />
Fosfatodilcolina 100mg<br />
Metilfolato 400mcg<br />
Metilcobalamina 1000mg<br />
<br />
Mande em caps.por 60 dias,&nbsp; tomar 1 dose junto no lanche da manhã.<br />
<br />
2-<br />
Vitamina C revestida 500mg<br />
Vitamina A como Acetato de Retinol 3000 UI<br />
Vitamina E como mix de tocotrienol 10mg<br />
Vitamina K2MK7 100mcg<br />
Inositol 200mg<br />
Mande em cps. por 60 dias e tomar 1 dose&nbsp; junto no lanche da tarde.', 'Ana Carolina Candia Barra', '2025-07-11 16:00:33'),
  ('57968799104', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2025-07-14 12:52:19'),
  ('96402806315', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira Santa.......................................500mg<br />
Alfafa extrato seco....................................500mg<br />
Uncaria tomentosa......................................250mg<br />
Coenzima Q10............................................50mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose duas vezes ao dia, de manhã em jejum e a tarde. Por 60 dias.</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-07-14 13:36:12'),
  ('96402806315', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000................................................40 g<br />
<br />
Mande com dosador.</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 40g diluido em um&nbsp;copo de água, 1 x ao dia, de manhã ou a noite antes de dormir.</span>', 'Ana Carolina Candia Barra', '2025-07-14 13:40:27'),
  ('08369131670', 'prescricao', '<strong>Suplementação para ganho de massa magra</strong><br />
<br />
<strong>Whey Protein Isolado</strong> – Sempre após treino, ou se não treinar, no lanche da tarde com a fruta, ou substituindo a proteína de alguma refeição, pode bater com água ou leite vegetal. (Pode tomar até 2 x ao dia).<br />
<br />
<strong>BCAA (Leucina 1.000 mg + L – isoleucina 750 mg + L – valina 750 mg).</strong> o mais prox. possível&nbsp;<br />
1 dose antes, durante e após ao treino, quando não treinar, pode tomar entre as refeições, 2x ao dia.<br />
<br />
<strong>Glutamina </strong>– 5 gramas por dia junto com limão em jejum.<br />
<br />
<strong>Creatina </strong>– 5 gramas dia, antes do treino. / 3 gramas sem treino.<br />
<br />
<strong>Ômega 3 – Vita For Plus&nbsp; </strong>– 2 doses por dia (café da manhã 2 caps. e jantar 1 caps.).&nbsp;<br />
<strong>OX DHA Yosen </strong>- 1 x ao dia no jantar.<br />
<br />
Pré treino&nbsp;<br />
1 hora a 30 minutos (preferencialmente).<br />
Carboidratos complexos ( 1 fatia de pão sem glúten com pasta de amendoin)&nbsp;<br />
<br />
Pós treino - Whey Protein&nbsp;<br />
+<br />
Energia do carboidrato mais proteína. ( Almoço)&nbsp;<br />
<br />
Durante o treino<br />
Beber bastante água, é muito importante se hidratar corretamente. + BCAA<br />
<br />
Atenção a quantidade de agua durante o dia. 5&nbsp; a 6 litros /dia&nbsp;<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-07-16 11:26:42'),
  ('25520199191', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2025-07-17 15:56:21'),
  ('64869229153', 'prescricao', '<strong>BCAA (Leucina 1.000 mg + L – isoleucina 750 mg + L – valina 750 mg)</strong>.<br />
&nbsp;1 dose antes, durante e após ao treino, quando não treinar, pode tomar entre as refeições, 2x ao dia.<br />
<br />
<strong>Glutamina </strong>– 5 gramas por dia junto com limão em jejum.<br />
<br />
<strong>Creatina </strong>– 5 gramas dia, antes do treino.&nbsp; / 3 gramas sem treino.<br />
<br />
<strong>Ômega 3 – </strong>990 de EPA e 660 de DHA – 3 doses por dia (café da manhã, almoço e jantar). – Vita For Plus<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-07-17 16:30:21'),
  ('53698258153', 'prescricao', '1<br />
Cobalto quelato 100 mcg<br />
Vitamina K2 120 mcg<br />
Metilfolato 500 mcg<br />
Metilcobalamina 1 mg<br />
Cobre Quelato 1,5 mg<br />
Zinco Quelato 7 mg<br />
Ferro Quelato 14 mg<br />
Magnésio Quelato 150 mg<br />
Cálcio Carbonato 730 mg<br />
<br />
Tomar uma dose após almoço e jantar. Por 30 dias<br />
<br />
2<br />
Ômega 3 - 990 EPA e 660 de DHA - vita for plus&nbsp;<br />
Tomar 1 dose 3 x ao dia , café da manhã, almoço e jantar.<br />
<br />
3<br />
Red clover 100 mg<br />
Angélica Sinensis 150 mg<br />
Cissus quadrangulares 150 mg<br />
Ilex paraguariensis 50 mg<br />
<br />
Mande 60 cápsulas.<br />
Tomar uma dose pela manhã e tarde.&nbsp;<br />
<br />
4-<br />
Angelica Sinensis 150 mg<br />
Magnolia officinalis 150 mg<br />
Valeriana officinalis 100 mg<br />
L-Theanina 50 mg<br />
<br />
Mande 60 cápsulas.<br />
Tomar uma dose antes de deitar (30 a 45<br />
minutos antes).<br />
<br />
5-<br />
Di indol-metano 50 mg<br />
Selênio 25 mcg<br />
Vitamina E 200 mg<br />
Ascorbato de magnésio 150 mg<br />
Vitex Agnus 80 mg<br />
<br />
Mande 60 cápsulas.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia.', 'Ana Carolina Candia Barra', '2025-07-21 17:09:13'),
  ('93668767068', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C ( ácido ascórbico)..........................500mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 4 x ao dia, café da manhã, almoço, lanche&nbsp;da tarde e jantar. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-07-23 13:56:44'),
  ('10717573770', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000....................................................</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose ( 25 a 40g) 1 x ao dia, de manhã ou a noite diluído em 1&nbsp;copo d''àgua.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>OBS: A dose depende a atividade intestinal, podendo aumentar ou reduzir a dose conforme o funcionamento intestinal.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-07-23 15:22:44'),
  ('92255221691', 'prescricao', '1-<br />
Melatonina Time Release – 5 mg<br />
mande em caps. glúten free Tomar 30 a 60 min. antes de dormir. Por 60 dias.<br />
<br />
2-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.', 'Ana Carolina Candia Barra', '2025-07-24 13:53:59'),
  ('18626319134', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................120mg<br />
Vitamina A...........................................2500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;<br />
<br />
2</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10......................................... 50 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg<br />
Berberina............................................. 500mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;<br />
3-<br />
Benfotiamina...................................... 100mg<br />
Sulbutiamina...................................... 100mg<br />
Tiamina........................................... 100mg<br />
manganês glicina ..................................10mg<br />
Picnogenol .........................................30mg<br />
<br />
mande 60 cap. tomar 2 x ao dia no café da manhã e a tarde.</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-07-30 16:59:29'),
  ('39124672858', 'prescricao', 'Solicito os seguintes exames:<br />
<br />
o TSH ultrassensível - T3 livre – T4 livre – Tireoglobulina<br />
o o SDHEA<br />
o FSH, LH o Estradiol, Estrona<br />
o Testosterona Total – SHBG<br />
o Serotonina, Prolactina<br />
o IGF-1 ( obs: dosado em nanogramas / ml )<br />
o 25-hidróxi Vitamina D3<br />
o Vitamina B12<br />
o Cálcio sérico, Cálcio Ionizado, Fósforo Sérico, PTH<br />
o Hemograma completo o TGO – TGP – Gama GT<br />
o Creatinina, Uréia, Ácido Úrico<br />
o Homocisteína<br />
o Ferro sérico, ferritina<br />
o Proteína C reativa ultrassensível<br />
o Fibrinogênio, Lipoproteína A<br />
o Glicemia de jejum – HB A1C – Insulina de jejum<br />
o Colesterol total – HDL – LDL – Triglicérides<br />
o Magnésio eritrocitário, zinco', 'Danielle Candia Barra', '2025-07-31 09:03:06'),
  ('39124672858', 'prescricao', 'Solicito rast :<br />
<br />
ALÉRGENOS RESPIRATÓRIOS<br />
RAST para Fungos: MX1<br />
RAST para Pólen de Gramíneias: GX2<br />
RAST para poeira: HX2<br />
RAST para Epitélios de Animais: EX1<br />
RAST para Ácaros: D1, D2 e D201<br />
RAST para Barata: I6<br />
ALÉRGENOS ALIMENTARES<br />
RAST para Alimentos Infantis: FX5<br />
RAST para Peixes / Mariscos: FX2<br />
RAST para Cereais: FX3<br />
RAST para Sementes Oleaginosas: FX1<br />
RAST para Leite: F2<br />
RAST para Ovo: F245', 'Danielle Candia Barra', '2025-07-31 09:04:13'),
  ('39124672858', 'prescricao', 'Solicito:&nbsp;<br />
<br />
<br />
<br />
- Ultrassom de abdome total<br />
- Ultrassom de mamas<br />
- Ultrassom transvaginal<br />
- Ultrassom de tireoide com doppler<br />
<br />
<br />
Cid: Z00<br />
&nbsp;', 'Danielle Candia Barra', '2025-07-31 09:06:09'),
  ('49800116915', 'prescricao', 'Uso oral<br />
<br />
* Avie em cápsulas incolores.<br />
1) Vitamina D3 7.000 unidades<br />
Vitamina A 1000 unidades<br />
Mix de Tocoferois 100mg<br />
Vitamina K2MK7 200 mcg<br />
<br />
Tomar 01 dose no almoço, por 90 dias.<br />
<br />
2) Omega 03 --------------------------- 01 grama<br />
Cápsulas de Ômega com 50% de DHA e 10% de EPA<br />
<br />
Tomar 01 dose ao dia ( Uso Contínuo)<br />
<br />
3) Creatina 03 gramas<br />
Tomar 01 dose ao dia. ( Uso Contínuo)<br />
<br />
4) Coenzima Q10 200mg<br />
Tomar 01 dose no café da manhã. ( Uso Contínuo)', 'Danielle Candia Barra', '2025-07-31 11:15:41'),
  ('49800116915', 'prescricao', 'Uso oral<br />
<br />
* Avie em cápsulas incolores.<br />
1) PQQ 5 mg<br />
Magnésio 150 mg<br />
Ribosídeo de nicotinamida 20 mg<br />
L-Arginina 300 mg<br />
L-Citrulina 200 mg<br />
Ácido alfa lipóico 150 mg<br />
<br />
Mande 90 cápsulas gastroresistentes.<br />
Sugestão de posologia: tomar 1 cápsula pela manhã.<br />
<br />
2) Metilfolato 0,25 mg<br />
Metilcobalamina0.5mg<br />
<br />
Mande 90 cápsulas.<br />
<br />
Sugestão de posologia: tomar uma dose à tarde.<br />
<br />
3)Red clover 100 mg<br />
Angélica Sinensis 150 mg<br />
Cissus quadrangulares 150 mg<br />
Ilex paraguariensis 50 mg<br />
Mande 90 cápsulas.<br />
<br />
Sugestão de posologia: tomar uma dose pela manhã e tarde.<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-07-31 11:26:00'),
  ('79453430153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno - manipular</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Melatonina Time Release – 5 mg<br />
mande em caps. glúten free Tomar 30 a 60 min. antes de dormir. Por 60 dias.<br />
<br />
2-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 400 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span><br />
<br />
3-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12,5mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.<br />
<br />
Em Lojas de suplementos&nbsp;<br />
<br />
4-</span><br />
<strong>Whey Protein Isolado &nbsp;(protéina vegetal ou da carne)&nbsp;</strong> – Sempre após treino&nbsp;ou se não treinar, no lanche da tarde com a fruta.<br />
<br />
5-&nbsp;<br />
<strong>BCAA&nbsp; em caps. (Leucina 1.000 mg + L – isoleucina 750 mg + L – valina 750 mg)</strong>.<br />
&nbsp;1 dose antes, durante e após ao treino, quando não treinar, pode tomar entre as refeições, 2x ao dia.<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-07-31 14:27:31'),
  ('46389580100', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Coenzima Q10...........................................50 mg<br />
Ácido málico............................................25 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH....................................................10mg<br />
Ácido alfa lipóico.....................................300mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2&nbsp;x ao dia, lanche da manhã e lanche da tarde.</span><br />
<br />
2-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3m</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Gaba...................................................300mg</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.<br />
<br />
3-<br />
Glucovantage 100mg&nbsp;<br />
<br />
1 dose - 2 x ao dia, cafpe da manhã e jnatar</span><br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-08-01 11:13:51'),
  ('92255221691', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Para manipulção<br />
<br />
Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Vitamina C ( ácido ascórbico)..........................500mg<br />
zinco quelato...........................................5mg<br />
selênio quelato.........................................50mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 4 x ao dia, café da manhã, almoço, lanche&nbsp;da tarde e jantar. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>2<br />
Melatonina Time Release – 5 mg<br />
mande em caps. glúten free. Tomar 30 a 60 min. antes de dormir. Por 60 dias.<br />
<br />
2-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 400 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.<br />
<br />
3-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
4-<br />
AdiDAO Diamina Oxidase ( histmina)......................4,2 mg<br />
<br />
Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar 1 dose até 2 x ao dia, antes de refeições que por ventura contanham alimentos ricos em histamina. (seguir tabela sugerida)Por 60 dias.<br />
<br />
5-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Trifolium pratense................................ 100 mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Angelica Sinensis................................. 150 mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Phellodendron amurense.............................200 mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Magnolia officinalis..............................&nbsp;100 mg</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 cápsulas.<br />
Sugestão de posologia: tomar uma dose após almoço e jantar.<br />
<br />
6-<br />
Vitamina D3 .....................................4.000 ui<br />
Vitamina A ......................................500ui<br />
Vitamina K2 MK7................................. 150mg<br />
<br />
Fluido sublingual base qsp 2 gotas. = 4.000 de vit.D<br />
Tomar 2 gotas via sublingual após o almoço. manter embaixo da lingua o máximo possível.</span><br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-08-01 13:07:35'),
  ('92255221691', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><font face=&quot;courier new, courier, monospace&quot;><span style=&quot;font-size:12px&quot;>2-</span></font></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span></p>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - Mega DHA &nbsp;- ( marca Vitafor)</span></span></h1>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 2&nbsp;x ao dia - &nbsp;almoço e jantar. Por 60 dias</span></span></p>
', 'Ana Carolina Candia Barra', '2025-08-01 13:21:28'),
  ('93668767068', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Di-indol metano........................................200mg<br />
Crisina................................................300mg<br />
Coleus forskohlii extrato seco padronizado 10% de forskohlin200mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Consumir 1 dose , pela manhã. Por 60 dias<br />
<br />
2</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................450mg<br />
hesperidina.............................................50mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose pela manhã e 1 a noite. por 30 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-08-06 15:36:34'),
  ('83206540330', 'prescricao', '<br />
Uso Subcutâneo :<br />
<br />
<br />
<br />
1)&nbsp;<a href=&quot;https://www.drogariasaopaulo.com.br/wegovy-2-4mg-novo-nordisk-4-doses-injetaveis/p?srsltid=AfmBOoohg_IsvCWi74oRapMUDhb0fU5riiTPhXImDqOhGxss_stURdx3&quot;>Wegovy 2,4mg Novo Nordisk 4 Doses Injetáveis</a><br />
<br />
<br />
Aplciar 01 dose por semana , por 08 semanas.&nbsp;<br />
&nbsp;', 'Danielle Candia Barra', '2025-08-07 09:59:59'),
  ('83206540330', 'prescricao', '<h2>****&nbsp; Tratamento proposto para 90 dias.&nbsp;<br />
<br />
<br />
Fórmula 1 – Metabólica e Reposição</h2>
Composição por dose total diária (2 cápsulas):

<table border=&quot;1&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot;>
	<tbody>
		<tr>
			<td style=&quot;width:288px&quot;>Ativo</td>
			<td style=&quot;width:288px&quot;>Dose total</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Vitamina C (tampão)</td>
			<td style=&quot;width:288px&quot;>500 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Vitamina K2 MK-7</td>
			<td style=&quot;width:288px&quot;>100 mcg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Zinco quelado</td>
			<td style=&quot;width:288px&quot;>25 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Inositol</td>
			<td style=&quot;width:288px&quot;>500 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Ácido alfa-lipóico (ALA)</td>
			<td style=&quot;width:288px&quot;>150 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Cromo (picolinato)</td>
			<td style=&quot;width:288px&quot;>200 mcg</td>
		</tr>
	</tbody>
</table>
Modo de uso: tomar 1 cápsula após o café da manhã e 1 após o almoço.<br />
&nbsp;
<h2>Fórmula 2 – Estímulo de Testosterona Natural</h2>
Composição por dose total diária (2 cápsulas):

<table border=&quot;1&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot;>
	<tbody>
		<tr>
			<td style=&quot;width:288px&quot;>Ativo</td>
			<td style=&quot;width:288px&quot;>Dose total</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Ácido D-aspártico</td>
			<td style=&quot;width:288px&quot;>1000 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Feno-grego extrato seco</td>
			<td style=&quot;width:288px&quot;>500 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Mucuna pruriens</td>
			<td style=&quot;width:288px&quot;>200 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Boro quelado</td>
			<td style=&quot;width:288px&quot;>3 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>NAC (N-acetilcisteína)</td>
			<td style=&quot;width:288px&quot;>300 mg</td>
		</tr>
		<tr>
			<td style=&quot;width:288px&quot;>Vitamina E (d-alfa tocoferol)</td>
			<td style=&quot;width:288px&quot;>200 UI</td>
		</tr>
	</tbody>
</table>
Modo de uso: tomar 1 cápsula após o jantar .<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-08-07 10:06:18'),
  ('83206540330', 'prescricao', '<h2>Fórmula (pó saborizado) – 1 scoop ao dia</h2>

<table border=&quot;1&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot;>
	<tbody>
		<tr>
			<td style=&quot;width:192px&quot;>Ativo</td>
			<td style=&quot;width:192px&quot;>Dose por porção</td>
			<td style=&quot;width:192px&quot;>Função</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>Taurina</td>
			<td style=&quot;width:192px&quot;>1000 mg</td>
			<td style=&quot;width:192px&quot;>Estímulo leve, foco, contração muscular</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>Beta-Alanina</td>
			<td style=&quot;width:192px&quot;>1500 mg</td>
			<td style=&quot;width:192px&quot;>Resistência, tamponamento ácido lático</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>Cafeína Anidra</td>
			<td style=&quot;width:192px&quot;>100 mg</td>
			<td style=&quot;width:192px&quot;>Estímulo, termogênese</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>L-Tirosina</td>
			<td style=&quot;width:192px&quot;>300 mg</td>
			<td style=&quot;width:192px&quot;>Neurofoco e performance mental</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>L-Citrulina DL-Malato</td>
			<td style=&quot;width:192px&quot;>1500 mg</td>
			<td style=&quot;width:192px&quot;>Vasodilatação e oxigenação muscular</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>Creatina Monohidratada</td>
			<td style=&quot;width:192px&quot;>3000 mg</td>
			<td style=&quot;width:192px&quot;>Energia e hipertrofia</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>Coenzima Q10</td>
			<td style=&quot;width:192px&quot;>50 mg</td>
			<td style=&quot;width:192px&quot;>Energia celular e mitocôndrias</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>Vitamina C</td>
			<td style=&quot;width:192px&quot;>250 mg</td>
			<td style=&quot;width:192px&quot;>Antioxidante e recuperação</td>
		</tr>
		<tr>
			<td style=&quot;width:192px&quot;>Saborizante natural (frutas vermelhas ou limão)</td>
			<td style=&quot;width:192px&quot;>-</td>
			<td style=&quot;width:192px&quot;>Melhora a palatabilidade</td>
		</tr>
	</tbody>
</table>
<br />
Modo de uso: Diluir 1 scoop em 150–200 mL de água, 30 minutos antes do treino.
<h2>Observações:</h2>
- Pode ser adoçado com taumatina, stevia ou eritritol.<br />
- Ajustar cafeína conforme sensibilidade.<br />
- Pode ser feito em potes de 150g a 300g.<br />
- Versão sem cafeína: substituir por Rodiola rosea ou Panax ginseng.<br />
&nbsp;', 'Danielle Candia Barra', '2025-08-07 10:12:06'),
  ('07844057602', 'prescricao', 'Uso oral&nbsp;<br />
<br />
<br />
<br />
1) Polietileno Glicol 4000-------------------- 01 Pote&nbsp;<br />
<br />
<br />
<br />
Tomar 20 gramas ao dia , por 60 dias', 'Danielle Candia Barra', '2025-08-07 11:06:58'),
  ('71469931320', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-08-07 16:09:09'),
  ('04937069179', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Magnésio treonato......................................600mg<br />
L-teanina..............................................200mg<br />
GABA...................................................250mg<br />
Coenzima Q10 (ubiquinol)...............................100mg<br />
Tomar uma dose, antes de dormir por 60 dias.&nbsp;<br />
<br />
2-</span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>PQQ....................................................10mg<br />
Ácido alfa lipóico.....................................500mg<br />
NAC....................................................600mg<br />
zinco elementar........................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 1</span><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span><span style=&quot;font-family:courier new,courier,monospace&quot;>x ao dia, café da manhã. Por 60 dias</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span><br />
Ômega 3 - rico em DHA - sugestão MEGA DHA ( vita for)&nbsp;<br />
<br />
uso contínuo&nbsp;<br />
3 x ao dia, café da manhã, almoço e jantar<br />
<br />
4-<br />
Cratina 5 g 1 x ao dia diluido em água.&nbsp;<br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-08-11 12:16:51'),
  ('04937069179', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ashwagandha (Withania somnifera) extrato padronizado 5% withanolídeos..500mg<br />
Tomar 2 x ao dia, lanche da manhã e da tarde. Por 60 dias.&nbsp;<br />
<br />
2-&nbsp;</span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Bacopa monnieri extrato padronizado 20% bacosídeos......................300mg<br />
Ginkgo biloba extrato padronizado 24% flavonoides / 6% terpenoides.......120mg<br />
Vitamina B1 (benfotiamina)...............................................150 mg<br />
Tomar 1 x ao dia, no café da manhã por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2025-08-11 13:02:06'),
  ('00124697003', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span>', 'Ana Carolina Candia Barra', '2025-08-12 12:06:48'),
  ('420738983', 'prescricao', '<p><font face=&quot;courier new, courier, monospace&quot;><strong>para manipulação</strong></font><br />
<br />
1-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;<br />
compra em farmácia&nbsp;<br />
<br />
2-<br />
Carvão ativado&nbsp;<br />
Tomar 1 dose por 07&nbsp;dias pela manhã<br />
<br />
3-<br />
Probiótico 20 BI<br />
<br />
Tomar 1 dose antes de dormir por 30 dias.&nbsp;</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-08-12 16:18:15'),
  ('41637070187', 'prescricao', '1-<br />
Espinheira santa 500 mg<br />
Alfafa extrato seco 500 mg<br />
Uncaria tomentosa 250 mg<br />
Coenzima Q10 50 mg<br />
Tomar uma dose duas a três vezes ao dia, por 60 dias<br />
<br />
2- Betaina HCl 300 mg<br />
Tomar uma dose duas vezes ao dia, no almoço e jantar. Por 60 dias.&nbsp;<br />
<br />
3-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease................................................50mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg</span>
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-08-13 12:59:53'),
  ('04368914171', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>1-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span><br />
<br />
2-</p>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Ferro Ydrosolv® 30ml&nbsp;( marca Yosen )</span></span></h1>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.</span></span><br />
<br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2025-08-13 16:39:19'),
  ('04368914171', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................50mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 2 doses,&nbsp;uma vez ao dia no almoço. Por 90 dias.</span><br />
<br />
2-&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2025-08-13 16:42:23'),
  ('99280078100', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
2-</span><br />
<span style=&quot;font-family:courier new,courier,monospace; font-size:14px&quot;>Ferro Ydrosolv® 30ml ( Yosen) compra na internet.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.<br />
<br />
3- (específico para lipedema)</span></span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Di-indol metano..................................................200mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>crisina...........................................................300mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coleus forskohlii extrato seco padronizado 10% de forskohlin .....200mg</span><br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Consumir 1 dose , pela manhã. Por 60 dias</span><br />
<br />
4- ( específico circulação e lipedema)</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................450mg<br />
hesperidina.............................................50mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose pela manhã e 1 a noite. por 30 dias.&nbsp;</span><br />
<br />
5-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................120mg<br />
Vitamina A...........................................2500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>60 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço. Por 60 dias<br />
<br />
6-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span>', 'Ana Carolina Candia Barra', '2025-08-15 10:55:47'),
  ('53698258153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 14:00, <strong>após refeições.&nbsp; por 30 dias.</strong></span><br />
<br />
2-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60&nbsp;dias<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira Santa.......................................500mg<br />
Alfafa extrato seco....................................500mg<br />
Uncaria tomentosa......................................250mg<br />
Coenzima Q10............................................50mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose duas vezes ao dia, de manhã em jejum e a tarde. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-08-20 09:32:50'),
  ('04937069179', 'prescricao', 'Uso oral<br />
<br />
1 - para manipulação<br />
<br />
Magnésio bisglicinato / malato..............................400mg<br />
vitamina K2 MK7................................................... 150mg<br />
selênio .................................................................. 100mcg<br />
zinco....................................................................... 15mg<br />
<br />
Tomar 1 dose - 1 x ao dia<br />
<br />
2- Chá de melissa natural 2 x ao dia, deixar infusão por 7 min.&nbsp;', 'Ana Carolina Candia Barra', '2025-08-27 12:04:02'),
  ('08369131670', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C ( ácido ascórbico)..........................500mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 4 x ao dia, café da manhã, almoço, lanche&nbsp;da tarde e jantar. Por 60 dias.</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................5.000ui<br />
Vitamina K2............................................60mg<br />
Vitamina A...........................................1250 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>60 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver duas&nbsp;pastilha sublingual uma vez ao dia no almoço.&nbsp;<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, jun to ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
5-&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-01 10:18:16'),
  ('08369131670', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso interno<br />
<br />
1-<br />
Testofen (50%Fenuside).................................400mg<br />
MucunaPruriens (20%L-Dopa).............................300mg<br />
Tribulusterrestris (40%saponinas)......................400mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>tomar uma dose duas vezes ao dia, longe das refeições. Por 60 dias</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2025-09-01 10:52:18'),
  ('8213109686', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Testofen (50%Fenuside).................................400mg<br />
MucunaPruriens (20%L-Dopa).............................300mg<br />
Tribulusterrestris (40%saponinas)......................400mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>tomar uma dose duas vezes ao dia, longe das refeições. Por 60 dias<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Crisina................................................250mg<br />
Resveratrol............................................500mg<br />
Saw palmeto............................................160mg<br />
Zinco...................................................10mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>tomar uma cápsula duas vezes ao dia.<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Ashwagandha............................................150mg<br />
Urtica dióica..........................................250mg<br />
Maca peruana...........................................250mg<br />
Tribullus terrestris...................................200mg<br />
Fenogrego..............................................300mg<br />
Turkesterone............................................50mg<br />
Catuaba................................................100mg<br />
Gynostemma pentaphyllum.................................80mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>tomar uma cápsula duas vezes ao dia. Por 60 dias</span></p>
', 'Ana Carolina Candia Barra', '2025-09-01 11:12:55'),
  ('08158093604', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10............................................100 mg<br />
Ácido málico............................................40 mg<br />
Acetil L - Carnitina....................................75mg<br />
NADH.....................................................15mg<br />
Ácido alfa lipóico.....................................600mg</span>
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 1 x ao dia, pela manhã.<br />
<br />
2-</span><br />
<br />
Niacina B3 ( ácido nicotínico).........................................................................250mg<br />
Policosanol................................................................................................... 10mg<br />
<br />
Tomar 1 cap. a noite com jantar , por 90 dias.<br />
obs. se tolerar bem,, subir para 2 caps. e após 4 semanas reavaliar perfil lipídico.<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-01 11:44:34'),
  ('08158093604', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................5.000ui<br />
Vitamina K2............................................120mg</span>
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço. por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-01 12:30:06'),
  ('12329797168', 'prescricao', '&nbsp;
<h2>MEDICAÇÃO</h2>
<br />
1) Metformina XR 500 mg<br />
<br />
Posologia: Tomar 01 comprimido ao jantar, diariamente.<br />
<br />
Duração: 90 dias<br />
<br />
CID-10: E88.2 – Resistência à insulina<br />
<br />
&nbsp;
<h2>ORIENTAÇÕES</h2>
<br />
- Avaliar tolerância gastrointestinal na 1ª semana de uso.<br />
- Reavaliar função renal, vitamina B12 e insulina em 90 dias.<br />
- Manter suplementação de vitamina B12 durante o uso.', 'Danielle Candia Barra', '2025-09-04 10:12:14'),
  ('12329797168', 'prescricao', '<h2>FÓRMULA 1 – VITAMINA D + K2 + OMEGA-3</h2>
Cápsula oleosa (uso diário):<br />
- Vitamina D3 (colecalciferol) – 10.000 UI<br />
- Vitamina K2 MK-7 – 100 mcg<br />
- Ômega-3 (EPA 660mg / DHA 440mg) – 1.000 mg<br />
<br />
Posologia: Tomar 1 cápsula ao dia, junto com o almoço.<br />
Duração: 90 dias<br />
<br />
&nbsp;
<h2>FÓRMULA 2 – VITAMINA B12 + B-COMPLEX ATIVO + ZINCO</h2>
Cápsula sublingual ou orodispersível:<br />
- Metilcobalamina – 5.000 mcg<br />
- Vitamina B1 – 20 mg<br />
- Vitamina B2 – 30 mg<br />
- Niacina (nicotinamida) – 35 mg<br />
- Ácido pantotênico (B5) – 80 mg<br />
- Piridoxal-5-fosfato (B6 ativa) – 20 mg<br />
- Metilfolato – 1 mg<br />
- Zinco quelado – 25 mg<br />
<br />
Posologia: Tomar 1 dose 3x/semana, longe de refeições com leite ou café.<br />
Duração: 90 dias', 'Danielle Candia Barra', '2025-09-04 10:14:39'),
  ('12329797168', 'prescricao', 'Cápsulas vegetais (manhã):<br />
<br />
- SDHEA – 5 mg<br />
- N-acetilcisteína (NAC) – 300 mg<br />
- Magnésio quelado – 150 mg<br />
- Selênio quelado – 100 mcg<br />
- Coenzima Q10 – 100 mg<br />
- Betaína (TMG) – 250 mg<br />
<br />
Posologia: Tomar 1 cápsula ao dia pela manhã, junto com o café da manhã.<br />
Duração: 90 dias<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-04 10:16:43'),
  ('25520199191', 'prescricao', 'Uso Intra muscular<br />
<br />
Vitamina D3 - 100.000 ui IM&nbsp;<br />
Dose única&nbsp;<br />
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2025-09-04 15:32:04'),
  ('71469931320', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, jun to ao almoço e jantar por 60 dias.&nbsp;</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release.................................2mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.<br />
<br />
3-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
silimarina - 200mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span>', 'Ana Carolina Candia Barra', '2025-09-04 16:23:21'),
  ('22500367134', 'prescricao', 'Uso intramuscular<br />
<br />
1 - metilcobalamina - 1 dose&nbsp;<br />
<br />
2 - Vitamina&nbsp; D3 600.000 ui&nbsp; - 1 dose<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-09-05 16:45:20'),
  ('25520199191', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span></p>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - Mega DHA &nbsp;- ( marca Vitafor)</span></span></h1>
Tomar 3 x ao dia, no café da manhã, almoço e jantar.<br />
<br />
&nbsp;
<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 2&nbsp;x ao dia - &nbsp;almoço e jantar. Por 60 dias</span></span></p>
', 'Ana Carolina Candia Barra', '2025-09-07 13:28:43'),
  ('25520199191', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso interno<br />
<br />
mandar manipular<br />
<br />
1-<br />
<br />
Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, jun to ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................120mg<br />
Vitamina A...........................................2500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-07 13:32:52'),
  ('35151994115', 'prescricao', NULL, 'Ana Carolina Candia Barra', '2025-09-07 13:41:15'),
  ('35151994115', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Extrato de Gotu Kola................................ 750mg<br />
Ginkgo biloba extrato padronizado 24% flavonoides / 6% terpenoides120mg<br />
Vitamina B9 (metilfolato)............................500mg<br />
Tomar 1 x ao dia, no café da manhã por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2025-09-07 13:53:22'),
  ('41637070187', 'prescricao', '<p><strong>1-</strong></p>
red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg
<p>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.<br />
<br />
<strong>2-</strong></p>
Extrato de Gotu Kola................................ 750mg<br />
Ginkgo biloba extrato padronizado 24% flavonoides / 6% terpenoides120mg<br />
Vitamina B9 (metilfolato)............................500mg<br />
<br />
Tomar 1 x ao dia, no café da manhã por 60 dias.&nbsp;<br />
<br />
<strong>3-</strong><br />
<br />
Ômega 3 - 990 de EPA e 660 de DHA ( sugestão Vita for plus)<br />
<br />
Tomar 3 x ao dia, no café da manhã, no almoço e jantar.<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-09-09 12:59:54'),
  ('41637070187', 'prescricao', '<br />
<strong>Dicas Importantes:&nbsp;<br />
<br />
Tomar sal integral ( de mar ou pedra) sal de mossoró.&nbsp;</strong><br />
<br />
Misture aproximadamente meia colher de chá de sal integral (como sal rosa ou marinho) em um litro e meio de água e beba ao longo do dia, especialmente durante o jejum ou antes e depois do exercício físico para melhorar a hidratação e repor eletrólitos.<br />
&nbsp;É crucial não exagerar na quantidade, para evitar excesso de sódio, e opta por sais integrais não refinados, que contêm mais minerais naturais do que o sal branco de mesa.&nbsp;<br />
<br />
OBS: Não fazer todos os dia , e sim dia sim, dia não, por 15 dias.&nbsp;<br />
e dar parar.', 'Ana Carolina Candia Barra', '2025-09-09 13:06:24'),
  ('57862680120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................2mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2025-09-09 15:07:38'),
  ('08369131670', 'prescricao', NULL, 'Ana Carolina Candia Barra', '2025-09-17 13:47:32'),
  ('08369131670', 'prescricao', '<br />
Uso oral<br />
<br />
1-<br />
Bifidobacterium animalis subsp. lactis_________________________ 2BI<br />
<br />
Bifidobacterium adolescentis________________________________ 2BI<br />
<br />
Lactobacillus casei_________________________________________2BI<br />
<br />
Pediococcus acidilactici_____________________________________2BI<br />
<br />
Akkermansia muciniphila (pasteurizada) _______________________5BI<br />
<br />
Tomar 1 dose, 1 x ao dia antes de dormir, por 30 dias.&nbsp;<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-09-17 13:51:50'),
  ('69058946134', 'prescricao', '<strong>Suplementação para ganho de massa magra</strong><br />
<br />
<strong>Whey Protein Isolado</strong>&nbsp;– Sempre após treino, ou se não treinar, no lanche da tarde com a fruta, ou substituindo a proteína de alguma refeição, pode bater com água ou leite vegetal. (Pode tomar até 2 x ao dia).<br />
<br />
<strong>BCAA (Leucina 1.000 mg + L – isoleucina 750 mg + L – valina 750 mg).</strong>&nbsp;o mais prox. possível&nbsp;<br />
1 dose antes, durante e após ao treino, quando não treinar, pode tomar entre as refeições, 2x ao dia.<br />
<br />
<strong>Glutamina&nbsp;</strong>– 5 gramas por dia junto com limão em jejum.<br />
<br />
<strong>Creatina&nbsp;</strong>– 5 gramas dia, antes do treino. / 3 gramas sem treino.<br />
<br />
<strong>Ômega 3 – Vita For Plus&nbsp;&nbsp;</strong>–&nbsp; 3 x ao dia no café da manhã, no almoço e no jantar.<br />
<br />
Pré treino&nbsp;<br />
1 hora antes (preferencialmente).<br />
Carboidratos complexos ( 1 fatia de pão sem glúten ou 1/2 banana nanica com 1 colher de sopa pasta de amendoin)&nbsp;<br />
<br />
Pós treino&nbsp;<br />
Whey Protein isolado&nbsp;<br />
+<br />
Energia do carboidrato mais proteína.&nbsp;<br />
<br />
Durante o treino<br />
Beber bastante água, é muito importante se hidratar corretamente. + BCAA<br />
<br />
Atenção a quantidade de agua durante o dia.&nbsp; (3 litros )&nbsp;<br />
<br />
____________________________________________________________<br />
<br />
Para manipulação<br />
<br />
1<br />
<br />
PEG 4000 - tomar 25g diluidos em água, 1 x ao dia. Durante o uso do Ozempic.&nbsp;', 'Ana Carolina Candia Barra', '2025-09-17 16:50:07'),
  ('01663482799', 'prescricao', '<strong>1. Ozempic® (semaglutida)<br />
<br />
Apresentação: </strong>Caneta 2 mg/1,5 mL, solução injetável.<br />
<strong>Posologia:</strong><br />
<br />
- Aplicar 0,625 mL , por via subcutânea, uma vez por semana,<br />
&nbsp; no mesmo dia e horário, durante 4 semanas.<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 09:15:42'),
  ('57895392115', 'prescricao', '<h2><br />
** Tratamento para 120 dias.&nbsp;<br />
<br />
&nbsp;Fórmula 1 – Suporte Metabólico e Antioxidante</h2>
- Ácido alfa-lipoico – 200 mg<br />
- Coenzima Q10 – 100 mg<br />
- Berberina fitossomada – 500 mg<br />
- Inositol – 200 mg<br />
- Cromo quelado – 200 mcg<br />
- Magnésio quelado – 150 mg<br />
- N-acetilcisteína – 300 mg<br />
Posologia: 1 cápsula 2x ao dia, antes das refeições principais
<h2>&nbsp;Fórmula 2 – Complexo B Metilado + Apoio Energético</h2>
- Vitamina B1 (tiamina) – 50 mg<br />
- Vitamina B2 (riboflavina) – 20 mg<br />
- Vitamina B3 (niacinamida) – 100 mg<br />
- Vitamina B5 (ácido pantotênico) – 100 mg<br />
- Vitamina B6 (P-5-P) – 25 mg<br />
- Metilfolato – 400 mcg<br />
- Metilcobalamina (B12) – 1000 mcg<br />
- Inositol – 200 mg<br />
- Colina bitartarato – 100 mg<br />
Posologia: 1 cápsula ao dia, após o café da manhã
<h2>Fórmula 3 – Vitamina D3 com CofatoresF</h2>
<br />
- Vitamina K2 MK-7 – 120 mcg<br />
- Magnésio bisglicinato – 100 mg<br />
- Boro quelado – 3 mg<br />
- Silício orgânico – 10 mg<br />
- Zinco quelado – 15 mg<br />
<br />
Posologia: 1 cápsula ao dia, junto com refeição com gordura<br />
<br />
<br />
Fórmula 4 - Tireoide<br />
-Levotiroxina (T4) bioidêntica – 20 mcg<br />
&nbsp;Liotironina (T3) bioidêntica – 20 mcg<br />
Forma farmacêutica: cápsulas gastroresistentes<br />
<br />
Quantidade: 120 cápsulas<br />
Posologia: tomar 1 cápsula ao dia, pela manhã em jejum, 30 minutos antes do café da manhã.<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 10:21:43'),
  ('70122741153', 'prescricao', '<p><strong>Exames solicitados:</strong></p>

<ul>
	<li>
	<p>Apolipoproteína A1 (Apo A1)</p>
	</li>
	<li>
	<p>Apolipoproteína B (Apo B)</p>
	</li>
	<li>
	<p>TSH</p>
	</li>
	<li>
	<p>T4 Livre</p>
	</li>
	<li>
	<p>T3 Livre</p>
	</li>
	<li>
	<p>FSH</p>
	</li>
	<li>
	<p>LH</p>
	</li>
	<li>
	<p>Estradiol</p>
	</li>
	<li>
	<p>Progesterona</p>
	</li>
	<li>
	<p>Testosterona total</p>
	</li>
</ul>

<p><strong>CID-10:</strong></p>

<ul>
	<li>
	<p><strong>E78.5</strong> – Dislipidemia não especificada</p>
	</li>
	<li>
	<p><strong>E03.9</strong> – Hipotireoidismo não especificado</p>
	</li>
	<li>
	<p><strong>N95.1</strong> – Sintomas da menopausa e do climatério</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-09-18 11:00:00'),
  ('70122741153', 'prescricao', '<br />
<br />
Uso Intramuscular&nbsp;<br />
<br />
<br />
<br />
1) Vitamina D3 200.000 unidades + Vitamina K2MK7&nbsp;<br />
<br />
<br />
Aplica 01 dose IM , dose única.&nbsp;', 'Danielle Candia Barra', '2025-09-18 11:02:46'),
  ('70122741153', 'prescricao', 'Prescrição de Suplementação Funcional –<br />
<br />
<br />
1) Cápsula Metabólica AM (1 cáps/dia, após o café da manhã)<br />
• Tiamina (B1) 25 mg<br />
• Riboflavina (B2) 20 mg<br />
• Niacina (B3, nicotinamida) 30 mg<br />
• Pantotenato de cálcio (B5) 50 mg<br />
• Piridoxal-5-fosfato (B6 ativa) 25 mg<br />
• Metilfolato (5-MTHF) 400 mcg<br />
• Metilcobalamina (B12) 1.000 mcg<br />
• Inositol 100 mg<br />
• Colina bitartarato 100 mg<br />
• Vitamina C 500 mg<br />
• Coenzima Q10 100 mg<br />
<br />
<br />
2) Cápsula Sono/Ansiedade PM (1 cáps/à noite)<br />
• Magnésio bisglicinato (fornecendo 120 mg de Mg elementar)<br />
<br />
<br />
3) D3 + K2 (1 cáps/dia com refeição principal)<br />
• Vitamina D3 10.000 UI<br />
• Vitamina K2 MK-7 200 mcg<br />
<br />
<br />
<br />
5) Ômega-3 EPA+DHA (2 g/dia)<br />
• Tomar com refeições principais, dividir em 1–2 tomadas ao dia.<br />
<br />
<br />
<br />
?? Orientações:<br />
- Iniciar suplementos após refeições para reduzir náusea.<br />
- Hidratação: 2–2,5 L/dia.<br />
- Ajustar fibras se desconforto: iniciar ½ sachê/dia e aumentar progressivamente.<br />
- Se constipação: priorizar fibras + magnésio.<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 11:08:29'),
  ('70122741153', 'prescricao', 'Prescrição de Suplementação Funcional –<br />
<br />
<br />
1) Cápsula Metabólica AM (1 cáps/dia, após o café da manhã)<br />
• Tiamina (B1) 25 mg<br />
• Riboflavina (B2) 20 mg<br />
• Niacina (B3, nicotinamida) 30 mg<br />
• Pantotenato de cálcio (B5) 50 mg<br />
• Piridoxal-5-fosfato (B6 ativa) 25 mg<br />
• Metilfolato (5-MTHF) 400 mcg<br />
• Metilcobalamina (B12) 1.000 mcg<br />
• Inositol 100 mg<br />
• Colina bitartarato 100 mg<br />
• Vitamina C 500 mg<br />
• Coenzima Q10 100 mg<br />
<br />
<br />
2) Cápsula Sono/Ansiedade PM (1 cáps/à noite)<br />
• Magnésio bisglicinato (fornecendo 120 mg de Mg elementar)<br />
<br />
<br />
3) D3 + K2 (1 cáps/dia com refeição principal)<br />
• Vitamina D3 10.000 UI<br />
• Vitamina K2 MK-7 200 mcg<br />
<br />
<br />
<br />
5) Ômega-3 EPA+DHA (2 g/dia)<br />
• Tomar com refeições principais, dividir em 1–2 tomadas ao dia.<br />
<br />
<br />
<br />
Orientações:<br />
- Iniciar suplementos após refeições para reduzir náusea.<br />
- Hidratação: 2–2,5 L/dia.<br />
- Ajustar fibras se desconforto: iniciar ½ sachê/dia e aumentar progressivamente.<br />
- Se constipação: priorizar fibras + magnésio.<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 11:10:04'),
  ('70122741153', 'prescricao', 'Receita Médica<br />
<br />
<br />
1) Mounjaro® (Tirzepatida) 2,5 mg/0,5 mL – Solução injetável (caneta pronta para uso)<br />
<br />
Posologia: aplicar 1 caneta (2,5 mg) por via subcutânea, 1 vez por semana, no mesmo dia da semana, preferencialmente no abdômen, coxa ou braço, alternando locais.<br />
<br />
<br />
Orientações:<br />
- Conservar refrigerado (2–8?°C). Não congelar.<br />
- Retirar da geladeira 30 minutos antes da aplicação.<br />
- Descartar caneta após uso único.<br />
- Associar dieta equilibrada e atividade física regular.', 'Danielle Candia Barra', '2025-09-18 11:12:17'),
  ('70122741153', 'prescricao', '1) Vonau Flash® (Ondansetrona) 4 mg – comprimidos orodispersíveis<br />
Posologia: 1 comprimido via oral se náusea ou vômito, podendo repetir a cada 8 horas se necessário. Não ultrapassar 3 comprimidos ao dia.<br />
<br />
<br />
Orientações:<br />
- Deixar dissolver o comprimido na boca, sem necessidade de água.<br />
- Utilizar apenas em caso de sintomas.<br />
- Caso os sintomas persistam, retornar para avaliação.<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 11:15:14'),
  ('02225692041', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1- energia fisica e mental, diminui&nbsp;stress&nbsp;</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo) 150mg<br />
Ashwagandha (Withania somnifera) extrato padronizado 5% withanolídeos 500mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
zinco quelato.......................................... 15mg<br />
Selenio metionina.......................................100mcg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00.<strong>&nbsp;Por 60 dias.</strong><br />
<br />
<strong>2- Trio de ouro&nbsp;</strong><br />
Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................100mg<br />
Vitamina A...........................................1000 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma 2 pastilhas sublingual uma vez ao dia no almoço. <strong>Por 60 dias</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>3- <strong>sono reparador / serotonina</strong></span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................150mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span><span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-19 14:42:25'),
  ('04937069179', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral<br />
<br />
1</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Clereto de metiltionínio................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose pela manhã, por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-24 11:24:29'),
  ('04734198152', 'prescricao', '<h2>Exames Laboratoriais</h2>
• Hemograma completo<br />
• Ferritina<br />
• Vitamina B12<br />
• Vitamina D (25-OH)<br />
• Vitamina C plasmática<br />
• Zinco sérico<br />
• Magnésio sérico<br />
• Cálcio total e iônico<br />
&nbsp;<br />
• Função tireoidiana e hormonal<br />
• TSH<br />
• T4 livre<br />
• T3 livre<br />
• FSH<br />
• LH<br />
• Estradiol<br />
• Progesterona<br />
• Testosterona total e livre<br />
• Prolactina<br />
• Cortisol sérico (manhã)&nbsp;<br />
• Metabólico e inflamação<br />
• Glicemia de jejum<br />
• Insulina<br />
• HOMA-IR<br />
• Hemoglobina glicada (HbA1c)<br />
• Colesterol total, HDL, LDL, triglicerídeos<br />
• Ácido úrico<br />
• PCR ultra-sensível&nbsp;<br />
<br />
• Coprológico funcional (digestão, disbiose, parasitas)<br />
• Indicam na Urina<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-25 10:16:44'),
  ('04734198152', 'prescricao', '<h3>RAST – IgE Específicas (painel resumido)</h3>

<ul>
	<li>
	<p>Leite de vaca</p>
	</li>
	<li>
	<p>Clara de ovo</p>
	</li>
	<li>
	<p>Trigo</p>
	</li>
	<li>
	<p>Soja</p>
	</li>
	<li>
	<p>Amendoim</p>
	</li>
	<li>
	<p>Crustáceos (camarão)</p>
	</li>
	<li>
	<p>Peixes</p>
	</li>
	<li>
	<p>Ácaros da poeira (Dermatophagoides pteronyssinus, Dermatophagoides farinae)</p>
	</li>
	<li>
	<p>Fungos (Alternaria, Aspergillus, Cladosporium)</p>
	</li>
	<li>
	<p>Epitélio de gato</p>
	</li>
	<li>
	<p>Epitélio de cão</p>
	</li>
	<li>
	<p>Pólen de gramíneas (capim)<br />
	<br />
	<br />
	<br />
	Cid : J34.2</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-09-25 10:19:00'),
  ('04734198152', 'prescricao', '<br />
Solicito :<br />
<br />
<br />
• Ultrassom de abdome total<br />
• Ultrassom transvaginal<br />
• Ultrassom de tireoide<br />
• Ultrassom de mamas<br />
<br />
<br />
Cid : Z00', 'Danielle Candia Barra', '2025-09-25 10:21:34'),
  ('04734198152', 'prescricao', 'Uso oral<br />
<br />
Boswellia serata 50 mg<br />
(extrato seco padronizado 20% de AKBA)<br />
Quercitina 400 mg<br />
Vitamina C 250 mg<br />
Tocotrimax 150 mg<br />
N-Acetil- cisteina 150 mg<br />
Zinco quelato 20 mg<br />
Mande 120 doses.<br />
<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia.<br />
<br />
Associar com:<br />
L-Glutamina 10 g<br />
N-Acetil-D-glucosamina 500 mg<br />
<br />
Mande 60 sachês.<br />
Sugestão de posologia: tomar um sachê ao dia.', 'Danielle Candia Barra', '2025-09-25 10:25:57'),
  ('25520199191', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................75mg<br />
Amilase................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................100mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
2-<br />
<br />
Sais biliares.......................................150 mg<br />
<br />
Tomar 1 dose junto com o alimento no almoço e no jantar por 30 dias.&nbsp;<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-25 14:36:42'),
  ('83639110110', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span><br />
1-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
2-<br />
Sais Biliares......................................... 300mg</span><br />
<br />
Tomar junto com as principais refeições, almoço e jantar - uso continuo.&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-25 16:22:51'),
  ('08158093604', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias. (Nunca em jejum)</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p>2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C ( ácido ascórbico)..........................500mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 4 x ao dia, café da manhã, almoço, lanche&nbsp;da tarde e jantar. Por 60 dias.<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................100mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-26 13:07:50'),
  ('79453430153', 'prescricao', '<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Sinensis........................................200mg<br />
Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias. ( pós procedimento de criomodelagem)<br />
<br />
2</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias (inicio pré procedimento de criomodelagem)<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias ( início pré&nbsp;procedimento de criomodelagem)</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-09-26 16:36:52'),
  ('57968799104', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1- comprar na internet</span></p>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Ferro Ydrosolv® 30ml</span></span></h1>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.</span></span></p>

<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2025-10-01 12:36:31'),
  ('57968799104', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Coenzima Q10..................................................... 50 mg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina.................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................5000ui<br />
Vitamina K2 MK7.......................................120mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-01 12:42:15'),
  ('28722219803', 'prescricao', 'Uso Tópico &nbsp;*** aplicar sempre nas pernas ,em pontos diferentes todos os dias!<br />
1) Estradiol 0,25mg<br />
Pentravan® qsp 1 mL<br />
*Sugestão de posologia: aplicar 1 mL (1 pump) ao acordar na pele em região sem pelos, de preferência atrás do joelho, face interna da coxas e no tornozelo<br />
<br />
2) Testosterona Base Micronizada 0,5 mg<br />
Pentravan® qsp 1 mL<br />
Mande frasco pump com 30 mL.<br />
*Sugestão de posologia: aplicar 1 mL (1 pump) ao acordar na pele em região sem pelos, de preferência atrás do joelho, face interna da coxas e no tornozelo<br />
<br />
Uso Vaginal&nbsp;<br />
3) Estriol 3mg<br />
Creme Vaginal qsp 4g<br />
Mande frasco com 25 g.<br />
Sugestão de posologia: administrar o conteúdo de 1 aplicador vaginal 03 vezes por semana<br />
<br />
Uso oral&nbsp;<br />
4) Progesterona Bioidêntica 100mg<br />
Tomar 01 dose antes de dormir.<br />
&nbsp;* Repetir a receita por no máximo 03 meses.', 'Danielle Candia Barra', '2025-10-02 10:25:57'),
  ('28722219803', 'prescricao', '• Uso oral<br />
<br />
<br />
<br />
1)&nbsp; Complexo B ativo (1 cápsula ao dia): B1 25 mg, B2 20 mg, B3 30 mg, B5 100 mg, B6 (P5P) 20 mg, B12 metilcobalamina 1000 mcg<br />
<br />
Tomar 01 dose no&nbsp; café da manhã.<br />
<br />
<br />
3) Coenzima Q10 (Ubiquinol) 100 mg/dia, pela manhã.<br />
Tomar 01 cp ao dia.&nbsp;<br />
<br />
2 )Vitamina D3 5.000 UI/dia Associar Vitamina K2 MK-7 200 mcg/dia + Vitamina A 1000 unidades<br />
<br />
Tomar 01 cp vo ao dia , no almoço.<br />
<br />
<br />
4) Ferro (Lipofer® 300 mg/dia) até ferritina &gt;70 ng/mL, de preferência longe do café da manhã.<br />
Tomar 01 dose ao dia , no almoço.<br />
<br />
<br />
5) Magnésio bisglicinato 200 mg/dia.<br />
&nbsp; &nbsp; Magnésio treonato 1.000 mg à noite (?144 mg Mg elementar).<br />
&nbsp; &nbsp; ZInco&nbsp; 15 mg&nbsp;<br />
&nbsp; &nbsp; &nbsp;Cobre 1mg&nbsp;<br />
<br />
Tomar 01 cp vo ao dia, antes de dormir.<br />
<br />
Tomar&nbsp;<br />
Observações:<br />
• Duração: 90 dias.<br />
• Manter ingestão proteica 1,2–1,6 g/kg/dia, evitando ultrapassar 2 g/kg por função renal limítrofe.<br />
• Evitar creatina e doses altas de vitamina C (&gt;1 g/dia).<br />
<br />
<br />
<br />
<br />
Dra. Danielle Candia Barra<br />
CRM-DF 22677<br />
&nbsp;', 'Danielle Candia Barra', '2025-10-02 10:38:50'),
  ('71469931320', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Sinensis........................................200mg<br />
Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias. ( pós procedimento de criomodelagem)<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2MK7.........................................120mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-03 12:09:51'),
  ('79453430153', 'prescricao', 'Uso oral<br />
<br />
1-<br />
PEG 4000&nbsp;<br />
Tomar de 25 a 40 g por dia ( conforme orientação profissional) diluido em um copo de água.&nbsp;', 'Ana Carolina Candia Barra', '2025-10-06 10:02:15'),
  ('75084821668', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso oral<br />
<br />
1-<br />
Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................150mg<br />
Vitamina A...........................................2500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, jun to ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
3-</span><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time Release – 3 mg<br />
mande em caps. glúten free Tomar 30 a 60 min. antes de dormir. Por 60 dias.<br />
<br />
5-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span><br />
<br />
6-<br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>Ashwagandha............................................150mg<br />
Urtica dióica..........................................250mg<br />
Maca peruana...........................................250mg<br />
Tribullus terrestris...................................200mg<br />
Fenogrego..............................................300mg<br />
Turkesterone............................................50mg<br />
Catuaba................................................100mg<br />
Gynostemma pentaphyllum.................................80mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>tomar uma cápsula duas vezes ao dia. Por 60 dias</span><br />
<br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-06 12:16:06'),
  ('04937069179', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira Santa.......................................500mg<br />
Alfafa extrato seco....................................500mg<br />
Uncaria tomentosa......................................250mg<br />
Coenzima Q10............................................50mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose duas vezes ao dia, de manhã em jejum e a tarde. Por 60 dias.<br />
<br />
3-<br />
<br />
Carvão ativado&nbsp;<br />
Tomar 1 dose, 1 x ao dia por 7 dias. pela manhã em jejum ( se alimentar somente 30min.&nbsp;depois.</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-08 11:07:30'),
  ('04288150140', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio TREONATO elementar............................150mg<br />
GABA...................................................250mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.<br />
<br />
2-</strong></span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Clereto de metiltionínio................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose pela manhã, por 60 dias.<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C ( como acido ascorbico).................................... 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio...............................................................&nbsp;100 mcg<br />
Coenzima Q10 ( ubiquinol)...............................................50&nbsp;mg<br />
Boro quelato........................................................... 1 mg<br />
Magnésio quelato......................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde</span><br />
<br />
<br />
4<br />
Lactobacillus acidophilus 1 Bilhão UFC<br />
Lactobacillus helveticus 1 Bilhão UFC<br />
Lactobacillus paracasei 1 Bilhão UFC<br />
Lactobacillus rhamnosus 1 Bilhão UFC<br />
Bifidobacterium breve 1 Bilhão UFC<br />
Enterococus faecium 1 Bilhão UFC<br />
<br />
Tomar uma dose a noite por 60&nbsp;&nbsp;dias e<br />
<br />
5</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................60mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>60 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver duas&nbsp;pastilhas sublingual uma vez ao dia no almoço.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-08 12:04:38'),
  ('04288150140', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1<br />
Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................60mg</span><br />
&nbsp;
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>60 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver duas&nbsp;pastilha sublingual uma vez ao dia após o almoço.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-08 13:06:18'),
  ('07844057602', 'prescricao', '<h2>Fórmula Manipulada</h2>
&nbsp;<br />
• Pancreatina 250 mg<br />
• Betaína HCl 200 mg<br />
• Pepsina 80 mg<br />
• Bromelina 100 mg<br />
• Papaína 100 mg<br />
• Lipase 6.000 FIP<br />
• Amilase 12.000 DU<br />
• Protease 10.000 HUT<br />
• Lactase 5.000 ALU<br />
<br />
• Excipiente q.s.p. 1 cápsula<br />
<br />
<br />
Tomar 1 cápsula antes do almoço e 1 antes do jantar, por 60 dias.<br />
&nbsp;', 'Danielle Candia Barra', '2025-10-09 09:13:54'),
  ('07844057602', 'prescricao', '&nbsp;Uso Subcutânea:<br />
<br />
&nbsp;
<h2>Mounjaro®&nbsp;</h2>
• Nome comercial: Mounjaro® (tirzepatida)<br />
• Posologia: Aplicar 7,5 mg, via subcutânea, 1 vez por semana.<br />
• Início: Conforme evolução do protocolo (após 4 semanas com 5 mg)<br />
<br />
<br />
• Horário preferencial: à noite, no mesmo dia da semana.<br />
• Locais de aplicação: alternar entre abdômen, coxa ou braço.<br />
• Duração: Uso contínuo com reavaliação clínica mensal.<br />
&nbsp;<br />
Dra. Danielle Candia Barra – CRM?DF 22677<br />
&nbsp;', 'Danielle Candia Barra', '2025-10-09 09:24:01'),
  ('07844057602', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
Uso Subcutânea:<br />
<br />
&nbsp;
<h2>Mounjaro®&nbsp;</h2>
• Nome comercial: Mounjaro® (tirzepatida)<br />
• Posologia: Aplicar 7,5 mg, via subcutânea, 1 vez por semana.<br />
• Início: Conforme evolução do protocolo (após 4 semanas com 5 mg)<br />
<br />
<br />
• Horário preferencial: à noite, no mesmo dia da semana.<br />
• Locais de aplicação: alternar entre abdômen, coxa ou braço.<br />
• Duração: Uso contínuo com reavaliação clínica mensal.<br />
&nbsp;<br />
Dra. Danielle Candia Barra – CRM?DF 22677', 'Ester Virginio dos Santos Tomaz', '2025-10-09 09:29:50'),
  ('07844057602', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
Uso oral&nbsp;<br />
<br />
1) Desvenlafaxina 50mg&nbsp;<br />
<br />
Tomar 01 dose o dia ( uso contínuo)&nbsp;', 'Danielle Candia Barra', '2025-10-09 09:34:56'),
  ('07844057602', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
Uso oral&nbsp;<br />
<br />
1) Desvenlafaxina 50mg&nbsp;<br />
<br />
Tomar 01 dose o dia ( uso contínuo)&nbsp;', 'Danielle Candia Barra', '2025-10-09 09:35:48'),
  ('92255221691', 'prescricao', '<h3><br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<strong>Uso Tópico<br />
<br />
<br />
1. Creme de Estradiol Bioidêntico – dose fisiológica mínima</strong></h3>

<p><strong>Composição (Pentravan® – 30g):</strong></p>

<ul>
	<li>
	<p><strong>Estradiol 17?</strong> .................................................. <strong>0,025 mg/dose (dose fisiológica)</strong></p>
	</li>
	<li>
	<p><strong>Base Pentravan® q.s.p.</strong> .................................. <strong>30 g</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong> aplicar <strong>1 dose (1 pump)</strong> <strong>pela manhã</strong>, em dias alternados, nas regiões descritas.</p>

<p><em>Objetivo:</em> manter níveis séricos entre <strong>20–40 pg/mL</strong>, promovendo melhora da mucosa, massa óssea e humor, sem estímulo endometrial significativo.</p>

<hr />
<h3>&nbsp;<strong>2. Creme de Testosterona Bioidêntica Feminina</strong></h3>

<p><strong>Composição (Pentravan® – 30g):</strong></p>

<ul>
	<li>
	<p><strong>Testosterona base</strong> .............................................. <strong>1,0 mg/dose</strong></p>
	</li>
	<li>
	<p><strong>Base Pentravan® q.s.p.</strong> .................................. <strong>30 g</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong> aplicar <strong>1 dose à noite</strong>, em região interna das coxas ou glúteos.</p>

<p>&nbsp;<em>Objetivo:</em> elevar testosterona total para 20–40 ng/dL, restaurando vitalidade, libido, densidade óssea e massa magra.<br />
<br />
<br />
<strong>Uso oral</strong></p>

<h3><strong>3)PROGESTERONA MICRONIZADA BIOIDÊNTICA – VIA ORAL</strong></h3>

<p><strong>Fórmula manipulada:</strong></p>

<ul>
	<li>
	<p><strong>Progesterona micronizada bioidêntica</strong> ..................... <strong>100 mg</strong></p>
	</li>
	<li>
	<p><strong>Excipiente q.s.p. cápsula gastrorresistente</strong><br />
	&nbsp;</p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
&nbsp;Tomar <strong>1 cápsula à noite, ao deitar</strong>, <strong>longe de alimentos gordurosos</strong>, para otimizar absorção e evitar refluxo.</p>

<p><br />
&nbsp;</p>
', 'Danielle Candia Barra', '2025-10-09 11:11:19'),
  ('92255221691', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;
<h3><strong>Uso Tópico<br />
<br />
<br />
1. Creme de Estradiol Bioidêntico – dose fisiológica mínima</strong></h3>

<p><strong>Composição (Pentravan® – 30g):</strong></p>

<ul>
	<li>
	<p><strong>Estradiol 17?</strong>&nbsp;..................................................&nbsp;<strong>0,025 mg/dose (dose fisiológica)</strong></p>
	</li>
	<li>
	<p><strong>Base Pentravan® q.s.p.</strong>&nbsp;..................................&nbsp;<strong>30 g</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong>&nbsp;aplicar&nbsp;<strong>1 dose (1 pump)</strong>&nbsp;<strong>pela manhã</strong>, em dias alternados, nas regiões descritas.</p>

<p><em>Objetivo:</em>&nbsp;manter níveis séricos entre&nbsp;<strong>20–40 pg/mL</strong>, promovendo melhora da mucosa, massa óssea e humor, sem estímulo endometrial significativo.</p>

<hr />
<h3>&nbsp;<strong>2. Creme de Testosterona Bioidêntica Feminina</strong></h3>

<p><strong>Composição (Pentravan® – 30g):</strong></p>

<ul>
	<li>
	<p><strong>Testosterona base</strong>&nbsp;..............................................&nbsp;<strong>1,0 mg/dose</strong></p>
	</li>
	<li>
	<p><strong>Base Pentravan® q.s.p.</strong>&nbsp;..................................&nbsp;<strong>30 g</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong>&nbsp;aplicar&nbsp;<strong>1 dose à noite</strong>, em região interna das coxas ou glúteos.</p>

<p>&nbsp;<em>Objetivo:</em>&nbsp;elevar testosterona total para 20–40 ng/dL, restaurando vitalidade, libido, densidade óssea e massa magra.<br />
<br />
<br />
<strong>Uso oral</strong></p>

<h3><strong>3)PROGESTERONA MICRONIZADA BIOIDÊNTICA – VIA ORAL</strong></h3>

<p><strong>Fórmula manipulada:</strong></p>

<ul>
	<li>
	<p><strong>Progesterona micronizada bioidêntica</strong>&nbsp;.....................&nbsp;<strong>100 mg</strong></p>
	</li>
	<li>
	<p><strong>Excipiente q.s.p. cápsula gastrorresistente</strong><br />
	&nbsp;</p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
&nbsp;Tomar&nbsp;<strong>1 cápsula à noite, ao deitar</strong>,&nbsp;<strong>longe de alimentos gordurosos</strong>, para otimizar absorção e evitar refluxo.</p>
', 'Danielle Candia Barra', '2025-10-09 11:11:57'),
  ('22500367134', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000....................................................1 pote&nbsp;</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose ( 25 a 40g) 1 x ao dia, de manhã ou a noite diluído em 1&nbsp;copo d''àgua.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>OBS: A dose depende a atividade intestinal, podendo aumentar ou reduzir a dose conforme o funcionamento intestinal.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-13 09:49:51'),
  ('22500367134', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>uso oral<br />
<br />
1-<br />
Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
Coenzima Q10 (ubiquinol)...............................50 mg<br />
picnogenol..............................................30mg<br />
metilcobalamina.........................................1 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, jun to ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Ômega 3&nbsp;<br />
<br />
Tomar 3 x ao dia, 1 no café da manhã, 1 no almoço e 1 no jantar.<br />
<br />
3-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4.000ui</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina K2............................................150mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina A...........................................2500 ui</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;</span><br />
&nbsp;</p>
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span>', 'Ana Carolina Candia Barra', '2025-10-13 10:09:41'),
  ('85260665104', 'prescricao', 'Uso intramuscular<br />
<br />
1- metilcobalamina - 2500 MCG - 1 ml<br />
Dose única&nbsp;<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-10-14 10:36:52'),
  ('08158093604', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................1,5mg<br />
magnésio treonato........................................400mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2025-10-14 12:31:17'),
  ('08158093604', 'prescricao', 'Probiótico ( farmácia comum)<br />
<br />
1- 20 bi<br />
<br />
tomar 1 dose após o jantar por 30 dias.&nbsp;', 'Ana Carolina Candia Barra', '2025-10-14 12:32:31'),
  ('87295490191', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Betaina HCl ...............................................................................300 mg<br />
Mande 60 doses.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar.</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-14 15:49:55'),
  ('04368914171', 'prescricao', '<p><strong>Uso uso interno</strong></p>

<h2>Compra pela internet</h2>

<p><strong>1-</strong></p>

<p><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></p>

<p><span style=&quot;font-size:14px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong><br />
<br />
2-</span></p>

<h1><span style=&quot;font-size:14px&quot;>Ferro Ydrosolv® 30ml&nbsp;( marca Yosen )</span></h1>

<p><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.<br />
<br />
3-<br />
<br />
Vitamina&nbsp; D3 Ydrosolv ( marca Yosen)<br />
<br />
Tomar 10 gotas bublingual ao dia após o almoço...</span></p>
', 'Ana Carolina Candia Barra', '2025-10-15 10:31:58'),
  ('02344108173', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Betaina HCl ...............................................................................150 mg&nbsp;<br />
Tomar uma dose duas vezes ao dia, no almoço<br />
e jantar. por 60 dias.&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg<br />
<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche, por 60 dias.&nbsp;<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
4-<br />
<br />
Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2025-10-15 16:04:28'),
  ('70122741153', 'prescricao', '<br />
<br />
Receita Médica<br />
<br />
<br />
1) Mounjaro® (Tirzepatida) 5 mg/0,5 mL – Solução injetável (caneta pronta para uso)<br />
<br />
Posologia: aplicar 1 caneta (5 mg) por via subcutânea, 1 vez por semana, no mesmo dia da semana, preferencialmente no abdômen, coxa ou braço, alternando locais.<br />
<br />
<br />
Orientações:<br />
- Conservar refrigerado (2–8?°C). Não congelar.<br />
- Retirar da geladeira 30 minutos antes da aplicação.<br />
- Descartar caneta após uso único.<br />
- Associar dieta equilibrada e atividade física regular.', 'Danielle Candia Barra', '2025-10-16 10:50:32'),
  ('70122741153', 'prescricao', '1) Mounjaro® (Tirzepatida) 15 mg/0,5 mL – Solução injetável (caneta KwikPen pronta para uso)<br />
Posologia: aplicar 1 caneta (15 mg) por via subcutânea, 1 vez por semana, no mesmo dia da semana, preferencialmente no abdômen, coxa ou braço, alternando os locais de aplicação.<br />
<br />
<br />
<br />
?? Orientações:<br />
- Conservar refrigerado (2–8?°C). Não congelar.<br />
- Retirar da geladeira 30 minutos antes da aplicação.<br />
- Descartar caneta após uso único.<br />
- Associar dieta equilibrada e atividade física regular.', 'Danielle Candia Barra', '2025-10-16 10:55:09'),
  ('70122741153', 'prescricao', '<h3><br />
<br />
<br />
<strong>Testosterona bioidêntica – strip sublingual (uso matinal)</strong></h3>

<p><strong>Fórmula manipulada:</strong></p>

<ul>
	<li>
	<p><strong>Testosterona base bioidêntica</strong> ............ <strong>0,25 mg</strong></p>
	</li>
	<li>
	<p><strong>Veículo sublingual (strip dissolvível)</strong> q.s.p. <strong>1 strip</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
Colocar <strong>1 strip sublingual pela manhã</strong>, em jejum, deixar dissolver completamente.<br />
Usar diariamente.</p>

<p><strong>Observações:</strong></p>

<ul>
	<li>
	<p>Não mastigar nem engolir.</p>
	</li>
	<li>
	<p>Armazenar ao abrigo de calor e umidade.</p>
	</li>
	<li>
	<p>Pode ajustar dose conforme sintomas e exames após 8 semanas.</p>
	</li>
</ul>

<hr />
<h3><strong>2?? Progesterona bioidêntica – cápsulas gastro-resistentes</strong></h3>

<p><strong>Fórmula manipulada:</strong></p>

<ul>
	<li>
	<p><strong>Progesterona micronizada bioidêntica</strong> ............ <strong>100 mg</strong></p>
	</li>
	<li>
	<p><strong>Veículo Pentravan® / excipiente lipofílico</strong> q.s.p. <strong>1 cápsula gastro-resistente</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar <strong>1 cápsula à noite (via oral)</strong>, <strong>do 14º ao 28º dia do ciclo menstrual</strong>.<br />
Em ciclos irregulares ou ausência de menstruação, iniciar 14 dias após o primeiro dia de sangramento e repetir mensalmente.</p>

<p><strong>Observações:</strong></p>

<ul>
	<li>
	<p>Tomar longe das refeições gordurosas.</p>
	</li>
	<li>
	<p>Favorece sono, tranquilidade e regularidade hormonal.</p>
	</li>
</ul>

<hr />
<p><strong>Orientações gerais:</strong></p>

<ul>
	<li>
	<p>Manter acompanhamento laboratorial (estradiol, progesterona, testosterona, TSH e T4 livre).</p>
	</li>
	<li>
	<p>Avaliar sintomas de excesso androgênico ou sonolência; ajustar conforme evolução clínica.</p>
	</li>
	<li>
	<p>Associar à rotina de suplementação funcional previamente prescrita.</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-10-16 11:09:57'),
  ('70122741153', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
1) Mounjaro® (Tirzepatida) 5 mg/0,5 mL – Solução injetável (caneta pronta para uso)<br />
<br />
Posologia: aplicar 1 caneta (5 mg) por via subcutânea, 1 vez por semana, no mesmo dia da semana, preferencialmente no abdômen, coxa ou braço, alternando locais.<br />
<br />
<br />
Orientações:<br />
- Conservar refrigerado (2–8?°C). Não congelar.<br />
- Retirar da geladeira 30 minutos antes da aplicação.<br />
- Descartar caneta após uso único.<br />
- Associar dieta equilibrada e atividade física regular.', 'Danielle Candia Barra', '2025-10-16 11:15:23'),
  ('77066146387', 'prescricao', 'Uso intramuscular&nbsp;<br />
<br />
1 - Ácido Alfa lipóico 100mg - 5 ml&nbsp;<br />
3 doses ( 1 x por mês)&nbsp;<br />
<br />
2- N Acetil Cisteína 300 mg - 2ml<br />
3 doses ( 1 x por mês)<br />
<br />
3- L carnitina 600mg - 2 ml&nbsp;<br />
3 doses ( 1 x por mês)', 'Ana Carolina Candia Barra', '2025-10-16 14:14:14'),
  ('77066146387', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1 - <strong>Melhorar a sensibilidade à insulina&nbsp;</strong><br />
<br />
Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias<br />
<br />
ou&nbsp;<br />
<br />
Berberina ..........................................500mg<br />
<br />
Tomar 1 caps. 3 x ao dia ( antes do café da manhã, almoço e jantar) Por 60 dias<br />
<br />
2- <strong>Polivitamínico para RI e emagrecimento</strong></span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose,&nbsp;por 60 dias. junto aos lanches.<br />
<br />
3-<br />
ômega 3 (990 de EPA e 660 de DHA) - sugestão Vita for Plus&nbsp;<br />
<br />
Tomar 3 doses ao dia, café da manhã, almoço e jantar. Por 90 dias.&nbsp;</span><br />
<br />
<br />
<br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-16 14:25:09'),
  ('77066146387', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1 - Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span><br />
&nbsp;</p>

<p>2- manipulada&nbsp;<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina K2............................................120mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>60 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço. Por 60 dias</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-16 17:18:52'),
  ('34600779134', 'prescricao', '<h3><strong>Fórmula para 60 dias&nbsp; , gastrorresistentes.<br />
<br />
<br />
Complexo B (com destaque para B12)</strong></h3>

<p><strong>Fórmula manipulada – 1 cápsula ao dia após o café da manhã</strong><br />
<em>(cápsulas gastro-resistentes, veículo Pentravan® se transdérmico não for necessário)</em></p>

<p>Tiamina (B1) – 50 mg</p>

<p>Riboflavina (B2) – 20 mg</p>

<p>Niacinamida (B3) – 50 mg</p>

<p>Ácido pantotênico (B5) – 100 mg</p>

<p>Piridoxal-5-fosfato (B6 ativa) – 25 mg</p>

<p>Inositol – 100 mg</p>

<p>Colina bitartarato – 150 mg</p>

<p>Ácido fólico (5-MTHF) – 400 mcg</p>

<p>Metilcobalamina (B12 ativa) – <strong>1000 mcg</strong></p>

<p>Biotina – 5 mg<br />
&nbsp;<strong>Objetivo:</strong> otimizar energia celular, cognição, metabolismo glicídico e homocisteína.</p>

<hr />
<h3><strong>Magnésio – associação dos quatro melhores tipos</strong></h3>

<p><strong>Fórmula manipulada – tomar 1 cápsula à noite antes de dormir</strong></p>

<p>Magnésio <strong>Bisglicinato</strong> – 100 mg</p>

<p>Magnésio <strong>Dimalato</strong> – 100 mg</p>

<p>Magnésio <strong>Treonato</strong> – 100 mg</p>

<p>Magnésio <strong>Citrato</strong> – 100 mg</p>

<p>&nbsp;<strong>Objetivo:</strong> suporte neuromuscular, melhora do sono, redução de cãibras e relaxamento muscular.</p>

<hr />
<h3>&nbsp;<strong>Antioxidantes e anti-inflamatórios leves</strong></h3>

<p><strong>1 cápsula 2x/dia, junto das principais refeições</strong></p>

<p>Ácido alfa-lipóico – 300 mg</p>

<p>Berberina – 500 mg</p>

<p>N-acetil-cisteína – 150 mg</p>

<p>Coenzima Q10 – 100 mg</p>

<p>Zinco quelato – 10 mg</p>

<p>Selênio quelato – 100 mcg</p>

<p>&nbsp;<strong>Objetivo:</strong> reduzir resistência insulínica, proteger endotelialmente e reduzir PCR.</p>

<hr />
<h3>&nbsp;<strong>Vitaminas lipossolúveis</strong></h3>

<p><strong>1 cápsula ao dia, após o almoço</strong></p>

<p>Vitamina D3 – 5000 UI</p>

<p>Vitamina K2 (MK-7) – 100 mcg</p>

<p>Vitamina E natural (d-alfa-tocoferol) – 100 UI</p>

<p>&nbsp;<strong>Objetivo:</strong> suporte cardiovascular, ósseo e cognitivo.</p>
', 'Danielle Candia Barra', '2025-10-23 09:15:22'),
  ('85260665104', 'prescricao', '<h3><strong>NORIPURUM® (ferripolimaltose) – Terapia de Reposição de Ferro Parenteral</strong></h3>

<p><strong>Prescrição:</strong></p>

<ul>
	<li>
	<p><strong>Noripurum® 100 mg (ampola 5 mL)</strong></p>
	</li>
	<li>
	<p><strong>Diluir em SF 0,9% – 250 mL</strong></p>
	</li>
	<li>
	<p><strong>Infundir lentamente (mínimo 1 hora)</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong></p>

<ul>
	<li>
	<p><strong>Aplicar 1 dose a cada 15 dias, total de 2 aplicações</strong></p>
	</li>
</ul>

<p>&nbsp;<strong>Esquema:</strong> 1ª infusão – dia 0<br />
????????2ª infusão – após 15 dias</p>

<p><strong>Via:</strong> Intravenosa, infusão lenta.<br />
<strong>Monitorar:</strong> pressão arterial, saturação e sintomas durante e após a infusão.</p>
', 'Danielle Candia Barra', '2025-10-23 11:13:25'),
  ('85260665104', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000<br />
mande 500g com um dosador de 10g</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose ( 30&nbsp;a 60g) 1 x ao dia, de manhã ou a noite diluído em 1&nbsp;copo d''àgua.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>OBS: A dose depende a atividade intestinal, podendo aumentar ou reduzir a dose conforme o funcionamento intestinal.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-10-28 11:42:45'),
  ('69058946134', 'prescricao', 'Voltando no retorno&nbsp;<br />
<br />
Perdeu um pouco de massa muscular de 38.6 para 37.9 e ganhou 1 kg de visceral.&nbsp;<br />
<br />
Porém não tomou ainda o BCAA, vai tomar e repetir os exames para avaliarmos os resultados coma insulina&nbsp;<br />
por volta do dia 6 de novembro', 'Ana Carolina Candia Barra', '2025-10-28 15:31:26'),
  ('00124697003', 'prescricao', '<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>1- Nux Vomica Homacord 30ml - Heel</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 30 gotas diluído em 300 ml de água 1 x ao dia.</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2025-10-29 11:02:12'),
  ('02225692041', 'prescricao', '<br />
1-<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp.......................................................75mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.', 'Ana Carolina Candia Barra', '2025-10-30 12:36:42'),
  ('00246144165', 'prescricao', '<h3><strong>Painel Autoimune e Inflamatório</strong></h3>

<ul>
	<li>
	<p>FAN (fator antinuclear) com padrão e título</p>
	</li>
	<li>
	<p>Anti-DNA dupla hélice</p>
	</li>
	<li>
	<p>Anti-ENA (anti-Ro, anti-La, anti-Sm, anti-RNP)</p>
	</li>
	<li>
	<p>Anti-CCP (peptídeo citrulinado cíclico)</p>
	</li>
	<li>
	<p>Fator reumatoide</p>
	</li>
	<li>
	<p>Anticorpos antitiroideanos (Anti-TPO, Anti-Tg)</p>
	</li>
	<li>
	<p>Anticorpo anti-endomísio e anti-gliadina IgA e IgG (avaliação de enteropatia associada)</p>
	</li>
	<li>
	<p>Anticorpo antinucleossomo e anti-histona (autoimunidade cutânea)</p>
	</li>
	<li>
	<p>Anticorpo anti-p40/p19 IL-23 (se disponível – pesquisa de fenótipo psoriásico autoimune)</p>
	</li>
</ul>

<h3>&nbsp;</h3>

<h3>&nbsp;</h3>

<p><strong>CID-10:</strong></p>

<ul>
	<li>
	<p>L40.0 – Psoríase vulgar</p>
	</li>
	<li>
	<p>L21.8 – Dermatite sebopsoriásica</p>
	</li>
	<li>
	<p>E06.3 – Tireoidite de Hashimoto</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-11-10 09:39:04'),
  ('33723192220', 'prescricao', '<h1>Pedido de Exames – Check-up Hormonal</h1>
• TSH<br />
• T4 Livre<br />
• T3 Livre<br />
• Anticorpos Anti-TPO<br />
• Vitamina D (25-OH)<br />
• Vitamina B12<br />
• Ácido Fólico<br />
• Zinco sérico<br />
• Selênio plasmático<br />
• Cortisol total<br />
• DHEA-S<br />
• Progesterona<br />
• Estradiol<br />
• Testosterona total e livre<br />
• SDHEA<br />
• LH e FSH<br />
• IGF-1<br />
• Insulina<br />
• Glicemia de jejum<br />
• Hemoglobina glicada<br />
• Homocisteína<br />
• Perfil lipídico completo<br />
<br />
Assinatura e carimbo médico<br />
<br />
<br />
____________________________________<br />
Dra. Danielle Candia Barra – CRM-DF 22677<br />
&nbsp;', 'Danielle Candia Barra', '2025-11-10 10:27:25'),
  ('33723192220', 'prescricao', '<br />
Solicito a realização dos seguintes exames laboratoriais para avaliação de risco cardiovascular e perfil lipídico avançado:<br />
- Apolipoproteína A1 (Apo A1)<br />
- Apolipoproteína B (Apo B)<br />
<br />
<br />
Assinatura: ____________________________________<br />
Dra. Danielle Candia Barra<br />
CRM-DF 22677<br />
&nbsp;', 'Danielle Candia Barra', '2025-11-10 10:32:55'),
  ('33723192220', 'prescricao', '<h2>&nbsp;</h2>
*** Fórmula para 120 dias.<br />
<br />
&nbsp;Fórmula manipulada proteção cardiovascular<br />
<br />
– Cápsulas gastro-resistentes – Tomar 1 cápsula 2x ao dia:<br />
<br />
• Berberina 500 mg<br />
• Red Yeast Rice (Arroz vermelho fermentado – Monacolina K padronizada 3%) 300 mg<br />
• Extrato seco de Bergamota (Citrus bergamia) 250 mg<br />
• Coenzima Q10 100 mg<br />
• Astaxantina 4 mg<br />
• Resveratrol 100 mg<br />
• Policosanol 20 mg<br />
• PQQ (Pirroloquinolina quinona) 10 mg<br />
• Extrato de alho envelhecido 250 mg<br />
• Tocoferóis mistos (Vitamina E complexa) 100 mg<br />
<br />
&nbsp;3. Neuroproteção/Cognição&nbsp;<br />
<br />
Citicolina 250 mg&nbsp;<br />
Bacopa monnieri 150 mg&nbsp;<br />
Ginkgo biloba 80 mg&nbsp;<br />
Fosfatidilserina 100 mg<br />
<br />
<br />
Tomar 01 cp vo pela manhã.<br />
<br />
&nbsp;&nbsp;<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-11-10 10:41:23'),
  ('01663482799', 'prescricao', '<p><strong>1. Ozempic® (semaglutida)</strong><br />
Apresentação: caneta 2 mg/1,5 mL – solução injetável.<br />
<strong>Posologia:</strong></p>

<ul>
	<li>
	<p>Aplicar <strong>54 cliques&nbsp;</strong>por via subcutânea <strong>1x por semana</strong>, no mesmo dia e horário, <strong>durante 4 semanas</strong>.</p>
	</li>
</ul>

<p><strong>Orientações:</strong></p>

<ul>
	<li>
	<p>Aplicar no abdome, coxa ou braço, alternando locais.</p>
	</li>
	<li>
	<p>Manter refrigerado entre 2 °C e 8 °C; após o primeiro uso, pode ser mantido até 56 dias em temperatura ambiente (&lt;30 °C), protegido da luz.</p>
	</li>
	<li>
	<p>Utilizar agulha nova a cada aplicação e descartar em coletor apropriado.</p>
	</li>
	<li>
	<p>Se esquecer, aplicar até 5 dias após a data prevista.</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-11-10 11:25:13'),
  ('01663482799', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;
<p><br />
<br />
<br />
<br />
<br />
<br />
<br />
<strong>1. Ozempic® (semaglutida)</strong><br />
Apresentação: caneta 2 mg/1,5 mL – solução injetável.<br />
<strong>Posologia:</strong></p>

<ul>
	<li>
	<p>Aplicar&nbsp;<strong>54 cliques&nbsp;</strong>por via subcutânea&nbsp;<strong>1x por semana</strong>, no mesmo dia e horário,&nbsp;<strong>durante 4 semanas</strong>.</p>
	</li>
</ul>

<p><strong>Orientações:</strong></p>

<ul>
	<li>
	<p>Aplicar no abdome, coxa ou braço, alternando locais.</p>
	</li>
	<li>
	<p>Manter refrigerado entre 2 °C e 8 °C; após o primeiro uso, pode ser mantido até 56 dias em temperatura ambiente (&lt;30 °C), protegido da luz.</p>
	</li>
	<li>
	<p>Utilizar agulha nova a cada aplicação e descartar em coletor apropriado.</p>
	</li>
	<li>
	<p>Se esquecer, aplicar até 5 dias após a data prevista</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-11-10 11:25:49'),
  ('01663482799', 'prescricao', 'Atesto, para os devidos fins, que a paciente Supracitada compareceu a esta clínica no período da manhã (matutino) para atendimento médico na presente data.&nbsp;<br />
<br />
Este atestado é emitido a pedido da interessada para fins de comprovação de comparecimento.<br />
&nbsp;', 'Danielle Candia Barra', '2025-11-10 11:35:28'),
  ('04937069179', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>USO ORAL<br />
<br />
1-<br />
Ashwagandha (Withania somnifera) extrato padronizado 5% withanolídeos500mg<br />
MAGNÉSIO DIMALATO 100 MG<br />
MAGNÉSIO TREONATO 100 MG<br />
<br />
<br />
Tomar 1 dose, 2 x ao dia , manhã e tarde por 60 dias.&nbsp;<br />
<br />
2-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C ( ácido ascórbico)..........................500mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 4 x ao dia, café da manhã, almoço, lanche&nbsp;da tarde e jantar. Por 60 dias.<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina K2..........................................150mg<br />
Vitamina A...........................................2500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;</span><br />
<br />
4-</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus casei 2 Bilhões UFC<br />
Lactobacillus bifidum 1 Bilhão UFC<br />
Lactobacillus acidophillus 1 Bilhão UFC<br />
Streptococcus faecium 1 Bilhão UFC<br />
Inulina 150 mg<br />
<br />
Mande 90 cápsulas.<br />
tomar uma dose uma vez ao dia, antes de<br />
dormir por três meses.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-11-11 11:27:19'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Sinensis........................................200mg<br />
Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias. ( pós procedimento de criomodelagem)<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias&nbsp;<br />
<br />
obs: Manter omega 3, e os demais suplementos do pré pocedimento&nbsp;<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-11-17 15:03:30'),
  ('41446780163', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Via oral<br />
<br />
1-<br />
Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
B12 ( metilcobalamina)..................................1000mcg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite.&nbsp;<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................120mg<br />
Vitamina A...........................................2500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;</span><br />
<br />
3-<br />
Ômega 3 - 990 de EPA e 660 de DHA ( sugestão vitafor plus)<br />
<br />
Tomar 1 dose 3 x ao dia, no café da manhã, no almoço e no jantar.&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-11-28 15:53:18'),
  ('07844057602', 'prescricao', '<p><br />
<br />
<br />
<br />
?? <strong>Mounjaro® KwikPen (tirzepatida)</strong>&nbsp; 15 mg/0,5 mL<br />
<strong>Apresentação:</strong> Caneta preenchida pronta para uso<br />
<strong>Posologia:</strong><br />
Aplicar <strong>1 dose subcutânea 1x por semana</strong>, no mesmo dia e horário, preferencialmente pela manhã.<br />
<em>Dose inicial habitual: 2,5 mg/semana por 4 semanas, com progressão gradual conforme tolerância e resposta clínica até dose-alvo individualizada.</em><br />
&nbsp;</p>

<p><strong>Instruções adicionais:</strong></p>

<ul>
	<li>
	<p>Rotacionar locais de aplicação (abdômen, coxa, parte posterior do braço).</p>
	</li>
	<li>
	<p>Aplicar em pele íntegra, longe do umbigo ou áreas inflamadas.</p>
	</li>
	<li>
	<p>Armazenar refrigerado entre 2°C e 8°C.</p>
	</li>
	<li>
	<p>Não congelar.</p>
	</li>
	<li>
	<p>Não utilizar se vencido ou se o líquido estiver turvo.</p>
	</li>
</ul>

<p><strong>CID(s):</strong> E66.9 / E11.9 / Z71.3 <em>(ajustável conforme indicação clínica)</em></p>
', 'Danielle Candia Barra', '2025-12-01 09:34:43'),
  ('07844057602', 'prescricao', '<p><br />
<br />
<br />
<br />
?? <strong>Mounjaro® KwikPen (tirzepatida)</strong>&nbsp; 15 mg/0,5 mL<br />
<strong>Apresentação:</strong> Caneta preenchida pronta para uso<br />
<strong>Posologia:</strong><br />
Aplicar <strong>1 dose subcutânea 1x por semana</strong>, no mesmo dia e horário, preferencialmente pela manhã.<br />
<em>Dose inicial habitual: 2,5 mg/semana por 4 semanas, com progressão gradual conforme tolerância e resposta clínica até dose-alvo individualizada.</em><br />
&nbsp;</p>

<p><strong>Instruções adicionais:</strong></p>

<ul>
	<li>
	<p>Rotacionar locais de aplicação (abdômen, coxa, parte posterior do braço).</p>
	</li>
	<li>
	<p>Aplicar em pele íntegra, longe do umbigo ou áreas inflamadas.</p>
	</li>
	<li>
	<p>Armazenar refrigerado entre 2°C e 8°C.</p>
	</li>
	<li>
	<p>Não congelar.</p>
	</li>
	<li>
	<p>Não utilizar se vencido ou se o líquido estiver turvo.</p>
	</li>
</ul>

<p><strong>CID(s):</strong> E66.9 / E11.9 / Z71.3 <em>(ajustável conforme indicação clínica)</em></p>
', 'Danielle Candia Barra', '2025-12-01 09:34:51'),
  ('07844057602', 'prescricao', '<p><br />
<br />
<br />
<br />
?? <strong>Mounjaro® KwikPen (tirzepatida)</strong>&nbsp; 15 mg/0,5 mL<br />
<strong>Apresentação:</strong> Caneta preenchida pronta para uso<br />
<strong>Posologia:</strong><br />
Aplicar <strong>1 dose subcutânea 1x por semana</strong>, no mesmo dia e horário, preferencialmente pela manhã.<br />
<em>Dose inicial habitual: 2,5 mg/semana por 4 semanas, com progressão gradual conforme tolerância e resposta clínica até dose-alvo individualizada.</em><br />
&nbsp;</p>

<p><strong>Instruções adicionais:</strong></p>

<ul>
	<li>
	<p>Rotacionar locais de aplicação (abdômen, coxa, parte posterior do braço).</p>
	</li>
	<li>
	<p>Aplicar em pele íntegra, longe do umbigo ou áreas inflamadas.</p>
	</li>
	<li>
	<p>Armazenar refrigerado entre 2°C e 8°C.</p>
	</li>
	<li>
	<p>Não congelar.</p>
	</li>
	<li>
	<p>Não utilizar se vencido ou se o líquido estiver turvo.</p>
	</li>
</ul>

<p><strong>CID(s):</strong> E66.9 / E11.9 / Z71.3 <em>(ajustável conforme indicação clínica)</em></p>
', 'Danielle Candia Barra', '2025-12-01 09:35:12'),
  ('07844057602', 'prescricao', '<p><br />
<br />
<br />
<br />
?? <strong>Mounjaro® KwikPen (tirzepatida)</strong>&nbsp; 15 mg/0,5 mL<br />
<strong>Apresentação:</strong> Caneta preenchida pronta para uso<br />
<strong>Posologia:</strong><br />
Aplicar <strong>1 dose subcutânea 1x por semana</strong>, no mesmo dia e horário, preferencialmente pela manhã.<br />
<em>Dose inicial habitual: 2,5 mg/semana por 4 semanas, com progressão gradual conforme tolerância e resposta clínica até dose-alvo individualizada.</em><br />
&nbsp;</p>

<p><strong>Instruções adicionais:</strong></p>

<ul>
	<li>
	<p>Rotacionar locais de aplicação (abdômen, coxa, parte posterior do braço).</p>
	</li>
	<li>
	<p>Aplicar em pele íntegra, longe do umbigo ou áreas inflamadas.</p>
	</li>
	<li>
	<p>Armazenar refrigerado entre 2°C e 8°C.</p>
	</li>
	<li>
	<p>Não congelar.</p>
	</li>
	<li>
	<p>Não utilizar se vencido ou se o líquido estiver turvo.</p>
	</li>
</ul>

<p><strong>CID(s):</strong> E66.9 / E11.9 / Z71.3 <em>(ajustável conforme indicação clínica)</em></p>
', 'Danielle Candia Barra', '2025-12-01 09:35:12'),
  ('07844057602', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;
<p><br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<strong>Mounjaro® KwikPen (tirzepatida)</strong>&nbsp; 15 mg/0,5 mL<br />
<strong>Apresentação:</strong>&nbsp;Caneta preenchida pronta para uso<br />
<strong>Posologia:</strong><br />
Aplicar&nbsp;<strong>1 dose subcutânea 1x por semana</strong>, no mesmo dia e horário, preferencialmente pela manhã.<br />
<em>Dose inicial habitual: 2,5 mg/semana por 4 semanas, com progressão gradual conforme tolerância e resposta clínica até dose-alvo individualizada.</em><br />
&nbsp;</p>

<p><strong>Instruções adicionais:</strong></p>

<ul>
	<li>
	<p>Rotacionar locais de aplicação (abdômen, coxa, parte posterior do braço).</p>
	</li>
	<li>
	<p>Aplicar em pele íntegra, longe do umbigo ou áreas inflamadas.</p>
	</li>
	<li>
	<p>Armazenar refrigerado entre 2°C e 8°C.</p>
	</li>
	<li>
	<p>Não congelar.</p>
	</li>
	<li>
	<p>Não utilizar se vencido ou se o líquido estiver turvo.</p>
	</li>
</ul>

<p><strong>CID(s):</strong>&nbsp;E66.9 / E11.9 / Z71.3&nbsp;<em>(ajustável conforme indicação clínica)</em></p>
', 'Danielle Candia Barra', '2025-12-01 09:36:32'),
  ('57968799104', 'prescricao', 'uso oral<br />
<br />
1-<br />
<br />
Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.', 'Ana Carolina Candia Barra', '2025-12-01 11:38:57'),
  ('83206540330', 'prescricao', '<h2>Fórmula 1 – Vitamina D3 + Vitamina K2 MK-7</h2>
• Vitamina D3 – 5000 UI<br />
• Vitamina K2 MK-7 – 100 mcg<br />
<br />
Modo de uso: Tomar 1 cápsula ao dia, preferencialmente junto a uma refeição com gordura.<br />
<br />
&nbsp;
<h2>Fórmula 2&nbsp;</h2>
• Tiamina (B1) – 50 mg<br />
• Riboflavina (B2) – 20 mg<br />
• Ácido pantotênico (B5) – 100 mg<br />
• Piridoxal-5-fosfato (B6 ativo) – 20 mg<br />
• Metilfolato – 400 mcg<br />
• Metilcobalamina (B12 ativa) – 1000 mcg<br />
• Colina – 200 mg<br />
• Inositol – 200 mg<br />
• Magnésio dimalato – 100 mg<br />
• Magnésio treonato – 50 mg<br />
• Magnésio glicina quelado – 150 mg<br />
<br />
Modo de uso: Tomar 1 dose&nbsp; 2 vezes ao dia com alimentos .<br />
&nbsp;
<h2>Fórmula 3 – Ferro com cofatores</h2>
• Ferro bisglicinato quelado – 30 mg<br />
• Vitamina A – 2000 UI<br />
• Ácido fólico – 400 mcg<br />
• Cobre quelado – 500 mcg<br />
<br />
Modo de uso: Tomar 1 cápsula longe de café, leite e refeições ricas em cálcio.<br />
&nbsp;
<h2>Fórmula 4 – Estímulo à Testosterona – Rodízio de Fitoterápicos</h2>
<br />
• Zinco quelado – 20 mg<br />
• Boro – 3 mg<br />
&nbsp;Tribulus terrestris – 500 mg (padronizado)<br />
<br />
Modo de uso: Tomar 1 dose&nbsp; ao dia, pela manhã.<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-12-01 11:59:47'),
  ('91394082304', 'prescricao', '<h3><strong>. Avaliação Hematológica</strong></h3>

<ul>
	<li>
	<p>Hemograma completo</p>
	</li>
	<li>
	<p>Ferritina</p>
	</li>
	<li>
	<p>Ferro sérico</p>
	</li>
	<li>
	<p>Capacidade total de ligação do ferro (TIBC)</p>
	</li>
	<li>
	<p>Saturação de transferrina</p>
	</li>
	<li>
	<p>Reticulócitos</p>
	</li>
	<li>
	<p>DHL</p>
	</li>
	<li>
	<p>Bilirrubina total e frações</p>
	</li>
</ul>

<h3><strong>2. Avaliação Metabólica e Glicêmica</strong></h3>

<ul>
	<li>
	<p>Glicemia de jejum</p>
	</li>
	<li>
	<p>Insulina de jejum</p>
	</li>
	<li>
	<p>Hemoglobina glicada (HbA1c)</p>
	</li>
	<li>
	<p>Perfil lipídico completo (CT, HDL, LDL, VLDL, Triglicerídeos)</p>
	</li>
</ul>

<h3><strong>3. Função Hepática e Renal</strong></h3>

<ul>
	<li>
	<p>AST (TGO)</p>
	</li>
	<li>
	<p>ALT (TGP)</p>
	</li>
	<li>
	<p>GGT</p>
	</li>
	<li>
	<p>Fosfatase alcalina</p>
	</li>
	<li>
	<p>Albumina</p>
	</li>
	<li>
	<p>Ureia</p>
	</li>
	<li>
	<p>Creatinina</p>
	</li>
	<li>
	<p>Ácido úrico</p>
	</li>
</ul>

<h3><strong>4. Inflamação Sistêmica</strong></h3>

<ul>
	<li>
	<p>PCR ultrassensível</p>
	</li>
	<li>
	<p>VHS</p>
	</li>
</ul>

<h3><strong>5. Tireoide</strong></h3>

<ul>
	<li>
	<p>TSH</p>
	</li>
	<li>
	<p>T4 livre</p>
	</li>
	<li>
	<p>T3 livre</p>
	</li>
	<li>
	<p>Anti-TPO</p>
	</li>
	<li>
	<p>Anti-tireoglobulina</p>
	</li>
</ul>

<h3><strong>6. Vitaminas e Minerais</strong></h3>

<ul>
	<li>
	<p>Vitamina D (25-OH)</p>
	</li>
	<li>
	<p>Vitamina B12</p>
	</li>
	<li>
	<p>Ácido fólico</p>
	</li>
	<li>
	<p>Magnésio</p>
	</li>
	<li>
	<p>Zinco</p>
	</li>
</ul>

<hr />
<h2><strong>PEDIDO DE EXAMES – AUTOIMUNIDADE (ESCLERODERMIA)</strong></h2>

<ul>
	<li>
	<p>FAN (ANA) com título e padrão</p>
	</li>
	<li>
	<p>Anti-centromero</p>
	</li>
	<li>
	<p>Anti-Scl-70 (anti-topoisomerase I)</p>
	</li>
	<li>
	<p>Anti-RNA polimerase III</p>
	</li>
	<li>
	<p>Painel ENA (quando disponível)</p>
	</li>
</ul>

<hr />
<h2><strong>PEDIDO DE EXAMES – IMAGEM</strong></h2>

<ul>
	<li>
	<p><strong>Ultrassonografia de tireoide com Doppler</strong></p>
	</li>
	<li>
	<p><strong>Ultrassonografia de abdome total</strong></p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-12-15 09:48:51'),
  ('83206540330', 'prescricao', '<h2>Fórmula 1 – Vitamina D3 + Vitamina K2 MK-7</h2>
• Vitamina D3 – 5000 UI<br />
• Vitamina K2 MK-7 – 100 mcg<br />
<br />
Modo de uso: Tomar 1 cápsula ao dia, preferencialmente junto a uma refeição com gordura.<br />
<br />
&nbsp;
<h2>Fórmula 2&nbsp;</h2>
• Tiamina (B1) – 50 mg<br />
• Riboflavina (B2) – 20 mg<br />
• Ácido pantotênico (B5) – 100 mg<br />
• Piridoxal-5-fosfato (B6 ativo) – 20 mg<br />
• Metilfolato – 400 mcg<br />
• Metilcobalamina (B12 ativa) – 1000 mcg<br />
• Colina – 200 mg<br />
• Inositol – 200 mg<br />
<br />
Modo de uso: Tomar 1 dose&nbsp; 2 vezes ao dia com alimentos .<br />
&nbsp;
<h2>Fórmula 3 – Ferro com cofatores</h2>
• Ferro bisglicinato quelado – 30 mg<br />
• Vitamina A – 2000 UI<br />
• Ácido fólico – 400 mcg<br />
• Cobre quelado – 500 mcg<br />
<br />
Modo de uso: Tomar 1 cápsula longe de café, leite e refeições ricas em cálcio.<br />
&nbsp;
<h2>Fórmula 4 – Estímulo à Testosterona – Rodízio de Fitoterápicos</h2>
<br />
• Zinco quelado – 20 mg<br />
• Boro – 3 mg<br />
&nbsp;Tribulus terrestris – 500 mg (padronizado)<br />
<br />
Modo de uso: Tomar 1 dose&nbsp; ao dia, pela manhã.', 'Danielle Candia Barra', '2025-12-15 09:51:13'),
  ('01663482799', 'prescricao', '<p><strong>1. Ozempic® (semaglutida)</strong><br />
Apresentação: caneta 2 mg/1,5 mL – solução injetável.<br />
<strong>Posologia:</strong></p>

<ul>
	<li>
	<p>Aplicar&nbsp;<strong>58&nbsp;cliques&nbsp;</strong>por via subcutânea&nbsp;<strong>1x por semana</strong>, no mesmo dia e horário,&nbsp;<strong>durante 4 semanas</strong>.</p>
	</li>
</ul>

<p><strong>Orientações:</strong></p>

<ul>
	<li>
	<p>Aplicar no abdome, coxa ou braço, alternando locais.</p>
	</li>
	<li>
	<p>Manter refrigerado entre 2 °C e 8 °C; após o primeiro uso, pode ser mantido até 56 dias em temperatura ambiente (&lt;30 °C), protegido da luz.</p>
	</li>
	<li>
	<p>Utilizar agulha nova a cada aplicação e descartar em coletor apropriado.</p>
	</li>
	<li>
	<p>Se esquecer, aplicar até 5 dias após a data prevista.</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-12-15 10:22:51'),
  ('01663482799', 'prescricao', 'Atesto, para os devidos fins, que a paciente Supracitada compareceu a esta clínica no período da manhã (matutino) para atendimento médico na presente data.&nbsp;<br />
<br />
Este atestado é emitido a pedido da interessada para fins de comprovação de comparecimento.<br />
&nbsp;', 'Danielle Candia Barra', '2025-12-15 10:24:34'),
  ('01663482799', 'prescricao', 'FORMULA 1 MANUTENCAO METABOLICA E MITOCONDRIAL<br />
Coenzima Q10 ubiquinol 200 mg<br />
Magnesio bisglicinato 100 mg<br />
Zinco quelado 15 mg<br />
Selenio quelado 100 mcg<br />
Posologia Tomar 1 capsula pela manha apos o cafe<br />
Duracao 120 dias<br />
<br />
<br />
FORMULA 2 MANUTENCAO NEUROMUSCULAR E SONO<br />
Magnesio bisglicinato 200 mg<br />
Glicina 300 mg<br />
Posologia Tomar 1 capsula a noite antes de dormir<br />
Duracao 120 dias<br />
<br />
<br />
FORMULA 3 MANUTENCAO CARDIOMETABOLICA<br />
Omega 3 TG EPA DHA 1000 mg<br />
Vitamina D3 2000 UI<br />
Vitamina K2 MK7 100 mcg<br />
Posologia Tomar 1 capsula ao almoco<br />
Duracao 120 dias<br />
<br />
<br />
FORMULA 4 PERFORMANCE E MASSA MAGRA<br />
Creatina monohidratada 3 g<br />
Posologia Diluir em agua e tomar 1 vez ao dia preferencialmente apos o treino<br />
Duracao 120 dias<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2025-12-15 10:32:49'),
  ('70041903153', 'prescricao', '<h1>. Fórmula Imunomoduladora + Antiviral</h1>
L-lisina 500 mg<br />
Monolaurina 300 mg<br />
Extrato seco de Astragalus (padronizado 70% polissacarídeos) 250 mg<br />
Zinco quelato 15 mg<br />
Selênio quelato 100 mcg<br />
Vitamina C tamponada 250 mg<br />
Posologia: 1 cápsula 2x/dia, após almoço e jantar<br />
Duração: 90 dias
<h1>2. Fórmula Anti-inflamatória Imune / Pele / Autoimunidade</h1>
Quercetina 400 mg<br />
Boswellia serrata (20% AKBA) 100 mg<br />
Curcumina fitossomada 250 mg<br />
Vitamina D3 2.000 UI<br />
Vitamina K2 MK-7 100 mcg<br />
Posologia: 1 cápsula ao dia, com a principal refeição<br />
Duração: 120 dias
<h1>3. Fórmula Endotelial / Antitrombótica Funcional</h1>
N-acetil-cisteína (NAC) 600 mg<br />
Pycnogenol® 100 mg<br />
Ômega-3 concentrado (EPA+DHA) 1.000 mg<br />
Magnésio bisglicinato 100 mg<br />
Posologia: 1 cápsula ao dia, após o jantar<br />
Duração: 120 dias
<h1>4. Fórmula Suporte Hematológico Leve</h1>
Metilcobalamina 500 mcg<br />
Metilfolato 400 mcg<br />
Ferro bisglicinato 15 mg<br />
Cobre quelato 1 mg<br />
Posologia: 1 cápsula ao dia, pela manhã<br />
Duração: 90 dias<br />
&nbsp;', 'Danielle Candia Barra', '2025-12-15 11:59:55'),
  ('70041903153', 'prescricao', '<p>SOLICITACAO DE EXAME</p>

<p>Paciente Maria Cecilia Teodora dos Santos</p>

<p>Solicito a realizacao do seguinte exame hormonal:</p>

<p>Progesterona serica<br />
Coleta entre o 21 e o 23 dia do ciclo menstrual</p>

<p>Justificativa<br />
Avaliacao da fase lutea e da producao endogena de progesterona</p>

<p>&nbsp;</p>
&nbsp;

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2025-12-15 12:02:18'),
  ('70041903153', 'prescricao', '<p>Paciente Maria Cecilia Teodora dos Santos</p>

<p>Vitamina D3 intramuscular<br />
Dose 200000 UI<br />
Aplicar 1 ampola intramuscular dose unica<br />
Reavaliar niveis sericos em 8 a 12 semanas</p>

<p>Metilcobalamina intramuscular<br />
Dose 2500 mcg<br />
Aplicar 1 ampola intramuscular 1 vez por semana por 4 semanas<br />
Apos manteravaliacao considerar manutencao mensal conforme niveis sericos</p>

<p>Orientacoes<br />
Aplicacao intramuscular profunda<br />
Nao associar na mesma seringa</p>
', 'Danielle Candia Barra', '2025-12-15 12:06:12'),
  ('66654718100', 'prescricao', '<p>Uso oral&nbsp; *** Fórnula para no máximo 120 dias.&nbsp;<br />
<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Boswellia serrata extrato seco padronizado 20 por cento de AKBA – 50 mg</p>

<ul>
	<li>
	<p>Quercetina – 400 mg</p>
	</li>
	<li>
	<p>Vitamina C (ascorbato de cálcio) – 250 mg</p>
	</li>
	<li>
	<p>Tocotrimax (tocotrienóis mistos) – 150 mg</p>
	</li>
	<li>
	<p>N acetil cisteína – 150 mg</p>
	</li>
	<li>
	<p>Zinco quelado (bisglicinato) – 20 mg</p>
	</li>
	<li>
	<p>Selênio quelado – 100 mcg</p>
	</li>
	<li>
	<p>Vitamina A (palmitato) – 5.000 UI</p>
	</li>
	<li>
	<p><strong>Vitamina B12 (metilcobalamina)</strong> – 500 mcg<br />
	<strong>Cápsulas gastro resistentes</strong></p>
	</li>
</ul>

<hr />
<p><strong>Fórmula 2 – Sachê para Barreira Intestinal e Imunorregulação</strong><br />
60 sachês – tomar 1 sachê ao dia em jejum</p>

<ul>
	<li>
	<p>L Glutamina – 10 g</p>
	</li>
	<li>
	<p>N acetil D glucosamina – 500 mg</p>
	</li>
	<li>
	<p>FOS frutooligossacarídeos – 1,5 g</p>
	</li>
	<li>
	<p>Beta glucana de levedura (Imunoglucan) – 250 mg</p>
	</li>
	<li>
	<p>Curcumina microencapsulada (Curcuwin) – 100 mg</p>
	</li>
</ul>

<hr />
<p><strong>Fórmula 3 – Antioxidante e Suporte Mitocondrial</strong><br />
60 cápsulas – tomar 1 cápsula ao dia, junto da maior refeição</p>

<ul>
	<li>
	<p>Coenzima Q10 – 100 mg</p>
	</li>
	<li>
	<p>Astaxantina – 6 mg</p>
	</li>
	<li>
	<p>Magnésio quelado (treonato ou glicina) – 150 mg</p>
	</li>
	<li>
	<p>Resveratrol – 100 mg</p>
	</li>
	<li>
	<p>Vitamina E (mix tocoferóis) – 200 UI</p>
	</li>
	<li>
	<p>Ácido alfa lipoico – 150 mg<br />
	<strong>Cápsulas gastro resistentes</strong></p>
	</li>
</ul>
', 'Danielle Candia Barra', '2025-12-15 12:38:20'),
  ('66654718100', 'prescricao', '<p><strong>Exame solicitado:</strong></p>

<ul>
	<li>
	<p>Polissonografia tipo II ou III (polissonografia domiciliar)</p>
	</li>
</ul>

<p><strong>Objetivo clínico:</strong></p>

<ul>
	<li>
	<p>Avaliação de apneia obstrutiva do sono (AOS)</p>
	</li>
	<li>
	<p>Identificação de microdespertares e fragmentação do sono</p>
	</li>
	<li>
	<p>Correlação com sintomas imunológicos e inflamatórios</p>
	</li>
	<li>
	<p>Investigação complementar em paciente com faringites de repetição, fadiga crônica e dor vascular pós-COVID</p>
	</li>
</ul>

<p><strong>CID-10 sugerido:</strong> G47.3 – Apneia do sono</p>
', 'Danielle Candia Barra', '2025-12-15 12:45:31'),
  ('02225692041', 'prescricao', '<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>1-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Zinco Ydrosolv® 30ml ( marca Yosen )</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 10 gotas sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia.</strong></span></span><br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3&nbsp;990 EPA e 660 DHA- ( marca Vitafor PLUS)</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 2 x ao dia - café da manhã,&nbsp;almoço e jantar. Por 30 dias</span></span></p>
', 'Ana Carolina Candia Barra', '2025-12-15 16:45:20'),
  ('02225692041', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso interno<br />
<br />
1-<br />
Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................150mg<br />
Vitamina A...........................................2500 ui</span>
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-12-15 16:46:21'),
  ('01515000532', 'prescricao', '<p><strong>Uso uso interno</strong></p>

<h2>Compra pela internet</h2>

<p>1-<br />
Ferro Ydrosolv® 30ml( marca Yosen)- ferro bisglicinato</p>

<p>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao ferro para não interferir na absorção.<br />
<br />
2-<br />
Ferro 50mL Ionquantic&nbsp; ( marca Fisioquantic)<br />
<br />
Tomar 15&nbsp;gotas direto na boca, junto ao ferro Ydrosolv, após o almoço.&nbsp;<br />
&nbsp;</p>

<p><strong>3-</strong></p>

<p>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></p>

<p><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></p>

<p><br />
4-<br />
ômega 3 - 990 de EPA e 660 de DHA&nbsp; - ( marca Vitafor PLUS)</p>

<p>Tomar 1 cap. 3x ao dia -&nbsp; café da manhã, almoço e jantar. Por 60 dias</p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2025-12-16 12:16:26'),
  ('01515000532', 'prescricao', '<p><strong>1- Ação ansiolítica e reguladora do humor&nbsp;</strong></p>
Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66).......................................300mg<br />
Magnolia officinalis extrato padronizado...............................................200mg<br />
Crocus sativus extrato padronizado 2% safranal.................................30mg<br />
L-teanina..............................................................................................200mg<br />
Magnésio bisglicinato elementar..........................................................150mg<br />
zinco quelado elementar........................................................................20mg<br />
Vitamina B6 (P-5-P)..............................................................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mc)<br />
<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00,&nbsp;<strong>após refeições.&nbsp; por 60 dias.<br />
<br />
2-</strong><br />
<br />
Clereto de metiltionínio................................30mg
<p>Tomar 1 dose pela manhã, por 60 dias.<br />
<br />
3-</p>

<p>Betaina HCl.............................................300 mg<br />
Mande 60 doses.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar.</p>

<p>4-<br />
<br />
Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................50mg</p>

<p>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose&nbsp;antes das duas principais refeições do dia. Por 60 dias</p>
', 'Ana Carolina Candia Barra', '2025-12-16 12:22:31'),
  ('08369131670', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000....................................................500g</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose ( 25 a 60g) 1 x ao dia, de manhã ou a noite diluído em 1&nbsp;copo d''àgua.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>OBS: A dose depende a atividade intestinal, podendo aumentar ou reduzir a dose conforme o funcionamento intestinal.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-12-16 12:51:35'),
  ('08158093604', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno - compra pela internet</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Ferro Ydrosolv&nbsp;30ml ( marca yosen)&nbsp;</span></span></h1>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.<br />
<br />
3-&nbsp;</span>Vitamina C Ydrosolv 30ml ( marcaYosen)<br />
<br />
tomar 10 gotas&nbsp;<span style=&quot;font-size:14px&quot;>diluido em um pouco de água após o almoço.</span><br />
<br />
<span style=&quot;font-size:14px&quot;>2-<br />
<br />
Ferro ionquantic ( marca fisioquantic)<br />
<br />
Tomar 15 gotas junto com o ferro da yosen após o almoço.&nbsp;</span></span><br />
<br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2025-12-18 15:38:34'),
  ('08158093604', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso interno&nbsp;<br />
<br />
1-&nbsp;<br />
red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>2-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 25 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span><br />
<br />
3-<br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias (pré crio)<br />
<br />
4-<br />
Ômega 3 - 990 de EPA e 660 de DHA - ( vita for plus)<br />
<br />
Tomar 3 x ao dia , café da manhã, almoço e jantar</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-12-18 15:45:01'),
  ('43882749172', 'prescricao', '<p><br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;<br />
Por&nbsp;60 dias<br />
<br />
&nbsp;Uso Tópico<br />
<br />
ESTRADIOL TÓPICO TRANSDÉRMICO (BIOIDÊNTICO)</p>

<p>Estradiol bioidêntico 0,5 mg<br />
Veículo: Pentravan®<br />
Quantidade: 30 g</p>

<p>Posologia:<br />
Aplicar 1 dose (equivalente a 0,5 mg) à noite, em membros inferiores (face interna da coxa, alternando os lados), 1 vez ao dia.<br />
<br />
<br />
PROGESTERONA MICRONIZADA 100 MG – JUNNO®&nbsp; OU MANIPULADO</p>

<p>Progesterona micronizada 100 mg<br />
Apresentação: cápsulas gelatinosas</p>

<p>Posologia:<br />
Tomar 1 cápsula por via oral à noite, ao deitar, uso contínuo.<br />
<br />
<br />
ESTRIOL VAGINAL + LACTOBACILOS (SUPORTE PARA CANDIDÍASE RECORRENTE)</p>

<p>Óvulos vaginais manipulados contendo:<br />
Estriol 0,5 mg<br />
Lactobacillus crispatus<br />
Lactobacillus rhamnosus<br />
Lactobacillus reuteri</p>

<p>Quantidade: 30&nbsp;óvulos</p>

<p>Posologia:<br />
Introduzir 1 óvulo vaginal à noite, ao deitar, por 30&nbsp;&nbsp;dias consecutivos.<br />
<br />
Após o esquema inicial, manutenção com 1 óvulo 2 vezes por semana, conforme resposta clínica.&nbsp;</p>
', 'Danielle Candia Barra', '2025-12-22 09:59:43'),
  ('43882749172', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;
<p><br />
Por&nbsp;60 dias<br />
<br />
&nbsp;Uso Tópico<br />
<br />
ESTRADIOL TÓPICO TRANSDÉRMICO (BIOIDÊNTICO)</p>

<p>Estradiol bioidêntico 0,5 mg<br />
Veículo: Pentravan®<br />
Quantidade: 30 g</p>

<p>Posologia:<br />
Aplicar 1 dose (equivalente a 0,5 mg) à noite, em membros inferiores (face interna da coxa, alternando os lados), 1 vez ao dia.<br />
<br />
<br />
PROGESTERONA MICRONIZADA 100 MG – JUNNO®&nbsp; OU MANIPULADO</p>

<p>Progesterona micronizada 100 mg<br />
Apresentação: cápsulas gelatinosas</p>

<p>Posologia:<br />
Tomar 1 cápsula por via oral à noite, ao deitar, uso contínuo.<br />
<br />
<br />
ESTRIOL VAGINAL + LACTOBACILOS (SUPORTE PARA CANDIDÍASE RECORRENTE)</p>

<p>Óvulos vaginais manipulados contendo:<br />
Estriol 0,5 mg<br />
Lactobacillus crispatus<br />
Lactobacillus rhamnosus<br />
Lactobacillus reuteri</p>

<p>Quantidade: 30&nbsp;óvulos</p>

<p>Posologia:<br />
Introduzir 1 óvulo vaginal à noite, ao deitar, por 30&nbsp;&nbsp;dias consecutivos.<br />
<br />
Após o esquema inicial, manutenção com 1 óvulo 2 vezes por semana, conforme resposta clínica.&nbsp;</p>
', 'Danielle Candia Barra', '2025-12-22 10:00:21'),
  ('43882749172', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;
<p>Por&nbsp;60 dias<br />
<br />
&nbsp;Uso Tópico<br />
<br />
ESTRADIOL TÓPICO TRANSDÉRMICO (BIOIDÊNTICO)</p>

<p>Estradiol bioidêntico 0,5 mg<br />
Veículo: Pentravan®<br />
Quantidade: 30 g</p>

<p>Posologia:<br />
Aplicar 1 dose (equivalente a 0,5 mg) à noite, em membros inferiores (face interna da coxa, alternando os lados), 1 vez ao dia.<br />
<br />
<br />
PROGESTERONA MICRONIZADA 100 MG – JUNNO®&nbsp; OU MANIPULADO</p>

<p>Progesterona micronizada 100 mg<br />
Apresentação: cápsulas gelatinosas</p>

<p>Posologia:<br />
Tomar 1 cápsula por via oral à noite, ao deitar, uso contínuo.<br />
<br />
<br />
ESTRIOL VAGINAL + LACTOBACILOS (SUPORTE PARA CANDIDÍASE RECORRENTE)</p>

<p>Óvulos vaginais manipulados contendo:<br />
Estriol 0,5 mg<br />
Lactobacillus crispatus<br />
Lactobacillus rhamnosus<br />
Lactobacillus reuteri</p>

<p>Quantidade: 30&nbsp;óvulos</p>

<p>Posologia:<br />
Introduzir 1 óvulo vaginal à noite, ao deitar, por 30&nbsp;&nbsp;dias consecutivos.<br />
<br />
Após o esquema inicial, manutenção com 1 óvulo 2 vezes por semana, conforme resposta clínica.&nbsp;</p>
', 'Danielle Candia Barra', '2025-12-22 10:01:27'),
  ('43882749172', 'prescricao', '<ol>
	<li>
	<p>VITAMINA D3 + K2 (MK-7)</p>
	</li>
</ol>

<p>Vitamina D3 (colecalciferol) 5.000 UI<br />
Vitamina K2 (menaquinona-7) 100 mcg</p>

<p>Posologia:<br />
Tomar 1 cápsula ao dia, junto a uma refeição principal.</p>

<hr />
<ol start=&quot;2&quot;>
	<li>
	<p>SELÊNIO</p>
	</li>
</ol>

<p>Selênio quelato (L-selenometionina) 100 mcg</p>

<p>Posologia:<br />
Tomar 1 cápsula ao dia, pela manhã.</p>

<hr />
<ol start=&quot;3&quot;>
	<li>
	<p>ZINCO</p>
	</li>
</ol>

<p>Zinco quelato 15 mg</p>

<p>Posologia:<br />
Tomar 1 cápsula ao dia, após o almoço.</p>

<hr />
<ol start=&quot;4&quot;>
	<li>
	<p>COENZIMA Q10</p>
	</li>
</ol>

<p>Coenzima Q10 (ubiquinona ou ubiquinol) 100 mg</p>

<p>Posologia:<br />
Tomar 1 cápsula ao dia, junto a refeição com gordura.</p>

<hr />
<p>Observações médicas:<br />
– Suplementação com objetivo de suporte imunológico, antioxidante, mitocondrial e hormonal.<br />
– Manter uso conforme orientação médica e reavaliar níveis laboratoriais periodicamente.</p>
', 'Danielle Candia Barra', '2025-12-22 10:02:56'),
  ('43882749172', 'prescricao', '<p>Solicito a realização dos seguintes exames:</p>

<ol>
	<li>
	<p>URINA TIPO I (EAS)</p>
	</li>
	<li>
	<p>UROCULTURA COM ANTIBIOGRAMA</p>
	</li>
</ol>

<hr />
<p>Indicação clínica:<br />
Avaliação de infecção urinária e diagnóstico diferencial de prurido urogenital recorrente em paciente pós-menopausa.</p>
', 'Danielle Candia Barra', '2025-12-22 10:03:54'),
  ('43882749172', 'prescricao', '<p>Solicito a realização dos seguintes exames:</p>

<ol>
	<li>
	<p>URINA TIPO I (EAS)</p>
	</li>
	<li>
	<p>UROCULTURA COM ANTIBIOGRAMA</p>
	</li>
</ol>

<hr />
<p>Indicação clínica:<br />
Avaliação de infecção urinária e diagnóstico diferencial de prurido urogenital recorrente em paciente pós-menopausa.</p>
', 'Danielle Candia Barra', '2025-12-22 10:03:54'),
  ('43882749172', 'prescricao', '<p>Solicito a realização dos seguintes exames:</p>

<ol>
	<li>
	<p>ULTRASSONOGRAFIA TRANSVAGINAL</p>
	</li>
	<li>
	<p>ULTRASSONOGRAFIA DAS MAMAS (BILATERAL)</p>
	</li>
</ol>

<hr />
<p>Indicação clínica:<br />
Avaliação ginecológica e mamária para controle hormonal em paciente pós-menopausa, em uso de terapia hormonal bioidêntica.</p>
', 'Danielle Candia Barra', '2025-12-22 10:05:12'),
  ('77394062287', 'prescricao', '<h2><strong>1. FÓRMULA BASE PRÉ-CONCEPÇÃO (Multinutriente Funcional)</strong></h2>

<p><em>(núcleo obrigatório antes da gestação)</em></p>

<p><strong>Ativos por cápsula:</strong></p>

<ul>
	<li>
	<p>Metilfolato (5-MTHF) – <strong>400 mcg</strong></p>
	</li>
	<li>
	<p>Vitamina B12 (Metilcobalamina) – <strong>500 mcg</strong></p>
	</li>
	<li>
	<p>Vitamina B6 (Piridoxal-5-fosfato) – <strong>10 mg</strong></p>
	</li>
	<li>
	<p>Vitamina B2 (Riboflavina-5-fosfato) – <strong>5 mg</strong></p>
	</li>
	<li>
	<p>Vitamina B1 (Tiamina) – <strong>5 mg</strong></p>
	</li>
	<li>
	<p>Colina bitartarato – <strong>200 mg</strong></p>
	</li>
	<li>
	<p>Inositol – <strong>200 mg</strong></p>
	</li>
	<li>
	<p>Iodo (iodeto de potássio) – <strong>150 mcg</strong></p>
	</li>
	<li>
	<p>Selênio quelado – <strong>100 mcg</strong></p>
	</li>
	<li>
	<p>Zinco quelado – <strong>15 mg</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
? Tomar <strong>1 cápsula pela manhã</strong>, junto ao café da manhã.<br />
<strong>Apresentação:</strong> 60 cápsulas gastro-resistentes.</p>

<p>&nbsp;<strong>Por que essa fórmula é chave:</strong></p>

<ul>
	<li>
	<p>Suporte epigenético e fechamento do tubo neural</p>
	</li>
	<li>
	<p>Apoio tireoidiano seguro</p>
	</li>
	<li>
	<p>Fertilidade feminina</p>
	</li>
	<li>
	<p>Redução de risco de abortamento precoce</p>
	</li>
	<li>
	<p>Compatível com uso de SSRI</p>
	</li>
</ul>

<hr />
<h2>&nbsp;<strong>2. FÓRMULA INTESTINAL + MINERALIZAÇÃO (Constipação + Fósforo)</strong></h2>

<p><em>(fundamental neste caso)</em></p>

<p><strong>Ativos por dose:</strong></p>

<ul>
	<li>
	<p>Magnésio bisglicinato – 1<strong>00 mg</strong><br />
	Magnésio Glicina&nbsp;&nbsp;– 1<strong>00 mg</strong></p>
	</li>
	<li>
	<p>Fósforo (fosfato orgânico) – <strong>250 mg</strong></p>
	</li>
	<li>
	<p>Citrato de potássio – <strong>100 mg</strong></p>
	</li>
	<li>
	<p>Taurina – <strong>300 mg</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
? Tomar <strong>1 cápsula à noite</strong>, após o jantar.<br />
<strong>Apresentação:</strong> 60 cápsulas gastro-resistentes.</p>

<p>&nbsp;<strong>Objetivos:</strong></p>

<ul>
	<li>
	<p>Corrigir fósforo baixo</p>
	</li>
	<li>
	<p>Melhorar ATP, energia celular e metabolismo</p>
	</li>
	<li>
	<p>Regular trânsito intestinal</p>
	</li>
	<li>
	<p>Suporte muscular e reprodutivo</p>
	</li>
</ul>

<hr />
<h2><strong>3. FÓRMULA INTESTINAL FUNCIONAL (Eixo Intestino–Hormônio)</strong></h2>

<p><em>(sem probióticos agressivos nesta fase)</em></p>

<p><strong>Ativos por dose:</strong></p>

<ul>
	<li>
	<p>L-glutamina – <strong>500 mg</strong></p>
	</li>
	<li>
	<p>N-acetil-D-glicosamina – <strong>250 mg</strong></p>
	</li>
	<li>
	<p>Zinco carnosina – <strong>37,5 mg</strong></p>
	</li>
	<li>
	<p>Quercetina – <strong>200 mg</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
? Tomar <strong>1 cápsula antes do jantar</strong>.<br />
<strong>Apresentação:</strong> 60 cápsulas gastro-resistentes.</p>

<p>&nbsp;<strong>Por que usar:</strong></p>

<ul>
	<li>
	<p>Melhora absorção de nutrientes</p>
	</li>
	<li>
	<p>Reduz inflamação intestinal subclínica</p>
	</li>
	<li>
	<p>Essencial para fertilidade e imunotolerância gestacional</p>
	</li>
</ul>

<hr />
<h2>&nbsp;<strong>4. VITAMINA D3 + K2 (Isolada e Segura)</strong></h2>

<p><em>(ajustada para pré-concepção)</em></p>

<ul>
	<li>
	<p>Vitamina D3 – <strong>6.000 UI</strong></p>
	</li>
	<li>
	<p>Vitamina K2 MK-7 – <strong>100 mcg</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
? Tomar <strong>1 cápsula ao dia</strong>, com a maior refeição.</p>

<hr />
<h2>&nbsp;<strong>5. ÔMEGA-3 DE ALTA PUREZA (Isolado)</strong></h2>

<p><em>(obrigatório para fertilidade)</em></p>

<ul>
	<li>
	<p>DHA – <strong>500 mg</strong></p>
	</li>
	<li>
	<p>EPA – <strong>250 mg</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong><br />
? Tomar <strong>1 cápsula ao dia</strong>, junto ao almoço.</p>
', 'Danielle Candia Barra', '2025-12-22 11:45:38'),
  ('77394062287', 'prescricao', '<p>Solicito a realização dos seguintes exames de imagem:</p>

<ol>
	<li>
	<p>Ultrassonografia de mamas bilateral<br />
	– Avaliação de parênquima mamário, linfonodos axilares e rastreio de alterações estruturais.</p>
	</li>
	<li>
	<p>Ultrassonografia transvaginal<br />
	– Avaliação de útero, endométrio e anexos ovarianos, com foco em seguimento ginecológico pós-menopausa e queixas vulvovaginais recorrentes.</p>
	</li>
	<li>
	<p>Ultrassonografia de tireoide<br />
	– Avaliação morfológica da glândula tireoide, pesquisa de nódulos e alterações estruturais.</p>
	</li>
</ol>

<hr />
<p>Observações clínicas:<br />
Paciente em menopausa (DUM há 4 anos), em uso de terapia hormonal, com histórico de sintomas urogenitais e necessidade de rastreio ginecológico e endocrinológico de rotina.</p>
', 'Danielle Candia Barra', '2025-12-22 11:47:06'),
  ('77394062287', 'prescricao', '<p>Solicito a realização dos seguintes exames de imagem:</p>

<ol>
	<li>
	<p>Ultrassonografia de mamas bilateral<br />
	– Avaliação de parênquima mamário, linfonodos axilares e rastreio de alterações estruturais.</p>
	</li>
	<li>
	<p>Ultrassonografia transvaginal<br />
	– Avaliação de útero, endométrio e anexos ovarianos, com foco em seguimento ginecológico pós-menopausa e queixas vulvovaginais recorrentes.</p>
	</li>
	<li>
	<p>Ultrassonografia de tireoide<br />
	– Avaliação morfológica da glândula tireoide, pesquisa de nódulos e alterações estruturais.</p>
	</li>
</ol>
', 'Danielle Candia Barra', '2025-12-22 11:53:24'),
  ('57968799104', 'prescricao', '<p><small><strong>Uso interno</strong></small></p>

<p><small>1-</small></p>

<p><small>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Coenzima Q10..................................................... 50 mg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina.................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde<br />
<br />
2-</small></p>
<small>Vitamina D 3..........................................5000ui<br />
Vitamina K2 MK7.......................................150mg</small>

<p><small>30 pastilhas</small></p>

<p><small>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;<br />
<br />
3-</small></p>
<small>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
bergamota extrato seco............................600mg<br />
Ácido alfa Lipóico....................................300 mg</small>

<p><small>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.<br />
<br />
4-</small></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Berberina ..............................................250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2025-12-22 12:04:34'),
  ('11783460130', 'prescricao', '<h2><strong>1. EIXO ÓSSEO + NEUROMUSCULAR (proteção contra perda óssea e sarcopenia)</strong></h2>

<h3>&nbsp;Fórmula 1 – Suporte Ósseo Funcional</h3>

<p><strong>Cápsulas gastro-resistentes</strong></p>

<ul>
	<li><strong>Vitamina D3 4000 unidades&nbsp;</strong></li>
	<li>
	<p>Vitamina K2 MK-7 ............... <strong>100 mcg</strong></p>
	</li>
	<li>
	<p>Magnésio bisglicinato .......... <strong>100 mg</strong></p>
	</li>
	<li>
	<p>Boro quelado .................. <strong>1 mg</strong></p>
	</li>
	<li>
	<p>Silício orgânico (Exsynutriment®) .... <strong>100 mg</strong></p>
	</li>
</ul>

<p>&nbsp;<strong>Posologia:</strong> 1 cápsula ao dia, junto ao almoço</p>

<p>&nbsp;<em>Justificativa:</em><br />
– Direciona cálcio ao osso<br />
– Reduz risco de calcificação vascular<br />
– Auxilia na remodelação óssea acelerada (FA elevada)<br />
– Seguro em nefrolitíase prévia</p>

<hr />
<h2>&nbsp;<strong>2. EIXO NEUROLÓGICO / COGNITIVO / ANSIOLÍTICO NATURAL</strong></h2>

<p><em>(Importante pelo uso crônico de alprazolam)</em></p>

<h3>&nbsp;Fórmula 2 – Neuroproteção e Ansiedade Funcional</h3>

<p><strong>Cápsulas gastro-resistentes</strong></p>

<ul>
	<li>
	<p>Magnésio L-treonato ............ <strong>500 mg</strong></p>
	</li>
	<li>
	<p>L-teanina ...................... <strong>200 mg</strong></p>
	</li>
	<li>
	<p>Taurina ........................ <strong>500 mg</strong></p>
	</li>
</ul>

<p>&nbsp;<strong>Posologia:</strong><br />
1 cápsula à noite, 30–60 min antes de dormir</p>

<p>&nbsp;<em>Justificativa:</em><br />
– Auxilia cognição e memória<br />
– Reduz hiperexcitabilidade neuronal<br />
– Pode permitir <strong>redução gradual futura do benzodiazepínico</strong><br />
– Seguro cardiovascularmente</p>

<hr />
<h2>&nbsp;<strong>3. EIXO METABÓLICO (pré-diabetes senil, sem hipoglicemia)</strong></h2>

<h3>&nbsp;Fórmula 3 – Sensibilidade Insulínica Leve</h3>

<p><strong>Cápsulas gastro-resistentes</strong></p>

<ul>
	<li>
	<p>Cromo picolinato ............... <strong>200 mcg</strong></p>
	</li>
	<li>
	<p>Ácido alfa-lipóico ............. <strong>300 mg</strong></p>
	</li>
</ul>

<p>&nbsp;<strong>Posologia:</strong><br />
1 cápsula antes do almoço</p>

<p>&nbsp;<em>Justificativa:</em><br />
– Reduz progressão de HbA1c<br />
– Não provoca hipoglicemia<br />
– Seguro para idosos e função renal</p>

<hr />
<h2>&nbsp;<strong>4. EIXO ANTIOXIDANTE / INFLAMAÇÃO DE BAIXO GRAU</strong></h2>

<p><em>(Ferritina elevada não carencial)</em></p>

<h3>&nbsp;Fórmula 4 – Modulação Inflamatória Suave</h3>

<p><strong>Cápsulas gastro-resistentes</strong></p>

<ul>
	<li>
	<p>Curcumina fitossomada .......... <strong>250 mg</strong></p>
	</li>
	<li>
	<p>Resveratrol .................... <strong>100 mg</strong></p>
	</li>
</ul>

<p>&nbsp;<strong>Posologia:</strong><br />
1 cápsula ao dia, junto ao almoço</p>

<p>&nbsp;<em>Justificativa:</em><br />
– Auxilia redução de inflamação crônica<br />
– Pode ajudar na modulação da ferritina<br />
– Proteção vascular e cognitiva</p>
', 'Danielle Candia Barra', '2026-01-05 10:26:36'),
  ('11783460130', 'prescricao', '<h2><strong>PEDIDO DE EXAME – ULTRASSOM DE ABDÔMEN TOTAL</strong></h2>

<p><strong>Paciente:</strong> Clemência de Brito Neves<br />
<strong>Idade:</strong> 86 anos<br />
<strong>Solicitante:</strong> Dra. Danielle Candia Barra<br />
<strong>CRM-DF:</strong> 22677</p>

<p><strong>Exame solicitado:</strong><br />
? <strong>Ultrassonografia de Abdômen Total</strong></p>

<p><strong>Indicação clínica:</strong><br />
– Avaliação abdominal global<br />
– Antecedente de <strong>nefrolitíase</strong><br />
– <strong>Ferritina elevada</strong><br />
– Avaliação hepática, biliar, pancreática e renal<br />
– Rastreamento de alterações estruturais compatíveis com a faixa etária</p>

<p><strong>Observações:</strong><br />
– Avaliar fígado, vias biliares, pâncreas, baço, rins, adrenais e grandes vasos<br />
– Atentar para presença de cálculos renais, alterações parenquimatosas e sinais de congestão hepática</p>
', 'Danielle Candia Barra', '2026-01-05 10:28:29'),
  ('11783460130', 'prescricao', '<h3><strong>Ultrassonografia Doppler Venosa de Membros Inferiores (MMII)</strong></h3>

<p><strong>Indicação clínica:</strong><br />
– Avaliação do sistema venoso profundo e superficial<br />
– Investigação de insuficiência venosa crônica<br />
– Rastreamento de trombose venosa (aguda ou prévia), conforme achados<br />
– Avaliação vascular em paciente idosa</p>

<hr />
<h3>? <strong>Ultrassonografia Doppler Arterial de Membros Inferiores (MMII)</strong></h3>

<p><strong>Indicação clínica:</strong><br />
– Avaliação do sistema arterial dos MMII<br />
– Pesquisa de doença arterial periférica<br />
– Avaliação do fluxo arterial, presença de estenoses ou placas ateroscleróticas<br />
– Estratificação de risco vascular em idosa</p>

<hr />
<p><strong>Observações:</strong><br />
– Avaliar bilateralmente<br />
– Descrever fluxo, compressibilidade, refluxo venoso e índices hemodinâmicos quando aplicável</p>
', 'Danielle Candia Barra', '2026-01-05 10:36:50'),
  ('79453430153', 'prescricao', '<p>compra na internet<br />
<br />
1-</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã. Iniciar após 21&nbsp;dias na aplicação IM.&nbsp;</strong></span></span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-01-08 14:07:59'),
  ('79453430153', 'prescricao', '<p><strong>Uso interno<br />
<br />
1-</strong></p>
Citrus Sinensis........................................200mg<br />
Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg
<p>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias. ( pós procedimento de criomodelagem)<br />
<br />
2</p>
Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
picolinato de cromo ...............................350 mcg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg
<p>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias (inicio pré procedimento de criomodelagem)<br />
<br />
3-</p>
Glucovantage...........................................100mg

<p>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias ( início pré&nbsp;procedimento de criomodelagem)</p>
', 'Ana Carolina Candia Barra', '2026-01-08 15:28:50'),
  ('79453430153', 'prescricao', 'Uso oral<br />
<br />
1-<br />
PEG 4000&nbsp;<br />
Tomar de 25 a 40 g por dia ( conforme orientação profissional) diluido em um copo de água.&nbsp;<br />
<br />
2-<br />
Lactobacillus casei 2 Bilhões UFC<br />
Lactobacillus bifidum 1 Bilhão UFC<br />
Lactobacillus acidophillus 1 Bilhão UFC<br />
Glutamina 300 mg<br />
<br />
Mande 90 cápsulas.<br />
Tomar uma dose uma vez ao dia, antes de<br />
dormir por três meses.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-01-08 15:36:19'),
  ('25471040325', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Coenzima Q10..................................................... 50 mg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina.................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ashwagandha (Withania somnifera) extrato padronizado 5% withanolídeos500mg<br />
Tomar 2 x ao dia, lanche da manhã e da tarde. Por 60 dias.&nbsp;<br />
&nbsp;</span><br />
3-<br />
<br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2026-01-09 11:57:04'),
  ('38678691115', 'prescricao', '<p>Perfil hormonal sexual:</p>

<ul>
	<li>
	<p>Estradiol</p>
	</li>
	<li>
	<p>Progesterona</p>
	</li>
	<li>
	<p>Testosterona total</p>
	</li>
	<li>
	<p>Testosterona livre</p>
	</li>
	<li>
	<p>SHBG</p>
	</li>
	<li>
	<p>DHEA-S</p>
	</li>
	<li>
	<p>FSH</p>
	</li>
	<li>
	<p>LH</p>
	</li>
</ul>

<p>Perfil lipídico avançado:</p>

<ul>
	<li>
	<p>Apolipoproteína A1 (Apo A1)</p>
	</li>
	<li>
	<p>Apolipoproteína B (Apo B)</p>
	</li>
	<li>
	<p>Relação Apo B / Apo A1</p>
	</li>
</ul>

<p>Diagnóstico (CID):<br />
N95.1 – Sintomas do climatério e menopausa<br />
E78.5 – Hiperlipidemia não especificada<br />
E34.9 – Transtorno endócrino, não especificado</p>
', 'Danielle Candia Barra', '2026-01-12 10:05:05'),
  ('26318270159', 'prescricao', '<p>Hemograma completo</p>

<p>Perfil glicídico e insulínico<br />
Glicemia de jejum<br />
Insulina de jejum<br />
Hemoglobina glicada (HbA1c)<br />
HOMA-IR (cálculo)</p>

<p>Perfil lipídico<br />
Colesterol total<br />
HDL<br />
LDL<br />
Triglicerídeos<br />
Apolipoproteína A1<br />
Apolipoproteína B<br />
Relação Apo B / Apo A1</p>

<p>Função hepática<br />
TGO (AST)<br />
TGP (ALT)<br />
GGT<br />
Fosfatase alcalina<br />
Bilirrubinas totais e frações</p>

<p>Função renal<br />
Ureia<br />
Creatinina<br />
Sódio<br />
Potássio<br />
Urina tipo I</p>

<p>Marcadores inflamatórios<br />
PCR ultrassensível<br />
Ferritina</p>

<p>Perfil hormonal metabólico<br />
TSH<br />
T4 livre<br />
T3 livre</p>

<p>Vitaminas e minerais<br />
Vitamina D (25-OH)<br />
Vitamina B12<br />
Ácido fólico<br />
Magnésio<br />
Zinco<br />
Selênio</p>

<p>Metabolismo cardiovascular<br />
Ácido úrico</p>
', 'Danielle Candia Barra', '2026-01-12 10:36:41'),
  ('10717573770', 'prescricao', 'uso oral<br />
<br />
1) Ômega 3 - 990 de EPA e 660 de DHA ( sugestão de matca, vitaFor Plus)<br />
<br />
tomar 1 dose 3 x ao dia, café da manhã, almoço e jantar.<br />
<br />
Uso contínuo&nbsp;', 'Ana Carolina Candia Barra', '2026-01-12 11:19:58'),
  ('12552898807', 'prescricao', '<h3>Fórmula para Suporte de Neurotransmissores e Vitalidade</h3>

<p><strong>Posologia:</strong> 1 cápsula 2x ao dia, longe das refeições</p>

<ul>
	<li>
	<p>L-Tirosina ................................. 500 mg</p>
	</li>
	<li>
	<p>Mucuna pruriens (15% L-Dopa) ...... 200 mg</p>
	</li>
	<li>
	<p>L-Citrulina ................................. 500 mg</p>
	</li>
	<li>
	<p>Acetil L-Carnitina ....................... 300 mg</p>
	</li>
	<li>
	<p>Taurina ..................................... 300 mg</p>
	</li>
	<li>
	<p>Fosfatidilserina ........................... 100 mg</p>
	</li>
</ul>

<hr />
<h3>&nbsp;2. Fórmula para Testosterona, Libido e Performance</h3>

<p><strong>Posologia:</strong> 1 cápsula ao jantar</p>

<ul>
	<li>
	<p>Tribulus terrestris (45% saponinas) .... 500 mg</p>
	</li>
	<li>
	<p>Fadogia agrestis .............................. 250 mg</p>
	</li>
	<li>
	<p>Ashwagandha KSM-66 ..................... 300 mg</p>
	</li>
	<li>
	<p>Zinco quelado .................................. 25 mg</p>
	</li>
	<li>
	<p>Magnésio Bisglicinato ....................... 150 mg</p>
	</li>
	<li>
	<p>Tadalafila ........................................ 3&nbsp;mg</p>
	</li>
</ul>

<h3>&nbsp;3. Fórmula de Suporte Metabólico e Vitamínico</h3>

<p><strong>Posologia:</strong> 1 cápsula pela manhã com o desjejum</p>

<ul>
	<li>
	<p>Vitamina D3 ...................................... 5.000 UI</p>
	</li>
	<li>
	<p>Vitamina K2 (MK-7) .......................... 100 mcg</p>
	</li>
	<li>
	<p>Coenzima Q10 .................................. 100 mg</p>
	</li>
	<li>
	<p>PQQ ................................................ 20 mg</p>
	</li>
	<li>
	<p>Complexo B funcional:</p>

	<ul>
		<li>
		<p>B1 (Tiamina) .............. 50 mg</p>
		</li>
		<li>
		<p>B2 (Riboflavina) ........ 25 mg</p>
		</li>
		<li>
		<p>B3 (Niacina) .............. 50 mg</p>
		</li>
		<li>
		<p>B5 (Ácido Pantotênico) 100 mg</p>
		</li>
		<li>
		<p>B6 (P-5-P) ................. 20 mg</p>
		</li>
		<li>
		<p>Inositol ..................... 200 mg</p>
		</li>
		<li>
		<p>Colina ....................... 100 mg</p>
		</li>
		<li>
		<p>B12 (Metilcobalamina) 1000 mcg</p>
		</li>
	</ul>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-01-12 11:59:16'),
  ('83206540330', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>

<p>1-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Betaina HCl ...............................................................................300 mg<br />
Mande 60 doses.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p>&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-01-14 16:55:00'),
  ('86414526134', 'prescricao', 'Uso oral<br />
<br />
1 - Antioxidante e quelante funcional<br />
<br />
N- acetilsiteína ( NAC) - 600mg<br />
Vitaminba C bufferizada - 500mg<br />
Ácido Alfda lipoico - 300mg<br />
<br />
tomnar 1 caps. 2 x ao dia m,anhã em jejum e final da tarde ( longe das refeições principais)<br />
<br />
2- Suporte hepático e aumento de glutationa&nbsp;<br />
<br />
Silimarina ( padronizada 70 - 80%) - 300mg<br />
Curcumina BCM-95 - 500mg<br />
Vitamina E ( tocoferóis mistos) - 200ui<br />
<br />
tomar 1 caps. 1 x ao dia no almoço ou jantar ( junto com gordura boa)<br />
<br />
3 - Mitocondria e antiinflamação<br />
<br />
Coenzima Q10 ( ubiquinol) - 200mg<br />
Selênio&nbsp; ( L seleniometionina) - 100mcg<br />
zinco bisglicinato - 25 mg<br />
cobre quelado - 1 mg<br />
vitamina B6 ( P-5-P) - 25mg<br />
<br />
tomar 1 caps. a noite junto com a formula HPA<br />
<br />
4- Eixo HPA<br />
<br />
Ashwagandha ( KSM-66 ou sensoril) 300mg<br />
magnésio bisglicinato 400mg<br />
vitamina B5 ( pantotenato) 100mg<br />
<br />
tomar 1 caps. à noite&nbsp; 30 a 60 min. antes de dormir.&nbsp;<br />
<br />
5-<br />
ômega 3 990 EPA e 660 DHA ( vitafor plus)<br />
<br />
Tomar 3 x ao dia no café da manhã, almoço e jantar.<br />
<br />
6 - suporte sono reparador ( se sentir necessidade)<br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release..................................3mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2026-01-15 14:48:03'),
  ('86414526134', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Clereto de metiltionínio................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose pela manhã, por 30 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-01-16 10:50:14'),
  ('02536963136', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso oral<br />
<br />
1-<br />
<br />
Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose,2 x ao dia nos lanches antes do almoço e jantar.<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( marca Vitafor plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã,&nbsp;&nbsp;almoço e jantar. Por 60 dias</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-01-21 10:52:51'),
  ('15433080153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Betaina HCl ..................................................................300 mg<br />
<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar. Por 60 dias.</span><br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2- (protetor gastrico e muco)</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa.............................................................. 500 mg<br />
Alfafa extrato seco........................................................... 500 mg<br />
Uncaria tomentosa .............................................................250 mg<br />
Coenzima Q10................................................................... 50 mg<br />
Mucosave® (Opuntia ficus indica) FG.............................................400mg</span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche da tarde. Por 60 dias<br />
<br />
3- Enzimas digestivas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia ( almoço e jantar). Por 60 dias<br />
<br />
4- ( probiótico desparasitação)</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus casei 2 Bilhões UFC<br />
Lactobacillus bifidum 1 Bilhão UFC<br />
Lactobacillus acidophillus 1 Bilhão UFC<br />
Streptococcus faecium 1 Bilhão UFC<br />
Inulina 150 mg<br />
<br />
tomar uma dose uma vez ao dia, antes de<br />
dormir por 60 dias.<br />
<br />
5- ( Polivitamínico - emagrecimento)</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, 3&nbsp;x ao dia no café da mamnhã, no lanche da mamnhã, e no lanhce da tarde<br />
Por 90 dias.<br />
<br />
6-<br />
Ômega 3 - mega DHA ( Vitafor )<br />
<br />
Tomar 3 x ao dia no café da manhã, no almoço e no jantar. Por 90 dias.<br />
<br />
7-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Melatonina Time release................................2,5mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula. Por 60 dias<br />
<br />
8-</span><br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2...........................................100mg<br />
Vitamina A...........................................1250ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>60 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver 2&nbsp;pastilhas sublingual uma vez ao dia após o&nbsp;almoço.&nbsp;</span><br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-01-21 11:25:51'),
  ('62606465342', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso oral<br />
<br />
1- manipulação<br />
<br />
Vitamina A 1.700 UI<br />
Vitamina C (como ácido ascórbico) 135 mg<br />
Vitamina D3 (como Colecalciferol) 275 UI<br />
Vitamina E (como acetato de d-alfa-tocoferil) 20 UI<br />
Tiamina (como Cloridrato de Tiamina) 2 mg<br />
Riboflavina (como Riboflavina-5-fosfato) 2 mg<br />
Niacina (como niacinamida) 10 mg<br />
Vitamina B6 (como cloridrato de piridoxina) 2 mg<br />
Ácido fólico 135 mcg<br />
Vitamina B12 (como metilcobalamina) 6 mcg<br />
Biotina (como d-biotina) 65 mcg<br />
Ácido Pantotênico (como d-Pantenol) 7 mg<br />
Cálcio quelato 55 mg<br />
Iodo (como Iodeto de Potássio) 50 mcg<br />
Magnésio Quelato 15 mg<br />
Zinco Quelato 5 mg<br />
Selênio (como L-selenometionina) 35 mcg<br />
Manganês Quelato 1,5 mg<br />
Cromo (como picolinato de cromo) 7 mcg<br />
Potássio (como citrato de potássio) 15 mg<br />
Inositol 20 mg<br />
Bitartarato de Colina 20 mg<br />
<br />
Suspensão livre de açúcar qsp 10 mL<br />
(sabor morango)<br />
Mande 250 mL.<br />
<br />
Tomar 15 ml uma vez ao dia no café da manhã.<br />
<br />
2- compra na internet</span>
<h1><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>ÔMEGA KIDS SUSPENSÃO - DHA 200 / EPA 500 - 120ml ( marca união magistral)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;>tomar 2 ml 2 x ao dia no café da manhã e no jantar</span><br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-01-21 12:16:11'),
  ('78380782615', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1- ( Ansiedade e reguladora de humor)</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.<br />
<br />
2- ( Azul de metileno, mais foco e energia)</strong></span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Clereto de metiltionínio................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose após o almoço&nbsp;por 60 dias.<br />
<br />
3- (mais vontade e energia)</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Ashwagandha............................................150mg<br />
Urtica dióica..........................................250mg<br />
Maca peruana...........................................250mg<br />
Tribullus terrestris...................................200mg<br />
Fenogrego..............................................300mg<br />
Turkesterone............................................50mg<br />
Catuaba................................................100mg<br />
Gynostemma pentaphyllum.................................80mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>tomar uma dose duas vezes ao dia. Lanche da manhã e no lanche da tarde. Por 60 dias</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-01-26 11:31:11'),
  ('22352651115', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg<br />
Sais biliares.......................................... 300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose depois das duas principais refeições do dia. Por 60 dias<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Glucovantage............................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, 2 x ao9 dia no lanche da manhã e no lanche&nbsp;da tarde, Por 60 dias.</span><br />
<br />
3</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;</span></span>', 'Ana Carolina Candia Barra', '2026-01-27 14:15:34'),
  ('17333920500', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso Oral&nbsp;<br />
<br />
1-<br />
Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2MK7........................................120mg<br />
Vitamina A............................................2500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>30 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-01-27 16:31:56'),
  ('00813233100', 'prescricao', 'Uso oral<br />
<br />
1-<br />
<br />
Vitamina C ( ascorbato de sódio)........... 500mg<br />
Zinco bisglicinato.................................... 15mg<br />
Quercetina.............................................. 250mg<br />
Glutationa ..............................................250mg<br />
Oli-Ola ................................................... 50mg<br />
(extrato padronizado em hidroxitirosol )<br />
&nbsp;<br />
Tomar 2 x ao dia, pela manhã no lanche da manhã e a tarde no lanche da tarde.<br />
<br />
2-<br />
<br />
Di indol - 3 - carbinol .........................100mg<br />
Calcio D Glucarato............................ 500mg<br />
<br />
Tomar 1 dose 1 x ao dia no café da manhã ou no almoço. ( preferencialmente com uma refeição)<br />
<br />
3-<br />
<br />
Ômega 3 - 990 de EPA e 660 de DHA ( vita for Plus)<br />
<br />
Tomar 3 x ao dia , no café da manhã, no almoço e no jantar<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-01-28 16:58:45'),
  ('00813233100', 'prescricao', 'Uso tópico&nbsp;<br />
<br />
1-<br />
<br />
Sérum&nbsp; gel-creme oil free - uso noturno<br />
<br />
ácido tranexâmico - 2%<br />
Niacinamida - 4%<br />
Alfa arbutin 1 %<br />
Pantenol ( vit. B5) - 1%<br />
Alantoína - 0,2%<br />
<br />
Veículo (toque seco, não oclusivo)<br />
silicone volátil leve<br />
liver de alcool, fragrancia.<br />
<br />
Aplicar 1 pump em pele limpa e seca a noite.<br />
<br />
Inicia passando 3 x na semana, se tolerar bem e não arder pode passar diariamente.', 'Ana Carolina Candia Barra', '2026-01-28 17:05:16'),
  ('04734198152', 'prescricao', '<h2>Fórmula 1 – Modulação intestinal + mucosa + gastrite</h2>

<p><strong>(cápsulas gastro-resistentes | 90 doses)</strong></p>

<p>L-glutamina 500 mg</p>

<p>N-acetil-D-glicosamina 250 mg</p>

<p>Zinco quelato 15 mg</p>

<p>Carnosina zinco (zinco-carnosina) 37,5 mg</p>

<p>Boswellia serrata (20% AKBA) 50 mg</p>

<p>Quercetina 200 mg</p>

<p><strong>Posologia:</strong> 2 cápsulas 2x/dia antes das principais refeições</p>

<p>&nbsp;ação: reparo mucoso + anti-inflamatório local + barreira intestinal + suporte gastrite</p>

<hr />
<h2>Fórmula 2 – Digestão + hipocloridria + gases</h2>

<p><strong>(cápsulas gastro-resistentes | 60 doses)</strong></p>

<p>Betaína HCl 200 mg</p>

<p>Pepsina 50 mg</p>

<p>Pancreatina 150 mg</p>

<p>Bromelina 100 mg</p>

<p>Gengibre extrato seco 100 mg</p>

<p><strong>Posologia:</strong> 1 cápsula junto ao almoço e jantar</p>

<p>ação: melhora digestão proteica (coprológico +), reduz fermentação/gases</p>

<hr />
<h2>?? Fórmula 3 – Metabólica / resistência insulínica / triglicerídeos</h2>

<p><strong>(cápsulas gastro-resistentes | 120 doses)</strong></p>

<p>Berberina 400 mg</p>

<p>Mio-inositol 500 mg</p>

<p>Cromo picolinato 200 mcg</p>

<p>&nbsp;</p>

<p><strong>Posologia:</strong> 1 cápsula 2x/dia</p>

<p>&nbsp;ação: ? HOMA-IR, ? TG, ? sensibilidade insulínica, melhora ovulação futura</p>

<hr />
<h2>&nbsp;Fórmula 4 – Complexo B otimizado + energia + cabelo</h2>

<p><strong>(cápsulas gastro-resistentes | 90 doses)</strong></p>
Vitamina B1 (tiamina) 25 mg<br />
Vitamina B2 (riboflavina) 20 mg<br />
Vitamina B3 (niacinamida) 50 mg<br />
Vitamina B5 (pantotenato) 100 mg<br />
Vitamina B6 (P5P) 25 mg<br />
Metilcobalamina (B12) 1000 mcg<br />
Biotina 5 mg<br />
Inositol 100 mg<br />
Colina 50 mg
<p><strong>Posologia:</strong> 1 cápsula pela manhã</p>

<p>&nbsp;ação: B12 &gt; 800, suporte neurológico, ansiedade, queda capilar, fertilidade</p>

<hr />
<h2>&nbsp;Fórmula 5 – Antioxidante mitocondrial + anti-estresse</h2>

<p><strong>(cápsulas gastro-resistentes | 90 doses)</strong></p>

<p>Coenzima Q10 (ubiquinol) 100 mg</p>

<p>N-acetil-cisteína 150 mg</p>

<p>Vitamina C 250 mg</p>

<p>Selênio quelato 100 mcg</p>

<p><strong>Posologia:</strong> 1 cápsula 2x/dia</p>

<p>&nbsp;ação: ? cortisol, melhora energia mitocondrial, proteção ovariana</p>

<hr />
<h2>&nbsp;Suplementos isolados (padrão funcional)</h2>

<h3>Vitamina D3 + K2</h3>

<p>Vitamina D3 1000 UI</p>

<p>Vitamina K2 MK-7 150 mcg</p>

<p><strong>1x/dia com gordura</strong></p>

<hr />
<h3>Ômega 3 concentrado</h3>

<ul>
	<li>
	<p>EPA + DHA ? 2 g/dia</p>
	</li>
</ul>

<p>&nbsp;essencial para triglicerídeos + fertilidade + inflamação</p>
', 'Danielle Candia Barra', '2026-02-02 09:57:55'),
  ('72810572100', 'prescricao', '<h3>Ultrassonografia Transvaginal com Doppler Colorido</h3>

<p><strong>Indicação clínica:</strong><br />
Metrorragia (sangramento uterino anormal fora do período menstrual), associada a tonturas e oscilação hormonal, necessitando avaliação estrutural ginecológica.</p>

<p><strong>Objetivos do exame:</strong></p>

<p>Avaliar espessura e padrão endometrial</p>

<p>Pesquisar pólipos endometriais</p>

<p>Miomas uterinos (submucosos/intramurais)</p>

<p>Adenomiose</p>

<p>Cistos ovarianos ou massas anexiais</p>

<p>Avaliação do fluxo uterino/ovariano (Doppler)</p>

<p>Exclusão de causas estruturais de sangramento uterino anormal</p>

<p><strong>CID-10 sugerido:</strong><br />
N92.1 – Metrorragia<br />
(ou N93.8 – Outros sangramentos uterinos anormais, se preferir mais abrangente)</p>
', 'Danielle Candia Barra', '2026-02-02 10:52:58'),
  ('72810572100', 'prescricao', '<h2>Tratamento para 90 dias<br />
<br />
Suporte neuroadrenal</h2>

<p>Manipular (cápsulas gastro-resistentes):</p>

<ul>
	<li>
	<p>Rhodiola rosea 200 mg</p>
	</li>
	<li>
	<p>Panax ginseng 150 mg</p>
	</li>
	<li>
	<p>L-tirosina 500 mg</p>
	</li>
	<li>
	<p>Vitamina C 250 mg</p>
	</li>
	<li>
	<p>Magnésio bisglicinato 100 mg</p>
	</li>
</ul>

<p>1 cápsula manhã</p>

<p>&nbsp;melhora dopamina, noradrenalina, energia cerebral e pressão postural.&nbsp;<br />
<br />
<br />
&nbsp;</p>

<h2>Correção intestinal (importante para sintomas neurológicos)</h2>

<p>Você já utiliza um protocolo excelente para disbiose. Para ela, eu sugiro:</p>

<h3>Fórmula anti-inflamatória intestinal</h3>

<ul>
	<li>
	<p>Quercetina 400 mg</p>
	</li>
	<li>
	<p>Vitamina C 250 mg</p>
	</li>
	<li>
	<p>NAC 150 mg</p>
	</li>
	<li>
	<p>Zinco quelato 20 mg</p>
	</li>
	<li>
	<p>Boswellia 50 mg</p>
	</li>
</ul>

<p>&nbsp;1 dose 2x/dia</p>
', 'Danielle Candia Barra', '2026-02-02 11:00:04'),
  ('72810572100', 'prescricao', '<p><strong>ENCAMINHAMENTO TERAPÊUTICO</strong></p>

<p>Encaminho a paciente acima para <strong>acompanhamento com Acupuntura / Medicina Tradicional Chinesa</strong>, como terapia complementar adjuvante ao tratamento clínico atual.</p>

<h3>Indicações clínicas:</h3>

<p>Tonturas recorrentes</p>

<p>Instabilidade postural</p>

<p>Fadiga física e mental</p>

<p>Disfunção neurovegetativa (baixa resposta adrenérgica/catecolaminérgica)</p>

<p>Oscilação hormonal associada a metrorragia</p>

<p>Disbiose intestinal funcional</p>

<h3>Objetivos terapêuticos:</h3>

<p>Modulação do sistema nervoso autonômico</p>

<p>Melhora do tônus vascular e perfusão cerebral</p>

<p>Redução de tontura/vertigem</p>

<p>Equilíbrio do eixo hipotálamo–hipófise–adrenal</p>

<p>Regulação hormonal</p>

<p>Controle de estresse e melhora do sono</p>

<p>Suporte anti-inflamatório sistêmico</p>

<h3>Sugestão:</h3>

<p>Realizar <strong>1–2 sessões semanais por 8 a 12 semanas</strong>, com reavaliação clínica subsequente.</p>

<p>A acupuntura apresenta evidências de benefício em quadros de vertigem funcional, disautonomia, ansiedade somática e fadiga crônica, sendo indicada como abordagem integrativa segura.</p>
', 'Danielle Candia Barra', '2026-02-02 11:03:18'),
  ('72810572100', 'prescricao', '<h2>ATESTADO MÉDICO</h2>

<p><strong>ATESTADO MÉDICO</strong></p>

<p>Atesto, para os devidos fins, que a Sra.</p>

<p><strong>Maria Angélica Leal Cordeiro</strong></p>

<p>encontra-se em acompanhamento médico por apresentar <strong>quadro de estresse físico e psicoemocional importante, associado a crises de ansiedade e síndrome do pânico</strong>, com sintomas autonômicos relevantes, incluindo tonturas, instabilidade postural, fadiga intensa, taquicardia, insegurança funcional e prejuízo do desempenho laboral.</p>

<p>No momento, a paciente <strong>não se encontra apta para exercer suas atividades profissionais</strong>, necessitando de <strong>afastamento temporário para tratamento clínico, estabilização neuroendócrina e recuperação da saúde física e mental</strong>.</p>

<h3>Conduta:</h3>

<p>Recomendo <strong>afastamento das atividades laborais por 30 (trinta) dias</strong>, a contar desta data.</p>

<h3>CID-10:</h3>

<p>F41.0 – Transtorno do pânico</p>

<p>F43.2 – Reação ao estresse grave / transtorno de adaptação<br />
(opcional associar R42 – Tontura e instabilidade)</p>
', 'Danielle Candia Barra', '2026-02-02 11:07:04'),
  ('72810572100', 'prescricao', '<p><strong>ENCAMINHAMENTO MÉDICO</strong></p>

<p>Encaminho a paciente para <strong>Reabilitação Vestibular (Fisioterapia Vestibular / Otoneurológica)</strong>.</p>

<h3>Indicação clínica:</h3>

<p>Paciente em acompanhamento médico apresentando:</p>

<p>Tonturas recorrentes</p>

<p>Sensação de instabilidade postural</p>

<p>Vertigem não rotatória</p>

<p>Oscilações autonômicas</p>

<p>Fadiga neurovegetativa</p>

<p>Prejuízo funcional nas atividades diárias</p>

<p>Quadro compatível com <strong>disfunção vestibular funcional / desregulação do sistema vestibulo-autonômico</strong>, sem evidências de causa estrutural grave, beneficiando-se de terapia de reabilitação específica.</p>

<h3>Objetivos terapêuticos:</h3>

<p>Recondicionamento vestibular</p>

<p>Habitação ao movimento</p>

<p>Melhora do equilíbrio estático e dinâmico</p>

<p>Redução de tontura e vertigem</p>

<p>Prevenção de quedas</p>

<p>Melhora da confiança postural e qualidade de vida</p>

<h3>Conduta sugerida:</h3>

<p>2 a 3 sessões semanais</p>

<p>por 6 a 8 semanas</p>

<p>com reavaliação clínica periódica</p>

<h3>CID-10:</h3>

<p>R42 – Tontura e instabilidade<br />
(pode associar H81.9 – Transtorno vestibular não especificado, se desejar)</p>
', 'Danielle Candia Barra', '2026-02-02 11:09:05'),
  ('01433139677', 'prescricao', '<p>Solicito :<br />
<br />
TSH&nbsp;<br />
<br />
T4L</p>

<p>T3L</p>

<p>Anti-TPO</p>

<p>Anti-Tg</p>

<p>Especialmente porque:<br />
? LDL elevado<br />
? possível fadiga metabólica<br />
? fase climatérica</p>
', 'Danielle Candia Barra', '2026-02-02 11:40:41'),
  ('01433139677', 'prescricao', '<br />
<br />
CID: E34.9 – Transtorno endócrino não especificado<br />
<br />
<br />
<strong>1) Estradiol – uso transdérmico</strong><br />
Estradiol bioidêntico 2 mg<br />
Pentravan® qsp 1 mL<br />
Frasco pump 30 mL<br />
Posologia: aplicar 1 pump pela manhã exclusivamente em membros inferiores (coxas internas, atrás dos joelhos ou tornozelos).<br />
<br />
<strong>2) Testosterona – uso transdérmico</strong><br />
Testosterona base micronizada 1,3 mg<br />
Pentravan® qsp 1 mL<br />
Frasco pump 30 mL<br />
<br />
Posologia: aplicar 1 pump pela manhã em local diferente do estradiol, somente membros inferiores.<br />
<br />
<strong>3) Estriol – uso vaginal</strong><br />
Estriol 3 mg<br />
Creme vaginal qsp 1 aplicador<br />
Frasco 30 g<br />
Posologia: aplicar à noite por 14 dias, depois 2–3x/semana.<br />
<br />
<strong>4) Progesterona micronizada – uso oral</strong><br />
<br />
Progesterona micronizada 150 mg<br />
Cápsulas gastro?resistentes – 60 cápsulas<br />
Posologia: 1 cápsula à noite ao deitar.<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2026-02-02 11:47:12'),
  ('01433139677', 'prescricao', '<h2>Suporte tireoidiano + conversão T4?T3 (ASSOCIADA)</h2>

<p>Selênio quelato <strong>200 mcg</strong><br />
Zinco quelato <strong>15 mg</strong><br />
Magnésio bisglicinato <strong>150 mg</strong><br />
Tirosina <strong>300 mg</strong><br />
Ashwagandha extrato (5% withanolídeos) <strong>250 mg</strong><br />
Vitamina A <strong>2.500 UI</strong><br />
Iodo orgânico (kelp) <strong>150 mcg</strong></p>

<p>Cápsulas gastro-resistentes<br />
Tomar <strong>1 cápsula pela manhã em jejum</strong><br />
<br />
<br />
&nbsp;</p>

<h2>Complexo B completo (ASSOCIADA – padrão que você prefere)</h2>

<p>B1 <strong>25 mg</strong><br />
B2 <strong>20 mg</strong><br />
B3 <strong>35 mg</strong><br />
B5 <strong>50 mg</strong><br />
B6 <strong>25 mg</strong><br />
Metilfolato <strong>400 mcg</strong><br />
Metilcobalamina <strong>1.000 mcg</strong><br />
Biotina <strong>5 mg</strong></p>

<p>Cápsulas gastro-resistentes<br />
Tomar <strong>1 cápsula/dia</strong><br />
<br />
&nbsp;</p>

<h2>Suporte metabólico + cardiovascular + anti-inflamatório (ASSOCIADA)</h2>

<p>Ômega 3 (EPA+DHA) <strong>1.500 mg</strong><br />
Coenzima Q10 <strong>100 mg</strong><br />
Vitamina K2 MK-7 <strong>120 mcg</strong><br />
Vitamina D3 <strong>5.000 UI</strong><br />
Magnésio bisglicinato <strong>200 mg</strong></p>

<p>Cápsulas gastro-resistentes<br />
Tomar <strong>2 cápsulas/dia com refeições</strong></p>
', 'Danielle Candia Barra', '2026-02-02 11:50:46'),
  ('52367959153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000<br />
pote de 500g</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose (60g) 1 x ao dia, de manhã ou a noite diluído em 1&nbsp;copo d''àgua.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>OBS: A dose depende a atividade intestinal, podendo aumentar ou reduzir a dose conforme o funcionamento intestinal.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-02-02 16:00:13'),
  ('25471040325', 'prescricao', '<p>Uso Oral</p>

<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche<br />
<br />
2-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Amilase.................................................50mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Papaína................................................100mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Bromelina...............................................50mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Lipase..................................................50mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Pepsina.................................................25mg</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span><br />
<br />
4-<br />
Mulungu (erythrina mulungu) ......................................................................400mg<br />
Valeriana officinalis ( extrato seco).............................................................. 500mg<br />
Passiflora incarnata ( extrato seco).............................................................. 400mg<br />
Melissa officinalis( extrato seco)................................................................... 400mg<br />
<br />
Tomar 1 dose 30 a 60 min. antes de deitar. por 60 dias.<br />
<br />
5-<br />
Glicina......................................................................................................3000mg<br />
Taurina......................................................................................................1000mg<br />
Magnésio L treonato ( elelementar)........................................................... 400mg<br />
Vitamina B6 (P5P)...................................................................................... 25mg<br />
Mandar em pó ou sache&nbsp;<br />
<br />
Tomar 30 min. antes de deitar diluido em água morna. Por 60 dias.</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-02-05 17:19:16'),
  ('04701840190', 'prescricao', 'USO TÓPICO<br />
<br />
1- Be Hialuronic&nbsp; 30 ml&nbsp; - sérum com ácido hialuronico ( Be belle)<br />
<br />
Aplicar 2 x ao dia de manhã e a noite. Aplicar uma fina camada em todo o rosto, esperar absorver e depois aplicar o filtro solar. aplicar sempre com a pele limpa.<br />
<br />
2- NoSkin Marks ( Be belle)<br />
<br />
Aplicar 1 x ao dia a noite, e não enxaguar. antes de dormir, aplicar uma camada generosa sob as marcas tratadas. Sempre aplicar com a pele limpa.', 'Ana Carolina Candia Barra', '2026-02-05 18:55:41'),
  ('62055143115', 'prescricao', 'Uso oral<br />
<br />
1-<br />
Nattokinase 100mg (2.000FU)<br />
Curcumina BCM -95 500mg<br />
Magnesio bisglicinato 200mg<br />
<br />
Tomar 1 cap. 2x ao dia, junto das peincipais refeições, café da manhã, almoço e jantar.<br />
<br />
2-<br />
Ômega 3 - 990 EPA e 660 DHA ( vita for plus)<br />
<br />
Tomar 1 cap. 2x ao dia, junto das peincipais refeições, café da manhã, almoço e jantar.<br />
<br />
3-<br />
Mio-inositol 600mg<br />
selênio quelado ( L seleniometionina) 200mg<br />
Zinco quelado 30mg<br />
<br />
Tomar 1 cap. 2 x ao dia , longe de café&nbsp; e leite.<br />
<br />
4-<br />
L-Glutamina 5g<br />
Butirato de sódio 300mg<br />
<br />
Diluir 1 medida em água, 2 x ao dia ( jejum e antes de dormir)<br />
<br />
5-<br />
Lactobacillus plantarum - 10 bilhões UFC<br />
Lactobacillus rhamnosus - 10 bilhões UFC<br />
Bifidobacterium lactis - 10 bilhões UFC<br />
<br />
Tomar 1 dose ao dia , á noite ante sde dormir.', 'Ana Carolina Candia Barra', '2026-02-06 12:06:45'),
  ('57895392115', 'prescricao', '<h2>Fórmula 1 – Levotiroxina (T4) + Liotironina (T3) Bioidênticas</h2>
Levotiroxina (T4) bioidêntica: 18 mcg<br />
Liotironina (T3) bioidêntica: 10 mcg<br />
<br />
Forma farmacêutica: cápsulas gastroresistentes<br />
Quantidade: 90 cápsulas<br />
<br />
Posologia: tomar 1 cápsula pela manhã em jejum, 30 minutos antes do café da manhã, com água.<br />
Observações:<br />
- Armazenar em temperatura ambiente, fora da luz e umidade.<br />
- Não ingerir com leite, café ou outros alimentos.
<h2>&nbsp;Fórmula 2 – Enzimas Digestivas de Amplo Espectro</h2>
Composição por cápsula:<br />
<br />
- Amilase 5.000 U<br />
- Protease 20.000 HUT<br />
- Lipase 1.000 FIP<br />
- Lactase 500 ALU<br />
- Betaína HCL 100 mg<br />
<br />
Forma farmacêutica: cápsulas gastroresistentes<br />
Quantidade: 90 cápsulas<br />
Posologia: tomar 1 cápsula antes do almoço e 1 cápsula antes do jantar.
<h2>Fórmula 3 – Modulação Intestinal com Beta-glucana e Boswellia</h2>
Composição por cápsula:<br />
- Beta-glucana (1,3/1,6) – 200 mg<br />
- Boswellia serrata extrato seco – 150 mg<br />
- N-acetilcisteína (NAC) – 100 mg<br />
- Zinco quelado – 10 mg<br />
- Aloe vera liofilizada – 50 mg<br />
Forma farmacêutica: cápsulas gastroresistentes<br />
Quantidade: 90 cápsulas<br />
Posologia: tomar 1 cápsula 2 vezes ao dia, preferencialmente em jejum e à noite.<br />
<br />
<br />
<br />
<br />
Assinatura e carimbo: _________________________________________<br />
&nbsp;', 'Danielle Candia Barra', '2026-02-09 10:28:23'),
  ('57895392115', 'prescricao', 'Solicito :<br />
<br />
<br />
• Hemograma completo<br />
• Testosterona total e livre<br />
• SDHEA (Sulfato de Dehidroepiandrosterona)<br />
• Androstenediona<br />
• SHBG<br />
• Cortisol matinal (8h)<br />
• IGF-1 + DHT', 'Danielle Candia Barra', '2026-02-09 10:32:37'),
  ('57895392115', 'prescricao', 'Solicito a realização do seguinte exame de imagem:<br />
Ultrassonografia de Abdome Total<br />
<br />
Indicação Clínica:<br />
Avaliação clínica geral de fígado, vesícula, pâncreas, rins, baço e demais estruturas abdominais para investigação ou acompanhamento de condições hepáticas, renais, digestivas ou metabólicas.<br />
<br />
Observações:<br />
- Comparecer em jejum de no mínimo 6 horas, com bexiga moderadamente cheia.<br />
- Levar exames anteriores se disponíveis.<br />
&nbsp;', 'Danielle Candia Barra', '2026-02-09 10:48:11'),
  ('57968799104', 'prescricao', '<p><small><strong>Uso interno</strong></small></p>

<p><small>1-</small></p>

<p><small>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Coenzima Q10..................................................... 50 mg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina.................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde<br />
<br />
2-</small></p>
<small>Vitamina D 3..........................................5000ui<br />
Vitamina K2 MK7.......................................150mg</small>

<p><small>30 pastilhas</small></p>

<p><small>Sorver uma pastilha sublingual uma vez ao dia no almoço.&nbsp;<br />
<br />
3-</small></p>
<small>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
bergamota extrato seco............................600mg<br />
Ácido alfa Lipóico....................................300 mg</small>

<p><small>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.<br />
<br />
4-</small></p>
Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Berberina ..............................................250mg
<p>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-02-09 14:25:33'),
  ('17333920500', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg<br />
Espinheira santa....................................... 500 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
<br />
Tomar uma dose logo antes das duas principais refeições do dia, almoço e jantar. Por 60 dias.<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p>&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-02-10 16:18:16'),
  ('79453430153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Betaina HCl ...............................................................................300 mg<br />
Mande 60 doses.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar.</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Curcumina (Cúrcuma Longa)fitossonal BCM95 – 500 mg<br />
Boswellia Serrata padronizada&nbsp; em 65% ácidos boswelicos – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Tomar 2 x aos dia no lanche da manhã e antes de dormir.<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span><br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-02-10 18:03:14'),
  ('38678691115', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.</span></p>
', 'Ana Carolina Candia Barra', '2026-02-12 10:10:17'),
  ('10717573770', 'prescricao', 'Uso intramuscular<br />
<br />
1 - Vitm. D 3 200.000 ui<br />
<br />
Dose única<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-02-12 10:44:27'),
  ('36874608860', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Betaina HCl ...............................................................................300 mg<br />
Mande 60 doses.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-02-12 16:22:34'),
  ('85260665104', 'prescricao', '<h1>Tratamento para 90 dias.<br />
<br />
MÓDULO HEMATOLÓGICO – Ferro e Eritropoiese</h1>

<p>(uso após esquema EV ou como manutenção)</p>

<p><strong>Fórmula – 1 cápsula 2x/dia</strong></p>

<ul>
	<li>
	<p>Ferro bisglicinato quelato ................................ 30 mg</p>
	</li>
	<li>
	<p>Vitamina C ..................................................... 250 mg</p>
	</li>
	<li>
	<p>Vitamina B6 (P-5-P) ........................................ 25 mg</p>
	</li>
	<li>
	<p>Vitamina B12 (metilcobalamina) ................. 1000 mcg</p>
	</li>
	<li>
	<p>Ácido fólico (5-MTHF) .................................... 400 mcg</p>
	</li>
	<li>
	<p>Cobre quelato .................................................. 1 mg</p>
	</li>
	<li>
	<p>Excipiente q.s.p. cápsula gastro-resistente</p>
	</li>
</ul>

<p>&nbsp;Objetivo: manter ferritina &gt; 70 e sustentar eritropoiese adequada.</p>

<h1>MÓDULO HORMONAL – Eixo Adrenal e Progesterona</h1>

<h3>DHEA isolado</h3>

<p><strong>1 cápsula pela manhã</strong></p>

<ul>
	<li>
	<p>DHEA ............................................................ 25 mg</p>
	</li>
	<li>
	<p>Excipiente q.s.p. cápsula gastro-resistente</p>
	</li>
</ul>

<h3>&nbsp;Progesterona bioidêntica</h3>

<p><strong>1 cápsula à noite</strong></p>

<ul>
	<li>
	<p>Progesterona micronizada ......................... 80 mg</p>
	</li>
	<li>
	<p>Vitamina E natural ........................................ 100 UI</p>
	</li>
	<li>
	<p>Excipiente q.s.p. cápsula gastro-resistente</p>
	</li>
</ul>

<p>Objetivo: estabilizar endométrio, modular sangramento residual e melhorar sono.</p>

<h1>MÓDULO CARDIOMETABÓLICO – LDL / ApoB</h1>

<p><strong>1 cápsula à noite</strong></p>

<ul>
	<li>
	<p>Red yeast rice (padronizado 3% monacolina) .... 200 mg</p>
	</li>
	<li>
	<p>Extrato de bergamota .............................................. 500 mg</p>
	</li>
	<li>
	<p>Coenzima Q10 ............................................................. 100 mg</p>
	</li>
	<li>
	<p>Policosanol ................................................................... 10 mg</p>
	</li>
	<li>
	<p>Excipiente q.s.p. cápsula gastro-resistente</p>
	</li>
</ul>

<p>&nbsp;Objetivo: reduzir ApoB e LDL sem interferir no metabolismo hormonal.</p>

<h1>MÓDULO IMUNO-HORMONAL – Vitamina D</h1>

<p><strong>1 cápsula ao dia</strong></p>

<ul>
	<li>
	<p>Vitamina D3 ............................................. 10.000 UI</p>
	</li>
	<li>
	<p>Vitamina K2 MK-7 ...................................... 120 mcg</p>
	</li>
	<li>
	<p>Excipiente q.s.p. cápsula.&nbsp;<br />
	<br />
	<br />
	&nbsp;</p>

	<h1>FÓRMULA DO SONO – Cápsula Gastro-Resistente</h1>

	<p><strong>Tomar 1 cápsula 30–60 minutos antes de deitar</strong></p>
	</li>
	<li>
	<p>Melatonina de liberação prolongada ............. 0,5 mg</p>
	</li>
	<li>
	<p>Magnésio bisglicinato ..................................... 200 mg</p>
	</li>
	<li>
	<p>L-Teanina .......................................................... 200 mg</p>
	</li>
	<li>
	<p>Glicina ................................................................. 500 mg</p>
	</li>
	<li>
	<p>Inositol .............................................................. 500 mg</p>
	</li>
	<li>
	<p>5-HTP ................................................................. 50 mg</p>
	</li>
	<li>
	<p>Excipiente q.s.p. cápsula gastro-resisten</p>
	</li>
</ul>

<p>&nbsp;</p>

<h1>&nbsp;</h1>
', 'Danielle Candia Barra', '2026-02-23 09:42:01'),
  ('85260665104', 'prescricao', '<h3><strong>NORIPURUM® (ferripolimaltose) – Reposição Endovenosa de Ferro</strong></h3>

<p><strong>Prescrição:</strong></p>

<ul>
	<li>
	<p><strong>Noripurum® 100 mg/5 mL – 02 ampolas (total 200 mg)</strong></p>
	</li>
	<li>
	<p><strong>Diluir em SF 0,9% – 250 mL</strong></p>
	</li>
	<li>
	<p><strong>Infundir lentamente (mínimo 60–90 minutos)</strong></p>
	</li>
</ul>

<p>&nbsp;</p>

<p><strong>Via:</strong> Intravenosa – infusão lenta sob supervisão<br />
<strong>Monitorização:</strong> PA, FC e sintomas durante e após a infusão</p>
', 'Danielle Candia Barra', '2026-02-23 09:42:59'),
  ('85260665104', 'prescricao', '<h3><strong>NORIPURUM® (ferripolimaltose) – Reposição Endovenosa de Ferro</strong></h3>

<p><strong>Prescrição:</strong></p>

<ul>
	<li>
	<p><strong>Noripurum® 100 mg/5 mL – 02 ampolas (total 200 mg)</strong></p>
	</li>
	<li>
	<p><strong>Diluir em SF 0,9% – 250 mL</strong></p>
	</li>
	<li>
	<p><strong>Infundir lentamente (mínimo 60–90 minutos)</strong></p>
	</li>
</ul>

<p><strong>Posologia:</strong></p>

<ul>
	<li>
	<p><strong>Aplicar 1 infusão com 200 mg (02 ampolas)</strong></p>
	</li>
	<li>
	<p>Reavaliar hemograma e ferritina em 4 semanas</p>
	</li>
	<li>
	<p>Considerar nova infusão conforme resposta clínica e laboratorial</p>
	</li>
</ul>

<p><strong>Via:</strong> Intravenosa – infusão lenta sob supervisão<br />
<strong>Monitorização:</strong> PA, FC e sintomas durante e após a infusão</p>
', 'Danielle Candia Barra', '2026-02-23 09:44:47'),
  ('17333920500', 'prescricao', '<p><strong>Solicito :&nbsp;<br />
<br />
1) Ultrassonografia músculo-esquelética do ombro esquerdo</strong><br />
Indicação: dor intensa em membro superior esquerdo, piora noturna, antecedente de bursite e diabetes mellitus de longa data.<br />
Avaliar manguito rotador (supraespinal, infraespinal, subescapular), tendão da cabeça longa do bíceps, bursa subacromial/subdeltoidea, cápsula articular, presença de derrame, calcificações e sinais de ruptura parcial ou total.</p>

<hr />
<p><strong>2) Ultrassonografia músculo-esquelética do braço esquerdo</strong><br />
Indicação: dor difusa em membro superior esquerdo.<br />
Avaliar musculatura, fáscias, inserções tendíneas e possíveis alterações inflamatórias ou estruturais.</p>

<hr />
<p><strong>3) Ultrassonografia de partes moles – região do trapézio</strong><br />
Indicação: abaulamento local.<br />
Caracterizar lesão subcutânea (lipoma, espessamento adiposo, massa sólida ou coleção).</p>

<hr />
<p><strong>4) Ultrassonografia de partes moles – região temporal bilateral</strong><br />
Indicação: abaulamento em região temporal.<br />
Avaliar partes moles, musculatura temporal e tecido subcutâneo.</p>

<hr />
<p><strong>5) Ultrassonografia de partes moles – região infrajoelhos bilateral</strong><br />
Indicação: abaulamento bilateral.<br />
Avaliar tecido subcutâneo, possíveis lipomas ou espessamentos adiposos.</p>

<hr />
<p><strong>Observação técnica (já incluída conforme solicitado):</strong><br />
Solicita-se avaliação músculo-esquelética detalhada com técnica específica para tendões, bursas, musculatura e partes moles, incluindo manobras dinâmicas e Doppler quando necessário.</p>
', 'Danielle Candia Barra', '2026-02-23 10:23:05'),
  ('17333920500', 'prescricao', '<h2>Solicito :&nbsp;<br />
<br />
&nbsp;Controle glicêmico e resistência insulínica</h2>

<ul>
	<li>
	<p>Glicemia de jejum</p>
	</li>
	<li>
	<p>Insulina de jejum</p>
	</li>
	<li>
	<p>Hemoglobina glicada (HbA1c)</p>
	</li>
	<li>
	<p>HOMA-IR (cálculo)</p>
	</li>
	<li>
	<p>Frutosamina</p>
	</li>
</ul>

<h2>Perfil lipídico e risco cardiovascular</h2>

<ul>
	<li>
	<p>Colesterol total</p>
	</li>
	<li>
	<p>HDL-colesterol</p>
	</li>
	<li>
	<p>LDL-colesterol</p>
	</li>
	<li>
	<p>VLDL</p>
	</li>
	<li>
	<p>Triglicerídeos</p>
	</li>
	<li>
	<p>Apolipoproteína A1</p>
	</li>
	<li>
	<p>Apolipoproteína B</p>
	</li>
	<li>
	<p>Relação Apo B/Apo A1</p>
	</li>
	<li>
	<p>Lipoproteína(a)</p>
	</li>
	<li>
	<p>PCR ultrassensível</p>
	</li>
</ul>

<h2>Inflamação e dor musculoesquelética</h2>

<ul>
	<li>
	<p>Hemograma completo</p>
	</li>
	<li>
	<p>VHS</p>
	</li>
	<li>
	<p>Ferritina</p>
	</li>
	<li>
	<p>CPK</p>
	</li>
	<li>
	<p>Ácido úrico</p>
	</li>
</ul>

<h2>Tireoidiano</h2>

<ul>
	<li>
	<p>TSH</p>
	</li>
	<li>
	<p>T4 livre</p>
	</li>
	<li>
	<p>T3 livre</p>
	</li>
	<li>
	<p>Anti-TPO</p>
	</li>
	<li>
	<p>Anti-tireoglobulina</p>
	</li>
</ul>

<h2>Metabolismo ósseo e muscular</h2>

<ul>
	<li>
	<p>Vitamina D (25-OH)</p>
	</li>
	<li>
	<p>Cálcio total</p>
	</li>
	<li>
	<p>Cálcio iônico</p>
	</li>
	<li>
	<p>Magnésio</p>
	</li>
	<li>
	<p>Fósforo</p>
	</li>
	<li>
	<p>PTH</p>
	</li>
</ul>

<h2>Função renal e hepática</h2>

<ul>
	<li>
	<p>Ureia</p>
	</li>
	<li>
	<p>Creatinina</p>
	</li>
	<li>
	<p>TFG estimada</p>
	</li>
	<li>
	<p>Microalbuminúria urinária</p>
	</li>
	<li>
	<p>TGO</p>
	</li>
	<li>
	<p>TGP</p>
	</li>
	<li>
	<p>GGT</p>
	</li>
	<li>
	<p>Fosfatase alcalina</p>
	</li>
</ul>

<h2>Eixo adrenal (considerando dor crônica e possível giba dorsal)</h2>

<ul>
	<li>
	<p>Cortisol sérico 8h</p>
	</li>
	<li>
	<p>ACTH</p>
	</li>
	<li>
	<p>DHEA-S</p>
	</li>
</ul>

<h2>Hormonal feminino (se pertinente)</h2>

<ul>
	<li>
	<p>Estradiol</p>
	</li>
	<li>
	<p>FSH</p>
	</li>
	<li>
	<p>LH</p>
	</li>
	<li>
	<p>SHBG</p>
	</li>
	<li>
	<p>Testosterona total</p>
	</li>
	<li>
	<p>Testosterona livre</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-02-23 10:26:07'),
  ('17333920500', 'prescricao', '<h2>MODULAÇÃO IMUNOLÓGICA E ANTI-HISTAMÍNICA NATURAL</h2>

<p><strong>Quercetina</strong> – 400 mg<br />
<strong>Vitamina C</strong> – 250 mg<br />
<strong>Boswellia serrata (20% AKBA)</strong> – 50 mg<br />
<strong>Curcumina fitossomada</strong> – 250 mg<br />
<strong>Zinco quelato</strong> – 20 mg</p>

<p>Tomar 1 cápsula 2x ao dia após as refeições.<br />
Manipular 60 cápsulas gastro-resistentes.</p>
', 'Danielle Candia Barra', '2026-02-23 10:43:46'),
  ('11055864725', 'prescricao', '<h1>FÓRMULA 1 – MODULAÇÃO INTESTINAL COMPLETA</h1>

<p><strong>Cápsulas gastro-resistentes – 120 doses</strong></p>

<ul>
	<li>
	<p>Boswellia serrata (20% AKBA) 50 mg</p>
	</li>
	<li>
	<p>Quercetina 400 mg</p>
	</li>
	<li>
	<p>Vitamina C 250 mg</p>
	</li>
	<li>
	<p>Zinco quelato 20 mg</p>
	</li>
	<li>
	<p>N-acetilcisteína 150 mg</p>
	</li>
</ul>

<p>Posologia: 1 cápsula 2x ao dia</p>

<p>(Controle inflamatório + mucosa + muco fecal)</p>

<h1>&nbsp;FÓRMULA 2 – SUPORTE BILIAR E METABÓLICO</h1>

<p><strong>Cápsulas gastro-resistentes – 120 doses</strong></p>

<ul>
	<li>
	<p>Taurina 500 mg</p>
	</li>
	<li>
	<p>Fosfatidilcolina 300 mg</p>
	</li>
	<li>
	<p>Colina bitartarato 250 mg</p>
	</li>
	<li>
	<p>Inositol 500 mg</p>
	</li>
	<li>
	<p>Berberina 500 mg</p>
	</li>
</ul>

<p>Posologia: 1 cápsula 2x ao dia antes das principais refeições</p>

<p>(Atua em gordura fecal + LDL + resistência insulínica)</p>

<h1>SUPLEMENTAÇÃO ISOLADA</h1>

<h3>Vitamina D3 10.000 UI</h3>

<ul>
	<li>
	<p>Vitamina K2 MK-7 100 mcg<br />
	1 cápsula ao dia</p>
	</li>
</ul>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-02-23 11:43:41'),
  ('11055864725', 'prescricao', '<h1>FÓRMULA 3 – MODULAÇÃO ANDROGÊNICA FISIOLÓGICA</h1>

<p>Cápsulas gastro-resistentes – 60 doses</p>

<ul>
	<li>
	<p>DHEA 25&nbsp;mg</p>
	</li>
</ul>

<p>Posologia: 1 cápsula pela manhã, após café da manhã</p>

<p>Reavaliar DHEA-S e testosterona em 8–10 semanas.</p>
', 'Danielle Candia Barra', '2026-02-23 11:45:43'),
  ('05221311666', 'prescricao', '<h2><br />
Dra. Paula Lobo<br />
<br />
L2 Sul - Asa Sul - Brasília - DF</h2>

<ul>
	<li><a href=&quot;mailto:contato@equilibrio.med.br&quot;>contato@equilibrio.med.br</a></li>
	<li>61 3346 9336</li>
	<li>&nbsp;</li>
	<li>61 99640 2405</li>
</ul>
', 'Danielle Candia Barra', '2026-02-23 12:45:49'),
  ('05221311666', 'prescricao', '<p><strong>ANAMNESE/EVOLUÇÃO</strong></p>

<h2>Investigação de Sobrecarga Férrica / Inflamação</h2>

<ul>
	<li>
	<p>Ferro sérico</p>
	</li>
	<li>
	<p>Ferritina</p>
	</li>
	<li>
	<p>Capacidade total de ligação do ferro (TIBC)</p>
	</li>
	<li>
	<p>Saturação de transferrina</p>
	</li>
	<li>
	<p>PCR ultrassensível</p>
	</li>
	<li>
	<p>VHS</p>
	</li>
	<li>
	<p>HFE (genotipagem para hemocromatose hereditária)</p>
	</li>
</ul>

<hr />
<h2>&nbsp;Avaliação de Metilação e Risco Vascular</h2>

<ul>
	<li>
	<p>Homocisteína (controle evolutivo)</p>
	</li>
	<li>
	<p>Ácido fólico sérico</p>
	</li>
	<li>
	<p>Folato eritrocitário</p>
	</li>
	<li>
	<p>Vitamina B6 (piridoxal-5-fosfato)</p>
	</li>
	<li>
	<p>Vitamina B2 (riboflavina)</p>
	</li>
	<li>
	<p>Perfil lipoproteico avançado (Apo A1, Apo B)</p>
	</li>
	<li>
	<p>Relação Apo B/Apo A1</p>
	</li>
</ul>

<hr />
<h2>&nbsp;Investigação Vestibular / Autoimune</h2>

<ul>
	<li>
	<p>FAN</p>
	</li>
	<li>
	<p>Anti-TPO</p>
	</li>
	<li>
	<p>Anti-tireoglobulina</p>
	</li>
	<li>
	<p>C3</p>
	</li>
	<li>
	<p>C4</p>
	</li>
	<li>
	<p>IgE total</p>
	</li>
	<li>
	<p>Eletroforese de proteínas</p>
	</li>
	<li>
	<p>Fibrinogênio</p>
	</li>
</ul>

<hr />
<h2>&nbsp;Eixo Tireoidiano Completo</h2>

<ul>
	<li>
	<p>TSH</p>
	</li>
	<li>
	<p>T4 livre</p>
	</li>
	<li>
	<p>T3 livre</p>
	</li>
	<li>
	<p>Reverse T3</p>
	</li>
</ul>

<hr />
<h2>&nbsp;Avaliação Metabólica Complementar</h2>

<ul>
	<li>
	<p>Insulina</p>
	</li>
	<li>
	<p>Glicemia de jejum</p>
	</li>
	<li>
	<p>Hemoglobina glicada</p>
	</li>
	<li>
	<p>Magnésio sérico</p>
	</li>
	<li>
	<p>Zinco</p>
	</li>
	<li>
	<p>Selênio</p>
	</li>
	<li>
	<p>Vitamina D (25-OH)</p>
	</li>
	<li>
	<p>Cortisol sérico 8h</p>
	</li>
</ul>

<hr />
<h2>&nbsp;Avaliação Endotelial / Tromboinflamatória</h2>

<ul>
	<li>
	<p>D-dímero (controle evolutivo)</p>
	</li>
	<li>
	<p>Lp(a)</p>
	</li>
	<li>
	<p>PCR-us</p>
	</li>
	<li>
	<p>Ácido úrico</p>
	</li>
</ul>

<hr />
<h1>Justificativa Clínica</h1>

<p>Paciente com quadro compatível com Doença de Ménière, com hidropsia coclear e vestibular bilateral documentada em ressonância magnética, associada a ferritina elevada e homocisteína aumentada, sintomas vestibulares recorrentes e perda auditiva flutuante.</p>

<p>Solicita-se investigação metabólica, inflamatória, vascular e autoimune para abordagem etiológica ampliada e prevenção de recorrência das crises.</p>
', 'Danielle Candia Barra', '2026-02-23 12:46:21'),
  ('04937069179', 'prescricao', 'Para manipulação<br />
<br />
uso oral<br />
<br />
<strong>Tratamento sono&nbsp;</strong><br />
<br />
1-<br />
Magnésio glicinato 400mg<br />
L- Teanina 200mg<br />
Metatonina time release 0,5 mg<br />
<br />
Tomaar 1 dose, 1 hora antes de dormir , por 60 dias, ( continuar com pasalix, juntamente neste horário) e não utilizar celular após essa formula.&nbsp;<br />
<br />
2-<br />
Glicina pura ( grau farmacêutico) - 3 g por dose<br />
mande 60 sachês de 3g&nbsp;<br />
<br />
Dissolver o envelope em água morna e tomar 1 hora antes de dormir.&nbsp;<br />
<br />
<strong>Tratamento pela manhã - Adaptação&nbsp;</strong><br />
<br />
3-<br />
NAC 600mg&nbsp;<br />
CoQ10 200mg<br />
Selênio 100mcg<br />
<br />
Tomar 1 dose, pela manhã ( juntamente a formula prescrita pelo médico que ja esta tomando), Por 60 dias.&nbsp;<br />
<br />
<strong>Modulação intestinal</strong><br />
<br />
4-<br />
Bifidobacterium longum - 5 bilhões UFC<br />
Lactobacillus rhamnosus - 5 bilhões UFC<br />
Lactobacillus plantarum - 3 bilhões UFC<br />
Bifidobacterium lactis - 2 bilhões UFC<br />
<br />
Tomar 1 dose pela manhã em jejum&nbsp; ou 30 min, antes do café. Por 60 dias.&nbsp;<br />
manter glutamina no shot da manhã 5G.<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-02-27 10:01:52'),
  ('04937069179', 'prescricao', 'Técnica obrigatória ( 2 x ao dia)<br />
<br />
<strong>Respiração Vagal<br />
<br />
Fazer 2 x ao dia&nbsp;<br />
<br />
4 segundos inspira ( pelo nariz)<br />
6-8 segundos solta ( pela boca)<br />
<br />
repetir por 5 min.&nbsp;</strong><br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-02-27 10:05:00'),
  ('39888762168', 'prescricao', '<h3>&nbsp;Metabólico</h3>

<ul>
	<li>
	<p>Glicemia de jejum</p>
	</li>
	<li>
	<p>Insulina basal</p>
	</li>
	<li>
	<p>Hemoglobina glicada (HbA1c)</p>
	</li>
	<li>
	<p>HOMA-IR (cálculo)</p>
	</li>
</ul>

<h3>&nbsp;Lipídico</h3>

<ul>
	<li>
	<p>Colesterol total</p>
	</li>
	<li>
	<p>HDL</p>
	</li>
	<li>
	<p>LDL</p>
	</li>
	<li>
	<p>Triglicerídeos</p>
	</li>
	<li>
	<p>Apolipoproteína B</p>
	</li>
	<li>
	<p>Apolipoproteína A1</p>
	</li>
	<li>
	<p>Relação Apo B/A1</p>
	</li>
</ul>

<h3>Tireoidiano</h3>

<ul>
	<li>
	<p>TSH</p>
	</li>
	<li>
	<p>T4 livre</p>
	</li>
	<li>
	<p>T3 livre</p>
	</li>
</ul>

<h3>&nbsp;Ferro / Inflamação</h3>

<ul>
	<li>
	<p>Ferritina</p>
	</li>
	<li>
	<p>PCR ultrassensível</p>
	</li>
</ul>

<h3>&nbsp;Hepático / Renal</h3>

<ul>
	<li>
	<p>TGO</p>
	</li>
	<li>
	<p>TGP</p>
	</li>
	<li>
	<p>GGT</p>
	</li>
	<li>
	<p>Creatinina</p>
	</li>
	<li>
	<p>eTFG</p>
	</li>
</ul>

<hr />
<h3>CID-10:</h3>

<ul>
	<li>
	<p>E88.81 – Resistência à insulina</p>
	</li>
	<li>
	<p>E03.9 – Hipotireoidismo</p>
	</li>
	<li>
	<p>E66.3 – Sobrepeso</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-03-02 10:15:39'),
  ('85260665104', 'prescricao', 'Uso oral&nbsp;<br />
<br />
para manipular&nbsp;<br />
<br />
1-<br />
Berberina HCl ..................... 500 mg<br />
Extrato de Neem .................. 200 mg<br />
Alho (extrato padronizado) ... 300 mg
<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>Tomar <strong>1 cápsula 2x ao dia antes das refeições principais</strong><br />
(almoço e jantar)<br />
&nbsp;</p>
2-

<p>Óleo de Orégano (mínimo 60% carvacrol)<br />
150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula <strong>2x ao dia após refeições<br />
<br />
3-</strong></p>

<p>Extrato de gengibre ............ 200 mg<br />
5-HTP ................................. 50 mg<br />
Magnésio citrato ............... 150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong><br />
1 cápsula após o jantar e<br />
1 cápsula antes de dormir<br />
<br />
4-</p>

<p>Triphala extrato seco ......... 400 mg<br />
Aloe vera extrato seco ...... 150 mg<br />
Ruibarbo extrato ................. 50 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula à noite após o jantar</p>

<p>Se necessário pode aumentar para <strong>2 cápsulas</strong>.</p>

<p><br />
<strong>tratamento - 30 dias - após esse tratamento agendar nova consulta para evoluirmos&nbsp;</strong><br />
&nbsp;</p>

<h1>&nbsp;</h1>

<p>&nbsp;</p>
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-05 09:44:20'),
  ('52367959153', 'prescricao', 'Uso oral&nbsp;<br />
<br />
para manipular&nbsp;<br />
<br />
1-<br />
Berberina HCl ..................... 500 mg<br />
Extrato de Neem .................. 200 mg<br />
Alho (extrato padronizado) ... 300 mg
<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>Tomar&nbsp;<strong>1 cápsula 2x ao dia antes das refeições principais</strong><br />
(almoço e jantar)<br />
&nbsp;</p>
2-

<p>Óleo de Orégano (mínimo 60% carvacrol)<br />
150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula&nbsp;<strong>2x ao dia após refeições<br />
<br />
3-</strong></p>

<p>Extrato de gengibre ............ 200 mg<br />
5-HTP ................................. 50 mg<br />
Magnésio citrato ............... 150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong><br />
1 cápsula após o jantar e<br />
1 cápsula antes de dormir<br />
<br />
4- Fórmula para melhorar motilidade e transito intestinal&nbsp;</p>

<p>Triphala extrato seco ......... 400 mg<br />
Aloe vera extrato seco ...... 150 mg<br />
Ruibarbo extrato ................. 50 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula à noite após o jantar</p>

<p>Se necessário pode aumentar para&nbsp;<strong>2 cápsulas</strong>.</p>
', 'Ana Carolina Candia Barra', '2026-03-05 10:41:22'),
  ('91163471100', 'prescricao', 'USO ORAL&nbsp;<br />
<br />
Para manipulação<br />
<br />
<br />
1-&nbsp;<br />
Vitamina D3..................... 4.000 ui<br />
Vitamina K2- MK7............&nbsp; 70 mg<br />
<br />
Tomar duas doses uma vez ao dia após o almoço por 60 dias.&nbsp;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-05 14:12:12'),
  ('66511887120', 'prescricao', 'Exames solicitados:<br />
- Ressonância Magnética do Ombro Direito<br />
- Ressonância Magnética do Ombro Esquerdo<br />
<br />
Protocolo do exame:<br />
Avaliação completa das articulações glenoumerais incluindo:<br />
- Manguito rotador<br />
- Tendão da cabeça longa do bíceps<br />
- Labrum glenoidal<br />
- Bursa subacromial-subdeltoidea<br />
- Articulação acromioclavicular<br />
- Estruturas capsuloligamentares<br />
<br />
Indicação clínica:<br />
Dor em ombros e/ou limitação funcional. Investigação de possíveis lesões do manguito rotador, tendinopatias, bursite ou impacto subacromial.<br />
<br />
CID sugerido: M75.1 – Síndrome do manguito rotador<br />
<br />
<br />
&nbsp;', 'Danielle Candia Barra', '2026-03-09 09:09:51'),
  ('66511887120', 'prescricao', '<h3>Oxandrolona</h3>

<p><strong>Oxandrolona 5 mg</strong></p>

<p>Tomar <strong>1 cápsula pela manhã e 1 cápsula no final da tarde</strong>.</p>

<p>Dose diária total: <strong>10 mg/dia</strong></p>

<p>Duração: <strong>6–8 semanas</strong></p>

<p>Quantidade sugerida: <strong>120 cápsulas<br />
<br />
<br />
CPF: 061.642.786-78<br />
<br />
Cid:M62.84</strong> – Sarcopenia</p>
', 'Danielle Candia Barra', '2026-03-09 09:37:47'),
  ('66511887120', 'prescricao', '<p><br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<strong>Oxandrolona 5 mg</strong></p>

<p>Tomar&nbsp;<strong>1 cápsula pela manhã e 1 cápsula no final da tarde</strong>.</p>

<p>Dose diária total:&nbsp;<strong>10 mg/dia</strong></p>

<p>Duração:&nbsp;<strong>6–8 semanas</strong></p>

<p>Quantidade sugerida:&nbsp;<strong>120 cápsulas<br />
<br />
<br />
CPF: 061.642.786-78<br />
<br />
Cid:M62.84</strong>&nbsp;– Sarcopenia</p>
', 'Danielle Candia Barra', '2026-03-09 09:38:27'),
  ('66511887120', 'prescricao', '<h3>Fórmula hepatoprotetora (cápsulas gastro-resistentes)</h3>

<p>Manipular:</p>

<p>Silimarina ................................ 300 mg</p>

<p>N-acetil-cisteína (NAC) ............ 300 mg</p>

<p>Vitamina C .................................. 500 mg</p>

<p>Zinco quelato ............................. 20 mg</p>

<p>Tomar <strong>1 cápsula 2 vezes ao dia</strong>.</p>

<p>Quantidade: <strong>120 cápsulas</strong><br />
&nbsp;</p>

<h3>&nbsp;Suporte metabólico</h3>

<p><strong>Ômega-3 (EPA + DHA)</strong></p>

<p>Tomar <strong>2 a 3 g ao dia</strong>, junto das refeições.</p>

<p>Duração: <strong>12 semanas</strong></p>
', 'Danielle Candia Barra', '2026-03-09 09:39:27'),
  ('66511887120', 'prescricao', '<h3>Tirzepatida (Mounjaro®)</h3>

<p><strong>Mounjaro® 2,5 mg / 0,5 mL – caneta aplicadora</strong></p>

<p>Aplicar <strong>2,5 mg por via subcutânea 1 vez por semana</strong>, sempre no mesmo dia da semana.</p>

<p>Duração inicial: <strong>4 semanas</strong></p>

<p>Locais de aplicação:</p>

<ul>
	<li>
	<p>abdome</p>
	</li>
	<li>
	<p>coxa</p>
	</li>
	<li>
	<p>parte posterior do braço</p>
	</li>
</ul>

<p>Alternar os locais de aplicação.</p>
', 'Danielle Candia Barra', '2026-03-09 09:43:42'),
  ('66511887120', 'prescricao', '<h3><br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
Tirzepatida (Mounjaro®)</h3>

<p><strong>Mounjaro® 2,5 mg / 0,5 mL – caneta aplicadora</strong></p>

<p>Aplicar <strong>2,5 mg por via subcutânea 1 vez por semana</strong>, sempre no mesmo dia da semana.</p>

<p>Duração inicial: <strong>4 semanas</strong></p>

<p>Locais de aplicação:</p>

<ul>
	<li>
	<p>abdome</p>
	</li>
	<li>
	<p>coxa</p>
	</li>
	<li>
	<p>parte posterior do braço</p>
	</li>
</ul>

<p>Alternar os locais de aplicação.</p>
', 'Danielle Candia Barra', '2026-03-09 09:44:05'),
  ('66511887120', 'prescricao', '<h2>. Identificação e contexto clínico</h2>

<p>Trata-se de paciente masculino de <strong>51 anos</strong>, em acompanhamento médico para <strong>controle metabólico e otimização da composição corporal</strong>, apresentando <strong>acúmulo de gordura abdominal persistente</strong>, apesar de manter rotina regular de atividade física e alimentação controlada.</p>

<p>O paciente realiza <strong>treinamento físico regular (musculação)</strong> e segue orientação nutricional com dieta controlada em carboidratos, porém mantém dificuldade na redução de gordura visceral.</p>

<hr />
<h2>2. Avaliação clínica e laboratorial</h2>

<p>Os exames laboratoriais demonstram:</p>

<ul>
	<li>
	<p>Testosterona total reduzida (284 ng/dL)</p>
	</li>
	<li>
	<p>Cortisol elevado</p>
	</li>
	<li>
	<p>Ferritina elevada (243 ng/mL)</p>
	</li>
	<li>
	<p>Perfil glicêmico dentro da normalidade, porém com tendência metabólica que favorece acúmulo de gordura visceral.</p>
	</li>
</ul>

<p>Essas alterações contribuem para <strong>dificuldade na redução de adiposidade central e maior risco cardiometabólico ao longo do tempo</strong>.</p>

<hr />
<h2>3. Indicação terapêutica</h2>

<p>Considerando o quadro clínico descrito, está indicado o uso de <strong>tirzepatida (Mounjaro®)</strong>, medicamento pertencente à classe dos <strong>agonistas duplos de receptores GIP e GLP-1</strong>, que atua promovendo:</p>

<ul>
	<li>
	<p>melhora da sensibilidade à insulina</p>
	</li>
	<li>
	<p>redução da gordura visceral</p>
	</li>
	<li>
	<p>controle do apetite</p>
	</li>
	<li>
	<p>melhora do perfil metabólico</p>
	</li>
</ul>

<p>Estudos clínicos demonstram eficácia significativa da tirzepatida na <strong>redução de peso corporal e gordura abdominal</strong>, além de melhora de parâmetros metabólicos.</p>

<hr />
<h2>4. Prescrição proposta</h2>

<p>Foi prescrita a seguinte terapêutica:</p>

<p><strong>Tirzepatida (Mounjaro®) 2,5 mg</strong></p>

<p>Aplicação <strong>subcutânea 1 vez por semana</strong>, inicialmente por <strong>4 semanas</strong>, com posterior reavaliação clínica e possível progressão de dose.</p>

<hr />
<h2>5. Considerações finais</h2>

<p>O uso da tirzepatida neste paciente tem como objetivo <strong>redução da gordura visceral, melhora metabólica e prevenção de complicações cardiometabólicas futuras</strong>, sendo considerado tratamento adequado e baseado em evidências científicas atuais.</p>

<p>Dessa forma, solicito a <strong>autorização para cobertura do medicamento prescrito</strong>.</p>
', 'Danielle Candia Barra', '2026-03-09 09:45:58'),
  ('66511887120', 'prescricao', '<h1>Café da manhã</h1>

<p>3 ovos inteiros mexidos</p>

<ul>
	<li>
	<p>2 claras</p>
	</li>
</ul>

<p>Proteína: <strong>26 g</strong></p>

<ul>
	<li>
	<p>café sem açúcar ou cappuccino sem açúcar</p>
	</li>
</ul>

<p>Opcional:<br />
1 fatia de queijo minas ou cottage</p>

<p>(+6 g proteína se usar)</p>

<h1>Almoço</h1>

<p>150 g de peito de frango grelhado<br />
ou<br />
150 g de carne vermelha magra</p>

<p>Proteína: <strong>35 g</strong></p>

<p>Acompanhar:</p>

<ul>
	<li>
	<p>salada verde à vontade</p>
	</li>
	<li>
	<p>legumes cozidos</p>
	</li>
	<li>
	<p>azeite de oliva</p>
	</li>
</ul>

<p>Opcional carboidrato (treino intenso):</p>

<ul>
	<li>
	<p>3 colheres de arroz</p>
	</li>
</ul>

<h1>Lanche da tarde</h1>

<p>1 scoop de whey protein</p>

<p>Proteína: <strong>25 g</strong></p>

<ul>
	<li>&nbsp;</li>
</ul>

<p>1 punhado pequeno de castanhas</p>

<h1>Jantar</h1>

<p>150 g de peixe<br />
(salmão, tilápia ou robalo)</p>

<p>Proteína: <strong>25 g</strong></p>

<ul>
	<li>
	<p>legumes cozidos</p>
	</li>
	<li>
	<p>azeite de oliva</p>
	</li>
</ul>

<h1>Distribuição proteica total</h1>

<table>
	<thead>
		<tr>
			<th>Refeição</th>
			<th>Proteína</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Café da manhã</td>
			<td>26 g</td>
		</tr>
		<tr>
			<td>Almoço</td>
			<td>35 g</td>
		</tr>
		<tr>
			<td>Lanche</td>
			<td>25 g</td>
		</tr>
		<tr>
			<td>Jantar</td>
			<td>25 g</td>
		</tr>
	</tbody>
</table>

<p><strong>Total: 111 g proteína/dia</strong></p>
', 'Danielle Candia Barra', '2026-03-09 09:51:22'),
  ('66511887120', 'prescricao', '<h1>1. Queixa principal</h1>

<p>Paciente procura avaliação médica com objetivo de <strong>melhora da composição corporal, redução de gordura abdominal e otimização hormonal</strong>, apesar de manter rotina de exercícios físicos.</p>

<hr />
<h1>2. História da doença atual</h1>

<p>Paciente masculino, <strong>51 anos</strong>, fisicamente ativo, praticando <strong>musculação aproximadamente 5 vezes por semana</strong>.</p>

<p>Relata dificuldade em <strong>reduzir gordura abdominal</strong>, mesmo mantendo alimentação controlada e prática regular de atividade física.</p>

<p>Refere uso prévio de <strong>testosterona injetável</strong>, prescrita por outra profissional, bem como uso prévio de <strong>oxandrolona</strong>, com boa resposta em força e massa muscular.</p>

<p>Atualmente demonstra interesse em <strong>estimular produção hormonal endógena e melhorar composição corporal de forma mais equilibrada</strong>.</p>

<p>Relata também <strong>início de entradas de calvície</strong>, sugestivas de alopecia androgenética inicial.</p>

<p>Paciente apresenta histórico recente de <strong>rotura de menisco esquerdo no final de novembro de 2025</strong>, com evolução satisfatória e boa recuperação funcional.</p>

<p>Informa que <strong>viajará para a Itália nos meses de junho e julho</strong>, motivo pelo qual deseja realizar <strong>check-up completo e otimização metabólica antes da viagem</strong>.</p>

<hr />
<h1>3. Hábitos de vida</h1>

<p>Atividade física:<br />
musculação aproximadamente <strong>5 vezes por semana</strong></p>

<p>Alimentação:<br />
relata manter <strong>dieta controlada com redução de carboidratos (low carb)</strong>.</p>

<p>Sono:<br />
não informado comprometimento significativo.</p>

<p>Álcool e tabagismo:<br />
não relatados na consulta atual.</p>

<hr />
<h1>4. Antecedentes pessoais</h1>

<ul>
	<li>
	<p>Rotura de menisco esquerdo (novembro de 2025)</p>
	</li>
	<li>
	<p>Uso prévio de testosterona exógena</p>
	</li>
	<li>
	<p>Uso prévio de oxandrolona</p>
	</li>
</ul>

<p>Nega outras doenças relevantes no momento.</p>

<hr />
<h1>5. Avaliação laboratorial recente</h1>

<p>Principais achados:</p>

<ul>
	<li>
	<p>Testosterona total: <strong>284 ng/dL</strong></p>
	</li>
	<li>
	<p>SHBG: <strong>46,3</strong></p>
	</li>
	<li>
	<p>LH: <strong>3,4</strong></p>
	</li>
	<li>
	<p>FSH: <strong>1,1</strong></p>
	</li>
	<li>
	<p>Estradiol: <strong>18,5</strong></p>
	</li>
</ul>

<p>Perfil glicêmico:</p>

<ul>
	<li>
	<p>Glicemia: <strong>95</strong></p>
	</li>
	<li>
	<p>Insulina: <strong>6,5</strong></p>
	</li>
	<li>
	<p>HbA1c: <strong>5,2</strong></p>
	</li>
</ul>

<p>Outros marcadores:</p>

<ul>
	<li>
	<p>Ferritina: <strong>243</strong></p>
	</li>
	<li>
	<p>Cortisol: <strong>20,21</strong></p>
	</li>
	<li>
	<p>IGF-1: <strong>169</strong></p>
	</li>
	<li>
	<p>Vitamina B12: <strong>800</strong></p>
	</li>
	<li>
	<p>Vitamina D: <strong>49</strong></p>
	</li>
</ul>

<hr />
<h1>6. Impressão clínica inicial</h1>

<p>Paciente apresenta quadro compatível com:</p>

<ul>
	<li>
	<p><strong>Hipogonadismo funcional masculino</strong></p>
	</li>
	<li>
	<p><strong>Acúmulo de gordura visceral</strong></p>
	</li>
	<li>
	<p><strong>Recuperação parcial do eixo hormonal após uso prévio de androgênios</strong></p>
	</li>
</ul>

<p>Com fatores metabólicos associados como:</p>

<ul>
	<li>
	<p>cortisol elevado</p>
	</li>
	<li>
	<p>ferritina elevada</p>
	</li>
</ul>

<hr />
<h1>7. Plano inicial</h1>

<ul>
	<li>
	<p>Solicitação de exames laboratoriais complementares e rastreio preventivo</p>
	</li>
	<li>
	<p>Orientação nutricional com adequação proteica</p>
	</li>
	<li>
	<p>Consideração terapêutica para otimização metabólica e composição corporal</p>
	</li>
	<li>
	<p>Prescrição de tirzepatida (Mounjaro®) em dose inicial</p>
	</li>
	<li>
	<p>Avaliação da necessidade de terapia hormonal ou estratégias de estímulo endógeno conforme evolução clínica.</p>
	</li>
</ul>

<hr />
<p>Se quiser, posso também montar p</p>
', 'Danielle Candia Barra', '2026-03-09 10:03:28'),
  ('83206540330', 'prescricao', '<p>Formula 1 Complexo metabolico e metilador<br />
Capsulas gastro resistentes 60 doses</p>

<p>Vitamina B1 benfotiamina 50 mg<br />
Vitamina B2 riboflavina 5 fosfato 10 mg<br />
Vitamina B5 pantotenato 100 mg<br />
Vitamina B6 P5P 20 mg<br />
Metilfolato 5 MTHF 400 mcg<br />
Metilcobalamina 1000 mcg<br />
Colina bitartarato 100 mg<br />
Inositol 250 mg</p>

<p>Posologia<br />
Tomar 1 capsula pela manha</p>

<p>Objetivo<br />
Suporte metabolico<br />
Reducao da homocisteina<br />
Melhora metabolismo energetico<br />
Suporte neurologico</p>

<p>Formula 2 Minerais estrategicos</p>

<p>Magnesio bisglicinato 200 mg<br />
Magnesio treonato 100 mg<br />
Zinco quelado 15 mg<br />
Boro quelado 3 mg</p>

<p>Posologia<br />
Tomar 1 capsula a noite</p>

<p>Objetivo<br />
Suporte hormonal<br />
Recuperacao muscular<br />
Qualidade do sono<br />
Otimizacao da testosterona</p>

<p>Formula 3 Vitamina D direcionada</p>

<p>Vitamina D3 7000 UI<br />
Vitamina K2 MK7 100 mcg</p>

<p>Posologia<br />
Tomar 1 capsula apos almoco.</p>

<p>Formula 4 Ferro funcional</p>

<p>Ferro bisglicinato 50 mg<br />
Vitamina C 200 mg</p>

<p>Posologia<br />
Tomar 1 capsula pela manha em dias alternados<br />
&nbsp;</p>

<p>&nbsp;</p>
<br />
<p><br />
&nbsp;</p>
', 'Danielle Candia Barra', '2026-03-09 10:58:00'),
  ('83206540330', 'prescricao', '<p>Prescricao</p>

<p>PEG 4000 polietilenoglicol 17&nbsp;g por dose<br />
Sachês</p>

<p>Posologia<br />
Diluir 1 sache em 200 ml de agua e tomar 1 vez ao dia, preferencialmente pela manha.</p>

<p>Se necessario pode aumentar para 2 doses ao dia conforme resposta intestinal.</p>

<p>Quantidade<br />
30 saches</p>

<p>Orientacoes<br />
Manter boa hidratacao diaria<br />
Associar ingestao adequada de fibras alimentares</p>
', 'Danielle Candia Barra', '2026-03-09 10:59:16'),
  ('83206540330', 'prescricao', '<p>** Tratamento para 90 dias<br />
<br />
Formula 1&nbsp;-Vitamina D direcionada</p>

<p>Vitamina D3 7000 UI<br />
Vitamina K2 MK7 100 mcg</p>

<p>Posologia<br />
Tomar 1 capsula apos almoco.</p>

<p><br />
<br />
<br />
Formula 2&nbsp;Complexo metabolico e metilador<br />
Capsulas gastro resistentes 60 doses</p>

<p>Vitamina B1 benfotiamina 50 mg<br />
Vitamina B2 riboflavina 5 fosfato 10 mg<br />
Vitamina B5 pantotenato 100 mg<br />
Vitamina B6 P5P 20 mg<br />
Metilfolato 5 MTHF 400 mcg<br />
Metilcobalamina 1000 mcg<br />
Colina bitartarato 100 mg<br />
Inositol 250 mg</p>

<p>Posologia<br />
Tomar 1 capsula pela manha</p>

<p><br />
&nbsp;</p>

<p>Formula 3&nbsp;Minerais estrategicos</p>

<p>Magnesio bisglicinato 200 mg<br />
Magnesio treonato 100 mg<br />
Zinco quelado 15 mg<br />
Boro quelado 3 mg</p>

<p>Posologia<br />
Tomar 1 capsula a noite<br />
<br />
<br />
&nbsp;</p>

<p>Manter a formula da testosterona !<br />
<br />
&nbsp;</p>

<p>Formula 4 Ferro funcional</p>

<p>Ferro bisglicinato 50 mg<br />
Vitamina C 200 mg</p>

<p>Posologia<br />
Tomar 1 capsula pela manha.</p>
', 'Danielle Candia Barra', '2026-03-09 11:07:04'),
  ('9806482891', 'prescricao', '<h1>Fórmula 1 – Energia celular e suporte neuromuscular</h1>

<p>Cápsulas gastro-resistentes<br />
90 doses</p>

<p>Tomar 1 cápsula pela manhã</p>

<p>Coenzima Q10 100 mg<br />
Acetil L-carnitina 500 mg<br />
Magnésio bisglicinato 150 mg<br />
Zinco quelato 15 mg<br />
Vitamina B1 25 mg<br />
Vitamina B2 10 mg<br />
Vitamina B3 20 mg<br />
Vitamina B5 25 mg<br />
Vitamina B6 (P5P) 10 mg<br />
Metilfolato 400 mcg<br />
Metilcobalamina 500 mcg<br />
Inositol 50 mg<br />
Colina 50 mg</p>

<h1><br />
Fórmula 2 – Antioxidante e anti-inflamatória</h1>

<p>Cápsulas gastro-resistentes<br />
90 doses</p>

<p>Tomar 1 cápsula após almoço</p>

<p>N-acetilcisteína 300 mg<br />
Quercetina 250 mg<br />
Vitamina C 250 mg<br />
Boswellia serrata 50 mg<br />
Selênio quelato 100 mcg</p>

<h1>&nbsp;</h1>

<h1><br />
<br />
Manter</h1>

<p>Creatina 3 g/dia<br />
Gerimax dia sim dia não<br />
Melatonina time release 3,5 mg à noite</p>
', 'Danielle Candia Barra', '2026-03-09 11:42:40'),
  ('00460983130', 'prescricao', '<p><strong>CID:</strong> Z00.0 (Avaliação clínica geral)</p>

<hr />
<h2>1. Avaliação metabólica e inflamatória</h2>

<p>Hemograma completo<br />
Ferritina<br />
Ferro sérico<br />
Capacidade total de ligação do ferro (TIBC)</p>

<p>PCR ultrassensível</p>

<p>Glicemia de jejum<br />
Insulina de jejum<br />
Hemoglobina glicada</p>

<p>Homocisteína</p>

<hr />
<h2>2. Perfil lipídico ampliado</h2>

<p>Colesterol total<br />
HDL<br />
LDL<br />
Triglicerídeos</p>

<p>Apolipoproteína A1<br />
Apolipoproteína B</p>

<hr />
<h2>3. Avaliação tireoidiana</h2>

<p>TSH<br />
T4 livre<br />
T3 livre<br />
Anti-TPO<br />
Anti-Tireoglobulina</p>

<hr />
<h2>4. Perfil hormonal feminino</h2>

<p>Estradiol<br />
Progesterona<br />
LH<br />
FSH<br />
Testosterona total<br />
SHBG<br />
DHEA-S<br />
Prolactina</p>

<hr />
<h2>5. Avaliação vitamínica e nutricional</h2>

<p>Vitamina B12<br />
Ácido fólico<br />
Vitamina D (25-OH)<br />
Vitamina C</p>

<p>Zinco<br />
Magnésio sérico</p>

<p>Cálcio total<br />
Cálcio iônico<br />
PTH</p>

<hr />
<h2>6. Avaliação hepática e renal</h2>

<p>AST (TGO)<br />
ALT (TGP)<br />
GGT</p>

<p>Ureia<br />
Creatinina</p>

<hr />
<h2>8. COPROLÓGICO FUNCIONAL COMPLETO</h2>

<p>&nbsp;</p>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-03-09 12:44:30'),
  ('79685099120', 'prescricao', '<p>&nbsp;</p>
&nbsp;

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche</span><br />
<br />
3-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
4-<br />
Sais biliares 300 mg<br />
<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, antes<br />
do almoço e jantar. Por 60 dias<br />
<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-03-11 16:53:39'),
  ('07943713109', 'prescricao', '<strong>Reparação intestinal e gastrite</strong><br />
<br />
Fórmula 1 – Reparação da mucosa intestinal<br />
<br />
L-glutamina — 5 g<br />
Zinco carnosina — 75 mg<br />
N-acetil glucosamina — 300 mg<br />
Deglicirrizinado de alcaçuz (DGL) — 200 mg<br />
<br />
Modo de usar:<br />
1 dose em jejum pela manhã diluído em água.<br />
Função clínica<br />
regeneração da mucosa intestinal<br />
melhora gastrite<br />
redução da permeabilidade intestinal.<br />
<br />
Fórmula 2 – Modulador inflamatório e anti-histamínico<br />
<br />
Quercetina — 500 mg<br />
Vitamina C — 500 mg<br />
Bromelina — 200 mg<br />
Curcumina fitossomada — 250 mg<br />
<br />
Modo de usar:<br />
1 cápsula 2x ao dia após refeições.<br />
<br />
3- Regulação metabólica e compulsão por doce<br />
Fórmula 3 – Estabilização metabólica<br />
<br />
Magnésio bisglicinato — 200 mg<br />
Taurina — 250 mg<br />
Inositol — 500 mg<br />
Cromo picolinato — 100 mcg<br />
<br />
Modo de usar:<br />
2 cápsulas à noite.<br />
<br />
4- Modulação intestinal leve (terreno fermentativo)<br />
Fórmula 4 – Modulador intestinal<br />
<br />
Berberina — 300 mg<br />
Extrato de própolis verde — 150 mg<br />
Óleo essencial de orégano microencapsulado — 50 mg<br />
<br />
Modo de usar:<br />
1 cápsula 2x ao dia antes das refeições por 30 dias.<br />
<br />
<strong>Evitar whey de leite por enquanto.<br />
Boas opções que costumo ver boa tolerância clínica:</strong><br />
<br />
6-&nbsp; Puravida – Plant Protein ou&nbsp;<br />
&nbsp;Essential Nutrition – Veggie Protein<br />
<br />
1 dose (20–25 g proteína) após treino<br />
ou<br />
no café da manhã quando necessário.<br />
<br />
Pode bater com:<br />
leite de coco<br />
canela ( evitar a noite)<br />
gelo. (se preferir)<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-11 17:49:31'),
  ('15433080153', 'prescricao', '<p><strong>Exame solicitado:</strong><br />
Polissonografia noturna completa (tipo I) com monitorização cardiorrespiratória.</p>

<p><strong>Indicação clínica:</strong><br />
Paciente com queixa de <strong>sono não reparador</strong>, despertares frequentes e fadiga diurna. Apresenta ainda <strong>história de refluxo gastroesofágico e tosse seca persistente</strong>, com possível associação a distúrbios respiratórios do sono.</p>

<p>Considerando a idade da paciente, a persistência de sintomas e a possibilidade de <strong>distúrbio respiratório do sono, incluindo síndrome da apneia/hipopneia obstrutiva do sono</strong>, solicita-se realização de <strong>polissonografia noturna completa para avaliação da arquitetura do sono, eventos respiratórios, saturação de oxigênio, microdespertares e movimentos periódicos de membros</strong>.</p>

<p><strong>CID sugeridos:</strong></p>

<ul>
	<li>
	<p>G47.3 – Apneia do sono</p>
	</li>
	<li>
	<p>G47.9 – Distúrbio do sono não especificado</p>
	</li>
	<li>
	<p>R53 – Fadiga</p>
	</li>
	<li>
	<p>R05 – Tosse</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-03-16 09:58:44'),
  ('15433080153', 'prescricao', '<h1>Reposição Hormonal Sugerida</h1>

<h2>1. Estradiol transdérmico</h2>

<p>Veículo: <strong>Pentravan®</strong></p>

<p>Estradiol bioidêntico .......... <strong>0,75 mg/g</strong></p>

<p>Aplicar <strong>1 pump ao dia</strong><br />
Face interna da coxa, alternando lados.</p>

<p>&nbsp;</p>

<hr />
<h2>2. Progesterona micronizada</h2>

<p>Cápsulas gastro-resistentes</p>

<p>Progesterona micronizada .......... <strong>100 mg</strong></p>

<p>Tomar <strong>1 cápsula à noite diariamente</strong>.</p>

<p>Benefícios:</p>

<ul>
	<li>
	<p>melhora sono</p>
	</li>
	<li>
	<p>proteção endometrial</p>
	</li>
	<li>
	<p>ação ansiolítica</p>
	</li>
	<li>
	<p>melhora arquitetura do sono</p>
	</li>
</ul>

<hr />
<h2>3. Testosterona transdérmica</h2>

<p>Veículo: <strong>Pentravan®</strong></p>

<p>Testosterona bioidêntica .......... <strong>&nbsp;3mg/g</strong></p>

<p>Aplicar <strong>1 pump ao dia</strong></p>

<p>Região de aplicação:</p>

<ul>
	<li>
	<p>face interna da coxa</p>
	</li>
	<li>
	<p>atrás do joelho</p>
	</li>
	<li>
	<p>atrás do tornozelo</p>
	</li>
</ul>

<p>? Dose menor que a atual (3 mg), mais adequada para mulher de 69 anos.</p>

<hr />
<h2>4. DHEA (muito baixo)</h2>

<p>Cápsulas gastro-resistentes</p>

<p>DHEA .......... <strong>10 mg</strong></p>

<p>Tomar <strong>1 cápsula pela manhã</strong></p>

<p>Benefícios:</p>
', 'Danielle Candia Barra', '2026-03-16 10:02:08'),
  ('15433080153', 'prescricao', '<h3>RECEITA MÉDICA</h3>

<p><strong>Paciente:</strong> Vera Lúcia do Amaral</p>

<p><strong>PEG 4000 (Polietilenoglicol 4000) – sachê 10 g</strong></p>

<p>Tomar <strong>01 sachê diluído em 200 mL de água</strong>, <strong>1 a 2 vezes ao dia</strong>, preferencialmente <strong>à noite</strong>, conforme necessidade para regularização do trânsito intestinal.</p>

<p><strong>Quantidade:</strong> 60 sachês</p>

<p><strong>Duração estimada:</strong> 30 dias</p>

<p><strong>Orientações:</strong></p>

<ul>
	<li>
	<p>Manter adequada ingestão de água (mínimo 1,5–2 litros/dia).</p>
	</li>
	<li>
	<p>Associar aumento gradual de fibras alimentares.</p>
	</li>
	<li>
	<p>Ajustar dose conforme resposta intestinal.</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-03-16 10:06:53'),
  ('15433080153', 'prescricao', '<h1><br />
<br />
<br />
<br />
<br />
<br />
<br />
Reposição Hormonal Sugerida</h1>

<h2>1. Estradiol transdérmico</h2>

<p>Veículo:&nbsp;<strong>Pentravan®</strong></p>

<p>Estradiol bioidêntico ..........&nbsp;<strong>0,75 mg/g</strong></p>

<p>Aplicar&nbsp;<strong>1 pump ao dia</strong><br />
Face interna da coxa, alternando lados.</p>

<p>&nbsp;</p>

<hr />
<h2>2. Progesterona micronizada</h2>

<p>Cápsulas gastro-resistentes</p>

<p>Progesterona micronizada ..........&nbsp;<strong>100 mg</strong></p>

<p>Tomar&nbsp;<strong>1 cápsula à noite diariamente</strong>.</p>

<p>Benefícios:</p>

<ul>
	<li>
	<p>melhora sono</p>
	</li>
	<li>
	<p>proteção endometrial</p>
	</li>
	<li>
	<p>ação ansiolítica</p>
	</li>
	<li>
	<p>melhora arquitetura do sono</p>
	</li>
</ul>

<hr />
<h2>3. Testosterona transdérmica</h2>

<p>Veículo:&nbsp;<strong>Pentravan®</strong></p>

<p>Testosterona bioidêntica ..........&nbsp;<strong>&nbsp;3mg/g</strong></p>

<p>Aplicar&nbsp;<strong>1 pump ao dia</strong></p>

<p>Região de aplicação:</p>

<ul>
	<li>
	<p>face interna da coxa</p>
	</li>
	<li>
	<p>atrás do joelho</p>
	</li>
	<li>
	<p>atrás do tornozelo</p>
	</li>
</ul>

<p>&nbsp;Dose menor que a atual (3 mg), mais adequada para mulher de 69 anos.</p>

<hr />
<h2>4. DHEA (muito baixo)</h2>

<p>Cápsulas gastro-resistentes</p>

<p>DHEA ..........&nbsp;<strong>10 mg</strong></p>

<p>Tomar&nbsp;<strong>1 cápsula pela manhã</strong></p>

<p>Benefícios:</p>
', 'Danielle Candia Barra', '2026-03-16 10:10:40'),
  ('01663482799', 'prescricao', '<p><br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<strong>1. Ozempic® (semaglutida)</strong><br />
Apresentação: caneta 2 mg/1,5 mL – solução injetável.<br />
<strong>Posologia:</strong></p>

<ul>
	<li>
	<p>Aplicar 64<strong>&nbsp;cliques&nbsp;</strong>por via subcutânea&nbsp;<strong>1x por semana</strong>, no mesmo dia e horário,&nbsp;<strong>durante 4 semanas</strong>.</p>
	</li>
</ul>

<p><strong>Orientações:</strong></p>

<ul>
	<li>
	<p>Aplicar no abdome, coxa ou braço, alternando locais.</p>
	</li>
	<li>
	<p>Manter refrigerado entre 2 °C e 8 °C; após o primeiro uso, pode ser mantido até 56 dias em temperatura ambiente (&lt;30 °C), protegido da luz.</p>
	</li>
	<li>
	<p>Utilizar agulha nova a cada aplicação e descartar em coletor apropriado.</p>
	</li>
	<li>
	<p>Se esquecer, aplicar até 5 dias após a data prevista.<br />
	<br />
	<br />
	&nbsp;</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-03-16 10:34:35'),
  ('01663482799', 'prescricao', '<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;
<p><strong>1. Ozempic® (semaglutida)</strong><br />
Apresentação: caneta 2 mg/1,5 mL – solução injetável.<br />
<strong>Posologia:</strong></p>

<ul>
	<li>
	<p>Aplicar 64<strong>&nbsp;cliques&nbsp;</strong>por via subcutânea&nbsp;<strong>1x por semana</strong>, no mesmo dia e horário,&nbsp;<strong>durante 4 semanas</strong>.</p>
	</li>
</ul>

<p><strong>Orientações:</strong></p>

<ul>
	<li>
	<p>Aplicar no abdome, coxa ou braço, alternando locais.</p>
	</li>
	<li>
	<p>Manter refrigerado entre 2 °C e 8 °C; após o primeiro uso, pode ser mantido até 56 dias em temperatura ambiente (&lt;30 °C), protegido da luz.</p>
	</li>
	<li>
	<p>Utilizar agulha nova a cada aplicação e descartar em coletor apropriado.</p>
	</li>
	<li>
	<p>Se esquecer, aplicar até 5 dias após a data prevista.</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-03-16 10:35:16'),
  ('85260665104', 'prescricao', 'Uso oral&nbsp;<br />
<br />
para manipular&nbsp;<br />
<br />
1-<br />
Betaína HCL ..................... 500 mg<br />
Extrato de Neem .................. 200 mg<br />
Alho (extrato padronizado) ... 300 mg
<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>Tomar <strong>1 cápsula 2x ao dia antes das refeições principais</strong><br />
(almoço e jantar)<br />
&nbsp;</p>
2-

<p>Óleo de Orégano (mínimo 60% carvacrol)<br />
150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula <strong>2x ao dia após refeições<br />
<br />
3-</strong></p>

<p>Extrato de gengibre ............ 200 mg<br />
5-HTP ................................. 50 mg<br />
Magnésio citrato ............... 150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong><br />
1 cápsula após o jantar e<br />
1 cápsula antes de dormir<br />
<br />
4-</p>

<p>Triphala extrato seco ......... 400 mg<br />
Aloe vera extrato seco ...... 150 mg<br />
Ruibarbo extrato ................. 50 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula à noite após o jantar</p>

<p>Se necessário pode aumentar para <strong>2 cápsulas</strong>.</p>

<p><br />
<strong>tratamento - 30 dias - após esse tratamento agendar nova consulta para evoluirmos&nbsp;</strong><br />
&nbsp;</p>

<h1>&nbsp;</h1>

<p>&nbsp;</p>
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-16 11:10:02'),
  ('34600779134', 'prescricao', '<h3>** Tratamento 90 dias**</h3>

<h1>Complexo B Sublingual – Fórmula Enxuta</h1>

<p><strong>Forma:</strong> gotas sublinguais<br />
<strong>Frasco:</strong> 30 mL</p>

<h3>Composição por dose (10 gotas)</h3>

<p>Metilcobalamina (B12 ativa) – <strong>1000 mcg</strong><br />
Piridoxal-5-fosfato (B6 ativa) – <strong>10 mg</strong><br />
Riboflavina-5-fosfato (B2 ativa) – <strong>10 mg</strong><br />
5-Metiltetrahidrofolato (5-MTHF) – <strong>400 mcg</strong></p>

<h3>Posologia</h3>

<p>Tomar <strong>10 gotas sublinguais pela manhã</strong>, manter sob a língua por 30–60 segundos antes de engolir.</p>

<h3><br />
<small><strong>Magnésio – associação dos quatro melhores tipos</strong></small></h3>

<p><small><strong>Fórmula manipulada – tomar 1 cápsula à noite antes de dormir</strong></small></p>

<p><small>Magnésio&nbsp;<strong>Bisglicinato</strong>&nbsp;– 100 mg</small></p>

<p><small>Magnésio&nbsp;<strong>Dimalato</strong>&nbsp;– 100 mg</small></p>

<p><small>Magnésio&nbsp;<strong>Treonato</strong>&nbsp;– 100 mg</small></p>

<p><small>Magnésio&nbsp;<strong>Citrato</strong>&nbsp;– 100 mg</small></p>

<p><small>&nbsp;<strong>Objetivo:</strong>&nbsp;suporte neuromuscular, melhora do sono, redução de cãibras e relaxamento muscular.</small></p>

<h1>Antioxidante / Detox celular</h1>

<p><strong>60 dias seguintes</strong></p>

<p>1 cápsula 2x/dia</p>

<p>N-acetil-cisteína – 300 mg<br />
Quercetina – 200 mg<br />
Vitamina C – 250 mg<br />
Coenzima Q10 – 100 mg<br />
Selênio – 100 mcg</p>

<p>&nbsp;</p>

<h3><br />
<small><strong>Vitaminas lipossolúveis</strong></small></h3>

<p><small><strong>1 cápsula ao dia, após o almoço</strong></small></p>

<p><small>Vitamina D3 – 6000 UI</small></p>

<p><small>Vitamina K2 (MK-7) – 100 mcg</small></p>

<p><small>Vitamina E natural (d-alfa-tocoferol) – 100 UI</small></p>

<p><small>&nbsp;<strong>Objetivo:</strong>&nbsp;suporte cardiovascular, ósseo e cognitivo.</small></p>
<br />
&nbsp;', 'Danielle Candia Barra', '2026-03-16 11:38:12'),
  ('85260665104', 'prescricao', 'Uso oral&nbsp;<br />
<br />
para manipular&nbsp;<br />
<br />
1-<br />
Betaína HCL ..................... 500 mg<br />
Alho (extrato padronizado) ... 300 mg
<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>Tomar <strong>1 cápsula 2x ao dia antes das refeições principais</strong><br />
(almoço e jantar)<br />
&nbsp;</p>
2-

<p>Óleo de Orégano (mínimo 60% carvacrol)<br />
150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula <strong>2x ao dia após refeições<br />
<br />
3-</strong></p>

<p>Extrato de gengibre ............ 200 mg<br />
5-HTP ................................. 50 mg<br />
Magnésio citrato ............... 150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong><br />
1 cápsula após o jantar e<br />
1 cápsula antes de dormir<br />
<br />
4-<br />
Aloe vera extrato seco ...... 150 mg<br />
Ruibarbo extrato ................. 50 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula à noite após o jantar</p>

<p>Se necessário pode aumentar para <strong>2 cápsulas</strong>.</p>

<p><br />
<strong>tratamento - 30 dias - após esse tratamento agendar nova consulta para evoluirmos&nbsp;</strong><br />
&nbsp;</p>

<h1>&nbsp;</h1>

<p>&nbsp;</p>
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-16 11:48:29'),
  ('79453430153', 'prescricao', NULL, 'Ana Carolina Candia Barra', '2026-03-18 14:33:36'),
  ('79453430153', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span><br />
<br />
1-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ashwagandha (Withania somnifera) extrato padronizagdo 5% withanolídeos500mg<br />
5htp 100mg<br />
valeriana 300mg<br />
PQQ 10mg<br />
<br />
Tomar 1 x ao dia, ante sde dormir Por 60 dias.&nbsp;<br />
&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-03-18 14:41:10'),
  ('52367959153', 'prescricao', 'Uso oral&nbsp;<br />
<br />
para manipular&nbsp;<br />
<br />
1-<br />
Betaína HCl ..................... 500 mg<br />
Extrato de Neem .................. 200 mg<br />
Alho (extrato padronizado) ... 300 mg
<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>Tomar&nbsp;<strong>1 cápsula 2x ao dia antes das refeições principais</strong><br />
(almoço e jantar)<br />
&nbsp;</p>
2-

<p>Óleo de Orégano (mínimo 60% carvacrol)<br />
150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula&nbsp;<strong>2x ao dia após refeições<br />
<br />
3-</strong></p>

<p>Extrato de gengibre ............ 200 mg<br />
5-HTP ................................. 50 mg<br />
Magnésio citrato ............... 150 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong><br />
1 cápsula após o jantar e<br />
1 cápsula antes de dormir<br />
<br />
4- Fórmula para melhorar motilidade e transito intestinal&nbsp;<br />
<br />
Aloe vera extrato seco ...... 150 mg<br />
Ruibarbo extrato ................. 50 mg</p>

<p>60 cápsulas</p>

<p><strong>Posologia</strong></p>

<p>1 cápsula à noite após o jantar</p>

<p>Se necessário pode aumentar para&nbsp;<strong>2 cápsulas</strong>.</p>
', 'Ana Carolina Candia Barra', '2026-03-18 15:07:35'),
  ('25520199191', 'prescricao', '<p><small><strong>Uso interno<br />
<br />
1-</strong></small></p>
<small>Protease...............................................75mg<br />
Amilase................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................100mg<br />
Pepsina.................................................25mg</small>

<p><small>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
2-<br />
<br />
Sais biliares.......................................150 mg<br />
<br />
Tomar 1 dose junto com o alimento no almoço e no jantar por 30 dias.&nbsp;<br />
&nbsp;<br />
3-</small></p>
<br />
<small>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</small>

<p><small>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</small></p>
', 'Ana Carolina Candia Barra', '2026-03-19 15:14:48'),
  ('60857148311', 'prescricao', 'Via oral<br />
<br />
1- durante a fase 1 do tratamento - 30 dias.&nbsp;<br />
<br />
Saccharomyces boulardii - 250mg<br />
<br />
tomar de 1 x ao dia em jejum - 30 minutos antes do café da manhã.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-21 10:48:06'),
  ('00460983130', 'prescricao', '<h3>*** Fórmula para 90 dias&nbsp;<br />
<br />
<br />
1)&nbsp; Regulação emocional e eixo HPA</h3>

<p>(cápsulas gastro-resistentes)</p>

<ul>
	<li>Magnésio bisglicinato .......... 150 mg</li>
	<li>Magnésio treonato .............. 100 mg</li>
	<li>Taurina ............................... 250 mg</li>
	<li>Glicina ................................ 300 mg</li>
	<li>L-teanina ............................ 150 mg</li>
	<li>Inositol .............................. 200 mg</li>
	<li>Vitamina B6 (P5P) .............. 25 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
1 cápsula à noite.&nbsp;<br />
<br />
&nbsp;</p>

<h3>&nbsp;2)&nbsp;&nbsp;Anti-inflamatória intestinal + pélvica</h3>

<ul>
	<li>Boswellia serrata (20% AKBA) .... 100 mg</li>
	<li>Curcumina fitossomada ............. 150 mg</li>
	<li>N-acetil-cisteína ....................... 300 mg</li>
	<li>Zinco quelado .......................... 15 mg</li>
	<li>Vitamina C .............................. 200 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
1 cápsula 2x ao dia, durante as refeições.<br />
<br />
<br />
&nbsp;</p>

<h3>3)Suporte hormonal fisiológico</h3>

<ul>
	<li>Myo-inositol ....................... 500 mg</li>
	<li>Colina ................................. 100 mg</li>
	<li>Vitamina B1 ....................... 25 mg</li>
	<li>Vitamina B2 ....................... 20 mg</li>
	<li>Vitamina B3 ....................... 50 mg</li>
	<li>Vitamina B5 ....................... 50 mg</li>
	<li>Vitamina D3 .......................3000 unidades</li>
</ul>

<p><strong>Posologia:</strong><br />
1 cápsula pela manhã.<br />
<br />
<br />
&nbsp;</p>

<h3>4) Probiótico direcionado</h3>

<ul>
	<li>Lactobacillus rhamnosus</li>
	<li>Lactobacillus plantarum</li>
	<li>Bifidobacterium longum</li>
</ul>

<p><strong>Posologia:</strong> 1 dose/dia.Antes de dormir.</p>
', 'Danielle Candia Barra', '2026-03-23 10:53:15'),
  ('00460983130', 'prescricao', '<p><strong>Progesterona micronizada 100 mg</strong><br />
Cápsulas</p>

<p>Tomar <strong>1 cápsula por via oral à noite</strong>, do <strong>14º ao 26º dia do ciclo menstrual</strong>.</p>

<p>Caso ciclos irregulares: usar por <strong>10 a 12 dias ao mês</strong>.</p>

<p>Três ciclos</p>

<p><br />
<br />
<strong>Orientações:</strong></p>

<ul>
	<li>Uso noturno devido efeito sedativo fisiológico</li>
	<li>Manter acompanhamento clínico durante lactação</li>
	<li>Observar possíveis efeitos: sonolência excessiva ou redução do volume de leite</li>
</ul>
', 'Danielle Candia Barra', '2026-03-23 10:55:44'),
  ('00460983130', 'prescricao', '<p><strong>CID:</strong> Z00.0</p>

<hr />
<h2><strong>Exames solicitados:</strong></h2>

<ul>
	<li>Ultrassonografia transvaginal</li>
	<li>Ultrassonografia de mamas bilateral</li>
	<li>Ultrassonografia de abdome total</li>
	<li>Ultrassonografia de tireoide com Doppler</li>
</ul>

<hr />
<h2><strong>Justificativa clínica:</strong></h2>

<p>Paciente em avaliação metabólica, hormonal e inflamatória, em período pós-gestacional com retorno recente dos ciclos menstruais.</p>

<p>Apresenta irregularidade do eixo hormonal, sintomas perimenstruais (cólicas, distensão abdominal), além de acompanhamento de composição corporal e metabolismo.</p>

<p>Solicitação com objetivo de:</p>

<ul>
	<li>Avaliação do padrão ovariano e endometrial</li>
	<li>Rastreio de alterações mamárias</li>
	<li>Investigação abdominal (fígado, vias biliares, pâncreas e rins)</li>
	<li>Avaliação morfológica e vascular da tireoide</li>
</ul>
', 'Danielle Candia Barra', '2026-03-23 10:58:48'),
  ('00460983130', 'prescricao', '<p><strong>Testosterona bioidêntica transdérmica 0,5 mg/dia</strong><br />
(adesivo transdérmico)</p>

<hr />
<p><strong>Posologia:</strong></p>

<p>Aplicar <strong>1 dose ao dia</strong>, pela manhã, em pele íntegra e seca.</p>

<p><strong>Locais sugeridos:</strong><br />
abdome inferior ou face interna da coxa</p>

<p>Alternar locais diariamente</p>
', 'Danielle Candia Barra', '2026-03-23 11:03:49'),
  ('00460983130', 'prescricao', '<p>Atesto, para os devidos fins, que a paciente <strong>Ana Claudia Negret Scalia</strong> esteve em consulta médica nesta data, necessitando de afastamento de suas atividades habituais por <strong>01 (um) dia</strong>, para avaliação clínica e cuidados de saúde.</p>

<p><strong>CID:</strong> N94.3 – Síndrome pré-menstrual</p>

<hr />
<hr />
<p>Dra. Danielle Candia Barra<br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2026-03-23 11:05:06'),
  ('21639183191', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1<br />
Cobalto quelato 100 mcg<br />
Vitamina K2 120 mcg<br />
Metilfolato 500 mcg<br />
Metilcobalamina 1 mg<br />
Cobre Quelato 1,5 mg<br />
Ferro Quelato 14 mg<br />
Magnésio Quelato 150 mg<br />
Cálcio Carbonato 730 mg<br />
selênio metionina 1% 50mcg<br />
picolinato de cromo 50mcg<br />
<br />
Tomar uma dose após almoço e jantar. Por 30 dias<br />
<br />
2-</span><br />
<br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>3-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 400 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
vitamina C ( acido ascorbico) 500mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span><br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-24 10:39:51'),
  ('15433080153', 'prescricao', '<p>1-&nbsp;</p>

<p>Betaina HCl ..................................................................300 mg<br />
<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar. Por 60 dias.<br />
&nbsp;</p>

<p>2- (protetor gastrico e muco)</p>

<p>Espinheira santa.............................................................. 500 mg<br />
Alfafa extrato seco........................................................... 500 mg<br />
Uncaria tomentosa .............................................................250 mg<br />
Coenzima Q10................................................................... 50 mg<br />
Mucosave® (Opuntia ficus indica) FG.............................................400mg<br />
<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche da tarde. Por 60 dias<br />
<br />
3- Enzimas digestivas</p>
Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg
<p>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia ( almoço e jantar). Por 60 dias<br />
<br />
4-</p>
Melatonina Time release......................2,5mg<br />
Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula. Por 60 dias<br />
<br />
8-<br />
Vitamina D 3..........................................4000ui<br />
Vitamina K2...........................................100mg<br />
Vitamina A...........................................1250ui
<p>30 pastilhas</p>

<p>Sorver 2&nbsp;pastilhas sublingual uma vez ao dia após o&nbsp;almoço.&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-03-24 15:58:26'),
  ('04937069179', 'prescricao', 'Uso oral<br />
<br />
GABA ( Pharma GABA) - 100MG<br />
TAURINA - 250MG<br />
MAGNÉSIO BISGLICINATO - 100MG<br />
GLICINA- 250MG<br />
INOSITOL - 250MG<br />
l-TEANINA - 100MG<br />
<br />
Tomar 2 doses a noite antes de dormir. por 30 dias&nbsp; e avaliar .<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-26 14:47:42'),
  ('75538784134', 'prescricao', 'uso oral&nbsp;<br />
<br />
1-&nbsp;
<ul>
	<li>Mucosave® – 150 mg</li>
	<li>L-Glutamina – 2 g</li>
	<li>zinco carnosina -&nbsp; 37,5mg</li>
</ul>

<p><strong>Forma:</strong> sachê<br />
Tomar 1 sachê 1 a 2x ao dia, em jejum ou antes das principais refeições.<br />
<br />
2-</p>

<ul>
	<li>DGL (Alcaçuz deglicirrizinado) – 100 mg</li>
	<li>Enzimas digestivas (blend leve) – 100 mg</li>
	<li>Magnésio bisglicinato – 100 mg</li>
</ul>

<p><strong>Forma:</strong> cápsulas<br />
Tomar 1 cápsula antes do almoço e jantar.<br />
<br />
3-</p>

<ul>
	<li>Quercetina – 150 mg</li>
	<li>Vitamina C – 200 mg</li>
	<li>NAC (N-acetilcisteína) – 300 mg</li>
	<li>Vitamina B6 – 10 mg</li>
</ul>

<p><strong>Forma:</strong> cápsulas<br />
<strong>Posologia:</strong><br />
Tomar 1 cápsula 2x ao dia. manhã e noite antes de dormir.</p>
', 'Ana Carolina Candia Barra', '2026-03-26 15:13:13'),
  ('91163471100', 'prescricao', '1.&nbsp;&nbsp;COMPOSTO ANTIMICROBIANO INTESTINAL<br />
Fórmula (cápsulas):<br />
<br />
Berberina ..................................... 300 mg<br />
Óleo essencial de orégano .......... 150 mg<br />
Alho (extrato seco) ....................... 200 mg<br />
Extrato de própolis ....................... 100 mg<br />
Artemísia ....................................... 150 mg<br />
<br />
1 cápsula 2x ao dia, antes do almoço e jantar<br />
<br />
&nbsp;Ação:<br />
Bactérias fermentadoras<br />
<br />
2.&nbsp;&nbsp;SUPORTE DIGESTIVO COMPLETO<br />
Fórmula (cápsulas):<br />
Betaína HCl ................................. 300 mg (avaliar tolerância)<br />
Pepsina ......................................... 50 mg<br />
Pancreatina ................................. 200 mg<br />
Bromelina ..................................... 100 mg<br />
<br />
1 cápsula no início das principais refeições<br />
<br />
3.&nbsp;&nbsp;ANTIFERMENTATIVO + CARMINATIVO<br />
Fórmula (cápsulas):<br />
Extrato de funcho ....................... 200 mg<br />
Extrato de hortelã ....................... 150 mg<br />
Gengibre ...................................... 100 mg<br />
Carvão ativado ............................ 100 mg<br />
<br />
1 cápsula após almoço e jantar<br />
<br />
Reduz:<br />
Gases<br />
Distensão<br />
Desconforto abdominal<br />
<br />
4.&nbsp;&nbsp;MODULADOR DE MOTILIDADE INTESTINAL<br />
<br />
Fórmula (cápsulas):<br />
Magnésio (bisglicinato) .............. 200 mg<br />
Vitamina B6 ................................. 25 mg<br />
<br />
1 a 2 cápsulas à noite<br />
<br />
Regular intestino<br />
Evitar fermentação por estase<br />
<br />
5.&nbsp;&nbsp;SUPORTE HEPÁTICO<br />
Fórmula (cápsulas):<br />
<br />
Silimarina (cardo mariano) ......... 200 mg<br />
Alcachofra .................................... 150 mg<br />
Dente-de-leão ............................. 150 mg<br />
<br />
1 cápsula 2x ao dia<br />
<br />
&nbsp;Ajuda:<br />
Digestão de gorduras<br />
Detox intestinal<br />
Redução de sobrecarga fermentativa<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-03-30 09:43:30'),
  ('82433542120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span><br />
&nbsp;
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-02 10:46:48'),
  ('82433542120', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso oral<br />
<br />
1<br />
<br />
Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, jun to ao almoço e jantar por 60 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-02 10:56:21'),
  ('17333920500', 'prescricao', '<p>Encaminho o(a) paciente acima para avaliação com especialista em <strong>Ortopedia</strong>, devido aos seguintes achados clínicos e de exames complementares:</p>

<ul>
	<li><strong>Densitometria óssea:</strong> compatível com <strong>osteopenia</strong></li>
	<li><strong>Ombro esquerdo:</strong> presença de <strong>tendinopatia</strong>, <strong>bursite</strong> e sinais de <strong>artrose</strong></li>
	<li><strong>Braço:</strong> sem alterações estruturais identificadas</li>
	<li><strong>Região de trapézio e subcutâneo:</strong> presença de tecido adiposo, <strong>sem evidência de nódulos</strong></li>
</ul>

<hr />
<h3>Objetivo do encaminhamento:</h3>

<ul>
	<li>Avaliação ortopédica especializada do ombro esquerdo</li>
	<li>Definição de conduta terapêutica (conservadora vs. intervencionista)</li>
	<li>Orientação quanto à reabilitação funcional e prevenção de progressão degenerativa</li>
</ul>

<hr />
<p>Atenciosamente,</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF: 22.677<br />
Nutrologia</p>
', 'Danielle Candia Barra', '2026-04-06 10:08:30'),
  ('17333920500', 'prescricao', '<h3>Indicação clínica:</h3>

<p>Avaliação do sistema vestibular em paciente com suspeita de disfunção vestibular periférica e/ou central.</p>

<hr />
<h3>Justificativa:</h3>

<p>Exame indicado para investigação de:</p>

<ul>
	<li>Vertigem</li>
	<li>Tontura</li>
	<li>Instabilidade postural</li>
	<li>Suspeita de labirintopatia</li>
	<li>Avaliação do reflexo vestíbulo-ocular</li>
</ul>

<hr />
<h3>CID sugerido:</h3>

<ul>
	<li><strong>R42</strong> – Tontura e instabilidade</li>
	<li><strong>H81.9</strong> – Transtorno vestibular não especificado</li>
</ul>

<hr />
<p>Atenciosamente,</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF: 22.677<br />
Nutrologia</p>
', 'Danielle Candia Barra', '2026-04-06 10:10:07'),
  ('17333920500', 'prescricao', '<h3>?? <strong>Explicação sobre seus exames e alimentação</strong></h3>

<p>Seus exames mostram algumas alterações importantes, e quero te explicar de forma simples o que está acontecendo no seu corpo — e por que você não se sentiu bem com a dieta anterior.</p>

<hr />
<h3>??? <strong>Sobre a dieta hiperproteica</strong></h3>

<p>Apesar de parecer contraditório, no seu caso <strong>a dieta muito rica em proteínas pode piorar o açúcar no sangue</strong>.</p>

<p>Isso acontece porque:</p>

<ul>
	<li>Quando você come muita proteína, o fígado transforma parte dela em glicose</li>
	<li>Como seu corpo está produzindo <strong>pouca insulina</strong>, essa glicose não é bem utilizada</li>
	<li>Resultado: o açúcar no sangue <strong>aumenta mesmo sem comer carboidrato</strong></li>
</ul>

<p>?? Ou seja: o problema não foi você — foi a forma como seu organismo respondeu.</p>

<hr />
<h3>?? <strong>Sobre o diabetes</strong></h3>

<p>Seus exames mostram que:</p>

<ul>
	<li>Seu açúcar médio (HbA1c) está elevado</li>
	<li>Seu corpo está produzindo <strong>menos insulina do que deveria</strong></li>
</ul>

<p>Por isso, o uso de <strong>insulina à noite e da medicação (Glyxambi)</strong> foi uma decisão correta — eles ajudam seu corpo a controlar melhor a glicose.</p>
', 'Danielle Candia Barra', '2026-04-06 10:32:17'),
  ('17333920500', 'prescricao', '<h3>&nbsp;<strong>Explicação sobre seus exames e alimentação</strong></h3>

<p>Seus exames mostram algumas alterações importantes, e quero te explicar de forma simples o que está acontecendo no seu corpo — e por que você não se sentiu bem com a dieta anterior.</p>

<hr />
<h3>&nbsp;<strong>Sobre a dieta hiperproteica</strong></h3>

<p>Apesar de parecer contraditório, no seu caso <strong>a dieta muito rica em proteínas pode piorar o açúcar no sangue</strong>.</p>

<p>Isso acontece porque:</p>

<ul>
	<li>Quando você come muita proteína, o fígado transforma parte dela em glicose</li>
	<li>Como seu corpo está produzindo <strong>pouca insulina</strong>, essa glicose não é bem utilizada</li>
	<li>Resultado: o açúcar no sangue <strong>aumenta mesmo sem comer carboidrato</strong></li>
</ul>

<p>&nbsp;Ou seja: o problema não foi você — foi a forma como seu organismo respondeu.</p>

<hr />
<h3>&nbsp;<strong>Sobre o diabetes</strong></h3>

<p>Seus exames mostram que:</p>

<ul>
	<li>Seu açúcar médio (HbA1c) está elevado</li>
	<li>Seu corpo está produzindo <strong>menos insulina do que deveria</strong></li>
</ul>

<p>Por isso, o uso de <strong>insulina à noite e da medicação (Glyxambi)</strong> foi uma decisão correta — eles ajudam seu corpo a controlar melhor a glicose.</p>
', 'Danielle Candia Barra', '2026-04-06 10:32:46'),
  ('17333920500', 'prescricao', '<p><strong>Polietilenoglicol (PEG) 4000 – pó para solução oral</strong></p>

<p>&nbsp;<strong>Posologia:</strong><br />
Dissolver <strong>01 sachê (13 a 17 g)</strong> em 200 mL de água e ingerir <strong>1 vez ao dia</strong>, preferencialmente à noite.</p>

<p>&nbsp;<strong>Ajuste de dose:</strong><br />
Se necessário, pode ajustar para <strong>½ a 2 sachês ao dia</strong>, conforme resposta intestinal.</p>

<hr />
<h3>&nbsp;Orientações:</h3>

<ul>
	<li>Manter boa ingestão hídrica ao longo do dia</li>
	<li>Efeito esperado: melhora do trânsito intestinal sem causar cólicas</li>
	<li>Pode levar de 24 a 72 horas para efeito pleno</li>
	<li>Uso seguro para períodos mais prolongados, conforme orientação médica</li>
</ul>

<hr />
<h3>CID sugerido:</h3>

<ul>
	<li><strong>K59.0 – Constipação intestinal</strong></li>
</ul>
', 'Danielle Candia Barra', '2026-04-06 10:33:57'),
  ('17333920500', 'prescricao', '<p><strong>Quercetina</strong>&nbsp;– 400 mg<br />
<strong>Vitamina C</strong>&nbsp;– 250 mg<br />
<strong>Boswellia serrata (20% AKBA)</strong>&nbsp;– 50 mg<br />
<strong>Curcumina fitossomada</strong>&nbsp;– 250 mg<br />
<strong>Zinco quelato</strong>&nbsp;– 20 mg<br />
<br />
&nbsp;</p>

<p>Tomar 1 cápsula 2x ao dia após as refeições.<br />
<br />
<br />
Manipular 60 cápsulas gastro-resistentes.</p>
', 'Danielle Candia Barra', '2026-04-06 10:36:19'),
  ('17333920500', 'prescricao', '<p>Aqui está o endereço do <strong>IBO – Instituto Brasileiro de Otorrinolaringologia</strong>:</p>

<p>?? <strong>Endereço:</strong><br />
SHLS 716, Bloco E, Consultórios Médicos<br />
Centro Clínico Sul – Asa Sul<br />
Brasília – DF, Brasil</p>

<p>?? <strong>Telefone/WhatsApp:</strong> (21) 98497-4377</p>
', 'Danielle Candia Barra', '2026-04-06 10:39:44'),
  ('52367959153', 'prescricao', '<p>Uso Oral</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.<br />
<br />
3-<br />
manipular</strong></span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Cobalto quelato 100 mcg<br />
Cobre Quelato 1,5 mg<br />
Zinco Quelato 7 mg<br />
Selênio 25 mcg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</span></p>
&nbsp;

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-06 15:09:03'),
  ('52367959153', 'prescricao', '<p>Uso Oral</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.<br />
<br />
3-<br />
manipular</strong></span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Cobalto quelato 100 mcg<br />
Cobre Quelato 1,5 mg<br />
Zinco Quelato 7 mg<br />
Selênio 25 mcg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</span></p>
&nbsp;

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-06 15:09:04'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span><br />
<br />
2-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg<br />
NAC.................................................... 200mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde. por 60 dias.<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg<br />
morosil............................................... 250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias.<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - Mega DHA &nbsp;- ( marca Vitafor)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã, almoço e jantar. Por 60 dias</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-07 09:57:52'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span><br />
<br />
2-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg<br />
NAC.................................................... 200mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde. por 60 dias.<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg<br />
morosil............................................... 250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias.<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( marca Vitafor Plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã, almoço e jantar. Por 60 dias</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-07 10:54:30'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span><br />
<br />
2-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg<br />
NAC.................................................... 200mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde. por 60 dias.<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg<br />
morosil............................................... 250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias.<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( marca Vitafor Plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã, almoço e jantar. Por 60 dias</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-07 10:54:32'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1- protetor natural</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 m</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche</span></p>
', 'Ana Carolina Candia Barra', '2026-04-07 11:00:36'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)..100mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>berberina ..............................................300mg<br />
Gymnema.................................................50mg<br />
Quercetina.............................................100mg<br />
Inositol............................................... 500mg<br />
morosil............................................... 250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min,junto ao almoço. por 60 dias.<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( marca Vitafor Plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã, almoço e jantar. Por 60 dias<br />
<br />
<br />
obs: Cuidados importantes na gastrite atrófica: sempre consumir junto com o alimento&nbsp;e não consumir em jejum..</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-07 11:23:55'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)..100mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span>

<p>2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>berberina ..............................................300mg<br />
Gymnema.................................................50mg<br />
Quercetina.............................................100mg<br />
Inositol............................................... 500mg<br />
morosil............................................... 250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min,junto ao almoço. por 60 dias.<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( marca Vitafor Plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã, almoço e jantar. Por 60 dias<br />
<br />
<br />
obs: Cuidados importantes na gastrite atrófica: sempre consumir junto com o alimento&nbsp;e não consumir em jejum..</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-07 11:26:31'),
  ('04193824454', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)..100mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span>

<p>2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>berberina ..............................................300mg<br />
Gymnema.................................................50mg<br />
Quercetina.............................................100mg<br />
Inositol............................................... 500mg<br />
morosil............................................... 250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min,junto ao almoço. por 60 dias.<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( marca Vitafor Plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã, almoço e jantar. Por 60 dias<br />
<br />
<br />
obs: Cuidados importantes na gastrite atrófica: sempre consumir junto com o alimento&nbsp;e não consumir em jejum..</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-07 11:26:50'),
  ('25305212200', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................500 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>2-<br />
Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 60 dias</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>3-<br />
Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-07 14:32:18'),
  ('85260665104', 'prescricao', 'Suplementação fase 2&nbsp;<br />
<br />
1 - DISBIOSE
<div>Berberina .................................. 400 mg</div>

<div>Extrato de Alho ......................... 200 mg</div>

<div>Óleo de Orégano ..................... 100 mg</div>

<div>60 cápsulas</div>

<div>Posologia:</div>

<div>Tomar 1 cápsula 2x ao dia, 30 minutos antes do almoço e jantar<br />
&nbsp;</div>

<div>2. PROBIÓTICO (REPOVOAMENTO INTESTINAL)<br />
&nbsp;</div>

<div>Bifidobacterium longum</div>

<div>Bifidobacterium lactis</div>

<div>Lactobacillus plantarum<br />
&nbsp;</div>

<div>Total: 5 a 10 bilhões UFC</div>

<div>30 doses</div>

<div>Posologia:</div>

<div>Tomar 1 dose à noite, antes de dormir<br />
&nbsp;</div>

<div>&nbsp;3. SUPORTE DE BARREIRA INTESTINAL</div>

<div>&nbsp;</div>

<div>Butirato (tributirina ou butirato de sódio) .... 300 mg</div>

<div>Zinco carnosina ......................................... 37,5 mg</div>

<div>60 cápsulas</div>

<div>Posologia:</div>

<div>Tomar 1 cápsula 2x ao dia, junto das refeições<br />
&nbsp;</div>

<div>+ complementar separado:</div>

<div>L-glutamina em pó ............... 3 g</div>

<div>Posologia:</div>

<div>Diluir em água e tomar em jejum pela manhã<br />
&nbsp;</div>

<div>&nbsp;4. MOTILIDADE INTESTINAL</div>

<div>Magnésio citrato ............... 300 mg</div>

<div>Triphala ................................. 300 mg</div>

<div>30 cápsulas</div>

<div>Posologia:</div>

<div>Tomar 1 cápsula à noite<br />
<br />
5. EIXO NEUROINTESTINAL</div>

<div>5-HTP .................................. 50 mg</div>

<div>Posologia:</div>

<div>Tomar 1 cápsula à noite<br />
<br />
&nbsp;</div>
', 'Ana Carolina Candia Barra', '2026-04-07 23:20:29'),
  ('04937069179', 'prescricao', NULL, 'Ana Carolina Candia Barra', '2026-04-08 10:15:50'),
  ('04937069179', 'prescricao', 'Uso oral<br />
<br />
1-<br />
AdiDAO&nbsp; 4,2mg enzima diamina oxidase<br />
1 caps. antes do jantar ( 15 a 20 min.) antes.&nbsp; OU se necessário tomar antes do almoço e antes do jantar. tomar por 5 a 7 dias e relatar.<br />
<br />
2-<br />
vitamina B6 (P5P) - 25 mg<br />
zinco quelado - 15mg<br />
cobre quelado - 1 mg<br />
tomat 1 dose ao dia .<br />
<br />
3- melatonina&nbsp;<br />
tomar 2 gotas antes de dormir.&nbsp;<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-08 10:28:49'),
  ('21639183191', 'prescricao', 'uso oral
<p><br />
1-<br />
HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</p>

<p><br />
Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.</p>
', 'Ana Carolina Candia Barra', '2026-04-09 11:12:21'),
  ('02225692041', 'prescricao', '<br />
fase 1 - tratamento da disbiose&nbsp;<br />
<br />
Uso oral&nbsp;<br />
<br />
1- Berberina 500mg&nbsp;<br />
<br />
Tomar 1 caps. 2 x ao dia&nbsp; ( 30 min. antes do almoço e jantar) por 30 dias.<br />
<br />
2-&nbsp;<br />
Óleo de orégano - 150mg&nbsp;<br />
tomar 1 caps. 2 x ao dia (após o almoço e jantar) por 30 dias.<br />
<br />
3-<br />
Extrato de alho 400mg<br />
tomar 2 x ao dia junto as refeições ( almoço e jantar) por 30 dias<br />
<br />
4-<br />
Vitamina B6 (P5P) 25mg<br />
Vitamina B2 ( riboflavina) 25mg<br />
Coenzima Q10 100mg<br />
Tomar 1 x ao dia pela manhã - por 30 dias&nbsp;<br />
<br />
5-<br />
Triphala 500mg<br />
Curcumina 250mg<br />
magnésio bisglicinato 200mg<br />
<br />
Tomar 1 dose antes de dormir por 30 dias.&nbsp; pode tomar até 2 doses se não melhorar a evacuação, relatar após 10 dias de uso.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-10 17:41:28'),
  ('78380782615', 'prescricao', 'Uso oral<br />
<br />
1 - Suporte hepatico.<br />
<br />
Silimarina...................300mg<br />
NAC............................600mg<br />
Ácido alfa lipoico.........300mg<br />
<br />
Tomar 1 dose 1 x ao dia pela manhã. por 30 dias', 'Ana Carolina Candia Barra', '2026-04-14 15:00:55'),
  ('15433080153', 'prescricao', '<h3>Perfil Hormonal Sexual</h3>

<ul>
	<li>Estradiol (E2)</li>
	<li>Progesterona</li>
	<li>Testosterona total</li>
	<li>Testosterona livre</li>
	<li>SHBG (Globulina ligadora de hormônios sexuais)</li>
	<li>DHEA-S (Sulfato de dehidroepiandrosterona)</li>
	<li>Androstenediona</li>
	<li>LH (Hormônio luteinizante)</li>
	<li>FSH (Hormônio folículo-estimulante)</li>
	<li>TSH, t4 livre e t3 livre&nbsp;</li>
</ul>

<hr />
<h3>Orientações para coleta</h3>

<ul>
	<li>Preferencialmente <strong>coletar pela manhã (até 10h)</strong></li>
	<li>Manter uso habitual das medicações (se em reposição hormonal, coletar conforme rotina para avaliação do nível sérico)</li>
	<li>Informar uso de hormônios ao laboratório</li>
</ul>

<hr />
<h3>Indicação clínica</h3>

<p>Avaliação do eixo hormonal feminino em paciente menopausada em uso de <strong>terapia de reposição hormonal</strong>, com objetivo de ajuste terapêutico, monitorização de níveis séricos e segurança metabólica.</p>

<hr />
<p><strong>CID sugeridos:</strong></p>

<ul>
	<li>Z79.890 – Uso de terapia hormonal</li>
	<li>N95.1 – Estado menopausal e climatério</li>
	<li>E34.9 – Transtorno endócrino não especificado</li>
</ul>
', 'Danielle Candia Barra', '2026-04-20 09:43:55'),
  ('15433080153', 'prescricao', '<h1>Reposição Hormonal Sugerida</h1>

<h2>1. Estradiol transdérmico</h2>

<p>Veículo:&nbsp;<strong>Pentravan®</strong></p>

<p>Estradiol bioidêntico ..........&nbsp;<strong>0,75 mg/g</strong></p>

<p>Aplicar&nbsp;<strong>1 pump ao dia</strong><br />
Face interna da coxa, alternando lados.</p>

<p>&nbsp;</p>

<hr />
<h2>2. Progesterona micronizada</h2>

<p>Cápsulas gastro-resistentes</p>

<p>Progesterona micronizada ..........&nbsp;<strong>100 mg</strong></p>

<p>Tomar&nbsp;<strong>1 cápsula à noite diariamente</strong>.</p>

<p>Benefícios:</p>

<ul>
	<li>
	<p>melhora sono</p>
	</li>
	<li>
	<p>proteção endometrial</p>
	</li>
	<li>
	<p>ação ansiolítica</p>
	</li>
	<li>
	<p>melhora arquitetura do sono</p>
	</li>
</ul>

<hr />
<h2>3. Testosterona transdérmica</h2>

<p>Veículo:&nbsp;<strong>Pentravan®</strong></p>

<p>Testosterona bioidêntica ..........&nbsp;<strong>&nbsp;3mg/g</strong></p>

<p>Aplicar&nbsp;<strong>1 pump ao dia</strong></p>

<p>Região de aplicação:</p>

<ul>
	<li>
	<p>face interna da coxa</p>
	</li>
	<li>
	<p>atrás do joelho</p>
	</li>
	<li>
	<p>atrás do tornozelo</p>
	</li>
</ul>

<p>&nbsp;Dose menor que a atual (3 mg), mais adequada para mulher de 69 anos.</p>

<hr />
<h2>4. DHEA (muito baixo)</h2>

<p>Cápsulas gastro-resistentes</p>

<p>DHEA ..........&nbsp;<strong>10 mg</strong></p>

<p>Tomar&nbsp;<strong>1 cápsula pela manhã</strong></p>
', 'Danielle Candia Barra', '2026-04-20 09:45:06'),
  ('15433080153', 'prescricao', 'Uso oral&nbsp;<br />
<br />
<br />
<br />
1) Velija 30mg ------------------------- 02 caixas&nbsp;<br />
<br />
<br />
Tomar 01 dose ao dia.', 'Danielle Candia Barra', '2026-04-20 09:45:57'),
  ('15433080153', 'prescricao', '<h3>FORMULA PRINCIPAL METABOLICA ANTI INFLAMATORIA</h3>

<p>1)Vitamina D3 5000 UI<br />
Vitamina K2 MK7 100 mcg<br />
<br />
Tomar 01 cp pela manhã.<br />
<br />
<br />
2) Quercetina 400 mg<br />
N acetil cisteina 150 mg<br />
Zinco quelato 20 mg<br />
Selenio 100 mcg<br />
Vitamina C 250 mg</p>

<p>Tomar 1 capsula 2 vezes ao dia</p>

<h3>&nbsp;</h3>

<h3>FORMULA SONO</h3>

<p>3) Magnesio bisglicinato 200 mg<br />
Magnesio treonato 150 mg<br />
Glicina 2000 mg<br />
Melatonina 2 mg</p>

<p>Tomar 1 dose a noite<br />
<br />
4)&nbsp;<strong>Ômega Plus Vitafor</strong></p>

<p>Tomar <strong>2 cápsulas ao dia</strong>, junto às principais refeições.</p>

<p><strong>Quantidade:</strong> 120 cápsulas</p>

<p><strong>Duração:</strong> 60 dias</p>

<h1>&nbsp;</h1>
', 'Danielle Candia Barra', '2026-04-20 09:53:09'),
  ('15433080153', 'prescricao', '<h3>RECEITA MÉDICA</h3>

<p><strong>Paciente:</strong> Vera Lúcia do Amaral</p>

<p><strong>Progesterona micronizada 100 mg</strong></p>

<p>Opções comerciais:</p>

<ul>
	<li>Utrogestan</li>
	<li>Junno</li>
</ul>

<p>Tomar <strong>1 cápsula à noite, diariamente</strong>, via oral.</p>

<p><strong>Quantidade:</strong> 30 cápsulas</p>

<p><strong>Duração:</strong> 30 dias</p>
', 'Danielle Candia Barra', '2026-04-20 09:54:00'),
  ('07943713109', 'prescricao', 'Uso oral<br />
<br />
&nbsp;
<h1><span style=&quot;font-size:12px&quot;>1- Vitamina K2 Ydrosolv®&nbsp;- 30ml</span></h1>
Tomar 10 gotas 1 x ao dia junto ao almoço.&nbsp; Por 30 dias.<br />
<br />
2- Vitamina K2 mk7 ------------- 75mcg&nbsp;<br />
<br />
Tomar 1 x ao dia, 1 dose junto do almoço.&nbsp; Por 60 dias<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-22 14:32:28'),
  ('50425684172', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Ferro Ydrosolv® 30ml</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.<br />
<br />
4- para manipular</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.<br />
<br />
5- para manipular</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;<br />
<br />
6- para manipular</span></span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................30mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Berberina...............................................250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-04-23 13:45:27'),
  ('50425684172', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Ferro Ydrosolv® 30ml</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.<br />
<br />
4- para manipular</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.<br />
<br />
5- para manipular</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;<br />
<br />
6- para manipular</span></span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................30mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Berberina...............................................250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
7-&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( vita for Plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 2&nbsp;x ao dia - &nbsp;almoço e jantar. Por 60 dias</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-23 13:57:23'),
  ('50425684172', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 2&nbsp;gotas sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Ferro Ydrosolv® 30ml</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 10 gotas diluido em um pouco água após o almoço, não tomar café após o almoço proximo ao feero para não interferir na absorção.<br />
<br />
4- para manipular</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Coenzima Q10.........................................12.5 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.<br />
<br />
5- para manipular</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;<br />
<br />
6- para manipular</span></span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................30mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Berberina...............................................250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
7-&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<h1><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( vita for Plus)</span></span></h1>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 2&nbsp;x ao dia - &nbsp;almoço e jantar. Por 60 dias</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-23 13:58:10'),
  ('50425684172', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Saúde gástrica para manipular</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Betaina HCl ...............................................................................150&nbsp;mg<br />
Mande 60 doses.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar.</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Espinheira santa..................................................................... 500 mg<br />
Alfafa extrato seco.................................................................. 500 mg<br />
Uncaria tomentosa ..................................................................250 mg<br />
Coenzima Q10......................................................................... 50 mg</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 90 cápsulas.<br />
Tomar uma dose duas&nbsp;vezes ao dia, de manhã em jejum e a tarde no lanche<br />
<br />
3-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-23 14:00:29'),
  ('52367959153', 'prescricao', 'Uso oral<br />
<br />
1-&nbsp;<br />
Triphala extrato seco ................................. 500mg<br />
extrato de gengibre.....................................200mg<br />
Magnesio citrato.........................................200mg<br />
<br />
Tomar 1 dose pela manhã em jejum e 2 doses a noite ante sde dormir.&nbsp;<br />
<br />
2-<br />
Sais Biliares................................................... 300mg<br />
<br />
Tomar 1 dose no almoço e se necessário 1 dose no jantar. sempre junto com as refeições e com gordura nas refeições.&nbsp;<br />
<br />
3-<br />
Magnésio citrato..............................................300mg<br />
<br />
Tomar 1 a 2 dose antes de dormir.&nbsp; 1 a 2 horas antes com bastante água.&nbsp;<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-23 16:23:25'),
  ('47326620130', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 30&nbsp;mg<br />
Selênio................................................................ 100 mcg<br />
Coenzima Q10........................................................... 50 mg<br />
Boro quelato............................................................ 1 mg<br />
Magnésio quelato........................................................&nbsp;300 mg<br />
Vitamina A.............................................................. 4.000&nbsp;UI<br />
Metilcobalamina.......................................................... 1 mg<br />
Vitamina B5............................................................. 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span><br />
&nbsp;</p>
3-<br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Crisina................................................250mg<br />
Resveratrol............................................500mg<br />
Saw palmeto............................................160mg<br />
Zinco...................................................10mg<br />
Mucuna pruriens........................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>tomar uma cápsula duas vezes ao dia.<br />
<br />
4-<br />
<br />
Ômega 3 990 EPA e 660 DHA ( sugestão, vita for plus)<br />
<br />
Tomar 1 dose 3 x ao dia no café da manhã, almoço e jantar.</span><br />
<br />
5-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................120mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>60 pastilhas</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver duas&nbsp;&nbsp;pastilhas sublingual uma vez ao dia no almoço.&nbsp;</span><br />
<br />
<br />
<br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p>&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-04-23 16:56:46'),
  ('22352651115', 'prescricao', '<p><strong>Uso interno<br />
<br />
1-</strong></p>
Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg<br />
Sais biliares.......................................... 300 mg
<p>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose depois das duas principais refeições do dia. Por 60 dias<br />
<br />
2-</p>
Picolinato de cromo....................................200mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................100mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Glucovantage............................................100mg
<p>Tomar uma dose, 2 x ao9 dia no lanche da manhã e no lanche&nbsp;da tarde, Por 60 dias.<br />
<br />
3</p>
Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;<br />
<br />
4<br />
<br />
magnésio dimalato 150mg<br />
magnésio treonato 100mg<br />
magnésio dimalato 150mg<br />
magnésio bisglicinato 150mg<br />
&nbsp;<br />
Aviar 60 cap. vegetais<br />
tomar 1 dose ao acordar.<br />
<br />
5<br />
Coenzima Q10 100mg<br />
NAC 300mg<br />
Curcuma extrato seco 250 mg<br />
vitamina C 200mng<br />
Zinco 30mg<br />
L carnitina&nbsp; 250mg<br />
Cu quelado 1mg<br />
Mn quelado 2mg<br />
NADH 15mg<br />
<br />
Aviar 60 doses.<br />
tomar 1 dose,&nbsp; pela manhã após café da manhã&nbsp;<br />
<br />
6<br />
Vitamina D 4.000 ui<br />
Vitamina K Mk7&nbsp; 150mcg<br />
60 doses - tomar 1 dose após o almoço.<br />
<br />
7<br />
Metilfolato 800mcg<br />
metilcobalamina 800mcg<br />
Piridoxal 5 fosfato 20mg<br />
Same 500mg&nbsp;<br />
lisina 200mg<br />
glicina 400mg<br />
60 doses<br />
tomar 1 dose&nbsp; após o almoço.&nbsp;<br />
<br />
8<br />
Pepstrong 2,4 mg<br />
HMB 2 g<br />
creatina 5G<br />
vitamina C 500mg<br />
colágeno hidrolizado 10g<br />
60 saches<br />
diluir 1 sache em 100ml de água&nbsp; e tomar pela manã por 60 dias.&nbsp;', 'Ana Carolina Candia Barra', '2026-04-24 15:16:00'),
  ('02160204170', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 2&nbsp;gotas sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>3-</span></p>

<h1><span style=&quot;font-size:12px&quot;>Vitamina D3 Ydrosolv®&nbsp;- 30ml&nbsp; ( yosen)&nbsp;</span></h1>
<span style=&quot;font-size:12px&quot;>Tomar sublingual 10 gotas no almoço por 30 dias.&nbsp;</span><br />
<br />
4-<br />
<br />
<span style=&quot;font-size:12px&quot;>Vitamina C Ydrosolv®&nbsp;- 30ml ( yosen)&nbsp;<br />
<br />
Tomar 10 gotas diluído em água ou suco pela manhã, por 30 dias.&nbsp;</span><br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-28 15:28:37'),
  ('75538784134', 'prescricao', 'USO ORAL&nbsp;<br />
<br />
1-
<ul>
	<li>Mucosave® – 150 mg</li>
	<li>L-Glutamina – 2 g</li>
	<li>Zinco carnosina – 37,5 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 sachê 2x ao dia (manhã em jejum e antes do jantar) POR 30 DIAS<br />
<br />
2-<br />
&nbsp;</p>

<ul>
	<li>DGL (Alcaçuz deglicirrizinado) – 100 mg</li>
	<li>Enzimas digestivas (blend leve) – 100 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula 2x ao dia, 15 minutos antes do almoço e jantar POR 30 DIAS<br />
<br />
3-<br />
&nbsp;</p>

<ul>
	<li>Quercetina – 150 mg</li>
	<li>Vitamina C – 200 mg</li>
	<li>NAC (N-acetilcisteína) – 300 mg</li>
	<li>Vitamina B6 – 10 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula 2x ao dia (manhã e noite) POR 30 DIAS.&nbsp;<br />
<br />
4-</p>

<ul>
	<li>Lactobacillus rhamnosus – 2 bilhões UFC</li>
	<li>Bifidobacterium longum – 2 bilhões UFC</li>
	<li>Bifidobacterium infantis – 2 bilhões UFC</li>
	<li>Lactobacillus plantarum – 2 bilhões UFC</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula ao dia em jejum POR 30 DIAS<br />
<br />
5-</p>

<ul>
	<li>Saccharomyces boulardii – 250 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula 1x ao dia (pode ser junto do probiótico ou à noite) POR 30 DIAS<br />
<br />
6-</p>

<ul>
	<li>Ferro bisglicinato – 30 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula ao dia, longe de refeições principais (preferir meio da tarde) POR 60 DIAS.&nbsp;<br />
<br />
7-</p>

<h3>Vitamina D3</h3>

<p><strong>Composição:</strong></p>

<ul>
	<li>Vitamina D3 – 2.000 UI</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1x ao dia junto com refeição POR 60 DIAS.&nbsp;<br />
<br />
8-</p>

<p><strong>Composição:</strong></p>

<ul>
	<li>Zinco bisglicinato – 15 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1x ao dia, junto com refeição (não junto do ferro) pOR 60 DIAS.<br />
<br />
9-</p>

<p><strong>Composição:</strong></p>

<ul>
	<li>Magnésio bisglicinato – 400 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1x ao dia à noite.&nbsp;&nbsp;POR 60 DIAS.&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-04-28 17:44:53'),
  ('47326620130', 'prescricao', '<p><strong>Uso interno</strong></p>

<p>1-<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 30&nbsp;mg<br />
Selênio................................................................ 100 mcg<br />
Boro quelato............................................................ 1 mg<br />
Magnésio quelato........................................................&nbsp;300 mg<br />
Vitamina A.............................................................. 4.000&nbsp;UI<br />
Vitamina B5............................................................. 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde, por 60 dias.<br />
<br />
2-</p>
red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg
<p>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.<br />
&nbsp;</p>
3-<br />
<br />
Crisina................................................250mg<br />
Resveratrol............................................500mg<br />
Saw palmeto............................................160mg<br />
Zinco...................................................10mg<br />
Mucuna pruriens........................................150mg
<p>tomar uma cápsula duas vezes ao dia. Por 60 dias.<br />
<br />
4-<br />
<br />
Ômega 3 990 EPA e 660 DHA ( sugestão, vita for plus)<br />
<br />
Tomar 1 dose 3 x ao dia no café da manhã, almoço e jantar. Por 60 dias.<br />
<br />
5-</p>
Vitamina D 3..........................................4000ui<br />
Vitamina K2............................................120mg
<p>60 pastilhas</p>

<p>Sorver duas&nbsp;&nbsp;pastilhas sublingual uma vez ao dia no almoço.&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-04-29 18:56:59'),
  ('15433080153', 'prescricao', 'Uso oral<br />
&nbsp;
<h1><span style=&quot;font-size:12px&quot;>1- Carvão Ativado Vegetal Carverol 250mg&nbsp; - 20 cps.</span></h1>
Tomar 4 cps. por dia, sendo 2 as 11:00 da manhã e as 17:30 as outras 2 caps. Por 2 dias<br />
<br />
Estratégia para desintoxicação da desparasitação<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-30 14:52:38'),
  ('25520199191', 'prescricao', '<font face=&quot;courier new, courier, monospace&quot;>Uso oral<br />
<br />
1-</font>
<ul>
	<li>Saw Palmetto (Serenoa repens) extrato padronizado (85–95% ácidos graxos) – <strong>160 mg</strong></li>
	<li>Pygeum africanum extrato seco – <strong>100 mg</strong></li>
	<li>Urtica dioica (raiz) extrato seco – <strong>120 mg</strong></li>
	<li>Zinco quelado – 25<strong>&nbsp;mg</strong></li>
	<li>Licopeno – <strong>10 mg</strong></li>
</ul>

<p>&nbsp; &nbsp; &nbsp; 1 cápsula, 2x ao dia (manhã e noite), após refeições.</p>
', 'Ana Carolina Candia Barra', '2026-04-30 15:45:31'),
  ('46704132104', 'prescricao', 'Uso oral&nbsp;
<h2><span style=&quot;font-family:arial,helvetica,sans-serif&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>
<span style=&quot;font-family:arial,helvetica,sans-serif&quot;> </span>

<p><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>1-</span></p>
<span style=&quot;font-family:arial,helvetica,sans-serif&quot;> </span>

<h1><span style=&quot;font-family:arial,helvetica,sans-serif&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - 990 de EPA e 660 de DHA&nbsp; - ( marca Vitafor Plus)</span></span></h1>
<span style=&quot;font-family:arial,helvetica,sans-serif&quot;> </span>

<p><span style=&quot;font-family:arial,helvetica,sans-serif&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã,&nbsp;almoço e jantar. Por 60&nbsp;dias<br />
<br />
2-<br />
<br />
Incluiído do tratamento&nbsp;</span><br />
<br />
Demagrê&nbsp;<br />
<br />
Tomar 2 comp. 3 x ao dia, no café da manhã, no lanche da manhã e no lanche da tarde.</span><br />
<br />
&nbsp;</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-03 12:38:59'),
  ('68939663691', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span><br />
<br />
<span style=&quot;font-family:arial,helvetica,sans-serif&quot;>1- Para manipular</span></p>
<span style=&quot;font-family:arial,helvetica,sans-serif&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Por 90 dias<br />
<br />
2- Incluído no tratamento<br />
<br />
Ômega 3&nbsp;<br />
<br />
Tomar 2&nbsp;x ao dia, 2 caps. no café da manhã, e 1 no jantar.<br />
<br />
3-<br />
<br />
Demagrê<br />
<br />
Tomar&nbsp; 2 x ao dia, 3 cop. no lanche da manhã e 3 no almoço.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-05-05 12:00:12'),
  ('25520199191', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso oral</span><br />
<br />
<br />
<span style=&quot;font-family:arial,helvetica,sans-serif&quot;><span style=&quot;font-size:14px&quot;>1-<br />
Glucovantage...........................................100mg</span></span>
<p><span style=&quot;font-family:arial,helvetica,sans-serif&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 dose, 2 x ao dia, no café da manhã e antes do jantar. Por 90 dias.&nbsp;<br />
<br />
2-<br />
Ômega 3 990 de EPA e 600 de DHA ( vitafor Plus)<br />
<br />
Tomar 1 dose, 3 x ao dia , no café da manhã, almoço e jantar. Por 90 dias.</span></span>&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Evellyn Lorrany Farias Dos Santos', '2026-05-05 14:51:09'),
  ('82433542120', 'prescricao', '<p>USO ORAL</p>

<p><br />
Sais biliares....................................150mg</p>

<p>Lipase............................................50mg</p>

<p>&nbsp;</p>

<p>Mande 60 cápsulas gastrorresistentes.</p>

<p>&nbsp;</p>

<p>Tomar 1 cápsula junto das 2 principais refeições do dia por 30 dias.</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-06 23:22:39'),
  ('82433542120', 'prescricao', '<p>USO ORAL</p>

<p>&nbsp;</p>

<p>Aloe vera extrato seco..........................200mg</p>

<p>&nbsp;</p>

<p>Mande 60 cápsulas.</p>

<p>&nbsp;</p>

<p>Tomar 1 cápsula após o almoço e 1 cápsula após o jantar por 30 dias.</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-06 23:23:41'),
  ('82433542120', 'prescricao', '<p>USO ORAL</p>

<p>&nbsp;</p>

<p>L-Glutamina......................................5g</p>

<p>&nbsp;</p>

<p>Mande 150g em pó sabor neutro.</p>

<p>&nbsp;</p>

<p>Tomar 1 dose pela manhã em jejum diluída em água por 30 dias.</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-06 23:24:29'),
  ('71468951149', 'prescricao', '<p>Uso Oral</p>

<p>Psyllium .................................. 3 g &nbsp;<br />
PHGG (Fibra parcialmente hidrolisada) ..... 3 g &nbsp;<br />
Glutamina ................................. 5 g &nbsp;<br />
<br />
Sachê.<br />
<br />
Tomar 1 sachê ao dia diluído em 250–300 ml de água, preferencialmente no final da tarde ou à noite.</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-07 13:53:37'),
  ('71468951149', 'prescricao', '<p>Uso oral</p>

<p>Selênio (selenometionina) ................. 200 mcg &nbsp;<br />
Zinco bisglicinato ........................ 25 mg &nbsp;<br />
Magnésio bisglicinato ..................... 200 mg &nbsp;<br />
Coenzima Q10 .............................. 100 mg &nbsp;<br />
Curcumina fitossomada ..................... 250 mg &nbsp;<br />
Piperina .................................. 5 mg &nbsp;<br />
<br />
60 cápsulas.<br />
<br />
Tomar 2 cápsulas ao dia, após almoço e jantar.</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-07 13:54:33'),
  ('71468951149', 'prescricao', 'Uso Oral<br />
<br />
Magnésio treonato ......................... 500 mg &nbsp;<br />
Glicina ................................... 3 g &nbsp;<br />
L-teanina ................................. 200 mg &nbsp;<br />
Inositol .................................. 2 g &nbsp;<br />
<br />
Sachê ou pó.<br />
<br />
Tomar 1 dose à noite, 30–60 minutos antes de dormir.', 'Evellyn Lorrany Farias Dos Santos', '2026-05-07 13:55:17'),
  ('48748919004', 'prescricao', '<p>Uso oral<br />
<br />
1) Levotiroxina sodica (T4) 35&nbsp;mcg<br />
Liotironina sodica (T3) 2,5 mcg</p>

<p>Tomar 1 capsula em jejum pela manha, aguardar 40 a 60 minutos para alimentar-se.<br />
<br />
<br />
&nbsp;</p>

<p>2) Liotironina sodica (T3) 2,5 mcg</p>

<p>Tomar 1 capsula as 13h.<br />
<br />
&nbsp;</p>
', 'Danielle Candia Barra', '2026-05-11 10:05:23'),
  ('48748919004', 'prescricao', '<p>*** Tratamento para 90 dias****<br />
<br />
Uso oral<br />
<br />
1) Levotiroxina sodica (T4) 35&nbsp;mcg<br />
Liotironina sodica (T3) 5 mcg</p>

<p>Tomar 1 capsula em jejum pela manha, aguardar 40 a 60 minutos para alimentar-se.</p>
', 'Danielle Candia Barra', '2026-05-11 10:06:45'),
  ('48748919004', 'prescricao', '<p>**** Tratamento para 90 dias *****<br />
<br />
<br />
Receita 01 Energia metabolismo tireoide e cognicao</p>

<p>Coenzima Q10 100 mg<br />
L tirosina 250 mg<br />
Inositol 500 mg<br />
Colina 150 mg<br />
Magnesio bisglicinato 100 mg<br />
Selenio quelato 100 mcg<br />
Zinco quelato 15 mg</p>

<p><br />
Capsulas gastro resistentes</p>

<p>Tomar 1 capsula apos cafe da manha e 1 capsula apos almoco.</p>

<p>Receita 02 Detox hepatico antioxidante e inflamacao</p>

<p>NAC 300 mg<br />
Taurina 250 mg<br />
Glicina 500 mg<br />
Curcumina fitossomada 250 mg<br />
Silimarina 150 mg<br />
Capsulas gastro resistentes</p>

<p>Tomar 1 capsula apos cafe da manha e 1 capsula apos jantar.</p>

<p>Receita 03 Relaxamento sono e irritabilidade</p>

<p>L teanina 200 mg<br />
Magnesio bisglicinato 100 mg</p>

<p><br />
Capsulas gastro resistentes</p>

<p>Tomar 1 capsula 1 hora antes de dormir.<br />
<br />
<br />
Receita 4&nbsp;&nbsp;</p>

<p>Vitamina D3 5000 UI<br />
Vitamina K2 MK7 200 mcg</p>

<p>Tomar 1 capsula ao dia apos cafe da manha.</p>

<p>&nbsp;</p>

<p>Omega 3<br />
EPA 700 mg<br />
DHA 500 mg</p>

<p>Tomar 2 capsulas ao dia apos almoco.</p>

<p>&nbsp;</p>

<p>CID N95.1<br />
CID E03.9<br />
CID L65.9<br />
CID R53</p>
', 'Danielle Candia Barra', '2026-05-11 10:13:32'),
  ('48748919004', 'prescricao', '<p>Reavaliacao em 90 dias</p>

<p>Hemograma completo<br />
Ferritina<br />
PCR ultrassensivel</p>

<p>TSH<br />
T4 livre<br />
T3 livre<br />
T3 total</p>

<p>Estradiol<br />
Progesterona<br />
Testosterona total<br />
SHBG</p>

<p>GGT<br />
TGO<br />
TGP</p>

<p>Insulina<br />
Glicose<br />
Hemoglobina glicada</p>

<p>Vitamina D<br />
Zinco<br />
Selenio</p>

<p>Cortisol salivar 4 pontos</p>

<p>Data sugerida para coleta:<br />
11/08/2026</p>

<p>CID N95.1<br />
CID E03.9</p>
', 'Danielle Candia Barra', '2026-05-11 10:16:25'),
  ('01663482799', 'prescricao', '<h2>120 doses — cápsulas gastro-resistentes<br />
<br />
Fórmula 1 — resistência insulínica / metabolismo / gordura visceral</h2>

<p>&nbsp;</p>

<ul>
	<li>Berberina 500 mg</li>
	<li>Mio-inositol 500 mg</li>
	<li>Magnésio glicina 150 mg</li>
	<li>Zinco quelato 15 mg</li>
	<li>Cromo picolinato 200 mcg</li>
	<li>NAC 300 mg</li>
</ul>

<p>Tomar 1 cápsula após almoço e 1 cápsula após jantar.</p>

<hr />
<h2>Fórmula 2 — proteção cardiovascular / ApoB / Lp(a) / triglicerídeos</h2>
&nbsp;

<ul>
	<li>Bergamota 500 mg</li>
	<li>Citrus aurantium moro 400 mg</li>
	<li>Coenzima Q10 100 mg</li>
	<li>Tocotrimax 100 mg</li>
	<li>Resveratrol 80 mg</li>
</ul>

<p>Tomar 1 cápsula após café da manhã e 1 cápsula após jantar.</p>

<h2>&nbsp;</h2>

<hr />
<h2>Ômega 3</h2>

<p>Ômega 3 TG ultra concentrado</p>

<ul>
	<li>EPA + DHA total: 2000–3000 mg/dia</li>
</ul>

<p>Tomar junto ao almoço.</p>

<hr />
<h2>Fórmula 3-Vitamina D3 + K2</h2>

<p>Vitamina D3 5000 UI<br />
Vitamina K2 MK-7 120 mcg</p>

<p>Tomar 1 cápsula ao almoço.</p>
', 'Danielle Candia Barra', '2026-05-11 10:45:26'),
  ('01663482799', 'prescricao', '<h1>Receita hormonal — 120 dias</h1>

<h2>Estradiol transdérmico + Estriol</h2>

<p>Base Pentravan®<br />
120 g</p>

<ul>
	<li>Estradiol bioidêntico 1,0&nbsp;mg/g</li>
	<li>Estriol 1 mg/g</li>
</ul>

<p>Aplicar 1 pump ao dia em membros inferiores alternados (parte interna das coxas, atrás dos joelhos ou tornozelos), preferencialmente pela manhã.</p>

<hr />
<h2>Progesterona bioidêntica oral</h2>

<p>120 cápsulas gastro-resistentes</p>

<ul>
	<li>Progesterona micronizada 100 mg</li>
</ul>

<p>Tomar 1 cápsula à noite, diariamente, 30 minutos antes de dormir.</p>

<hr />
<h2>Testosterona transdérmica feminina</h2>

<p>Base Pentravan®<br />
60 g</p>

<ul>
	<li>Testosterona bioidêntica 1,5&nbsp;mg/g</li>
</ul>

<p>Aplicar 1 pump em membros inferiores alternados pela manhã.</p>
', 'Danielle Candia Barra', '2026-05-11 10:47:22'),
  ('01663482799', 'prescricao', '<h1>Receita</h1>

<p>Ozempic® (semaglutida) caneta multidose</p>

<p>Aplicar 72 cliques por via subcutânea 1x por semana, no mesmo dia da semana.</p>

<p>Locais de aplicação:</p>

<ul>
	<li>abdome</li>
	<li>coxa</li>
	<li>braço</li>
</ul>

<p>Alternar os locais de aplicação.</p>

<p>Quantidade:<br />
03 canetas</p>

<p>Orientações:</p>

<ul>
	<li>manter refrigeração</li>
	<li>evitar aplicação após refeições muito volumosas</li>
	<li>aumentar ingestão proteica</li>
	<li>manter hidratação adequada</li>
	<li>suspender em caso de dor abdominal intensa ou vômitos persistentes</li>
</ul>

<p>Uso contínuo por 120 dias com acompanhamento médico.</p>
', 'Danielle Candia Barra', '2026-05-11 10:48:37'),
  ('69982490125', 'prescricao', '<p><strong>CID:</strong> E66.3 / R63.5 / N95.1 / L65.9 / K59.0</p>

<h2>Exames laboratoriais</h2>

<h3>Hematológicos e inflamatórios</h3>

<ul>
	<li>Hemograma completo</li>
	<li>Ferritina</li>
	<li>Ferro sérico</li>
	<li>Transferrina</li>
	<li>Saturação de transferrina</li>
	<li>PCR ultrassensível</li>
	<li>VHS</li>
	<li>Homocisteína</li>
</ul>

<h3>Metabólicos</h3>

<ul>
	<li>Glicemia de jejum</li>
	<li>Insulina de jejum</li>
	<li>Hemoglobina glicada</li>
	<li>HOMA-IR</li>
	<li>Ureia</li>
	<li>Creatinina</li>
	<li>Sódio</li>
	<li>Potássio</li>
	<li>Magnésio</li>
	<li>Cálcio total e iônico</li>
	<li>Ácido úrico</li>
</ul>

<h3>Perfil lipídico e cardiovascular</h3>

<ul>
	<li>Colesterol total</li>
	<li>HDL</li>
	<li>LDL</li>
	<li>Triglicerídeos</li>
	<li>Apo A1</li>
	<li>Apo B</li>
	<li>Lipoproteína(a)</li>
</ul>

<h3>Hepáticos</h3>

<ul>
	<li>TGO</li>
	<li>TGP</li>
	<li>GGT</li>
	<li>Fosfatase alcalina</li>
	<li>Bilirrubinas totais e frações</li>
</ul>

<h3>Tireoidianos</h3>

<ul>
	<li>TSH</li>
	<li>T4 livre</li>
	<li>T3 livre</li>
	<li>Anti-TPO</li>
	<li>Anti-tireoglobulina</li>
</ul>

<h3>Hormonais femininos</h3>

<ul>
	<li>Estradiol</li>
	<li>Progesterona</li>
	<li>FSH</li>
	<li>LH</li>
	<li>Testosterona total</li>
	<li>Testosterona livre</li>
	<li>SHBG</li>
	<li>SDHEA</li>
	<li>Prolactina</li>
	<li>Cortisol 8h</li>
</ul>

<h3>Vitaminas e minerais</h3>

<ul>
	<li>Vitamina D</li>
	<li>Vitamina B12</li>
	<li>Ácido fólico</li>
	<li>Zinco</li>
</ul>
Coprológico Funcional e Indican Urina.', 'Danielle Candia Barra', '2026-05-11 11:48:21'),
  ('83000372172', 'prescricao', 'Via Oral<br />
&nbsp;
<p>Glutamina ……………………………. 5g<br />
PHGG …………………………………. 5g<br />
Psyllium ……………………………… 3g<br />
Magnésio glicina ………………………. 200mg</p>

<p>&nbsp;</p>

<p>Sachê</p>

<p>&nbsp;</p>

<p>Tomar 1 sachê diluído em 200ml de água, 30 minutos antes do jantar.</p>

<p>&nbsp;</p>

<p>Iniciar com 1/2 sachê nos primeiros 5 dias caso apresente distensão abdominal.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-11 12:29:42'),
  ('83000372172', 'prescricao', 'Via Oral<br />
&nbsp;
<p>Magnésio treonato ……………………… 150mg<br />
Riboflavina (Vitamina B2) ………………. 50mg<br />
Vitamina C ……………………………. 300mg<br />
Taurina ………………………………. 500mg</p>

<p>&nbsp;</p>

<p>60 cápsulas</p>

<p>&nbsp;</p>

<p>Tomar 1 cápsula após café da manhã e 1 cápsula após almoço.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-11 12:30:28'),
  ('83000372172', 'prescricao', 'Via Oral<br />
&nbsp;
<p>Diosmina ……………………………… 450mg<br />
Hesperidina …………………………… 50mg<br />
Centella asiática ……………………… 150mg</p>

<p>&nbsp;</p>

<p>60 cápsulas</p>

<p>&nbsp;</p>

<p>Tomar 1 cápsula após almoço e 1 cápsula após jantar.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-11 12:34:50'),
  ('03434174133', 'prescricao', 'Via Oral<br />
<br />
N-acetilcisteína (NAC) ............. 600mg &nbsp;<br />
Silimarina .................................... 200mg &nbsp;<br />
TUDCA ........................................... 250mg &nbsp;<br />
Berberina ..................................... 500mg &nbsp;<br />
Curcumina fitossomada ............ 250mg &nbsp;<br />
Taurina ......................................... 500mg &nbsp;<br />
<br />
QSP 1 cápsula<br />
<br />
Tomar 1 cápsula 2x ao dia, 30 minutos antes do almoço e jantar.<br />
<br />
60 cápsulas', 'Evellyn Lorrany Farias Dos Santos', '2026-05-13 10:34:51'),
  ('03434174133', 'prescricao', '<p>Via Oral</p>

<p>Vitamina C .................................. 500mg &nbsp;<br />
Quercetina .................................. 250mg &nbsp;<br />
Rutina .......................................... 100mg &nbsp;<br />
Hesperidina metil chalcona ..... 100mg &nbsp;<br />
Zinco quelado ............................. 15mg &nbsp;<br />
<br />
QSP 1 cápsula<br />
<br />
Tomar 1 cápsula 2x ao dia após refeições.<br />
<br />
60 cápsulas</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-13 10:35:29'),
  ('03434174133', 'prescricao', 'Via Oral<br />
<br />
Magnésio glicina ....................... 250mg &nbsp;<br />
L-Teanina .................................... 200mg &nbsp;<br />
Mio-inositol ................................ 500mg &nbsp;<br />
Rhodiola rosea .......................... 150mg &nbsp;<br />
<br />
QSP 1 dose<br />
<br />
Tomar 1 dose à noite, 1 hora antes de dormir.<br />
<br />
30 doses', 'Evellyn Lorrany Farias Dos Santos', '2026-05-13 10:36:30'),
  ('37151045115', 'prescricao', 'Uso oral<br />
<br />
1- Enzimas disgestivas<br />
<br />
Protese de Aspergillus 100mg<br />
Lipase 50mg<br />
Amilase 50mg<br />
Pepsina 50mg<br />
betaína HCl 100mg<br />
<br />
Tomar 1 caps. antes do almoço e antes do jantar. Por 60 dias.<br />
<br />
2- Ômega 3 - 990 EPA e 660 DHA ( vita for Plus)<br />
<br />
Tomar 1 dose 3 x ao dia, 1 no café da manhã, 1 no almoço e 1 no jantar. Por 90 dias.<br />
<br />
3-<br />
Vitamina C 500mg<br />
Magnesio bisglicinato 200mg<br />
Coq10 100mg<br />
Vitamina E 200ui<br />
Curcumina fitossomada 250mg<br />
Resveratrol 100mg<br />
MSM 1g<br />
Colágeno tipo II não desnaturado 40mg<br />
geleia real liofilizada 200mg<br />
sabor frutas vermelhas com taumatina&nbsp;<br />
<br />
Dissolver 1 sachê&nbsp; em 200 ml de água.<br />
tomar 1 dose ao dia após o almoço. Por 60 dias.&nbsp;<br />
<br />
4-<br />
Zinco quelado 15mg<br />
selênio 100mcg<br />
Magnesio glicina 100mg<br />
metilfolato 400mcg<br />
metilcobalamina 1000mcg<br />
vitamina D3 - 5000ui<br />
L glutamina 3mg<br />
Inositol 500mg<br />
sabor limão com taumatina<br />
<br />
Dissolver 1 sachê em 500ml de água&nbsp;<br />
Tomar pela manhã em jejum ou 300minutos antes do café da manhã, por 60 dias.&nbsp;<br />
<br />
5-<br />
cartilagem de tubarão 500mg<br />
<br />
Tomar q cap. 2 x ao dia após o almoço e jantar. por 30 dias&nbsp;<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-13 20:05:39'),
  ('00786230142', 'prescricao', 'Uso oral<br />
<br />
1- Enzimas digestivas.<br />
<br />
Protease de Aspergillus 150mg<br />
Lipase 50mg<br />
Amilase 100mg<br />
Berberina 200mg<br />
pepsina 50mg<br />
<br />
Tomar 1 caps. antes do almoço e jantar Por 30 dias.<br />
<br />
2-<br />
Coenzima Q10 100mg<br />
vitamina C 500mg<br />
Resveratrol 100mg<br />
Curcumina fitoossomada 250mg<br />
Ginkgo biloba 80mg<br />
castanha da índia 150mg<br />
<br />
1 caps. após o almoço e 1 caps após o jantar. por 30 dias.&nbsp;<br />
<br />
3-<br />
Caprílico 250mg<br />
Óleo de oregano seco 100mg<br />
alho seco 100mg<br />
pau d´arco 150mg<br />
zinco quelado 15mg<br />
selenio 100mcg<br />
<br />
1 caps. após o almoço e jantar. Por 30 dias.&nbsp;<br />
<br />
4-<br />
Triphala extrato seco 500mg<br />
Magnésio citrato 200mg<br />
Aloe vera extrato seco 100mg<br />
Gengibre extrato seco 50mg<br />
<br />
mande 45 doses.<br />
tomar1&nbsp; caps. a noite, se necessário tomar 2 caps. por 30 dias<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-13 20:23:34'),
  ('83000372172', 'prescricao', 'paciente relata não quer fazer as prescrições manipuladas da nutri.<br />
comnversamos e pedi para priorizar a glutamina ( por estarmos em fase intestinal) para tomar com água e limão em jejum e a formula da diosmina para o lipedema.&nbsp;', 'Ana Carolina Candia Barra', '2026-05-14 14:48:07'),
  ('37151045115', 'prescricao', '<strong>Forma de tomar suplementos da clínica&nbsp;<br />
<br />
Reset intestinal</strong><br />
<br />
1<strong> -&nbsp;&nbsp;</strong>Simple life - Tomar 3 gotas sublingual pela manhã em jejum.&nbsp;<br />
2-&nbsp; &nbsp;Desinflamy - Tomar 8 gotas sublinguais no meio da manhã e no lanche da tarde.<br />
3-&nbsp; &nbsp;Floratin - Tomar 5 gotas antes do almoço e antes do jantar.<br />
4-&nbsp; &nbsp;Probiotic - Tomar 5 gotas sublinguais antes de dormir.&nbsp;<br />
<br />
<strong>Reset Emocional&nbsp;</strong><br />
<br />
1- Energy+ - Tomar 5 gotas sublingual pela manhã em jejum.&nbsp;<br />
2- Calmmin - Tomar até no máximo 3 x ao dia, ao longo do dia sempre que se perceber ansiosa. Se4 não sentir, não toma. ou toma 1 x a tarde ,&nbsp; 5 gotas sublingual.<br />
3- No stress -&nbsp;&nbsp;Tomar 5 gotas sublingual antes de dormir.<br />
<br />
<strong>Compulsy</strong> - modulador da compulsão - tomar até 3 x ao dia,&nbsp; manhã, tarde e noite,&nbsp;&nbsp;5 gotas sublingual.&nbsp;<br />
<br />
OBS:Este tratamento deve ser feito de forma initerrupta por pelo menos 30 dias, até avaliação profissional.&nbsp;<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-14 15:45:53'),
  ('06089932639', 'prescricao', 'Solicito :
<ul>
	<li>Hemograma completo</li>
	<li>Ferritina</li>
	<li>Glicemia de jejum</li>
	<li>Insulina de jejum</li>
	<li>Hemoglobina glicada</li>
	<li>Perfil lipídico completo</li>
	<li>TGO, TGP, GGT</li>
	<li>TSH</li>
	<li>T4 livre</li>
	<li>Anti-TPO</li>
	<li>Vitamina D</li>
	<li>Vitamina B12</li>
	<li>PCR ultrassensível</li>
	<li>Ácido úrico</li>
	<li>Cortisol sérico 8h da manhã</li>
	<li>DHEA-S</li>
	<li>Androstenediona</li>
	<li>17-OH progesterona</li>
	<li>ACTH</li>
	<li>IGF-1</li>
	<li>Leptina</li>
</ul>

<p>Se houver evolução importante de peso, acantose, piora da fadiga ou pubarca precoce, eu incluiria futuramente:</p>

<ul>
	<li>ultrassom abdominal,</li>
	<li>bioimpedância seriada,</li>
	<li>curva glicêmica/insulínica,</li>
	<li>testosterona total,</li>
	<li>SHBG.</li>
</ul>

<p>Os hormônios adrenais mais úteis nesse contexto pediátrico são:</p>

<ul>
	<li>DHEA-S,</li>
	<li>androstenediona,</li>
	<li>17-OH progesterona,</li>
	<li>cortisol.</li>
</ul>
', 'Danielle Candia Barra', '2026-05-18 09:56:13'),
  ('06089932639', 'prescricao', '<h1>Café da manhã (06:30–07:00)</h1>

<p>Opção 1</p>

<ul>
	<li>1 ovo mexido</li>
	<li>1 fatia de pão integral</li>
	<li>1 fatia pequena de queijo</li>
	<li>1 fruta pequena</li>
</ul>

<p>Opção 2</p>

<ul>
	<li>Iogurte natural integral sem açúcar (150 mL)</li>
	<li>1 colher de sopa de aveia</li>
	<li>morangos ou maçã picada</li>
</ul>

<p>Opção 3</p>

<ul>
	<li>Tapioca pequena (2 colheres sopa)</li>
	<li>frango desfiado ou queijo</li>
	<li>1 fruta</li>
</ul>

<p>Evitar:</p>

<ul>
	<li>achocolatado diário,</li>
	<li>cereal matinal,</li>
	<li>biscoitos,</li>
	<li>pão em excesso.</li>
</ul>

<hr />
<h1>Lanche da escola (09:30–10h)</h1>

<p>Alternar:</p>

<h2>Segunda</h2>

<ul>
	<li>Mini sanduíche integral com queijo branco</li>
	<li>água</li>
</ul>

<h2>Terça</h2>

<ul>
	<li>Iogurte natural</li>
	<li>morangos</li>
</ul>

<h2>Quarta</h2>

<ul>
	<li>Ovo cozido</li>
	<li>uvas pequenas</li>
</ul>

<h2>Quinta</h2>

<ul>
	<li>Queijo em cubos</li>
	<li>maçã pequena</li>
</ul>

<h2>Sexta</h2>

<ul>
	<li>Crepioca pequena de queijo</li>
	<li>água</li>
</ul>

<p>Evitar mandar:</p>

<ul>
	<li>suco de caixinha,</li>
	<li>bolinho,</li>
	<li>barrinha infantil,</li>
	<li>biscoito recheado,</li>
	<li>“snacks fit”.</li>
</ul>

<hr />
<h1>Almoço (12h–13h)</h1>

<p>Metade do prato:</p>

<ul>
	<li>legumes e verduras</li>
</ul>

<p>Proteína:</p>

<ul>
	<li>frango</li>
	<li>carne</li>
	<li>peixe</li>
	<li>ovos</li>
</ul>

<p>Carboidrato (escolher 1):</p>

<ul>
	<li>batata</li>
	<li>mandioca</li>
	<li>mandioquinha</li>
	<li>arroz pequeno volume</li>
	<li>macarrão simples pequeno volume</li>
</ul>

<p>Como não gosta de feijão:<br />
substituir às vezes por:</p>

<ul>
	<li>lentilha,</li>
	<li>grão-de-bico,</li>
	<li>ervilha,</li>
	<li>hummus.</li>
</ul>

<p>Quantidade média:</p>

<ul>
	<li>proteína: tamanho da palma da mão infantil</li>
	<li>carboidrato: 3 colheres sopa</li>
	<li>legumes livres.</li>
</ul>

<hr />
<h1>Lanche da tarde (16h–17h)</h1>

<p>Opção 1</p>

<ul>
	<li>iogurte natural + canela</li>
</ul>

<p>Opção 2</p>

<ul>
	<li>banana pequena com pasta de amendoim fina camada</li>
</ul>

<p>Opção 3</p>

<ul>
	<li>queijo + fruta</li>
</ul>

<p>Opção 4</p>

<ul>
	<li>vitamina:
	<ul>
		<li>leite</li>
		<li>morango</li>
		<li>aveia</li>
	</ul>
	</li>
</ul>

<hr />
<h1>Jantar (18:30–19:30)</h1>

<p>Preferir jantar mais cedo.</p>

<p>Opção 1</p>

<ul>
	<li>sopa com frango e legumes</li>
</ul>

<p>Opção 2</p>

<ul>
	<li>omelete com queijo + legumes</li>
</ul>

<p>Opção 3</p>

<ul>
	<li>frango desfiado + purê de batata + legumes</li>
</ul>

<p>Opção 4</p>

<ul>
	<li>carne moída + legumes + mandioca</li>
</ul>

<hr />
<h1>Ceia</h1>

<p>Na maioria dos dias:</p>

<ul>
	<li>não precisa.</li>
</ul>

<p>Se fome:</p>

<ul>
	<li>leite morno<br />
	ou</li>
	<li>iogurte natural pequeno.</li>
</ul>

<hr />
<h1>Orientações importantes para a família</h1>

<ul>
	<li>Não falar sobre “dieta” ou “engordar”.</li>
	<li>Evitar pesar frequentemente.</li>
	<li>Não usar comida como prêmio.</li>
	<li>Priorizar movimento diário espontâneo.</li>
	<li>Menos telas.</li>
	<li>Incentivar brincadeiras ativas.</li>
	<li>Dormir idealmente antes de 21h.</li>
	<li>Água ao longo do dia.</li>
</ul>
', 'Danielle Candia Barra', '2026-05-18 09:59:55'),
  ('06089932639', 'prescricao', '<p><br />
<br />
DECLARAÇÃO DE COMPARECIMENTO<br />
&nbsp;</p>

<p>Declaro, para os devidos fins, que a Sra. Daneila Coura Bastos acompanhou a paciente Helena Bastos Lanna em consulta médica realizada no período matutino do dia 18/05/2026.</p>

<p>Sem mais.</p>

<p>Brasília, 18 de maio de 2026.</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-05-18 10:10:25'),
  ('00246144165', 'prescricao', 'Relatório Médico<br />
<br />
<br />
Paciente: Carolina Brugger Borges<br />
Data da consulta: 18/05/2026<br />
<br />
<br />
Paciente em acompanhamento clínico funcional e integrativo devido a quadro compatível com intolerância<br />
histamínica, sintomas inflamatórios crônicos, manifestações dermatológicas e investigação de autoimunidade<br />
tireoidiana inicial.<br />
Foram avaliados exames laboratoriais recentes demonstrando alterações compatíveis com atividade autoimune<br />
tireoidiana inicial, incluindo elevação de anticorpos antitireoglobulina e tireoglobulina sérica, além de sintomas<br />
sistêmicos associados a desregulação imunológica e inflamatória de mucosa intestinal.<br />
A paciente apresenta quadro clínico compatível com hipersensibilidade alimentar e possível ativação mastocitária,<br />
cursando com necessidade de investigação complementar, ajuste nutricional e suporte medicamentoso/suplementar<br />
contínuo.<br />
Foram solicitados exames laboratoriais e exames de imagem complementares, incluindo ultrassonografia<br />
transvaginal, ultrassonografia de mamas, ultrassonografia de abdome total e ultrassonografia da tireoide com<br />
Doppler.<br />
Também foram prescritas fórmulas manipuladas com finalidade antioxidante, anti-inflamatória, suporte intestinal,<br />
suporte mitocondrial, modulação hormonal e melhora da digestibilidade alimentar, incluindo enzimas digestivas,<br />
vitaminas do complexo B metilado, vitamina D associada à vitamina K2, protocolo detox intestinal e terapia hormonal<br />
individualizada.<br />
<br />
<br />
CID principais relacionados ao quadro:<br />
<br />
<br />
• D89.4 – Síndrome de ativação mastocitária<br />
• E06.3 – Tireoidite autoimune<br />
• N95.1 – Distúrbios do climatério/perimenopausa<br />
• N80.9 – Endometriose não especificada<br />
Paciente permanece em seguimento médico especializado.<br />
Dra. Danielle Candia Barra<br />
CRM-DF 22.677', 'Danielle Candia Barra', '2026-05-18 11:16:49'),
  ('71468951149', 'prescricao', '<p>Fórmula 1&nbsp;– Correção nutricional + suporte hormonal/metabólico<br />
<br />
<br />
Vitamina B1 ............................ 25 mg<br />
Vitamina B2 ............................ 10 mg<br />
Vitamina B3 ............................ 50 mg<br />
Vitamina B5 ............................ 100 mg<br />
Vitamina B6 (P-5-P) .................... 25 mg<br />
Metilfolato ............................ 400 mcg<br />
Colina ................................ 100 mg<br />
Vitamina C .........................250mg</p>

<p>60 cápsulas gastro-resistentes.</p>

<p>Tomar 1 cápsula ao almoço.</p>

<hr />
<p>Fórmula 2&nbsp;– Aminoácidos essenciais (dias de treino)<br />
Leucina ................................ 2500 mg<br />
Isoleucina ............................. 1250 mg<br />
Valina ................................. 1250 mg<br />
Lisina ................................. 1000 mg<br />
Treonina ............................... 500 mg<br />
Metionina .............................. 250 mg<br />
Fenilalanina ........................... 250 mg<br />
Histidina .............................. 250 mg<br />
Triptofano ............................. 100 mg</p>

<p>Sachê.</p>

<p>Tomar 1 sachê após o treino de crossfit.</p>

<hr />
<p>Orientações:</p>

<ul>
	<li>Proteína diária alvo: 110–130 g/dia.</li>
	<li>Hidratação mínima: 2,5–3 litros/dia.</li>
	<li>Manter crossfit 3x/semana.</li>
	<li>Priorizar sono antes de meia-noite.</li>
	<li>Evitar longos jejuns devido ao risco de perda muscular.</li>
	<li>Manter acompanhamento da composição corporal.</li>
</ul>
', 'Danielle Candia Barra', '2026-05-18 12:04:45'),
  ('71468951149', 'prescricao', '<p>Paciente: Henriette Groenwold Monteiro</p>

<p>Uso Subcutâneo</p>

<p>Ozempic® (semaglutida)</p>

<p>Aplicar 1 vez por semana, sempre no mesmo dia da semana.</p>

<p>Escalonamento inicial:</p>

<ul>
	<li>Semanas 1 e 2: aplicar 10 cliques</li>
	<li>Semanas 3 e 4: aplicar 14 cliques</li>
</ul>

<p>Orientações:</p>

<ul>
	<li>Aplicar preferencialmente à noite.</li>
	<li>Manter boa hidratação.</li>
	<li>Priorizar ingestão proteica adequada.</li>
	<li>Reduzir ingestão de gordura e excesso alimentar nas 24h após aplicação.</li>
	<li>Suspender e comunicar em caso de vômitos intensos, dor abdominal importante ou intolerância importante.</li>
</ul>

<p>Receita para 30 dias.</p>
', 'Danielle Candia Barra', '2026-05-18 12:07:15'),
  ('71468951149', 'prescricao', '<p>Paciente: Henriette Groenwold Monteiro</p>

<p>Uso Oral</p>

<p>Junno® 100 mg<br />
Progesterona micronizada</p>

<p>Tomar 1 cápsula à noite, aproximadamente 30 a 60 minutos antes de dormir.</p>

<p>Uso contínuo.</p>

<p>Receita para 60 dias.</p>
', 'Danielle Candia Barra', '2026-05-18 12:10:51'),
  ('62606465342', 'prescricao', 'Via oral
<p>Glutamina …………………………………. 2g<br />
Zinco bisglicinato ………………………. 5mg<br />
Magnésio glicina ………………………… 50mg</p>

<p>&nbsp;</p>

<p>Sachês saborizados<br />
Tomar 1 sachê ao dia, longe das principais refeições.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-19 10:28:47'),
  ('62606465342', 'prescricao', 'Via oral<br />
&nbsp;
<p>Vitamina D3 …………………………………. 2.000 UI<br />
Vitamina K2 MK7 ……………………………. 25mcg</p>

<p>&nbsp;</p>

<p>Gomas mastigáveis sem açúcar, sem corantes artificiais e sem açúcar refinado.</p>

<p>&nbsp;</p>

<p>Administrar 1 goma ao dia junto às refeições.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-19 10:30:37'),
  ('62606465342', 'prescricao', 'Via Oral
<p>Cromo picolinato ……………………….. 50mcg<br />
Magnésio glicina ………………………… 60mg<br />
Taurina ……………………………………. 100mg</p>

<p>&nbsp;</p>

<p>Sachê saborizado sem açúcar, sem corantes artificiais e sem açúcar refinado.</p>

<p>&nbsp;</p>

<p>Tomar 1 sachê após o almoço.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-19 10:31:45'),
  ('15433080153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>2-<br />
<tt>Curcumina lipossomada (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg</tt></span><br />
<tt>Uncaria tomentosa - 350mg</tt><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span><br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-19 10:58:55'),
  ('07478852149', 'prescricao', 'Via oral<br />
&nbsp;
<p>L-teanina –––––––– 200mg<br />
Magnésio glicina ——— 200mg<br />
Taurina —————— 300mg<br />
Ashwagandha KSM-66 —–– 250mg<br />
Rhodiola rosea ———– 150mg<br />
Curcumina –––––––– 250mg<br />
Piperina —————– 5mg</p>

<p>&nbsp;</p>

<p>Tomar 1 dose após café da manhã e 1 dose no final da tarde.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-19 14:27:45'),
  ('07478852149', 'prescricao', 'Via Oral<br />
&nbsp;
<p>PHGG ——————— 5g<br />
Glutamina –––––––– 5g<br />
Magnésio citrato ——— 200mg<br />
Inulina leve ———–– 2g</p>

<p>&nbsp;</p>

<p>Tomar à noite em água.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-19 14:28:20'),
  ('07478852149', 'prescricao', 'Via oral<br />
&nbsp;
<p>Coenzima Q10 ———— 100mg<br />
Selênio quelado ——— 100mcg<br />
Zinco quelado ———– 15mg<br />
NAC ——————— 600mg<br />
Complexo B metilado —– 1 dose</p>

<p>&nbsp;</p>

<p>Tomar após almoço.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-19 14:28:52'),
  ('22352651115', 'prescricao', 'Uso oral&nbsp;<br />
<br />
1-<br />
Cloridrato de tiamina - 250mg&nbsp;<br />
Exinutriment - 100mg&nbsp;<br />
<br />
Tomar 1 dose 2 x ao dia juntamente com a formula 2 ( que ja esta em tratamento)&nbsp; de manhã e a tarde.&nbsp;', 'Ana Carolina Candia Barra', '2026-05-19 15:06:40'),
  ('15433080153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>2-<br />
<tt>Curcumina lipossomada (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Zinco Quelado – 15 mg</tt></span><br />
<tt>Uncaria tomentosa - 250mg</tt><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span><br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-19 16:55:27'),
  ('03434174133', 'prescricao', '<p>Uso Oral<br />
<br />
1- ativador mitocondrial e antioxidante.</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Vitamina C ( Ácido ascorbico)......................... 500&nbsp;mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Selênio quelado........................................100mcg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Metilcobalamina........................................ 1 mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg<br />
<br />
Mande em sache, sabor a escolha da paciente</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias (pré crio)</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-05-19 17:07:08'),
  ('03434174133', 'prescricao', '<p>Uso Oral<br />
<br />
1- ativador mitocondrial e antioxidante.</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Vitamina C ( Ácido ascorbico)......................... 500&nbsp;mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Selênio quelado........................................100mcg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Metilcobalamina........................................ 1 mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg<br />
<br />
Mande em sache, sabor a escolha da paciente</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias (pré crio)<br />
<br />
2-</span><br />
N-acetilcisteína (NAC) ............. 600mg &nbsp;<br />
Silimarina .................................... 200mg &nbsp;<br />
TUDCA ........................................... 250mg &nbsp;<br />
Berberina ..................................... 500mg &nbsp;<br />
Curcumina fitossomada ............ 250mg &nbsp;<br />
Taurina ......................................... 500mg &nbsp;<br />
<br />
QSP 1 cápsula<br />
<br />
Tomar 1 cápsula 2x ao dia, 30 minutos antes do almoço e jantar.<br />
<br />
60 cápsulas</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-05-19 17:32:11'),
  ('03434174133', 'prescricao', 'Obs A escolha da paciente, priorizamos 2 fórmulas<br />
<br />
o ativador mitocondrial e a formula passada pela nutricionista para o fígado<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-19 17:33:33'),
  ('91163471100', 'prescricao', '1.&nbsp;&nbsp;COMPOSTO ANTIMICROBIANO INTESTINAL<br />
Fórmula (cápsulas):<br />
<br />
Berberina ..................................... 300 mg<br />
Óleo essencial de orégano .......... 150 mg<br />
Alho (extrato seco) ....................... 200 mg<br />
Extrato de própolis ....................... 100 mg<br />
Artemísia ....................................... 150 mg<br />
<br />
1 cápsula 2x ao dia, antes do almoço e jantar - Por 15 dias.<br />
<br />
2-&nbsp;<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-20 09:44:02'),
  ('91163471100', 'prescricao', '1.&nbsp;&nbsp;COMPOSTO ANTIMICROBIANO INTESTINAL<br />
Fórmula (cápsulas):<br />
<br />
Berberina ..................................... 300 mg<br />
Óleo essencial de orégano .......... 150 mg<br />
Alho (extrato seco) ....................... 200 mg<br />
Extrato de própolis ....................... 100 mg<br />
Artemísia ....................................... 150 mg<br />
<br />
1 cápsula 2x ao dia, antes do almoço e jantar - Por 15 dias.<br />
<br />
2-&nbsp;&nbsp;ANTIFERMENTATIVO + CARMINATIVO<br />
<br />
Extrato de funcho ....................... 200 mg<br />
Extrato de hortelã ....................... 150 mg<br />
Gengibre ...................................... 100 mg<br />
Carvão ativado ............................ 100 mg<br />
<br />
1 cápsula após almoço e jantar - por 15 dias.<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-20 09:47:19'),
  ('37392964100', 'prescricao', 'USO ORAL
<p>Coenzima Q10 (Ubiquinol) ………. 100 mg<br />
Magnésio glicina ……………………. 200 mg<br />
Metilcobalamina ……………………. 1000 mcg<br />
Metilfolato ……………………………. 400 mcg<br />
Piridoxal-5-Fosfato (P5P) ………… 25 mg<br />
Selênio quelado …………………….. 100 mcg<br />
Zinco quelado ………………………… 15 mg</p>

<p>Posologia:<br />
Tomar 1 cápsula após o café da manhã e 1 cápsula após o almoço.</p>

<p>&nbsp;</p>
', 'Evellyn Lorrany Farias Dos Santos', '2026-05-21 14:54:28'),
  ('37392964100', 'prescricao', 'USO ORAL<br />
&nbsp;
<p>Vitamina C tamponada …………… 500 mg<br />
Quercetina ……………………………. 150 mg<br />
NAC ……………………………………….. 300 mg</p>

<p>&nbsp;</p>

<p>Posologia:<br />
Tomar 1 cápsula após o almoço.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-21 14:55:04'),
  ('37392964100', 'prescricao', 'USO ORAL<br />
&nbsp;
<p>Glutamina ……………………………… 5 g<br />
PHGG (Sunfiber®) ………………….. 5 g</p>

<p>&nbsp;</p>

<p>Sachê ou pó saborizado.</p>

<p>&nbsp;</p>

<p>Posologia:<br />
Diluir em 200 ml de água e tomar pela manhã em jejum.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-21 14:55:42'),
  ('79453430153', 'prescricao', 'Fase 1 - Modulação da inflamação intestinal, reparação de mucosa, melhora de motilidade e redução da disbiose e fermentação.<br />
<br />
Via oral&nbsp;<br />
<br />
1-<br />
Gengibre extrato seco padronizado.................300mg<br />
Alcachofra extrato seco padronizado................300mg<br />
<br />
Tomar 1 caps. 30 minutos antes do almoço e 1 caps. 30 min. antes do jantar. Por 30 dias.<br />
<br />
2-<br />
Curcumina fitossomal...............................500mg<br />
Boswellia serrata ( 65% acidos boswelicos) 300mg<br />
magnésio bisglicinato.................................400mg<br />
L teanina....................................................100mg<br />
Zinco quelado...............................................15mg<br />
<br />
Tomar 1 caps. após o almoço e 1 caps após o jantar. Por 30 dias<br />
<br />
3-<br />
berberina HCL.........................................500mg<br />
<br />
Tomar 1 caps após o almoço e 1 após o jantar. por 60 dias.<br />
<br />
4-<br />
Corebiome( tributirina).............................300mg<br />
<br />
tomar 1 caps. após o almoço e 1 caps. após o jnatar, por 30 dias.<br />
<br />
5-<br />
L- Glutamina&nbsp;<br />
5g por dose&nbsp;<br />
<br />
Diluir 5g em água ao acordar em jejum e 5 antes de dormir. por 30 dias<br />
<br />
6-<br />
Ômega 3 990 de EPA e 660 de DHA<br />
<br />
Tomar 2 caps. junto ao almoço e 1 junto ao jantar. por 60 dias.<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-22 10:02:25'),
  ('79685099120', 'prescricao', 'Uso oral
<p>Tomar 1 cápsula no início do almoço e jantar.</p>

<ul>
	<li>Pancreatina 200 mg</li>
	<li>Protease 80 mg</li>
	<li>Amilase 80 mg</li>
	<li>Lipase 50 mg</li>
	<li>Gengibre extrato seco 50 mg</li>
	<li>Alcachofra extrato seco 50 mg</li>
	<li>Bromelina 100 mg</li>
</ul>

<p>QSP 1 cápsula</p>

<p>Manipular 60 cápsulas.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-05-22 15:23:08'),
  ('37392964100', 'prescricao', 'Suplementação<br />
<br />
fazer - durante a desparasitação&nbsp;<br />
a vit C com NAC e após a desparasitação tomar a glutamina e a formula multivitaminica<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-25 10:32:47'),
  ('01692484109', 'prescricao', '<p>USO ORAL – GESTRINONA</p>

<p>Gestrinona 2mg&nbsp;&nbsp;cápsulas gastro-resistentes</p>

<p>Tomar 01 cápsula via oral 2x por semana, à noite, por 90 dias.<br />
<br />
<br />
<br />
<br />
Uso Tópico&nbsp;<br />
<br />
<br />
2)&nbsp;Testosterona bioidêntica 10mg/g<br />
Veículo: Pentravan®<br />
Quantidade: 30g</p>

<p>Aplicar 01 pump à noite na face interna das coxas, atrás dos joelhos ou tornozelos, alternando os locais, 5x por semana, por 90 dias.</p>

<p><br />
<br />
<br />
&nbsp;</p>
', 'Danielle Candia Barra', '2026-05-25 10:53:39'),
  ('01692484109', 'prescricao', '<p>Mounjaro® (tirzepatida) 2,5mg/0,5mL<br />
Caneta preenchida</p>

<p>Aplicar 2,5mg por via subcutânea a cada 10 dias, por 90 dias.</p>

<p>Locais de aplicação:</p>

<ul>
	<li>abdome</li>
	<li>coxa</li>
	<li>braço</li>
</ul>

<p>Orientações:</p>

<ul>
	<li>alternar os locais de aplicação</li>
	<li>manter hidratação adequada</li>
	<li>aumentar ingestão proteica</li>
	<li>evitar álcool em excesso</li>
	<li>associar musculação regular</li>
	<li>em caso de náuseas intensas, vômitos persistentes ou dor abdominal importante, suspender e comunicar</li>
</ul>
', 'Danielle Candia Barra', '2026-05-25 10:56:07'),
  ('01692484109', 'prescricao', '<p>USO INTRAMUSCULAR – DOSE ÚNICA</p>

<p>Vitamina D3 200.000 UI<br />
Vitamina K2 MK-7 200mcg<br />
Vitamina A 20.000 UI</p>

<p>Aplicar 01 ampola via intramuscular profunda – dose única.</p>

<p>Orientações:</p>

<ul>
	<li>Aplicação preferencialmente em glúteo</li>
	<li>Manter hidratação adequada após aplicação</li>
	<li>Reavaliar vitamina D em aproximadamente 8–12 semanas</li>
</ul>
', 'Danielle Candia Barra', '2026-05-25 10:57:17'),
  ('01692484109', 'prescricao', '<p>USO ORAL – VITAMINA D3 + K2 MK-7</p>

<p>Vitamina D3 50.000 UI<br />
Vitamina K2 MK-7 200mcg</p>

<p>12 cápsulas gastro-resistentes</p>

<p>Tomar 01 cápsula 1x por semana, após almoço, por 12 semanas.</p>

<p>Orientações:</p>

<ul>
	<li>Associar boa hidratação</li>
	<li>Preferir exposição solar regular</li>
	<li>Tomar junto de refeição com gordura boa</li>
	<li>Reavaliar vitamina D após o término</li>
</ul>

<p>Dra. Danielle Candia Barra</p>
', 'Danielle Candia Barra', '2026-05-25 10:58:50'),
  ('79685099120', 'prescricao', '<p><br />
&nbsp;**** Tratamento para 90 dias****<br />
<br />
<br />
FÓRMULA HORMONAL FEMININA – USO TRANSDÉRMICO</p>

<p>Estradiol transdérmico adesivo 25 mcg/24h</p>

<p>&nbsp;</p>

<p>Posologia:<br />
Aplicar 1 adesivo transdérmico e trocar duas vezes por semana (a cada 3 a 4 dias), em pele limpa e seca, alternando os locais de aplicação.</p>

<p><br />
&nbsp;</p>

<p>Testosterona transdérmica adesivo 300 mcg/24h</p>

<p>Quantidade: 30 adesivos</p>

<p>Posologia:<br />
Aplicar 1 adesivo transdérmico ao dia, conforme orientação médica.</p>

<p><br />
&nbsp;</p>

<p>FÓRMULA HORMONAL FEMININA – VIA ORAL&nbsp; ( Junno ou Utrogestran)&nbsp;</p>

<p>Progesterona micronizada ............. 100 mg</p>

<p>60 cápsulas gastro-resistentes</p>

<p>Posologia:<br />
Tomar 1 cápsula à noite , uso contínuo.<br />
<br />
<br />
<strong>N95.1 + R68.82 + N92.6</strong>.<br />
<br />
CPF prescritor : 061.642.786-78</p>
', 'Danielle Candia Barra', '2026-06-01 09:39:46'),
  ('79685099120', 'prescricao', '<p>PEDIDO DE EXAMES – CHECK-UP FEMININO</p>

<p>Hemograma completo<br />
Reticulócitos<br />
Ferro sérico<br />
Ferritina<br />
Transferrina<br />
Índice de saturação da transferrina</p>

<p>Glicemia de jejum<br />
Insulina de jejum<br />
Hemoglobina glicada<br />
HOMA-IR</p>

<p>Colesterol total e frações<br />
Triglicerídeos<br />
Apolipoproteína A1<br />
Apolipoproteína B<br />
Relação Apo B/Apo A1</p>

<p>Ureia<br />
Creatinina<br />
Sódio<br />
Potássio<br />
Magnésio<br />
Cálcio<br />
Relação albumina/creatinina urinária</p>

<p>TGO<br />
TGP<br />
GGT<br />
Fosfatase alcalina<br />
Bilirrubinas totais e frações</p>

<p>TSH<br />
T4 livre<br />
T3 livre<br />
Anti-TPO<br />
Anti-tireoglobulina</p>

<p>Estradiol<br />
Progesterona<br />
FSH<br />
LH<br />
Testosterona total<br />
Testosterona livre<br />
SHBG<br />
DHEA-S<br />
Androstenediona<br />
Prolactina</p>

<p>Cortisol 8h<br />
ACTH</p>

<p>Vitamina B12<br />
Ácido fólico<br />
Vitamina D 25-OH<br />
Vitamina C<br />
Zinco<br />
Selênio</p>

<p>PCR ultrassensível<br />
Homocisteína</p>

<p>&nbsp;</p>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-06-01 09:42:18'),
  ('83206540330', 'prescricao', '<p><strong>CID-10:</strong> Z00.0 – Exame médico geral de rotina</p>

<h3>Hematologia</h3>

<ul>
	<li>Hemograma completo</li>
	<li>VHS</li>
	<li>PCR ultrassensível</li>
</ul>

<h3>Metabolismo glicídico</h3>

<ul>
	<li>Glicemia de jejum</li>
	<li>Hemoglobina glicada (HbA1c)</li>
	<li>Insulina de jejum</li>
	<li>HOMA-IR</li>
	<li>Frutosamina</li>
</ul>

<h3>Perfil lipídico e cardiovascular</h3>

<ul>
	<li>Colesterol total</li>
	<li>HDL-c</li>
	<li>LDL-c</li>
	<li>VLDL-c</li>
	<li>Triglicerídeos</li>
	<li>Apolipoproteína A1</li>
	<li>Apolipoproteína B</li>
	<li>Relação Apo B/Apo A1</li>
	<li>Lipoproteína(a)</li>
	<li>Homocisteína</li>
</ul>

<h3>Função hepática</h3>

<ul>
	<li>TGO</li>
	<li>TGP</li>
	<li>GGT</li>
	<li>Fosfatase alcalina</li>
	<li>Bilirrubinas totais e frações</li>
	<li>Albumina</li>
	<li>Proteínas totais e frações</li>
</ul>

<h3>Função renal</h3>

<ul>
	<li>Ureia</li>
	<li>Creatinina</li>
	<li>eTFG</li>
	<li>Ácido úrico</li>
	<li>EAS</li>
	<li>Relação albumina/creatinina urinária</li>
</ul>

<h3>Perfil tireoidiano</h3>

<ul>
	<li>TSH</li>
	<li>T4 livre</li>
	<li>T3 livre</li>
	<li>Anti-TPO</li>
	<li>Anti-tireoglobulina</li>
</ul>

<h3>Perfil hormonal masculino</h3>

<ul>
	<li>Testosterona total</li>
	<li>Testosterona livre</li>
	<li>SHBG</li>
	<li>LH</li>
	<li>FSH</li>
	<li>Estradiol</li>
	<li>Progesterona</li>
	<li>DHEA-S</li>
	<li>Prolactina</li>
	<li>Cortisol sérico 8h</li>
	<li>IGF-1</li>
</ul>

<h3>Vitaminas e minerais</h3>

<ul>
	<li>Vitamina D (25-OH)</li>
	<li>Vitamina B12</li>
	<li>Ácido fólico</li>
	<li>Vitamina A</li>
	<li>Vitamina C</li>
	<li>Vitamina E</li>
	<li>Zinco</li>
	<li>Selênio</li>
	<li>Magnésio eritrocitário</li>
	<li>Cobre</li>
	<li>Ferritina</li>
	<li>Ferro sérico</li>
	<li>Transferrina</li>
	<li>Saturação de transferrina</li>
</ul>

<h3>Imunidade e inflamação</h3>

<ul>
	<li>IgA</li>
	<li>IgG</li>
	<li>IgM</li>
	<li>PCR ultrassensível</li>
</ul>

<h3>Marcadores tumorais</h3>

<ul>
	<li>PSA Total</li>
	<li>PSA Livre</li>
	<li>Relação PSA Livre/Total</li>
	<li>CEA</li>
	<li>CA 19-9</li>
	<li>AFP (Alfafetoproteína)</li>
</ul>

<h3>Exames complementares</h3>
', 'Danielle Candia Barra', '2026-06-01 10:30:04'),
  ('83206540330', 'prescricao', '<p>ID-10:<br />
Z12.1 – Exame especial de rastreamento para neoplasia maligna do intestino<br />
Z00.0 – Exame médico geral de rotina</p>

<p>Solicito:</p>

<p>COLONOSCOPIA TOTAL COM BIÓPSIA, SE NECESSÁRIO.</p>

<p>Justificativa:</p>

<p>Paciente masculino, 46 anos, em acompanhamento clínico para prevenção e promoção da saúde, com indicação de rastreamento de câncer colorretal conforme recomendações atuais para indivíduos a partir dos 45 anos de idade.</p>

<p>O exame é solicitado para avaliação da mucosa colônica, identificação precoce de pólipos, lesões pré-neoplásicas, neoplasias colorretais, doenças inflamatórias intestinais e outras alterações do trato gastrointestinal inferior.</p>

<p>Solicita-se realização do exame sob sedação conforme protocolo do serviço executante.</p>

<p>Danielle Candia Barra<br />
CRM-DF 22.677</p>

<p>Nutrologia – Medicina Integrativa</p>
', 'Danielle Candia Barra', '2026-06-01 10:32:05'),
  ('83206540330', 'prescricao', '<h3>*** Tratamento para 60 dias<br />
<br />
Uso oral&nbsp;&nbsp;<br />
<br />
<br />
Bupropiona SR&nbsp; 75mg&nbsp;</h3>

<p>Tomar 01 dose pela manhã;<br />
<br />
Após tomar 01 dose de manhã e à noite.<br />
&nbsp;</p>

<p>&nbsp;</p>

<h3><br />
Naltrexona&nbsp; &nbsp;25mg</h3>

<p>&nbsp;</p>

<p>Tomar uma dose&nbsp;à noite.<br />
<br />
<br />
<strong>CID principal:</strong><br />
<br />
&nbsp;<strong>E66.0 – Obesidade devida a excesso de calorias</strong></p>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-06-01 10:49:05'),
  ('83206540330', 'prescricao', '<h3>*** Tratamento para 60 dias<br />
<br />
Uso oral&nbsp;&nbsp;<br />
<br />
<br />
Bupropiona SR&nbsp; 75mg&nbsp;</h3>

<p>Tomar 01 dose pela manhã;<br />
<br />
Após tomar 01 dose de manhã e à noite.<br />
&nbsp;</p>

<p>&nbsp;</p>

<h3><br />
Naltrexona&nbsp; &nbsp;25mg</h3>

<p>&nbsp;</p>

<p>Tomar uma dose&nbsp;à noite.<br />
<br />
<br />
<strong>CID principal:</strong><br />
<br />
&nbsp;<strong>E66.0 – Obesidade devida a excesso de calorias</strong></p>
', 'Danielle Candia Barra', '2026-06-01 10:49:51'),
  ('83206540330', 'prescricao', '<p><strong>Uso interno</strong></p>

<p>&nbsp;</p>

<p>1-</p>
Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg
<p>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
&nbsp;<br />
2-</p>

<p>Betaina HCl ...............................................................................300 mg<br />
Mande 60 doses.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, no almoço<br />
e jantar.</p>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-06-01 10:59:26'),
  ('49800116915', 'prescricao', '<h4>Hemograma e inflamação</h4>

<ul>
	<li>Hemograma completo</li>
	<li>VHS</li>
	<li>PCR ultrassensível</li>
</ul>

<h4>Metabolismo glicídico</h4>

<ul>
	<li>Glicemia de jejum</li>
	<li>Insulina de jejum</li>
	<li>Hemoglobina glicada (HbA1c)</li>
	<li>HOMA-IR</li>
	<li>Frutosamina</li>
</ul>

<h4>Perfil lipídico e cardiovascular</h4>

<ul>
	<li>Colesterol total</li>
	<li>HDL</li>
	<li>LDL</li>
	<li>Triglicerídeos</li>
	<li>Apo A1</li>
	<li>Apo B</li>
	<li>Lipoproteína(a) – Lp(a)</li>
	<li>LDL oxidado</li>
	<li>Fibrinogênio</li>
	<li>Homocisteína</li>
</ul>

<h4>Ferro e metabolismo do ferro</h4>

<ul>
	<li>Ferro sérico</li>
	<li>Ferritina</li>
	<li>Transferrina</li>
	<li>Saturação de transferrina</li>
</ul>

<h4>Função hepática</h4>

<ul>
	<li>TGO</li>
	<li>TGP</li>
	<li>GGT</li>
	<li>Fosfatase alcalina</li>
	<li>Bilirrubinas totais e frações</li>
</ul>

<h4>Função renal</h4>

<ul>
	<li>Ureia</li>
	<li>Creatinina</li>
	<li>eTFG</li>
	<li>Sódio</li>
	<li>Potássio</li>
	<li>EAS (urina tipo I)</li>
	<li>Relação albumina/creatinina urinária</li>
</ul>

<h4>Tireoide</h4>

<ul>
	<li>TSH</li>
	<li>T4 livre</li>
	<li>T3 livre</li>
	<li>Anti-TPO</li>
	<li>Anti-Tireoglobulina</li>
	<li>Selênio sérico</li>
	<li>Iodo urinário</li>
</ul>

<h4>Hormonal</h4>

<ul>
	<li>Estradiol</li>
	<li>Progesterona</li>
	<li>Testosterona total</li>
	<li>Testosterona livre calculada</li>
	<li>SHBG</li>
	<li>DHEA-S</li>
	<li>Cortisol 8h</li>
	<li>IGF-1</li>
	<li>Prolactina</li>
</ul>

<h4>Vitaminas e minerais</h4>

<ul>
	<li>Vitamina D 25-OH</li>
	<li>Vitamina B12</li>
	<li>Ácido fólico</li>
	<li>Vitamina C</li>
	<li>Magnésio eritrocitário</li>
	<li>Zinco</li>
	<li>Selênio</li>
	<li>Cobre</li>
</ul>

<h4>Avaliação metabólica complementar</h4>

<ul>
	<li>Ácido úrico</li>
	<li>Insulina pós-prandial 2h (opcional)</li>
	<li>Leptina</li>
	<li>Adiponectina (se disponível)</li>
</ul>

<h4>Marcadores tumorais (check-up)</h4>

<ul>
	<li>CEA</li>
	<li>CA 19-9</li>
	<li>CA 125</li>
	<li>CA 15-3</li>
	<li>AFP</li>
</ul>
', 'Danielle Candia Barra', '2026-06-01 11:31:27'),
  ('49800116915', 'prescricao', '<p>&nbsp;</p>

<p>Solico a realização de:</p>

<p>COLONOSCOPIA TOTAL COM POSSIBILIDADE DE BIÓPSIA E/OU POLIPECTOMIA, SE INDICADO DURANTE O PROCEDIMENTO.</p>

<p>Justificativa clínica:</p>

<p>Paciente feminina, 63 anos, em acompanhamento clínico preventivo, apresentando fatores de risco cardiometabólicos e necessidade de rastreamento de neoplasia colorretal conforme recomendações atuais para sua faixa etária.</p>

<p>O exame é indicado para:</p>

<ul>
	<li>Rastreamento de câncer colorretal.</li>
	<li>Pesquisa de pólipos adenomatosos e lesões precursoras.</li>
	<li>Avaliação da mucosa colônica.</li>
	<li>Prevenção e diagnóstico precoce de doenças colorretais.</li>
</ul>

<p>CID-10:<br />
Z12.1 – Exame especial para rastreamento de neoplasia maligna do intestino.<br />
Z13.9 – Rastreamento de doenças sem diagnóstico estabelecido.</p>

<p>Atenciosamente,</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22677<br />
RQE 13830</p>
', 'Danielle Candia Barra', '2026-06-01 11:32:42'),
  ('49800116915', 'prescricao', '<p>Solicito a realização dos seguintes exames:</p>

<ol start=&quot;1&quot;>
	<li>ULTRASSONOGRAFIA DE ABDOME TOTAL</li>
</ol>

<p>Justificativa:<br />
Avaliação de fígado, vesícula biliar, vias biliares, pâncreas, baço, rins e aorta abdominal, em paciente com alterações metabólicas, ferritina elevada e acompanhamento clínico preventivo.</p>

<p>CID-10:<br />
R79.8<br />
E78.5</p>

<ol start=&quot;2&quot;>
	<li>ULTRASSONOGRAFIA DE TIREOIDE COM DOPPLER</li>
</ol>

<p>Justificativa:<br />
Acompanhamento de tireoidite autoimune (Hashimoto), hipotireoidismo subclínico e rastreamento de nódulos tireoidianos.</p>

<p>CID-10:<br />
E06.3<br />
E03.8</p>

<ol start=&quot;3&quot;>
	<li>ULTRASSONOGRAFIA DE MAMAS BILATERAL</li>
</ol>

<p>Justificativa:<br />
Rastreamento e acompanhamento preventivo das mamas em paciente pós-menopausa.</p>

<p>CID-10:<br />
Z12.3</p>

<ol start=&quot;4&quot;>
	<li>ULTRASSONOGRAFIA TRANSVAGINAL</li>
</ol>

<p>Justificativa:<br />
Avaliação ginecológica de rotina em paciente pós-menopausa, incluindo útero, ovários, endométrio e anexos.</p>

<p>CID-10:<br />
Z01.4<br />
N95.1</p>

<p>Observação:<br />
Correlacionar os achados com os exames laboratoriais, avaliação clínica e demais exames de imagem em acompanhamento.</p>
', 'Danielle Candia Barra', '2026-06-01 11:33:29'),
  ('04945317542', 'prescricao', '<p><strong>Fórmula manipulada<br />
<br />
1-&nbsp;</strong></p>

<ul>
	<li>N-acetilcisteína (NAC) 600 mg</li>
	<li>Diindolilmetano (DIM) 100 mg</li>
	<li>Indol-3-Carbinol (I3C) 200 mg</li>
	<li>Chlorella vulgaris 300 mg</li>
</ul>

<p>Posologia:<br />
Tomar 1 cápsula 2x ao dia, após almoço e jantar. Por 60 dias</p>
', 'Ana Carolina Candia Barra', '2026-06-01 15:24:53'),
  ('71468951149', 'prescricao', '<p>1-<br />
HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</p>

<p><br />
Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.</p>
', 'Ana Carolina Candia Barra', '2026-06-03 14:23:10'),
  ('83395296768', 'prescricao', '<p>1- para manipular<br />
<br />
HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</p>

<p><br />
Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
2- Para comprar na internet<br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias.&nbsp;<br />
<br />
&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-06-03 15:58:15'),
  ('04945317542', 'prescricao', '<h3>Tratamento para 90 dias&nbsp;<br />
<br />
<br />
Fórmula 1 – Fertilidade, qualidade ovocitária e endometriose</h3>

<p><strong>Cápsulas gastro-resistentes – 120 cápsulas</strong></p>

<ul>
	<li>Coenzima Q10 100 mg</li>
	<li>N-acetilcisteína (NAC) 600 mg</li>
	<li>Vitamina E natural 100 UI</li>
	<li>Selênio quelato 100 mcg</li>
</ul>

<p>Tomar 1 cápsula 2x ao dia.</p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>qualidade mitocondrial do ovócito</li>
	<li>redução do estresse oxidativo</li>
	<li>suporte à endometriose</li>
	<li>suporte à implantação</li>
</ul>

<hr />
<h3>Fórmula 2 – Metilação e redução da homocisteína</h3>

<p><strong>Cápsulas gastro-resistentes – 120 cápsulas</strong></p>

<ul>
	<li>Metilfolato 800 mcg</li>
	<li>Metilcobalamina 1.000 mcg</li>
	<li>Piridoxal-5-fosfato (B6 ativa) 25 mg</li>
	<li>Riboflavina (B2) 10 mg</li>
	<li>Colina 250 mg</li>
	<li>Mio-inositol 500 mg</li>
</ul>

<p>Tomar 1 cápsula 2x ao dia.</p>

<p>&nbsp;</p>

<hr />
<h3>Fórmula 3 – Sono e recuperação</h3>

<p><strong>Cápsulas gastro-resistentes – 90 cápsulas</strong></p>

<ul>
	<li>Magnésio bisglicinato 200 mg</li>
	<li>L-teanina 200 mg</li>
	<li>Inositol 500 mg</li>
	<li>Melatonina 2 gramas</li>
</ul>

<p>Tomar 1 cápsula 30–60 minutos antes de dormir.</p>

<p>Pode manter a melatonina que já utiliza.</p>

<hr />
<h3>Vitamina D (separada)</h3>

<p><strong>Vitamina D3 6.000 UI</strong><br />
<strong>Vitamina K2 MK-7 100 mcg</strong></p>

<p>Tomar 1 cápsula ao dia após almoço.</p>

<p>Meta:</p>

<ul>
	<li>vitamina D entre 50–70 ng/mL.</li>
</ul>

<hr />
<h3>&nbsp;</h3>
', 'Danielle Candia Barra', '2026-06-08 10:33:08'),
  ('04945317542', 'prescricao', '<p>&nbsp;</p>

<p>Noripurum® EV 100 mg/5 mL</p>

<p>Aplicar 01 ampola (100 mg de ferro III) por via endovenosa lenta, dose única.&nbsp;</p>

<p>Orientações:</p>

<ul>
	<li>Administrar em ambiente com suporte para intercorrências.</li>
	<li>Monitorar sinais vitais durante a infusão.</li>
	<li>Reavaliar ferritina, ferro sérico, saturação de transferrina e hemograma 30 dias após a última aplicação.</li>
</ul>

<p>CID-10:<br />
N97.9 – Infertilidade feminina não especificada<br />
N80.9 – Endometriose não especificada</p>
', 'Danielle Candia Barra', '2026-06-08 10:36:54'),
  ('04945317542', 'prescricao', '<p>Paciente: DOMITÍLIA OLIVEIRA ROCHA</p>

<p>Solicito a realização de:</p>

<p>&nbsp;Ultrassonografia Transvaginal com Mapeamento para Endometriose Profunda</p>

<p>Indicações:</p>

<ul>
	<li>Histórico de endometriose profunda com acometimento intestinal.</li>
	<li>Pós-operatório de ressecção de focos de endometriose.</li>
	<li>Infertilidade há 10 anos.</li>
	<li>Programação para Fertilização In Vitro (FIV).</li>
	<li>Avaliação de recorrência de focos endometrióticos.</li>
	<li>Avaliação ovariana, anexial e da anatomia pélvica pré-estimulação ovariana.</li>
</ul>
', 'Danielle Candia Barra', '2026-06-08 10:44:33'),
  ('64633160168', 'prescricao', '<p>HEMATOLOGIA E INFLAMAÇÃO</p>

<ul>
	<li>Hemograma completo</li>
	<li>VHS</li>
	<li>Proteína C reativa ultrassensível (PCR-us)</li>
	<li>Ferritina</li>
	<li>Ferro sérico</li>
	<li>Transferrina</li>
	<li>Saturação da transferrina</li>
</ul>

<p>METABOLISMO GLICÍDICO</p>

<ul>
	<li>Glicemia de jejum</li>
	<li>Hemoglobina glicada (HbA1c)</li>
	<li>Insulina de jejum</li>
	<li>Peptídeo C</li>
	<li>HOMA-IR</li>
</ul>

<p>PERFIL LIPÍDICO E CARDIOVASCULAR</p>

<ul>
	<li>Colesterol total</li>
	<li>HDL-colesterol</li>
	<li>LDL-colesterol</li>
	<li>VLDL-colesterol</li>
	<li>Triglicerídeos</li>
	<li>Apolipoproteína A1</li>
	<li>Apolipoproteína B</li>
	<li>Lipoproteína (a)</li>
	<li>Homocisteína</li>
	<li>Ácido úrico</li>
</ul>

<p>FUNÇÃO HEPÁTICA</p>

<ul>
	<li>TGO (AST)</li>
	<li>TGP (ALT)</li>
	<li>Gama GT</li>
	<li>Fosfatase alcalina</li>
	<li>Bilirrubinas totais e frações</li>
</ul>

<p>FUNÇÃO RENAL</p>

<ul>
	<li>Ureia</li>
	<li>Creatinina</li>
	<li>eTFG</li>
	<li>Urina tipo I</li>
	<li>Relação albumina/creatinina urinária</li>
</ul>

<p>TIREOIDE</p>

<ul>
	<li>TSH</li>
	<li>T4 Livre</li>
	<li>T3 Livre</li>
	<li>Anti-TPO</li>
	<li>Anti-Tireoglobulina</li>
</ul>

<p>PERFIL HORMONAL FEMININO</p>

<ul>
	<li>Estradiol</li>
	<li>Progesterona</li>
	<li>FSH</li>
	<li>LH</li>
	<li>Testosterona total</li>
	<li>Testosterona livre</li>
	<li>SHBG</li>
	<li>DHEA-S</li>
	<li>Androstenediona</li>
	<li>Prolactina</li>
</ul>

<p>SUPRARRENAL E LONGEVIDADE</p>

<ul>
	<li>Cortisol sérico 8h</li>
	<li>IGF-1</li>
</ul>

<p>VITAMINAS E MICRONUTRIENTES</p>

<ul>
	<li>Vitamina D (25-OH)</li>
	<li>Vitamina B12</li>
	<li>Ácido fólico</li>
	<li>Zinco</li>
	<li>Magnésio</li>
	<li>Selênio</li>
</ul>

<p>&nbsp;</p>

<p>MARCADORES TUMORAIS FEMININOS</p>

<ul>
	<li>CEA</li>
	<li>CA 125</li>
	<li>CA 15-3</li>
	<li>CA 19-9</li>
	<li>Alfa-fetoproteína (AFP)</li>
</ul>
<br />
Solicito : Coprológico Funcional&nbsp;', 'Danielle Candia Barra', '2026-06-08 11:49:03'),
  ('64633160168', 'prescricao', '<p>EXAMES DE IMAGEM</p>

<ul>
	<li>Ultrassonografia transvaginal</li>
	<li>Ultrassonografia de mamas</li>
	<li>Ultrassonografia de abdome total</li>
	<li>Ultrassonografia de tireoide com Doppler</li>
</ul>
<br />
<br />
<br />
Cid : Z00', 'Danielle Candia Barra', '2026-06-08 11:49:55'),
  ('02160204170', 'prescricao', 'Fórmula 1 – Reparo intestinal<br />
<br />
Glutamina .............. 5 g<br />
Tomar 1 dose em jejum e 1 dose ao deitar. por 60 dias<br />
<br />
Fórmula 2 – Mucosa e barreira intestinal<br />
<br />
Zinco carnosina ........ 75 mg<br />
N-acetil glucosamina ... 500 mg<br />
Quercetina ............. 250 mg<br />
Tomar 1 cápsula 2x ao dia. por 60 dias<br />
<br />
Fórmula 3 – Diversidade intestinal<br />
<br />
Goma Acácia ............ 5 g<br />
Iniciar com 1 colher medida ao dia.&nbsp;<br />
Após 15 dias aumentar para 2x/dia. manhã e tarde. POR 60 dias.<br />
<br />
Fórmula 4 – Produção de butirato<br />
<br />
CoreBiome® ............. 500 mg<br />
Tomar 1 cápsula 2x ao dia junto às refeições. Por 60 dias<br />
(ou conforme a concentração disponível na farmácia)&nbsp;<br />
<br />
Fórmula 5 – Complexo B ativo<br />
B1 (benfotiamina) ...... 50 mg<br />
B2 ..................... 20 mg<br />
B3 ..................... 50 mg<br />
B5 ..................... 100 mg<br />
P5P .................... 25 mg<br />
Metilfolato ............ 400 mcg<br />
Metilcobalamina ........ 1000 mcg<br />
Biotina ................ 5 mg<br />
Tomar 1 cápsula pela manhã. Por 60 dias<br />
<br />
Fórmula 6 – Anti-inflamatório<br />
Ômega 3 990 de EPA e 660 de DHA ( sugestão, vitafor plus)<br />
Tomar 3 x ao dia , café da manhã, almoço e jantar. por 60 dias<br />
<br />
Vitamina D<br />
manter a prescrição anterior por 60 dias.&nbsp;', 'Ana Carolina Candia Barra', '2026-06-08 12:37:10'),
  ('06336262103', 'prescricao', '1. Reparação de mucosa intestinal<br />
<br />
Zinco Carnosina 75 mg<br />
Tomar 1 cápsula após café da manhã e 1 cápsula após jantar. Por 60 dias<br />
<br />
2. Modulação inflamatória intestinal<br />
Tributirina 300 mg<br />
Tomar 1 cápsula após almoço e 1 cápsula após jantar.<br />
Após 15 dias:<br />
Se não houver desconforto:<br />
aumentar para 2 cápsulas após almoço.<br />
2 cápsulas após jantar - Por 60 dias.<br />
<br />
3. Modulação inflamatória<br />
Quercetina 250 mg<br />
Tomar 1 cápsula após café da manhã e 1 cápsula às 17h. Por 60 dias.<br />
<br />
4.&nbsp;<br />
Vitamina C 500 mg<br />
Tomar 1 cápsula após café da manhã e 1 cápsula após almoço. Por 60 dias.<br />
<br />
5. Neuroinflamação e mucosa<br />
Ômega 3 - Sugestão ( Super Omega 3 1080 de EPA e 730 de DHA da Essencial nutrition)<br />
Tomar junto ao almoço e jantar - Uso contínuo até reavaliação<br />
<br />
6. Motilidade intestinal<br />
<br />
Magnésio citrato 400mg&nbsp;<br />
Tomar 1 x ao dia a noite antes de dormir. Por 60 dias.&nbsp;<br />
<br />
7- devido a ausencia de Akkermancia no exames da microbiota<br />
<br />
Saccharomyces boulardii 250 mg<br />
1 cápsula após almoço por 30 dias.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-10 15:40:49'),
  ('78380782615', 'prescricao', 'Uso Oral<br />
<br />
1-<br />
Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00,&nbsp;<strong>após refeições.&nbsp; por 60 dias.<br />
Dica: lanche da tarde com proteina e gordura, whey, abocado, pasta de amendoim etc..<br />
<br />
2- ( Azul de metileno, mais foco e energia)</strong><br />
<br />
Clereto de metiltionínio................................30mg
<p>Tomar 1 dose no lanche da manhã&nbsp;&nbsp;por 60 dias.<br />
<br />
3-<br />
Ômega 3 Mega DHA ( vita for)&nbsp;<br />
Tomar 3 x ao dia café da manhã, almoço e jantar</p>
', 'Ana Carolina Candia Barra', '2026-06-11 15:14:44'),
  ('78380782615', 'prescricao', 'Uso Oral<br />
<br />
1-<br />
Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00,&nbsp;<strong>após refeições.&nbsp; por 60 dias.<br />
Dica: lanche da tarde com proteina e gordura, whey, abocado, pasta de amendoim etc..<br />
<br />
2- ( Azul de metileno, mais foco e energia)</strong><br />
<br />
Clereto de metiltionínio................................30mg
<p>Tomar 1 dose no lanche da manhã&nbsp;&nbsp;por 60 dias.<br />
<br />
3-<br />
Ômega 3 Mega DHA ( vita for)&nbsp;<br />
Tomar 3 x ao dia café da manhã, almoço e jantar</p>
', 'Ana Carolina Candia Barra', '2026-06-11 15:14:45'),
  ('79685099120', 'prescricao', '<p>Rhodiola rosea (padronizada em 3% de rosavinas) ………. 100 mg<br />
Melissa officinalis ………………………………………………… 200 mg<br />
Magnésio bisglicinato ……………………………………………. 150 mg</p>

<p>&nbsp;</p>

<p>Veículo q.s.p. 1 cápsula gastro-resistente</p>

<p>&nbsp;</p>

<p>Posologia:<br />
Tomar 1 cápsula após o jantar por 7 dias.<br />
Após adaptação, aumentar para 1 cápsula 2x ao dia (após almoço e jantar).</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-06-11 15:31:14'),
  ('07943713109', 'prescricao', '<p><strong>Fórmula manipulada<br />
<br />
1-&nbsp;</strong></p>

<ul>
	<li>N-acetilcisteína (NAC) 600 mg</li>
	<li>Diindolilmetano (DIM) 100 mg</li>
	<li>Indol-3-Carbinol (I3C) 200 mg</li>
	<li>Chlorella vulgaris 300 mg</li>
</ul>

<p>Posologia:<br />
Tomar 1 cápsula 2x ao dia, após almoço e jantar. Por 60 dias</p>
', 'Ana Carolina Candia Barra', '2026-06-16 09:52:44'),
  ('85260665104', 'prescricao', 'Para Manipulação<br />
<br />
1-<br />
Melatonina time release .1 mg<br />
Magnésio bisglicinato.. 200mg<br />
L-teanina ................... 200mg<br />
Glicina .........................500mg<br />
Inositol..........................500mg<br />
5HTP...............................50mg<br />
<br />
Excipiente q.s.p. cápsula grastro- resisten<br />
<br />
2-
<ul>
	<li>N-acetilcisteína (NAC) 600 mg</li>
	<li>Diindolilmetano (DIM) 100 mg</li>
	<li>Indol-3-Carbinol (I3C) 200 mg</li>
</ul>

<p>Posologia:<br />
Tomar 1 cápsula 2x ao dia, após almoço e jantar. Por 60 dias<br />
&nbsp;</p>
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-16 12:04:29'),
  ('85260665104', 'prescricao', 'Suplementação clínica&nbsp;<br />
<br />
1&nbsp;<br />
ômega 3&nbsp;<br />
3 x ao dia 1 caps. no café da manhã, 1 no almoço e 1 no jantar...<br />
<br />
2<br />
Demagre:<br />
2 caps. 2 x ao dia nos lanches.<br />
<br />
3<br />
Equilibrium&nbsp;<br />
2 x ao dia, 7 gotas sublingual , de manhã e antes de dormir.&nbsp;<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-16 12:10:03'),
  ('21639183191', 'prescricao', 'para manipular<br />
<br />
1-<br />
Magnésio bisglicinato 200mg<br />
Taurina 500mg<br />
Potássio citrato 200mg<br />
Colágeno tipo 1 e 2 - 10g<br />
<br />
Tomar 1 sache 1 x ao dia por 30 dias, a noite. por 30 dias', 'Ana Carolina Candia Barra', '2026-06-17 12:12:19'),
  ('04288150140', 'prescricao', '1-<br />
Crocus Sativus .... 30mg<br />
Tomar 1 dose após o café da manhã; por 7 dias, observar tolerancia gástrica se ficar bem após os 7 dias, incluir mais uma dose após o almoço.&nbsp; Por 60 dias.&nbsp;<br />
<br />
2-<br />
Ômega 3 - mega DHA,&nbsp; EPA 700 e DHA 1200.<br />
<br />
Tomar de uma a 2 x ao dia junto as refeições dependendo da formulação. uso contínuo.&nbsp;<br />
<br />
3-<br />
Berberina 500mg<br />
<br />
Tomar 1 dose 2 x ao dia antes do almoço e antes do jantar, por 60 dias.&nbsp;&nbsp;<br />
Após 15 dias, se tolerar bem, incluir mais uma dose&nbsp; no café da manhã.<br />
<br />
4-<br />
magnésio bisglicinato&nbsp; elementar 400mg<br />
<br />
tomar 1&nbsp; dose até uma hora antes de dormir. Por 60 dias.&nbsp;<br />
<br />
5-<br />
Silimarina 200mg<br />
Saccharomyces boulardii ..5bilhões&nbsp; UFC<br />
<br />
Tomar 1 dose 2 x ao dia, após o almoço e após o jantar. Por 30 dias.&nbsp;<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-19 14:17:05'),
  ('69982490125', 'prescricao', '<h3>Fórmula 1 – Reparação da Barreira Intestinal (60 sachês)</h3>

<ul>
	<li>L-Glutamina ............... 10 g</li>
	<li>N-acetil-D-glicosamina ............... 500 mg</li>
	<li>Zinco carnosina ............... 75 mg</li>
	<li>Colágeno hidrolisado tipo I ............... 5 g</li>
</ul>

<p><strong>Posologia:</strong><br />
Diluir 1 sachê em 200 mL de água e tomar em jejum diariamente.</p>

<hr />
<h3>Fórmula 2 – Modulação da Permeabilidade e Inflamação Intestinal (120 cápsulas gastro-resistentes)</h3>

<ul>
	<li>Boswellia serrata (20% AKBA) ............... 50 mg</li>
	<li>Quercetina ............... 400 mg</li>
	<li>N-acetilcisteína (NAC) ............... 150 mg</li>
	<li>Vitamina C ............... 250 mg</li>
	<li>Tocotrienóis (Tocotrimax®) ............... 150 mg</li>
	<li>Zinco bisglicinato ............... 20 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula após o café da manhã e 1 cápsula após o jantar.<br />
<br />
&nbsp;</p>

<h3>Suporte Digestivo (60 cápsulas gastro-resistentes)</h3>

<ul>
	<li>Betaína HCl ............... 200 mg</li>
	<li>Pepsina ............... 50 mg</li>
	<li>Pancreatina ............... 150 mg</li>
	<li>Lactase ............... 4.500 FCC</li>
</ul>

<p><strong>Posologia:</strong><br />
1 cápsula no almoço e 1 cápsula no jantar.<br />
<br />
<br />
&nbsp;</p>

<p><strong>90 cápsulas gastro-resistentes</strong></p>

<ul>
	<li>Vitamina D3 ............... 10.000 UI</li>
	<li>Vitamina K2 MK-7 ............... 100 mcg</li>
	<li>Selênio ............... 200 mcg</li>
	<li>Zinco bisglicinato ............... 15 mg</li>
	<li>Magnésio glicina ............... 150 mg</li>
	<li>L-tirosina ............... 300 mg</li>
	<li>Coenzima Q10 ............... 100 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula após o café da manhã diariamente.</p>

<p><br />
&nbsp;</p>
', 'Danielle Candia Barra', '2026-06-22 09:59:48'),
  ('69982490125', 'prescricao', '<h3>Fórmula Fitoterápica para Suporte Androgênico Feminino (90 cápsulas gastro-resistentes)</h3>

<ul>
	<li>Ashwagandha KSM-66® ............... 300 mg</li>
	<li>Feno-grego (Fenuside®) ............... 300 mg</li>
	<li>Maca peruana concentrada ............... 500 mg</li>
	<li>Long Jack (Eurycoma longifolia) ............... 100 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula após o café da manhã e 1 cápsula após o jantar.</p>
', 'Danielle Candia Barra', '2026-06-22 10:07:58'),
  ('83206540330', 'prescricao', '<p>COLUNA CERVICAL</p>

<p>• Ressonância magnética da coluna cervical</p>

<p>Justificativa:<br />
Investigação de protrusões discais, hérnias cervicais, compressão radicular, estenose foraminal e outras causas de cervicobraquialgia associada à parestesia em membros superiores.<br />
<br />
<br />
M54.2 – Cervicalgia</p>
', 'Danielle Candia Barra', '2026-06-22 10:29:44'),
  ('83206540330', 'prescricao', 'Solicito :&nbsp;<br />
<br />
<br />
<br />
• Ressonância magnética do ombro direito (se limitação funcional importante)<br />
• Ressonância magnética do ombro esquerdo<br />
<br />
<br />
<br />
R20.2 – Parestesia da pele<br />
M54.1 – Radiculopatia<br />
G56.0 – Síndrome do túnel do carpo (a esclarecer)', 'Danielle Candia Barra', '2026-06-22 10:30:48'),
  ('83206540330', 'prescricao', '<p>**** Tratamento para 90 dias<br />
<br />
Uso oral&nbsp;<br />
<br />
FÓRMULA 1 – COMPLEXO B METABÓLICO PREMIUM</p>

<p>5-MTHF ............................................... 1 mg<br />
Metilcobalamina .................................. 1.000 mcg<br />
Benfotiamina ...................................... 150 mg<br />
Riboflavina-5-fosfato ............................ 25 mg<br />
Piridoxal-5-fosfato ............................... 25 mg<br />
Niacinamida ....................................... 100 mg<br />
Pantotenato de cálcio ............................ 150 mg<br />
Magnésio bisglicinato ............................ 150 mg<br />
Vitamina C ........................................ 500 mg</p>

<p>&nbsp;cápsulas gastro-resistentes</p>

<p>Posologia:<br />
Tomar 1 cápsula após o café da manhã.<br />
<br />
<br />
&nbsp;</p>

<p>FÓRMULA 2 – SUPORTE HORMONAL MASCULINO (CICLO 1 – 90 DIAS)</p>

<p>Ashwagandha KSM-66® .............................. 300 mg<br />
Tongkat Ali (Eurycoma longifolia) ............... 200 mg<br />
Boro quelado ..................................... 3 mg<br />
Zinco bisglicinato ............................... 25 mg<br />
Magnésio bisglicinato ............................ 200 mg<br />
Vitamina D3 ...................................... 4.000 UI<br />
Vitamina K2 MK-7 ................................ 100 mcg</p>

<p>90 cápsulas</p>

<p>Posologia:<br />
Tomar 1 cápsula após o café da manhã.<br />
<br />
<br />
&nbsp;</p>

<p>FÓRMULA 03&nbsp; SONO PROFUNDO E RECUPERAÇÃO</p>

<p>Magnésio L-Treonato ...................... 500 mg<br />
Magnésio Bisglicinato .................... 300 mg<br />
L-Teanina ................................ 200 mg<br />
Glicina .................................. 1.000 mg<br />
Taurina .................................. 500 mg<br />
Melatonina ............................... 0,5 mg</p>

<p>&nbsp;</p>

<p>Posologia:<br />
Tomar 01 dose ,&nbsp;&nbsp;60 minutos antes de dormir.</p>
', 'Danielle Candia Barra', '2026-06-22 11:01:10'),
  ('64633160168', 'prescricao', '<h3>Fórmula 1 – Reparo de Mucosa e Integridade Intestinal</h3>

<p><strong>Sachês – 60 doses</strong></p>

<ul>
	<li>L-Glutamina ................. 10 g</li>
	<li>N-acetil-D-glicosamina ....... 500 mg</li>
	<li>Zinco carnosina .............. 75 mg</li>
	<li>Tributirina .................. 300 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Diluir 1 sachê em água e tomar em jejum pela manhã.</p>

<hr />
<h3>Fórmula 2 – Modulação Inflamatória e Menopausa</h3>

<p><strong>60 cápsulas</strong></p>

<ul>
	<li>Curcumina BCM-95® ............ 250 mg</li>
	<li>Boswellia serrata (30% AKBA) . 100 mg</li>
	<li>Quercetina ................... 250 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
1 cápsula após almoço e 1 cápsula após jantar.</p>

<hr />
<h3>Fórmula 3 – Suporte Metilação e Homocisteína</h3>

<p>(Homocisteína 10,7)</p>

<p><strong>60 cápsulas</strong></p>

<ul>
	<li>Metilcobalamina .............. 1.000 mcg</li>
	<li>Metilfolato .................. 800 mcg</li>
	<li>Piridoxal-5-fosfato .......... 25 mg</li>
	<li>Riboflavina .................. 10 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
1 cápsula após café da manhã.</p>

<hr />
<h3>Enzimas Digestivas</h3>

<p><strong>90 cápsulas gastro-resistentes</strong></p>

<ul>
	<li>Lipase ....................... 5.000 FIP</li>
	<li>Protease ..................... 20.000 HUT</li>
	<li>Amilase ...................... 5.000 DU</li>
	<li>Lactase ...................... 3.000 ALU</li>
	<li>Alfa-galactosidase ........... 150 GALU</li>
</ul>

<p><strong>Posologia:</strong><br />
1 cápsula 10 minutos antes do almoço e jantar.<br />
<br />
<br />
<br />
&nbsp;</p>

<h3>Vitamina D + K2 – 90 dias</h3>

<p><strong>Vitamina D3</strong> ............... 5.000 UI<br />
<strong>Vitamina K2 MK-7</strong> .......... 100 mcg<br />
Coenzima Q10 ................150mg</p>

<p><strong>90 cápsulas</strong></p>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula após o almoço diariamente.</p>

<hr />
<h3>Fórmula Sono e Recuperação Profunda – Magnésios Combinados</h3>

<p><strong>90 cápsulas</strong></p>

<ul>
	<li>Magnésio Bisglicinato ........ 150 mg</li>
	<li>Magnésio Treonato ............ 150 mg</li>
	<li>Magnésio Taurato ............. 150 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 01 dose 1 hora antes de dormir.</p>
', 'Danielle Candia Barra', '2026-06-22 11:56:33'),
  ('64633160168', 'prescricao', '<p>Solicito a realização de <strong>Polissonografia Noturna Completa</strong>, para investigação de distúrbio do sono.</p>

<p><strong>Justificativa Clínica:</strong></p>

<p>Paciente do sexo feminino, 50 anos, em transição menopausal, apresentando quadro compatível com distúrbio do sono, associado a fadiga, alterações hormonais do climatério, uso crônico de medicações de ação central e queixas que impactam a qualidade do sono e a recuperação física.</p>

<p>A avaliação objetiva da arquitetura do sono é fundamental para investigação de:</p>

<ul>
	<li>Apneia Obstrutiva do Sono (AOS);</li>
	<li>Hipopneia do sono;</li>
	<li>Fragmentação do sono;</li>
	<li>Distúrbios respiratórios relacionados ao sono;</li>
	<li>Movimentos periódicos dos membros;</li>
	<li>Alterações da arquitetura do sono associadas ao climatério;</li>
	<li>Avaliação da eficiência e qualidade global do sono.</li>
</ul>

<p>O resultado do exame auxiliará na definição diagnóstica e direcionamento terapêutico adequado.</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>G47.3 – Apneia do sono</li>
	<li>G47.0 – Distúrbios do início e da manutenção do sono (insônia)</li>
	<li>N95.1 – Estado da menopausa e climatério feminino</li>
</ul>
', 'Danielle Candia Barra', '2026-06-22 11:57:06'),
  ('64633160168', 'prescricao', '<p><strong>Levotiroxina sódica (T4) 25 mcg</strong><br />
<strong>Liotironina sódica (T3) 3 mcg</strong></p>

<p>Manipular em cápsulas gastro-resistentes.</p>

<p>Quantidade: 90 cápsulas.</p>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula pela manhã, em jejum, aproximadamente 30 a 60 minutos antes do café da manhã.</p>

<p>Orientações:</p>

<ul>
	<li>Evitar ingestão concomitante com ferro, cálcio, magnésio, multivitamínicos e fibras.</li>
	<li>Manter intervalo mínimo de 4 horas entre a medicação e suplementos minerais.</li>
	<li>Reavaliar TSH, T4 livre e T3 livre após 6 a 8 semanas.</li>
</ul>
', 'Danielle Candia Barra', '2026-06-22 11:59:30'),
  ('64633160168', 'prescricao', '<p><strong>ATESTADO MÉDICO</strong></p>

<p>Atesto, para os devidos fins, que a paciente <strong>ROBERTA CARDOSO ALMEIDA MARAVIESKI</strong>, esteve em consulta médica nesta data, necessitando de afastamento de suas atividades habituais durante o <strong>período matutino</strong>, para avaliação e acompanhamento de sua condição de saúde.</p>

<p>CID-10:</p>

<ul>
	<li>E03.9 – Hipotireoidismo não especificado</li>
</ul>
', 'Danielle Candia Barra', '2026-06-22 12:04:23'),
  ('91163471100', 'prescricao', 'fase 2 - 30 dias&nbsp;<br />
<br />
1&nbsp;<br />
L Glutamina 5G&nbsp;<br />
tomar 1 x ao dia em jejum, uso continuo<br />
<br />
2-<br />
N-acetil glucosamina 500mg<br />
zinco carnosina&nbsp; 75 mg<br />
Tributirina 500mg<br />
<br />
Tomar 2 x ao dia manhã e tarde. por 30 dias&nbsp;<br />
<br />
3-<br />
Saccharomyces boulardii&nbsp; 5 bilhoes UFC<br />
1 x ao dia no café da manhã. por 30 dias&nbsp;<br />
<br />
4-<br />
Protease 150mg<br />
Amilase 100mg<br />
lipase 50mg<br />
Lactase 100mg<br />
bromelina 150mg<br />
<br />
Tomar 2 x ao dia, 1 dose no inicio do almoço e no jantar. por 30 dias&nbsp;', 'Ana Carolina Candia Barra', '2026-06-22 12:05:44'),
  ('71468951149', 'prescricao', '<ul>
	<li>Vitamina D3 (colecalciferol) …………. 15.000 UI</li>
	<li>Vitamina K2 MK-7 ……………………….. 120 mcg</li>
</ul>

<p>Posologia: Tomar 1 cápsula ao dia após almoço ou jantar.</p>
<br />
&nbsp;', 'Evellyn Lorrany Farias Dos Santos', '2026-06-23 14:53:15'),
  ('00786230142', 'prescricao', 'Uso oral<br />
<br />
1- Enzimas digestivas.<br />
<br />
Protease de Aspergillus 150mg<br />
Lipase 50mg<br />
Amilase 100mg<br />
Berberina 200mg<br />
pepsina 50mg<br />
<br />
Tomar 1 caps. antes do almoço e jantar Por 30 dias.<br />
<br />
2-<br />
Coenzima Q10 100mg<br />
vitamina C 500mg<br />
Resveratrol 100mg<br />
Curcumina fitoossomada 250mg<br />
Ginkgo biloba 80mg<br />
castanha da índia 150mg<br />
<br />
1 caps. após o almoço e 1 caps após o jantar. por 30 dias.&nbsp;<br />
<br />
3-<br />
Caprílico 250mg<br />
Óleo de oregano seco 100mg<br />
alho seco 100mg<br />
pau d´arco 150mg<br />
zinco quelado 15mg<br />
selenio 100mcg<br />
<br />
1 caps. após o almoço e jantar. Por 30 dias.&nbsp;<br />
<br />
4-<br />
Triphala extrato seco 500mg<br />
Magnésio citrato 200mg<br />
Aloe vera extrato seco 100mg<br />
Gengibre extrato seco 50mg<br />
<br />
mande 45 doses.<br />
tomar1&nbsp; caps. a noite, se necessário tomar 2 caps. por 30 dias<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-24 09:48:37'),
  ('49800116915', 'prescricao', '<p><strong>PEDIDO MÉDICO – POLISSONOGRAFIA BASAL NOTURNA</strong></p>

<p><strong>Paciente:</strong> Maristela Zorzo<br />
<strong>Idade:</strong> 63 anos</p>

<p><strong>Solicito a realização de:</strong></p>

<p><strong>Polissonografia Basal Noturna Completa</strong>, com monitorização cardiorrespiratória e neurofisiológica, incluindo avaliação de:</p>

<ul>
	<li>
	<p>Arquitetura do sono;</p>
	</li>
	<li>
	<p>Índice de apneia e hipopneia (IAH);</p>
	</li>
	<li>
	<p>Dessaturação de oxigênio;</p>
	</li>
	<li>
	<p>Microdespertares;</p>
	</li>
	<li>
	<p>Ronco;</p>
	</li>
	<li>
	<p>Movimentos periódicos dos membros;</p>
	</li>
	<li>
	<p>Eletrocardiograma contínuo;</p>
	</li>
	<li>
	<p>Estadiamento completo do sono.</p>
	</li>
</ul>

<p><strong>Indicação clínica:</strong></p>

<p>Paciente em acompanhamento clínico devido a fatores de risco cardiovascular, apresentando aterosclerose subclínica documentada (placa ateromatosa em carótida), cefaleia esporádica, fadiga prévia e necessidade de investigação de possíveis distúrbios respiratórios do sono como fator contribuinte para risco cardiometabólico e neurovascular.</p>

<p>A polissonografia é indicada para excluir ou confirmar síndrome da apneia obstrutiva do sono e outros distúrbios do sono que possam impactar a saúde cardiovascular, metabólica e cognitiva.</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>
	<p>G47.3 – Síndrome da apneia do sono.</p>
	</li>
	<li>
	<p>G47.8 – Outros distúrbios do sono.</p>
	</li>
	<li>
	<p>I70.8 – Aterosclerose de outras artérias.</p>
	</li>
	<li>
	<p>R51 – Cefaleia.</p>
	</li>
</ul>

<p><strong>Justificativa para o convênio:</strong></p>

<p>Paciente com doença aterosclerótica subclínica documentada em Doppler de carótidas, dislipidemia, lipoproteína(a) elevada e cefaleia recorrente. A investigação de distúrbios respiratórios do sono é clinicamente indicada, uma vez que a apneia obstrutiva do sono constitui fator independente para progressão da aterosclerose, hipertensão arterial, acidente vascular cerebral, doença coronariana e alterações metabólicas. O resultado do exame poderá modificar a conduta terapêutica e reduzir o risco cardiovascular futuro.</p>

<hr />
<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677 • RQE 13830<br />
<strong>Candia Saúde &amp; Bem-Estar</strong></p>
', 'Danielle Candia Barra', '2026-06-29 09:30:34'),
  ('49800116915', 'prescricao', '<h1>Fórmula 1 – Suporte Tireoidiano e Metabólico (manhã)</h1>

<p><strong>120 cápsulas gastro-resistentes</strong></p>

<ul>
	<li>Myo-inositol ........................................ 600 mg</li>
	<li>L-Tirosina ............................................ 300 mg</li>
	<li>Selênio (L-selenometionina) ............. 150 mcg</li>
	<li>Zinco bisglicinato ............................... 25 mg</li>
	<li>Magnésio bisglicinato ......................... 100 mg</li>
	<li>Vitamina A ........................................... 1.500 UI</li>
</ul>

<p><strong>Posologia</strong></p>

<p>Tomar <strong>1 cápsula pela manhã</strong>, em jejum.</p>

<h3>&nbsp;</h3>

<hr />
<h1>Fórmula 2 – Proteção Cardiovascular (almoço)</h1>

<p><strong>120 cápsulas gastro-resistentes</strong></p>

<ul>
	<li>Citrus bergamia (Bergavit®) ............. 500 mg</li>
	<li>Berberina HCl .................................... 500 mg</li>
	<li>Coenzima Q10 ................................... 100 mg</li>
	<li>PQQ ..................................................... 10 mg</li>
</ul>

<p><strong>Posologia</strong></p>

<p>1 cápsula após almoço.</p>

<h3>&nbsp;</h3>

<hr />
<h1>Fórmula 3 – Antioxidante / Anti-inflamatória (noite)</h1>

<p><strong>120 cápsulas gastro-resistentes</strong></p>

<ul>
	<li>NAC ...................................................... 300 mg</li>
	<li>Boswellia (20% AKBA) ...................... 100 mg</li>
	<li>Quercetina .......................................... 300 mg</li>
	<li>Vitamina C .......................................... 250 mg</li>
	<li>Tocotrienóis (Tocotrimax®) .............. 100 mg</li>
</ul>

<p><strong>Posologia</strong></p>

<p>1 cápsula após jantar.</p>

<hr />
<h1>Fórmula 4 – Complexo B de manutenção</h1>

<p>&nbsp;</p>

<p><strong>120 cápsulas</strong></p>

<ul>
	<li>Benfotiamina 25 mg</li>
	<li>Riboflavina 10 mg</li>
	<li>Niacinamida 50 mg</li>
	<li>Pantotenato 50 mg</li>
	<li>Piridoxal-5-fosfato 10 mg</li>
	<li>Metilfolato 400 mcg</li>
	<li>Metilcobalamina <strong>250 mcg</strong></li>
	<li>Biotina 2,5 mg</li>
</ul>

<p>Tomar <strong>1 cápsula pela manhã</strong>.</p>

<p>&nbsp;</p>

<hr />
<h1>Vitamina D</h1>

<ul>
	<li>Vitamina D3 5.000 UI + K2 MK7 100 mcg</li>
	<li>Tomar 01 1 cápsula/dia no almoço.&nbsp;</li>
</ul>
&nbsp;

<p><strong>Hidrocortisona (idêntica ao cortisol humano)</strong></p>

<p>Comprimidos de <strong>5 mg</strong></p>

<p>Posologia:</p>

<ul>
	<li>
	<p>Tomar <strong>2 comprimidos (10 mg)</strong> ao acordar, preferencialmente entre 6h e 8h.</p>
	</li>
	<li>
	<p>Tomar <strong>1 comprimido (5 mg)</strong> às 14 horas.</p>
	</li>
</ul>

<p>Total diário: <strong>15 mg/dia</strong>.</p>

<p>Duração: 120 dias.</p>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-06-29 09:37:53'),
  ('49800116915', 'prescricao', '<p><br />
<br />
<br />
<strong>Tratamento para 90 dias&nbsp;<br />
<br />
<br />
RECEITA MÉDICA</strong></p>

<p><strong>1. Estradiol transdérmico (gel)</strong></p>

<p>Estradiol bioidêntico gel <strong>0,20&nbsp;mg por pump</strong></p>

<p>Posologia:</p>

<p>Aplicar <strong>1 pump diariamente</strong>, pela manhã, na face interna das coxas, alternando os lados.</p>

<p>Quantidade: 90 doses.</p>

<hr />
<p><strong>2. Progesterona micronizada</strong></p>

<p>Progesterona micronizada 100 mg</p>

<p>Posologia:</p>

<p>Tomar <strong>1 cápsula ao deitar.&nbsp;</strong></p>

<p>Todos os dias</p>

<hr />
<p><strong>3. Testosterona transdérmica</strong></p>

<p>Testosterona bioidêntica gel <strong>0,5%</strong></p>

<p>Aplicar <strong>0,5 mL diariamente</strong>, pela manhã, na face interna da coxa.</p>

<p>Quantidade: 30 g.</p>

<hr />
<p><strong>4. Estriol vaginal</strong></p>

<p>Estriol 0,5 mg/g</p>

<p>Creme vaginal.</p>

<p>Posologia:</p>

<p>Aplicar <strong>1 g à noite durante 14 dias</strong> e, posteriormente, <strong>2 vezes por semana</strong> como manutenção.</p>

<p>Quantidade: 30 g.</p>

<hr />
<p><strong>Retorno em 8 a 12 semanas</strong> para reavaliação clínica e laboratorial.</p>
', 'Danielle Candia Barra', '2026-06-29 09:41:57'),
  ('49800116915', 'prescricao', '<p><strong>PEDIDO DE EXAMES HORMONAIS</strong></p>

<p><strong>Paciente:</strong> Maristela Zorzo<br />
<strong>Data:</strong> <strong><strong>/</strong></strong>/2026</p>

<p>Solicito a realização dos seguintes exames hormonais para acompanhamento de terapia de reposição hormonal bioidêntica, avaliação do climatério e monitorização da resposta terapêutica.</p>

<h3>Eixo Gonadal Feminino</h3>

<ul>
	<li>
	<p>Estradiol (E2)</p>
	</li>
	<li>
	<p>Progesterona</p>
	</li>
	<li>
	<p>LH</p>
	</li>
	<li>
	<p>FSH</p>
	</li>
	<li>
	<p>Testosterona Total</p>
	</li>
	<li>
	<p>Testosterona Livre (ou cálculo pela albumina e SHBG)</p>
	</li>
	<li>
	<p>SHBG</p>
	</li>
	<li>
	<p>DHEA-S</p>
	</li>
	<li>
	<p>Androstenediona</p>
	</li>
</ul>

<h3>Eixo Adrenal</h3>

<ul>
	<li>
	<p>Cortisol sérico (08:00 horas)</p>
	</li>
	<li>
	<p>ACTH</p>
	</li>
	<li>
	<p>Sulfato de DHEA (DHEA-S)</p>
	</li>
</ul>

<h3>Eixo Tireoidiano</h3>

<ul>
	<li>
	<p>TSH</p>
	</li>
	<li>
	<p>T4 Livre</p>
	</li>
	<li>
	<p>T3 Livre</p>
	</li>
	<li>
	<p>Anti-TPO</p>
	</li>
	<li>
	<p>Anti-Tireoglobulina</p>
	</li>
</ul>

<h3>Eixo Somatotrófico</h3>

<ul>
	<li>
	<p>IGF-1 (Somatomedina C)</p>
	</li>
</ul>

<h3>Outros Hormônios</h3>

<ul>
	<li>
	<p>Prolactina</p>
	</li>
</ul>

<h3>Observações</h3>

<p>Exames destinados ao acompanhamento da terapia hormonal, avaliação da resposta clínica e laboratorial, monitorização da função adrenal, tireoidiana e androgênica, permitindo ajustes individualizados da reposição hormonal.</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>
	<p>N95.1 – Estado da menopausa e climatério feminino.</p>
	</li>
	<li>
	<p>E28.3 – Insuficiência ovariana.</p>
	</li>
	<li>
	<p>E06.3 – Tireoidite autoimune.</p>
	</li>
	<li>
	<p>R53 – Mal-estar e fadiga.</p>
	</li>
	<li>
	<p>Z79.8 – Uso prolongado de outras medicações.</p>
	</li>
</ul>

<hr />
<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677 • RQE 13830<br />
Candia Saúde &amp; Bem-Estar</p>
', 'Danielle Candia Barra', '2026-06-29 09:43:10'),
  ('40063976153', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Coenzima Q10 ( ubiquinol)............................33 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tarde.</span><br />
<br />
2-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Coenzima Q10..................................................... 50 mg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina.................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde</span><br />
<br />
3-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Magnésio treonato......................................600mg<br />
melatonina time release................................ 0,5mg<br />
L-teanina..............................................200mg<br />
GABA...................................................250mg<br />
Tomar uma dose, antes de dormir por 60 dias.&nbsp;<br />
<br />
4-<br />
Vitamina D3 .......................................4.000 ui&nbsp;<br />
vitamina k2 mk7................................... 150mg<br />
Tomar 1 dose 1 x ao dia após o almoço.&nbsp;</span><br />
<br />
5-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ômega 3 -&nbsp; mega DHA ( vita for )<br />
Tomar 1 dose, 3 x ao dia no café da manhã, almoço e jantar</span><br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-30 11:56:15'),
  ('8213109686', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Berberina............................................ 250 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina....................................25mg<br />
NADH.....................................................5mg<br />
Ácido alfa lipóico.....................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã e lanche da tarde.<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio...............................................................&nbsp;100 mcg<br />
Coenzima Q10........................................................... 50 mg<br />
Boro quelato........................................................... 1 mg<br />
Magnésio quelato......................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina....................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde, por 60 dias.&nbsp;<br />
<br />
3-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Crocus sativus extrato seco padronizado em 0,3 % de safranal.. 30mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Bacopa monnieri extrato padronizado 20% bacosídeos.....300mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ginkgo biloba extrato padronizado 24% flavonoides / 6% terpenoides120mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina B1 (benfotiamina)............................150 mg</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 x ao dia, no café da manhã por 60 dias.<br />
<br />
4-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Magnésio treonato......................................600mg<br />
L-teanina..............................................200mg<br />
GABA...................................................250mg<br />
Coenzima Q10 (ubiquinol)...............................100mg<br />
<br />
Tomar uma dose, antes de dormir por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-07-01 15:18:06'),
  ('04937069179', 'prescricao', '1-<br />
Coriandrum sativum - extrato seco ou pó de coentro - 150mg<br />
<br />
Tomar 2 x ao dia de manhã e a tarde . Por 60 dias<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-07-02 11:50:53'),
  ('05176470101', 'prescricao', '<h3><strong>Perfil Alérgico – IgE Específica (RAST)</strong></h3>

<p><strong>IgE Total</strong></p>

<h4>Aeroalérgenos</h4>

<ul>
	<li>D1 – <em>Dermatophagoides pteronyssinus</em></li>
	<li>D2 – <em>Dermatophagoides farinae</em></li>
	<li>D201 – <em>Blomia tropicalis</em></li>
	<li>D70 – <em>Acarus siro</em></li>
	<li>D3 – <em>Dermatophagoides microceras</em></li>
	<li>HX2 – Mix poeira domiciliar</li>
	<li>MX1 – Mix fungos ambientais</li>
	<li>GX2 – Mix pólens de gramíneas</li>
	<li>EX1 – Mix epitélios de animais</li>
	<li>E1 – Epitélio de gato</li>
	<li>E5 – Epitélio de cão</li>
	<li>I6 – Barata doméstica</li>
</ul>

<h4>Insetos (painel expandido)</h4>

<ul>
	<li>Abelha</li>
	<li>Vespa</li>
	<li>Marimbondo</li>
	<li>Formiga</li>
	<li>Mosquito/Pernilongo</li>
</ul>

<h4>Alérgenos Alimentares</h4>

<ul>
	<li>FX5 – Mix alimentos</li>
	<li>FX2 – Mix peixes e frutos do mar</li>
	<li>FX3 – Mix cereais</li>
	<li>FX1 – Mix sementes oleaginosas</li>
	<li>F2 – Leite de vaca</li>
	<li>F245 – Ovo de galinha (clara e gema)</li>
</ul>
', 'Danielle Candia Barra', '2026-07-06 11:39:42'),
  ('05176470101', 'prescricao', '<p><strong>Teste de Tolerância à Lactose (Teste Oral de Sobrecarga de Lactose)</strong></p>

<p><strong>Solicito:</strong></p>

<ul>
	<li>Teste Oral de Tolerância à Lactose (50 g de lactose)</li>
	<li>Dosagem de glicemia nos tempos:
	<ul>
		<li>Jejum (0 minutos)</li>
		<li>30 minutos</li>
		<li>60 minutos</li>
		<li>90 minutos</li>
		<li>120 minutos</li>
	</ul>
	</li>
</ul>

<p><strong>Indicação clínica:</strong><br />
Investigação de intolerância à lactose em paciente com sintomas gastrointestinais compatíveis (distensão abdominal, flatulência, dor abdominal e/ou diarreia após ingestão de leite e derivados).</p>

<p><strong>Observação:</strong><br />
Caso disponível no laboratório, pode ser realizado <strong>Teste Respiratório do Hidrogênio Expirado (H? Breath Test com lactose)</strong>, por apresentar maior sensibilidade e especificidade para o diagnóstico de má absorção de lactose e por não depender da resposta glicêmica do paciente. É o método preferencial quando disponível.</p>
', 'Danielle Candia Barra', '2026-07-06 11:44:03'),
  ('05176470101', 'prescricao', '<h3>Sorologia</h3>

<ul>
	<li>Anti-transglutaminase tecidual IgA (tTG-IgA)</li>
	<li>Anti-transglutaminase tecidual IgG (tTG-IgG) <em>(se deficiência de IgA)</em></li>
	<li>Anti-endomísio IgA (EMA-IgA)</li>
	<li>Anticorpo antipeptídeo de gliadina deamidada (DGP) IgA</li>
	<li>Anticorpo antipeptídeo de gliadina deamidada (DGP) IgG</li>
	<li>IgA sérica total <em>(obrigatório para interpretar os testes em IgA)</em></li>
</ul>
', 'Danielle Candia Barra', '2026-07-06 11:45:32'),
  ('05176470101', 'prescricao', '<p><strong>Manipular – 90 cápsulas gastro-resistentes</strong></p>

<p><strong>Posologia:</strong> Tomar <strong>1 cápsula pela manhã</strong>, após o café da manhã.</p>

<p><strong>Composição:</strong></p>

<ul>
	<li>Magnésio bisglicinato – 150 mg</li>
	<li>Zinco quelato – 15 mg</li>
	<li>Selênio quelato – 100 mcg</li>
	<li>Vitamina B1 (Benfotiamina) – 25 mg</li>
	<li>Vitamina B2 – 20 mg</li>
	<li>Vitamina B3 (Niacinamida) – 50 mg</li>
	<li>Vitamina B5 – 50 mg</li>
	<li>Vitamina B6 (P5P) – 25 mg</li>
	<li>Metilfolato – 400 mcg</li>
	<li>Metilcobalamina – 500 mcg</li>
	<li>Inositol – 500 mg</li>
	<li>Colina – 100 mg</li>
	<li>Vitamina C – 250 mg</li>
	<li>Vitamina E – 100 UI</li>
</ul>

<hr />
<h3><strong>2. SUPORTE CAPILAR + ANTI-INFLAMATÓRIO</strong></h3>

<p><strong>Manipular – 90 cápsulas gastro-resistentes</strong></p>

<p><strong>Posologia:</strong> Tomar <strong>1 cápsula no jantar</strong>.</p>

<p><strong>Composição:</strong></p>

<ul>
	<li>Silício orgânico – 100 mg</li>
	<li>Biotina – 5 mg</li>
	<li>L-cisteína – 100 mg</li>
	<li>L-metionina – 100 mg</li>
	<li>N-acetilcisteína (NAC) – 150 mg</li>
</ul>

<hr />
<h3><strong>3. VITAMINA D3 + K2</strong></h3>

<p><strong>Manipular – 90 cápsulas oleosas</strong></p>

<p><strong>Posologia:</strong> Tomar <strong>1 cápsula ao dia</strong>, em qualquer horário.</p>

<p><strong>Composição:</strong></p>

<ul>
	<li>Vitamina D3 – 4.000 UI</li>
	<li>Vitamina K2 MK-7 – 100 mcg</li>
</ul>

<hr />
<h3><strong>4. ÔMEGA-3</strong></h3>

<p><strong>Sugestão de marca:</strong> <strong>Vitafor</strong> ou <strong>Essentia Pharma</strong></p>

<p><strong>Posologia:</strong> Tomar <strong>1 dose ao dia</strong>, em qualquer horário, preferencialmente junto a uma refeição.</p>

<p><strong>Composição sugerida:</strong></p>

<ul>
	<li>EPA + DHA total ? <strong>1.500 mg/dia</strong>.</li>
</ul>

<p><strong>Observação:</strong> Conforme solicitado, o <strong>Extrato de Bambu foi retirado da fórmula capilar</strong>.</p>
', 'Danielle Candia Barra', '2026-07-06 11:48:13'),
  ('69982490125', 'prescricao', '<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1- para manipular<br />
<br />
HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
2- Para comprar na internet<br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias.&nbsp;<br />
<br />
&nbsp;</span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-07-06 11:55:43'),
  ('69982490125', 'prescricao', '<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1- para manipular<br />
<br />
HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água. em dias que não treina, tomar no lanche da tarde.&nbsp;<br />
<br />
2- Para comprar na internet<br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias. no lanche da manhã.<br />
<br />
&nbsp;</span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-07-06 11:58:11'),
  ('02344108173', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral<br />
<br />
1-</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>HMB 1 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.</span><br />
<br />
2-<br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250mg<br />
Vitamina E............................................................. 100mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100mcg<br />
Coenzima Q10........................................................... 50 mg<br />
Boro quelato............................................................ 1mg<br />
Magnésio quelato......................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina........................................................ 1 mg<br />
Vitamina B5........................................................... 20mg<br />
vitamina B6 ( piridoxal 5 fosfato) .................................... 50mg&nbsp;<br />
Biotina............................................................... 2,5mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde</span><br />
<br />
3-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula.</span>', 'Ana Carolina Candia Barra', '2026-07-07 11:31:16'),
  ('02344108173', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral<br />
<br />
1-</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>HMB 1 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água. Pós 60 dias.&nbsp;</span><br />
<br />
2-<br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250mg<br />
Vitamina E............................................................. 100mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100mcg<br />
Coenzima Q10........................................................... 50 mg<br />
Boro quelato............................................................ 1mg<br />
Magnésio quelato......................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina........................................................ 1 mg<br />
Vitamina B5........................................................... 20mg<br />
vitamina B6 ( piridoxal 5 fosfato) .................................... 50mg&nbsp;<br />
Biotina............................................................... 2,5mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde. Por 60 dias</span><br />
<br />
3-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Gaba...................................................300mg<br />
Passiflora.............................................150mg<br />
L theanina..............................................50mg<br />
5htp...................................................100mg<br />
<br />
Tomar 1 caps. 30 min, antes de dormir. Evitar ficar no celular ou com muitas luzes acesas após tomar a fórmula. Por 60 dias<br />
<br />
4-<br />
Vitamina D3............................... 4.000 ui&nbsp;<br />
Vitamnina K2 MK7.......................... 100mg<br />
<br />
tomar 1 dose após o almoço. por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-07-07 11:34:35'),
  ('04945317542', 'prescricao', NULL, 'Ana Carolina Candia Barra', '2026-07-09 16:13:25'),
  ('00158099192', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-<br />
ômega 3 - 990 EPA e 660 de DHA&nbsp; - ( marca Vitafor - PLUS) - compra pela internet&nbsp;</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - &nbsp;almoço e jantar. Por 90 dias</span></span><br />
<br />
2- manipulação<br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água, ou no lanche da tarde.<br />
<br />
3- manipulação</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
picnogenol..............................................30mg<br />
Berberina.............................................. 500mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 90 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-07-09 17:25:51'),
  ('83395296768', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p>3- para manipular<br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Coenzima Q10..................................................... 50 mg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Mnaipular formato sachê, Tomar uma dose duas vezes ao dia. manhã e tarde.Por 60 dias<br />
Sabor a escolha da&nbsp;paciente</span></p>
', 'Ana Carolina Candia Barra', '2026-07-10 10:52:58'),
  ('07943713109', 'prescricao', '1– Modulador inflamatório e anti-histamínico<br />
<br />
Quercetina — 500 mg<br />
Vitamina C — 500 mg<br />
Bromelina — 200 mg<br />
Curcumina fitossomada — 250 mg<br />
<br />
Modo de usar:<br />
1 cápsula 2x ao dia após refeições.<br />
<br />
2- Regulação metabólica e compulsão por doce<br />
Fórmula 3 – Estabilização metabólica<br />
<br />
Magnésio bisglicinato — 200 mg<br />
Taurina — 250 mg<br />
Inositol — 500 mg<br />
Cromo picolinato — 100 mcg<br />
<br />
Modo de usar:<br />
2 cápsulas à noite.<br />
<br />
3- Modulação intestinal leve (terreno fermentativo)<br />
Fórmula 4 – Modulador intestinal<br />
<br />
Berberina — 300 mg<br />
Extrato de própolis verde — 150 mg<br />
Óleo essencial de orégano microencapsulado — 50 mg<br />
<br />
Modo de usar:<br />
1 cápsula 2x ao dia antes das refeições por 30 dias.<br />
<br />
4- Modulação do cortisol
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Coenzima Q10..................................................... 50 mg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina.................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde<br />
<br />
5-&nbsp;<br />
Vitamina D3.......................4.000 ui<br />
Vitamina K2mk7.................... 75mg<br />
<br />
Tomar 1 dose 1 x ao dia após o almoço Por 60 dias.<br />
<br />
reavaliar os exames após essa suplementação.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-07-10 13:11:28'),
  ('40012530115', 'prescricao', '<h1>EDIDO DE EXAMES – ULTRASSONOGRAFIAS</h1>

<p><strong>Paciente:</strong> Rosana Maria Vasconcelos Teixeira</p>

<p><strong>Data:</strong> 13/07/2026</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>E66.3 – Sobrepeso</li>
	<li>I89.0 – Lipedema</li>
	<li>I83.9 – Insuficiência venosa/varizes dos membros inferiores</li>
	<li>N95.1 – Menopausa e climatério</li>
	<li>D24 / N60.9 – História de hiperplasia ductal atípica e doença mamária benigna</li>
	<li>E04.2 – Bócio multinodular atóxico</li>
	<li>D25.9 – Leiomioma uterino</li>
</ul>

<hr />
<h2>Solicito:</h2>

<h3>1. Ultrassonografia da Tireoide com Doppler</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>História de bócio multinodular.</li>
	<li>Nódulos tireoidianos calcificados previamente classificados como TI-RADS 4 e 5.</li>
	<li>Acompanhamento evolutivo dos nódulos.</li>
	<li>Avaliação da vascularização tireoidiana e dos nódulos.</li>
	<li>Rastreamento de linfonodos cervicais.</li>
</ul>

<hr />
<h3>2. Ultrassonografia Mamária Bilateral</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>História de BI-RADS 4 em 2021.</li>
	<li>História de hiperplasia ductal atípica (ADH).</li>
	<li>Status pós-mamotomia e quadrantectomia da mama direita.</li>
	<li>Seguimento de paciente de maior risco para neoplasia mamária.</li>
	<li>Avaliação de cicatriz cirúrgica, linfonodos e eventuais novas lesões.</li>
</ul>

<hr />
<h3>3. Ultrassonografia de Abdome Total</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>Avaliação metabólica.</li>
	<li>Obesidade.</li>
	<li>Lipedema.</li>
	<li>Dislipidemia.</li>
	<li>Monitorização durante tratamento para emagrecimento.</li>
	<li>Avaliação hepática, pancreática, renal, biliar e esplênica.</li>
</ul>

<hr />
<h3>4. Ultrassonografia Pélvica Transvaginal</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>Menopausa recente.</li>
	<li>Terapia de reposição hormonal.</li>
	<li>Episódios prévios de sangramento uterino durante uso de progesterona.</li>
	<li>História de leiomiomas uterinos.</li>
	<li>Avaliação do endométrio.</li>
	<li>Avaliação ovariana.</li>
	<li>Seguimento ginecológico.</li>
</ul>

<hr />
<p><strong>Observação clínica:</strong></p>

<p>Paciente em terapia hormonal para menopausa, com história de hiperplasia ductal atípica mamária tratada cirurgicamente, lipedema estágio III, doença nodular tireoidiana e miomatose uterina, necessitando acompanhamento ultrassonográfico periódico para monitorização evolutiva.</p>
', 'Danielle Candia Barra', '2026-07-13 10:06:45'),
  ('40012530115', 'prescricao', '<h1>PEDIDO DE EXAME</h1>

<p><strong>Paciente:</strong> Rosana Maria Vasconcelos Teixeira</p>

<p><strong>Data:</strong> 13/07/2026</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>Z12.3 – Rastreamento para neoplasia maligna da mama</li>
	<li>N60.9 – Doença benigna da mama</li>
	<li>N60.8 – Hiperplasia ductal atípica da mama (história prévia)</li>
	<li>Z98.89 – Estado pós procedimento cirúrgico da mama</li>
</ul>

<hr />
<h2>Solicito:</h2>

<h3>Mamografia Digital Bilateral com Tomossíntese (3D)</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>Rastreamento anual para câncer de mama.</li>
	<li>História de BI-RADS® 4 em 2021.</li>
	<li>História de hiperplasia ductal atípica (ADH) confirmada em mamotomia, submetida posteriormente à quadrantectomia, sem evidências de malignidade no anatomopatológico definitivo.</li>
	<li>Seguimento pós-quadrantectomia da mama direita.</li>
	<li>Mamas heterogeneamente densas.</li>
	<li>Paciente em terapia de reposição hormonal para menopausa.</li>
	<li>Avaliação evolutiva de cicatriz cirúrgica e exclusão de novas microcalcificações ou lesões suspeitas.</li>
</ul>

<p><strong>Observação:</strong></p>

<p>Solicita-se realização do exame preferencialmente com <strong>tomossíntese mamária (mamografia 3D)</strong>, considerando o antecedente de hiperplasia ductal atípica, cirurgia mamária prévia e maior sensibilidade diagnóstica em mamas densas.</p>
', 'Danielle Candia Barra', '2026-07-13 10:07:57'),
  ('40012530115', 'prescricao', '<h1>1. SUPORTE METABÓLICO + MITOCONDRIAL + METILAÇÃO</h1>

<p><strong>Manipular – cápsulas gastro-resistentes</strong></p>

<p><strong>90 doses</strong></p>

<p>Tomar <strong>1 cápsula após o café da manhã.</strong></p>

<h3>Fórmula</h3>

<ul>
	<li>Magnésio bisglicinato ............... 150 mg</li>
	<li>Zinco quelato ............................. 15 mg</li>
	<li>Selênio quelato ......................... 100 mcg</li>
	<li>Benfotiamina (B1) .................... 25 mg</li>
	<li>Vitamina B2 ............................... 20 mg</li>
	<li>Niacinamida (B3) ...................... 50 mg</li>
	<li>Pantotenato de cálcio (B5) ...... 50 mg</li>
	<li>Piridoxal-5-fosfato (B6) ........... 25 mg</li>
	<li><strong>Metilfolato</strong> ............................ 400 mcg</li>
	<li>Inositol ...................................... 500 mg</li>
	<li>Colina (bitartrato) .................... 150 mg</li>
	<li>Vitamina C ................................. 250 mg</li>
</ul>

<p><strong>Não incluir vitamina B12</strong>, pois a paciente já faz suplementação isolada.</p>

<hr />
<h1>2. LIPOEDEMA + MICROCIRCULAÇÃO</h1>

<p><strong>Manipular</strong></p>

<p><strong>90 doses</strong></p>

<p>Tomar <strong>1 cápsula após almoço e 1 após jantar.</strong></p>

<h3>Fórmula</h3>

<ul>
	<li>Diosmina .................................. 450 mg</li>
	<li>Hesperidina .............................. 50 mg</li>
	<li>Castanha-da-Índia (20% escina) ...150 mg</li>
	<li>Centella asiatica ...................... 150 mg</li>
	<li>Quercetina ................................. 250 mg</li>
</ul>

<p>Objetivos:</p>

<ul>
	<li>melhora do edema;</li>
	<li>redução da fragilidade capilar;</li>
	<li>melhora da drenagem venosa e linfática;</li>
	<li>ação anti-inflamatória.</li>
</ul>

<hr />
<h1>3. MASSA MUSCULAR</h1>

<h3>Creatina monohidratada</h3>

<p><strong>3 g/dia</strong></p>

<p>Tomar diariamente.</p>

<h1>&nbsp;</h1>
', 'Danielle Candia Barra', '2026-07-13 10:16:23'),
  ('40012530115', 'prescricao', '<h1>Plano proposto</h1>

<h2>Fase 1 – Adaptação (30 dias)</h2>

<p><strong>Rybelsus® 7 mg</strong></p>

<ul>
	<li>Segunda-feira: 1 comprimido</li>
	<li>Quarta-feira: 1 comprimido</li>
	<li>Sexta-feira: 1 comprimido</li>
</ul>

<p><strong>Total: 3 comprimidos por semana.</strong></p>

<p>Objetivo:</p>

<ul>
	<li>readaptar o organismo;</li>
	<li>minimizar perda de massa magra;</li>
	<li>avaliar tolerância.</li>
</ul>

<hr />
<h2>Fase 2 – Consolidação (30 dias)</h2>

<p>Se não houver:</p>

<ul>
	<li>fraqueza importante;</li>
	<li>náuseas persistentes;</li>
	<li>perda muscular acelerada;</li>
</ul>

<p>passar para:</p>

<ul>
	<li>Segunda: 7 mg</li>
	<li>Quarta: 7 mg</li>
	<li>Sexta: 7 mg</li>
	<li>Domingo: 7 mg</li>
</ul>

<p><strong>Total: 4 comprimidos por semana.</strong></p>

<hr />
<h2>Fase 3 – Manutenção (30 dias)</h2>

<p>Manter a menor frequência que permita continuar emagrecendo sem efeitos adversos.</p>

<p>Na maioria das pacientes com perfil semelhante, eu manteria:</p>

<ul>
	<li>4 comprimidos por semana (segunda, quarta, sexta e domingo).</li>
</ul>

<p>&nbsp;</p>

<hr />
<h1>Recomendações nutricionais</h1>

<p>Durante todo o tratamento:</p>

<ul>
	<li>Proteína: <strong>1,5–1,6 g/kg/dia</strong> (aproximadamente 95–105 g/dia).</li>
	<li>Creatina: <strong>3 g/dia</strong>.</li>
	<li>Treinamento resistido: 3–4 vezes por semana.</li>
	<li>Hidratação: 2,2–2,5 litros/dia.</li>
	<li>Evitar jejum prolongado, principalmente nos dias de uso do medicamento.</li>
</ul>
', 'Danielle Candia Barra', '2026-07-13 10:18:46'),
  ('40012530115', 'prescricao', '<h3><strong>RECEITA MÉDICA</strong></h3>

<p><strong>Paciente:</strong> Rosana Maria Vasconcelos Teixeira</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>N95.1 – Menopausa</li>
	<li>E66.3 – Sobrepeso</li>
	<li>I89.0 – Lipedema</li>
	<li>Z79.8 – Uso prolongado de terapia hormonal</li>
</ul>

<hr />
<h2>1. Coenzima Q10</h2>

<p><strong>Coenzima Q10 (Ubiquinol® ou Ubiquinona de alta pureza) – 100 mg</strong></p>

<p><strong>Posologia:</strong><br />
Tomar <strong>1 cápsula ao dia</strong>, após o café da manhã ou almoço, junto a refeição contendo gordura.</p>

<p><strong>Quantidade:</strong> 90 cápsulas.</p>

<hr />
<h2>2. Vitamina D3 + Vitamina K2</h2>

<p><strong>Vitamina D3 (Colecalciferol) – 4.000 UI</strong></p>

<p><strong>Vitamina K2 MK-7 – 120 mcg</strong></p>

<p><strong>Posologia:</strong><br />
Tomar <strong>1 cápsula ao dia</strong>, junto à principal refeição.</p>

<p><strong>Quantidade:</strong> 90 cápsulas.</p>
', 'Danielle Candia Barra', '2026-07-13 10:19:45'),
  ('40012530115', 'prescricao', '<h1>PEDIDO DE EXAMES – ULTRASSONOGRAFIAS</h1>

<p><strong>Paciente:</strong> Rosana Maria Vasconcelos Teixeira</p>

<p><strong>Data:</strong> 13/07/2026</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>E66.3 – Sobrepeso</li>
	<li>I89.0 – Lipedema</li>
	<li>I83.9 – Insuficiência venosa/varizes dos membros inferiores</li>
	<li>N95.1 – Menopausa e climatério</li>
	<li>D24 / N60.9 – História de hiperplasia ductal atípica e doença mamária benigna</li>
	<li>E04.2 – Bócio multinodular atóxico</li>
	<li>D25.9 – Leiomioma uterino</li>
</ul>

<hr />
<h2>Solicito:</h2>

<h3>1. Ultrassonografia da Tireoide com Doppler</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>História de bócio multinodular.</li>
	<li>Nódulos tireoidianos calcificados previamente classificados como TI-RADS 4 e 5.</li>
	<li>Acompanhamento evolutivo dos nódulos.</li>
	<li>Avaliação da vascularização tireoidiana e dos nódulos.</li>
	<li>Rastreamento de linfonodos cervicais.</li>
</ul>

<hr />
<h3>2. Ultrassonografia Mamária Bilateral</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>História de BI-RADS 4 em 2021.</li>
	<li>História de hiperplasia ductal atípica (ADH).</li>
	<li>Status pós-mamotomia e quadrantectomia da mama direita.</li>
	<li>Seguimento de paciente de maior risco para neoplasia mamária.</li>
	<li>Avaliação de cicatriz cirúrgica, linfonodos e eventuais novas lesões.</li>
</ul>

<hr />
<h3>3. Ultrassonografia de Abdome Total</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>Avaliação metabólica.</li>
	<li>Obesidade.</li>
	<li>Lipedema.</li>
	<li>Dislipidemia.</li>
	<li>Monitorização durante tratamento para emagrecimento.</li>
	<li>Avaliação hepática, pancreática, renal, biliar e esplênica.</li>
</ul>

<hr />
<h3>4. Ultrassonografia Pélvica Transvaginal</h3>

<p><strong>Indicação clínica:</strong></p>

<ul>
	<li>Menopausa recente.</li>
	<li>Terapia de reposição hormonal.</li>
	<li>Episódios prévios de sangramento uterino durante uso de progesterona.</li>
	<li>História de leiomiomas uterinos.</li>
	<li>Avaliação do endométrio.</li>
	<li>Avaliação ovariana.</li>
	<li>Seguimento ginecológico.</li>
</ul>

<hr />
<p><strong>Observação clínica:</strong></p>

<p>Paciente em terapia hormonal para menopausa, com história de hiperplasia ductal atípica mamária tratada cirurgicamente, lipedema estágio III, doença nodular tireoidiana e miomatose uterina, necessitando acompanhamento ultrassonográfico periódico para monitorização evolutiva.</p>
', 'Danielle Candia Barra', '2026-07-13 10:25:43'),
  ('00813233100', 'prescricao', 'Uso oral<br />
<br />
1-<br />
<br />
Vitamina C ( ascorbato de sódio)........... 500mg<br />
Zinco bisglicinato.................................... 15mg<br />
Quercetina.............................................. 250mg<br />
Glutationa ..............................................250mg<br />
Oli-Ola ................................................... 50mg<br />
(extrato padronizado em hidroxitirosol )<br />
&nbsp;<br />
Tomar 2 x ao dia, pela manhã no lanche da manhã e a tarde no lanche da tarde.<br />
<br />
2-<br />
<br />
Di indol - 3 - carbinol .........................100mg<br />
Calcio D Glucarato............................ 500mg<br />
<br />
Tomar 1 dose 1 x ao dia no café da manhã ou no almoço. ( preferencialmente com uma refeição)<br />
<br />
3-<br />
<br />
Ômega 3 - 990 de EPA e 660 de DHA ( vita for Plus)<br />
<br />
Tomar 3 x ao dia , no café da manhã, no almoço e no jantar<br />
<br />
4-<br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.<br />
<br />
5-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3..........................................4.000 ui<br />
Vitamina K2 Mk7.........................................120mg<br />
Tomar 1 doses&nbsp; após o almoço, por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-07-13 18:35:48'),
  ('00813233100', 'prescricao', 'Uso oral<br />
<br />
1-<br />
<br />
Vitamina C ( ascorbato de sódio)........... 500mg<br />
Zinco bisglicinato.................................... 15mg<br />
Quercetina.............................................. 250mg<br />
Glutationa ..............................................250mg<br />
Oli-Ola ................................................... 50mg<br />
(extrato padronizado em hidroxitirosol )<br />
&nbsp;<br />
Tomar 2 x ao dia, pela manhã no lanche da manhã e a tarde no lanche da tarde.<br />
<br />
2-<br />
<br />
Di indol - 3 - carbinol .........................100mg<br />
Calcio D Glucarato............................ 500mg<br />
<br />
Tomar 1 dose 1 x ao dia no café da manhã ou no almoço. ( preferencialmente com uma refeição)<br />
<br />
3-<br />
<br />
Ômega 3 - 990 de EPA e 660 de DHA ( vita for Plus)<br />
<br />
Tomar 3 x ao dia , no café da manhã, no almoço e no jantar<br />
<br />
4-<br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.<br />
<br />
5-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3..........................................4.000 ui<br />
Vitamina K2 Mk7.........................................120mg<br />
Tomar 1 doses&nbsp; após o almoço, por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-07-13 18:35:48'),
  ('79453430153', 'prescricao', 'Uso oral<br />
<br />
1-&nbsp;<br />
berberina HCL.........................................500mg<br />
<br />
Tomar 1 caps após o almoço e 1 após o jantar. por 60 dias.<br />
<br />
2-<br />
Corebiome( tributirina).............................300mg<br />
<br />
tomar 1 caps. após o almoço e 1 caps. após o jnatar, por 30 dias.<br />
<br />
3-<br />
L- Glutamina&nbsp;<br />
5g por dose&nbsp;<br />
<br />
Diluir 5g em água ao acordar em jejum e 5 antes de dormir. por 30 dias<br />
<br />
4-<br />
Cálcio D glucarato ...................... 500mg<br />
<br />
Tomar 1 caps. após o almoço e 1 caps. após o jantar, por 60 dias.<br />
<br />
5-<br />
Bifidobacterium longum&nbsp;<br />
Bifidobacterium lactis<br />
Lactobacillus plantarum<br />
Total 20 bilhões UFC<br />
<br />
Tomar 1 dose ante sde dormir. por 30 dias.&nbsp;<br />
<br />
6-<br />
Vitamina D3 ( colecalciferol) 4.000 ui<br />
Vitamina K2 mk7 90 mcg<br />
Gotas ou solução liposulúvel qsp<br />
30 ml<br />
<br />
Tomar 1 dose ao dia, após o café da manhã.<br />
<br />
7-
<p><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>Vitamina C............................................................. 250 mg<br />
Vitamina E............................................................. 100 mg<br />
Zinco quelato......................................................... 20 mg<br />
Selênio................................................................. 100 mcg<br />
Boro quelato......................................................... 1 mg<br />
Magnésio quelato.................................................&nbsp;300 mg<br />
Vitamina A............................................................ 4.500 UI<br />
Metilcobalamina.................................................... 1 mg<br />
Vitamina B5........................................................... 20 mg<br />
<br />
Tomar uma dose duas vezes ao dia. manhã e tarde, por 60 dias</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-07-14 16:18:26'),
  ('01169196128', 'prescricao', '<h3>PEDIDO DE EXAMES DE IMAGEM</h3>

<p><strong>Paciente:</strong> Lorraine Ardila Geness de Freitas</p>

<p><strong>Data:</strong> 20/07/2026</p>

<p><strong>CID-10:</strong></p>
&nbsp;

<ul>
	<li>N96 – Abortamento habitual</li>
	<li>E22.1 – Hiperprolactinemia</li>
	<li>D35.2 – Adenoma benigno da hipófise</li>
	<li>E88.81 – Resistência à insulina</li>
</ul>

<hr />
<h3>Solicito:</h3>

<p><strong>1. Ultrassonografia Transvaginal com Doppler, contagem de folículos</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Avaliação uterina e ovariana.</li>
	<li>Pesquisa de miomas, pólipos, adenomiose e malformações uterinas.</li>
	<li>Avaliação da espessura e aspecto do endométrio.</li>
	<li>Pesquisa de endometriose (quando possível).</li>
	<li>Contagem de folículos antrais.</li>
	<li>Avaliação da vascularização uterina e ovariana.</li>
</ul>

<hr />
<p><strong>2. Ultrassonografia de Abdome Total</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Avaliação hepática (esteatose e outras alterações).</li>
	<li>Vesícula biliar e vias biliares.</li>
	<li>Pâncreas.</li>
	<li>Baço.</li>
	<li>Rins e vias urinárias.</li>
	<li>Aorta abdominal.</li>
	<li>Pesquisa de alterações metabólicas associadas à resistência insulínica e avaliação geral dos órgãos abdominais.</li>
</ul>

<hr />
<p><strong>3. Ultrassonografia da Tireoide com Doppler</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Avaliação morfológica da glândula.</li>
	<li>Pesquisa de nódulos.</li>
	<li>Avaliação da vascularização.</li>
	<li>Investigação de doença tireoidiana autoimune.</li>
</ul>

<hr />
<p><strong>4. Ultrassonografia das Mamas Bilateral</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Rastreamento mamário.</li>
	<li>Avaliação de nódulos, cistos e demais alterações estruturais.</li>
</ul>

<hr />
<p><strong>Justificativa clínica:</strong></p>

<p>Paciente de 40 anos com infertilidade secundária, dois abortamentos espontâneos, microadenoma hipofisário com hiperprolactinemia em tratamento, resistência à insulina, variante <strong>MTHFR C677T em homozigose</strong>, irregularidade menstrual e planejamento gestacional. Solicito avaliação ultrassonográfica para investigação de possíveis causas estruturais ginecológicas, tireoidianas e alterações metabólicas associadas, visando otimização do preparo pré-concepcional.</p>
', 'Danielle Candia Barra', '2026-07-20 10:25:30'),
  ('01169196128', 'prescricao', '<h2>Fórmula 1 – Fertilidade, metilação e qualidade ovocitária</h2>

<p><strong>Manipular 90 cápsulas gastro-resistentes</strong></p>

<p><strong>Composição:</strong></p>

<ul>
	<li>Metilfolato (5-MTHF) .................................. 1 mg</li>
	<li>Metilcobalamina ....................................... 1.000 mcg</li>
	<li>Piridoxal-5-fosfato (Vit. B6 ativa) ............. 25 mg</li>
	<li>Riboflavina-5-fosfato ................................. 20 mg</li>
	<li>Benfotiamina ............................................. 50 mg</li>
	<li>Zinco bisglicinato ..................................... 15 mg</li>
	<li>Selênio quelato ........................................ 100 mcg</li>
	<li>Coenzima Q10 (ubiquinol) ........................ 200 mg</li>
</ul>

<p><strong>Posologia:</strong><br />
Tomar 1 cápsula após o café da manhã.</p>

<hr />
<h2>Fórmula 2 – Resistência insulínica e fertilidade</h2>

<p><strong>Manipular 90 sachês</strong></p>

<p><strong>Composição:</strong></p>

<ul>
	<li>Mio-inositol ............................................. 2 g</li>
	<li>D-quiro-inositol ....................................... 50 mg</li>
	<li>N-acetilcisteína ..................................... 600 mg</li>
	<li>Magnésio bisglicinato .............................. 150 mg</li>
</ul>

<p><strong>Posologia:</strong></p>

<p>Diluir 1 sachê em 200 mL de água após o jantar.</p>

<hr />
<h2>Fórmula 3 – Ferro</h2>

<p>Como a ferritina encontra-se em <strong>21 ng/mL</strong>, sugiro utilizar ferro de elevada biodisponibilidade.</p>

<p><strong>Leipofer® (ferro lipossomal) 30 mg</strong></p>

<p>Tomar:</p>

<p><strong>1 cápsula ao dia</strong>, longe de café, leite e cálcio.</p>

<p>Associar vitamina C.</p>

<hr />
<h2>Fórmula 4 – Enzimas digestivas</h2>

<p><strong>Manipular 90 cápsulas gastro-resistentes</strong></p>

<p><strong>Composição</strong></p>

<p>Pancreatina ........................................... 250 mg</p>

<p>Bromelina .............................................. 150 mg</p>

<p>Papaína .................................................. 100 mg</p>

<p>Lipase ...................................................... 5.000 UI</p>

<p>Protease ................................................. 25.000 HUT</p>

<p>Amilase ................................................... 12.000 DU</p>

<p>Lactase ................................................... 4.500 FCC</p>

<p>Alfa-galactosidase .................................. 300 GalU</p>

<p><strong>Posologia</strong></p>

<p>Tomar <strong>1 cápsula imediatamente antes do almoço e do jantar</strong>.</p>

<hr />
<h2>Vitamina D</h2>

<p>Manter:</p>

<p>Vitamina D3 50.000 UI semanal</p>

<p>Associada à</p>

<p>Vitamina K2 MK-7 120 mcg.</p>

<p>Meta sérica:</p>

<p>40–60 ng/mL.</p>

<hr />
<h2>Ômega-3</h2>

<p>EPA + DHA</p>

<p><strong>2.000 mg/dia</strong></p>

<p>Após almoço.</p>

<h2>&nbsp;</h2>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-07-20 10:28:22'),
  ('01169196128', 'prescricao', '<h3>Tirzepatida (Mounjaro®) 2,5 mg/0,5 mL</h3>

<p><strong>Dispensar:</strong> 4 canetas preenchidas (ou quantidade suficiente para 4 aplicações).</p>

<p><strong>Posologia:</strong></p>

<p>Aplicar <strong>2,5 mg por via subcutânea, 1 vez por semana</strong>, sempre no mesmo dia da semana, por <strong>4 semanas</strong>.</p>

<p>Locais de aplicação:</p>

<ul>
	<li>Abdome</li>
	<li>Face anterior da coxa</li>
	<li>Face posterior do braço</li>
</ul>

<p>Realizar rodízio dos locais de aplicação.</p>

<hr />
<h3>Orientações</h3>

<ul>
	<li>Manter adequada hidratação.</li>
	<li>Priorizar ingestão proteica (1,2–1,5 g/kg/dia).</li>
	<li>Associar atividade física, preferencialmente musculação.</li>
	<li>Em caso de náuseas importantes, considerar <strong>ondansetrona 8 mg</strong>, se necessário, conforme orientação médica.</li>
	<li>Caso apresente boa tolerância após 4 semanas, reavaliar para possível progressão da dose para <strong>5 mg/semana</strong>.</li>
</ul>

<p><strong>Indicação clínica:</strong> resistência à insulina, excesso de adiposidade corporal e otimização metabólica pré-concepcional.</p>
', 'Danielle Candia Barra', '2026-07-20 10:34:20'),
  ('01169196128', 'prescricao', '<h1>PEDIDO DE EXAME</h1>

<p><strong>Paciente:</strong> Lorraine Ardila Geness de Freitas</p>

<p><strong>Data:</strong> 20/07/2026</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>D35.2 – Adenoma benigno da hipófise</li>
	<li>E22.1 – Hiperprolactinemia</li>
	<li>N97.9 – Infertilidade feminina</li>
</ul>

<hr />
<h2>Solicito:</h2>

<p><strong>Ressonância Magnética de Crânio com estudo direcionado da sela túrcica (Hipófise), COM e SEM contraste paramagnético (gadolínio), COM SEDAÇÃO ANESTÉSICA.</strong></p>

<hr />
<h3>Indicação clínica</h3>

<p>Paciente de 40 anos com <strong>microadenoma hipofisário secretor de prolactina (hiperprolactinemia)</strong> em tratamento com cabergolina, apresentando irregularidade menstrual, infertilidade secundária e dois abortamentos espontâneos consecutivos.</p>

<p>Solicita-se exame para:</p>

<ul>
	<li>Avaliação evolutiva do microadenoma hipofisário.</li>
	<li>Comparação com exame anterior.</li>
	<li>Avaliação do tamanho e características da lesão.</li>
	<li>Pesquisa de crescimento tumoral.</li>
	<li>Avaliação da haste hipofisária.</li>
	<li>Avaliação do quiasma óptico.</li>
	<li>Planejamento terapêutico e acompanhamento pré-concepcional.</li>
</ul>

<p><strong>Paciente apresenta importante ansiedade/claustrofobia, necessitando realização do exame sob sedação anestésica para garantir adequada qualidade diagnóstica e segurança durante o procedimento.</strong></p>

<hr />
<h3>Justificativa para sedação</h3>

<p>A sedação anestésica é necessária devido à incapacidade da paciente de permanecer imóvel durante todo o exame por ansiedade/claustrofobia, condição que compromete a aquisição adequada das imagens e pode resultar em exame inconclusivo, especialmente em estudo de alta resolução da hipófise.</p>
', 'Danielle Candia Barra', '2026-07-20 10:39:19'),
  ('01692484109', 'prescricao', '<p><strong>RECEITA MÉDICA</strong></p>

<p><strong>Tirzepatida (Mounjaro®) 2,5 mg/0,5 mL – caneta preenchida</strong></p>

<p><strong>Prescrição:</strong></p>

<ul>
	<li>Aplicar <strong>2,5 mg por via subcutânea a cada 21 dias (3 semanas)</strong>.</li>
</ul>

<p><strong>Posologia:</strong></p>

<ul>
	<li>Aplicar 1 dose de <strong>2,5 mg</strong> nos seguintes locais, alternando a aplicação: abdome, face anterior da coxa ou região posterior do braço.</li>
	<li>Manter a caneta refrigerada entre <strong>2°C e 8°C</strong>, sem congelar.</li>
	<li>Caso esqueça a aplicação e tenham se passado menos de 4 dias, aplicar assim que lembrar. Após esse período, aguardar a próxima data programada.</li>
</ul>

<p><strong>Quantidade:</strong></p>

<ul>
	<li>01 (uma) caneta preenchida de Mounjaro® 2,5 mg/0,5 mL (ou quantidade suficiente conforme disponibilidade e tempo de tratamento).</li>
</ul>

<p><strong>Uso contínuo.</strong></p>

<hr />
<p><strong>Observação clínica:</strong> A utilização em intervalo de <strong>21 dias</strong> é um esquema individualizado, diferente do regime aprovado em bula (que é semanal), devendo ser mantido apenas sob acompanhamento médico e conforme resposta clínica do paciente.</p>
', 'Danielle Candia Barra', '2026-07-20 11:15:16'),
  ('53932072120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Via Oral<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 1&nbsp;x ao dia, no café da manhã. Por 60 dias<br />
<br />
2-<br />
HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
3- Para comprar na internet<br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias. pós teeino ou a noite.<br />
&nbsp;<br />
<br />
4-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Ácido alfa lipoico ....................................300mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias&nbsp;</span></p>
5-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
selênio quelado-25mcg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span>

<p><font face=&quot;courier new, courier, monospace&quot;><strong>6-</strong></font></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina C ( ácido ascórbico).......................... 2 g</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 1x ao dia, após o treino junto com o colágeno.Por 60 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-07-23 10:25:04'),
  ('53932072120', 'prescricao', 'Uso IM<br />
<br />
Vitamina D3 - 300.000 ui&nbsp;<br />
<br />
2 ampolas, sendo a aplicação 1 a cada 15 dias.&nbsp;', 'Ana Carolina Candia Barra', '2026-07-23 10:27:11'),
  ('83395296768', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Clereto de metiltionínio................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose pela manhã, por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-07-24 11:59:35'),
  ('06336262103', 'prescricao', 'Uso oral<br />
<br />
1-<br />
Zinco carnosina ............... 75 mg<br />
<br />
Tomar 1 caps. após o café da manhã e 1 caps. após o jantar. Por 60 dias.&nbsp;<br />
<br />
2-<br />
Tributirina ..............................600mg<br />
<br />
Tomar 1 caps. após o almoço e 1 caps. após o jantar. Por 60 dias<br />
<br />
3-<br />
Quercetina ...............................500mg<br />
Vitamina C (aci. arcorbico).........500mg<br />
<br />
Tomat 1 caps. após o café da manhã. por 60 dias&nbsp;<br />
<br />
4-<br />
magnésio citaro.....400mg<br />
<br />
Tomar 1 caps. 30 min. antes de dormir. Por 30 dias<br />
<br />
5-<br />
Bifidobacterium longum........... 5 bilhões UFC<br />
Bifidobacterium breve................ 5 bilhões UFC<br />
Bifidobacterium infantis...............5 bilhões UFC<br />
<br />
total 15 Bi UFC<br />
<br />
Tomar 1 caps. em jejum pela manhã por 60 dias.<br />
<br />
6-&nbsp; Ômega 3 -<br />
EPA 1500mg<br />
DHA 700mg&nbsp;<br />
<br />
Tomar 1 x ao dia no almoço e no jantar.&nbsp;<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-07-27 16:41:14'),
  ('53932072120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000 em pó&nbsp;<br />
fazer 500g&nbsp;</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose ( 60g) 1 x ao dia, de manhã ou a noite diluído em 1&nbsp;copo d''àgua.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>OBS: A dose depende a atividade intestinal, podendo aumentar ou reduzir a dose conforme o funcionamento intestinal.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-07-29 10:45:59'),
  ('53698258153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1)</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Sinensis........................................200mg<br />
Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg<br />
Berberina..............................................250mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias. ( pós procedimento de criomodelagem)<br />
<br />
2)</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg<br />
metilcobalamina..........................................1000mcg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e lanche da tarde. Por 60 dias (pré crio)</span><br />
&nbsp;</p>
3)<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;<br />
<br />
4)<br />
Ômega 3 990 EPA e 660 de DHA ( vita for plus)&nbsp;<br />
<br />
Tomar 3 x ao dia, no café da manhã, no almoço e no jantar.</span></span>', 'Ana Carolina Candia Barra', '2026-07-30 10:28:13'),
  ('01663482799', 'prescricao', '<p><strong>Hematologia</strong></p>

<ul>
	<li>Hemograma completo</li>
	<li>Ferritina</li>
	<li>Ferro sérico</li>
	<li>Saturação de transferrina</li>
</ul>

<p><strong>Metabolismo glicídico</strong></p>

<ul>
	<li>Glicemia de jejum</li>
	<li>Insulina basal</li>
	<li>Hemoglobina glicada</li>
	<li>Curva glicêmica e insulinêmica (75 g)</li>
	<li>HOMA-IR</li>
	<li>HOMA-Beta</li>
</ul>

<p><strong>Perfil lipídico</strong></p>

<ul>
	<li>Colesterol total</li>
	<li>HDL-colesterol</li>
	<li>LDL-colesterol</li>
	<li>Não HDL-colesterol</li>
	<li>Triglicerídeos</li>
	<li>Apolipoproteína A1</li>
	<li>Apolipoproteína B</li>
	<li>Lipoproteína(a)</li>
</ul>

<p><strong>Inflamação e risco cardiovascular</strong></p>

<ul>
	<li>Proteína C reativa ultrassensível</li>
	<li>Homocisteína</li>
</ul>

<p><strong>Função renal</strong></p>

<ul>
	<li>Ureia</li>
	<li>Creatinina</li>
	<li>Sódio</li>
	<li>Potássio</li>
	<li>Magnésio</li>
	<li>Ácido úrico</li>
</ul>

<p><strong>Função hepática</strong></p>

<ul>
	<li>TGO (AST)</li>
	<li>TGP (ALT)</li>
	<li>GGT</li>
	<li>Fosfatase alcalina</li>
	<li>Bilirrubinas totais e frações</li>
</ul>

<p><strong>Minerais e vitaminas</strong></p>

<ul>
	<li>Vitamina D (25 OH)</li>
	<li>Vitamina B12</li>
	<li>Ácido fólico</li>
	<li>Zinco</li>
	<li>Selênio</li>
	<li>Cálcio total</li>
	<li>Cálcio iônico</li>
	<li>PTH</li>
</ul>

<p><strong>Tireoide</strong></p>

<ul>
	<li>TSH</li>
	<li>T4 livre</li>
	<li>T3 livre</li>
</ul>

<p><strong>Hormonal</strong></p>

<ul>
	<li>Estradiol</li>
	<li>FSH</li>
	<li>LH</li>
	<li>Testosterona total</li>
	<li>SHBG</li>
	<li>DHEA-S</li>
	<li>IGF-1</li>
	<li>Cortisol (8 horas)</li>
</ul>

<p><strong>Outros</strong></p>

<ul>
	<li>EAS (urina tipo I)</li>
	<li>Relação albumina/creatinina urinária</li>
</ul>
', 'Danielle Candia Barra', '2026-08-03 10:17:28'),
  ('01663482799', 'prescricao', '<h2>Prescrição</h2>

<p><strong>Wegovy® (semaglutida) 2,4 mg/0,75 mL – caneta preenchida</strong></p>

<p><strong>Aplicar 40 cliques por via subcutânea, 1 vez por semana, sempre no mesmo dia da semana.</strong></p>

<hr />
<h2>Orientações</h2>

<p>Aplicar no abdome, coxa ou braço, alternando os locais de aplicação.</p>

<p>Manter a caneta refrigerada entre <strong>2°C e 8°C</strong>.</p>

<p>Não congelar.</p>

<p>Caso esqueça uma dose, administrar em até <strong>5 dias</strong>. Após esse período, pular a dose esquecida e manter o esquema habitual.</p>

<hr />
<p><strong>Quantidade:</strong> 01 (uma) caneta (ou conforme necessidade para o período do tratamento).</p>
', 'Danielle Candia Barra', '2026-08-03 10:30:09'),
  ('01663482799', 'prescricao', '<p>Eu, <strong>Dra. Danielle Candia Barra</strong>, CRM-DF <strong>22677</strong>, atesto, para os devidos fins, que a paciente <strong>Daniela Francescutti Martins Hott</strong>, CPF <strong>016.634.827-99</strong>, compareceu à <strong>Clínica Candia Saúde &amp; Bem-Estar</strong> na presente data para consulta médica, permanecendo em atendimento durante o <strong>período matutino</strong>.</p>

<p>O presente atestado é fornecido exclusivamente para fins de comprovação de comparecimento.</p>

<p><strong>Brasília-DF, 03 de agosto de 2026.</strong></p>

<p>&nbsp;</p>

<hr />
<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677<br />
Médica Nutróloga e Otorrinolaringologista</p>
', 'Danielle Candia Barra', '2026-08-03 10:37:20'),
  ('22352651115', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p>&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>1-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 2&nbsp;gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3 Ydrosolv 30ml ( marca Yosen )<br />
<br />
Tomar 5 gotas sublingual, manter um tempo em baixo ante sde engolir, 1 x ao dia depois do almoço.</span><br />
<br />
3-<br />
<br />
<span style=&quot;font-size:14px&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Ferro Ydrosolv Líquido Em Gotas 30ml ( marca Yosen)</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 10 gotas&nbsp;<span style=&quot;font-size:12px&quot;><strong>sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span>

<p><br />
&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-08-05 16:32:21'),
  ('43882773120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.</strong></span>', 'Ana Carolina Candia Barra', '2026-08-07 18:05:38'),
  ('60464526000', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 2&nbsp;gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.<br />
<br />
3-</strong></span></span><br />
Zinco Ydrosolv® Gotas (30ml) - Marca Yosen&nbsp;&nbsp;<br />
<br />
Tomar 10 gotas&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>4-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>ômega 3 - Mega DHA &nbsp;- ( marca Vitafor)</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3 x ao dia -&nbsp; café da manhã, almoço e jantar. Por 60 dias</span></span><br />
&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-08-07 18:13:05'),
  ('60464526000', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
1-&nbsp;<br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10 (ubiquinol)...............................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e tarde. Por 60 dias.&nbsp;Mande em caps. glúten free<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.<br />
<br />
3-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg<br />
Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;Mande em caps. glúten free</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p>&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-08-07 18:19:25'),
  ('78680166120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Melatonina Time Release – 0,5 mg<br />
mande em caps. glúten free Tomar 30 a 60 min. antes de dormir. Por 60 dias.<br />
<br />
2-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.<br />
<br />
3-</span><br />
C<span style=&quot;font-family:courier new,courier,monospace&quot;>oenzima Q10 ( ubiquinol)...........................100 mg<br />
Ácido málico.........................................12,5 mg<br />
Acetil L - Carnitina.................................25mg<br />
NADH.................................................5mg<br />
Ácido alfa lipóico...................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>mande 90 cap.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 3 x ao dia, café da manhã, lanche da manhã e lanche da tard</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p>4-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Cobalto quelato 100 mcg<br />
Vitamina K2 120 mcg<br />
Metilfolato 500 mcg<br />
Metilcobalamina 1 mg<br />
Cobre Quelato 1,5 mg<br />
Zinco Quelato 7 mg<br />
Ferro Quelato 14 mg<br />
Magnésio Quelato 150 mg<br />
Cálcio Carbonato 730 mg<br />
exinutriment 100mg<br />
Piridoxina 50mg<br />
<br />
Tomar uma dose após almoço e jantar. Por 30 dias<br />
<br />
2<br />
Ômega 3 - 990 EPA e 660 de DHA - vita for plus&nbsp;<br />
Tomar 1 dose 3 x ao dia , café da manhã, almoço e jantar.<br />
<br />
3<br />
Red clover 100 mg<br />
Angélica Sinensis 150 mg<br />
Cissus quadrangulares 150 mg<br />
Ilex paraguariensis 50 mg<br />
<br />
Mande 30 cápsulas.<br />
Tomar uma dose pela manhã e tarde.&nbsp;<br />
<br />
5-<br />
Di indol-metano 50 mg<br />
Selênio 25 mcg<br />
Vitamina E 200 mg<br />
Ascorbato de magnésio 150 mg<br />
Vitex Agnus 80 mg<br />
<br />
Mande 60 cápsulas.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia.</span>', 'Ester Virginio dos Santos Tomaz', '2026-08-10 11:09:12'),
  ('78380782615', 'prescricao', '<small><strong>Uso oral<br />
<br />
1- ( Azul de metileno, mais foco e energia)</strong><br />
<br />
Clereto de metiltionínio................................30mg</small>

<p><small>Tomar 1 dose no lanche da manhã&nbsp;&nbsp;por 60 dias.<br />
<br />
2-<br />
Ômega 3 Mega DHA ( vita for)&nbsp;<br />
Tomar 3 x ao dia café da manhã, almoço e jantar</small></p>
<br />
<small>3- - Suporte hepatico.<br />
<br />
Silimarina...................300mg<br />
NAC............................600mg<br />
Ácido alfa lipoico.........300mg<br />
<br />
Tomar 1 dose 1 x ao dia pela manhã. por 60 dias<br />
<br />
4-&nbsp; melhorar colesterol</small><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-08-12 16:52:43'),
  ('70206409400', 'prescricao', '<br />
Uso Oral<br />
<br />
1-<br />
<small>Clereto de metiltionínio................................30mg</small>
<p><small>Tomar 1 dose no lanche da manhã&nbsp;&nbsp;por 60 dias.</small></p>
', 'Ana Carolina Candia Barra', '2026-08-12 16:55:12'),
  ('02225692041', 'prescricao', 'fase 1 - tratamento da disbiose&nbsp;<br />
<br />
Uso oral&nbsp;<br />
<br />
1- Berberina 500mg&nbsp;<br />
<br />
Tomar 1 caps. 2 x ao dia&nbsp; ( 30 min. antes do almoço e jantar) por 30 dias.<br />
<br />
2-&nbsp;<br />
Óleo de orégano - 150mg&nbsp;<br />
tomar 1 caps. 2 x ao dia (após o almoço e jantar) por 30 dias.<br />
<br />
3-<br />
Extrato de alho 400mg<br />
tomar 2 x ao dia junto as refeições ( almoço e jantar) por 30 dias<br />
<br />
4-<br />
Vitamina B6 (P5P) 25mg<br />
Vitamina B2 ( riboflavina) 25mg<br />
Coenzima Q10 100mg<br />
Tomar 1 x ao dia pela manhã - por 30 dias&nbsp;<br />
<br />
5-<br />
Triphala 500mg<br />
Curcumina 250mg<br />
magnésio bisglicinato 200mg<br />
<br />
Tomar 1 dose antes de dormir por 30 dias.&nbsp; pode tomar até 2 doses se não melhorar a evacuação, relatar após 10 dias de uso.', 'Ana Carolina Candia Barra', '2026-08-14 11:54:06'),
  ('01169196128', 'prescricao', '<h1>PEDIDO DE EXAME</h1>

<p><strong>Paciente:</strong> Lorraine Ardila Geness de Freitas</p>

<p><strong>Data:</strong>&nbsp;_____/_____/_____</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>D35.2 – Adenoma benigno da hipófise</li>
	<li>E22.1 – Hiperprolactinemia</li>
	<li>N97.9 – Infertilidade feminina</li>
</ul>

<hr />
<h2>Solicito:</h2>

<p><strong>Ressonância Magnética de Crânio com estudo direcionado da sela túrcica (Hipófise), COM e SEM contraste paramagnético (gadolínio), COM SEDAÇÃO ANESTÉSICA.</strong></p>

<hr />
<h3>Indicação clínica</h3>

<p>Paciente de 40 anos com <strong>microadenoma hipofisário secretor de prolactina (hiperprolactinemia)</strong> em tratamento com cabergolina, apresentando irregularidade menstrual, infertilidade secundária e dois abortamentos espontâneos consecutivos.</p>

<p>Solicita-se exame para:</p>

<ul>
	<li>Avaliação evolutiva do microadenoma hipofisário.</li>
	<li>Comparação com exame anterior.</li>
	<li>Avaliação do tamanho e características da lesão.</li>
	<li>Pesquisa de crescimento tumoral.</li>
	<li>Avaliação da haste hipofisária.</li>
	<li>Avaliação do quiasma óptico.</li>
	<li>Planejamento terapêutico e acompanhamento pré-concepcional.</li>
</ul>

<p><strong>Paciente apresenta importante ansiedade/claustrofobia, necessitando realização do exame sob sedação anestésica para garantir adequada qualidade diagnóstica e segurança durante o procedimento.</strong></p>

<hr />
<h3>Justificativa para sedação</h3>

<p>A sedação anestésica é necessária devido à incapacidade da paciente de permanecer imóvel durante todo o exame por ansiedade/claustrofobia, condição que compromete a aquisição adequada das imagens e pode resultar em exame inconclusivo, especialmente em estudo de alta resolução da hipófise.</p>
', 'Danielle Candia Barra', '2026-08-17 09:00:21'),
  ('53698258153', 'prescricao', '<h1>SOLICITAÇÃO DE EXAMES DE IMAGEM</h1>

<p><strong>Paciente:</strong> Ana Patrícia Viana de Andrade<br />
<strong>Idade:</strong> 55 anos</p>

<p>Solicito os seguintes exames:</p>

<ol>
	<li>
	<p><strong>Ultrassonografia transvaginal</strong></p>

	<ul>
		<li>
		<p>Avaliação de útero, endométrio, miométrio e anexos.</p>
		</li>
		<li>
		<p>Descrever <strong>espessura endometrial</strong>.</p>
		</li>
		<li>
		<p>Avaliar presença, localização e dimensões de <strong>miomas uterinos</strong>.</p>
		</li>
	</ul>
	</li>
	<li>
	<p><strong>Ultrassonografia de mamas bilateral</strong></p>

	<ul>
		<li>
		<p>Avaliação complementar das mamas.</p>
		</li>
		<li>
		<p>Atenção especial à <strong>mama esquerda</strong>, considerando antecedente de nódulo mamário com crescimento e ressecção cirúrgica parcial, com anatomopatológico benigno.</p>
		</li>
		<li>
		<p>Classificação <strong>BI-RADS</strong>.</p>
		</li>
	</ul>
	</li>
	<li>
	<p><strong>Ultrassonografia de abdome total</strong></p>

	<ul>
		<li>
		<p>Avaliação hepática, vias biliares, vesícula biliar, pâncreas, baço, rins e demais estruturas abdominais acessíveis ao método.</p>
		</li>
		<li>
		<p>Atenção especial para pesquisa e graduação de <strong>esteatose hepática</strong>, considerando antecedente da paciente.</p>
		</li>
	</ul>
	</li>
	<li>
	<p><strong>Ultrassonografia de tireoide com Doppler</strong></p>

	<ul>
		<li>
		<p>Avaliação do volume e ecotextura da glândula.</p>
		</li>
		<li>
		<p>Pesquisa e caracterização de nódulos, quando presentes, com classificação <strong>ACR TI-RADS</strong>.</p>
		</li>
	</ul>
	</li>
</ol>

<p><strong>Indicação clínica:</strong> paciente na pós-menopausa, com fogachos persistentes, antecedente de miomatose uterina, esteatose hepática e nódulo mamário esquerdo previamente ressecado com histologia benigna. Avaliação complementar e rastreamento antes da definição de estratégia terapêutica.</p>

<p><strong>Data:</strong> 17/08/2026</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
Médica Nutróloga e Otorrinolaringologista<br />
<strong>CRM-DF 22677</strong></p>
', 'Danielle Candia Barra', '2026-08-17 09:52:00'),
  ('53698258153', 'prescricao', '<h1>PRESCRIÇÃO</h1>

<p><strong>Paciente:</strong> Ana Patrícia Viana de Andrade<br />
<strong>Idade:</strong> 55 anos</p>

<h3>1. 17?-ESTRADIOL TRANSDÉRMICO – BIOIDÊNTICO</h3>

<p><strong>Estradiol 17? gel 0,5 mg/dose</strong></p>

<p>Aplicar <strong>1 dose na pele, 1 vez ao dia</strong>, preferencialmente pela manhã, em região de coxa ou abdome inferior, alternando os locais de aplicação.</p>

<p><strong>Uso contínuo.</strong></p>

<p>Não aplicar nas mamas ou região genital.</p>

<hr />
<h3>2. PROGESTERONA MICRONIZADA – VIA ORAL</h3>

<p><strong>Progesterona micronizada 100 mg</strong></p>

<p>Tomar <strong>1 cápsula por via oral à noite, diariamente</strong>, ao deitar.</p>

<p><strong>Uso contínuo.</strong></p>

<hr />
<h3>3. ESTRIOL VAGINAL</h3>

<p><strong>Estriol 1 mg/g – creme vaginal</strong></p>

<p>Aplicar <strong>0,5 g por via vaginal à noite, diariamente, durante 14 dias</strong>.</p>

<p>Após esse período, aplicar <strong>0,5 g por via vaginal, 2 vezes por semana</strong>, como manutenção.</p>

<hr />
<p><strong>Orientações:</strong> reavaliar resposta clínica, sangramento uterino, sintomas mamários e tolerabilidade após início da terapia. Qualquer sangramento vaginal após a menopausa deverá ser investigado.</p>

<p><strong>Data:</strong> 17/08/2026</p>

<p><strong>Dra. Danielle Candia Barra<br />
CPF : 061.642.786-78</strong><br />
Médica Nutróloga&nbsp;<br />
<strong>CRM-DF 22677</strong></p>
', 'Danielle Candia Barra', '2026-08-17 09:55:57'),
  ('83206540330', 'prescricao', '<h3>*** Tratamento para 60 dias<br />
<br />
Uso oral&nbsp;&nbsp;<br />
<br />
<br />
Bupropiona SR&nbsp; 75mg&nbsp;</h3>

<p>Tomar 01 dose pela manhã;<br />
<br />
Após tomar 01 dose de manhã e à noite.<br />
&nbsp;</p>

<p>&nbsp;</p>

<h3><br />
Naltrexona&nbsp; &nbsp;25mg</h3>

<p>&nbsp;</p>

<p>Tomar uma dose&nbsp;à noite.<br />
<br />
<br />
<strong>CID principal:</strong><br />
<br />
&nbsp;<strong>E66.0 – Obesidade devida a excesso de calorias</strong></p>
', 'Danielle Candia Barra', '2026-08-17 10:22:20'),
  ('83206540330', 'prescricao', '<h1>RECEITA MÉDICA</h1>

<p><strong>Paciente:</strong> Isaac Abrahão de Oliveira Simões</p>

<p><strong>Mounjaro® (tirzepatida) 10 mg/dose – KwikPen®</strong></p>

<p>Uso subcutâneo.</p>

<p>Aplicar 30 cliques (&nbsp;7,5mg )&nbsp;<strong>, 1 vez por semana</strong>, sempre no mesmo dia da semana.</p>

<p><strong>Quantidade:</strong> 01 (uma) KwikPen®, contendo 4 doses semanais.</p>

<p><strong>CID-10:</strong> E66.9 – Obesidade, não especificada.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-08-17 10:35:50'),
  ('83206540330', 'prescricao', '<h1>RECEITA MÉDICA</h1>

<p><strong>Paciente:</strong> Isaac Abrahão de Oliveira Simões</p>

<p><strong>MOUNJARO® (tirzepatida) 7,5 mg/dose</strong></p>

<p>Uso subcutâneo.</p>

<p>Aplicar <strong>7,5 mg por via subcutânea, 1 vez por semana, durante 12&nbsp;semanas</strong>.</p>

<p><strong>Quantidade:</strong> 04 (quatro) doses de 7,5 mg.</p>

<p><strong>CID-10:</strong> E66.9 – Obesidade, não especificada.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-08-17 10:37:54'),
  ('83206540330', 'prescricao', '<h1>PEDIDO DE EXAMES LABORATORIAIS – CONTROLE</h1>

<p><strong>Paciente:</strong> Isaac Abrahão de Oliveira Simões</p>

<p><strong>CID-10:</strong> E66.9 / Z51.8</p>

<p>Solicito:</p>

<h3>Hematológico / inflamatório</h3>

<ul>
	<li>
	<p>Hemograma completo</p>
	</li>
	<li>
	<p>PCR ultrassensível</p>
	</li>
	<li>
	<p>VHS</p>
	</li>
</ul>

<h3>Metabolismo glicídico</h3>

<ul>
	<li>
	<p>Glicemia de jejum</p>
	</li>
	<li>
	<p>Insulina de jejum</p>
	</li>
	<li>
	<p>Hemoglobina glicada (HbA1c)</p>
	</li>
</ul>

<h3>Perfil lipídico / cardiovascular</h3>

<ul>
	<li>
	<p>Colesterol total e frações</p>
	</li>
	<li>
	<p>Triglicerídeos</p>
	</li>
	<li>
	<p>Apolipoproteína B</p>
	</li>
	<li>
	<p>Apolipoproteína A1</p>
	</li>
	<li>
	<p>Lipoproteína(a)</p>
	</li>
	<li>
	<p>Homocisteína</p>
	</li>
</ul>

<h3>Função renal e eletrólitos</h3>

<ul>
	<li>
	<p>Ureia</p>
	</li>
	<li>
	<p>Creatinina com eTFG</p>
	</li>
	<li>
	<p>Cistatina C com eTFG</p>
	</li>
	<li>
	<p>Relação albumina/creatinina urinária</p>
	</li>
	<li>
	<p>Sódio</p>
	</li>
	<li>
	<p>Potássio</p>
	</li>
	<li>
	<p>Cálcio total</p>
	</li>
	<li>
	<p>Magnésio</p>
	</li>
	<li>
	<p>Ácido úrico</p>
	</li>
</ul>

<h3>Função hepática</h3>

<ul>
	<li>
	<p>TGO (AST)</p>
	</li>
	<li>
	<p>TGP (ALT)</p>
	</li>
	<li>
	<p>GGT</p>
	</li>
	<li>
	<p>Fosfatase alcalina</p>
	</li>
	<li>
	<p>Bilirrubinas totais e frações</p>
	</li>
	<li>
	<p>Albumina</p>
	</li>
</ul>

<h3>Perfil tireoidiano</h3>

<ul>
	<li>
	<p>TSH</p>
	</li>
	<li>
	<p>T4 livre</p>
	</li>
	<li>
	<p>T3 livre</p>
	</li>
</ul>

<h3>Perfil hormonal masculino</h3>

<ul>
	<li>
	<p>Testosterona total</p>
	</li>
	<li>
	<p>SHBG</p>
	</li>
	<li>
	<p>Testosterona livre calculada</p>
	</li>
	<li>
	<p>LH</p>
	</li>
	<li>
	<p>FSH</p>
	</li>
	<li>
	<p>Estradiol ultrassensível</p>
	</li>
	<li>
	<p>Prolactina</p>
	</li>
	<li>
	<p>DHEA-S</p>
	</li>
</ul>

<h3>Vitaminas / micronutrientes</h3>

<ul>
	<li>
	<p>Vitamina B12</p>
	</li>
	<li>
	<p>Ácido fólico</p>
	</li>
	<li>
	<p>Vitamina D – 25-OH</p>
	</li>
	<li>
	<p>Vitamina C</p>
	</li>
	<li>
	<p>Zinco</p>
	</li>
	<li>
	<p>Ferritina</p>
	</li>
	<li>
	<p>Ferro sérico</p>
	</li>
	<li>
	<p>Transferrina</p>
	</li>
	<li>
	<p>Índice de saturação da transferrina</p>
	</li>
</ul>

<h3>Complementação pela parestesia/dor cervical</h3>

<ul>
	<li>
	<p>CPK</p>
	</li>
	<li>
	<p>Vitamina B6 (PLP)</p>
	</li>
	<li>
	<p>Cálcio ionizado</p>
	</li>
</ul>

<p><strong>Justificativa:</strong> acompanhamento metabólico e nutricional durante tratamento para obesidade, monitorização da função renal e avaliação complementar de parestesias em membros superiores associadas à doença degenerativa cervical.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
<strong>CRM-DF 22.677</strong></p>
', 'Danielle Candia Barra', '2026-08-17 10:39:54'),
  ('72632100100', 'prescricao', '<h1>Plano Alimentar Temporário – Redução de Histamina e Urticária</h1>

<p><strong>Paciente:</strong> Sandra de Oliveira Soares Carvalho<br />
<strong>Idade:</strong> 44 anos</p>

<p><strong>Objetivos:</strong> reduzir exposição a possíveis gatilhos alimentares durante a investigação, melhorar o trânsito intestinal e evitar restrições excessivas.</p>

<h2>Café da manhã</h2>

<p><strong>Opção 1</strong></p>

<ul>
	<li>
	<p>2 ovos mexidos preparados na hora</p>
	</li>
	<li>
	<p>Tapioca: 2 colheres de sopa cheias (50 g)</p>
	</li>
	<li>
	<p>Pera ou maçã: 1 unidade</p>
	</li>
</ul>

<p><strong>Opção 2</strong></p>

<ul>
	<li>
	<p>Mingau de aveia: 30 g de aveia + 200 mL de bebida de arroz sem aditivos</p>
	</li>
	<li>
	<p>Maçã: 1 unidade</p>
	</li>
	<li>
	<p>Canela a gosto, se já tolerada</p>
	</li>
</ul>

<h2>Lanche da manhã – se necessário</h2>

<ul>
	<li>
	<p>Pera ou maçã: 1 unidade<br />
	<strong>ou</strong></p>
	</li>
	<li>
	<p>Melão: 150 g</p>
	</li>
</ul>

<h2>Almoço</h2>

<ul>
	<li>
	<p>Arroz: 4 colheres de sopa (100–120 g cozido)</p>
	</li>
	<li>
	<p>Frango ou carne bovina <strong>fresca e preparada no mesmo dia</strong>: 100–120 g</p>
	</li>
	<li>
	<p>Abobrinha, cenoura, chuchu ou abóbora cozidos: 150–200 g</p>
	</li>
	<li>
	<p>Azeite extravirgem: 1 colher de chá</p>
	</li>
</ul>

<h2>Lanche da tarde</h2>

<p><strong>Opção 1</strong></p>

<ul>
	<li>
	<p>Maçã ou pera: 1 unidade</p>
	</li>
	<li>
	<p>Aveia: 1 colher de sopa</p>
	</li>
</ul>

<p><strong>Opção 2</strong></p>

<ul>
	<li>
	<p>Tapioca pequena: 40 g</p>
	</li>
	<li>
	<p>Frango preparado no mesmo dia: 50 g</p>
	</li>
</ul>

<h2>Jantar</h2>

<ul>
	<li>
	<p>Frango ou carne fresca: 100 g</p>
	</li>
	<li>
	<p>Batata, mandioca ou arroz: 80–100 g</p>
	</li>
	<li>
	<p>Legumes cozidos: 150–200 g</p>
	</li>
</ul>

<p><strong>Ou:</strong> sopa preparada no dia com frango, abóbora, chuchu, cenoura e arroz.</p>

<h2>Evitar temporariamente</h2>

<ul>
	<li>
	<p><strong>Castanha de caju e pistache</strong></p>
	</li>
	<li>
	<p>Demais alimentos que já tenham desencadeado sintomas</p>
	</li>
	<li>
	<p>Embutidos: presunto, salame, mortadela, peito de peru, linguiça</p>
	</li>
	<li>
	<p>Enlatados e conservas</p>
	</li>
	<li>
	<p>Carnes defumadas ou curadas</p>
	</li>
	<li>
	<p>Queijos maturados</p>
	</li>
	<li>
	<p>Molho de soja, shoyu e alimentos fermentados</p>
	</li>
	<li>
	<p>Vinagre e conservas em vinagre</p>
	</li>
	<li>
	<p>Bebidas alcoólicas</p>
	</li>
	<li>
	<p>Kombucha</p>
	</li>
	<li>
	<p>Chocolate/cacau</p>
	</li>
	<li>
	<p>Tomate e molhos concentrados de tomate</p>
	</li>
	<li>
	<p>Berinjela e espinafre</p>
	</li>
	<li>
	<p>Abacate</p>
	</li>
	<li>
	<p>Morango</p>
	</li>
	<li>
	<p>Frutas cítricas, inicialmente, se houver associação com as crises</p>
	</li>
	<li>
	<p>Peixes e frutos do mar que não sejam extremamente frescos</p>
	</li>
	<li>
	<p>Sobras de carnes/proteínas mantidas vários dias na geladeira</p>
	</li>
	<li>
	<p>Alimentos ultraprocessados com muitos corantes, conservantes e aromatizantes</p>
	</li>
</ul>

<h2>Constipação</h2>

<ul>
	<li>
	<p>Água: aproximadamente <strong>2 litros/dia</strong>, ajustando individualmente</p>
	</li>
	<li>
	<p>Aveia: 1–2 colheres de sopa/dia</p>
	</li>
	<li>
	<p>Pera com casca, maçã com casca e legumes cozidos diariamente</p>
	</li>
	<li>
	<p>Aumentar fibras progressivamente para evitar distensão abdominal</p>
	</li>
</ul>

<h2>Orientações importantes</h2>

<p>Esta estratégia é <strong>temporária</strong>, idealmente por <strong>2–4 semanas</strong>, seguida de reavaliação e reintrodução individualizada. Não realizar testes ou reintrodução domiciliar de castanha de caju ou de qualquer alimento que previamente tenha provocado reação sistêmica.</p>

<p>Preferir alimentos frescos e preparações simples. Carnes e peixes acumulam mais aminas biogênicas conforme o tempo de armazenamento; preparar e consumir imediatamente ou congelar rapidamente as porções.</p>

<p>Manter um <strong>diário alimentar</strong>, registrando alimento, quantidade, horário e aparecimento de cefaleia, prurido, urticária, edema ou sintomas gastrointestinais.</p>
', 'Danielle Candia Barra', '2026-08-17 12:15:39'),
  ('72632100100', 'prescricao', '<h1>Fórmula – Suporte à Barreira Intestinal</h1>

<p><strong>L-Glutamina</strong> ........................................ 3 g<br />
<strong>Zinco carnosina</strong> ................................... 37,5 mg<br />
<strong>N-acetil-D-glicosamina</strong> ......................... 500 mg<br />
<strong>Glicina</strong> ................................................ 500 mg</p>

<p>Preparar <strong>30 sachês</strong>.</p>

<p><strong>Posologia:</strong> diluir 1 sachê em 150–200 mL de água e tomar 1 vez ao dia, preferencialmente longe das refeições, por 30 dias.</p>

<p><strong>Orientação à farmácia:</strong> preparação sem corantes, conservantes, lactose, glúten, proteína do leite, soja ou oleaginosas. Utilizar o mínimo possível de excipientes.<br />
<br />
&nbsp;</p>

<h1>Fórmula – Modulação de Histamina</h1>

<p><strong>Quercetina</strong> ......................................... 250 mg<br />
<strong>Luteolina</strong> .............................................. 50 mg<br />
<strong>Vitamina C</strong> ........................................... 250 mg<br />
<strong>Rutina</strong> .................................................. 100 mg</p>

<p>Preparar <strong>60 cápsulas vegetais</strong>.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula 2 vezes ao dia, após café da manhã e almoço, por 30 dias.</p>

<p><strong>Observação:</strong> fórmula adjuvante. Não substitui anti-histamínico, plano de emergência ou avaliação alergológica em paciente com história de reação sistêmica.<br />
<br />
&nbsp;</p>

<h1>Fórmula – Vitamina D</h1>

<p><strong>Vitamina D3</strong> ...................................... 5.000 UI<br />
<strong>Vitamina K2 MK-7</strong> ................................. 100 mcg</p>

<p>Preparar <strong>60 cápsulas oleosas</strong>.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula ao dia junto ao almoço por 8 semanas.</p>

<p>Após o período, reavaliar <strong>25-OH vitamina D e cálcio</strong> para definição da dose de manutenção.</p>

<p><strong>Orientação:</strong> utilizar veículo e excipientes sem derivados de oleaginosas.<br />
&nbsp;</p>

<h1>Fórmula – Complexo B</h1>

<p><strong>Tiamina (B1)</strong> ........................................ 20 mg<br />
<strong>Riboflavina-5-fosfato (B2)</strong> .................... 10 mg<br />
<strong>Niacinamida (B3)</strong> .................................. 30 mg<br />
<strong>Pantotenato de cálcio (B5)</strong> ................... 50 mg<br />
<strong>Piridoxal-5-fosfato (B6)</strong> ....................... 10 mg<br />
<strong>Metilfolato</strong> ........................................... 400 mcg<br />
<strong>Metilcobalamina (B12)</strong> ........................ 500 mcg</p>

<p>Preparar <strong>30 cápsulas vegetais</strong>.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula pela manhã, após o café da manhã, por 60 dias.<br />
<br />
&nbsp;</p>
', 'Danielle Candia Barra', '2026-08-17 12:19:32'),
  ('72632100100', 'prescricao', '<h1>Receita</h1>

<p><strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;>Paciente:</font></font></strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;> Sandra de Oliveira Soares Carvalho </font></font><br />
<strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;>Idade:</font></font></strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;> 44 anos</font></font></p>

<h3><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;>1. PEG 3350 – Polietilenoglicol</font></font></h3>

<p><strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;>PEG 3350</font></font></strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;> ........................................ 17g</font></font></p>

<p>Preparar <strong>30 sachês</strong>.</p>

<p><strong>Posologia:</strong> diluir 1 sachê em aproximadamente 200 mL de água e tomar <strong>1 vez ao dia</strong>, preferencialmente pela manhã. Ajustar conforme consistência e frequência das evacuações.</p>

<hr />
<h3><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;>2. Base de Hidrocortisona</font></font></h3>

<p><strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;>Base de hidrocortisona</font></font></strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;> ............................ 10 mg</font></font></p>

<p>Preparar <strong>30 cápsulas</strong>.</p>

<p><strong>Posologia:</strong> tomar <strong>1 cápsula pela manhã</strong>, conforme orientação médica.</p>

<p><strong><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;><font dir=&quot;auto&quot; style=&quot;vertical-align: inherit;&quot;>Uso oral.</font></font></strong></p>

<p><strong>Observação:</strong> realizar transição do corticoide sistêmico vigente sob supervisão médica; não associar ou suspender abruptamente a prednisolona sem definição do esquema de transição.</p>
', 'Danielle Candia Barra', '2026-08-17 12:24:19'),
  ('72632100100', 'prescricao', '<h1>Solicitação de Exames – RAST / IgE Específica</h1>

<p><strong>Paciente:</strong> Sandra de Oliveira Soares Carvalho<br />
<strong>Idade:</strong> 44 anos</p>

<p><strong>Solicito IgE específica (RAST) para:</strong></p>

<h3>Alimentos</h3>

<ul>
	<li>
	<p>Castanha de caju</p>
	</li>
	<li>
	<p>Pistache</p>
	</li>
	<li>
	<p>Amendoim</p>
	</li>
	<li>
	<p>Castanha-do-pará</p>
	</li>
	<li>
	<p>Nozes</p>
	</li>
	<li>
	<p>Avelã</p>
	</li>
	<li>
	<p>Amêndoa</p>
	</li>
	<li>
	<p>Leite de vaca</p>
	</li>
	<li>
	<p>Clara de ovo</p>
	</li>
	<li>
	<p>Trigo</p>
	</li>
	<li>
	<p>Soja</p>
	</li>
	<li>
	<p>Camarão</p>
	</li>
	<li>
	<p>Peixe</p>
	</li>
</ul>

<h3>Inalantes</h3>

<ul>
	<li>
	<p><em>Dermatophagoides pteronyssinus</em></p>
	</li>
	<li>
	<p><em>Dermatophagoides farinae</em></p>
	</li>
	<li>
	<p><em>Blomia tropicalis</em></p>
	</li>
	<li>
	<p>Epitélio de cão</p>
	</li>
	<li>
	<p>Epitélio de gato</p>
	</li>
	<li>
	<p>Barata</p>
	</li>
	<li>
	<p>Fungos (<em>Alternaria</em> / <em>Aspergillus</em>)</p>
	</li>
</ul>

<p><strong>Complementar:</strong></p>

<ul>
	<li>
	<p>IgE total</p>
	</li>
	<li>
	<p>Ana o 3 – componente molecular da castanha de caju</p>
	</li>
</ul>

<p><strong>Indicação:</strong> urticária recorrente e suspeita de hipersensibilidade imediata após exposição alimentar.</p>
', 'Danielle Candia Barra', '2026-08-17 12:45:46'),
  ('72632100100', 'prescricao', '<h1>Solicitação de Exame</h1>

<p><strong>Paciente:</strong> Sandra de Oliveira Soares Carvalho<br />
<strong>Idade:</strong> 44 anos</p>

<p><strong>Solicito:</strong></p>

<ul>
	<li>
	<p>Painel de Intolerância Alimentar <strong>A200 – IgG específica para aproximadamente 200 alimentos</strong></p>
	</li>
</ul>

<p><strong>Indicação clínica:</strong> investigação complementar de sintomas gastrointestinais e manifestações associadas à ingestão alimentar.</p>

<p><strong>Observação:</strong> exame complementar, não substituindo a investigação de alergia alimentar IgE-mediada.</p>
', 'Danielle Candia Barra', '2026-08-17 12:46:05'),
  ('72632100100', 'prescricao', '<h1>Anamnese – Consulta de 17/08/2026</h1>

<p><strong>Paciente:</strong> Sandra de Oliveira Soares Carvalho<br />
<strong>Idade:</strong> 44 anos</p>

<h2>Queixa principal</h2>

<p>Crises alérgicas recorrentes/urticária, com piora recente.</p>

<h2>História da doença atual</h2>

<p>Paciente com histórico de alergias de longa data, apresentando piora recente das manifestações. Refere episódios que podem iniciar com <strong>cefaleia</strong>, seguidos de <strong>urticária aproximadamente 40 minutos após ingestão alimentar</strong>.</p>

<p>Relata episódio recente após <strong>contato com castanha de caju</strong>, levantando suspeita de hipersensibilidade alimentar imediata.</p>

<p>Apresenta antecedente de <strong>crise alérgica grave com necessidade de internação há aproximadamente 15 anos</strong>.</p>

<p>Encontra-se em uso de <strong>Predsim® 20 mg/dia há 15 dias</strong> devido à exacerbação do quadro alérgico.</p>

<p>Refere importante componente de <strong>estresse</strong>, potencialmente atuando como fator de exacerbação das manifestações cutâneas/alérgicas.</p>

<p>Apresenta ainda <strong>constipação intestinal crônica</strong>.</p>

<h2>Antecedentes pessoais</h2>

<ul>
	<li>
	<p>Alergia medicamentosa: <strong>dipirona</strong></p>
	</li>
	<li>
	<p>Antecedente de reação alérgica grave com internação há 15 anos</p>
	</li>
	<li>
	<p>Nega cirurgias prévias</p>
	</li>
	<li>
	<p>Constipação intestinal de longa data</p>
	</li>
	<li>
	<p>Três filhos: 22, 20 e 17 anos</p>
	</li>
</ul>

<h2>História ginecológica</h2>

<ul>
	<li>
	<p>Ciclos menstruais regulares, aproximadamente a cada <strong>21 dias</strong></p>
	</li>
	<li>
	<p>Duração do fluxo: aproximadamente <strong>4 dias</strong></p>
	</li>
</ul>

<h2>Exames laboratoriais apresentados</h2>

<ul>
	<li>
	<p>Hemoglobina: 13,3 g/dL</p>
	</li>
	<li>
	<p>Leucócitos: 10.200/mm³</p>
	</li>
	<li>
	<p>Plaquetas: 191.000/mm³</p>
	</li>
	<li>
	<p>Ferro: <strong>203</strong></p>
	</li>
	<li>
	<p>Ferritina: 81,73</p>
	</li>
	<li>
	<p>Glicose: 86</p>
	</li>
	<li>
	<p>Insulina: 7,5</p>
	</li>
	<li>
	<p>HOMA-IR calculado: <strong>1,59</strong></p>
	</li>
	<li>
	<p>HbA1c: 4,3%</p>
	</li>
	<li>
	<p>Albumina: 4,8</p>
	</li>
	<li>
	<p>Creatinina: 0,69</p>
	</li>
	<li>
	<p>Ureia: 20</p>
	</li>
	<li>
	<p>Cálcio: 9,3</p>
	</li>
	<li>
	<p>Magnésio: 2,2</p>
	</li>
	<li>
	<p>Zinco: 80</p>
	</li>
	<li>
	<p>Selênio: 81,8</p>
	</li>
	<li>
	<p>Ácido úrico: 3,6</p>
	</li>
	<li>
	<p>Enzimas hepáticas: sem alterações</p>
	</li>
	<li>
	<p>PCR: 0,28</p>
	</li>
	<li>
	<p>IgA: 148</p>
	</li>
	<li>
	<p>IgM: 129</p>
	</li>
	<li>
	<p>IgG: 1.242</p>
	</li>
	<li>
	<p>C3/C4: sem alteração relevante relatada</p>
	</li>
	<li>
	<p>Fator reumatoide: &lt;0,10</p>
	</li>
	<li>
	<p>FAN: <strong>reagente 1:320</strong></p>
	</li>
	<li>
	<p>Anticorpos nucleares: <strong>reagentes</strong></p>
	</li>
	<li>
	<p>Placa metafásica cromossômica: <strong>reagente</strong></p>
	</li>
	<li>
	<p>Triptase: 1,60</p>
	</li>
	<li>
	<p>ACTH: 9,3</p>
	</li>
	<li>
	<p>Cortisol: <strong>2,40</strong></p>
	</li>
	<li>
	<p>TSH: 1,12</p>
	</li>
	<li>
	<p>T3: 1,92</p>
	</li>
	<li>
	<p>IGF-1: 185</p>
	</li>
	<li>
	<p>Vitamina B12: <strong>332</strong></p>
	</li>
	<li>
	<p>Ácido fólico: 7,30</p>
	</li>
	<li>
	<p>Vitamina D: <strong>17,9 – deficiência</strong></p>
	</li>
</ul>

<h3>Perfil lipídico</h3>

<ul>
	<li>
	<p>Colesterol total: 194</p>
	</li>
	<li>
	<p>HDL: 64</p>
	</li>
	<li>
	<p>LDL: 112</p>
	</li>
	<li>
	<p>Triglicerídeos: 82</p>
	</li>
	<li>
	<p>ApoB: 96</p>
	</li>
	<li>
	<p>Lipoproteína(a): 10,82</p>
	</li>
</ul>

<h3>Coprológico</h3>

<ul>
	<li>
	<p>Fezes cíbalas</p>
	</li>
	<li>
	<p>pH fecal: 5,0</p>
	</li>
	<li>
	<p>Histamina: 0,06</p>
	</li>
</ul>

<h3>Imagem</h3>

<p><strong>Ultrassonografia de abdome total:</strong> sem alterações.</p>

<h2>Avaliação</h2>

<ol>
	<li>
	<p><strong>Urticária recorrente com suspeita de hipersensibilidade alimentar imediata</strong></p>
	</li>
	<li>
	<p>Suspeita importante de reação à <strong>castanha de caju</strong></p>
	</li>
	<li>
	<p>Antecedente de reação alérgica sistêmica grave</p>
	</li>
	<li>
	<p>Estresse como possível fator amplificador das manifestações alérgicas</p>
	</li>
	<li>
	<p>Uso de corticoide sistêmico há 15 dias</p>
	</li>
	<li>
	<p><strong>Cortisol reduzido em vigência de corticoterapia</strong>, devendo considerar supressão do eixo hipotálamo-hipófise-adrenal pelo glicocorticoide</p>
	</li>
	<li>
	<p><strong>FAN positivo 1:320</strong>, necessitando correlação clínica e investigação autoimune complementar</p>
	</li>
	<li>
	<p><strong>Deficiência de vitamina D</strong></p>
	</li>
	<li>
	<p>Níveis subótimos de vitamina B12</p>
	</li>
	<li>
	<p>Constipação intestinal crônica</p>
	</li>
	<li>
	<p>Ferro sérico elevado, com ferritina preservada</p>
	</li>
</ol>

<h2>Conduta na consulta</h2>

<ul>
	<li>
	<p>Solicitada investigação de <strong>alergia alimentar IgE-mediada/RAST</strong></p>
	</li>
	<li>
	<p>Solicitados IgE específicos para principais alimentos e oleaginosas</p>
	</li>
	<li>
	<p>Incluído <strong>Ana o 3</strong>, componente molecular da castanha de caju</p>
	</li>
	<li>
	<p>Orientada exclusão rigorosa de castanha de caju e cautela com pistache até esclarecimento alergológico</p>
	</li>
	<li>
	<p>Dieta temporária com redução de alimentos ricos/liberadores de histamina e ultraprocessados</p>
	</li>
	<li>
	<p>Orientado diário alimentar e registro das crises</p>
	</li>
	<li>
	<p>Estratégia nutricional para melhora da constipação</p>
	</li>
	<li>
	<p>Prescrito <strong>PEG 3350</strong></p>
	</li>
	<li>
	<p>Suporte à barreira intestinal</p>
	</li>
	<li>
	<p>Estratégia nutricional adjuvante para modulação de histamina</p>
	</li>
	<li>
	<p>Reposição de vitamina D</p>
	</li>
	<li>
	<p>Complexo B com B12 e folato</p>
	</li>
	<li>
	<p>Prescrita <strong>hidrocortisona base 10 mg pela manhã</strong>, considerando o contexto do eixo adrenal e necessidade de manejo individualizado da corticoterapia</p>
	</li>
	<li>
	<p>Orientada redução da carga de estresse e fornecidas explicações aos familiares sobre sua possível participação na exacerbação das crises</p>
	</li>
	<li>
	<p>Orientados sinais de alerta para reação alérgica grave e necessidade de atendimento de emergência</p>
	</li>
	<li>
	<p>Manter acompanhamento e considerar avaliação especializada com <strong>Alergologia/Imunologia e Reumatologia</strong>, conforme evolução e resultados da investigação.</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-08-17 12:48:46'),
  ('09157396663', 'prescricao', '<strong>Via oral<br />
<br />
1. Vitamina D + K2</strong><br />
<br />
<strong>Vitamina D3 (colecalciferol)</strong> — 10.000 UI<br />
<strong>Vitamina K2 MK-7</strong>&nbsp;— 120 mcg<br />
<br />
<strong>Posologia:</strong>&nbsp;tomar 1 cápsula ao dia, junto a uma refeição com gordura.<br />
<strong>Quantidade:</strong>&nbsp;60 cápsulas.<br />
<br />
---<br />
<br />
<strong>&nbsp;2. Complexo B + Inositol</strong><br />
<br />
<strong>Tiamina (Vitamina B1)</strong>&nbsp;— 25 mg<br />
<strong>Riboflavina-5-fosfato (Vitamina B2 ativa)</strong>&nbsp;— 10 mg<br />
<strong>Nicotinamida (Vitamina B3)</strong>&nbsp;— 30 mg<br />
<strong>Pantotenato de cálcio (Vitamina B5)</strong>&nbsp;— 50 mg<br />
<strong>Piridoxal-5-fosfato (Vitamina B6 ativa)</strong>&nbsp;— 10 mg<br />
<strong>L-metilfolato</strong>&nbsp;— 400 mcg<br />
<strong>Metilcobalamina (Vitamina B12)</strong>&nbsp;— 500 mcg<br />
<strong>Biotina</strong>&nbsp;— 300 mcg<br />
<strong>Mio-inositol</strong>&nbsp;— 500 mg<br />
<br />
<strong>Posologia:</strong>&nbsp;tomar 1 dose pela manhã.<br />
<strong>Quantidade:</strong>* 60 doses.<br />
<br />
---<br />
<br />
<strong>&nbsp;3. Suporte Mitocondrial e Antioxidante</strong><br />
<br />
<strong>Coenzima Q10</strong>&nbsp;— 200 mg<br />
<strong>Resveratrol trans</strong> — 150 mg<br />
<br />
<strong>Posologia:</strong>&nbsp;tomar 1 cápsula ao dia, preferencialmente junto ao almoço.<br />
<strong>Quantidade:</strong>&nbsp;60 cápsulas.<br />
<br />
---<br />
<br />
<strong>&nbsp;4. N-Acetilcisteína</strong><br />
<br />
<strong>N-acetilcisteína (NAC)</strong> — 600 mg<br />
<br />
<strong>Posologia:</strong>&nbsp;tomar 1 cápsula ao dia.<br />
<strong>Quantidade:</strong> 60 cápsulas.', 'Ester Virginio dos Santos Tomaz', '2026-08-18 14:06:48'),
  ('40063976153', 'prescricao', 'VENDO OS EXAMES&nbsp;<br />
<br />
OBSERVEI UMA ANISOCITOSE E MICROCITOSE<br />
<br />
rdw EM 16.8<br />
<br />
b12 - 600&nbsp;<br />
<br />
FERRO E FERRITINA NORMAIS.&nbsp;<br />
<br />
VOU PEDIR ACIDO FOLICO&nbsp;<br />
E SE ESTIVER NORMAL FAZER MICROSCOPIA.&nbsp;', 'Ana Carolina Candia Barra', '2026-08-19 16:43:36'),
  ('85260665104', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
<br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;<br />
<br />
2-</span></span><br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span><br />
<br />
3-<br />
ViA IM<br />
<br />
vita D 100.000 ui&nbsp;<br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-08-19 17:27:47'),
  ('53698258153', 'prescricao', '<h1>SOLICITAÇÃO DE EXAMES HORMONAIS</h1>

<p><strong>Paciente:</strong> Ana Patrícia Viana de Andrade<br />
<strong>Idade:</strong> 55 anos<br />
<strong>Data:</strong> 24/08/2026</p>

<p>Solicito:</p>

<ul>
	<li>
	<p>Estradiol</p>
	</li>
	<li>
	<p>Estrona</p>
	</li>
	<li>
	<p>Progesterona</p>
	</li>
	<li>
	<p>FSH</p>
	</li>
	<li>
	<p>LH</p>
	</li>
	<li>
	<p>Testosterona total</p>
	</li>
	<li>
	<p>SHBG</p>
	</li>
	<li>
	<p>Testosterona livre calculada</p>
	</li>
	<li>
	<p>DHEA-S</p>
	</li>
	<li>
	<p>AndrostenedionaProlactina</p>
	</li>
</ul>

<p><strong>Indicação:</strong> menopausa em acompanhamento e avaliação hormonal para seguimento/ajuste da terapia hormonal.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
<strong>CRM-DF 22677</strong></p>
', 'Danielle Candia Barra', '2026-08-24 09:35:29'),
  ('53698258153', 'prescricao', '<h1>RECEITA MÉDICA</h1>

<p><strong>Paciente:</strong> Ana Patrícia Viana de Andrade<br />
<strong>Data:</strong> 24/08/2026</p>

<p><strong>Ozivy® (semaglutida) 1,34 mg/mL – caneta aplicadora</strong></p>

<p>Aplicar <strong>0,25 mg por via subcutânea, 1 vez por semana, durante 4 semanas</strong>, sempre no mesmo dia da semana.</p>

<p><strong>Dispensar:</strong> 01 caneta aplicadora.</p>

<p><strong>Orientações:</strong> aplicação subcutânea em abdome, coxa ou parte superior do braço, alternando os locais de aplicação. Reavaliar tolerabilidade e resposta clínica antes da progressão da dose.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
<strong>CRM-DF 22677</strong></p>
', 'Danielle Candia Barra', '2026-08-24 09:37:57'),
  ('82006571753', 'prescricao', '<p><strong>PACIENTE:</strong> Lidia dos Santos Pêgas<br />
<strong>Idade:</strong> 63 anos</p>

<h3>PRESCRIÇÃO</h3>

<p><strong>1. Estradiol bioidêntico transdérmico – manipulado</strong><br />
Estradiol bioidêntico <strong>0,8 mg por aplicação</strong><br />
Veículo transdérmico hipoalergênico q.s.p. 1 aplicação.<br />
<strong>Uso:</strong> aplicar <strong>1 dose (0,8 mg) na pele, 1 vez ao dia</strong>, preferencialmente em membros inferiores, alternando os locais de aplicação.<br />
<strong>Uso contínuo.</strong></p>

<p><strong>2. Progesterona micronizada 100 mg</strong><br />
Cápsulas.<br />
<strong>Uso:</strong> tomar <strong>1 cápsula por via oral à noite</strong>, diariamente.<br />
<strong>Uso contínuo.</strong></p>

<p><strong>3. Stele® 1 mg/g – uso vaginal</strong><br />
<strong>Uso:</strong> aplicar <strong>1 dose por via vaginal à noite</strong>, conforme esquema de manutenção habitual da paciente.</p>

<p><strong>4. Testosterona bioidêntica 4 mg – transdérmica</strong><br />
Testosterona <strong>4 mg por aplicação</strong><br />
Veículo transdérmico hipoalergênico q.s.p. 1 aplicação.<br />
<strong>Uso:</strong> aplicar <strong>1 dose na pele, 1 vez ao dia</strong>, conforme orientação médica.<br />
<strong>Uso contínuo.</strong></p>

<p><strong>Observação:</strong> paciente com <strong>alergia a látex</strong>. Utilizar embalagens/aplicadores livres de látex quando aplicável.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2026-08-24 10:59:50'),
  ('82006571753', 'prescricao', '<p><strong>PACIENTE:</strong> Lidia dos Santos Pêgas<br />
<strong>Idade:</strong> 63 anos</p>

<p><strong>Indicação:</strong> investigação de queda capilar / suspeita de alopecia androgenética feminina.</p>

<h3>EXAMES LABORATORIAIS</h3>

<p><strong>Eixo androgênico</strong></p>

<ul>
	<li>
	<p>Testosterona total</p>
	</li>
	<li>
	<p>Testosterona livre</p>
	</li>
	<li>
	<p>SHBG</p>
	</li>
	<li>
	<p>DHEA-S</p>
	</li>
	<li>
	<p>Androstenediona</p>
	</li>
	<li>
	<p>DHT – di-hidrotestosterona<br />
	&nbsp;</p>
	</li>
</ul>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2026-08-24 11:04:55'),
  ('60464526000', 'prescricao', '<p><strong>Paciente:</strong> Helena Azevedo dos Santos<br />
<strong>Idade:</strong> 56 anos</p>

<h3>1. Complexo B – manipulado</h3>

<p><strong>Tiamina (Vitamina B1)</strong> — 50 mg<br />
<strong>Riboflavina-5-fosfato (Vitamina B2 ativa)</strong> — 20 mg<br />
<strong>Nicotinamida (Vitamina B3)</strong> — 50 mg<br />
<strong>Pantotenato de cálcio (Vitamina B5)</strong> — 50 mg<br />
<strong>Piridoxal-5-fosfato (Vitamina B6 ativa)</strong> — 10 mg<br />
<strong>Metilfolato</strong> — 400 mcg<br />
<strong>Metilcobalamina (Vitamina B12)</strong> — 500 mcg<br />
<strong>Biotina</strong> — 2,5 mg<br />
<strong>Mio-inositol</strong> — 200 mg</p>

<p>Excipiente q.s.p. 1 cápsula.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula pela manhã, após o café da manhã.<br />
<strong>Quantidade:</strong> 60 cápsulas.</p>

<h3>2. Coenzima Q10</h3>

<p><strong>Coenzima Q10 (ubiquinol)</strong> — 200 mg</p>

<p>Excipiente oleoso q.s.p. 1 cápsula.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula ao dia, junto a uma refeição contendo gordura.<br />
<strong>Quantidade:</strong> 60 cápsulas.</p>

<p><strong>Observação:</strong> manter a CoQ10 separada do complexo B. Particularmente interessante nesta paciente pelo uso crônico de sinvastatina.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2026-08-24 11:51:29'),
  ('60464526000', 'prescricao', '<p><strong>PACIENTE:</strong> Helena Azevedo dos Santos<br />
<strong>Idade:</strong> 56 anos</p>

<p><strong>Solicito:</strong></p>

<ol>
	<li>
	<p><strong>Ultrassonografia de tireoide</strong></p>

	<ul>
		<li>
		<p>Avaliação morfológica da glândula tireoide e pesquisa de nódulos.</p>
		</li>
	</ul>
	</li>
	<li>
	<p><strong>Ultrassonografia de abdome total</strong></p>

	<ul>
		<li>
		<p>Avaliação de fígado, vias biliares, pâncreas, baço, rins, aorta abdominal e bexiga.</p>
		</li>
		<li>
		<p>Antecedentes de colecistectomia e nefrolitíase.</p>
		</li>
	</ul>
	</li>
	<li>
	<p><strong>Ultrassonografia de mamas bilateral</strong></p>

	<ul>
		<li>
		<p>Avaliação mamária bilateral.</p>
		</li>
		<li>
		<p>História familiar de câncer de mama em irmã.</p>
		</li>
	</ul>
	</li>
	<li>
	<p><strong>Ultrassonografia transvaginal</strong></p>

	<ul>
		<li>
		<p>Avaliação de útero, endométrio e anexos.</p>
		</li>
		<li>
		<p>Paciente em pós-menopausa, com antecedente de uso prolongado de DIU Mirena.</p>
		</li>
	</ul>
	</li>
</ol>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>

<p><strong>Data:</strong> 24/08/2026</p>
', 'Danielle Candia Barra', '2026-08-24 11:53:15'),
  ('60464526000', 'prescricao', '<p><strong>Paciente:</strong> Helena Azevedo dos Santos<br />
<strong>Idade:</strong> 56 anos</p>

<p><strong>Polietilenoglicol 4000 (PEG 4000), sem eletrólitos</strong> — 17 g</p>

<p>Manipular em sachês.</p>

<p><strong>Posologia:</strong> diluir 1 sachê em aproximadamente 200 mL de água e tomar <strong>1 vez ao dia</strong>, preferencialmente pela manhã.</p>

<p>Ajustar posteriormente conforme resposta intestinal, buscando evacuação confortável e fezes Bristol 3–4.</p>

<p><strong>Quantidade:</strong> 30 sachês.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2026-08-24 11:53:40'),
  ('60464526000', 'prescricao', '<p><strong>Paciente:</strong> Helena Azevedo dos Santos<br />
<strong>Idade:</strong> 56 anos</p>

<p><strong>Collagene Derma® – B.Health</strong> — pó, 300 g</p>

<p><strong>Posologia:</strong> diluir <strong>2 scoops (10 g)</strong> em aproximadamente <strong>200 mL de água</strong>, 1 vez ao dia. Consumir logo após o preparo.</p>

<p><strong>Uso contínuo.</strong></p>

<p><strong>Quantidade:</strong> 1 pote de 300 g.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2026-08-24 11:54:02'),
  ('60464526000', 'prescricao', '<p><strong>Paciente:</strong> Helena Azevedo dos Santos<br />
<strong>Idade:</strong> 56 anos</p>

<h3>1. Progesterona micronizada 100 mg</h3>

<p><strong>Progesterona micronizada 100 mg</strong><br />
Cápsulas</p>

<p><strong>Posologia:</strong> tomar <strong>1 cápsula por via oral à noite</strong>, diariamente, em uso contínuo.</p>

<p><strong>Quantidade:</strong> 60 cápsulas.</p>

<h3>2. Estriol vaginal</h3>

<p><strong>Estriol 0,5&nbsp;mg/g</strong><br />
Creme vaginal</p>

<p><strong>Posologia:</strong> aplicar 0,5<strong>&nbsp;g por via vaginal à noite durante 14 dias</strong>.<br />
Após esse período, manter <strong>1 g por via vaginal 2 a 3 vezes por semana</strong>.</p>

<p><strong>Quantidade:</strong> 1 bisnaga com 30 g.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>

<p><strong>Data:</strong> 24/08/2026</p>
', 'Danielle Candia Barra', '2026-08-24 11:55:29'),
  ('60464526000', 'prescricao', '<p><strong>Paciente:</strong> Helena Azevedo dos Santos<br />
<strong>Idade:</strong> 56 anos</p>

<h3>1. Complexo B – manipulado<br />
<br />
<strong>Metilcobalamina (Vitamina B12)</strong> — 500 mcg<br />
<strong>Biotina</strong> — 2,5 mg<br />
<strong>Mio-inositol</strong> — 200 mg</h3>

<p>Excipiente q.s.p. 1 cápsula.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula pela manhã, após o café da manhã.<br />
<strong>Quantidade:</strong> 60 cápsulas.</p>

<h3>2. Coenzima Q10</h3>

<p><strong>Coenzima Q10 (ubiquinol)</strong> — 200 mg</p>

<p>Excipiente oleoso q.s.p. 1 cápsula.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula ao dia, junto a uma refeição contendo gordura.<br />
<strong>Quantidade:</strong> 60 cápsulas.</p>

<p><strong>Observação:</strong> manter a CoQ10 separada do complexo B. Particularmente interessante nesta paciente pelo uso crônico de sinvastatina.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Ana Carolina Candia Barra', '2026-08-26 14:16:30'),
  ('60464526000', 'prescricao', '<h3>1. Complexo B – manipulado<br />
<br />
<strong>Metilcobalamina (Vitamina B12)</strong>&nbsp;— 500 mcg<br />
<strong>Biotina</strong>&nbsp;— 2,5 mg<br />
<strong>Mio-inositol</strong>&nbsp;— 200 mg</h3>

<p>Excipiente q.s.p. 1 cápsula.</p>

<p><strong>Posologia:</strong>&nbsp;tomar 1 cápsula pela manhã, após o café da manhã.<br />
<strong>Quantidade:</strong>&nbsp;60 cápsulas.</p>

<h3>2. Coenzima Q10</h3>

<p><strong>Coenzima Q10 (ubiquinol)</strong>&nbsp;— 200 mg</p>

<p>Excipiente oleoso q.s.p. 1 cápsula.</p>

<p><strong>Posologia:</strong>&nbsp;tomar 1 cápsula ao dia, junto a uma refeição contendo gordura.<br />
<strong>Quantidade:</strong>&nbsp;60 cápsulas.</p>

<p><strong>Observação:</strong>&nbsp;manter a CoQ10 separada do complexo B. Particularmente interessante nesta paciente pelo uso crônico de sinvastatina.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2026-08-26 14:48:34'),
  ('02225692041', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>HMB 1 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.</span></p>
', 'Ana Carolina Candia Barra', '2026-08-27 18:03:08'),
  ('83000372172', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno</strong></span></p>
1-<br />
Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg
<p>Tomar 1 dose&nbsp; 2 x ao dia, manhã e tarde. Por 30 dias<br />
<br />
2-</p>

<h1><span style=&quot;font-size:14px&quot;>ômega 3 - 990 EPA e 660 DHA&nbsp;- (sugestão de&nbsp; marca Vitafor Plus)</span></h1>

<p><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 3&nbsp;x ao dia - café da manhã,&nbsp;&nbsp;almoço e jantar. Por 30 dias<br />
<br />
3-</span></p>

<p><span style=&quot;font-size:16px&quot;><small>Magnésio treonato ……………………… 150mg<br />
Magnésio glicina ………………………. 200mg<br />
Riboflavina (Vitamina B2) ………………. 50mg<br />
Vitamina C ……………………………. 300mg<br />
<br />
Tomar 1 dose , 1 x ao dia a noite antes de dormir. Por 30 dias.</small></span><br />
&nbsp;</p>

<p><span style=&quot;font-size:16px&quot;><small>&nbsp;</small></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-08-28 15:53:48'),
  ('53103335253', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Manutenção massa miuscular&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>1- para manipular<br />
<br />
HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
2- Para comprar na internet<br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias.&nbsp;<br />
<br />
&nbsp;</span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-08-28 15:57:55'),
  ('25520199191', 'prescricao', '<p><br />
<small>1-<br />
Ômega 3 990 de EPA e 600 de DHA ( vitafor Plus)<br />
<br />
Tomar 1 dose, 3 x ao dia , no café da manhã, almoço e jantar. Por 90 dias.&nbsp;</small></p>
<br />
<small>2- Fómula inibidora da aromatase, ( prostata, manter tomando se ainda tiver em casa)</small>

<ul>
	<li><small>Saw Palmetto (Serenoa repens) extrato padronizado (85–95% ácidos graxos) –&nbsp;<strong>160 mg</strong></small></li>
	<li><small>Pygeum africanum extrato seco –&nbsp;<strong>100 mg</strong></small></li>
	<li><small>Urtica dioica (raiz) extrato seco –&nbsp;<strong>120 mg</strong></small></li>
	<li><small>Zinco quelado – 25<strong>&nbsp;mg</strong></small></li>
	<li><small>Licopeno –&nbsp;<strong>10 mg</strong></small></li>
</ul>

<p><small>&nbsp; &nbsp; &nbsp; 1 cápsula, 2x ao dia (manhã e noite), após refeições</small><br />
<br />
<small><small>3- mantem a insulina e glicemia&nbsp;</small></small></p>
<small><small>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
picnogenol..............................................30mg<br />
Berberina...............................................250mg</small></small>

<p><small><small>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</small></small><br />
<br />
<span style=&quot;font-size:11px&quot;>4-&nbsp; auxilia no colesterol</span></p>
<span style=&quot;font-size:11px&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span></span>

<p><span style=&quot;font-size:11px&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.</span></span><br />
<br />
&nbsp;</p>
<span style=&quot;font-size:11px&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;> </span></span>

<p><span style=&quot;font-size:11px&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-08-28 16:07:16'),
  ('06683879397', 'prescricao', 'Uso oral<br />
<br />
1-<br />
Astragalus membraneceus 200 mg<br />
Cinnamon cassia 50 mg<br />
Cranberry 200 mg<br />
Grape seed 75 mg<br />
Green tea 100 mg<br />
Raspberry 25 mg<br />
Uva ursi 50 mg<br />
Vitamina C 100 mg<br />
Zingiber officinale 50 mg<br />
<br />
Mande 60 cápsulas.<br />
Posologia sugerida: tomar uma dose duas vezes ao dia, junto às<br />
refeições. Por 30 dias.&nbsp; glúten free<br />
<br />
2-<br />
NADH......................&nbsp; 5 mg<br />
Silimarina...............&nbsp; 300 mg<br />
Selênio Glicina.......... 200 mcg<br />
Vitamina B12............ 200 mcg<br />
Biotina......................&nbsp; 1mg<br />
Zinco quedado (Albion). 15 mg<br />
Vitamina E.................... 200 UI<br />
L Glutationa ..................15 mg<br />
N Acetil Cisteína............ 500 mg<br />
Vitamina B6 ....................50 mg<br />
Quercetina..................... 100 mg<br />
<br />
Posologia sugerida: tomar uma cápsula após o desjejum e uma<br />
cápsula após o jantar. Por 60 dias. - glúten free<br />
<br />
3-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3..........................................4000 ui<br />
Vitamina K2 Mk7.........................................120mg<br />
Tomar 2 doses&nbsp; após o almoço, por 60 dias. Gluten free<br />
<br />
4-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Curcumina (Cúrcuma Longa) – 500 m<br />
Boswellia Serrata – 300 mg<br />
Magnésio Bisglicinato – 200 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.<br />
<br />
5-</span><br />
Ômega 3 - 990 de epa e 660 de DHA&nbsp; ( sugestão de marca Vita for Plus)<br />
<br />
Tomar 1 cap. 3 x ao dia . no café da manhã, no almoço e no jantar Por 90 dias', 'Ana Carolina Candia Barra', '2026-08-28 16:31:16'),
  ('04705338111', 'prescricao', '1-<br />
<br />
Camélia sinensis 200 mg<br />
Metilfolato 500 mcg<br />
Piridoxina 50 mg<br />
Grifonia simplicifólia 75 mg<br />
Metilcobalamina 200 mcg<br />
L - Theanina 200 mg<br />
Magnésio glicina 200 mg<br />
Zinco glicina 15 mg<br />
Cobre glicina 1 mg<br />
<br />
Mande 60 cápsulas.<br />
Sugestão de posologia: tomar uma dose às 10 e às 16h.<br />
<br />
2-<br />
Ácido alfa lipóico 300 mg<br />
Vitamina B5 50 mg<br />
Vitamina C 200 mg<br />
Magnésio elementar 100 mg<br />
<br />
Mande 60 cápsulas.<br />
Sugestão de posologia: tomar uma dose duas vezes ao dia, antes<br />
das refeições.<br />
<br />
3-<br />
&nbsp;<span style=&quot;font-family:courier new,courier,monospace&quot;>Di-indol metano........................................200mg<br />
crisina................................................300mg<br />
Coleus forskohlii extrato seco padronizado 10% de forskohlin200mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Consumir 1 dose , pela manhã. Por 60 dias</span><br />
<br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-08-28 16:46:03'),
  ('00813233100', 'prescricao', 'Uso tópico&nbsp;<br />
<br />
1-<br />
<br />
Sérum&nbsp; gel-creme oil free - uso noturno<br />
<br />
ácido tranexâmico - 2%<br />
Niacinamida - 4%<br />
Alfa arbutin 1 %<br />
Pantenol ( vit. B5) - 1%<br />
Alantoína - 0,2%<br />
<br />
Veículo (toque seco, não oclusivo)<br />
silicone volátil leve<br />
liver de alcool, fragrancia.<br />
<br />
Aplicar 1 pump em pele limpa e seca a noite.', 'Ana Carolina Candia Barra', '2026-08-28 17:20:51'),
  ('25520199191', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3..........................................4000 ui<br />
Vitamina K2 Mk7.........................................60mg<br />
Tomar 2 doses&nbsp; após o almoço, por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-08-28 18:14:33'),
  ('85260665104', 'prescricao', 'Uso oral<br />
<br />
1-<br />
Coentro extrato seco..................................300 mg<br />
<br />
Tomar 2 x ao dia junto a formula do colesterol, por 60 dias', 'Ana Carolina Candia Barra', '2026-08-31 10:29:10'),
  ('37392964100', 'prescricao', 'Via oral<br />
<br />
1-<br />
<br />
Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias.&nbsp;', 'Ana Carolina Candia Barra', '2026-08-31 10:33:53'),
  ('05422435710', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Interno<br />
<br />
1- Circulação e lipedema</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................450mg<br />
Rutina.................................................100mg<br />
Centella Asiatica......................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 Dose ao dia, no lanche da manhã. Por 90 dias.<br />
<br />
2- Polivitamínico</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Zinco quelado...........................................30mcg&nbsp;<br />
Selêniometionina ...................................... 200mcg<br />
Resveratrol............................................150mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 90 dias&nbsp;<br />
<br />
3-</span><br />
Ômega 3 990 de EPA e 660 de DHA ( sugestão de marac - vitafor plus)<br />
<br />
Tomar 1 dose 3 x ao dia por 90 dias.&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-08-31 12:06:21'),
  ('05422435710', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Interno<br />
<br />
1- Circulação e lipedema</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................450mg<br />
Rutina.................................................100mg<br />
Centella Asiatica......................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 Dose ao dia, no lanche da manhã. Por 90 dias.<br />
<br />
2- Polivitamínico</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Zinco quelado...........................................30mcg&nbsp;<br />
Selêniometionina ...................................... 200mcg<br />
Resveratrol............................................150mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 90 dias&nbsp;<br />
<br />
3-</span><br />
Ômega 3 990 de EPA e 660 de DHA ( sugestão de marca&nbsp;- vitafor plus)<br />
<br />
Tomar 1 dose 3 x ao dia por 90 dias.&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-08-31 12:06:56'),
  ('05422435710', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Interno<br />
<br />
1- Circulação e lipedema</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................450mg<br />
Rutina.................................................100mg<br />
Centella Asiatica......................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 Dose ao dia, no lanche da manhã. Por 90 dias.<br />
<br />
2- Polivitamínico</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Zinco quelado...........................................15mg&nbsp;<br />
Selêniometionina ...................................... 200mcg<br />
Resveratrol............................................150mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 90 dias&nbsp;<br />
<br />
3-</span><br />
Ômega 3 990 de EPA e 660 de DHA ( sugestão de marca&nbsp;- vitafor plus)<br />
<br />
Tomar 1 dose 3 x ao dia por 90 dias.&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-08-31 17:20:09'),
  ('05422435710', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso uso interno</strong></span></p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>1-</span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>2-</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 2&nbsp;gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-09-02 11:11:24'),
  ('1054502196', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Interno<br />
<br />
Para manipúlar</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>1- circulação e lipedema&nbsp;<br />
Diosmina...............................................450mg<br />
Rutina.................................................100mg<br />
Centella Asiatica......................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 Dose ao dia, no lanche da manhã. Por 60 dias.</span><br />
&nbsp;</p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>2.</strong> manutenção massa miuscular</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>&nbsp;para manipular</strong><br />
<br />
HMB 1 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p>Sabor a escolha da apciente<br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
3- <strong>Para comprar na internet</strong><br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias.&nbsp;<br />
<br />
4- Para colesterol<br />
<br />
<strong>manipulação</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Almoço e jantar&nbsp;Por 60 dias.<br />
<br />
5- melhorar a sensibilidade a insulina<br />
<br />
<strong>manipulação</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, manhã e tarde. Nos lanches, Por 60 dias.<br />
<br />
6-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;<br />
<br />
7-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3..........................................4000 ui<br />
Vitamina K2 Mk7.......................................60mg<br />
Tomar 2 doses&nbsp; após o almoço, por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-09-02 11:49:38'),
  ('76823660104', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Oral<br />
<br />
1. Para manipular</strong><br />
<br />
HMB 1 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
2- <strong>Para comprar na internet</strong><br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias.&nbsp;<br />
<br />
3- <strong>Para manipular&nbsp;<br />
Axilio no colesterolç</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>red yeast rice........................................600 mg<br />
Coentro extrato seco..................................300 mg<br />
Ácido alfa Lipóico....................................300 mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose 2 x ao dia, junto as principais refeições. Por 60 dias.<br />
<br />
4- <strong>Para manipular<br />
circulação e lipedema</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................450mg<br />
Rutina.................................................100mg<br />
Centella Asiatica......................................150mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 Dose ao dia, no lanche da manhã. Por 60 dias.<br />
<br />
5- <strong>Para manipular</strong></span><br />
<strong>Auxilia na glicemia</strong></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Glucovantage...........................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose, 2 x ao dia, no café da manhã e antes do jantar.&nbsp;<br />
<br />
6-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.<br />
<br />
7- <strong>Para manipular</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3..........................................4000 ui<br />
Vitamina K2 Mk7.........................................60mg<br />
Tomar 2 doses após o almoço, por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-09-02 17:47:37'),
  ('03322603130', 'prescricao', '<p>Solicito:</p>

<ol>
	<li><strong>Ultrassonografia transvaginal com Doppler</strong>

	<ul>
		<li>Avaliação uterina, endométrio e anexos.</li>
		<li>Avaliação da morfologia e volume ovarianos e contagem de folículos antrais, considerando desejo gestacional e histórico de irregularidade menstrual.</li>
	</ul>
	</li>
	<li><strong>Ultrassonografia das mamas bilateral</strong>
	<ul>
		<li>Avaliação mamária de rotina.</li>
	</ul>
	</li>
	<li><strong>Ultrassonografia da tireoide com Doppler</strong>
	<ul>
		<li>Avaliação da morfologia, volume, ecotextura e pesquisa de nódulos tireoidianos.</li>
	</ul>
	</li>
</ol>

<p><strong>CID-10:</strong><br />
Z31.6 – Aconselhamento geral sobre procriação<br />
N92.6 – Menstruação irregular, não especificada<br />
Z12.3 – Rastreamento para neoplasia maligna da mama<br />
Z13.29 – Rastreamento para outros transtornos endócrinos e metabólicos</p>
', 'Danielle Candia Barra', '2026-09-03 10:10:12'),
  ('03322603130', 'prescricao', '<p>Solicito:</p>

<ul>
	<li>FSH</li>
	<li>LH</li>
	<li>Estradiol</li>
	<li>Progesterona</li>
	<li>Testosterona total</li>
	<li>Testosterona livre</li>
	<li>SHBG</li>
	<li>DHEA-S</li>
	<li>Androstenediona</li>
	<li>17-OH-Progesterona</li>
	<li>Prolactina</li>
	<li>Hormônio Anti-Mülleriano (AMH)</li>
</ul>

<p><strong>Indicação:</strong> avaliação hormonal, irregularidade menstrual e planejamento gestacional.</p>

<p><strong>CID-10:</strong> N92.6 / Z31.6</p>
', 'Danielle Candia Barra', '2026-09-03 10:12:26'),
  ('03322603130', 'prescricao', '<h3>Tratamento para 90 dias.&nbsp;<br />
<br />
1. Vitamina D + K2</h3>

<p><strong>Vitamina D3 – 5.000 UI</strong><br />
<strong>Vitamina K2 MK-7 – 100 mcg</strong></p>

<p>Tomar 1 cápsula ao dia, junto a uma refeição, por 90 dias.</p>

<p>Vitamina D atual: <strong>30 ng/mL</strong>.</p>

<h3>2. Complexo metilador enxuto</h3>

<p><strong>Metilcobalamina – 1.000 mcg</strong><br />
<strong>Metilfolato – 400 mcg</strong><br />
<strong>Piridoxal-5-fosfato – 10 mg</strong></p>

<p>Tomar 1 cápsula ao dia, pela manhã, por 90 dias.<br />
<br />
<strong>3. Coenzima Q10 – 100 mg</strong><br />
<strong>N-acetilcisteína (NAC) – 600 mg</strong></p>

<p>Tomar 1 dose ao dia, preferencialmente após o almoço, por 90 dias.</p>
', 'Danielle Candia Barra', '2026-09-03 10:15:02'),
  ('84128445304', 'prescricao', '<p><strong>À Ginecologia,</strong></p>

<p>Encaminho a paciente acima para <strong>avaliação ginecológica prioritária de espessamento endometrial na pós-menopausa</strong>.</p>

<p>Paciente encontra-se na menopausa, atualmente <strong>sem terapia de reposição hormonal há aproximadamente 1 ano</strong>. Apresenta antecedente de uso de terapia hormonal, suspensa devido à ocorrência de <strong>sangramento uterino</strong>.</p>

<p>Ultrassonografia transvaginal recente evidenciou:</p>

<p><strong>Eco endometrial: 12,1 mm</strong><br />
<strong>Mioma uterino</strong></p>

<p>Laboratorialmente apresenta perfil compatível com pós-menopausa, com <strong>FSH 74,7 mUI/mL, LH 49,4 mUI/mL, estradiol &lt;5 pg/mL e progesterona &lt;0,15 ng/mL</strong>.</p>

<p>Solicito avaliação especializada do espessamento endometrial e definição da necessidade de <strong>histeroscopia diagnóstica, biópsia endometrial e/ou demais procedimentos pertinentes</strong>, visando excluir hiperplasia, pólipo ou neoplasia endometrial antes de eventual reconsideração da terapia hormonal da menopausa.</p>

<p><strong>CID-10:</strong><br />
N85.0 – Hiperplasia do endométrio / espessamento endometrial a esclarecer<br />
N95.0 – Sangramento pós-menopausa<br />
N95.1 – Estados da menopausa e do climatério feminino</p>
', 'Danielle Candia Barra', '2026-09-03 10:56:23'),
  ('84128445304', 'prescricao', '<h3>Fórmula – Suporte tireoidiano</h3>

<p><strong>Selênio (L-selenometionina) .......... 100 mcg</strong><br />
<strong>Zinco bisglicinato .......................... 15 mg</strong><br />
<strong>Mio-inositol .................................... 600 mg</strong></p>

<p>Preparar 60 doses.</p>

<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-09-03 10:57:36'),
  ('84128445304', 'prescricao', '<p><strong>Uso por 60 dias.&nbsp;<br />
<br />
1. Progesterona micronizada 100 mg</strong></p>

<p>Tomar 1 cápsula, via oral, à noite, diariamente.</p>

<p><strong>2. Estriol vaginal – baixa dose</strong></p>

<p>Estriol 0,5 mg/g – creme vaginal.</p>

<p>Aplicar <strong>1 g por via vaginal à noite, diariamente por 14 dias</strong>. Após, aplicar <strong>1 g por via vaginal 2 vezes por semana</strong>, como manutenção.</p>
', 'Danielle Candia Barra', '2026-09-03 10:59:39'),
  ('53932072120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso Interno</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Diosmina...............................................400mg<br />
Rutina.................................................100mg<br />
Centella Asiatica......................................150mg</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Di-indol metano........................................150mg<br />
crisina................................................300mg<br />
Coleus forskohlii extrato seco padronizado 10% de forskohlin 200mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Consumir 1 dose , pela manhã. Por 60 dias</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-09-03 11:03:57'),
  ('01663482799', 'prescricao', '<p>RECEITA MÉDICA</p>

<p>Paciente: Liana Costa de Almeida<br />
Idade: 60 anos</p>

<ol>
	<li>
	<p>ESTRADIOL GEL 0,5 mg/dose</p>
	</li>
</ol>

<p>Aplicar 01 dose na pele, 01 vez ao dia, preferencialmente pela manhã.</p>

<p>Aplicar em pele limpa e seca dos membros inferiores, alternando os locais de aplicação.</p>

<p>Uso contínuo.</p>

<ol start=&quot;2&quot;>
	<li>
	<p>PROGESTERONA MICRONIZADA 100 mg</p>
	</li>
</ol>

<p>Tomar 01 cápsula por via oral à noite, ao deitar.</p>

<p>Uso contínuo.</p>

<ol start=&quot;3&quot;>
	<li>
	<p>ESTRIOL VAGINAL 1 mg/g</p>
	</li>
</ol>

<p>Aplicar 0,5 g por via vaginal à noite, diariamente por 14 dias.</p>

<p>Após esse período, aplicar 0,5 g por via vaginal 2 vezes por semana, como manutenção.</p>

<p>Orientações:<br />
Reavaliar resposta clínica, padrão de sangramento e tolerabilidade ao tratamento.</p>

<p>Na ocorrência de sangramento vaginal persistente, recorrente ou de maior intensidade, realizar nova avaliação ginecológica antes de aumentar as doses hormonais.</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22.677<br />
CPF : 061.642.786-78</p>
', 'Danielle Candia Barra', '2026-09-03 11:46:07'),
  ('01663482799', 'prescricao', '<p>RECEITA</p>

<p>Paciente: Liana Costa de Almeida<br />
Idade: 60 anos</p>

<p>USO ORAL</p>

<p>FÓRMULA 1 – SUPORTE MITOCONDRIAL</p>

<p>Coenzima Q10 ............... 100 mg<br />
PQQ ........................ 10 mg<br />
Ácido alfa-lipoico ......... 100 mg</p>

<p>Tomar 01 cápsula ao dia, junto ao almoço.</p>

<p>Uso por 90 dias.</p>

<p>FÓRMULA 2 – SUPORTE CAPILAR</p>

<p>L-Cistina .................. 250 mg<br />
L-Metionina ................ 200 mg<br />
Silício orgânico ........... 100 mg<br />
Extrato de semente de uva .. 100 mg<br />
Vitamina C ................. 200 mg</p>

<p>Tomar 01 dose ao dia.</p>

<p>Uso por 90 dias.</p>

<p>Observação:<br />
Fórmulas propositalmente sem complexo B, magnésio, ferro e doses adicionais de zinco.</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-09-03 11:48:15'),
  ('01663482799', 'prescricao', '<p>PEDIDO DE EXAME DE IMAGEM</p>

<p>Paciente: Liana Costa de Almeida<br />
Idade: 60 anos</p>

<p>Solicito:</p>

<p>ULTRASSONOGRAFIA TRANSVAGINAL</p>

<p>Avaliar:</p>

<ul>
	<li>
	<p>Posicionamento do dispositivo intrauterino (DIU) na cavidade uterina;</p>
	</li>
	<li>
	<p>Relação do DIU com fundo uterino e orifício interno do colo;</p>
	</li>
	<li>
	<p>Sinais de deslocamento, penetração miometrial ou expulsão parcial;</p>
	</li>
	<li>
	<p>Espessura e aspecto do endométrio;</p>
	</li>
	<li>
	<p>Cavidade uterina;</p>
	</li>
	<li>
	<p>Miométrio;</p>
	</li>
	<li>
	<p>Ovários e anexos.</p>
	</li>
</ul>

<p>Indicação clínica: paciente pós-menopausa, em uso de DIU, apresentando sangramento uterino anormal/pós-menopausa. Avaliação do posicionamento do DIU e controle endometrial.</p>

<p>CID-10: N95.0 / Z30.5</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-09-03 11:49:10'),
  ('25471040325', 'prescricao', '<p><small>PEDIDO DE EXAME DE IMAGEM</small></p>

<p><small>Paciente: Liana Costa de Almeida<br />
Idade: 60 anos</small></p>

<p><small>Solicito:</small></p>

<p><small>ULTRASSONOGRAFIA TRANSVAGINAL</small></p>

<p><small>Avaliar:</small></p>

<ul>
	<li>
	<p><small>Posicionamento do dispositivo intrauterino (DIU) na cavidade uterina;</small></p>
	</li>
	<li>
	<p><small>Relação do DIU com fundo uterino e orifício interno do colo;</small></p>
	</li>
	<li>
	<p><small>Sinais de deslocamento, penetração miometrial ou expulsão parcial;</small></p>
	</li>
	<li>
	<p><small>Espessura e aspecto do endométrio;</small></p>
	</li>
	<li>
	<p><small>Cavidade uterina;</small></p>
	</li>
	<li>
	<p><small>Miométrio;</small></p>
	</li>
	<li>
	<p><small>Ovários e anexos.</small></p>
	</li>
</ul>

<p><small>Indicação clínica: paciente pós-menopausa, em uso de DIU, apresentando sangramento uterino anormal/pós-menopausa. Avaliação do posicionamento do DIU e controle endometrial.</small></p>

<p><small>CID-10: N95.0 / Z30.5</small></p>

<p><small>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</small></p>
<br />
&nbsp;', 'Danielle Candia Barra', '2026-09-03 11:54:25'),
  ('25471040325', 'prescricao', '<p>&nbsp;</p>

<p><small>USO ORAL</small></p>

<p><small>FÓRMULA 1 – SUPORTE MITOCONDRIAL</small></p>

<p><small>Coenzima Q10 ............... 100 mg<br />
PQQ ........................ 10 mg<br />
Ácido alfa-lipoico ......... 100 mg</small></p>

<p><small>Tomar 01 cápsula ao dia, junto ao almoço.</small></p>

<p><small>Uso por 90 dias.</small></p>

<p><small>FÓRMULA 2 – SUPORTE CAPILAR</small></p>

<p><small>L-Cistina .................. 250 mg<br />
L-Metionina ................ 200 mg<br />
Silício orgânico ........... 100 mg<br />
Extrato de semente de uva .. 100 mg<br />
Vitamina C ................. 200 mg</small></p>

<p><small>Tomar 01 dose ao dia.</small></p>

<p><small>Uso por 90 dias.</small></p>

<p><small>Observação:<br />
Fórmulas propositalmente sem complexo B, magnésio, ferro e doses adicionais de zinco.</small></p>

<p><small>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</small></p>
<br />
&nbsp;', 'Danielle Candia Barra', '2026-09-03 11:54:56'),
  ('25471040325', 'prescricao', '<p>&nbsp;</p>

<p><small>RECEITA MÉDICA</small></p>

<p><small>Paciente: Liana Costa de Almeida<br />
Idade: 60 anos</small></p>

<ol>
	<li>
	<p><small>ESTRADIOL GEL 0,5 mg/dose</small></p>
	</li>
</ol>

<p><small>Aplicar 01 dose na pele, 01 vez ao dia, preferencialmente pela manhã.</small></p>

<p><small>Aplicar em pele limpa e seca dos membros inferiores, alternando os locais de aplicação.</small></p>

<p><small>Uso contínuo.</small></p>

<ol start=&quot;2&quot;>
	<li>
	<p><small>PROGESTERONA MICRONIZADA 100 mg</small></p>
	</li>
</ol>

<p><small>Tomar 01 cápsula por via oral à noite, ao deitar.</small></p>

<p><small>Uso contínuo.</small></p>

<ol start=&quot;3&quot;>
	<li>
	<p><small>ESTRIOL VAGINAL 1 mg/g</small></p>
	</li>
</ol>

<p><small>Aplicar 0,5 g por via vaginal à noite, diariamente por 14 dias.</small></p>

<p><small>Após esse período, aplicar 0,5 g por via vaginal 2 vezes por semana, como manutenção.</small></p>

<p><small>Orientações:<br />
Reavaliar resposta clínica, padrão de sangramento e tolerabilidade ao tratamento.</small></p>

<p><small>Na ocorrência de sangramento vaginal persistente, recorrente ou de maior intensidade, realizar nova avaliação ginecológica antes de aumentar as doses hormonais.</small></p>

<p><small>Dra. Danielle Candia Barra<br />
CRM-DF 22.677<br />
CPF : 061.642.786-78</small></p>
', 'Danielle Candia Barra', '2026-09-03 11:55:24'),
  ('82006571753', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-family:courier new,courier,monospace&quot;>Lactobacillus paracasei.......... 1 BI<br />
Lactobacillus Acidophilus........ 1 BI<br />
Lactobacillus Rhamnosus........... 1 BI<br />
Lactobacillus salivarius ..........1 BI<br />
Lactobacillus reuteri..............1 BI<br />
Lactobacillus delbruecki...........1 BI<br />
Bifidubact. Brevis................ 1 BI<br />
Bifidubact. lactis.................1 BI<br />
Inulina ........................... 3g<br />
Glutamina...........................5g<br />
<br />
Sabor a escolha do paciente&nbsp;<br />
mande 60 envelopes, tomar 1 dose antes de dormir, por 60 dias. (Após detox intestinal)<br />
<br />
3-<br />
NADH 5 mg<br />
Silimarina 300 mg<br />
Selênio Glicina 200 mcg<br />
Vitamina B12 200 mcg<br />
Zinco quedado (Albion) 15 mg<br />
Vitamina E 200 UI<br />
L Glutationa 15 mg<br />
N Acetil Cisteína 500 mg<br />
Vitamina B6 50 mg<br />
Quercetina 100 mg<br />
Mande 60 cápsulas.<br />
<br />
tomar uma cápsula após o desjejum e uma<br />
cápsula após o jantar.</span></span><br />
<br />
<strong>OBS: Paciente com alergia a Látex, tomar todos os cuidados para não haver contaminação quando aplicável.</strong>', 'Ana Carolina Candia Barra', '2026-09-04 17:15:06'),
  ('21639183191', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Curcumina (Cúrcuma Longa) – 500 mg<br />
Boswellia Serrata – 300 mg<br />
L-Teanina – 100 mg<br />
Zinco Quelado – 15 mg<br />
vitamina C ( acido ascorbico) 500mg<br />
<br />
Mande em caps. glúten free Tomar após o jantar. Por 60 dias.</span>
<p><span style=&quot;font-family:courier new,courier,monospace&quot;>2-</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês. sabor a escolha da paciente.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
3-</span><br />
&nbsp;</p>

<h2><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Compra pela internet</span></span></h2>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>4-</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>L-Metilfolato de&nbsp;Cálcio -&nbsp;</span><span style=&quot;font-size:12px&quot;><strong>Vitamina B9 na forma ativa ( marca Yosen)</strong></span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>5-</strong></span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Vitamina B12 Ydrosolv® 30ml ( marca Yosen ) -</span><span style=&quot;font-size:12px&quot;>&nbsp;<strong>Vitamina B12&nbsp;na Forma Ativa- Metilcobalamina.&nbsp;</strong></span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:12px&quot;><strong>Tomar 1 gota sunblingual, manter o máx. de tempo embaixo da lingua, 1 x ao dia. no café da manhã.</strong></span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>6-<br />
<br />
<span style=&quot;font-size:14px&quot;>ômega 3 - 990 de EPA e 660 de DHA</span><span style=&quot;font-size:14px&quot;>&nbsp; - ( marca Vitafor Plus)</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><span style=&quot;font-size:14px&quot;>Tomar 1 cap. 2&nbsp;x ao dia - &nbsp;almoço e jantar. Por 60 dias<br />
<br />
7- manipular</span></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> Vitamina D3..........................................4000 ui<br />
Vitamina K2 Mk7.......................................75mg<br />
Tomar 2 doses&nbsp; após o almoço, por 60 dias.&nbsp;<br />
<br />
8-<br />
Magnésio bisglicinato 400mg<br />
Taurina 500mg<br />
Potássio citrato 200mg<br />
Colágeno tipo 1 e 2 - 10g<br />
<br />
Sabor a escolha da paciente.<br />
Tomar 1 sache 1 x ao dia a noite. por 60 dias</span>', 'Ana Carolina Candia Barra', '2026-09-05 09:02:57'),
  ('01801944105', 'prescricao', '<p><strong>Exame solicitado:</strong><br />
<strong>Ultrassonografia transvaginal com preparo intestinal para mapeamento de endometriose profunda</strong></p>

<p>Solicito avaliação direcionada para pesquisa/mapeamento de endometriose, incluindo compartimentos anterior e posterior da pelve, mobilidade dos órgãos pélvicos e pesquisa de comprometimento ovariano, uterino, retrocervical, ligamentos uterossacros, septo retovaginal, fórnices vaginais, bexiga, ureteres e segmentos intestinais acessíveis ao método.</p>

<p><strong>Indicação:</strong> rastreamento/investigação de endometriose.</p>
', 'Danielle Candia Barra', '2026-09-10 09:54:49'),
  ('01801944105', 'prescricao', '<p><strong>EXAME SOLICITADO</strong></p>

<p><strong>Painel A200 – pesquisa de reatividade alimentar para 200 alimentos</strong></p>

<p><strong>Indicação clínica:</strong> investigação complementar de possíveis reações alimentares, diante de quadro crônico de manifestações cutâneas e orais associado a sintomas relacionados à ingestão de determinados alimentos.</p>
', 'Danielle Candia Barra', '2026-09-10 09:56:04'),
  ('01801944105', 'prescricao', '<p>Solicito:</p>

<ul>
	<li><strong>IgE total</strong></li>
	<li><strong>D1</strong> – <em>Dermatophagoides pteronyssinus</em></li>
	<li><strong>D2</strong> – <em>Dermatophagoides farinae</em></li>
	<li><strong>D201</strong> – <em>Blomia tropicalis</em></li>
	<li><strong>D70</strong> – <em>Acarus siro</em></li>
	<li><strong>D3</strong> – <em>Dermatophagoides microceras</em></li>
	<li><strong>HX2</strong> – Mix para poeira domiciliar</li>
	<li><strong>MX1</strong> – Mix para fungos ambientais</li>
	<li><strong>GX2</strong> – Mix para pólens de gramíneas</li>
	<li><strong>EX1</strong> – Mix para epitélios de animais</li>
	<li><strong>E1</strong> – Epitélio de gato</li>
	<li><strong>E5</strong> – Epitélio/caspa de cão</li>
	<li><strong>I6</strong> – Barata doméstica</li>
</ul>

<p><strong>Indicação clínica:</strong> rinite alérgica e sintomas respiratórios recorrentes; investigação de sensibilização a aeroalérgenos.</p>
', 'Danielle Candia Barra', '2026-09-10 10:05:12'),
  ('01801944105', 'prescricao', '<h3>1. Ferro – reserva de ferro</h3>

<p><strong>Ferro bisglicinato (ferro elementar) ........ 30 mg</strong><br />
<strong>Vitamina C ............................................... 200 mg</strong></p>

<p>Tomar 1 cápsula ao dia, preferencialmente afastada de café, chá, laticínios, cálcio e zinco.</p>

<h3>2. Metilação + zinco</h3>

<p><strong>Metilcobalamina ................................ 500 mcg</strong><br />
<strong>Metilfolato ........................................ 400 mcg</strong><br />
<strong>Piridoxal-5-fosfato ............................ 10 mg</strong><br />
<strong>Riboflavina-5-fosfato .......................... 10 mg</strong><br />
<strong>Zinco bisglicinato (Zn elementar) ........ 15 mg</strong></p>

<p>Tomar 1 cápsula ao dia após o almoço.</p>

<h3>3. Quercetina – suporte ao terreno alérgico</h3>

<p><strong>Quercetina ......................................... 500 mg</strong><br />
<strong>Vitamina C .......................................... 250 mg</strong></p>

<p>Tomar 1 cápsula ao dia. A quercetina pode ser usada como <strong>adjuvante</strong>, mas eu não a colocaria como substituta da investigação/tratamento alergológico.</p>

<h3>4. Vitamina D3 + K2</h3>

<p><strong>Vitamina D3 ..................................... 6.000 UI</strong><br />
<strong>Vitamina K2 MK-7 ............................. 100 mcg</strong></p>

<p>Tomar 1 cápsula ao dia junto a uma refeição contendo gordura.</p>

<p>Eu <strong>não colocaria selênio automaticamente</strong> apenas pelo valor informado de 58 sem conferir <strong>unidade e referência do laboratório</strong>. Selênio tem janela terapêutica relativamente estreita e excesso crônico também é indesejável. O magnésio eritrocitário, por outro lado, está adequado (<strong>50,06 mg/L; VR 37,67–63,68</strong>), então não vejo necessidade laboratorial clara de aumentá-lo apenas por esse exame.</p>
', 'Danielle Candia Barra', '2026-09-10 10:14:34'),
  ('01801944105', 'prescricao', '<h3>Receita – Metilcobalamina IM</h3>

<p><strong>Paciente:</strong> Luciana de Carvalho Lobão Barroso, 33 anos</p>

<p><strong>Metilcobalamina 1.000 mcg/1 mL – solução injetável</strong></p>

<p>Aplicar <strong>1 mL por via intramuscular, dose única</strong>.</p>

<p><strong>Quantidade:</strong> 01 ampola.</p>
', 'Danielle Candia Barra', '2026-09-10 10:16:15'),
  ('01692484109', 'prescricao', '<p><strong>EDIDO DE EXAMES LABORATORIAIS – SEGUIMENTO</strong></p>

<p><strong>Paciente:</strong> Kelly da Silva Matos</p>

<p><strong>Metabólico / cardiovascular</strong></p>

<ul>
	<li>Hemograma completo</li>
	<li>Ferritina</li>
	<li>Glicemia de jejum</li>
	<li>Insulina de jejum</li>
	<li>Hemoglobina glicada</li>
	<li>Colesterol total e frações</li>
	<li>Triglicerídeos</li>
	<li>Apolipoproteína A1 (ApoA1)</li>
	<li>Apolipoproteína B (ApoB)</li>
	<li>Lipoproteína(a) – se ainda não realizada</li>
</ul>

<p><strong>Função hepática e renal</strong></p>

<ul>
	<li>TGO (AST)</li>
	<li>TGP (ALT)</li>
	<li>GGT</li>
	<li>Creatinina com TFG estimada</li>
	<li>Ureia</li>
</ul>

<p><strong>Hormonal</strong></p>

<ul>
	<li>TSH</li>
	<li>T4 livre</li>
	<li>Estradiol</li>
	<li>Progesterona</li>
	<li>Testosterona total</li>
	<li>Testosterona livre</li>
	<li>SHBG</li>
	<li>DHEA-S</li>
	<li>Prolactina</li>
</ul>

<p><strong>Micronutrientes</strong></p>

<ul>
	<li>25-OH vitamina D</li>
	<li>Vitamina B12</li>
</ul>

<p><strong>Observação:</strong> pela ocorrência de dois escapes menstruais no mês, manter também <strong>USG transvaginal com avaliação do endométrio</strong> caso ainda não tenha sido realizado.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677<br />
<strong>Nutróloga</strong></p>
', 'Danielle Candia Barra', '2026-09-10 10:43:04'),
  ('01692484109', 'prescricao', '<p>RECEITA MÉDICA</p>

<p>Paciente: Kelly da Silva Matos</p>

<p>USO SUBCUTÂNEO</p>

<p>MOUNJARO® (tirzepatida) 2,5 mg/0,5 mL</p>

<p>Aplicar 2,5 mg por via subcutânea a cada 21 dias (03 semanas).</p>

<p>Uso conforme acompanhamento médico, em estratégia de espaçamento/desmame.</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22677<br />
Nutróloga</p>
', 'Danielle Candia Barra', '2026-09-10 10:44:31'),
  ('01692484109', 'prescricao', '<p><strong>USO SUBCUTÂNEO</strong></p>

<p><strong>Tirzepatida 60 mg / 2,4 mL</strong><br />
Concentração: 25 mg/mL</p>

<p>Aplicar <strong>0,05 mL (equivalente a 1,25 mg)</strong> por via subcutânea <strong>a cada 15 dias</strong>.</p>

<p>Uso conforme orientação e acompanhamento médico.</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677<br />
<strong>Nutróloga</strong></p>
', 'Danielle Candia Barra', '2026-09-10 10:45:55'),
  ('01692484109', 'prescricao', '<p>Solicito:</p>

<ol>
	<li><strong>Ultrassonografia das mamas bilateral</strong>

	<ul>
		<li>Avaliação mamária de rotina/rastreamento complementar.</li>
	</ul>
	</li>
	<li><strong>Ultrassonografia transvaginal</strong>
	<ul>
		<li>Avaliação de útero, endométrio e ovários.</li>
		<li>Atenção à espessura e aspecto endometrial.</li>
		<li>Indicação: irregularidade menstrual/episódios de sangramento de escape.</li>
	</ul>
	</li>
	<li><strong>Ultrassonografia de abdome total</strong>
	<ul>
		<li>Avaliação de fígado, vesícula e vias biliares, pâncreas, baço, rins, bexiga e demais estruturas acessíveis ao método.</li>
	</ul>
	</li>
	<li><strong>Ultrassonografia de tireoide com Doppler</strong>
	<ul>
		<li>Avaliação morfológica, volumétrica, nodular e vascularização da tireoide.</li>
	</ul>
	</li>
	<li><strong>Eco-Doppler venoso colorido de membros inferiores bilateral</strong>
	<ul>
		<li>Avaliação dos sistemas venosos superficial e profundo.</li>
		<li>Pesquisa de insuficiência venosa/refluxo e alterações vasculares.</li>
		<li>Indicação: edema e dor em membros inferiores.</li>
	</ul>
	</li>
</ol>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677<br />
<strong>Nutróloga</strong></p>
', 'Danielle Candia Barra', '2026-09-10 10:48:19'),
  ('01663482799', 'prescricao', '<h3>Fórmula 1 – Suporte muscular e energético – 120 dias</h3>

<p><strong>Coenzima Q10</strong> 150 mg<br />
<strong>Magnésio bisglicinato</strong> q.s. para fornecer 200 mg de magnésio elementar<br />
<strong>Riboflavina (B2)</strong> 10 mg<br />
<strong>Piridoxal-5-fosfato (B6 ativa)</strong> 10 mg<br />
<strong>Metilcobalamina</strong> 500 mcg<br />
<strong>Metilfolato</strong> 400 mcg</p>

<p>Tomar <strong>1 dose ao dia pela manhã</strong>, após alimentação.<br />
<br />
&nbsp;</p>

<h3>2) Vitamina D + K2 – manutenção</h3>

<p><strong>Vitamina D3.000 UI</strong><br />
<strong>Vitamina K2 MK-7 100 mcg</strong><br />
<br />
Tomar <strong>1 dose ao dia</strong>, com refeição.<br />
<br />
<br />
3)<strong>Magnésio bisglicinato</strong> q.s. para 100 mg de magnésio elementar<br />
<strong>L-teanina</strong> 200 mg<br />
<strong>Glicina</strong> 1.000 mg<br />
<strong>Melatonina</strong>&nbsp;1&nbsp;mg</p>

<p>Tomar <strong>1 dose 30–60 minutos antes de dormir</strong>.</p>
', 'Danielle Candia Barra', '2026-09-10 11:43:10'),
  ('01663482799', 'prescricao', '<p><strong>Wegovy® (semaglutida) 2,4 mg/0,75 mL – caneta preenchida</strong></p>

<p><strong>Aplicar 46&nbsp;cliques por via subcutânea, 1 vez por semana, sempre no mesmo dia da semana.</strong></p>

<hr />
<h2>Orientações</h2>

<p>Aplicar no abdome, coxa ou braço, alternando os locais de aplicação.</p>

<p>Manter a caneta refrigerada entre&nbsp;<strong>2°C e 8°C</strong>.</p>

<p>Não congelar.</p>

<p>Caso esqueça uma dose, administrar em até&nbsp;<strong>5 dias</strong>. Após esse período, pular a dose esquecida e manter o esquema habitual.</p>

<hr />
<p><strong>Quantidade:</strong>&nbsp;01 (uma) caneta (ou conforme necessidade para o período do tratamento).</p>
', 'Danielle Candia Barra', '2026-09-10 11:45:18'),
  ('01663482799', 'prescricao', '<p><strong>ATESTADO DE COMPARECIMENTO</strong><br />
<br />
&nbsp;</p>

<p>Atesto, para os devidos fins, que a paciente <strong>Daniela Francescutti Martins Hott</strong>, CPF <strong>016.634.827-99</strong>, compareceu a atendimento médico na presente data, necessitando de afastamento de suas atividades durante o <strong>período matutino</strong>.<br />
<br />
<br />
&nbsp;</p>

<p><strong>Brasília-DF, 10 de setembro de 2026.</strong></p>
', 'Danielle Candia Barra', '2026-09-10 11:52:01'),
  ('43882773120', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>1.</strong> manutenção massa miuscular&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>para manipular<br />
<br />
HMB 1 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p>sabor a escolha da paciente<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.<br />
<br />
2- Para comprar na internet ( colágeno)&nbsp;<br />
<br />
collagene derma b health - 300 g&nbsp;<br />
tomar por 60 dias.&nbsp;<br />
<br />
tomar 1 dose ( 2 scoops) após o treino no café da manhã. ou antes de dormir.<br />
<br />
3-<br />
Whey protein isolado.&nbsp;<br />
sabor a escolha da paciente.<br />
<br />
Tomar 1 dose, 1 x ao dia no lanche&nbsp;<br />
<br />
<br />
&nbsp;</span></p>

<p>&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-09-11 09:36:51'),
  ('53698258153', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso interno<br />
<br />
1-</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Protease...............................................100mg<br />
Amilase.................................................50mg<br />
Papaína................................................100mg<br />
Bromelina...............................................50mg<br />
Lipase..................................................50mg<br />
Pepsina.................................................25mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Mande&nbsp;cápsulas gastrorresistente.<br />
Tomar uma dose logo antes das duas principais refeições do dia. Por 60 dias<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>PEG 4000.................................................... 1 pote 500g</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose ( 60g) 1 x ao dia, de manhã ou a noite diluído em 1&nbsp;copo d''àgua.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>OBS: A dose depende a atividade intestinal, podendo aumentar ou reduzir a dose conforme o funcionamento intestinal.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-09-15 10:26:50'),
  ('01169196128', 'prescricao', '<h3>PEDIDO DE EXAMES DE IMAGEM</h3>

<p><strong>Paciente:</strong> Lorraine Ardila Geness de Freitas</p>

<p><strong>Data:</strong> 15/09/2026</p>

<p><strong>CID-10:</strong></p>
&nbsp;

<ul>
	<li>N96 – Abortamento habitual</li>
	<li>E22.1 – Hiperprolactinemia</li>
	<li>D35.2 – Adenoma benigno da hipófise</li>
	<li>E88.81 – Resistência à insulina</li>
</ul>

<hr />
<h3>Solicito:</h3>

<p><strong>1. Ultrassonografia Transvaginal com Doppler, contagem de folículos</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Avaliação uterina e ovariana.</li>
	<li>Pesquisa de miomas, pólipos, adenomiose e malformações uterinas.</li>
	<li>Avaliação da espessura e aspecto do endométrio.</li>
	<li>Pesquisa de endometriose (quando possível).</li>
	<li>Contagem de folículos antrais.</li>
	<li>Avaliação da vascularização uterina e ovariana.</li>
</ul>

<hr />
<p><strong>2. Ultrassonografia de Abdome Total</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Avaliação hepática (esteatose e outras alterações).</li>
	<li>Vesícula biliar e vias biliares.</li>
	<li>Pâncreas.</li>
	<li>Baço.</li>
	<li>Rins e vias urinárias.</li>
	<li>Aorta abdominal.</li>
	<li>Pesquisa de alterações metabólicas associadas à resistência insulínica e avaliação geral dos órgãos abdominais.</li>
</ul>

<hr />
<p><strong>3. Ultrassonografia da Tireoide com Doppler</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Avaliação morfológica da glândula.</li>
	<li>Pesquisa de nódulos.</li>
	<li>Avaliação da vascularização.</li>
	<li>Investigação de doença tireoidiana autoimune.</li>
</ul>

<hr />
<p><strong>4. Ultrassonografia das Mamas Bilateral</strong></p>

<p><strong>Objetivo:</strong></p>

<ul>
	<li>Rastreamento mamário.</li>
	<li>Avaliação de nódulos, cistos e demais alterações estruturais.</li>
</ul>

<hr />
<p><strong>Justificativa clínica:</strong></p>

<p>Paciente de 40 anos com infertilidade secundária, dois abortamentos espontâneos, microadenoma hipofisário com hiperprolactinemia em tratamento, resistência à insulina, variante <strong>MTHFR C677T em homozigose</strong>, irregularidade menstrual e planejamento gestacional. Solicito avaliação ultrassonográfica para investigação de possíveis causas estruturais ginecológicas, tireoidianas e alterações metabólicas associadas, visando otimização do preparo pré-concepcional.</p>
', 'Ana Carolina Candia Barra', '2026-09-15 10:56:14'),
  ('06089932639', 'prescricao', '<p>PEDIDO DE EXAMES LABORATORIAIS - SEGUIMENTO</p>

<p>Paciente: Helena Bastos Lanna<br />
Data de nascimento: 03/06/2018</p>

<p>Solicito:</p>

<p>Hemograma completo<br />
Ferritina</p>

<p>Glicemia de jejum<br />
Insulina de jejum<br />
Hemoglobina glicada</p>

<p>Colesterol total<br />
HDL colesterol<br />
LDL colesterol<br />
Triglicerídeos</p>

<p>TGO (AST)<br />
TGP (ALT)<br />
Gama GT</p>

<p>Ureia<br />
Creatinina<br />
Ácido úrico</p>

<p>TSH<br />
T4 livre<br />
Anti-TPO<br />
Antitireoglobulina (Anti-Tg)</p>

<p>25-OH vitamina D<br />
Cálcio total<br />
Fósforo<br />
Magnésio<br />
PTH</p>

<p>PCR ultrassensível</p>

<p>Brasília, 17/09/2026</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-09-17 09:30:19'),
  ('06089932639', 'prescricao', '<p>PEDIDO DE EXAMES LABORATORIAIS - SEGUIMENTO</p>

<p>Paciente: Helena Bastos Lanna<br />
Data de nascimento: 03/06/2018</p>

<p>Solicito:</p>

<p>Hemograma completo<br />
Ferritina</p>

<p>Glicemia de jejum<br />
Insulina de jejum<br />
Hemoglobina glicada</p>

<p>Colesterol total<br />
HDL colesterol<br />
LDL colesterol<br />
Triglicerídeos</p>

<p>TGO (AST)<br />
TGP (ALT)<br />
Gama GT</p>

<p>Ureia<br />
Creatinina<br />
Ácido úrico</p>

<p>TSH<br />
T4 livre<br />
Anti-TPO<br />
Antitireoglobulina (Anti-Tg)</p>

<p>25-OH vitamina D<br />
Cálcio total<br />
Fósforo<br />
Magnésio<br />
PTH</p>

<p>PCR ultrassensível</p>

<p>Brasília, 17/09/2026</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-09-17 09:30:26'),
  ('06089932639', 'prescricao', '<p>PERFIL HORMONAL - AVALIAÇÃO PUBERAL</p>

<p>LH basal - método ultrassensível<br />
FSH<br />
Estradiol - método ultrassensível</p>

<p>DHEA-S<br />
Androstenediona<br />
Testosterona total</p>

<p>17-OH-progesterona</p>

<p>IGF-1<br />
IGFBP-3</p>
', 'Danielle Candia Barra', '2026-09-17 09:50:33'),
  ('06089932639', 'prescricao', '<p>PERFIL HORMONAL - AVALIAÇÃO PUBERAL</p>

<p>LH basal - método ultrassensível<br />
FSH<br />
Estradiol - método ultrassensível</p>

<p>DHEA-S<br />
Androstenediona<br />
Testosterona total</p>

<p>17-OH-progesterona</p>

<p>IGF-1<br />
IGFBP-3</p>
', 'Danielle Candia Barra', '2026-09-17 09:50:36'),
  ('53103335253', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>Uso oral<br />
<br />
1-</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias (pré crio)<br />
<br />
2-</span><br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Sinensis........................................200mg<br />
Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias. ( pós procedimento de criomodelagem)</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-09-21 16:00:35'),
  ('04587810886', 'prescricao', 'para manipulação<br />
<br />
uso oral<br />
<br />
1-<br />
Boswellia serata 50 mg<br />
(extrato seco padronizado 20% de AKBA)<br />
Quercitina 400 mg<br />
Vitamina C 250 mg<br />
Tocotrimax 150 mg<br />
N-Acetil- cisteina 150 mg<br />
Zinco quelato 20 mg<br />
Mande 120 doses.<br />
Tomar uma dose duas vezes ao dia. Por 60 dias<br />
<br />
2-<br />
L-Glutamina 10 g<br />
N-Acetil-D-glucosamina 500 mg<br />
Mande 60 sachês.<br />
Tomar um sachê ao dia.<br />
<br />
3-<br />
Protease 50 mg<br />
Amilase 50 mg<br />
Lipase 50 mg<br />
Pancreatina 150 mg<br />
Papaína 150 mg<br />
Bromelina 50 mg<br />
Pepsina 25 mg<br />
Mande 120 cápsulas gastrorresistente.<br />
Tomar uma dose duas vezes ao dia, junto<br />
das principais refeições. Por 60 dias<br />
<br />
4-<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Bacopa monnieri extrato padronizado 20% bacosídeos.....300mg<br />
Ginkgo biloba extrato padronizado 24% flavonoides / 6% terpenoides120mg<br />
Vitamina B1 (benfotiamina)............................150 mg<br />
Tomar 1 x ao dia, no café da manhã por 60 dias.&nbsp;</span>

<p>5-</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Rhodiola rosea extrato padronizado (3% rosavinas / 1% salidrosídeo)150mg<br />
Withania somnifera (Ashwagandha KSM-66)................300mg<br />
Magnolia officinalis extrato padronizado...............200mg<br />
Crocus sativus extrato padronizado 2% safranal..........30mg<br />
L-teanina..............................................200mg<br />
Magnésio bisglicinato elementar........................150mg<br />
Vitamina B6 (P-5-P).....................................25mg<br />
Complexo B (B1 – 10 mg, B2 – 10 mg, B3 – 20 mg, B5 – 50 mg, B7 – 300 mcg, B9 – 400 mcg, B12 metilcobalamina – 500 mcg)<br />
1 dose&nbsp; pela manhã por volta de 9:00 + 1 dose a tarde as 16:00, <strong>após refeições.&nbsp; por 60 dias.<br />
<br />
6-</strong></span><br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Picolinato de cromo....................................200mg<br />
Biotina..................................................1mg<br />
magnesio quelato.......................................100mg<br />
selênio quelato........................................25mcg<br />
manganês glicina........................................10mg<br />
zinco glicina...........................................25mg<br />
cobre quelato............................................1mg<br />
green tea..............................................100mg<br />
pomegranate............................................200mg<br />
picnogenol..............................................30mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar uma dose, junto ao almoço e jantar por 60 dias.&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-09-21 17:55:18'),
  ('87474808153', 'prescricao', 'Intra muscular&nbsp;<br />
<br />
1 - Metilcobalamina 2500mcg - 1 ml<br />
Dose única&nbsp;<br />
<br />
2- Vitamina D3 300.000 ui - 1 ml<br />
Dose única&nbsp;<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-09-22 12:37:06'),
  ('87474808153', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
<br />
Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio...............................................100mg<br />
Resveratrol............................................100mg<br />
Piperina.................................................5mg<br />
NAC....................................................300mg<br />
Vit B3..................................................30mg<br />
Vit. B1...............................................1,2 mg<br />
B2......................................................10mg<br />
B6......................................................10mg<br />
Ac. Pantotenico.........................................20mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias (pré crio)<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span><span style=&quot;font-family:courier new,courier,monospace&quot;>Citrus Sinensis........................................200mg<br />
Citrus Aurantium.......................................200mg<br />
Garcínia...............................................200mg<br />
Gymnema.................................................50mg<br />
Forskolina..............................................80mg<br />
Quercetina.............................................100mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose. 30min, antes do almoço e do jantar, por 60 dias. ( pós procedimento de criomodelagem)<br />
<br />
3-</span><br />
<br />
Ômega 3 - 990 EPA e 660 de DHA&nbsp; ( Vita For Plus)<br />
Tomar 1 dose 3 x ao dia, café da manhã, almoço e jantar.&nbsp;<br />
<br />
4-<br />
<br />
&nbsp;</p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral</strong></span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Vitamina D3..........................................4000 ui<br />
Vitamina K2 Mk7.........................................70mg<br />
gotas sublingual&nbsp;<br />
Tomar 2 doses&nbsp; após o almoço, por 60 dias.&nbsp;</span>', 'Ana Carolina Candia Barra', '2026-09-22 12:38:32'),
  ('01169196128', 'prescricao', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;><strong>Uso oral<br />
<br />
1- para manipular</strong></span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>HMB 1 g<br />
Creatina 4 g<br />
D-Ribose 10 g<br />
BCAA (L-leucina, L-isoleucina, L-valina) 2:1:1 5 g</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>sabor a escolha da pacinte&nbsp;</span><br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Mande 60 sachês.<br />
Sugestão de posologia: tomar uma dose ao dia, uma hora antes dos<br />
treinos, diluído em 250 mL de água.</span><br />
<br />
2- compra na internet<br />
<br />
<span style=&quot;font-family:courier new,courier,monospace&quot;>Collagene Derma – 300g<br />
Tomar 2 scoops 1 x ao dia, de manhã ou a noite&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-23 16:44:26'),
  ('83206540330', 'prescricao', '<h1>PRESCRIÇÃO – FÓRMULAS MANIPULADAS</h1>

<p><strong>Paciente:</strong> Isaac Abrahão de Oliveira Simões<br />
<strong>Dra. Danielle Candia Barra – CRM-DF 22.677</strong></p>

<h2>1. COMPLEXO METILADOR – 90 dias</h2>

<p>Metilfolato (5-MTHF) ................. <strong>800 mcg</strong><br />
Metilcobalamina ....................... <strong>1.000 mcg</strong><br />
Riboflavina-5-fosfato ................. <strong>10 mg</strong><br />
Piridoxal-5-fosfato (P5P) ............ <strong>10 mg</strong><br />
Benfotiamina .......................... <strong>100 mg</strong><br />
Niacinamida ........................... <strong>50 mg</strong><br />
Pantotenato de cálcio ................. <strong>100 mg</strong><br />
TMG (betaína anidra) .................. <strong>500 mg</strong></p>

<p>Preparar 90 doses.</p>

<p><strong>Posologia:</strong> tomar 1 dose pela manhã, após o café da manhã.</p>

<p>&nbsp;</p>

<hr />
<h2>2. VITAMINA D + K2 – 90 dias</h2>

<p>Vitamina D3 ........................... 7<strong>.000 UI</strong><br />
Vitamina K2 MK-7 ...................... <strong>100 mcg</strong></p>

<p>Excipiente lipossolúvel q.s.p. 1 cápsula.</p>

<p>Preparar 90 cápsulas.</p>

<p><strong>Posologia:</strong> tomar 1 cápsula ao dia junto à principal refeição contendo gordura.</p>

<hr />
<h2>3. SUPORTE ANTIOXIDANTE / MICRONUTRIENTES – 90 dias ( Opcional !!)&nbsp;</h2>

<p>Vitamina C tamponada .................. <strong>500 mg</strong><br />
Zinco bisglicinato .................... <strong>15 mg</strong><br />
Cobre bisglicinato .................... <strong>1 mg</strong></p>

<p>Preparar 90 doses.</p>

<p><strong>Posologia:</strong> tomar 1 dose ao dia após o almoço.</p>

<hr />
<h2>4. FITOTERÁPICO – SUPORTE MASCULINO – 60 dias</h2>

<p>Ashwagandha extrato padronizado ........ <strong>300 mg</strong><br />
Eurycoma longifolia extrato padronizado (Tongkat Ali) ... <strong>200 mg</strong><br />
Feno-grego extrato padronizado ......... <strong>500 mg</strong><br />
Boro ................................... <strong>3 mg</strong></p>

<p>Preparar 90 doses.</p>

<p><strong>Posologia:</strong> tomar 1 dose pela manhã.</p>

<p><strong>Observação:</strong> reavaliar sintomas, testosterona total, SHBG e testosterona livre após o período. Não associar outra fórmula contendo ashwagandha.</p>

<hr />
<h2>5. FÓRMULA NOTURNA – SONO E RECUPERAÇÃO – 90 dias</h2>

<p>Magnésio bisglicinato q.s. para fornecer <strong>100 mg de magnésio elementar</strong><br />
L-teanina .............................. <strong>200 mg</strong><br />
Glicina ................................ <strong>1.000 mg</strong><br />
Taurina ................................ <strong>500 mg</strong><br />
Mio-inositol ........................... <strong>1.000 mg</strong><br />
Melatonina ............................. <strong>0,5 mg</strong></p>

<p>Preparar 60 doses em sachês ou quantidade de cápsulas suficiente para comportar a dose.</p>

<p><strong>Posologia:</strong> tomar 1 dose de 30 a 60 minutos antes de dormir.</p>

<h3>&nbsp;</h3>

<p><strong>Dra. Danielle Candia Barra</strong><br />
<strong>CRM-DF 22.677</strong></p>
', 'Danielle Candia Barra', '2026-09-24 10:43:11'),
  ('03322603130', 'prescricao', '<br />
<ol>
	<li><strong>Ultrassonografia das mamas bilateral</strong>
	<ul>
		<li>Avaliação mamária de rotina.</li>
	</ul>
	</li>
</ol>

<p><br />
<br />
<strong>CID-10:</strong><br />
Z31.6 – Aconselhamento geral sobre procriação<br />
N92.6 – Menstruação irregular, não especificada<br />
Z12.3 – Rastreamento para neoplasia maligna da mama<br />
Z13.29 – Rastreamento para outros transtornos endócrinos e metabólicos</p>
', 'Danielle Candia Barra', '2026-09-24 11:10:28'),
  ('03322603130', 'prescricao', '&nbsp;
<ol>
	<li><strong>Ultrassonografia da tireoide com Doppler</strong>
	<ul>
		<li>Avaliação da morfologia, volume, ecotextura e pesquisa de nódulos tireoidianos.</li>
	</ul>
	</li>
</ol>

<p><strong>CID-10:</strong><br />
Z31.6 – Aconselhamento geral sobre procriação<br />
N92.6 – Menstruação irregular, não especificada<br />
Z12.3 – Rastreamento para neoplasia maligna da mama<br />
Z13.29 – Rastreamento para outros transtornos endócrinos e metabólicos</p>
', 'Danielle Candia Barra', '2026-09-24 11:10:54'),
  ('03322603130', 'prescricao', '<br />
Solicito:<br />
<br />
RESSONANCIA MAGNETICA DE PELVE<br />
Avaliar utero, endometrio, ovarios e anexos, com atencao para alteracoes estruturais pelvicas e<br />
sinais de endometriose/adenomiose, conforme protocolo do servico.<br />
<br />
<br />
Indicacao clinica: ciclos menstruais irregulares e planejamento gestacional.<br />
<br />
<br />
CID-10: N92.6 / Z31.6<br />
<br />
<br />
<br />
<br />
____________________________________________<br />
Dra. Danielle Candia Barra<br />
Nutrologa - CRM-DF 22677', 'Danielle Candia Barra', '2026-09-24 11:12:08'),
  ('13138812104', 'prescricao', '<span style=&quot;font-family:courier new,courier,monospace&quot;>1-<br />
Vitamina D3..........................................4000ui<br />
Vitamina K2..........................................100mcg<br />
Vitamina A...........................................500 ui</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Sorver 2&nbsp;pastilhas sublingual uma vez ao dia após o&nbsp;almoço.<br />
tomar 2 doses. Por 60 dias.&nbsp;<br />
<br />
2-</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;>Ácido Málico...........................................100mg<br />
Coenzima Q10...........................................100mg<br />
Acetil L carnitina.....................................150mg<br />
Magnésio bisglicinato...................................200mg<br />
Resveratrol............................................100mg<br />
NAC....................................................300mg<br />
Manganês.................................................2mg</span>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Tomar 1 dose&nbsp; 2 x ao dia, manhã e noite. Por 60 dias&nbsp;</span></p>
<span style=&quot;font-family:courier new,courier,monospace&quot;> </span>', 'Ana Carolina Candia Barra', '2026-09-24 11:56:57'),
  ('06335546930', 'atestado', 'testeeee<br />
<br />
<br />
<br />
<br />
testeeee<br />
<br />
<br />
<br />
teste', 'Evellyn Lorrany Farias Dos Santos', '2025-07-16 15:41:50'),
  ('06335546930', 'atestado', 'testee<br />
<br />
<br />
testeee<br />
testee', 'Evellyn Lorrany Farias Dos Santos', '2025-07-16 15:43:22'),
  ('57862680120', 'atestado', 'Paciente Iniciou hoje o 5S mounjaro.&nbsp;<br />
Dieta especifica para mounjaro, porém ainda não iniciou a medicação. prevista para iniciar em 7 a 10 dias.&nbsp;<br />
levou suplementação, ( ozendrop, desinflamy, firm e probiotico)<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-07-28 14:47:37'),
  ('02529863504', 'atestado', '<strong>Queixa principal</strong><br />
<br />
Melhor qualidade de vida<br />
Baixa hormonal, ja fez reposição hormonal, e nada nunca melhorou relata que a testosterona é baixa,&nbsp; libido praticamente zero,&nbsp;<br />
lipedema, nódulo na tireoide, fissura na coluna.&nbsp;<br />
8 horas de sono, sim acordo com cansasso físico<br />
<br />
tomou antibiotico recente - Sim, amoxcilina - fez 2 implantes ha uns 15 dias e precisou tomar. não fez uso de probiótico<br />
<br />
teve alteração nos exames em relação ao Lupus no ano passado e o médico pediu apenas para acompanhar<br />
<br />
<strong>Histórico familiar&nbsp;</strong><br />
<br />
Alteração tireoide ( nega cancer de tiroide na família)<br />
&nbsp;lupus&nbsp;<br />
<br />
<strong>Mais relatos e historico de saúde&nbsp;</strong><br />
<br />
2 gestações<br />
<br />
Relata não saber tipo sanguineo<br />
<br />
relata compulsão por massas e pães<br />
<br />
dores musculares&nbsp;<br />
<br />
retenção de liquidos<br />
<br />
instabilidade de humor<br />
<br />
cansaço e dores no corpo<br />
<br />
candidiase<br />
<br />
rinite<br />
<br />
halitose<br />
<br />
queda de cabelo<br />
<br />
intestino preso<br />
<br />
indisposição<br />
<br />
memória baixa<br />
<br />
dor de cabeça na TPM<br />
<br />
Sente que não pega massa muscular (quando fazia academia, perdeu o gosto pq n via resultado).', 'Ana Carolina Candia Barra', '2025-07-29 09:38:29'),
  ('02529863504', 'atestado', 'candidiase antes de menstruar passou a ter de uns 3 meses para ca<br />
<br />
<span style=&quot;background-color:#FFFF00&quot;>exame fisico para lipedema</span> - aculumo desproporcional de gordura, edema, dor ao toque, gordura até no joelho, e ausencia de garrote.', 'Ana Carolina Candia Barra', '2025-07-29 09:40:10'),
  ('02529863504', 'atestado', 'Retornando mais inflamada<br />
Paciente relata que esta com sinusite recorrente com labirintite.<br />
Não teve episódio de candidiase nopvamente desde a consulta.&nbsp;<br />
Muita dor nas pernas.&nbsp;<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-07-29 09:50:05'),
  ('82608270506', 'atestado', 'Atesto para os devidos fins que a paciente supracitada esteve presente em consulta médica na presente data no período matutino.&nbsp;<br />
<br />
<br />
Cid : Z00', 'Danielle Candia Barra', '2025-07-31 10:32:46'),
  ('8213109686', 'atestado', '&nbsp;Atesto para os devidos fins que o paciente supracitado esteve presente em consulta na presente data e deverá permanecer afastado de suas atividades laborais por dois dias por motivo de doença.&nbsp;<br />
<br />
<br />
<br />
Cid : J00', 'Danielle Candia Barra', '2025-08-07 09:09:47'),
  ('04937069179', 'atestado', '<h3>. <strong>Alimentos base recomendados</strong></h3>

<h4>? Proteínas funcionais (alcalinizantes ou neutras):</h4>

<ul>
	<li>
	<p>Ovo caipira (cozido ou pochê)</p>
	</li>
	<li>
	<p>Peixe selvagem ou tilápia de boa procedência</p>
	</li>
	<li>
	<p>Tofu orgânico fermentado (em pequenas quantidades)</p>
	</li>
	<li>
	<p>Frango caipira ou peru orgânico</p>
	</li>
	<li>
	<p>Whey protein isolado de fonte vegetal (arroz + ervilha), se tolerado</p>
	</li>
</ul>

<h4>? Vegetais alcalinos:</h4>

<ul>
	<li>
	<p>Brócolis, couve, rúcula, agrião, espinafre</p>
	</li>
	<li>
	<p>Pepino, abobrinha, berinjela, chuchu, quiabo</p>
	</li>
	<li>
	<p>Salsinha e coentro (ação diurética e desintoxicante)</p>
	</li>
	<li>
	<p>Beterraba cozida (rica em nitratos e antioxidantes musculares)</p>
	</li>
	<li>
	<p>Cebola roxa e alho (moduladores hepáticos)</p>
	</li>
</ul>

<h4>? Carboidratos bons:</h4>

<ul>
	<li>
	<p>Batata-doce, inhame, cará, abóbora cabotiá</p>
	</li>
	<li>
	<p>Arroz integral ou negro</p>
	</li>
	<li>
	<p>Quinoa, amaranto ou painço</p>
	</li>
	<li>
	<p>Banana verde cozida ou biomassa de banana verde</p>
	</li>
	<li>
	<p>Maçã, pera, melão, ameixa fresca, kiwi (alcalinos e hipoglicemiantes)</p>
	</li>
</ul>

<h4>? Fontes de gordura boas:</h4>

<ul>
	<li>
	<p>Azeite de oliva extravirgem (finalização)</p>
	</li>
	<li>
	<p>Abacate (1/4 ao dia)</p>
	</li>
	<li>
	<p>Sementes de abóbora, linhaça e chia</p>
	</li>
	<li>
	<p>Castanhas-do-pará (ricas em selênio) – 1 a 2 ao dia</p>
	</li>
</ul>

<hr />
<h3>3. <strong>Alimentos que devem ser evitados</strong></h3>

<p><br />
&nbsp;</p>

<ul>
	<li>
	<p>Glúten e farinhas refinadas</p>
	</li>
	<li>
	<p>Leite e derivados convencionais</p>
	</li>
	<li>
	<p>Açúcar (mesmo mascavo ou mel)</p>
	</li>
	<li>
	<p>Café em excesso (substituir por café de cevada ou matchá)</p>
	</li>
	<li>
	<p>Embutidos, carne vermelha frequente</p>
	</li>
	<li>
	<p>Bebidas ácidas: refrigerantes, sucos artificiais</p>
	</li>
	<li>
	<p>Soja não fermentada<br />
	<br />
	&nbsp;</p>

	<p><strong>4- Tomar em jejum, 15 a 30 min antes do café da manhã</strong></p>
	</li>
	<li>
	<p>50–100 ml de água morna</p>
	</li>
	<li>
	<p>Suco de ½ limão fresco</p>
	</li>
	<li>
	<p><strong>Dica extra:</strong> adicionar 5gramas&nbsp;de glutamina&nbsp;</p>
	</li>
	<li>
	<p>10 a 20 gotas de clorofila líquida (verde escura, sem aditivos) - clorofilla de 100mg - compra na internet</p>
	</li>
	<li>
	<p>1 pitada de cúrcuma ou gengibre em pó (se tolerado)</p>
	</li>
</ul>
', 'Ana Carolina Candia Barra', '2025-08-11 12:00:13'),
  ('01663482799', 'atestado', '<p>&nbsp;</p>

<p><strong>ATESTADO DE COMPARECIMENTO</strong></p>

<p>Atesto, para os devidos fins, que a Sra. <strong>Daniela Francescutti Martins Hott</strong>, compareceu a atendimento médico nesta data, <strong>no período da manhã</strong>.</p>

<p>Local e Data: 14/08/2025</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>

<hr />
<p><br />
&nbsp;</p>
', 'Danielle Candia Barra', '2025-08-14 11:05:06'),
  ('48319309115', 'atestado', 'Pedi exames para reavaliar e passei a dieta da semana detox', 'Ana Carolina Candia Barra', '2025-09-01 15:13:05'),
  ('12329797168', 'atestado', '&nbsp;<br />
Atesto, para os devidos fins, que a Sra. Maria Adair Alves Mundim necessita de afastamento de suas atividades habituais por 02 (dois) dias, no período de 04/09/2025 a 06/09/2025, por motivo de saúde.<br />
<br />
<br />
<br />
CID-10: J00 – Nasofaringite aguda (resfriado comum)<br />
<br />
<br />
<br />
Sem mais para o momento, subscrevo-me.<br />
<br />
<br />
<br />
Brasília, 04/09/2025.<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-04 10:25:09'),
  ('79453430153', 'atestado', '<h3>Novo plano alimentar&nbsp;<br />
&nbsp;</h3>

<h3>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;?? Manhã (jejum)</h3>

<ul>
	<li>
	<p><strong>1 copo (300 ml) de água com 1 colher de sopa de chia hidratada</strong></p>
	</li>
	<li>
	<p>Café ou chá sem açúcar (adoçante natural opcional).<br />
	<br />
	<br />
	??? Almoço (1ª refeição) – 12h</p>
	</li>
</ul>

<ul>
	<li>
	<p><strong>1 prato de salada crua variada</strong> (folhas verdes, tomate, pepino). etc.</p>
	</li>
	<li>
	<p><strong>Proteína:</strong> 120 g frango grelhado OU peixe assado OU carne magra. ( pesada depois de pronta)</p>
	</li>
	<li>
	<p><strong>Vegetais cozidos:</strong> brócolis, abobrinha, couve-flor, vagem.</p>
	</li>
	<li>
	<p><strong>Gordura boa:</strong> 1 colher (sopa) de azeite extra virgem sobre a salad,&nbsp;e temperos naturais.</p>
	</li>
</ul>

<p><em>(Evita carboidrato aqui para não impactar a insulina)</em><br />
&nbsp;</p>

<h3>&nbsp; &nbsp; &nbsp; &nbsp; ? Lanche da tarde (16h – pré-treino, refeição com carboidrato)</h3>

<ul>
	<li>
	<p><strong>Cuscuz (50 g cru, ~150 g cozido)</strong></p>
	</li>
	<li>
	<p><strong>1 fatia de queijo muçarela (20 g)</strong></p>
	</li>
	<li>
	<p><strong>1 ovo cozido ou mexido<br />
	<br />
	+ 100 g de mamão papaia (aprox. ½ unidade pequena ou 1 fatia média) -&nbsp;</strong><br />
	?? Só não recomendo usar mamão <strong>isolado no lanche</strong>, porque pode elevar a glicemia mais rápido. Sempre melhor junto com proteína ou fibra.&nbsp;Pode colocar uma colher de mix de semetes em cima do mamão.</p>
	</li>
</ul>

<p><em>(Essa refeição fornece energia de liberação lenta para treino, proteína e saciedade.)</em><br />
<br />
substituições ao cuzcuz</p>

<ul>
	<li>
	<p><strong>Crepioca</strong>: 1 ovo + 1 col. sopa de tapioca hidratada + 1 fatia de queijo mussarela ou 60g de peito de&nbsp;frango desfiado.</p>
	</li>
	<li>
	<p><strong>Pão sem glúten (1 fatia pequena)</strong> + 1 ovo mexido OU 1 fatia de mussarela.<br />
	&nbsp;</p>

	<h3>??? Pós-treino (logo após)</h3>
	</li>
	<li>
	<p><strong>1 dose de whey protein (20–25 g de proteína)</strong></p>
	</li>
	<li>
	<p><strong>150 ml leite vegetal sem açúcar</strong></p>
	</li>
	<li>
	<p><strong>3 morangos<br />
	<br />
	ou</strong></p>
	</li>
	<li>
	<p><strong>Omelete de claras (3 claras + 1 gema) com espinafre ou couve</strong>.<br />
	<br />
	&nbsp;</p>

	<h3>?? Ceia (opcional, se houver fome)</h3>
	</li>
	<li>
	<p>5 amêndoas OU 3 nozes + chá calmante. ( camomila, erva cidreira, molungu, passiflora)<br />
	<br />
	&nbsp;</p>

	<h2>?? Destaques do plano</h2>
	</li>
	<li>
	<p><strong>Água com chia cedo</strong> ? ajuda na saciedade até o almoço.</p>
	</li>
	<li>
	<p><strong>Maior variedade no pré-treino</strong> ? mantém energia, mas respeita a resistência insulínica.</p>
	</li>
	<li>
	<p><strong>Pós-treino flexível</strong> ? proteína via whey, ovos ou laticínios leves.</p>
	</li>
	<li>
	<p><strong>Sem jantar fixo</strong> ? calorias mais concentradas onde há demanda energética.</p>
	</li>
</ul>

<p><br />
<br />
&nbsp;</p>
', 'Evellyn Lorrany Farias Dos Santos', '2025-09-04 14:29:52'),
  ('41637070187', 'atestado', '<h2>Objetivos</h2>

<ul>
	<li>
	<p><strong>Ganho de massa magra</strong> com cerca de <strong>1.600–1.700 kcal/dia</strong> (ponto de partida, ajusta-se conforme evolução).</p>
	</li>
	<li>
	<p><strong>Controle do colesterol</strong>: mais fibras, antioxidantes e gorduras boas.</p>
	</li>
	<li>
	<p><strong>Saúde intestinal</strong>: muitas fibras solúveis e probióticos vegetais.</p>
	</li>
</ul>

<hr />
<h1>CARDÁPIO MODELO – 1 DIA</h1>

<h3>Café da manhã</h3>

<ul>
	<li>
	<p><strong>Vitamina antioxidante</strong></p>

	<ul>
		<li>
		<p>1 banana média</p>
		</li>
		<li>
		<p>½ abacate</p>
		</li>
		<li>
		<p>1 colher (sopa) cacau 100%</p>
		</li>
		<li>
		<p>1 colher (sopa) chia hidratada</p>
		</li>
		<li>
		<p>30 g proteína vegetal em pó (ervilha ou arroz)</p>
		</li>
		<li>
		<p>150 ml água ou leite de coco caseiro</p>
		</li>
	</ul>
	</li>
	<li>
	<p><strong>Acompanhamento</strong>:</p>

	<ul>
		<li>
		<p>1 fatia de pão sem glúten de fermentação natural <strong>OU</strong> 3 colheres (sopa) aveia sem glúten hidratada</p>
		</li>
		<li>
		<p>1 colher (sopa) pasta de amêndoas ou castanha de caju</p>
		</li>
	</ul>
	</li>
</ul>

<hr />
<h3>Lanche da manhã</h3>

<ul>
	<li>
	<p>1 fruta cítrica (laranja, tangerina ou kiwi)</p>
	</li>
	<li>
	<p>30 g castanhas-do-pará, nozes ou sementes de abóbora</p>
	</li>
</ul>

<hr />
<h3>&nbsp;Almoço</h3>

<ul>
	<li>
	<p><strong>Proteína</strong>: 120 g salmão, sardinha fresca, peito de frango ou tofu grelhado</p>
	</li>
	<li>
	<p><strong>Carboidrato</strong>: 3 colheres (sopa) arroz integral <strong>OU</strong> quinoa</p>
	</li>
	<li>
	<p><strong>Leguminosas</strong>: 1 concha de lentilha ou feijão azuki</p>
	</li>
	<li>
	<p><strong>Salada grande</strong>: rúcula, agrião, tomate, azeite e limão</p>
	</li>
	<li>
	<p>1 colher (sopa) sementes de abóbora ou girassol</p>
	</li>
</ul>

<hr />
<h3>&nbsp;Lanche da tarde</h3>

<ul>
	<li>
	<p>Bowl de frutas vermelhas (1 xícara)</p>
	</li>
	<li>
	<p>2 colheres (sopa) granola sem açúcar</p>
	</li>
	<li>
	<p>2 colheres (sopa) iogurte vegetal integral (coco ou amêndoas)</p>
	</li>
</ul>

<hr />
<h3>&nbsp;Jantar</h3>

<ul>
	<li>
	<p>100 g filé de peixe branco ou frango desfiado</p>
	</li>
	<li>
	<p>½ xícara purê de mandioquinha OU batata-doce</p>
	</li>
	<li>
	<p>Brócolis e couve no vapor com azeite e alho</p>
	</li>
</ul>

<hr />
<h3>&nbsp;Ceia (opcional)</h3>

<ul>
	<li>
	<p>1 kiwi ou ½ pera</p>
	</li>
	<li>
	<p>1 colher (sobremesa) semente de linhaça dourada moída<br />
	<br />
	<strong><span style=&quot;font-size:18px&quot;>&nbsp;LISTA DE SUBSTITUIÇÕES (por refeição)</span></strong></p>

	<h3>Café da manhã</h3>

	<p><strong>Carboidratos</strong> (escolher 1)</p>
	</li>
	<li>
	<p>1 fatia pão sem glúten de fermentação natural</p>
	</li>
	<li>
	<p>3 colheres (sopa) aveia sem glúten hidratada</p>
	</li>
	<li>
	<p>½ xícara batata-doce cozida amassada</p>
	</li>
	<li>
	<p>1 banana média</p>
	</li>
	<li>
	<p><strong>Proteínas</strong> (escolher 1)</p>
	</li>
	<li>
	<p>1 ovo caipira</p>
	</li>
	<li>
	<p>2 colheres (sopa) homus</p>
	</li>
	<li>
	<p>30 g proteína vegetal em pó</p>
	</li>
	<li>
	<hr />
	<h3>Lanche da manhã</h3>

	<p><strong>Carboidratos</strong></p>
	</li>
	<li>
	<p>1 maçã pequena</p>
	</li>
	<li>
	<p>1 tangerina</p>
	</li>
	<li>
	<p>1 fatia de mamão</p>
	</li>
	<li>
	<p><strong>Proteínas/Gorduras boas</strong></p>
	</li>
	<li>
	<p>30 g castanhas ou nozes</p>
	</li>
	<li>
	<p>1 colher (sopa) sementes de abóbora ou girassol</p>
	</li>
	<li>
	<hr />
	<h3>Almoço</h3>

	<p><strong>Carboidratos (3 colheres de sopa cozidos)</strong></p>
	</li>
	<li>
	<p>Arroz integral</p>
	</li>
	<li>
	<p>Quinoa</p>
	</li>
	<li>
	<p>Lentilha ou feijão azuki</p>
	</li>
	<li>
	<p>Purê de mandioquinha</p>
	</li>
	<li>
	<p><strong>Proteínas (100–120 g cozidos)</strong></p>
	</li>
	<li>
	<p>Salmão, sardinha fresca, tilápia</p>
	</li>
	<li>
	<p>Peito de frango orgânico</p>
	</li>
	<li>
	<p>Ovos caipiras (2 unidades)</p>
	</li>
	<li>
	<p>Tofu ou tempeh</p>

	<h3>Lanche da tarde</h3>

	<p><strong>Carboidratos</strong></p>
	</li>
	<li>
	<p>Frutas vermelhas (1 xícara)</p>
	</li>
	<li>
	<p>1 fatia de melão ou mamão</p>
	</li>
	<li>
	<p>2 colheres (sopa) granola sem açúcar</p>
	</li>
	<li>
	<p><strong>Proteínas</strong></p>
	</li>
	<li>
	<p>2 colheres (sopa) iogurte vegetal</p>
	</li>
	<li>
	<p>20 g proteína vegetal em pó</p>
	</li>
	<li>
	<p>2 colheres (sopa) chia hidratada</p>
	</li>
	<li>
	<hr />
	<h3>Jantar</h3>

	<p><strong>Carboidratos (½ xícara)</strong></p>
	</li>
	<li>
	<p>Purê de batata-doce</p>
	</li>
	<li>
	<p>Purê de mandioquinha</p>
	</li>
	<li>
	<p>Quinoa</p>
	</li>
	<li>
	<p>Arroz integral</p>
	</li>
	<li>
	<p><strong>Proteínas (100 g cozidos)</strong></p>
	</li>
	<li>
	<p>Filé de peixe branco</p>
	</li>
	<li>
	<p>Peito de frango</p>
	</li>
	<li>
	<p>2 ovos mexidos</p>
	</li>
	<li>
	<p>Tofu firme grelhado</p>
	</li>
	<li>
	<hr />
	<h3>Ceia</h3>

	<p><strong>Carboidratos leves</strong></p>
	</li>
	<li>
	<p>1 kiwi</p>
	</li>
	<li>
	<p>½ pera</p>
	</li>
	<li>
	<p>1 colher (sopa) aveia sem glúten</p>
	</li>
	<li>
	<p><strong>Proteínas/Gorduras boas</strong></p>
	</li>
	<li>
	<p>1 colher (sobremesa) semente de linhaça moída</p>
	</li>
	<li>
	<p>1 colher (sopa) pasta de amêndoas<br />
	&nbsp;</p>

	<h2>Orientações Gerais</h2>
	</li>
	<li>
	<p>Beba <strong>2 litros de água</strong> por dia.</p>
	</li>
	<li>
	<p>Inclua <strong>azeite cru</strong> em saladas e vegetais.</p>
	</li>
	<li>
	<p>Se possível, introduza exercícios de resistência (musculação leve, pilates) para que o aumento calórico resulte em <strong>massa muscular</strong>, não gordura.</p>
	</li>
	<li>
	<p>Avaliar progresso a cada 2 semanas, ajustando calorias. Em consultas de acompanhamento com bioimpedancia.&nbsp;</p>
	</li>
</ul>
', 'Ana Carolina Candia Barra', '2025-09-15 16:49:39'),
  ('01663482799', 'atestado', '<p><strong>ATESTADO DE COMPARECIMENTO</strong></p>

<p>Atesto, para os devidos fins, que a Sra.&nbsp;<strong>Daniela Francescutti Martins Hott</strong>, compareceu a atendimento médico nesta data,&nbsp;<strong>no período da manhã</strong>.</p>

<p>Local e Data: 18/09/2025</p>

<p><strong>Dra. Danielle Candia Barra</strong><br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2025-09-18 09:24:38'),
  ('87295490191', 'atestado', 'Tratamentos&nbsp;<br />
<br />
5S 3 meses - online - ( acompanhamento nutricional, demagre e omega e simplelife) 4000,00<br />
<br />
Desparasitação + 4 sessões de hidrovitallis. 1100,99<br />
<br />
consulta nutrologia - 700,00<br />
<br />
Vitamina b12 IM - 230,00<br />
<br />
total 6030,99<br />
<br />
3x de 2010.33<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-09-23 15:05:37'),
  ('79453430153', 'atestado', NULL, 'Ana Carolina Candia Barra', '2025-09-25 12:26:31'),
  ('69058946134', 'atestado', '<h2>Orientações alimentares e sugestões<br />
<br />
Café da manhã</h2>

<ul>
	<li>
	<p>1 ovo inteiro + 2 claras mexidas (?12 g proteína)</p>
	</li>
	<li>
	<p>1 fatia de pão integral/sem glúten (30 g) OU 2 col. sopa de aveia (?3 g proteína)</p>
	</li>
	<li>
	<p>½ mamão pequeno OU 1 maçã pequena com casca</p>
	</li>
	<li>
	<p>1 col. sopa de chia ou linhaça (?2 g proteína)</p>
	</li>
	<li>
	<p>Café sem açúcar OU chá verde</p>
	</li>
</ul>

<p>&nbsp;</p>

<hr />
<h2>Lanche da manhã</h2>

<ul>
	<li>
	<p>1 iogurte grego natural sem açúcar (150 g) (?10 g proteína)</p>
	</li>
	<li>
	<p>1 col. sopa de castanhas/nozes/amêndoas (?2 g proteína)</p>
	</li>
	<li>
	<p>1 scoop de whey protein isolado (meia dose – 15 g proteína)</p>
	</li>
</ul>

<p><strong>Proteína média:</strong> 27 g</p>

<hr />
<h2>Almoço</h2>

<ul>
	<li>
	<p>100 g de peito de frango grelhado OU peixe branco (?22 g proteína)</p>
	</li>
	<li>
	<p>3 col. sopa de arroz integral OU ½ xíc. batata-doce/mandioca (?2 g proteína)</p>
	</li>
	<li>
	<p>Salada crua variada à vontade (alface, rúcula, tomate, pepino, couve, cebola)</p>
	</li>
	<li>
	<p>Brócolis, couve-flor ou abobrinha refogada (livre)</p>
	</li>
	<li>
	<p>1 fio de azeite de oliva extra virgem (1 col. sopa)</p>
	</li>
</ul>

<p>&nbsp;</p>

<hr />
<h2>Lanche da tarde (pós-treino, se aplicável)</h2>

<ul>
	<li>
	<p>Crepioca com:</p>

	<ul>
		<li>
		<p>1 ovo inteiro (6 g proteína)</p>
		</li>
		<li>
		<p>2 col. sopa de tapioca (0 g proteína)</p>
		</li>
		<li>
		<p>½ scoop de whey protein (12 g proteína)</p>
		</li>
	</ul>
	</li>
	<li>
	<p>Recheio: 40 g frango desfiado OU atum (?8–10 g proteína)</p>
	</li>
	<li>
	<p>1 porção pequena de abacate (2 col. sopa)</p>
	</li>
</ul>

<p>&nbsp;</p>

<hr />
<h2>Jantar</h2>

<ul>
	<li>
	<p>100 g de salmão grelhado OU frango (?22 g proteína)</p>
	</li>
	<li>
	<p>½ xíc. de abóbora OU batata-doce (?1,5 g proteína)</p>
	</li>
	<li>
	<p>Legumes no vapor (brócolis, couve-flor, espinafre, cogumelos)</p>
	</li>
	<li>
	<p>1 col. sopa de azeite de oliva</p>
	</li>
</ul>

<p>&nbsp;</p>

<hr />
<h2>Ceia (opcional, caso haja fome à noite)</h2>

<ul>
	<li>
	<p>1 iogurte natural/vegetal (?6 g proteína)</p>
	</li>
	<li>
	<p>OU ½ scoop de caseína (12 g proteína)<br />
	&nbsp;</p>
	</li>
</ul>

<p><strong>Observações importantes</strong></p>

<ul>
	<li>
	<p>Hidratação: 2–2,5 L de água/dia.</p>
	</li>
	<li>
	<p>Frutas: dar preferência às de <strong>baixo índice glicêmico</strong> (mamão, kiwi, morango, maçã, pera).</p>
	</li>
	<li>
	<p>Ajustar carboidrato conforme evolução da resistência à insulina e gasto energético.</p>
	</li>
	<li>
	<p>Evitar sucos de fruta, refrigerantes, álcool e industrializados.</p>
	</li>
</ul>
', 'Ana Carolina Candia Barra', '2025-10-01 12:18:53'),
  ('02373984601', 'atestado', 'indiquei 5S 3 meses 15 em 15 dias 5.500 em 4 x sem juros.<br />
<br />
para a filha Julia - acompanhamento integrativo 300,00 Mês 15 em 15 dias. total 1500,00 soemnte o acompanhamento.<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-10-04 12:18:32'),
  ('03402127644', 'atestado', 'Acompanhamento integrativo 300,00 Mês 15 em 15 dias. total 1500,00 soemnte o acompanhamento<br />
<br />
Foco em SIBO e neuroinflamação', 'Ana Carolina Candia Barra', '2025-10-04 12:21:53'),
  ('39888762168', 'atestado', 'Fazer prescrição de enzimas digestivas, pepsina blomelina e sais biliares.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-10-07 17:07:13'),
  ('77066146387', 'atestado', 'Proposta de tratamento<br />
<br />
Contrato integrativo: 3 meses de acompanhamento terapeutico&nbsp;<br />
<br />
-6 sessões de ozonioterapia + infravermelho longo e drenagem linfática com exame de&nbsp; bioimpedancia (15 em 15 dias )<br />
-1 kit desparasitação ( mês 2)&nbsp;<br />
-3 consultas de avaliação na troca de cada mês.<br />
<br />
Valor: 3000,00&nbsp;<br />
<br />
forma de pagamento: 1.000,00 pix&nbsp; ou no cartão com a taxa da maquina', 'Ana Carolina Candia Barra', '2025-10-16 13:54:55'),
  ('99572354000', 'atestado', 'tratamento indicado<br />
<br />
3 meses de 5S com omega e equilibrium, consultas de&nbsp; 15 em 15 dias com coach e bioimpedancia&nbsp;<br />
<br />
dieta com carbo no primeiro mes e depois reavaliar<br />
<br />
5000 a vista&nbsp;<br />
5500 3 x sem juros ou até em 12 com taxa da maquina<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-10-28 17:18:40'),
  ('01556411154', 'atestado', 'Tratamento integrativo&nbsp;<br />
<br />
6 sessões de terapia neural&nbsp;<br />
detox de figado&nbsp;<br />
<br />
2280,00&nbsp; 12x&nbsp;<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-11-19 15:11:26'),
  ('41446780163', 'atestado', 'se tornou habito o limão<br />
<br />
e os lanches com as frutas<br />
<br />
comer legumes no vapor no almoço.&nbsp;<br />
<br />
proteinas melhores é o peixe e frango&nbsp;<br />
<br />
maracuja a noite pra dormir.&nbsp;<br />
<br />
faz falta do feijão&nbsp;<br />
<br />
e o capuccino de manhã.&nbsp; adoçado com açúcar..<br />
<br />
jajum - fez tyranquilo o de 24 e tirou de letra o de 18<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-11-28 15:14:03'),
  ('77394062287', 'atestado', 'Análise corporal:&nbsp; 40% oral, 22% rígida, 17% psicopata, 15% masoquista e 7% esquizóide<br />
<br />
causas centrais:<br />
1-&nbsp; relação com a mãe<br />
2-&nbsp;relacionamentos amorosos<br />
3-&nbsp;desorganização financeira<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-12-16 16:46:50'),
  ('00813233100', 'atestado', '<strong>Relatório resultados dos exames relacionando com as queixas.</strong><br />
<br />
VISÃO INTEGRATIVA – ACNE + MELASMA EM MULHER ADULTA<br />
&nbsp;1. Acne e melasma não são problemas de pele<br />
Na visão integrativa, a pele é um órgão de excreção e sinalização metabólica.<br />
Quando aparecem acne persistente e melasma, geralmente há alterações internas combinadas, principalmente:<br />
<br />
Hormonal<br />
<br />
Metabólica<br />
<br />
Hepática<br />
<br />
Inflamatória<br />
<br />
Autoimune silenciosa<br />
<br />
2- METABOLISMO GLICÊMICO – HEMOGLOBINA GLICADA<br />
<br />
&nbsp;Hemoglobina glicada elevada ou limítrofe - isso impacta na glicação.<br />
<br />
<br />
A glicose elevada estimula insulina<br />
<br />
A insulina:<br />
<br />
Aumenta a produção de andrógenos<br />
<br />
Estimula IGF-1 ? acne<br />
<br />
Ativa melanócitos ? melasma<br />
<br />
Gera inflamação silenciosa<br />
<br />
&nbsp;Valor ideal integrativo da HbA1c:<br />
? 5,2%<br />
Acima disso já pensamos em resistência insulínica subclínica<br />
<br />
insulina não está alta: o que pode estar acontecendo é uma hiperglicemia pós prandial. não eleva a insulina mas aumenta o açucar ligada a proteína.<br />
<br />
3- FÍGADO E DETOX HORMONAL – GGT<br />
&nbsp;GGT alterado ou alto-normal<br />
<br />
Mesmo discreto, é um marcador precoce de sobrecarga hepática.<br />
<br />
Relação com pele:<br />
<br />
O fígado é responsável pela inativação e excreção de estrogênios e andrógenos<br />
<br />
Quando sobrecarregado:<br />
<br />
Hormônios ativos circulam mais tempo<br />
<br />
A pele que&nbsp; “paga a conta”<br />
<br />
Surge melasma, acne, rosácea, manchas<br />
<br />
Valor ideal integrativo da GGT:<br />
<img alt=&quot;??&quot; src=&quot;https://fonts.gstatic.com/s/e/notoemoji/16.0/1f449/32.png&quot; />&nbsp;Mulheres: ? 20 U/L<br />
<br />
Valores acima disso já sugerem:<br />
<br />
Estresse oxidativo<br />
<br />
Sobrecarga hepática<br />
<br />
Baixa capacidade detox<br />
<br />
4- RIM E ELIMINAÇÃO – TAXA DE FILTRAÇÃO GLOMERULAR (TFG)<br />
<br />
&nbsp;TFG reduzida ou limítrofe<br />
<br />
&nbsp;Visão integrativa:<br />
<br />
Rim participa da eliminação de metabólitos inflamatórios<br />
<br />
Toxinas acumuladas pioram inflamação sistêmica<br />
<br />
Pele funciona como órgão compensatório<br />
<br />
&nbsp;Valor ideal integrativo da TFG:<br />
&nbsp;? 90 ml/min<br />
Entre 60–89 já consideramos perda funcional precoce, especialmente em estética integrativa<br />
<br />
5-&nbsp; TIREOIDE – ANTICORPOS (AUTOIMUNIDADE SILENCIOSA)<br />
<br />
&nbsp;Anticorpos tireoidianos positivos (TPO e/ou TgAb)<br />
<br />
Mesmo com TSH e T4 “normais”.<br />
<br />
&nbsp;Impacto na pele:<br />
<br />
Inflamação crônica de baixo grau<br />
<br />
Alteração na regeneração cutânea<br />
<br />
Melasma resistente<br />
<br />
Acne que não responde a tratamentos convencionais<br />
<br />
&nbsp;Visão integrativa:<br />
Não é ainda hipotireoidismo clínico, mas:<br />
<br />
&nbsp;Processo autoimune em atividade<br />
<br />
Isso exige:<br />
<br />
Redução inflamatória<br />
<br />
Modulação intestinal<br />
<br />
Atenção a permeabilidade intestinal<br />
<br />
&nbsp;<strong>CONCLUSÃO INTEGRATIVA DO CASO</strong><br />
<br />
&nbsp;Acne e melasma na paciente são resultado da soma de fatores, não de uma causa isolada:<br />
<br />
Resistência insulínica subclínica<br />
Sobrecarga hepática<br />
Eliminação renal subótima<br />
Inflamação autoimune silenciosa<br />
<br />
&nbsp;<strong>Por isso tratamentos apenas tópicos ou estéticos falham ou têm recidiva.<br />
<br />
Sugestão:</strong><br />
<br />
tratamento integrativo completo - saúde e tópico ( local)<br />
<br />
fase 1 - 1 mês&nbsp;<br />
<br />
Ajuste de alimentação para evitar picos glicemicos pós prandial com acomphamento de bioimpedancia. ,eçhora a glicação da pele<br />
Indicação de cosmeceuticos de home care&nbsp;<br />
detox heptatico&nbsp;<br />
melhora de função de filtação renal. - suplementos e alimentação<br />
limpeza de pele e ozonioterapia local ( 1 sessão de limpeza detox e antiinflamatória = 3 sessões de ozonio 1 x por semana).<br />
Acompanhamento remoto direto com Dra. Ana Carolina<br />
<br />
1560,00<br />
<br />
fase 2 - 1 Mês&nbsp;<br />
<br />
desparasitação sistemica ( fungos, virus, bacterias e protozoarios)&nbsp;<br />
Tratamento de regeneração da pele PRP e PDRN<br />
1 sessão de higienização + Plasma enriquecido com plaquetas ozonizado&nbsp;<br />
1 sessão de PDRN mais ativos para melasma&nbsp;<br />
Acompanhamento do estado geral metabolico de saúde&nbsp;<br />
<br />
<br />
4.368<br />
<br />
Fase 3 - 1 mês&nbsp;<br />
<br />
manutenção do estilo de vida com exames e prescrições, ajuste de alimentação&nbsp;<br />
2&nbsp;sessões de ozonioterapia&nbsp; a cada 15 dias para manutenção<br />
<br />
585,00<br />
<br />
<br />
Total 6513,00 em até 12 x sem juros&nbsp;<br />
<br />
ou 5.536,05<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-12-17 11:55:56'),
  ('22352651115', 'atestado', 'Parecer Técnico&nbsp; –&nbsp; Avaliação por Bioimpedância<br />
Paciente: Sueli Pina de Barros&nbsp;<br />
<br />
<strong>Dados da bioimpedância corporal</strong><br />
<br />
Peso corporal: 80,1 kg<br />
IMC: 32,1 kg/m²<br />
Percentual de gordura corporal: 48,3%<br />
Massa gorda total: 38,7 kg<br />
Peso corporal livre de gordura: 41,6 kg<br />
Índice de gordura visceral: 17 kg<br />
<br />
A avaliação evidencia excesso de adiposidade total e central, condição associada a maior risco metabólico e inflamatório, com impacto direto na saúde articular e na evolução clínica de quadros dolorosos crônicos.<br />
<br />
<strong>Avaliação muscular</strong><br />
<br />
Massa muscular total: 38,6 kg<br />
Músculo esquelético: 22,7 kg<br />
<br />
Embora a massa muscular global esteja classificada como dentro do padrão pelo equipamento, a análise isolada não reflete a qualidade funcional da musculatura.<br />
<br />
<strong>Análise segmentar (musculatura)</strong><br />
Membro inferior direito: 88,8% (baixo)<br />
Membro inferior esquerdo: 88,8% (baixo)<br />
<br />
A análise compartimental evidencia redução de massa muscular funcional em membros inferiores, achado relevante em paciente idosa, por representar menor suporte às articulações, aumento da sobrecarga mecânica e maior risco de dor, instabilidade e limitação funcional.<br />
<br />
<strong>Massa óssea e água corporal</strong><br />
Massa óssea estimada: 2,9 kg (preservada)<br />
Água corporal total: 30,4 kg (dentro do padrão)<br />
<br />
Apesar da preservação óssea, a adequada proteção articular depende da manutenção e fortalecimento da musculatura periarticular.<br />
<br />
<strong>Considerações gerais</strong><br />
<br />
De forma integrada, a associação, insulina alterada e I.R. alterado ( visualisada em exames de sangue complementares) , gordura visceral elevada, excesso de gordura corporal total e baixa massa muscular compartimental cria um ambiente metabólico inflamatório, desfavorável à regeneração articular e ao controle da dor, podendo justificar a necessidade de melhorar a composição corporal, diminuir % de gordura e aumentar a % de massa muscular.<br />
Sem caráter diagnóstico, esta avaliação reforça a importância de abordagem multiprofissional, com estratégias voltadas à redução gradual e segura de peso corporal, com <strong>meta inicial</strong> técnica aproximada de 10 kg, melhora da sensibilidade insulínica, redução da inflamação sistêmica e estímulo ao ganho de massa muscular funcional, especialmente em membros inferiores, como complemento ao acompanhamento ortopédico, nutricional, nutrologia e técnicas integrativas.<br />
&nbsp;<br />
Coloco-me à disposição para discussão conjunta do caso e troca de informações clínicas, visando uma abordagem integrada e melhor evolução funcional da paciente.<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-12-20 12:44:59'),
  ('11783460130', 'atestado', 'Detox de metais pesados e pesticidas<br />
<br />
4 sessões de terapia neural - 1.800,00<br />
5 sessões de hidrovitallis - 1.000,00<br />
kit desparasitação - 780,00<br />
consulta de acompanhamento - 250,00<br />
consulta nutrologia - 780,00<br />
<br />
total 4.610,00<br />
a vista 4.287,300<br />
<br />
Combinado com o paciente - a vista 2305,00 no débito&nbsp;<br />
<br />
mais 5 x de 461 por sessão a cada sessão<br />
&nbsp;', 'Ana Carolina Candia Barra', '2025-12-29 13:17:03'),
  ('77394062287', 'atestado', 'segunda sessão da análise corporal<br />
<br />
auto-conhecimento para seguir com o relacionamento amoroso.<br />
<br />
tarefa:&nbsp;<br />
<br />
Pegar uma lista de temas a serem abordados no chat gpt e primeiro se responder as questões que precisam ser levantadas e alinhadas com o parceiro, porém antes de discutir essas questoes com o parceiro, precisa responder a si mesma..&nbsp;<br />
<br />
trazer essa lista respondida na proxima sessão<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-01-05 13:03:07'),
  ('38678691115', 'atestado', '<p>ATESTADO DE COMPARECIMENTO<br />
&nbsp;</p>

<p>Atesto, para os devidos fins, que a Sra.&nbsp;<strong>Simone do Carmo Direito</strong>&nbsp;compareceu à consulta médica nesta data, no período&nbsp;<strong>matutino</strong>, permanecendo em atendimento neste serviço de saúde.</p>

<p>Declaro que a mesma esteve impossibilitada de exercer suas atividades habituais durante o período acima mencionado.<br />
<br />
<br />
N95.1 – Sintomas do climatério e menopausa<br />
E28.39 – Outras disfunções ovarianas<br />
E34.9 – Transtorno endócrino, não especificado</p>
', 'Danielle Candia Barra', '2026-01-12 10:11:44'),
  ('15433080153', 'atestado', '&nbsp;digestão<br />
- Betaína HCL…&nbsp; 300 mg<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pepsina…. 100 mg<br />
<br />
&nbsp;<br />
Colágeno Beauty Power - doterra<br />
<br />
&nbsp;<br />
&nbsp;&nbsp;tireoide (hipotireoidismo)<br />
- Puran T4 100 mcg<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 capsula em jejum<br />
<br />
&nbsp;<br />
&nbsp;ansiedade:<br />
. Velija - cloridrato de duloxetina 30 mg - 1 cápsula após o café<br />
&nbsp;<br />
<br />
TAG (transtorno da ansiedade generalizada):<br />
- Depakote<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 cápsula antes de dormir<br />
&nbsp;<br />
<br />
ajudar no sono:<br />
- Axonium<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 capsula antes de dormir.<br />
E mais raramente, quando estou muito estufada, tomo 1 comprimido de Motilium. (Esse é mais raramente)<br />
&nbsp;<br />
<br />
E ainda:<br />
- Glutamina: 5 g<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 sache em jejum<br />
&nbsp;<br />
- Metilcobalamina&nbsp; 500 mcg/ metilfolato&nbsp; 100 mcg<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pastilha sublingual<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usar 1 pastilha após o almoço<br />
&nbsp;', 'Ester Virginio dos Santos Tomaz', '2026-01-12 14:30:49'),
  ('77394062287', 'atestado', 'Relatou que terminou com o namorado. ainda não saiu de casa<br />
<br />
vai fazer uma relação do que sente pelos homens e como os enxerga&nbsp;', 'Ana Carolina Candia Barra', '2026-01-15 13:47:30'),
  ('86414526134', 'atestado', 'Sugestão alimentar ( Low carb, antiinflamatória e alcalina)<br />
<br />
<strong>CAFÉ DA MANHÃ – 400 kcal&nbsp;</strong><br />
(opção alcalinizante e anti-inflamatória)<br />
<br />
Omelete com:<br />
3 ovos caipiras<br />
Espinafre + cebola roxa + cúrcuma<br />
1 colher de sopa de azeite de oliva extra virgem<br />
½ avocado (ou 1/3 de abacate)<br />
Chá verde, hortelã ou gengibre (sem adoçar)<br />
<br />
Função:<br />
Anti-inflamatório<br />
Fonte de colina, antioxidantes e gorduras alcalinizantes<br />
Estabiliza glicemia pela manhã<br />
<br />
<strong>LANCHE DA MANHÃ – 200 kcal</strong><br />
1 punhado (30 g) de castanhas (do Pará, noz ou amêndoas)<br />
1 maçã verde pequena OU 1 pera pequena<br />
<br />
Função:<br />
Alcalinidade<br />
Fibras + gorduras boas<br />
Controle do apetite<br />
<br />
<strong>ALMOÇO – 550 kcal</strong><br />
(base anti-inflamatória + proteína limpa)<br />
<br />
150 g de peixe (salmão, sardinha ou tilápia) - pesar depois de pronta e sem osso.<br />
ou frango orgânico / carne magra<br />
Mix de folhas verdes escuras à vontade<br />
(rúcula, agrião, alface roxa, espinafre)<br />
<br />
Legumes alcalinos:<br />
Abobrinha<br />
Brócolis<br />
Couve-flor<br />
3 colheres de sopa de azeite de oliva extra virgem<br />
<br />
½ xícara de:<br />
Quinoa OU arroz integral OU lentilha<br />
<br />
Temperos:<br />
Limão, cúrcuma, gengibre, alho, ervas frescas<br />
(evitar molhos prontos)<br />
<br />
Função:<br />
Suporte anti-inflamatório<br />
Minerais alcalinizantes<br />
Boa densidade nutricional<br />
<br />
<strong>LANCHE DA TARDE – 250 kcal</strong><br />
1 iogurte natural integral ( grego) sem açúcar<br />
ou iogurte vegetal sem açúcar<br />
1 colher de sopa de chia ou linhaça<br />
1 punhado de frutas vermelhas (morango, amora ou mirtilo)<br />
<br />
Função:<br />
Saúde intestinal<br />
Redução de inflamação<br />
Equilíbrio ácido-base<br />
<br />
<strong>JANTAR – 350 kcal</strong><br />
(leve, alcalino e anti-inflamatório)<br />
<br />
120–150 g de proteína:<br />
Peixe<br />
Ovos<br />
Frango<br />
Grande porção de legumes cozidos ou salteados:<br />
Abóbora<br />
Chuchu<br />
Vagem<br />
Couve<br />
1 colher de sopa de azeite<br />
½ batata-doce pequena OU mandioquinha<br />
<br />
<strong>ANTES DE DORMIR (opcional) – 50 kcal</strong><br />
Chá de camomila, erva-doce ou melissa<br />
Magnésio e melatonina se já fizer uso', 'Ana Carolina Candia Barra', '2026-01-15 14:18:49'),
  ('86414526134', 'atestado', 'Avaliação dos exames<br />
<br />
Ferritina 443&nbsp;<br />
<br />
Valor claramente elevado - funcionalmente sugere:<br />
estresse oxidativo. possível sobrecarga de ferro funcional, inflamação subclínica, impacto direto sobre o fígado, mitocondria, testosterona e eixo adrenal.<br />
<br />
GGT - 48<br />
Sobrecarga hepática, baixa capacidade antioxidante - relação com glutationa baixa, estresse oxidativo sistêmico, e disfunção metabólica silenciosa.<br />
<br />
Testosterona 417 - normal labotarorialmente<br />
<br />
- porém baixa funcionalmente para perda de gordura e ganho de massa, principalmente em homen ativo.<br />
compatível com inflamação, ferro alterado, cortisol desregulado e figado sobrecarregado.<br />
<br />
Cortisol mais baixo - a baixo de 10 ao acordar.<br />
- fadiga adrenal, leva a queda da testosterona, inflamção cronica, cansaço persistente e redução da performance.<br />
<br />
Obejetico da alimentação e suplementação:<br />
- Reduzir estresse oxidativo<br />
- quelação de ferritina / ferro<br />
- Reforçar a glutationa hepática ( antioxidante)<br />
- proteger a mitocôndria<br />
- reequilibrar eixo HPA<br />
- Criar ambiente hormonal favorável.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-01-15 14:30:47'),
  ('62606465342', 'atestado', '<strong>primeira medida<br />
Resultado (Escore-Z):<br />
1,96</strong>
<p><strong>IMC Calculado: 24,0</strong></p>

<p>A tabela abaixo apresenta os limites de referência técnicos da OMS para análises populacionais. A interpretação destes dados deve ser feita por um pediatra.</p>

<table>
	<thead>
		<tr>
			<th>Limite de referência (OMS)</th>
			<th>Escore-Z</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Magreza acentuada</td>
			<td>&lt; -3</td>
		</tr>
		<tr>
			<td>Magreza</td>
			<td>-3 a -2</td>
		</tr>
		<tr>
			<td>Peso normal</td>
			<td>-2 a +1</td>
		</tr>
		<tr>
			<td>Sobrepeso</td>
			<td>&gt; +1 a +2</td>
		</tr>
		<tr>
			<td>Obesidade</td>
			<td>&gt; +2 a +3</td>
		</tr>
		<tr>
			<td>Obesidade grave</td>
			<td>&gt; +3</td>
		</tr>
	</tbody>
</table>

<p>Fonte:&nbsp;<a href=&quot;https://www.who.int/tools/child-growth-standards&quot; rel=&quot;noopener noreferrer&quot; target=&quot;_blank&quot;>Padrões de Crescimento da OMS</a>.</p>
', 'Ana Carolina Candia Barra', '2026-01-20 14:49:05'),
  ('78380782615', 'atestado', '<p><strong>Laudo – Biorressonância</strong></p>

<p>&nbsp;</p>

<ul>
	<li>
	<p><strong>Candida albicans</strong> – Positivo (ressonante)</p>
	</li>
	<li>
	<p><strong>Herpes simples</strong> – Negativo (dissonante)</p>
	</li>
	<li>
	<p><strong>Herpes zoster</strong> – Negativo (dissonante)</p>
	</li>
	<li>
	<p><strong>Borrelia</strong> – Positivo (ressonante)</p>
	</li>
	<li>
	<p><strong>Clamídia</strong> – Negativo (dissonante)</p>
	</li>
	<li>
	<p><strong>Toxoplasma</strong> – Positivo (ressonante)</p>
	</li>
	<li>
	<p><strong>Taenia saginata</strong> – Negativo (dissonante)</p>
	</li>
</ul>
', 'Ester Virginio dos Santos Tomaz', '2026-01-22 15:26:12'),
  ('06240052590', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética alimentar:<br />
<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Café:&nbsp;</strong>positivo (dissonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Carne de frango:</strong>&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Carne bovina:</strong>&nbsp;positivo (dissonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp;<strong>&nbsp;&nbsp;Peixe branco:</strong>&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Ovos:</strong>&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Camarão:</strong>&nbsp;positivo (dissonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Glúten:</strong>&nbsp;positivo (dissonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Carne suína:</strong>&nbsp;positivo (dissonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Leite de vaca – lactose e caseína:</strong>&nbsp;positivo (dissonante)<br />
<br />
<strong>Sensibilidade à histamina:&nbsp;</strong>positivo (ressonante)<br />
<br />
<strong>OBS.: ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong>', 'Ana Carolina Candia Barra', '2026-01-28 13:08:07'),
  ('06240052590', 'atestado', '<h2><span style=&quot;font-size:14px&quot;><strong>Teste de Biorressonância</strong></span></h2>
<br />
<span style=&quot;font-size:12px&quot;>Sensibilidade energética alimentar:<br />
<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Café:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Carne de frango:&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;<strong>&nbsp; &nbsp;Carne bovina:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp;&nbsp;&nbsp;Peixe branco:&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Ovos:</strong>&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; <strong>&nbsp;Camarão:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Glúten:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Carne suína:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Leite de vaca – lactose e caseína:&nbsp;positivo (dissonante)</strong><br />
<br />
<strong>Sensibilidade à histamina:&nbsp;positivo (ressonante)</strong></span><br />
<br />
<span style=&quot;font-size:14px&quot;><strong>OBS.: ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></span><br />
<br />
<span style=&quot;font-size:14px&quot;>Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong></span>', 'Ana Carolina Candia Barra', '2026-01-28 14:44:27'),
  ('06240052590', 'atestado', '<h2><span style=&quot;font-size:14px&quot;><strong>Teste de Biorressonância</strong></span></h2>
<br />
Sensibilidade energética alimentar:<br />
<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Café:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Carne de frango:&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;<strong>&nbsp; &nbsp;Carne bovina:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp;&nbsp;&nbsp;Peixe branco:&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Ovos:</strong>&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; <strong>&nbsp;Camarão:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Glúten:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Carne suína:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Leite de vaca – lactose e caseína:&nbsp;positivo (dissonante)</strong><br />
<br />
<strong>Sensibilidade à histamina:&nbsp;positivo (ressonante)</strong><br />
<br />
<span style=&quot;font-size:14px&quot;><strong>OBS.: ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></span><br />
<br />
<span style=&quot;font-size:14px&quot;>Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong></span>', 'Ana Carolina Candia Barra', '2026-01-28 14:44:59'),
  ('06240052590', 'atestado', '<h2><span style=&quot;font-size:14px&quot;><strong>Teste de Biorressonância</strong></span></h2>
<br />
Sensibilidade energética alimentar:<br />
<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Café:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Carne de frango:&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;<strong>&nbsp; &nbsp;Carne bovina:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp;&nbsp;&nbsp;Peixe branco:&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Ovos:&nbsp;negativo (ressonante)<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; <strong>&nbsp;Camarão:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Glúten:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Carne suína:&nbsp;positivo (dissonante)</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;<strong>Leite de vaca – lactose e caseína:&nbsp;positivo (dissonante)</strong><br />
<br />
<strong>Sensibilidade à histamina:&nbsp;positivo (ressonante)</strong><br />
<br />
<span style=&quot;font-size:14px&quot;><strong>OBS.: ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></span><br />
<br />
<span style=&quot;font-size:14px&quot;>Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong></span>', 'Ana Carolina Candia Barra', '2026-01-28 14:49:02'),
  ('28657284634', 'atestado', '<strong>Guia Alimentar&nbsp;<br />
<br />
CAFÉ DA MANHÃ</strong><br />
Frango desfiado (80–100 g)<br />
Abacate (2–3 colheres de sopa)<br />
1 fatia pequena de pão de linhaça (sem trigo, sem açúcar, sem amido)<br />
Chá de ervas ou chá verde fraco<br />
<br />
&nbsp;<strong>Café preto não é indicado neste momento.</strong><br />
&nbsp;<br />
<strong>&nbsp;LANCHE DA MANHÃ - escolher uma unidade</strong><br />
Fruta de baixo índice glicêmico (1 porção):<br />
Morango ( 4 unidades)<br />
Amora<br />
Framboesa<br />
Mirtilo<br />
Kiwi (½ unidade)<br />
<br />
usar com moderação ( não todos os dias)<br />
<br />
maçã<br />
pera<br />
ameixa fresca<br />
pêssego<br />
<br />
<strong>ALMOÇO</strong><br />
Arroz integral ou arroz negro (3–4 colheres de sopa)<br />
Vegetais à vontade (priorizar folhas verdes e crucíferos)<br />
Proteína permitida (100–120 g pesar depois de pronta)<br />
Frango<br />
Peixe branco<br />
1 colher de sopa de azeite de oliva extra virgem<br />
Evitar molhos prontos, excesso de sal e alimentos ultraprocessados.<br />
<br />
<strong>LANCHE DA TARDE</strong><br />
Escolher uma das opções:<br />
<br />
Opção 1 (preferencial):<br />
Fruta de baixo índice glicêmico<br />
Oleaginosas (5–6 unidades)<br />
<br />
Opção 2 (eventual – até 2–3x/semana):<br />
Fruta de baixo índice glicêmico<br />
Queijo de cabra ou ovelha (?30 g)<br />
<br />
<strong>JANTAR</strong><br />
Legumes refogados ou cozido à vontade.<br />
Proteína leve (frango ou peixe)&nbsp; - 70 a 90 g ( pesar depois de pronto)<br />
Azeite de oliva<br />
<br />
<br />
<strong>Não consumir carboidratos concentrados à noite.<br />
Evitar queijos de leite de vaca neste período.<br />
HIDRATAÇÃO - Total:&nbsp; Peso x 35 ml<br />
Água ao longo do dia, fracionada<br />
Evitar grande volume de líquidos à noite<br />
Importe - raizes como vegetais não passaram na bioressonncia ( batatatas, abobora, cenoura, beterraba etc)<br />
Grãos também não passar na biorressonancia, somente a linhaça, por isso por enviar a receita do pão de linhaça por whatzapp<br />
TEMPO DE PROTOCOLO<br />
Seguir por 8 semanas<br />
Reavaliar sintomas, exames e necessidade de ajustes</strong><br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-02-02 10:29:12'),
  ('28657284634', 'atestado', '<br />
<br />
<strong>Alimentos:</strong><br />
<strong>&nbsp;&nbsp;&nbsp;&nbsp;•&nbsp;&nbsp; &nbsp;Gema de ovo: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Clara de ovo: dissonante</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Peixe branco: ressonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Carne de frango: ressonante<br />
&nbsp;<strong>&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Carne bovina: dissonante</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;<strong>&nbsp; &nbsp;Sal de cozinha: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Sal do Himalaia: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Camarão: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Leite de vaca: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Café: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Farinha de trigo: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Carne suína: dissonante</strong><br />
<br />
<strong>Parasitas:</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Borrelia: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Herpes simples: dissonante<br />
<strong>&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Herpes zoster: ressonante</strong><br />
&nbsp;&nbsp; &nbsp;•<strong>&nbsp;&nbsp; &nbsp;Candida albicans: ressonante</strong><br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Clamídia: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Taenia saginatta: dissonante<br />
&nbsp;&nbsp; &nbsp;•&nbsp;&nbsp; &nbsp;Toxoplasma gondii: dissonante<br />
<br />
<br />
<br />
<strong>OBS: tudo que está em negrito são pontos de atenção.</strong><br />
<br />
Teste analisado e revisado por:<br />
Dra. Ana Carolina Candia Barra<br />
CRBM: 26073', 'Ana Carolina Candia Barra', '2026-02-02 10:55:59'),
  ('28657284634', 'atestado', '<p><span style=&quot;font-size:18px&quot;><strong>Protocolo Integrativo de Desparasitação e Simplelife</strong></span><br />
<br />
O <strong>5S Kit Desparasitação</strong> é um protocolo integrativo que auxilia no equilíbrio intestinal e na redução de desconfortos como excesso de gases, distensão abdominal, náuseas, refluxo, alterações do trânsito intestinal (diarreia ou constipação), além de impactos que podem refletir em pele, cabelo, unhas e energia.</p>

<p>Sua composição combina:</p>

<ul>
	<li>
	<p><strong>Essências vibracionais</strong>, que atuam no equilíbrio bioenergético do organismo.</p>
	</li>
	<li>
	<p><strong>Óleos essenciais</strong> como Melaleuca, Tomilho, Eucalipto e Manjericão, reconhecidos por suas propriedades antimicrobianas, anti-inflamatórias, digestivas e imunomoduladoras.</p>
	</li>
</ul>

<p>Entre os principais benefícios esperados estão:<br />
?? Melhora da digestão e absorção de nutrientes<br />
?? Redução de desconfortos gastrointestinais<br />
?? Fortalecimento do sistema imunológico<br />
?? Mais energia e bem-estar<br />
?? Apoio na redução de processos inflamatórios<br />
<br />
<br />
&nbsp;</p>

<p>O <strong>5S Simplelife</strong> é um modulador integrativo indicado para auxiliar no fortalecimento do sistema imunológico, no apoio aos processos naturais de desintoxicação e no equilíbrio interno do organismo.</p>

<p>Sua fórmula combina:</p>

<ul>
	<li>
	<p><strong>Essências vibracionais</strong>, que atuam no equilíbrio bioenergético celular.</p>
	</li>
	<li>
	<p><strong>Óleo essencial de alecrim</strong>, reconhecido por suas propriedades antioxidantes e anti-inflamatórias, auxiliando na proteção contra o estresse oxidativo e no suporte à desintoxicação.</p>
	</li>
</ul>

<p>Entre os principais benefícios esperados estão:<br />
?? Apoio ao equilíbrio metabólico do organismo<br />
?? Redução do estresse oxidativo<br />
?? Auxílio nos processos naturais de desintoxicação (fígado e rins)<br />
?? Fortalecimento da imunidade<br />
?? Mais energia e vitalidade<br />
<br />
<strong>Por essa razão, a Dra. indica a associação dos protocolos 5S Desparasitação + 5S Simplelife, visando um cuidado mais completo, organizado e seguro durante o processo de reequilíbrio do organismo.</strong><br />
<br />
&nbsp;</p>

<p>Os protocolos <strong>5S Desparasitação + 5S Simplelife</strong> são indicados de forma complementar porque, enquanto a desparasitação auxilia no equilíbrio intestinal e na redução de sobrecargas microbianas, o <strong>Simplelife</strong> atua apoiando os processos naturais de desintoxicação e fortalecendo o organismo durante esse processo.</p>

<p>Durante um protocolo de desparasitação, é comum que o corpo mobilize toxinas e metabólitos que estavam sobrecarregando o organismo. Em algumas pessoas, isso pode gerar reações transitórias como:</p>

<p>• leve dor de cabeça<br />
• cansaço<br />
• alterações intestinais temporárias<br />
• discreto mal-estar</p>

<p>Por isso, associamos o <strong>Simplelife</strong>, que auxilia fígado e rins nos processos naturais de eliminação, contribui para o equilíbrio metabólico e oferece suporte antioxidante e imunológico. Essa combinação tende a tornar o processo mais equilibrado, confortável e eficiente.</p>
', 'Ester Virginio dos Santos Tomaz', '2026-02-11 10:35:28'),
  ('28657284634', 'atestado', '<h2 style=&quot;font-style:italic;&quot;><span style=&quot;font-size:18px&quot;><strong>Protocolo Integrativo de Desparasitação e Simplelife</strong></span></h2>

<p><br />
O <strong>5S Kit Desparasitação</strong> é um protocolo integrativo que auxilia no equilíbrio intestinal e na redução de desconfortos como excesso de gases, distensão abdominal, náuseas, refluxo, alterações do trânsito intestinal (diarreia ou constipação), além de impactos que podem refletir em pele, cabelo, unhas e energia.</p>

<p>Sua composição combina:</p>

<ul>
	<li>
	<p><strong>Essências vibracionais</strong>, que atuam no equilíbrio bioenergético do organismo.</p>
	</li>
	<li>
	<p><strong>Óleos essenciais</strong> como Melaleuca, Tomilho, Eucalipto e Manjericão, reconhecidos por suas propriedades antimicrobianas, anti-inflamatórias, digestivas e imunomoduladoras.</p>
	</li>
</ul>

<p>Entre os principais benefícios esperados estão:</p>

<ul>
	<li>Melhora da digestão e absorção de nutriente</li>
	<li>Redução de desconfortos gastrointestinais</li>
	<li>Fortalecimento do sistema imunológico</li>
	<li>Mais energia e bem-estar</li>
	<li>Apoio na redução de processos inflamatórios</li>
</ul>

<p><br />
<br />
&nbsp;</p>

<p>O <strong>5S Simplelife</strong> é um modulador integrativo indicado para auxiliar no fortalecimento do sistema imunológico, no apoio aos processos naturais de desintoxicação e no equilíbrio interno do organismo.</p>

<p>Sua fórmula combina:</p>

<ul>
	<li>
	<p><strong>Essências vibracionais</strong>, que atuam no equilíbrio bioenergético celular.</p>
	</li>
	<li>
	<p><strong>Óleo essencial de alecrim</strong>, reconhecido por suas propriedades antioxidantes e anti-inflamatórias, auxiliando na proteção contra o estresse oxidativo e no suporte à desintoxicação.</p>
	</li>
</ul>

<p>Entre os principais benefícios esperados estão:</p>

<ul>
	<li>Apoio ao equilíbrio metabólico do organismo</li>
	<li>Redução do estresse oxidativo</li>
	<li>Auxílio nos processos naturais de desintoxicação (fígado e rins)</li>
	<li>Fortalecimento da imunidade</li>
	<li>Mais energia e vitalidade</li>
</ul>

<p><br />
<strong>Por essa razão, a Dra. indica a associação dos protocolos 5S Desparasitação + 5S Simplelife, visando um cuidado mais completo, organizado e seguro durante o processo de reequilíbrio do organismo.</strong><br />
<br />
&nbsp;</p>

<p>Os protocolos <strong>5S Desparasitação + 5S Simplelife</strong> são indicados de forma complementar porque, enquanto a desparasitação auxilia no equilíbrio intestinal e na redução de sobrecargas microbianas, o <strong>Simplelife</strong> atua apoiando os processos naturais de desintoxicação e fortalecendo o organismo durante esse processo.</p>

<p>Durante um protocolo de desparasitação, é comum que o corpo mobilize toxinas e metabólitos que estavam sobrecarregando o organismo. Em algumas pessoas, isso pode gerar reações transitórias como:</p>

<p>• leve dor de cabeça<br />
• cansaço<br />
• alterações intestinais temporárias<br />
• discreto mal-estar</p>

<p>Por isso, associamos o <strong>Simplelife</strong>, que auxilia fígado e rins nos processos naturais de eliminação, contribui para o equilíbrio metabólico e oferece suporte antioxidante e imunológico. Essa combinação tende a tornar o processo mais equilibrado, confortável e eficiente.</p>
', 'Ester Virginio dos Santos Tomaz', '2026-02-11 10:36:36'),
  ('91163471100', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética de elementos:
<ul>
	<li><strong>Pariri: dissonante</strong></li>
	<li>Cardia Verbenancia: ressonante</li>
	<li>Cardo Mariano:&nbsp;ressonante</li>
	<li><strong>Vermifugação: dissonante</strong></li>
</ul>
<br />
<strong>OBS.: OS ELEMENTOS EM NEGRTO DEVEM SER EVITADOS</strong><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong>', 'Ester Virginio dos Santos Tomaz', '2026-02-13 15:07:52'),
  ('36874608860', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética de alimentos:
<ul>
	<li><strong>Tomate: dissonante</strong></li>
	<li><strong>Batata inglesa: dissonante</strong></li>
	<li>Batata doce: ressonante</li>
	<li><strong>Alface:&nbsp;dissonante</strong></li>
	<li>Rúcula:&nbsp;ressonante</li>
	<li>Cenoura: neutro</li>
	<li>Arooz branco:&nbsp;ressonante</li>
	<li><strong>Feijão carioca:&nbsp;dissonante</strong></li>
	<li>Feijão preto:&nbsp;ressonante</li>
	<li><strong>Lentilha:&nbsp;dissonante</strong></li>
	<li><strong>Grão de bico:&nbsp;dissonante</strong></li>
	<li><strong>Ervilha:&nbsp;dissonante</strong></li>
	<li>Quinoa:&nbsp;ressonante</li>
	<li>Caju:&nbsp;neutro</li>
	<li><strong>Banana nanica:&nbsp;dissonante</strong></li>
	<li><strong>Banana prata:&nbsp;dissonante</strong></li>
	<li>Banana da terra:&nbsp;ressonante</li>
	<li><strong>Goiaba:&nbsp;dissonante</strong></li>
	<li>Uva verde:&nbsp;ressonante</li>
	<li>Abacaxi:&nbsp;ressonante</li>
	<li><strong>Abacate:&nbsp;dissonante</strong></li>
	<li><strong>Melancia:&nbsp;dissonante</strong></li>
	<li>Melão:&nbsp;ressonante</li>
	<li><strong>Brócolis:&nbsp;dissonante</strong></li>
	<li><strong>Couve flor:&nbsp;dissonante</strong></li>
	<li><strong>Alho:&nbsp;dissonante</strong></li>
	<li>Cebola:&nbsp;ressonante</li>
	<li>Cebolinha:&nbsp;ressonante</li>
	<li>Coentro:&nbsp;ressonante</li>
	<li><strong>Mel:&nbsp;dissonante</strong></li>
	<li><strong>Pasta de amendoim:&nbsp;dissonante</strong></li>
	<li>Castanha do Pará:&nbsp;ressonante</li>
	<li>Castanha de Cajú:&nbsp;ressonante</li>
	<li><strong>Amendoim:&nbsp;dissonante</strong></li>
	<li>Amêndoa:&nbsp;ressonante</li>
	<li><strong>Granola:&nbsp;dissonante</strong></li>
	<li><strong>Aveia:&nbsp;dissonante</strong></li>
	<li><strong>Suco de uva integral:&nbsp;dissonante</strong></li>
	<li><strong>Açaí:&nbsp;dissonante</strong></li>
</ul>
<br />
<br />
<br />
<strong>OBS.: OS ALIMENTOS EM NEGRTO DEVEM SER EVITADOS.</strong><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong>', 'Ester Virginio dos Santos Tomaz', '2026-02-13 15:17:35'),
  ('91163471100', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética de elementos:
<ul>
	<li><strong>Pariri: dissonante</strong></li>
	<li>Cardia Verbenancia: ressonante</li>
	<li>Cardo Mariano:&nbsp;ressonante</li>
	<li><strong>Vermifugação: dissonante</strong></li>
</ul>
<br />
<strong>OBS.: OS ELEMENTOS EM NEGRTO DEVEM SER EVITADOS.</strong><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong>', 'Ester Virginio dos Santos Tomaz', '2026-02-13 16:00:02'),
  ('91163471100', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética de elementos:
<ul>
	<li><strong>Pariri: dissonante</strong></li>
	<li>Cardia Verbenancia: ressonante</li>
	<li>Cardo Mariano:&nbsp;ressonante</li>
	<li><strong>Vermifugação: dissonante</strong></li>
</ul>
<br />
<strong>OBS.: OS ELEMENTOS EM NEGRTO DEVEM SER EVITADOS.</strong><br />
<br />
<span style=&quot;font-size:10px&quot;>&quot;Este documento constitui um laudo de avaliação bioenergética, um método não invasivo que analisa o campo de frequência funcional do organismo.&nbsp;<strong>Este teste não substitui exames médicos convencionais (clínicos, laboratoriais ou de imagem) e não se destina a diagnosticar, tratar, curar ou prevenir qualquer doença.</strong>&nbsp;Os resultados indicam apenas predisposições energéticas e desequilíbrios funcionais. A interpretação deve ser feita por um profissional qualificado dentro da saúde integrativa&quot;.</span><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica Patologista Clínica (funcional integrativa) – CRBM: 26073</strong>', 'Ester Virginio dos Santos Tomaz', '2026-02-13 16:47:33'),
  ('36874608860', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética de alimentos:
<ul>
	<li><strong>Tomate: dissonante</strong></li>
	<li><strong>Batata inglesa: dissonante</strong></li>
	<li>Batata doce: ressonante</li>
	<li><strong>Alface:&nbsp;dissonante</strong></li>
	<li>Rúcula:&nbsp;ressonante</li>
	<li>Cenoura: neutro</li>
	<li>Arooz branco:&nbsp;ressonante</li>
	<li><strong>Feijão carioca:&nbsp;dissonante</strong></li>
	<li>Feijão preto:&nbsp;ressonante</li>
	<li><strong>Lentilha:&nbsp;dissonante</strong></li>
	<li><strong>Grão de bico:&nbsp;dissonante</strong></li>
	<li><strong>Ervilha:&nbsp;dissonante</strong></li>
	<li>Quinoa:&nbsp;ressonante</li>
	<li>Caju:&nbsp;neutro</li>
	<li><strong>Banana nanica:&nbsp;dissonante</strong></li>
	<li><strong>Banana prata:&nbsp;dissonante</strong></li>
	<li>Banana da terra:&nbsp;ressonante</li>
	<li><strong>Goiaba:&nbsp;dissonante</strong></li>
	<li>Uva verde:&nbsp;ressonante</li>
	<li>Abacaxi:&nbsp;ressonante</li>
	<li><strong>Abacate:&nbsp;dissonante</strong></li>
	<li><strong>Melancia:&nbsp;dissonante</strong></li>
	<li>Melão:&nbsp;ressonante</li>
	<li><strong>Brócolis:&nbsp;dissonante</strong></li>
	<li><strong>Couve flor:&nbsp;dissonante</strong></li>
	<li><strong>Alho:&nbsp;dissonante</strong></li>
	<li>Cebola:&nbsp;ressonante</li>
	<li>Cebolinha:&nbsp;ressonante</li>
	<li>Coentro:&nbsp;ressonante</li>
	<li><strong>Mel:&nbsp;dissonante</strong></li>
	<li><strong>Pasta de amendoim:&nbsp;dissonante</strong></li>
	<li>Castanha do Pará:&nbsp;ressonante</li>
	<li>Castanha de Cajú:&nbsp;ressonante</li>
	<li><strong>Amendoim:&nbsp;dissonante</strong></li>
	<li>Amêndoa:&nbsp;ressonante</li>
	<li><strong>Granola:&nbsp;dissonante</strong></li>
	<li><strong>Aveia:&nbsp;dissonante</strong></li>
	<li><strong>Suco de uva integral:&nbsp;dissonante</strong></li>
	<li><strong>Açaí:&nbsp;dissonante</strong></li>
</ul>
<br />
<strong>OBS.: OS ALIMENTOS EM NEGRTO DEVEM SER EVITADOS.</strong><br />
<br />
<span style=&quot;font-size:10px&quot;>&quot;Este documento constitui um laudo de avaliação bioenergética, um método não invasivo que analisa o campo de frequência funcional do organismo.&nbsp;<strong>Este teste não substitui exames médicos convencionais (clínicos, laboratoriais ou de imagem) e não se destina a diagnosticar, tratar, curar ou prevenir qualquer doença.</strong>&nbsp;Os resultados indicam apenas predisposições energéticas e desequilíbrios funcionais. A interpretação deve ser feita por um profissional qualificado dentro da saúde integrativa&quot;.</span><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica Patologista Clínica (funcional integrativa) – CRBM: 26073</strong>', 'Ester Virginio dos Santos Tomaz', '2026-02-13 16:51:38'),
  ('36874608860', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética de alimentos:
<ul>
	<li><strong>Tomate: dissonante</strong></li>
	<li><strong>Batata inglesa: dissonante</strong></li>
	<li>Batata doce: ressonante</li>
	<li><strong>Alface:&nbsp;dissonante</strong></li>
	<li>Rúcula:&nbsp;ressonante</li>
	<li>Cenoura: neutro</li>
	<li>Arooz branco:&nbsp;ressonante</li>
	<li><strong>Feijão carioca:&nbsp;dissonante</strong></li>
	<li>Feijão preto:&nbsp;ressonante</li>
	<li><strong>Lentilha:&nbsp;dissonante</strong></li>
	<li><strong>Grão de bico:&nbsp;dissonante</strong></li>
	<li><strong>Ervilha:&nbsp;dissonante</strong></li>
	<li>Quinoa:&nbsp;ressonante</li>
	<li>Caju:&nbsp;neutro</li>
	<li><strong>Banana nanica:&nbsp;dissonante</strong></li>
	<li><strong>Banana prata:&nbsp;dissonante</strong></li>
	<li>Banana da terra:&nbsp;ressonante</li>
	<li><strong>Goiaba:&nbsp;dissonante</strong></li>
	<li>Uva verde:&nbsp;ressonante</li>
	<li>Abacaxi:&nbsp;ressonante</li>
	<li><strong>Abacate:&nbsp;dissonante</strong></li>
	<li><strong>Melancia:&nbsp;dissonante</strong></li>
	<li>Melão:&nbsp;ressonante</li>
	<li><strong>Brócolis:&nbsp;dissonante</strong></li>
	<li><strong>Couve flor:&nbsp;dissonante</strong></li>
	<li><strong>Alho:&nbsp;dissonante</strong></li>
	<li>Cebola:&nbsp;ressonante</li>
	<li>Cebolinha:&nbsp;ressonante</li>
	<li>Coentro:&nbsp;ressonante</li>
	<li><strong>Mel:&nbsp;dissonante</strong></li>
	<li><strong>Pasta de amendoim:&nbsp;dissonante</strong></li>
	<li>Castanha do Pará:&nbsp;ressonante</li>
	<li>Castanha de Cajú:&nbsp;ressonante</li>
	<li><strong>Amendoim:&nbsp;dissonante</strong></li>
	<li>Amêndoa:&nbsp;ressonante</li>
	<li><strong>Granola:&nbsp;dissonante</strong></li>
	<li><strong>Aveia:&nbsp;dissonante</strong></li>
	<li><strong>Suco de uva integral:&nbsp;dissonante</strong></li>
	<li><strong>Açaí:&nbsp;dissonante</strong></li>
</ul>
<br />
<strong>OBS.: OS ALIMENTOS EM NEGRTO DEVEM SER EVITADOS.</strong><br />
<br />
<span style=&quot;font-size:10px&quot;>&quot;Este documento constitui um laudo de avaliação bioenergética, um método não invasivo que analisa o campo de frequência funcional do organismo.&nbsp;Este teste não substitui exames médicos convencionais (clínicos, laboratoriais ou de imagem) e não se destina a diagnosticar, tratar, curar ou prevenir qualquer doença.&nbsp;Os resultados indicam apenas predisposições energéticas e desequilíbrios funcionais. A interpretação deve ser feita por um profissional qualificado dentro da saúde integrativa&quot;.</span><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica Patologista Clínica (funcional integrativa) – CRBM: 26073</strong>', 'Ester Virginio dos Santos Tomaz', '2026-02-13 16:52:06'),
  ('91163471100', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>
<br />
Sensibilidade energética de elementos:
<ul>
	<li><strong>Pariri: dissonante</strong></li>
	<li>Cardia Verbenancia: ressonante</li>
	<li>Cardo Mariano:&nbsp;ressonante</li>
	<li><strong>Vermifugação: dissonante</strong></li>
</ul>
<br />
<strong>OBS.: OS ELEMENTOS EM NEGRTO DEVEM SER EVITADOS.</strong><br />
<br />
<span style=&quot;font-size:10px&quot;>&quot;Este documento constitui um laudo de avaliação bioenergética, um método não invasivo que analisa o campo de frequência funcional do organismo.&nbsp;Este teste não substitui exames médicos convencionais (clínicos, laboratoriais ou de imagem) e não se destina a diagnosticar, tratar, curar ou prevenir qualquer doença.&nbsp;Os resultados indicam apenas predisposições energéticas e desequilíbrios funcionais. A interpretação deve ser feita por um profissional qualificado dentro da saúde integrativa&quot;.</span><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica Patologista Clínica (funcional integrativa) – CRBM: 26073</strong>', 'Ester Virginio dos Santos Tomaz', '2026-02-13 16:53:12'),
  ('85260665104', 'atestado', '<h1><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>Tratamento probiome&nbsp;<br />
<br />
FASE 1 — Alimentação&nbsp;Antifermentativa (4 semanas)</span></span></h1>

<p><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>Objetivo:</span></span></p>

<ul>
	<li>
	<p><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>reduzir substrato para <strong>Firmicutes</strong></span></span></p>
	</li>
	<li>
	<p><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>diminuir <strong>produção de metano</strong></span></span></p>
	</li>
	<li>
	<p><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>reduzir <strong>distensão intestinal</strong></span></span></p>
	</li>
	<li>
	<p><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>melhorar <strong>motilidade</strong></span></span></p>
	</li>
</ul>

<p><span style=&quot;font-size:12px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>Essa fase é <strong>temporária</strong>.</span></span><br />
<br />
&nbsp;</p>

<h1>Alimentos que devem ser evitados (4 semanas)</h1>

<p>Principais fermentadores:</p>

<p>açúcar<br />
mel<br />
frutas muito doces<br />
farinha de trigo<br />
pão<br />
massas<br />
aveia<br />
feijão<br />
lentilha<br />
grão de bico<br />
leite<br />
queijos frescos<br />
cebola<br />
alho cru<br />
couve-flor<br />
brócolis cru<br />
repolho<br />
batata doce em excesso<br />
banana madura</p>

<p>Esses alimentos alimentam muito:</p>

<ul>
	<li>
	<p><strong>Firmicutes</strong></p>
	</li>
	<li>
	<p><strong>arqueias metanogênicas</strong><br />
	<br />
	<span style=&quot;font-size:20px&quot;>Alimentos liberados</span></p>

	<p><strong>Proteínas:</strong></p>

	<p>peixe<br />
	frango<br />
	ovos<br />
	carne vermelha magra</p>

	<p><strong>Gorduras boas:</strong></p>

	<p>azeite<br />
	abacate<br />
	coco<br />
	ghee</p>

	<p><strong>Vegetais pouco fermentativos:</strong></p>

	<p>abobrinha<br />
	cenoura<br />
	pepino<br />
	alface<br />
	rúcula<br />
	espinafre<br />
	berinjela<br />
	tomate</p>

	<p><strong>Frutas com baixa fermentação:</strong></p>

	<p>morango<br />
	mirtilo<br />
	kiwi&nbsp;<br />
	limão<br />
	<br />
	<strong>Carboidrato&nbsp;</strong><br />
	<br />
	arroz branco porção moderada<br />
	&nbsp;</p>

	<h1>Estrutura do dia alimentar</h1>
	jejum - café com 1 colher de oleo de coco</li>
	<li>&nbsp;</li>
	<li>Café da manhã</li>
	<li>Opção 1</li>
	<li>
	<p>2 ovos<br />
	abacate<br />
	chá verde</p>

	<p>Opção 2<br />
	omelete com espinafre<br />
	azeite<br />
	frutas vermelhas</p>

	<p>Opção 3<br />
	iogurte de coco natural<br />
	mirtilo<br />
	sementes de chia</p>

	<hr />
	<h3>Almoço</h3>

	<p>Proteína:<br />
	120–150 pesar depois de pronta<br />
	<br />
	carboidrato : arroz branco porção moderada</p>
	</li>
	<li>
	<p>Vegetais cozidos: abobrinha, cenoura, berinjela etc...</p>
	</li>
	<li>
	<p>salada verde</p>
	</li>
	<li>
	<p>azeite</p>

	<hr />
	<h3>Lanche</h3>

	<p>opção 1<br />
	castanhas - 5 unidades</p>

	<p>opção 2<br />
	kiwi</p>

	<p>opção 3<br />
	ovo cozido</p>

	<hr />
	<h3>Jantar</h3>

	<p>Proteína<br />
	120 g<br />
	salada verde á vontade&nbsp;<br />
	legumes cozidos á vontade&nbsp;</p>
	</li>
</ul>

<p><br />
<br />
&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-03-05 09:35:57'),
  ('07943713109', 'atestado', 'Orientações Alimentares – Fase de Reequilíbrio Metabólico e Intestinal<br />
<br />
<strong>1-&nbsp; Alimentos que devemos EVITAR por enquanto</strong><br />
(aproximadamente 6–8 semanas)<br />
<br />
Esses alimentos podem aumentar inflamação, fermentação intestinal e liberação de histamina.<br />
<br />
<strong>Açúcares e ultraprocessados<br />
doces<br />
chocolate<br />
balas<br />
refrigerantes<br />
bolos industrializados<br />
biscoitos recheados<br />
Farinhas refinadas<br />
pão branco<br />
massas<br />
pizza<br />
salgados de padaria<br />
Laticínios<br />
leite<br />
whey protein concentrado<br />
queijos<br />
iogurte comum<br />
Alimentos ricos em histamina<br />
embutidos<br />
alimentos fermentados<br />
vinagre<br />
molho shoyu<br />
vinho<br />
tomate<br />
berinjela<br />
espinafre</strong><br />
Esses alimentos podem piorar sintomas como:<br />
enxaqueca<br />
rosácea<br />
rinite<br />
distensão abdominal.<br />
<br />
<strong>2-Alimentos que devemos REDUZIR</strong><br />
Não precisam ser totalmente excluídos, mas devem ser consumidos com moderação.<br />
café (máx. 1 xícara por dia)<br />
chocolate 70%<br />
alimentos muito condimentados<br />
<br />
<strong>3 - Alimentos que devem ser PRIORIDADE - incluir na alimentação</strong><br />
A base da alimentação deve ser composta por alimentos naturais que ajudem a reduzir inflamação e estabilizar energia.<br />
<br />
<strong>Proteínas (muito importante)</strong><br />
Como&nbsp; não consome carne ou frango, precisamos garantir ingestão adequada de proteína.<br />
<strong>Priorizar: pode pesar em média 150 g ou 3 ovos<br />
<br />
ovos<br />
peixes frescos<br />
proteína vegetal (ervilha ou arroz)<br />
quinoa<br />
sementes (abóbora, girassol, chia).<br />
<br />
Carboidratos de boa qualidade<br />
arroz<br />
batata<br />
batata doce<br />
mandioca<br />
quinoa.</strong><br />
<br />
<strong>Vegetais e legumes</strong><br />
Priorizar principalmente:<br />
<strong>abobrinha<br />
cenoura<br />
chuchu<br />
brócolis<br />
couve-flor<br />
pepino<br />
alface<br />
rúcula.</strong><br />
Consumir preferencialmente cozidos ou levemente refogados, para facilitar a digestão.<br />
<br />
<strong>Gorduras saudáveis</strong><br />
Importantes para equilíbrio hormonal e inflamatório.<br />
<strong>azeite de oliva<br />
óleo de coco<br />
abacate (pequena quantidade)<br />
castanha do pará</strong><br />
<strong>sementes.</strong><br />
<br />
<br />
<strong>4 Organização das refeições</strong><br />
Para ajudar no controle da energia e da compulsão por doces:<br />
evitar longos períodos em jejum<br />
<br />
incluir proteína em todas as refeições<br />
manter 3 refeições principais + 1 ou 2 lanches.<br />
<br />
<strong>Exemplo simples de estrutura diária</strong><br />
Café da manhã<br />
ovos mexidos ou omelete<br />
tapioca ou fruta<br />
chá ou café.<br />
<br />
Almoço<br />
peixe ou ovos<br />
arroz ou batata<br />
legumes<br />
azeite.<br />
<br />
Lanche da tarde&nbsp;<br />
castanhas ou ovo cozido<br />
ou<br />
shake de proteína vegetal. ( whey vegetal)<br />
Jantar<br />
sopa de legumes com ovos<br />
ou<br />
peixe + legumes.<br />
<br />
<strong>5-&nbsp; Hidratação</strong><br />
pelo menos 2 litros de água por dia<br />
chás digestivos podem ajudar:<br />
gengibre<br />
hortelã<br />
erva-doce.', 'Ana Carolina Candia Barra', '2026-03-11 17:34:15'),
  ('75538784134', 'atestado', '<h1>1. O sintoma central do caso</h1>

<p>A paciente apresenta:</p>

<ul>
	<li>
	<p><strong>Tosse persistente há 3 anos</strong></p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
	<li>
	<p><strong>Imunidade respiratória baixa</strong></p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
	<li>
	<p><strong>Diagnóstico prévio de bronquite</strong></p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
	<li>
	<p><strong>Secreção clara</strong></p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>Isso indica que <strong>não é um quadro agudo</strong>, mas sim <strong>crônico e multifatorial</strong>.</p>

<p>Quando uma tosse dura <strong>anos</strong>, na medicina integrativa geralmente investigamos <strong>3 eixos principais</strong>:</p>

<p>1?? eixo digestivo<br />
2?? eixo imunológico<br />
3?? eixo inflamatório respiratório</p>

<p>E nesse caso <strong>os três aparecem alterados</strong>.</p>

<hr />
<h1>2. Um ponto muito relevante: refluxo confirmado</h1>

<p>A endoscopia mostrou:</p>

<ul>
	<li>
	<p><strong>Esofagite por refluxo grau A (Los Angeles)</strong></p>
	</li>
	<li>
	<p><strong>pangastrite</strong></p>
	</li>
	<li>
	<p><strong>lesões hemorrágicas planas</strong></p>
	</li>
	<li>
	<p><strong>H. pylori negativo</strong></p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>Isso muda bastante o raciocínio.</p>

<h3>Por quê?</h3>

<p><strong>Refluxo é uma das causas mais comuns de tosse crônica em jovens.</strong></p>

<p>Existe algo chamado:</p>

<p><strong>Refluxo laringofaríngeo</strong></p>

<p>O ácido sobe até a garganta e irrita:</p>

<ul>
	<li>
	<p>laringe</p>
	</li>
	<li>
	<p>traqueia</p>
	</li>
	<li>
	<p>vias respiratórias</p>
	</li>
</ul>

<p>Resultado:</p>

<ul>
	<li>
	<p>tosse persistente</p>
	</li>
	<li>
	<p>pigarro</p>
	</li>
	<li>
	<p>sensação de secreção</p>
	</li>
</ul>

<p>E muitas vezes <strong>não responde a bombinha de bronquite</strong>, exatamente como relatado.</p>

<hr />
<h1>3. Intestino claramente alterado</h1>

<p>A paciente apresenta:</p>

<ul>
	<li>
	<p>constipação (evacua a cada 2 dias)</p>
	</li>
	<li>
	<p>fezes Bristol <strong>1 a 3</strong> (ressecadas)</p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
	<li>
	<p>gases e distensão abdominal</p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>Isso indica <strong>trânsito intestinal lento</strong>.</p>

<p>Na medicina integrativa isso pode gerar:</p>

<ul>
	<li>
	<p>aumento de toxinas circulantes</p>
	</li>
	<li>
	<p>inflamação sistêmica</p>
	</li>
	<li>
	<p>piora da imunidade</p>
	</li>
</ul>

<p>Além disso, o intestino preso favorece:</p>

<p><strong>refluxo gastroesofágico</strong></p>

<p>porque aumenta a pressão abdominal.</p>

<hr />
<h1>4. Histórico pulmonar prévio</h1>

<p>Outro dado importante:</p>

<ul>
	<li>
	<p><strong>pneumonia em 2016</strong></p>
	</li>
	<li>
	<p>sinais de <strong>broncopatia inflamatória</strong></p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>Isso sugere que o pulmão pode ter ficado <strong>mais sensível ou hiper-reativo</strong>.</p>

<p>Então hoje ela pode ter uma combinação de:</p>

<ul>
	<li>
	<p>inflamação pulmonar residual</p>
	</li>
	<li>
	<p>refluxo irritando vias respiratórias</p>
	</li>
	<li>
	<p>imunidade baixa</p>
	</li>
</ul>

<hr />
<h1>5. Uso recorrente de antibióticos</h1>

<p>Foi relatado:</p>

<ul>
	<li>
	<p>azitromicina</p>
	</li>
	<li>
	<p>amoxicilina</p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>E a mãe relata que <strong>piora após antibiótico</strong>.</p>

<p>Isso é um sinal clássico de:</p>

<h3>disbiose intestinal</h3>

<p>Antibióticos podem:</p>

<ul>
	<li>
	<p>reduzir bactérias benéficas</p>
	</li>
	<li>
	<p>aumentar fungos</p>
	</li>
	<li>
	<p>alterar imunidade mucosa</p>
	</li>
</ul>

<p>E isso afeta diretamente:</p>

<p><strong>intestino – pulmão – imunidade</strong></p>

<p>Existe inclusive o conceito chamado:</p>

<p><strong>Eixo intestino–pulmão</strong></p>

<hr />
<h1>6. Um detalhe comportamental que merece atenção</h1>

<p>Na anamnese aparece:</p>

<p>quando a tosse está forte ela fica feliz apenas com o celular, e sem ele fica irritada</p>

<p>Anamnese - Angela Yusuf</p>

<p>Isso pode parecer irrelevante, mas na prática clínica pode indicar:</p>

<ul>
	<li>
	<p>mecanismo de compensação emocional</p>
	</li>
	<li>
	<p>ansiedade</p>
	</li>
	<li>
	<p>hiperfoco como distração da tosse</p>
	</li>
</ul>

<p>Outro ponto:</p>

<ul>
	<li>
	<p>relação difícil com o pai</p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>Estresse emocional crônico pode alterar:</p>

<ul>
	<li>
	<p>eixo HPA (cortisol)</p>
	</li>
	<li>
	<p>imunidade</p>
	</li>
	<li>
	<p>inflamação respiratória.</p>
	</li>
</ul>

<p>Não significa que a causa seja psicológica, mas pode <strong>agravar o quadro inflamatório</strong>.</p>

<hr />
<h1>7. Outro dado interessante: possível gatilho após vacina</h1>

<p>A mãe relata que:</p>

<p>os sintomas começaram após a segunda dose da vacina covid</p>

<p>Anamnese - Angela Yusuf</p>

<p>Aqui é importante ter <strong>cuidado na interpretação</strong>.</p>

<p>Três possibilidades:</p>

<p>1?? coincidência temporal<br />
2?? desregulação imunológica transitória<br />
3?? exacerbação de inflamação pré-existente</p>

<p>Mas como ela já tinha histórico pulmonar (pneumonia e broncopatia), pode ter ocorrido apenas <strong>uma reativação de inflamação respiratória</strong>.</p>

<hr />
<h1>8. Avaliação nutricional</h1>

<p>Outro ponto que chama atenção:</p>

<ul>
	<li>
	<p><strong>músculos muito baixos</strong></p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>Isso sugere:</p>

<ul>
	<li>
	<p>baixa ingestão proteica</p>
	</li>
	<li>
	<p>absorção prejudicada</p>
	</li>
	<li>
	<p>possível déficit de micronutrientes</p>
	</li>
</ul>

<p>Deficiências comuns em quadros assim:</p>

<ul>
	<li>
	<p>vitamina D</p>
	</li>
	<li>
	<p>zinco</p>
	</li>
	<li>
	<p>ferro</p>
	</li>
	<li>
	<p>B12</p>
	</li>
</ul>

<p>Todos essenciais para imunidade.</p>

<hr />
<h1>9. Hipótese integrativa mais provável</h1>

<p>Se juntarmos todos os dados, o quadro mais coerente seria:</p>

<h3>Eixo digestivo alterado</h3>

<ul>
	<li>
	<p>gastrite</p>
	</li>
	<li>
	<p>refluxo</p>
	</li>
	<li>
	<p>intestino preso</p>
	</li>
	<li>
	<p>disbiose</p>
	</li>
</ul>

<p>?</p>

<h3>Inflamação de mucosa respiratória</h3>

<ul>
	<li>
	<p>tosse crônica</p>
	</li>
	<li>
	<p>broncopatia inflamatória</p>
	</li>
</ul>

<p>?</p>

<h3>Imunidade mucosal fragilizada</h3>

<ul>
	<li>
	<p>infecções respiratórias recorrentes.</p>
	</li>
</ul>

<hr />
<h1>10. O que eu investigaria antes de fechar diagnóstico</h1>

<p>Alguns exames seriam muito úteis:</p>

<h3>inflamação e imunidade</h3>

<ul>
	<li>
	<p>PCR ultrassensível</p>
	</li>
	<li>
	<p>IgE total</p>
	</li>
	<li>
	<p>eosinófilos</p>
	</li>
</ul>

<h3>estado nutricional</h3>

<ul>
	<li>
	<p>ferritina</p>
	</li>
	<li>
	<p>vitamina D</p>
	</li>
	<li>
	<p>B12</p>
	</li>
	<li>
	<p>zinco</p>
	</li>
</ul>

<h3>eixo intestinal</h3>

<ul>
	<li>
	<p>parasitológico</p>
	</li>
	<li>
	<p>microbiota fecal</p>
	</li>
	<li>
	<p>calprotectina</p>
	</li>
</ul>

<h3>digestivo</h3>

<ul>
	<li>
	<p>teste de SIBO</p>
	</li>
	<li>
	<p>pepsina salivar (refluxo silencioso)</p>
	</li>
</ul>

<hr />
<h1>11. Conduta proposta na anamnese</h1>

<p>A linha de raciocínio colocada no documento foi:</p>

<ul>
	<li>
	<p>modulação gástrica e intestinal</p>
	</li>
	<li>
	<p>teste genético da microbiota</p>
	</li>
	<li>
	<p>desparasitação</p>
	</li>
	<li>
	<p>consulta nutricional</p>
	</li>
	<li>
	<p>teste de incompatibilidade alimentar</p>

	<p>Anamnese - Angela Yusuf</p>
	</li>
</ul>

<p>De forma estratégica, <strong>faz sentido</strong>, mas tem um ponto de atenção:</p>

<p>?? <strong>desparasitação empírica em adolescente sem exame positivo pode não ser a melhor primeira abordagem</strong>.</p>

<p>Talvez seja mais prudente:</p>

<p>1?? exame parasitológico primeiro<br />
2?? depois tratar.</p>

<hr />
<h1>12. Síntese clínica do caso</h1>

<p>Este parece ser um quadro de:</p>

<p><strong>tosse crônica multifatorial</strong></p>

<p>com provável combinação de:</p>

<ul>
	<li>
	<p>refluxo gastroesofágico</p>
	</li>
	<li>
	<p>disbiose intestinal</p>
	</li>
	<li>
	<p>inflamação respiratória residual</p>
	</li>
	<li>
	<p>imunidade mucosal baixa.</p>
	</li>
</ul>

<p>O intestino provavelmente é <strong>o eixo central do problema</strong>.</p>

<hr />
<p>A bioimpedância traz informações importantes que <strong>reforçam alguns pontos clínicos da anamnese</strong>, mas também levanta <strong>contradições que precisam ser interpretadas com cautela</strong> antes de tirar conclusões. Vou cruzar <strong>bioimpedância + sintomas + histórico clínico</strong> para uma leitura integrativa mais estratégica.</p>

<hr />
<h1>1. Primeiro ponto crítico: composição corporal incoerente para a idade</h1>

<p>Dados principais do exame:</p>

<ul>
	<li>
	<p><strong>Peso:</strong> 51,1 kg</p>
	</li>
	<li>
	<p><strong>Altura:</strong> 158 cm</p>
	</li>
	<li>
	<p><strong>IMC:</strong> 20,5 (dentro do normal)</p>
	</li>
	<li>
	<p><strong>Gordura corporal:</strong> <strong>40,9% (muito alta)</strong></p>
	</li>
	<li>
	<p><strong>Massa muscular:</strong> <strong>baixa</strong></p>
	</li>
	<li>
	<p><strong>Água corporal:</strong> <strong>baixa</strong></p>
	</li>
	<li>
	<p><strong>Massa proteica:</strong> <strong>baixa</strong></p>
	</li>
</ul>

<p>Isso caracteriza um padrão chamado:</p>

<h3><strong>“obesidade sarcopênica oculta”</strong></h3>

<p>ou também conhecido como <strong>skinny fat</strong>.</p>

<p>Ou seja:</p>

<ul>
	<li>
	<p>peso aparentemente normal</p>
	</li>
	<li>
	<p><strong>muita gordura</strong></p>
	</li>
	<li>
	<p><strong>pouco músculo</strong></p>
	</li>
</ul>

<p>Isso <strong>combina exatamente com a observação da anamnese:</strong></p>

<p>“músculos muito baixos”</p>

<hr />
<h1>2. Distribuição muscular extremamente baixa</h1>

<p>O exame mostra:</p>

<ul>
	<li>
	<p>músculo esquelético <strong>15,8 kg (baixo)</strong></p>
	</li>
	<li>
	<p>massa muscular total <strong>28,2 kg (baixo)</strong></p>
	</li>
	<li>
	<p>SMI <strong>4,7 kg/m² (baixo)</strong></p>
	</li>
</ul>

<p>E no mapa corporal:</p>

<ul>
	<li>
	<p>braços: <strong>baixo</strong></p>
	</li>
	<li>
	<p>tronco: <strong>baixo</strong></p>
	</li>
	<li>
	<p>pernas: <strong>baixo</strong></p>
	</li>
</ul>

<p>Isso indica:</p>

<h3>baixa reserva metabólica</h3>

<p>Consequências metabólicas importantes:</p>

<ul>
	<li>
	<p>imunidade mais fraca</p>
	</li>
	<li>
	<p>maior fadiga</p>
	</li>
	<li>
	<p>pior recuperação de infecções</p>
	</li>
	<li>
	<p>maior inflamação sistêmica</p>
	</li>
</ul>

<p>Isso <strong>se conecta diretamente com:</strong></p>

<ul>
	<li>
	<p>imunidade respiratória baixa</p>
	</li>
	<li>
	<p>infecções recorrentes</p>
	</li>
	<li>
	<p>broncopatia inflamatória.</p>
	</li>
</ul>

<hr />
<h1>3. Gordura corporal extremamente alta para idade</h1>

<p>A taxa de gordura é:</p>

<p><strong>40,9%</strong></p>

<p>Para adolescentes do sexo feminino o esperado seria aproximadamente:</p>

<ul>
	<li>
	<p>saudável: <strong>20–30%</strong></p>
	</li>
</ul>

<p>Portanto há <strong>excesso real de gordura corporal</strong>, apesar do peso não ser alto.</p>

<p>Isso indica provável:</p>

<h3>inflamação metabólica silenciosa</h3>

<p>Tecido adiposo produz citocinas inflamatórias:</p>

<ul>
	<li>
	<p>IL-6</p>
	</li>
	<li>
	<p>TNF-alpha</p>
	</li>
	<li>
	<p>leptina inflamatória</p>
	</li>
</ul>

<p>Essas substâncias podem:</p>

<ul>
	<li>
	<p>piorar inflamação pulmonar</p>
	</li>
	<li>
	<p>aumentar alergias</p>
	</li>
	<li>
	<p>reduzir imunidade antiviral.</p>
	</li>
</ul>

<p>Isso ajuda a explicar a <strong>tosse crônica e a broncopatia inflamatória.</strong></p>

<hr />
<h1>4. Baixa água corporal</h1>

<p>Água corporal:</p>

<p><strong>43,3% (baixo)</strong></p>

<p>Ideal em adolescentes:</p>

<p><strong>50–60%</strong></p>

<p>Baixa hidratação celular pode indicar:</p>

<ul>
	<li>
	<p>baixa massa muscular</p>
	</li>
	<li>
	<p>disbiose intestinal</p>
	</li>
	<li>
	<p>estado inflamatório</p>
	</li>
	<li>
	<p>baixa ingestão proteica.</p>
	</li>
</ul>

<p>Também favorece:</p>

<ul>
	<li>
	<p>secreção respiratória mais espessa</p>
	</li>
	<li>
	<p>pior eliminação de muco.</p>
	</li>
</ul>

<hr />
<h1>5. Massa proteica muito baixa</h1>

<p>Massa proteica:</p>

<p><strong>6,0 kg (baixo)</strong></p>

<p>Isso sugere:</p>

<ul>
	<li>
	<p>ingestão proteica insuficiente<br />
	ou</p>
	</li>
	<li>
	<p>absorção intestinal prejudicada.</p>
	</li>
</ul>

<p>Lembrando que a paciente tem:</p>

<ul>
	<li>
	<p>gastrite</p>
	</li>
	<li>
	<p>esofagite</p>
	</li>
	<li>
	<p>constipação intestinal.</p>
	</li>
</ul>

<p>Problemas digestivos podem reduzir:</p>

<ul>
	<li>
	<p>absorção de aminoácidos</p>
	</li>
	<li>
	<p>síntese muscular.</p>
	</li>
</ul>

<hr />
<h1>6. Relação direta com os sintomas respiratórios</h1>

<p>O sistema imune depende muito de proteína e músculo.</p>

<p>Baixa massa muscular reduz produção de:</p>

<ul>
	<li>
	<p>glutamina</p>
	</li>
	<li>
	<p>imunoglobulinas</p>
	</li>
	<li>
	<p>citocinas reguladoras</p>
	</li>
</ul>

<p>Isso pode gerar:</p>

<ul>
	<li>
	<p>infecções respiratórias recorrentes</p>
	</li>
	<li>
	<p>tosse crônica</p>
	</li>
	<li>
	<p>recuperação lenta.</p>
	</li>
</ul>

<p>Ou seja, o pulmão pode não ser o problema principal.</p>

<p><strong>O problema pode ser metabólico e intestinal.</strong></p>

<hr />
<h1>7. Gordura visceral moderada</h1>

<p>O exame mostra:</p>

<p><strong>gordura visceral = 9</strong></p>

<p>Não é extremamente alto, mas está <strong>no limite de risco</strong>.</p>

<p>Isso reforça possível:</p>

<ul>
	<li>
	<p>inflamação sistêmica</p>
	</li>
	<li>
	<p>alteração metabólica.</p>
	</li>
</ul>

<hr />
<h1>8. Outro detalhe importante: metabolismo basal muito baixo</h1>

<p>Taxa metabólica basal:</p>

<p><strong>1022 kcal</strong></p>

<p>Para uma adolescente de 15 anos é <strong>baixo</strong>.</p>

<p>Isso pode indicar:</p>

<ul>
	<li>
	<p>baixa massa muscular</p>
	</li>
	<li>
	<p>metabolismo lento</p>
	</li>
	<li>
	<p>possível adaptação metabólica.</p>
	</li>
</ul>

<hr />
<h1>9. Conectando tudo com a anamnese</h1>

<p>Se juntarmos:</p>

<h3>digestivo</h3>

<ul>
	<li>
	<p>gastrite</p>
	</li>
	<li>
	<p>refluxo</p>
	</li>
	<li>
	<p>intestino preso</p>
	</li>
</ul>

<h3>metabólico</h3>

<ul>
	<li>
	<p>baixa massa muscular</p>
	</li>
	<li>
	<p>gordura corporal alta</p>
	</li>
	<li>
	<p>baixa proteína corporal</p>
	</li>
</ul>

<h3>imunológico</h3>

<ul>
	<li>
	<p>imunidade respiratória baixa</p>
	</li>
	<li>
	<p>broncopatia inflamatória</p>
	</li>
</ul>

<h3>respiratório</h3>

<ul>
	<li>
	<p>tosse crônica.</p>
	</li>
</ul>

<p>Forma-se um quadro coerente de:</p>

<h3>disfunção metabólica + inflamação intestinal</h3>

<p>que acaba repercutindo no pulmão.</p>

<hr />
<h1>10. Algo que merece investigação</h1>

<p>Um ponto que não pode ser ignorado:</p>

<p><strong>40% de gordura corporal em adolescente magra não é comum.</strong></p>

<p>Pode estar relacionado a:</p>

<ul>
	<li>
	<p>sedentarismo</p>
	</li>
	<li>
	<p>dieta pobre em proteína</p>
	</li>
	<li>
	<p>resistência à insulina inicial</p>
	</li>
	<li>
	<p>disbiose intestinal</p>
	</li>
	<li>
	<p>inflamação crônica.</p>
	</li>
</ul>

<p>Por isso seria interessante avaliar:</p>

<ul>
	<li>
	<p>insulina</p>
	</li>
	<li>
	<p>HOMA-IR</p>
	</li>
	<li>
	<p>vitamina D</p>
	</li>
	<li>
	<p>ferritina</p>
	</li>
	<li>
	<p>B12</p>
	</li>
	<li>
	<p>zinco.</p>
	</li>
</ul>

<hr />
<h1>11. Algo que eu ajustaria na conduta proposta</h1>

<p>A estratégia da anamnese focou em:</p>

<ul>
	<li>
	<p>microbiota</p>
	</li>
	<li>
	<p>desparasitação</p>
	</li>
	<li>
	<p>intolerâncias alimentares.</p>
	</li>
</ul>

<p>Isso é válido, mas <strong>talvez não seja suficiente</strong>.</p>

<p>O eixo <strong>muscular-metabólico</strong> também precisa ser tratado.</p>

<p>Ou o tratamento pode falhar.</p>

<hr />
<h1>12. Estratégia integrativa mais completa</h1>

<p>Uma abordagem mais estratégica seria:</p>

<h3>1?? recuperar intestino</h3>

<ul>
	<li>
	<p>modulação microbiota</p>
	</li>
	<li>
	<p>tratar gastrite</p>
	</li>
	<li>
	<p>melhorar digestão.</p>
	</li>
</ul>

<h3>2?? reconstrução muscular</h3>

<ul>
	<li>
	<p>aumento de proteína alimentar</p>
	</li>
	<li>
	<p>exercícios de força</p>
	</li>
	<li>
	<p>correção de micronutrientes.</p>
	</li>
</ul>

<h3>3?? reduzir inflamação</h3>

<ul>
	<li>
	<p>dieta anti-inflamatória</p>
	</li>
	<li>
	<p>equilíbrio glicêmico.</p>
	</li>
</ul>

<h3>4?? suporte imunológico</h3>

<ul>
	<li>
	<p>vitamina D</p>
	</li>
	<li>
	<p>zinco</p>
	</li>
	<li>
	<p>vitamina C.</p>
	</li>
</ul>

<hr />
<h1>13. Síntese clínica final</h1>

<p>A bioimpedância mostra que a paciente tem um padrão metabólico de:</p>

<p><strong>baixo músculo + gordura alta + baixa proteína corporal</strong></p>

<p>Esse perfil favorece:</p>

<ul>
	<li>
	<p>inflamação sistêmica</p>
	</li>
	<li>
	<p>baixa imunidade</p>
	</li>
	<li>
	<p>pior função respiratória.</p>
	</li>
</ul>
', 'Ana Carolina Candia Barra', '2026-03-12 18:15:51'),
  ('60857148311', 'atestado', '<h1><span style=&quot;font-size:18px&quot;>Tratamento - tríade da restauração&nbsp;<br />
Fase 1 tratamento- despertar metabólico - personalizado para sindrome fúngica<br />
<br />
<strong>Alimentos para retirar por 30 dias</strong></span></h1>

<p><strong>Laticínios</strong></p>

<ul>
	<li>
	<p>Iogurte grego</p>
	</li>
	<li>
	<p>Cream cheese</p>
	</li>
	<li>
	<p>Ricota</p>
	</li>
	<li>
	<p>Mussarela de búfala</p>
	</li>
	<li>
	<p>Kefir de leite</p>
	</li>
</ul>

<p><strong>Fermentados alcoólicos ou com leveduras</strong></p>

<ul>
	<li>
	<p>Kombuchá</p>
	</li>
	<li>
	<p>Vinho</p>
	</li>
	<li>
	<p>Torradas</p>
	</li>
	<li>
	<p>Pães (mesmo sem glúten)</p>
	</li>
</ul>

<p><strong>Carboidratos de alto índice glicêmico</strong></p>

<ul>
	<li>
	<p>Biscoito de arroz</p>
	</li>
	<li>
	<p>Banana da terra</p>
	</li>
	<li>
	<p>Banana caturra (exceto eventualmente pós-treino)</p>
	</li>
</ul>

<p><strong>Adoçantes fermentativos</strong></p>

<ul>
	<li>
	<p>Xilitol</p>
	</li>
	<li>
	<p>Eritritol</p>
	</li>
	<li>
	<p>Açúcar de coco</p>
	</li>
</ul>

<p><strong>Possíveis irritantes intestinais</strong></p>

<ul>
	<li>
	<p>Chá de sene</p>
	</li>
	<li>
	<p>Chá de casca sagrada</p>
	</li>
</ul>

<p><strong>Outros que podem favorecer fungos</strong></p>

<ul>
	<li>
	<p>chocolates e doces no geral, Chocolate (mesmo 70%) na fase inicial</p>
	</li>
	<li>
	<p>Água de coco (deixar apenas ocasional após treino se necessário)</p>

	<h1><strong><span style=&quot;font-size:18px&quot;>Alimentos que permanecem</span></strong></h1>

	<p><strong>Bebidas:</strong></p>
	</li>
	<li>
	<p>café com canela</p>
	</li>
	<li>
	<p>chá verde</p>
	</li>
	<li>
	<p>chá de hibiscus</p>
	</li>
	<li>
	<p>chá de oliveira</p>
	</li>
	<li>
	<p>chá de amora</p>
	</li>
	<li>
	<p>chá de camomila</p>
	</li>
	<li>
	<p>chá de erva-cidreira</p>
	</li>
	<li>
	<p>água</p>
	</li>
	<li>
	<p>água com gás<br />
	<br />
	<strong>Proteínas:</strong></p>
	</li>
	<li>
	<p>ovos</p>
	</li>
	<li>
	<p>frango</p>
	</li>
	<li>
	<p>peixe</p>
	</li>
	<li>
	<p>carne</p>
	</li>
	<li>
	<p>whey protein isolado</p>
	</li>
	<li>
	<p><br />
	<strong>Gorduras:</strong></p>
	</li>
	<li>
	<p>azeite</p>
	</li>
	<li>
	<p>óleo de coco</p>
	</li>
	<li>
	<p>abacate</p>
	</li>
	<li>
	<p>ghee</p>
	</li>
	<li>
	<p>banha artesanal</p>
	</li>
	<li>
	<p>Fibras:</p>
	</li>
	<li>
	<p>chia</p>
	</li>
	<li>
	<p>linhaça</p>
	</li>
	<li>
	<p>psyllium<br />
	<br />
	<strong>Vegetais (fundamentais):</strong></p>
	</li>
	<li>
	<p>brócolis</p>
	</li>
	<li>
	<p>couve</p>
	</li>
	<li>
	<p>rúcula</p>
	</li>
	<li>
	<p>espinafre</p>
	</li>
	<li>
	<p>abobrinha</p>
	</li>
	<li>
	<p>berinjela</p>
	</li>
	<li>
	<p>pepino</p>
	</li>
	<li>
	<p>aspargos</p>
	</li>
	<li>
	<p>repolho</p>
	</li>
	<li>
	<p>couve-flor<br />
	<br />
	<strong>Carboidratos controlados:</strong></p>
	</li>
	<li>
	<p>batata doce</p>
	</li>
	<li>
	<p>mandioquinha</p>
	</li>
	<li>
	<p>quinoa</p>
	</li>
	<li>
	<p>arroz integral (pequena porção<br />
	<br />
	<strong>Frutas permitidas:</strong></p>
	</li>
	<li>
	<p>morango</p>
	</li>
	<li>
	<p>mirtilo</p>
	</li>
	<li>
	<p>framboesa</p>
	</li>
	<li>
	<p>limão</p>
	</li>
	<li>
	<p>kiwi</p>
	</li>
	<li>&nbsp;</li>
	<li>
	<p>pera<br />
	<br />
	&nbsp;</p>

	<h1><strong><span style=&quot;font-size:18px&quot;>Cardápio base (rotativo para 30 dias)</span></strong></h1>

	<p>A estratégia é usar <strong>7 dias rotativos</strong>.<br />
	Repete o ciclo por 4 semanas.</p>

	<hr />
	<h1>DIA 1</h1>

	<p>Café da manhã<br />
	Omelete de 2 ovos&nbsp;<br />
	Abacate - 50g<br />
	Café com canela</p>

	<p>Almoço<br />
	Frango grelhado - 120g - pesar depois de pronta<br />
	Arroz integral (3 colheres de sopa)<br />
	Brócolis e abobrinha a vontade&nbsp;<br />
	Azeite 1 colher de sopa</p>

	<p>Lanche<br />
	Castanhas 10g&nbsp; + morangos - 80g</p>

	<p>Jantar<br />
	Peixe grelhado 120g&nbsp;<br />
	Salada verde grande a vontade&nbsp;<br />
	Chia 1 colher&nbsp;</p>

	<hr />
	<h1>DIA 2</h1>

	<p>Café da manhã<br />
	Ovos mexidos 1 ovos&nbsp;<br />
	Guacamole 50g<br />
	Chá verde</p>

	<p>Almoço<br />
	Carne magra - 120g<br />
	Purê de batata doce - 70g ou 3 colheres de sopa<br />
	Couve refogada á vontade</p>

	<p>Lanche<br />
	Whey protein + morango - pode bater com leite de coco ou água</p>

	<p>Jantar<br />
	Frango desfiado 120g<br />
	Salada de rúcula á vontade&nbsp;<br />
	Pepino<br />
	&nbsp;azeite 1 colher de sopa</p>

	<hr />
	<h1>DIA 3</h1>

	<p>Café da manhã<br />
	Panqueca de farinha de amêndoas 1 colher com 2&nbsp;ovos<br />
	Pasta de castanha 1 colher de sopa ou pasta de amendoim 1 colher de sopa<br />
	Café com canela</p>

	<p>Almoço<br />
	Peixe 100g<br />
	Quinoa 50g<br />
	Brócolis e couve-flor á vontade&nbsp;</p>

	<p>Lanche<br />
	Kiwi&nbsp; 80g + castanhas 10g</p>

	<p>Jantar<br />
	Omelete com espinafre com 2&nbsp;ovos<br />
	Salada verde á vontade&nbsp;</p>

	<hr />
	<h1>DIA 4</h1>

	<p>Café da manhã<br />
	Ovos + abacate - 2 ovos mais 50g de abacate&nbsp;<br />
	Chá verde</p>

	<p>Almoço<br />
	Frango 120g<br />
	Mandioquinha - batata baroa&nbsp; 70 g&nbsp;<br />
	Abobrinha grelhada á vontade&nbsp;</p>

	<p>Lanche<br />
	Whey isolado + morango pode bater com leite de coco ou água</p>

	<p>Jantar<br />
	Carne magra ( patinho moido ou filé mingnon)<br />
	Salada grande&nbsp; á vontade&nbsp;</p>

	<hr />
	<h1>DIA 5</h1>

	<p>Café da manhã<br />
	Omelete com espinafre - 2 ovos&nbsp;<br />
	Café com canela</p>

	<p>Almoço<br />
	Peixe 120 g<br />
	Arroz integral 3 colheres de sopa<br />
	Repolho refogado á vontade&nbsp;</p>

	<p>Lanche<br />
	Castanhas 10g + kiwi 80 g</p>

	<p>Jantar<br />
	Frango 120g<br />
	Salada verde á vontade&nbsp;<br />
	Chia 1 colher</p>

	<hr />
	<h1>DIA 6</h1>

	<p>Café da manhã<br />
	Panqueca de linhaça - ovos e linhaça<br />
	Pasta de castanha pu pasta de amendoim - 1 colher</p>

	<p>Almoço<br />
	Carne 120g<br />
	Batata doce 70g<br />
	Brócolis á vontade&nbsp;&nbsp;</p>

	<p>Lanche<br />
	Whey protein isolado pode bater com leite de coco</p>

	<p>Jantar<br />
	Ovos mexidos até 3 unid.&nbsp;<br />
	Salada verde</p>

	<hr />
	<h1>DIA 7</h1>

	<p>Café da manhã<br />
	Omelete 2 ovos&nbsp;<br />
	Abacate 50g<br />
	Chá verde</p>

	<p>Almoço<br />
	Frango 120g<br />
	Quinoa 50g<br />
	Legumes á vontade&nbsp;</p>

	<p>Lanche<br />
	Morangos&nbsp; 80 g + castanhas 10g</p>

	<p>Jantar<br />
	Peixe 120g<br />
	Salada grande á vontade&nbsp;<br />
	<br />
	Obs: pode usar a lista de alimentos permitidos para variar, vegetais e frutas.<br />
	<br />
	<span style=&quot;font-size:18px&quot;><strong>Dicas extas:</strong></span></p>

	<h1><span style=&quot;font-size:16px&quot;>Estratégia para aumentar&nbsp;músculo</span></h1>

	<p>Como&nbsp; treina <strong>4x semana</strong>, incluir:</p>

	<p><strong>pós-treino</strong></p>
	</li>
	<li>
	<p>whey protein</p>
	</li>
	<li>
	<p>morango ou kiwi</p>
	</li>
	<li>
	<p>Isso melhora: recuperação, ganho de massa, sensibilidade à insulina</p>
	<br />
	<hr />
	<h1><span style=&quot;font-size:16px&quot;>Estratégia intestinal simples</span></h1>

	<p>Diariamente incluir:</p>
	</li>
	<li>
	<p>1 colher de <strong>chia ou linhaça</strong></p>
	</li>
	<li>
	<p>vegetais verdes</p>
	</li>
	<li>
	<p>Isso ajuda:</p>
	</li>
	<li>
	<p>gases</p>
	</li>
	<li>
	<p>microbiota</p>
	</li>
	<li>
	<p>trânsito intestinal</p>
	</li>
	<li>&nbsp;</li>
	<li>
	<p>azeite</p>
	</li>
</ul>
', 'Ana Carolina Candia Barra', '2026-03-14 12:26:41'),
  ('75538784134', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>

<p><br />
Sensibilidade energética alimentar:<br />
&nbsp;</p>

<ul>
	<li>Café: dissonante</li>
	<li>Camarão: dissonante</li>
	<li>Carne bovina: ressonante</li>
	<li>Carne de frango: neutro</li>
	<li>Carne suína: dissonante</li>
	<li>Clara de ovo: ressonante</li>
	<li>Gema de ovo:&nbsp;dissonante</li>
	<li>Farinha de trigo:&nbsp;dissonante</li>
	<li>Peixe branco:&nbsp;ressonante</li>
	<li>Soja:&nbsp;dissonante</li>
	<li>Leite de vaca e derivados:&nbsp;dissonante</li>
	<li>Queijos curados:&nbsp;dissonante</li>
	<li>Iogurte:&nbsp;dissonante</li>
	<li>Kefir:&nbsp;dissonante</li>
	<li>Kombucha:&nbsp;dissonante</li>
</ul>


<ul>
	<li>Tomate:&nbsp;dissonante</li>
	<li>Berinjela: neutro</li>
	<li>Espinafre:&nbsp;dissonante</li>
	<li>Abacate:&nbsp;dissonante</li>
	<li>Banana:&nbsp;dissonante</li>
	<li>Morango:&nbsp;dissonante</li>
	<li>Abacaxi:&nbsp;dissonante</li>
	<li>Chocolate:&nbsp;dissonante</li>
	<li>Cacau:&nbsp;dissonante</li>
	<li>Vinagre: dissonante</li>
	<li>Feijão:&nbsp;ressonante</li>
	<li>Histamina:&nbsp;ressonante</li>
</ul>

<p>&nbsp;&nbsp;</p>

<p>&nbsp;</p>

<p><strong>Sensibilidade à histamina:&nbsp;positivo (ressonante)<br />
<br />
OBS.:</strong></p>

<ul>
	<li><strong>ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></li>
	<li><strong>ALIMENTOS NEUTROS: PODEM SER CONSUMIDOR DE 2X A 3X POR SEMANA.&nbsp;</strong></li>
</ul>

<p><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong></p>
', 'Ester Virginio dos Santos Tomaz', '2026-03-19 15:54:18'),
  ('75538784134', 'atestado', '<h2><strong>Teste de Biorressonância</strong></h2>

<p><br />
Sensibilidade energética alimentar:<br />
&nbsp;</p>

<ul>
	<li><strong>Café: dissonante</strong></li>
	<li><strong>Camarão: dissonante</strong></li>
	<li>Carne bovina: ressonante</li>
	<li>Carne de frango: neutro</li>
	<li>Carne suína: dissonante</li>
	<li>Clara de ovo: ressonante</li>
	<li><strong>Gema de ovo:&nbsp;dissonante</strong></li>
	<li><strong>Farinha de trigo:&nbsp;dissonante</strong></li>
	<li>Peixe branco:&nbsp;ressonante</li>
	<li><strong>Soja:&nbsp;dissonante</strong></li>
	<li><strong>Leite de vaca e derivados:&nbsp;dissonante</strong></li>
	<li><strong>Queijos curados:&nbsp;dissonante</strong></li>
	<li><strong>Iogurte:&nbsp;dissonante</strong></li>
	<li><strong>Kefir:&nbsp;dissonante</strong></li>
	<li><strong>Kombucha:&nbsp;dissonante</strong></li>
</ul>

<ul>
	<li><strong>Tomate:&nbsp;dissonante</strong></li>
	<li>Berinjela: neutro</li>
	<li><strong>Espinafre:&nbsp;dissonante</strong></li>
	<li><strong>Abacate:&nbsp;dissonante</strong></li>
	<li><strong>Banana:&nbsp;dissonante</strong></li>
	<li><strong>Morango:&nbsp;dissonante</strong></li>
	<li><strong>Abacaxi:&nbsp;dissonante</strong></li>
	<li><strong>Chocolate:&nbsp;dissonante</strong></li>
	<li><strong>Cacau:&nbsp;dissonante</strong></li>
	<li><strong>Vinagre: dissonante</strong></li>
	<li>Feijão:&nbsp;ressonante</li>
	<li>Histamina:&nbsp;ressonante</li>
</ul>

<p>&nbsp;&nbsp;</p>

<p>&nbsp;</p>

<p><strong>Sensibilidade à histamina:&nbsp;positivo (ressonante)<br />
<br />
OBS.:</strong></p>

<ul>
	<li><strong>ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></li>
	<li><strong>ALIMENTOS NEUTROS: PODEM SER CONSUMIDOS&nbsp;DE 2X A 3X POR SEMANA.&nbsp;</strong></li>
</ul>

<p><br />
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong></p>
', 'Ester Virginio dos Santos Tomaz', '2026-03-19 16:32:39'),
  ('60857148311', 'atestado', '<h1><span style=&quot;font-size:18px&quot;>Tratamento - tríade da restauração&nbsp;<br />
Fase 1 tratamento- despertar metabólico - personalizado para sindrome fúngica<br />
<br />
<strong>Alimentos para retirar por 30 dias</strong></span></h1>

<p><strong>Laticínios</strong></p>

<ul>
	<li>
	<p>Iogurte grego</p>
	</li>
	<li>
	<p>Cream cheese</p>
	</li>
	<li>
	<p>Ricota</p>
	</li>
	<li>
	<p>Mussarela de búfala</p>
	</li>
	<li>
	<p>Kefir de leite</p>
	</li>
</ul>

<p><strong>Fermentados alcoólicos ou com leveduras</strong></p>

<ul>
	<li>
	<p>Kombuchá</p>
	</li>
	<li>
	<p>Vinho</p>
	</li>
	<li>
	<p>Torradas</p>
	</li>
	<li>
	<p>Pães (mesmo sem glúten)</p>
	</li>
</ul>

<p><strong>Carboidratos de alto índice glicêmico</strong></p>

<ul>
	<li>
	<p>Biscoito de arroz</p>
	</li>
	<li>
	<p>Banana da terra</p>
	</li>
	<li>
	<p>Banana caturra (exceto eventualmente pós-treino)</p>
	</li>
</ul>

<p><strong>Adoçantes fermentativos</strong></p>

<ul>
	<li>
	<p>Xilitol</p>
	</li>
	<li>
	<p>Eritritol</p>
	</li>
	<li>
	<p>Açúcar de coco</p>
	</li>
</ul>

<p><strong>Possíveis irritantes intestinais</strong></p>

<ul>
	<li>
	<p>Chá de sene</p>
	</li>
	<li>
	<p>Chá de casca sagrada</p>
	</li>
</ul>

<p><strong>Outros que podem favorecer fungos</strong></p>

<ul>
	<li>
	<p>chocolates e doces no geral, Chocolate (mesmo 70%) na fase inicial</p>
	</li>
	<li>
	<p>Água de coco (deixar apenas ocasional após treino se necessário)</p>

	<h1><strong><span style=&quot;font-size:18px&quot;>Alimentos que permanecem</span></strong></h1>

	<p><strong>Bebidas:</strong></p>
	</li>
	<li>
	<p>café com canela</p>
	</li>
	<li>
	<p>chá verde</p>
	</li>
	<li>
	<p>chá de hibiscus</p>
	</li>
	<li>
	<p>chá de oliveira</p>
	</li>
	<li>
	<p>chá de amora</p>
	</li>
	<li>
	<p>chá de camomila</p>
	</li>
	<li>
	<p>chá de erva-cidreira</p>
	</li>
	<li>
	<p>água</p>
	</li>
	<li>
	<p>água com gás<br />
	<br />
	<strong>Proteínas:</strong></p>
	</li>
	<li>
	<p>ovos</p>
	</li>
	<li>
	<p>frango</p>
	</li>
	<li>
	<p>peixe</p>
	</li>
	<li>
	<p>carne</p>
	</li>
	<li>
	<p>whey protein isolado</p>
	</li>
	<li>
	<p><br />
	<strong>Gorduras:</strong></p>
	</li>
	<li>
	<p>azeite</p>
	</li>
	<li>
	<p>óleo de coco</p>
	</li>
	<li>
	<p>abacate</p>
	</li>
	<li>
	<p>ghee</p>
	</li>
	<li>
	<p>banha artesanal</p>
	</li>
	<li>
	<p>Fibras:</p>
	</li>
	<li>
	<p>chia</p>
	</li>
	<li>
	<p>linhaça</p>
	</li>
	<li>
	<p>psyllium<br />
	<br />
	<strong>Vegetais (fundamentais):</strong></p>
	</li>
	<li>
	<p>brócolis</p>
	</li>
	<li>
	<p>couve</p>
	</li>
	<li>
	<p>rúcula</p>
	</li>
	<li>
	<p>espinafre</p>
	</li>
	<li>
	<p>abobrinha</p>
	</li>
	<li>
	<p>berinjela</p>
	</li>
	<li>
	<p>pepino</p>
	</li>
	<li>
	<p>aspargos</p>
	</li>
	<li>
	<p>repolho</p>
	</li>
	<li>
	<p>couve-flor<br />
	<br />
	<strong>Carboidratos controlados:</strong></p>
	</li>
	<li>
	<p>batata doce</p>
	</li>
	<li>
	<p>mandioquinha</p>
	</li>
	<li>
	<p>quinoa</p>
	</li>
	<li>
	<p>arroz integral (pequena porção<br />
	<br />
	<strong>Frutas permitidas:</strong></p>
	</li>
	<li>
	<p>morango</p>
	</li>
	<li>
	<p>mirtilo</p>
	</li>
	<li>
	<p>framboesa</p>
	</li>
	<li>
	<p>limão</p>
	</li>
	<li>
	<p>kiwi</p>
	</li>
	<li>&nbsp;</li>
	<li>
	<p>pera<br />
	<br />
	&nbsp;</p>

	<h1><strong><span style=&quot;font-size:18px&quot;>Cardápio base (rotativo para 30 dias)</span></strong></h1>

	<p>A estratégia é usar <strong>7 dias rotativos</strong>.<br />
	Repete o ciclo por 4 semanas.</p>

	<hr />
	<h1>DIA 1</h1>

	<p>Café da manhã<br />
	Omelete de 2 ovos&nbsp;<br />
	Abacate - 50g<br />
	Café com canela</p>

	<p>Almoço<br />
	Frango grelhado - 120g - pesar depois de pronta<br />
	Arroz integral (3 colheres de sopa)<br />
	Brócolis e abobrinha a vontade&nbsp;<br />
	Azeite 1 colher de sopa</p>

	<p>Lanche<br />
	Castanhas 10g&nbsp; + morangos - 80g</p>

	<p>Jantar<br />
	Peixe grelhado 120g&nbsp;<br />
	Salada verde grande a vontade&nbsp;<br />
	Chia 1 colher&nbsp;</p>

	<hr />
	<h1>DIA 2</h1>

	<p>Café da manhã<br />
	Ovos mexidos 1 ovos&nbsp;<br />
	Guacamole 50g<br />
	Chá verde</p>

	<p>Almoço<br />
	Carne magra - 120g<br />
	Purê de batata doce - 70g ou 3 colheres de sopa<br />
	Couve refogada á vontade</p>

	<p>Lanche<br />
	Whey protein + morango - pode bater com leite de coco ou água</p>

	<p>Jantar<br />
	Frango desfiado 120g<br />
	Salada de rúcula á vontade&nbsp;<br />
	Pepino<br />
	&nbsp;azeite 1 colher de sopa</p>

	<hr />
	<h1>DIA 3</h1>

	<p>Café da manhã<br />
	Panqueca de farinha de amêndoas 1 colher com 2&nbsp;ovos<br />
	Pasta de castanha 1 colher de sopa ou pasta de amendoim 1 colher de sopa<br />
	Café com canela</p>

	<p>Almoço<br />
	Peixe 100g<br />
	Quinoa 50g<br />
	Brócolis e couve-flor á vontade&nbsp;</p>

	<p>Lanche<br />
	Kiwi&nbsp; 80g + castanhas 10g</p>

	<p>Jantar<br />
	Omelete com espinafre com 2&nbsp;ovos<br />
	Salada verde á vontade&nbsp;</p>

	<hr />
	<h1>DIA 4</h1>

	<p>Café da manhã<br />
	Ovos + abacate - 2 ovos mais 50g de abacate&nbsp;<br />
	Chá verde</p>

	<p>Almoço<br />
	Frango 120g<br />
	Mandioquinha - batata baroa&nbsp; 70 g&nbsp;<br />
	Abobrinha grelhada á vontade&nbsp;</p>

	<p>Lanche<br />
	Whey isolado + morango pode bater com leite de coco ou água</p>

	<p>Jantar<br />
	Carne magra ( patinho moido ou filé mingnon)<br />
	Salada grande&nbsp; á vontade&nbsp;</p>

	<hr />
	<h1>DIA 5</h1>

	<p>Café da manhã<br />
	Omelete com espinafre - 2 ovos&nbsp;<br />
	Café com canela</p>

	<p>Almoço<br />
	Peixe 120 g<br />
	Arroz integral 3 colheres de sopa<br />
	Repolho refogado á vontade&nbsp;</p>

	<p>Lanche<br />
	Castanhas 10g + kiwi 80 g</p>

	<p>Jantar<br />
	Frango 120g<br />
	Salada verde á vontade&nbsp;<br />
	Chia 1 colher</p>

	<hr />
	<h1>DIA 6</h1>

	<p>Café da manhã<br />
	Panqueca de linhaça - ovos e linhaça<br />
	Pasta de castanha pu pasta de amendoim - 1 colher</p>

	<p>Almoço<br />
	Carne 120g<br />
	Batata doce 70g<br />
	Brócolis á vontade&nbsp;&nbsp;</p>

	<p>Lanche<br />
	Whey protein isolado pode bater com leite de coco</p>

	<p>Jantar<br />
	Ovos mexidos até 3 unid.&nbsp;<br />
	Salada verde</p>

	<hr />
	<h1>DIA 7</h1>

	<p>Café da manhã<br />
	Omelete 2 ovos&nbsp;<br />
	Abacate 50g<br />
	Chá verde</p>

	<p>Almoço<br />
	Frango 120g<br />
	Quinoa 50g<br />
	Legumes á vontade&nbsp;</p>

	<p>Lanche<br />
	Morangos&nbsp; 80 g + castanhas 10g</p>

	<p>Jantar<br />
	Peixe 120g<br />
	Salada grande á vontade&nbsp;<br />
	<br />
	Obs: pode usar a lista de alimentos permitidos para variar, vegetais e frutas.<br />
	<br />
	<span style=&quot;font-size:18px&quot;><strong>Dicas extas:</strong></span></p>

	<h1><span style=&quot;font-size:16px&quot;>Estratégia para aumentar&nbsp;músculo</span></h1>

	<p>Como&nbsp; treina <strong>4x semana</strong>, incluir:</p>

	<p><strong>pós-treino</strong></p>
	</li>
	<li>
	<p>whey protein</p>
	</li>
	<li>
	<p>morango ou kiwi</p>
	</li>
	<li>
	<p>Isso melhora: recuperação, ganho de massa, sensibilidade à insulina</p>
	&nbsp;

	<hr />
	<h1><span style=&quot;font-size:16px&quot;>Estratégia intestinal simples</span></h1>

	<p>Diariamente incluir:</p>
	</li>
	<li>
	<p>1 colher de <strong>chia ou linhaça</strong></p>
	</li>
	<li>
	<p>vegetais verdes</p>
	</li>
	<li>
	<p>Isso ajuda:</p>
	</li>
	<li>
	<p>gases</p>
	</li>
	<li>
	<p>microbiota</p>
	</li>
	<li>
	<p>trânsito intestinal</p>
	</li>
	<li>
	<p>azeite</p>
	</li>
</ul>
', 'Ester Virginio dos Santos Tomaz', '2026-03-20 16:26:40'),
  ('91163471100', 'atestado', '<strong>ALIMENTOS PERMITIDOS (FASE 1 – DESFERMENTAÇÃO)</strong><br />
Objetivo: reduzir gases, distensão e fermentação<br />
<br />
<strong>&nbsp;PROTEÍNAS</strong><br />
Ovos&nbsp;<br />
Peixes&nbsp;<br />
Carnes boi e frango ( se aceitar)<br />
<br />
<strong>VEGETAIS (preferir cozidos)</strong><br />
Abobrinha<br />
Cenoura<br />
Chuchu<br />
Abóbora<br />
Berinjela<br />
Pepino (sem casca/semente se sensível)<br />
<br />
<strong>&nbsp;GORDURAS BOAS</strong><br />
Azeite de oliva<br />
Abacate<br />
Óleo de coco (pequena quantidade)<br />
<br />
<strong>&nbsp;CARBOIDRATOS SEGUROS</strong><br />
Arroz branco<br />
Batata inglesa<br />
Mandioquinha<br />
Inhame<br />
&nbsp;(baixa fermentação ? importante nessa fase)<br />
<br />
<strong>&nbsp;CHÁS FUNCIONAIS</strong><br />
Erva-doce<br />
Funcho<br />
Hortelã<br />
Gengibre<br />
verde<br />
<br />
&nbsp;EXTRAS<br />
Sal<br />
Temperos naturais (sem industrializados)<br />
<br />
<strong>&nbsp;ALIMENTOS NÃO PERMITIDOS (FASE 1)</strong><br />
<br />
&nbsp;Esses são os PRINCIPAIS responsáveis pelos sintomas<br />
<br />
<strong>FERMENTATIVOS (FODMAP alto)</strong><br />
Feijão<br />
Lentilha<br />
Grão-de-bico<br />
Soja<br />
<br />
<strong>FRUTAS EM EXCESSO&nbsp;</strong> - que causam muita fermentação<br />
principalmente o que faz parte com frequencia<br />
Açaí&nbsp;<br />
Banana madura&nbsp;<br />
Maçã&nbsp;<br />
Manga&nbsp;<br />
<br />
<strong>&nbsp;FIBRAS FERMENTÁVEIS</strong><br />
Aveia<br />
Psyllium<br />
Granola<br />
Sementes em excesso<br />
<br />
<strong>LATICÍNIOS</strong><br />
Leite<br />
Queijo<br />
Iogurte<br />
<br />
<strong>GLÚTEN (principalmente do trabalho)</strong><br />
Pão<br />
Massas<br />
Biscoitos<br />
<br />
<strong>INDUSTRIALIZADOS</strong><br />
Embutidos<br />
Molhos prontos<br />
Adoçantes artificiais<br />
<br />
<strong>GORDURAS RUINS</strong><br />
Óleos vegetais refinados<br />
Frituras<br />
<br />
&nbsp;<strong>ALIMENTOS PROBLEMÁTICOS DO CASO</strong><br />
<br />
&nbsp;Esses aqui são CRÍTICOS<br />
Pasta de amendoim&nbsp;&nbsp;(fermenta MUITO )<br />
Excesso de frutas&nbsp;<br />
<br />
Atenção:<br />
“Se fermenta, piora seu sintoma mesmo sendo saudável.”', 'Ana Carolina Candia Barra', '2026-03-30 09:39:24'),
  ('02225692041', 'atestado', '&nbsp;PROTOCOLO DE RESTAURAÇÃO INTESTINAL<br />
( probiome)
<div>Duração: 8 a 12 semanas</div>

<div>&nbsp;</div>

<div>Este protocolo foi desenvolvido para restaurar o equilíbrio do seu intestino, melhorar seu metabolismo e reduzir inflamações silenciosas.</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;</div>

<div>FASE 1 – LIMPEZA E PREPARO DO TERRENO</div>

<div>Duração: 2 a 3 semanas</div>

<div>&nbsp;</div>

<div>Objetivo:</div>

<div>&nbsp;</div>

<div>- Reduzir a sobrecarga intestinal</div>

<div>- Controlar o crescimento de fungos e bactérias indesejadas</div>

<div>- Preparar o intestino para absorver melhor os nutrientes</div>

<div>- Diminuir sintomas como inchaço, gasgases fadiga crônica&nbsp;<br />
- Suplementação - simple life e floratin</div>

<div>&nbsp;</div>

<div>FASE 2 – DESPARASITAÇÃO E CONTROLE FÚNGICO</div>

<div>Duração: 4 semanas</div>

<div>&nbsp;</div>

<div>Objetivo:</div>

<div>&nbsp;</div>

<div>- Eliminar fungos e possíveis parasitas não detectados nos exames ( porém tem ambiente favorável).</div>

<div>- Reduzir toxinas produzidas no intestino</div>

<div>- Melhorar energia, imunidade e funcionamento intestinal</div>

<div>- Corrigir desequilíbrios mais profundos da microbiota</div>

<div>&nbsp;</div>

<div>--- kit desparasitação&nbsp;</div>

<div>&nbsp;</div>

<div>FASE 3 – REPOVOAMENTO E MODULAÇÃO METABÓLICA</div>

<div>Duração: 4 semanas</div>

<div>&nbsp;</div>

<div>Objetivo:</div>

<div>&nbsp;</div>

<div>- Reequilibrar as bactérias benéficas</div>

<div>- Fortalecer a barreira intestinal</div>

<div>- Melhorar o metabolismo e a resposta ao emagrecimento</div>

<div>- Reduzir inflamação silenciosa</div>

<div>- Promover saúde intestinal duradoura</div>

<div>- suplementação: probióticos&nbsp;</div>

<div>---<br />
<br />
&nbsp;Importante:</div>

<div>Cada fase é essencial. Pular etapas pode comprometer os resultados.</div>
', 'Ana Carolina Candia Barra', '2026-03-31 08:12:35'),
  ('02225692041', 'atestado', 'Alimentação&nbsp; FASE 1 (LIMPEZA INTESTINAL)
<div>&nbsp;</div>

<div>Durante essa fase, vamos reduzir a fermentação intestinal e controlar fungos.</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;EVITAR <strong>COMPLETAMENTE</strong>:</div>

<div>&nbsp;</div>

<div>- Açúcar (inclusive mascavo, mel, adoçantes artificiais)</div>

<div>- Farinha branca e massas</div>

<div>- Leite e derivados</div>

<div>- Álcool</div>

<div>- Ultraprocessados</div>

<div>- Refrigerantes e sucos industrializados</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;</div>

<div>REDUZIR:</div>

<div>&nbsp;</div>

<div>- Frutas muito doces (banana, uva, manga)</div>

<div>- Excesso de fibras cruas (pode gerar gases no início)</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;</div>

<div>ALIMENTOS PERMITIDOS:</div>

<div>&nbsp;</div>

<div>Proteínas:</div>

<div>&nbsp;</div>

<div>- Frango</div>

<div>- Peixe</div>

<div>- Ovos</div>

<div>- Carne magra</div>

<div>&nbsp;</div>

<div>&nbsp;Vegetais:</div>

<div>&nbsp;</div>

<div>- Abobrinha</div>

<div>- Brócolis</div>

<div>- Couve</div>

<div>- Pepino</div>

<div>- Alface</div>

<div>- Espinafre</div>

<div>&nbsp;</div>

<div>Gorduras boas:</div>

<div>&nbsp;</div>

<div>- Azeite de oliva</div>

<div>- Abacate</div>

<div>- Óleo de coco</div>

<div>&nbsp;</div>

<div>&nbsp;Chás:</div>

<div>&nbsp;</div>

<div>- Hortelã</div>

<div>- Camomila</div>

<div>- Gengibre</div>

<div>&nbsp;</div>

<div>Carboidrato:<br />
<br />
- arroz branco ( 2 colheres de sopa)<br />
- Inhame<br />
&nbsp;</div>

<div>&nbsp;</div>

<div>DICAS IMPORTANTES:</div>

<div>&nbsp;</div>

<div>- Coma devagar</div>

<div>- Evite líquidos durante as refeições</div>

<div>- Priorize alimentos simples e naturais</div>

<div>- Mantenha boa hidratação</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;</div>

<div>Objetivo dessa fase:</div>

<div>“Desinflamar e preparar o intestino para a regeneração.”</div>
', 'Ana Carolina Candia Barra', '2026-03-31 08:16:23'),
  ('79685099120', 'atestado', '<h3><strong>RELATÓRIO DE ATENDIMENTO BIOMÉDICO COM ANÁLISE DE COMPOSIÇÃO CORPORAL</strong></h3>

<p><strong>Profissional Responsável:</strong><br />
Ana Carolina Candia Barra<br />
Biomédica – Patologia Clínica e Estética<br />
CRBM: 26073</p>

<p><strong>Local do Atendimento:</strong><br />
Clínica Candia - saúde e bem estar</p>

<p><strong>Data da Consulta:</strong><br />
03/03/2026</p>

<hr />
<h3><strong>1. Identificação da Paciente</strong></h3>

<p>Paciente do sexo feminino, 50 anos, em avaliação biomédica com foco em saúde no geral&nbsp;e composição corporal.</p>

<hr />
<h3><strong>2. Queixa Principal</strong></h3>

<p>Paciente procura atendimento relatando:</p>

<ul>
	<li>Desconfortos relacionados à saúde geral e inflamatória</li>
	<li>Sensação de inchaço corporal e alteração na distribuição de gordura</li>
	<li>Dificuldade em manejo do peso corporal ao longo dos anos</li>
	<li>Sintomas associados ao período de transição hormonal (pré-menopausa)</li>
</ul>

<p>Relata também cefaleia leve ao despertar e episódios de enjoo matinal.</p>

<hr />
<h3><strong>3. Histórico Clínico&nbsp;</strong></h3>

<ul>
	<li>Talassemia</li>
	<li>Tireoidite de Hashimoto</li>
	<li>Sensibilidade ao glúten não celíaca</li>
	<li>Colecistectomia prévia</li>
	<li>Histórico de manifestações dermatológicas (psoríase capilar)</li>
	<li>Ansiedade com episódios de pânico</li>
</ul>

<hr />
<h3><strong>4. Uso de Medicamento</strong></h3>

<ul>
	<li>Levotiroxina 75 mcg/dia</li>
	<li>Sertralina 50 mg/dia</li>
	<li>Bilastina</li>
</ul>

<hr />
<h3><strong>5. Avaliação por Bioimpedância</strong></h3>

<p>A análise de composição corporal evidenciou:</p>

<ul>
	<li><strong>IMC:</strong> 26,6 kg/m² (faixa de sobrepeso)</li>
	<li><strong>Percentual de gordura corporal:</strong> 34,2% (elevado)</li>
	<li><strong>Massa gorda:</strong> aumentada em relação aos parâmetros de referência</li>
	<li><strong>Gordura visceral:</strong> nível 9 (limítrofe)</li>
</ul>

<p><strong>Com preservação de:</strong></p>

<ul>
	<li>Massa muscular</li>
	<li>Massa proteica</li>
	<li>Hidratação corporal</li>
</ul>

<p>Observa-se <strong>desequilíbrio na composição corporal</strong>, caracterizado por aumento de gordura com manutenção de massa magra.</p>

<hr />
<h3><strong>6. Análise Clínica</strong></h3>

<p>A avaliação integrada evidencia:</p>

<ul>
	<li>Alteração na composição corporal com padrão de acúmulo adiposo</li>
	<li>Possível componente inflamatório sistêmico associado</li>
	<li>Influência de fatores hormonais (tireoidianos e climatério)</li>
	<li>Relato clínico compatível com retenção e desconforto corporal</li>
</ul>

<p>A distribuição de gordura corporal e os achados clínicos sugerem necessidade de investigação mais aprofundada quanto a possíveis alterações metabólicas e hormonais associadas.</p>

<hr />
<h3><strong>7. Conduta</strong></h3>

<p>Diante dos achados clínicos e da avaliação por bioimpedância, foi indicado:</p>

<p>Encaminhamento para avaliação médica especializada (Nutrologia), com objetivo de:</p>

<ul>
	<li>Investigação metabólica e hormonal detalhada</li>
	<li>Avaliação de marcadores inflamatórios</li>
	<li>Análise do metabolismo de micronutrientes</li>
	<li>Definição diagnóstica e conduta terapêutica</li>
</ul>

<hr />
<h3><strong>8. Conclusão</strong></h3>

<p>A avaliação biomédica, associada à análise de bioimpedância, evidenciou alterações relevantes na composição corporal e no contexto clínico da paciente, justificando a necessidade de acompanhamento médico especializado.</p>

<p>O exame foi fundamental para direcionamento clínico e tomada de decisão, não tendo caráter estético, mas sim de <strong>avaliação em saúde e risco metabólico</strong>.</p>

<hr />
<p><strong>Assinatura:</strong></p>

<hr />
<p>Ana carolina Candia Barra<br />
CRBM: 26073</p>
', 'Ana Carolina Candia Barra', '2026-03-31 11:56:13'),
  ('07943713109', 'atestado', 'NOVOS EXAMES PARA SOLICITAR NO RETORNO&nbsp;<br />
&nbsp;
<ul>
	<li><strong>Sangue:</strong>&nbsp;Cálcio Iônico, Magnésio, Fósforo, CTX&nbsp;</li>
	<li><strong>Urina:</strong>&nbsp;Calciúria de 24h + Creatinina urinária.</li>
</ul>
', 'Ana Carolina Candia Barra', '2026-04-01 10:28:52'),
  ('09157396663', 'atestado', '<br />
Uso em consultório&nbsp;&nbsp;<br />
<br />
2 frascos ampola PDRNM 1% + Niacinamida 0,1% + AC. hialurônico 0,3% - 2ml ( microagulhamento)<br />
<br />
5 frascos ampola Vitamina D3 100.000 ui - 1 ml em veículo oleoso - IM<br />
<br />
10 frascos ampola vitamina D3 300.000 ui - 1 ml em veículo oleoso - IM<br />
<br />
10 frascos ampola metilcobalamina 2500mcg - 1 ml - IM<br />
<br />
<strong>Emagrecimento - acelerador do metabolismo III - via intramuscular</strong><br />
2 ampolas L-Baiba 150mg - 2 ml<br />
2 ampolas MORO 40MG - 2ml<br />
2 ampolas Ribosídeo de nicotinamida 200mg - 2 ml&nbsp;<br />
2 ampolas de teacrina 50mg - 2 ml<br />
2 ampolas Lidocaína 2% - 1 ml&nbsp;<br />
<br />
<strong>Emagrecimento - Dieta cetogênica / doces e ansiedade - via intramuscular</strong><br />
8 ampolas L - Fenilalanina 2,5% - 2ml<br />
8 ampolas L - Theanina 100mg - 2 ml<br />
8 ampolas 5 - hidroxi triptofano 4mg - 2 ml<br />
8 ampolas Inositol 10% + L Taurina 10% 2ml&nbsp;<br />
8 ampolas MORO 40mg - 2 ml&nbsp;<br />
8 ampolas Lidocaína 2 % - 1 ml<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-01 17:48:07'),
  ('52367959153', 'atestado', 'dieta que esta fazendo é a desintoxicação do falso magro com arroz no almoço e abóbora e inhame ou batata baroa ou batata doce.&nbsp;<br />
<br />
E esta fazendo um suco antes de dormir a noite com meia pitaya com água e 1 colher de sopa de oleo de ricino e uma colher de café do sal amargo..<br />
e isso funcionou muito com intestino..&nbsp;<br />
<br />
está tomando café com uma colher de sobremesa do oleo de coco&nbsp;<br />
<br />
e por volta das 11:00 o intestino funcinou&nbsp;<br />
<br />
e isso funcionou por 2 x&nbsp;&nbsp;<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-06 14:45:56'),
  ('52367959153', 'atestado', 'dieta que esta fazendo é a desintoxicação do falso magro com arroz no almoço e abóbora e inhame ou batata baroa ou batata doce.&nbsp;<br />
<br />
E esta fazendo um suco antes de dormir a noite com meia pitaya com água e 1 colher de sopa de oleo de ricino e uma colher de café do sal amargo..<br />
e isso funcionou muito com intestino..&nbsp;<br />
<br />
está tomando café com uma colher de sobremesa do oleo de coco&nbsp;<br />
<br />
e por volta das 11:00 o intestino funcinou&nbsp;<br />
<br />
e isso funcionou por 2 x&nbsp;&nbsp;<br />
<br />
esta fazendo a desparasitação&nbsp;<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-06 14:48:40'),
  ('85260665104', 'atestado', 'FASE 2 — ALIMENTAÇÃO DE REEQUILÍBRIO INTESTINAL (30 dias)
<div>OBJETIVOS</div>

<div>reativar microbiota benéfica</div>

<div>reduzir dependência intestinal</div>

<div>melhorar consistência das fezes</div>

<div>começar reintrodução alimentar</div>

<div>preparar para fase de desparasitação futura.&nbsp;<br />
<br />
O QUE AINDA EXCLUIR (POR ENQUANTO)</div>

<div>(mais 30 dias)<br />
&nbsp;</div>

<div>açúcar</div>

<div>ultraprocessados</div>

<div>óleo de soja / gordura industrial</div>

<div>leite e derivados (por enquanto)</div>

<div>trigo/glúten<br />
<br />
REDUZIR (não precisa excluir totalmente)</div>

<div>carne vermelha ? máx 2x semana</div>

<div>gordura saturada excessiva</div>

<div>coco em excesso<br />
<br />
BASE DA DIETA - ALIMENTOS PERMITIDOS&nbsp;<br />
&nbsp;</div>

<div>PROTEÍNAS</div>

<div>Priorizar:</div>

<div>peixe (principal)</div>

<div>frango</div>

<div>ovos<br />
&nbsp;</div>

<div>GORDURAS</div>

<div>azeite ??</div>

<div>abacate ??</div>

<div>Usar com moderação (não exagerar)<br />
&nbsp;</div>

<div>FIBRAS ( INTRODUZIR)<br />
&nbsp;</div>

<div>Introduzir:</div>

<div>chia ??</div>

<div>linhaça ??</div>

<div>legumes cozidos<br />
&nbsp;</div>

<div>REINTRODUÇÃO PROGRESSIVA&nbsp;<br />
&nbsp;</div>

<div>Semana 1–2</div>

<div>introduzir:</div>

<div>cenoura ??</div>

<div>abobrinha ??</div>

<div>berinjela ??</div>

<div>espinafre ??</div>

<div>&nbsp;</div>

<div>Semana 3–4</div>

<div>testar:</div>

<div>brócolis COZIDO (pequena quantidade)</div>

<div>couve refogada (pequena quantidade)<br />
&nbsp;</div>

<div>Observar:</div>

<div>gases</div>

<div>dor</div>

<div>intestino<br />
Se piorar ? RETRETIRAR<br />
<br />
FRUTAS</div>

<div>manter:</div>

<div>morango</div>

<div>mirtilo</div>

<div>kiwi</div>

<div>Pode testar:</div>

<div>maçã cozida (pequena quantidade)<br />
&nbsp;</div>

<div>&nbsp;CARBOIDRATOS (AJUSTE IMPORTANTE)</div>

<div>&nbsp;manter arroz branco ??</div>

<div>pode testar:</div>

<div>batata inglesa cozida</div>

<div>(pequena quantidade)<br />
&nbsp;</div>

<div>Isso ajuda:</div>

<div>microbiota</div>

<div>motilidade</div>

<div>energia<br />
&nbsp;</div>

<div>OBS:<br />
vitar jejum prolongado agora<br />
&nbsp;</div>

<div>ESTRUTURA DO DIA (AJUSTADA)<br />
&nbsp;</div>

<div>Café da manhã</div>

<div>Opção 1</div>

<div>2 ovos</div>

<div>kiwi ou morango</div>

<div>chá</div>

<div>Opção 2</div>

<div>iogurte de coco</div>

<div>chia + mirtilo<br />
&nbsp;</div>

<div>Almoço</div>

<div>proteína (120–150g)</div>

<div>arroz OU batata</div>

<div>legumes cozidos</div>

<div>salada</div>

<div>azeite<br />
&nbsp;</div>

<div>Lanche</div>

<div>castanhas</div>

<div>OU</div>

<div>ovo</div>

<div>OU</div>

<div>fruta<br />
&nbsp;</div>

<div>Jantar</div>

<div>proteína leve</div>

<div>legumes cozidos</div>

<div>salada<br />
<br />
SINAIS DE ALERTA</div>

<div>Se acontecer:</div>

<div>estufamento forte</div>

<div>dor</div>

<div>intestino travar</div>

<div>Reduzir reintrodução e avisar imediatamente para ajuste.<br />
<br />
&nbsp;</div>
', 'Ana Carolina Candia Barra', '2026-04-07 23:10:47'),
  ('02225692041', 'atestado', 'Alimentação&nbsp; FASE 1 (LIMPEZA INTESTINAL)
<div>&nbsp;</div>

<div>Durante essa fase, vamos reduzir a fermentação intestinal e controlar fungos.</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;EVITAR <strong>COMPLETAMENTE</strong>:</div>

<div>&nbsp;</div>

<div>- Açúcar (inclusive mascavo, mel, adoçantes artificiais)</div>

<div>- Farinha branca e massas</div>

<div>- Leite e derivados</div>

<div>- Álcool</div>

<div>- Ultraprocessados</div>

<div>- Refrigerantes e sucos industrializados</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;</div>

<div>REDUZIR:</div>

<div>&nbsp;</div>

<div>- Frutas muito doces (banana, uva, manga)</div>

<div>- Excesso de fibras cruas (pode gerar gases no início)</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;</div>

<div>ALIMENTOS PERMITIDOS:</div>

<div>&nbsp;</div>

<div>Proteínas:</div>

<div>&nbsp;</div>

<div>- Frango</div>

<div>- Peixe</div>

<div>- Ovos</div>

<div>- Carne magra</div>

<div>&nbsp;</div>

<div>&nbsp;Vegetais:</div>

<div>&nbsp;</div>

<div>- Abobrinha</div>

<div>- Brócolis</div>

<div>- Couve</div>

<div>- Pepino</div>

<div>- Alface</div>

<div>- Espinafre</div>

<div>&nbsp;</div>

<div>Gorduras boas:</div>

<div>&nbsp;</div>

<div>- Azeite de oliva</div>

<div>- Abacate</div>

<div>- Óleo de coco</div>

<div>&nbsp;</div>

<div>&nbsp;Chás:</div>

<div>&nbsp;</div>

<div>- Hortelã</div>

<div>- Camomila</div>

<div>- Gengibre</div>

<div>&nbsp;</div>

<div>Carboidrato:<br />
<br />
- arroz branco ( 2 colheres de sopa)<br />
- Inhame<br />
&nbsp;</div>

<div>&nbsp;</div>

<div>DICAS IMPORTANTES:</div>

<div>&nbsp;</div>

<div>- Coma devagar</div>

<div>- Evite líquidos durante as refeições</div>

<div>- Priorize alimentos simples e naturais</div>

<div>- Mantenha boa hidratação</div>

<div>&nbsp;</div>

<div>---</div>

<div>&nbsp;</div>

<div>Objetivo dessa fase:</div>

<div>“Desinflamar e preparar o intestino para a regeneração.”</div>
', 'Ester Virginio dos Santos Tomaz', '2026-04-10 15:46:02'),
  ('68939663691', 'atestado', '<span style=&quot;font-size:16px&quot;><strong>Avaliação integrativa&nbsp;</strong></span><br />
&nbsp;
<h2><strong>Histórico Clínico</strong></h2>

<ul>
	<li>Trombose:
	<ul>
		<li>2019: membro inferior esquerdo</li>
		<li>2021: membro inferior direito</li>
	</ul>
	</li>
	<li>Colecistectomia (2022)</li>
	<li>Disbiose intestinal</li>
	<li>Excesso de peso com gordura visceral elevada</li>
</ul>

<hr />
<h2><strong>Estilo de Vida</strong></h2>

<ul>
	<li>Trabalho em home office (baixa mobilidade)</li>
	<li>Atividade física: musculação 3x/semana (recente)</li>
	<li>Etilismo: consumo diário prévio - em tentativa de diminuição</li>
	<li>Tabagismo: 2 a 3 cigarros/dia</li>
	<li>Histórico de ingesta hídrica diminuida.</li>
</ul>

<hr />
<h2><strong>Histórico Familiar</strong></h2>

<ul>
	<li>Diabetes mellitus</li>
	<li>Obesidade</li>
</ul>

<hr />
<h2><strong>Uso de Medicação</strong></h2>

<ul>
	<li>Eliquis 5mg, 2x ao dia</li>
</ul>

<hr />
<h2><strong>Avaliação Clínica</strong></h2>

<p>Paciente com quadro compatível com:</p>

<ul>
	<li>Inflamação sistêmica crônica</li>
	<li>Elevado acúmulo de gordura visceral (alto risco metabólico)</li>
	<li>Disfunção metabólica associada ao estilo de vida</li>
	<li>Histórico vascular relevante (trombose recorrente)</li>
	<li>Disbiose intestinal</li>
	<li>Sobrecarga musculoesquelética (ombro e joelho)</li>
	<li>Possível impacto emocional/comportamental associado ao estilo de vida e hábitos</li>
</ul>

<hr />
<h2><strong>Considerações Clínicas</strong></h2>

<p>Indicação de abordagem integrativa com foco em:</p>

<ul>
	<li>Redução da inflamação sistêmica</li>
	<li>Controle de gordura visceral</li>
	<li>Suporte ao sistema vascular</li>
	<li>Reequilíbrio intestinal</li>
	<li>Melhora da dor e função musculoesquelética</li>
	<li>Regulação do eixo emocional e comportamental</li>
</ul>
Indicação terapeutica:<br />
<br />
3 meses de acomphamento muiltidisciplinar para mudança do estilo de vida e promoção geral da saúde.<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-15 11:42:46'),
  ('50425684172', 'atestado', '<h2>HIPÓTESES PRINCIPAIS</h2>

<ol>
	<li><strong>Disbiose intestinal com fermentação ativa (± SIBO)</strong></li>
	<li><strong>Intestino sensibilizado pós-cirurgia</strong></li>
	<li><strong>Inflamação de mucosa leve a moderada</strong></li>
	<li><strong>Má absorção funcional ? explicando fraqueza</strong></li>
	<li><strong>Impacto do estresse no eixo intestinal</strong></li>
</ol>

<hr />
<h2>&nbsp;DIRECIONAMENTO ESTRATÉGICO (conduta)</h2>

<h3>&nbsp;1. AJUSTE ALIMENTAR (primeiro passo real)</h3>

<p>Antes de suplementar, organize o terreno:</p>

<ul>
	<li>Reduzir alimentos altamente fermentáveis:
	<ul>
		<li>alho, cebola, trigo (testar retirada estruturada) ETC. AGUARDAR EXAME DA MICROBIOTA</li>
	</ul>
	</li>
	<li>Evitar totalmente:
	<ul>
		<li>pimenta, piperina, ultraprocessados</li>
	</ul>
	</li>
	<li>Fracionar refeições (evitar sobrecarga digestiva)</li>
	<li>Evitar jejum prolongado</li>
	<li>início imediato</li>
</ul>

<hr />
<h3>2. PROBIÓTICO COM CRITÉRIO</h3>

<ul>
	<li>Manter temporariamente o que ele tolera (<strong>Enterogermina</strong>)</li>
	<li>Evitar fórmulas complexas nesse momento</li>
</ul>

<p>Após o exame de microbiota poderemos ajustar com critétio</p>

<hr />
<h3>3. INVESTIGAR SE POSSÍVEL</h3>

<p>Se quiser elevar o nível do atendimento:</p>

<ul>
	<li>B12, ferro, ferritina, vitamina D (mesmo que já tenha, reavaliar)</li>
	<li>magnésio</li>
	<li>zinco</li>
	<li>exame de fezes (microbiota/inflamação)</li>
</ul>

<hr />
<h3>4. FOCO NA ENERGIA (PRIORIDADE CLÍNICA)</h3>

<p>Não adianta tratar intestino e ignorar isso:</p>

<ul>
	<li>Ajustar alimentação</li>
	<li>Avaliar suporte nutricional</li>
	<li>Reduzir inflamação</li>
</ul>

<p>&nbsp;A fraqueza é o marcador mais importante de que o corpo não está compensando bem.</p>

<hr />
<h3>&nbsp;5. INTERVENÇÃO NO ESTRESSE</h3>

<p>Sem isso, o intestino não estabiliza:</p>

<ul>
	<li>rotina de sono</li>
	<li>redução de estímulos</li>
	<li>manejo emocional</li>
	<li>COM TERAPIA NEURAL</li>
</ul>

<hr />
<h2>&nbsp;VISÃO ESTRATÉGICA FINAL</h2>

<ul>
	<li>pós-câncer</li>
	<li>com alteração anatômica</li>
	<li>com intestino sensível</li>
	<li>que descompensou por condutas inadequadas</li>
</ul>

<p>Se&nbsp; conduzir bem, tem alto valor clínico e resultado.<br />
Se tratar de forma genérica, tende a cronificar OU VOLTAR</p>
', 'Ana Carolina Candia Barra', '2026-04-22 15:07:08'),
  ('50425684172', 'atestado', '<h2>PRIORIDADE 1: REDUZIR INFLAMAÇÃO</h2>

<ul>
	<li>dieta controlada (como já estruturamos)</li>
	<li>ajuste intestinal</li>
	<li>reduzir fermentação</li>
</ul>

<hr />
<h2>PRIORIDADE 2: CORRIGIR BASE NUTRICIONAL</h2>

<p>Aqui está o que realmente vai mudar energia:</p>

<ul>
	<li>B12 (forma ativa)</li>
	<li>Vitamina D (subir com critério)</li>
	<li>Vitamina C (suporte antioxidante leve)</li>
	<li>Magnésio (não veio no exame ? provavelmente necessário)</li>
</ul>

<h2>&nbsp;PRIORIDADE 3: METILAÇÃO</h2>

<ul>
	<li>suporte leve (sem exagero)</li>
	<li>acompanhar homocisteína</li>
</ul>

<h2>PRIORIDADE 4: METABOLISMO</h2>

<ul>
	<li>ajuste alimentar</li>
	<li>evitar picos glicêmicos</li>
	<li>melhorar sensibilidade à insulina</li>
</ul>

<h2>&nbsp;PRIORIDADE 5: INTESTINO (com estratégia)</h2>

<ul>
	<li>fase 1 (controle fermentação)</li>
	<li>depois microbiota guiada pelo exame</li>
</ul>

<h1>VISÃO CLÍNICA FINAL</h1>

<p>&nbsp;</p>

<ul>
	<li>inflamado</li>
	<li>mal nutrido funcionalmente</li>
	<li>metabolicamente em risco</li>
	<li>com intestino desregulado</li>
</ul>

<p>E isso, no contexto de câncer prévio, <strong>não pode ser conduzido de forma superficial</strong>.</p>

<hr />
<h2>&nbsp;PARA O PACIENTE</h2>

<p>“Seus exames não mostram uma doença isolada, mas mostram que seu corpo está funcionando sob estresse,&nbsp;com inflamação, baixa energia e um intestino que não está absorvendo bem.<br />
O tratamento precisa reorganizar tudo isso em conjunto, não só tratar um sintoma.”</p>
', 'Ana Carolina Candia Barra', '2026-04-22 15:21:45'),
  ('52367959153', 'atestado', 'Antes de ir para a viagem no final de semana,&nbsp;<br />
funcionava a cada 4 dias, tomando tudo, óleo, e as fórmulas.<br />
<br />
La comeu feijão,arroz que não tem costume.&nbsp;<br />
&nbsp;<br />
chegou a ir para o hospital, e la foi indicado fazer lavagem intestinal.<br />
<br />
Antes de começar o tratamento, tomava ducolax,&nbsp; a paciente lembrou que antes de fazer abdominoplastia não precisava tomar e ia ao banheiro, faz 4 anos.&nbsp;', 'Ana Carolina Candia Barra', '2026-04-23 14:50:39'),
  ('86414526134', 'atestado', '<div style=&quot;text-align: center;&quot;><strong>RELATÓRIO DE ATENDIMENTO MÉDICO</strong><br />
&nbsp;</div>
Declaro, para os devidos fins, que o(a) paciente <strong>Yuri Shmitke Almeida B. Tisi</strong> foi atendido(a) por mim nesta clínica.<br />
Informo que sou médica com especialidade em <strong>Otorrinolaringologia </strong>regularmente inscrita no Conselho Regional de Medicina sob o número <strong>CRM 22677.</strong><br />
O atendimento foi realizado na data de <strong>20/12/2025, </strong>conforme descrito na nota fiscal emitida.<br />
Emito este relatório a pedido do paciente para fins de reembolso junto ao plano de saúde.<br />
<strong>Data de emissão:</strong> <strong>27/04/2026</strong><br />
&nbsp;
<div style=&quot;text-align: center;&quot;><strong>Dra. Danielle Candia Barra</strong><br />
CRM 22677<br />
Especialidade: Otorrinolaringologia</div>
', 'Ester Virginio dos Santos Tomaz', '2026-04-27 10:39:22'),
  ('86414526134', 'atestado', '<div style=&quot;text-align:center&quot;><br />
<br />
<strong>RELATÓRIO DE ATENDIMENTO MÉDICO</strong><br />
&nbsp;</div>
Declaro, para os devidos fins, que o(a) paciente <strong>Yuri Shmitke Almeida B. Tisi</strong> foi atendido(a) por mim nesta clínica.<br />
Informo que sou médica com especialidade em <strong>Otorrinolaringologia </strong>regularmente inscrita no Conselho Regional de Medicina sob o número <strong>CRM 22677.</strong><br />
O atendimento foi realizado na data de <strong>20/12/2025, </strong>conforme descrito na nota fiscal emitida.<br />
Emito este relatório a pedido do paciente para fins de reembolso junto ao plano de saúde.<br />
<strong>Data de emissão:</strong> <strong>27/04/2026</strong><br />
&nbsp;
<div style=&quot;text-align:center&quot;><strong>Dra. Danielle Candia Barra</strong><br />
CRM 22677<br />
Especialidade: Otorrinolaringologia</div>
', 'Ester Virginio dos Santos Tomaz', '2026-04-27 10:39:54'),
  ('75538784134', 'atestado', '<strong>Análise dos exames de sangue&nbsp;</strong><br />
<br />
<strong>Hemograma série vermelha :</strong>
<p>Sem anemia evidente.</p>

<ul>
	<li>isso <strong>não exclui deficiência funcional de ferro ou B12</strong></li>
	<li>principalmente em paciente com <strong>baixa massa muscular</strong></li>
	<li><strong>O médico pode avaliar melhor&nbsp;</strong></li>
</ul>
<strong>Série Branca:&nbsp;</strong>padrão <strong>normal</strong>, sem infecção aguda evidenciada.&nbsp;<br />
<br />
<strong>PCR ultrassensível&nbsp;:&nbsp;</strong>

<p>extremamente baixo</p>

<ul>
	<li>sem inflamação sistêmica relevante.</li>
</ul>
<strong>Glicemia e metabolismo</strong>

<p>Tudo dentro do intervalo, MAS:</p>

<h2><span style=&quot;font-size:12px&quot;>&nbsp;Aqui tem um ponto importante:</span></h2>

<p>HOMA 2,02 em paciente magra:</p>

<p>Pode&nbsp;não ser&nbsp;ideal, ideal seria uma avalição médica mais detalhada.&nbsp;</p>

<h3><span style=&quot;font-size:12px&quot;>Conexão com a bioimpedância:</span></h3>

<ul>
	<li>gordura alta</li>
	<li>músculo baixo</li>
</ul>

<h1><strong><span style=&quot;font-size:14px&quot;>Magnésio eritrocitário</span></strong></h1>

<ul>
	<li><strong>3,8 mg/dL</strong></li>
</ul>

<p>dentro da referência, porém:</p>

<ul>
	<li>não está alto</li>
	<li>pode ser insuficiente funcionalmente</li>
</ul>

<p>&nbsp;importante para:</p>

<ul>
	<li>músculo</li>
	<li>intestino</li>
	<li>sistema nervoso</li>
</ul>

<h1><strong><span style=&quot;font-size:14px&quot;>Tireóide (autoimune)</span></strong></h1>

<ul>
	<li>Anti-TPO: <strong>8,8 UI/mL</strong></li>
</ul>

<p>&nbsp;negativo - normal</p>

<p><strong>Ferritina 30 em adolescente:</strong></p>

<p>&nbsp;pode ser<strong>&nbsp;baixa funcionalmente</strong></p>

<p>Ideal para:</p>

<ul>
	<li>imunidade</li>
	<li>cabelo</li>
	<li>músculo</li>
</ul>

<p>&nbsp;Consequências diretas:</p>

<ul>
	<li>baixa síntese muscular</li>
	<li>fadiga</li>
	<li>imunidade reduzida</li>
	<li>pior recuperação respiratória</li>
</ul>

<p>explica parte da <strong>perda de massa muscular</strong></p>

<hr />
<h1>&nbsp;<span style=&quot;font-size:12px&quot;><strong>Zinco</strong></span></h1>

<ul>
	<li><strong>63,2 µg/dL (BAIXO)</strong></li>
</ul>

<p>Referência: 70–120</p>

<h2><span style=&quot;font-size:12px&quot;><strong>&nbsp;Esse é um dos achados MAIS importantes</strong></span></h2>

<p>Zinco baixo impacta diretamente:</p>

<ul>
	<li>imunidade</li>
	<li>mucosa intestinal</li>
	<li>mucosa respiratória</li>
	<li>produção de enzimas digestivas</li>
	<li>metabolismo de histamina (DAO!)</li>
</ul>

<h3>&nbsp;Conexão com o caso:</h3>

<ul>
	<li>tosse crônica</li>
	<li>rinite</li>
	<li>gastrite</li>
	<li>disbiose</li>
</ul>

<p>tudo pode ser agravado por zinco baixo</p>

<h1><span style=&quot;font-size:14px&quot;><strong>Selênio</strong></span></h1>

<ul>
	<li><strong>84 µg/L (normal)</strong></li>
</ul>

<p>? adequado<br />
? sem impacto negativo relevante aqui</p>

<hr />
<h1><strong><span style=&quot;font-size:12px&quot;>&nbsp;Vitamina D</span></strong></h1>

<ul>
	<li><strong>35 ng/mL</strong></li>
</ul>

<hr />
<h2><span style=&quot;font-size:12px&quot;>Interpretação funcional:</span></h2>

<p>Para laboratório: normal<br />
Para clínica integrativa: <strong>limítrofe</strong></p>

<p>Ideal nesse caso:</p>

<p>40–60 ng/mL</p>

<h3>&nbsp;Impacto:</h3>

<ul>
	<li>imunidade respiratória</li>
	<li>inflamação</li>
	<li>músculo</li>
</ul>

<p>&nbsp;não está ruim, mas também <strong>não está ideal para recuperação</strong><br />
&nbsp;</p>

<h1><span style=&quot;font-size:14px&quot;><strong>Teste genético&nbsp; (MICROBIOTA)</strong></span></h1>

<ul>
	<li>F/B normal ? irrelevante isoladamente</li>
	<li><strong>baixa diversidade ? achado chave</strong></li>
	<li><strong>perda de bactérias anti-inflamatórias ? central</strong></li>
	<li><strong>disbiose funcional presente ?</strong></li>
</ul>

<hr />
<h1><strong><span style=&quot;font-size:14px&quot;>&nbsp;Caso total (até aqui)</span></strong></h1>

<h3><strong>disbiose funcional + mucosa intestinal comprometida</strong></h3>

<p>Que pode estar&nbsp;levando a:</p>

<ul>
	<li>má absorção</li>
	<li>deficiência nutricional</li>
	<li>inflamação respiratória</li>
	<li>tosse crônica</li>
	<li>perda de massa muscular</li>
</ul>

<p><br />
&nbsp;</p>

<p>&nbsp;</p>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-04-27 11:34:04'),
  ('83000372172', 'atestado', 'Sobre o lipedema e circulação<br />
A gordura se concentra mais em pernas/quadril ou é distribuída igualmente?<br />
As pernas doem ao toque ou no final do dia?<br />
Tem sensação de peso, pressão ou queimação nas pernas?<br />
Você percebe facilidade para hematomas?<br />
Os pés ficam poupados comparados às pernas? (“efeito bracelete”)<br />
O volume das pernas piorou após menopausa ou alterações hormonais?<br />
Sobre o hormonal<br />
Quando começou a menopausa/pré-menopausa? Quais sintomas mais incomodam?<br />
A prolactina alta já foi investigada com ressonância de hipófise?<br />
Qual valor atual da prolactina?<br />
O Natifa Pro melhorou ou piorou:<br />
retenção<br />
peso<br />
dor nas pernas<br />
disposição<br />
sono<br />
libido?<br />
Tem histórico de:<br />
mioma<br />
endometriose<br />
SOP<br />
mama densa<br />
cistos?<br />
Sobre composição corporal/metabolismo<br />
Mesmo treinando musculação, sente que:<br />
perde força fácil?<br />
não hipertrofia?<br />
ganha gordura rapidamente?<br />
Tem muita fome à noite ou episódios de hipoglicemia/tremores?<br />
Já fez bioimpedância recentemente?<br />
Sobre intestino e inflamação<br />
As fezes com “bolinhas” são ressecadas tipo cíbalos?<br />
Tem distensão abdominal após comer?<br />
Piora com leite/glúten?<br />
Usa antiácido/omeprazol?<br />
Sobre fadiga e inflamação sistêmica<br />
Ronca ou acorda sufocada?<br />
Tem queda de cabelo importante ou afinamento dos fios?<br />
Como está libido e motivação?<br />
Já teve COVID com piora persistente da disposição?', 'Ester Virginio dos Santos Tomaz', '2026-05-07 15:17:20'),
  ('01663482799', 'atestado', '<p>ATESTADO DE COMPARECIMENTO</p>

<p>Atesto, para os devidos fins, que a paciente DANIELA OLIVEIRA DE SIQUEIRA compareceu em consulta médica nesta data, no período matutino.</p>

<p>Brasília, 11 de maio de 2026.</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22.677</p>
', 'Danielle Candia Barra', '2026-05-11 10:49:39'),
  ('37151045115', 'atestado', '<div style=&quot;text-align:center&quot;><br />
<br />
<span style=&quot;font-size:14px&quot;><strong>Laudo de Análise Microscópica em Campo Escuro de Sangue Vivo</strong></span><br />
<br />
&nbsp;</div>

<ul>
	<li>Boa movimentação</li>
	<li>Agregação eritrocitários</li>
	<li>Rede de&nbsp;fibrina em formação</li>
	<li>Cocos circulares — macro symprotite</li>
	<li>Eosinófilos</li>
	<li>Sinais de hipermeabilidade intestinal — potencial zeta&nbsp;</li>
	<li>Equinócitos</li>
	<li>Anisocitose</li>
	<li>Dacriócitos</li>
	<li>Hemácias parasitadas</li>
	<li>Leveduras</li>
	<li>Quilomicrons</li>
	<li>Cristais de colesterol ou&nbsp;ácido úrico</li>
	<li>Symprotites presentes no plasma</li>
</ul>
<br />
<span style=&quot;font-size:12px&quot;><strong>OBS.:</strong> - Imagens disponibilazadas no prontuário;<br />
- Esta avaliação possui caráter complementar e não substitui exames laboratoriais convencionais ou diagnóstico médico. Os achados observados podem contribuir como recurso de apoio na análise integrativa do organismo, auxiliando no direcionamento individualizado do acompanhamento em saúde.</span>', 'Ester Virginio dos Santos Tomaz', '2026-05-12 16:26:09'),
  ('00786230142', 'atestado', '<div style=&quot;text-align:center&quot;><br />
<br />
<span style=&quot;font-size:14px&quot;><strong>Laudo de Análise Microscópica em Campo Escuro de Sangue Vivo</strong></span></div>
&nbsp;

<ul>
	<li>Boa movimentação</li>
	<li>Presença de Symprotite</li>
	<li>Maioria das hemácias em formato de espículas</li>
	<li>Microcitose</li>
	<li>Esquizócitos</li>
	<li>Hemácia parasitada</li>
	<li>Agregação eritrocitária</li>
	<li>Macrosymprotite</li>
	<li>Presença de pelo menos um leucócito por campo</li>
	<li>Cristais de colesterol&nbsp;</li>
	<li>Formato de rouleaux</li>
	<li>Anisocitose</li>
	<li>Dacriócitos</li>
	<li>Ovalócitos</li>
	<li>Ponto focal de fibrina&nbsp;</li>
	<li>Formas fúngicas</li>
</ul>
<br />
<span style=&quot;font-size:12px&quot;><strong>OBS.:</strong>&nbsp;- Imagens disponibilazadas no prontuário;<br />
- Esta avaliação possui caráter complementar e não substitui exames laboratoriais convencionais ou diagnóstico médico. Os achados observados podem contribuir como recurso de apoio na análise integrativa do organismo, auxiliando no direcionamento individualizado do acompanhamento em saúde.</span>', 'Ester Virginio dos Santos Tomaz', '2026-05-13 16:09:49'),
  ('79453430153', 'atestado', '<h1>FASE 1 (30 dias)</h1>

<h2>Objetivo</h2>

<ul>
	<li>Reduzir dor abdominal</li>
	<li>Reduzir gases</li>
	<li>Reduzir distensão</li>
	<li>Modular inflamação</li>
	<li>Melhorar barreira intestinal</li>
	<li>Reduzir R. gnavus</li>
	<li>Preparar terreno para recuperação do microbioma</li>
</ul>

<hr />
<h1>ALIMENTOS PERMITIDOS</h1>

<h3>Proteínas (base da dieta)</h3>

<p>&nbsp;Carne bovina</p>

<p>&nbsp;Frango</p>

<p>&nbsp;Peixe</p>

<p>&nbsp;Ovos</p>

<p>Caldo de ossos&nbsp;<br />
<br />
Consumir em todas as refeções depossível.</p>

<hr />
<h3>Carboidratos mais seguros</h3>

<p>- Arroz branco - maximo de 1 colher de sopa</p>

<p>-Mandioquinha - máximo de 2 colheres de sopa</p>

<p>-Batata inglesa&nbsp;- máximo de 2 colheres de sopa</p>

<p>-Abóbora cabotiá&nbsp;- máximo de 2 colheres de sopa</p>

<p>-Cenoura cozida- máximo de 2 colheres de sopa</p>

<p>-Chuchu á vontade&nbsp;</p>

<p>-Abobrinha á vontade<br />
<br />
&nbsp;</p>

<hr />
<h3>Frutas</h3>

<p>Começar com:<br />
<br />
-Melão</p>

<p>-Mamão</p>

<p>-Morango</p>

<p>-Kiwi</p>

<p>-Tangerina</p>

<p>1-2 porções/dia</p>

<hr />
<h3>Gorduras</h3>

<p>-Azeite</p>

<p>-Ghee (se tolerar)</p>

<p>-Abacate</p>

<p>-Coco<br />
<br />
máximo de&nbsp;1 colher de chá</p>

<hr />
<h1>PROIBIDOS POR 30 DIAS</h1>

<h3>FODMAPs altos</h3>

<p>-Cebola</p>

<p>-Alho</p>

<p>-Alho-poró</p>

<p>-Couve-flor</p>

<p>-Brócolis</p>

<p>-Repolho</p>

<hr />
<h3>Leguminosas</h3>

<p>-Feijão</p>

<p>-Lentilha</p>

<p>-Grão-de-bico</p>

<p>-Ervilha</p>

<hr />
<h3>Grãos e industrializados</h3>

<p>-Trigo<br />
<br />
-&nbsp;Pão</p>

<p>-Macarrão</p>

<p>-Biscoitos</p>

<p>-Ultraprocessados</p>

<hr />
<h3>Laticínios</h3>

<p>-Leite</p>

<p>-Iogurte<br />
<br />
-&nbsp;Queijos por enquanto</p>

<hr />
<h3>Outros</h3>

<p>-Refrigerante</p>

<p>-Álcool</p>

<p>-Chicletes</p>

<p>-Xilitol</p>

<p>-Eritritol</p>

<p>-Sorbitol</p>
', 'Ana Carolina Candia Barra', '2026-05-21 15:56:07'),
  ('69982490125', 'atestado', 'ALA&nbsp;<br />
zinco quelado&nbsp;<br />
b12&nbsp;<br />
astaxantina&nbsp;<br />
selenio&nbsp;<br />
tirosina<br />
silimarina<br />
<br />
magnesio citrato<br />
glutamina&nbsp;<br />
fiber for&nbsp;<br />
pyssilium&nbsp;<br />
espinheira santa&nbsp;<br />
<br />
lactobacilus gasseri<br />
ramnosus<br />
platarium&nbsp;<br />
bfidobacterium breve<br />
<br />
resveratrol<br />
curcuma com piperina<br />
magnesio treonato<br />
<br />
coenzima q10<br />
Nadh<br />
acetil L carnitina<br />
sibutramina&nbsp;<br />
glucomanan<br />
vit D<br />
rodiola rosea<br />
<br />
magnesio bisglicinato&nbsp;<br />
5htp<br />
calcio&nbsp;<br />
<br />
magnesio quelado&nbsp;<br />
cromo<br />
berberina<br />
<br />
omega 3&nbsp;<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-22 15:58:45'),
  ('69982490125', 'atestado', 'fez um tratamento e tomou esses suplementos<br />
relata que se sentiu bem.&nbsp;<br />
<br />
ALA&nbsp;<br />
zinco quelado&nbsp;<br />
b12&nbsp;<br />
astaxantina&nbsp;<br />
selenio&nbsp;<br />
tirosina<br />
silimarina<br />
<br />
magnesio citrato<br />
glutamina&nbsp;<br />
fiber for&nbsp;<br />
pyssilium&nbsp;<br />
espinheira santa&nbsp;<br />
<br />
lactobacilus gasseri<br />
ramnosus<br />
platarium&nbsp;<br />
bfidobacterium breve<br />
<br />
resveratrol<br />
curcuma com piperina<br />
magnesio treonato<br />
<br />
coenzima q10<br />
Nadh<br />
acetil L carnitina<br />
sibutramina&nbsp;<br />
glucomanan<br />
vit D<br />
rodiola rosea<br />
<br />
magnesio bisglicinato&nbsp;<br />
5htp<br />
calcio&nbsp;<br />
<br />
magnesio quelado&nbsp;<br />
cromo<br />
berberina<br />
<br />
omega 3&nbsp;<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-05-22 16:00:43'),
  ('04288150140', 'atestado', '<br />
<br />
<br />
<strong>Encaminhamento Psicoterapêutico<br />
<br />
<!--TgQPHd|[]--></strong><!--TgQPHd|[]--><br />
Encaminho o paciente <strong>Ícaro Figueiredo Almeida<!--TgQPHd|[]--></strong> para acompanhamento psicológico.<!--TgQPHd|[]--><br />
<strong>CID-10: F40<br />
<br />
<br />
<!--TgQPHd|[]--></strong><!--TgQPHd|[]--><br />
Brasília, 30 de maio de 2026.<!--TgQPHd|[]--><br />
<!--TgQPHd|[]-->
<hr />', 'Ana Carolina Candia Barra', '2026-05-30 16:56:55'),
  ('02225692041', 'atestado', '<h3><strong>Alimentos ricos em FODMAPs - Proibidos</strong></h3>
Seguir Por 30 dias initerruptos.&nbsp;

<h4>Frutas</h4>

<ul>
	<li>Maçã</li>
	<li>Pera</li>
	<li>Manga</li>
	<li>Melancia</li>
	<li>Caqui</li>
	<li>Pêssego</li>
	<li>Ameixa</li>
	<li>Cereja</li>
	<li>Nectarina</li>
</ul>

<h4>Vegetais e legumes</h4>

<ul>
	<li>Alho</li>
	<li>Cebola</li>
	<li>Alho-poró</li>
	<li>Aspargos</li>
	<li>Couve-flor</li>
	<li>Beterraba em grandes quantidades</li>
	<li>Cogumelos</li>
	<li>Ervilha</li>
</ul>

<h4>Leguminosas</h4>

<ul>
	<li>Feijão preto</li>
	<li>Feijão carioca</li>
	<li>Feijão branco</li>
	<li>Lentilha (em grandes quantidades)</li>
	<li>Grão-de-bico (em grandes quantidades)</li>
</ul>

<h4>Laticínios com lactose</h4>

<ul>
	<li>Leite de vaca</li>
	<li>Leite de cabra</li>
	<li>Sorvete</li>
	<li>Leite condensado</li>
	<li>Iogurtes tradicionais</li>
</ul>

<h4>Cereais e derivados</h4>

<ul>
	<li>Trigo</li>
	<li>Centeio</li>
	<li>Cevada</li>
	<li>Pães comuns</li>
	<li>Biscoitos feitos com farinha de trigo</li>
</ul>

<h4>Adoçantes</h4>

<ul>
	<li>Sorbitol</li>
	<li>Manitol</li>
	<li>Xilitol</li>
	<li>Maltitol</li>
	<li>Isomalte</li>
</ul>

<h4>Outros</h4>

<ul>
	<li>Mel</li>
	<li>Xarope de milho rico em frutose</li>
	<li>Algumas barras proteicas e suplementos que contenham inulina, chicória ou polióis</li>
</ul>

<hr />
<h3><strong>Alimentos geralmente permitidos</strong></h3>

<h4>Frutas</h4>

<ul>
	<li>Banana</li>
	<li>Morango</li>
	<li>Uva</li>
	<li>Kiwi</li>
	<li>Laranja</li>
	<li>Abacaxi</li>
	<li>Maracujá</li>
</ul>

<h4>Vegetais</h4>

<ul>
	<li>Cenoura</li>
	<li>Abobrinha</li>
	<li>Pepino</li>
	<li>Tomate</li>
	<li>Alface</li>
	<li>Espinafre</li>
	<li>Berinjela</li>
</ul>

<h4>Proteínas</h4>

<ul>
	<li>Carnes</li>
	<li>Frango</li>
	<li>Peixe</li>
	<li>Ovos</li>
</ul>

<h4>Carboidratos</h4>

<ul>
	<li>Arroz</li>
	<li>Batata</li>
	<li>Mandioca</li>
	<li>Tapioca</li>
	<li>Aveia (em porções moderadas)</li>
</ul>

<h4>Laticínios</h4>

<ul>
	<li>Leite sem lactose</li>
	<li>Queijos maturados (parmesão, muçarela, provolone)</li>
	<li>Iogurte sem lactose</li>
</ul>
', 'Ana Carolina Candia Barra', '2026-06-01 15:01:37'),
  ('43882749172', 'atestado', '<h2 style=&quot;text-align: center;&quot;><br />
<br />
<strong><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>4–6 semanas com redução de alimentos altamente fermentáveis:</span></strong></h2>
<strong>Priorizar:</strong><br />
<br />
Ovos<br />
Peixes<br />
Frango<br />
Folhas<br />
Abobrinha<br />
Chuchu<br />
Pepino<br />
Morango<br />
Kiwi<br />
Azeite<br />
Abacate<br />
&nbsp;
<div><strong>Retirar temporariamente:</strong></div>
<br />
Feijão<br />
Lentilha<br />
Grão-de-bico<br />
Cebola<br />
Alho&nbsp;<br />
Maçã<br />
Pera<br />
Açúcares', 'Ester Virginio dos Santos Tomaz', '2026-06-03 11:47:02'),
  ('02160204170', 'atestado', '<strong>ALIMENTOS PARA RETIRAR (8 semanas) - DIMINUIR AKKERMANCIA INFLAMATÓRIA, E MELHORAR A DIVERSIDADE ENTRE BACTERIOIDETES E FIRMICUTES.</strong><br />
<br />
Açúcares e refinados<br />
Açúcar<br />
Refrigerante<br />
Sucos industrializados<br />
Bolo<br />
Biscoitos<br />
Doces<br />
Chocolate ao leite<br />
Sorvetes<br />
Ultraprocessados<br />
Embutidos<br />
Salgadinho<br />
Macarrão&nbsp;<br />
Molhos industrializados<br />
Temperos prontos<br />
<strong>Fibras prebióticas na alimentação (temporariamente)<br />
Inulina&nbsp;<br />
FOS<br />
Mix prebióticos comerciais</strong><br />
<br />
Alimentos que costumam fermentar muito<br />
Cebola crua<br />
Alho cru em excesso<br />
Couve-flor<br />
Brócolis em excesso<br />
Repolho<br />
Feijão (reduzir inicialmente, não necessariamente excluir)<br />
Lentilha<br />
Grão-de-bico<br />
<br />
Álcool - Suspender totalmente<br />
<br />
<strong>ALIMENTOS PARA FAVORECER</strong><br />
Proteínas<br />
Ovos<br />
Frango<br />
Peixes<br />
Sardinha<br />
Carne bovina<br />
Whey protein isolado<br />
Colágeno<br />
Meta: 1,5 a 2 g/kg/dia ( CONFORME ORIENTAÇÃO DO NUTRICIONISTA)<br />
<br />
<strong>Gorduras anti-inflamatórias</strong><br />
Azeite extravirgem<br />
Abacate<br />
Castanhas<br />
Macadâmias<br />
Coco<br />
Ghee<br />
Amido resistente<br />
Excelente para ela.<br />
Batata inglesa cozida e resfriada<br />
Batata-doce cozida e resfriada<br />
Arroz cozido e resfriado<br />
Biomassa de banana verde (pequenas quantidades)<br />
<br />
<strong>Frutas mais bem toleradas</strong><br />
Morango<br />
Mirtilo<br />
Amora<br />
Kiwi<br />
Limão<br />
Maracujá<br />
Vegetais<br />
Preferir cozidos:<br />
Abobrinha<br />
Chuchu<br />
Cenoura<br />
Abóbora<br />
Pepino<br />
Alface<br />
Rúcula<br />
<br />
<strong>Alimentos para mucosa intestinal</strong><br />
Caldo de ossos<br />
Colágeno<br />
Peixes<br />
Gema de ovo<br />
Carnes<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-08 12:27:36'),
  ('06336262103', 'atestado', '<strong>ALIMENTAÇÃO TERAPÊUTICA (30 DIAS)<br />
<span style=&quot;font-size:14px&quot;>Retirar</span></strong><br />
<br />
Glúten<br />
Leite de vaca<br />
Chocolate<br />
Achocolatados<br />
Tomate<br />
Molho de tomate<br />
Ketchup<br />
Morango<br />
Refrigerantes<br />
Sucos artificiais<br />
Corantes artificiais<br />
Gelatina colorida<br />
Balas<br />
Chicletes<br />
Presunto<br />
Peito de peru<br />
Salame<br />
Mortadela<br />
Salsicha<br />
Linguiça<br />
Bacon<br />
Queijos maturados<br />
Conservas<br />
Vinagre<br />
Kombucha<br />
<br />
<span style=&quot;font-size:14px&quot;><strong>Priorizar&nbsp;</strong></span><br />
<br />
Arroz Branco&nbsp;<br />
Batata<br />
Mandioca<br />
Frango<br />
Carne bovina<br />
Peixe fresco<br />
Ovos (se tolerados)<br />
Brócolis<br />
Cenoura<br />
Abobrinha<br />
Chuchu<br />
Abóbora<br />
Pepino<br />
Maçã<br />
Pera<br />
Kiwi<br />
Mirtilo', 'Ana Carolina Candia Barra', '2026-06-10 15:35:21'),
  ('06336262103', 'atestado', '<strong>ALIMENTAÇÃO TERAPÊUTICA (30 DIAS)<br />
<span style=&quot;font-size:14px&quot;>Retirar</span></strong><br />
<br />
Glúten<br />
Leite de vaca<br />
Chocolate<br />
Achocolatados<br />
Tomate<br />
Molho de tomate<br />
Ketchup<br />
Morango<br />
Refrigerantes<br />
Sucos artificiais<br />
Corantes artificiais<br />
Gelatina colorida<br />
Balas<br />
Chicletes<br />
Presunto<br />
Peito de peru<br />
Salame<br />
Mortadela<br />
Salsicha<br />
Linguiça<br />
Bacon<br />
Queijos maturados<br />
Conservas<br />
Vinagre<br />
Kombucha<br />
mel<br />
laranja&nbsp;<br />
Tangerina<br />
<br />
<span style=&quot;font-size:14px&quot;><strong>Priorizar&nbsp;</strong></span><br />
<br />
Arroz Branco&nbsp;<br />
Batata<br />
Mandioca<br />
Frango<br />
Carne bovina<br />
Peixe fresco<br />
Ovos (se tolerados)<br />
Brócolis<br />
Cenoura<br />
Abobrinha<br />
Chuchu<br />
Abóbora<br />
Pepino<br />
Maçã<br />
Pera<br />
Kiwi<br />
Mirtilo<br />
abacaxi<br />
melancia<br />
banana&nbsp;<br />
coco e derivados&nbsp;<br />
uva', 'Ana Carolina Candia Barra', '2026-06-10 16:30:11'),
  ('64633160168', 'atestado', '<h1>Cardápio em uso de Tirzepatida</h1>

<h3>1. Café da manhã – 25 g de proteína</h3>

<ul>
	<li>Omelete preparado com <strong>2 ovos + 1 clara</strong>, recheado com espinafre e queijo cottage.</li>
	<li>1 fatia de pão integral.</li>
	<li>1 xícara de chá verde sem açúcar.</li>
</ul>

<hr />
<h3>2. Lanche da manhã – 30 g de proteína</h3>

<ul>
	<li>Shake proteico:
	<ul>
		<li>1 scoop de whey protein;</li>
		<li>200 ml de leite vegetal sem açúcar;</li>
		<li>1 colher de sopa de pasta de amendoim integral.</li>
	</ul>
	</li>
</ul>

<hr />
<h3>3. Almoço – 35 g de proteína</h3>

<ul>
	<li>120 g de frango grelhado.</li>
	<li>3 colheres de sopa de arroz integral.</li>
	<li>Mix de legumes no vapor temperados com azeite (brócolis, abobrinha e cenoura).</li>
	<li>1 colher de sopa de sementes de abóbora.</li>
</ul>

<hr />
<h3>4. Lanche da tarde – 20 g de proteína</h3>

<ul>
	<li>150 g de iogurte grego natural sem açúcar.</li>
	<li>1 colher de sopa de mix de nuts.</li>
	<li>1 colher de sopa de sementes de chia.</li>
</ul>

<hr />
<h3>5. Jantar – 30 g de proteína</h3>

<ul>
	<li>120 g de filé de peixe grelhado (tilápia, salmão ou merluza).</li>
	<li>Purê de couve-flor com ricota.</li>
	<li>Salada de folhas temperada com azeite e limão.</li>
</ul>
<br />
<strong>Outras opçoes e substituições.</strong>

<h1><strong><span style=&quot;font-size:12px&quot;>Café da Manhã</span></strong></h1>

<p><strong>Escolha 1 opção de cada grupo alimentar:</strong></p>

<h3>Carboidrato</h3>

<ul>
	<li>
	<p>Aveia</p>
	</li>
	<li>
	<p>Pão integral ou sem glúten</p>
	</li>
	<li>
	<p>Batata-doce</p>
	</li>
	<li>
	<p>Banana-da-terra</p>
	</li>
	<li>
	<p>Frutas (preferencialmente de baixo índice glicêmico)</p>
	</li>
</ul>

<h3>Proteína</h3>

<ul>
	<li>
	<p>Ovos</p>
	</li>
	<li>
	<p>Iogurte grego natural</p>
	</li>
	<li>
	<p>Whey Protein isolado</p>
	</li>
	<li>
	<p>Frango desfiado</p>
	</li>
	<li>
	<p>Atum em lata (preferencialmente em água)</p>
	</li>
</ul>

<h3>Gorduras saudáveis</h3>

<ul>
	<li>
	<p>Abacate</p>
	</li>
	<li>
	<p>Queijo branco</p>
	</li>
	<li>
	<p>Queijos curados</p>
	</li>
	<li>
	<p>Azeite de oliva extravirgem</p>
	</li>
	<li>
	<p>Oleaginosas (castanhas, nozes, amêndoas)</p>
	</li>
</ul>

<h3>Vegetais</h3>

<p>Adicione sempre que possível:</p>

<ul>
	<li>
	<p>Tomate</p>
	</li>
	<li>
	<p>Cebola</p>
	</li>
	<li>
	<p>Cogumelos</p>
	</li>
	<li>
	<p>Brócolis</p>
	</li>
	<li>
	<p>Salsinha</p>
	</li>
	<li>
	<p>Outros vegetais de sua preferência</p>
	</li>
</ul>

<h3>Bebidas</h3>

<ul>
	<li>
	<p>Café (preferencialmente sem açúcar)</p>
	</li>
	<li>
	<p>Chás naturais</p>
	</li>
	<li>
	<p>Água</p>
	</li>
	<li>
	<p>Água de coco</p>
	</li>
	<li>
	<p>Leite (preferencialmente vegetal e sem açúcar)</p>
	</li>
</ul>

<hr />
<h1><strong><span style=&quot;font-size:12px&quot;>Almoço e Jantar</span></strong></h1>

<p><strong>Escolha 1 opção de cada grupo alimentar:</strong></p>

<h3>Carboidrato</h3>

<ul>
	<li>
	<p>Arroz integral</p>
	</li>
	<li>
	<p>Macarrão integral ou sem glúten</p>
	</li>
	<li>
	<p>Batata inglesa</p>
	</li>
	<li>
	<p>Batata-doce</p>
	</li>
	<li>
	<p>Abóbora</p>
	</li>
	<li>
	<p>Mandioca</p>
	</li>
</ul>

<h3>Proteína</h3>

<ul>
	<li>
	<p>Ovos</p>
	</li>
	<li>
	<p>Peito de frango</p>
	</li>
	<li>
	<p>Atum</p>
	</li>
	<li>
	<p>Salmão</p>
	</li>
	<li>
	<p>Peixes brancos</p>
	</li>
	<li>
	<p>Carne bovina magra</p>
	</li>
	<li>
	<p>Carne moída magra</p>
	</li>
</ul>

<h3>Gorduras saudáveis</h3>

<ul>
	<li>
	<p>Abacate</p>
	</li>
	<li>
	<p>Queijos</p>
	</li>
	<li>
	<p>Queijos curados</p>
	</li>
	<li>
	<p>Azeite de oliva extravirgem</p>
	</li>
	<li>
	<p>Azeitonas</p>
	</li>
</ul>

<h3>Vegetais</h3>

<p>Consuma à vontade, variando diariamente:</p>

<ul>
	<li>
	<p>Folhas verdes</p>
	</li>
	<li>
	<p>Tomate</p>
	</li>
	<li>
	<p>Pepino</p>
	</li>
	<li>
	<p>Brócolis</p>
	</li>
	<li>
	<p>Couve-flor</p>
	</li>
	<li>
	<p>Cebola</p>
	</li>
	<li>
	<p>Cebolinha</p>
	</li>
	<li>
	<p>Salsinha</p>
	</li>
	<li>
	<p>Coentro</p>
	</li>
	<li>
	<p>Outros vegetais de sua preferência</p>
	</li>
</ul>

<h3>Bebidas</h3>

<ul>
	<li>
	<p>Água</p>
	</li>
	<li>
	<p>Água com gás</p>
	</li>
	<li>
	<p>Água aromatizada naturalmente</p>
	</li>
	<li>
	<p>Chás sem açúcar</p>
	</li>
</ul>

<hr />
<h1><strong><span style=&quot;font-size:12px&quot;>Lanches</span></strong></h1>

<p><strong>Escolha uma das opções:</strong></p>

<ul>
	<li>
	<p>Iogurte grego natural com castanhas.</p>
	</li>
	<li>
	<p>Shake de Whey Protein.</p>
	</li>
	<li>
	<p>Ovos cozidos.</p>
	</li>
	<li>
	<p>Queijo com oleaginosas.</p>
	</li>
	<li>
	<p>Atum com tomate.</p>
	</li>
	<li>
	<p>Frutas acompanhadas de uma fonte de proteína (como iogurte grego ou Whey Protein).</p>
	</li>
</ul>
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-06-26 10:54:26'),
  ('02344108173', 'atestado', 'Estratégia alimentar&nbsp;<br />
<br />
200ml de água ao acordar<br />
jejum ao acordar&nbsp; -&nbsp; 1 limão espremido - 5g creatina + 5g de glutamina 300ml de água&nbsp;<br />
<br />
café da manhã: alternar&nbsp;<br />
<br />
1- meio pão com 3 ovos com manteiga guee + meio mamão papaia com 1 colher de chia e 2 coher de yogurte&nbsp;<br />
ou 100g de cuzcuz como carboidrato.<br />
<br />
Almoço. 12:00 - 13:30&nbsp;<br />
<br />
150 g ou 120g de proteina - peito de frango, peixe, carne bovina.<br />
100g de arroz integral cozido<br />
100g de feijão<br />
salada a vontade&nbsp;<br />
legumes cozidos a vontade.<br />
1 colher de azeite para cozinhar ou temperar.&nbsp;<br />
<br />
Pré treino&nbsp;<br />
<br />
2 ovos com meio pão ou 70 g de cuzcuz&nbsp;<br />
Café com uma colher de chá de oleo de coco com canela.&nbsp;<br />
<br />
pós treino&nbsp;<br />
<br />
1 dose de whey&nbsp;<br />
<br />
lanche:<br />
120g a 150g de carne moída.&nbsp;<br />
1 banana da terra ou nanica&nbsp;<br />
salada a vontade.&nbsp;<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-07-07 11:09:31'),
  ('09470196694', 'atestado', '<h1 style=&quot;text-align: center;&quot;>&nbsp;</h1>

<div style=&quot;text-align: center;&quot;><span style=&quot;font-size:16px&quot;><strong><span style=&quot;font-family:arial,helvetica,sans-serif&quot;>Teste de Incompatibilidade Alimentar por Biorressonância</span></strong></span></div>

<h2><span style=&quot;font-size:14px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;><strong>Alimentos:</strong></span></span><br />
<strong style=&quot;font-size:13px&quot;>Café – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Camarão – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Carne bovina – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Frango – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Carne suína – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Clara de ovo – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Farinha de trigo – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Gema de ovo – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Leite de vaca – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Peixe branco – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Arroz (integral) – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Arroz (branco)&nbsp;– neutro</span><br />
<span style=&quot;font-size:13px&quot;>Sal de cozinha – neutro</span><br />
<span style=&quot;font-size:13px&quot;>Sal do Himalaia – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Soja – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Própolis verde – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Cacau 100% alcalino – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Cacau 100% puro – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Damasco – neutro</span><br />
<span style=&quot;font-size:13px&quot;>Tâmara – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Uva-passa – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Pistache (castanha) – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Morango – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Banana – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Mexerica – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Limão – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Chá ginseng – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Chá de gengibre com limão – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Leite de coco – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Chocolate – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Feijão – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Tomate – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Molho de tomate – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Leite de castanha – neutro</span><br />
<strong style=&quot;font-size:13px&quot;>Mel – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Salmão – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Cogumelo – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Mandioca – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Batata inglesa/doce – neutro</span><br />
<span style=&quot;font-size:13px&quot;>Tapioca – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Repolho – dissonante</strong><br />
<span style=&quot;font-size:13px&quot;>Brócolis – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Chá preto – neutro</span><br />
<span style=&quot;font-size:13px&quot;>Chá verde – ressonante</span><br />
<span style=&quot;font-size:13px&quot;>Castanhas – ressonante</span><br />
<strong style=&quot;font-size:13px&quot;>Granola sem acúçar/com açúcar&nbsp; – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Aveia – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Cafeína – dissonante&nbsp;</strong><br />
<br />
<span style=&quot;font-size:13px&quot;>Histamina – neutro</span></h2>
&nbsp;

<h2><span style=&quot;font-size:14px&quot;><strong>Metais pesados:&nbsp;</strong></span><br />
<strong style=&quot;font-size:13px&quot;>Alumínio – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Arsênico – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Chumbo – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Enxofre – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Mercúrio – dissonante</strong><br />
<strong style=&quot;font-size:13px&quot;>Níquel – dissonante</strong></h2>
<br />
<br />
<span style=&quot;font-size:14px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;><strong>Medicamentos:</strong></span></span><br />
Lyberdia 15 gotas – ressonante<br />
<strong>Venvance 30 mg – dissonante<br />
Venvance 50 mg – dissonante</strong><br />
<br />
<br />
<span style=&quot;font-size:14px&quot;><span style=&quot;font-family:arial,helvetica,sans-serif&quot;><strong>Alergia:</strong></span></span><br />
<strong>Pele, saliva e caspa de gato – dissonante</strong><br />
<br />
<br />
OBS.: Este teste não deve ser utilizado como diagnóstico médico, nem substitui consulta, exame clínico ou exames laboratoriais. Os resultados obtidos por meio da bioressonância têm caráter complementar e devem ser interpretados em conjunto com a avaliação clínica realizada por um profissional habilitado, considerando o histórico, os sintomas e demais exames do paciente.<br />
&nbsp;
<ul>
	<li><strong>ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></li>
	<li><strong>ALIMENTOS NEUTROS: PODEM SER CONSUMIDOR DE 2X A 3X POR SEMANA.&nbsp;</strong></li>
</ul>
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong><br />
&nbsp;', 'Ester Virginio dos Santos Tomaz', '2026-07-24 17:43:48'),
  ('64633160168', 'atestado', '<p>Solicito a realização de&nbsp;<strong>Polissonografia Noturna Completa</strong>, para investigação de distúrbio do sono.</p>

<p><strong>Justificativa Clínica:</strong></p>

<p>Paciente do sexo feminino, 50 anos, em transição menopausal, apresentando quadro compatível com distúrbio do sono, associado a fadiga, alterações hormonais do climatério, uso crônico de medicações de ação central e queixas que impactam a qualidade do sono e a recuperação física.</p>

<p>A avaliação objetiva da arquitetura do sono é fundamental para investigação de:</p>

<ul>
	<li>Apneia Obstrutiva do Sono (AOS);</li>
	<li>Hipopneia do sono;</li>
	<li>Fragmentação do sono;</li>
	<li>Distúrbios respiratórios relacionados ao sono;</li>
	<li>Movimentos periódicos dos membros;</li>
	<li>Alterações da arquitetura do sono associadas ao climatério;</li>
	<li>Avaliação da eficiência e qualidade global do sono.</li>
</ul>

<p>O resultado do exame auxiliará na definição diagnóstica e direcionamento terapêutico adequado.</p>

<p><strong>CID-10:</strong></p>

<ul>
	<li>G47.3 – Apneia do sono</li>
	<li>G47.0 – Distúrbios do início e da manutenção do sono (insônia)</li>
	<li>N95.1 – Estado da menopausa e climatério feminino</li>
</ul>
', 'Ana Carolina Candia Barra', '2026-07-28 11:07:23'),
  ('09470196694', 'atestado', '<div style=&quot;text-align: center;&quot;><span style=&quot;font-size:16px&quot;><strong>Teste de Incompatibilidade Alimentar por Biorressonância</strong></span></div>

<h2><span style=&quot;font-size:14px&quot;><strong>Alimentos:</strong><br />
<strong>Café – dissonante</strong><br />
<strong>Camarão – dissonante</strong><br />
Carne bovina – ressonante<br />
Frango – ressonante<br />
<strong>Carne suína – dissonante</strong><br />
<strong>Clara de ovo – dissonante</strong><br />
<strong>Farinha de trigo – dissonante</strong><br />
Gema de ovo – ressonante<br />
<strong>Leite de vaca – dissonante</strong><br />
Peixe branco – ressonante<br />
Arroz (integral) – ressonante<br />
Arroz (branco)&nbsp;– neutro<br />
Sal de cozinha – neutro<br />
Sal do Himalaia – ressonante<br />
<strong>Soja – dissonante</strong><br />
Própolis verde – ressonante<br />
Cacau 100% alcalino – ressonante<br />
<strong>Cacau 100% puro – dissonante</strong><br />
Damasco – neutro<br />
Tâmara – ressonante<br />
Uva-passa – ressonante<br />
Pistache (castanha) – ressonante<br />
Morango – ressonante<br />
Banana – ressonante<br />
Mexerica – ressonante<br />
Limão – ressonante<br />
Chá ginseng – ressonante<br />
Chá de gengibre com limão – ressonante<br />
Leite de coco – ressonante<br />
<strong>Chocolate – dissonante</strong><br />
Feijão – ressonante<br />
Tomate – ressonante<br />
Molho de tomate – ressonante<br />
Leite de castanha – neutro<br />
<strong>Mel – dissonante</strong><br />
Salmão – ressonante<br />
<strong>Cogumelo – dissonante</strong><br />
Mandioca – ressonante<br />
Batata inglesa/doce – neutro<br />
Tapioca – ressonante<br />
<strong>Repolho – dissonante</strong><br />
Brócolis – ressonante<br />
Chá preto – neutro<br />
Chá verde – ressonante<br />
Castanhas – ressonante<br />
<strong>Granola sem acúçar/com açúcar&nbsp; – dissonante</strong><br />
<strong>Aveia – dissonante</strong><br />
<strong>Cafeína – dissonante&nbsp;</strong><br />
<br />
Histamina – neutro</span></h2>
<span style=&quot;font-size:14px&quot;>&nbsp;</span>

<h2><span style=&quot;font-size:14px&quot;><strong>Metais pesados:&nbsp;</strong><br />
<strong>Alumínio – dissonante</strong><br />
<strong>Arsênico – dissonante</strong><br />
<strong>Chumbo – dissonante</strong><br />
<strong>Enxofre – dissonante</strong><br />
<strong>Mercúrio – dissonante</strong><br />
<strong>Níquel – dissonante</strong></span></h2>
<br />
<br />
<strong>Medicamentos:</strong><br />
Lyberdia 15 gotas – ressonante<br />
<strong>Venvance 30 mg – dissonante<br />
Venvance 50 mg – dissonante</strong><br />
<br />
<br />
<strong>Alergia:</strong><br />
<strong>Pele, saliva e caspa de gato – dissonante</strong><br />
<br />
<br />
OBS.: Este teste não deve ser utilizado como diagnóstico médico, nem substitui consulta, exame clínico ou exames laboratoriais. Os resultados obtidos por meio da bioressonância têm caráter complementar e devem ser interpretados em conjunto com a avaliação clínica realizada por um profissional habilitado, considerando o histórico, os sintomas e demais exames do paciente.<br />
&nbsp;
<ul>
	<li><strong>ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></li>
	<li><strong>ALIMENTOS NEUTROS: PODEM SER CONSUMIDOR DE 2X A 3X POR SEMANA.&nbsp;</strong></li>
</ul>
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong>', 'Ana Carolina Candia Barra', '2026-07-29 16:26:24'),
  ('09470196694', 'atestado', '<div><strong><span style=&quot;font-size:16px&quot;>Alimentos&nbsp;- base da alimentação:</span></strong></div>
<br />
<br />
<strong><span style=&quot;font-size:16px&quot;>Proteínas:</span></strong><br />
Carne bovina<br />
Frango<br />
Peixe branco<br />
Salmão<br />
Gema de ovo (evitando a clara)<br />
<br />
<br />
<strong><span style=&quot;font-size:16px&quot;>Carboidratos:</span></strong><br />
Arroz integral<br />
Feijão<br />
Mandioca<br />
Tapioca<br />
Batata (somente ocasionalmente, por ser neutra)<br />
Vegetais<br />
Brócolis<br />
Tomate<br />
Molho de tomate artesanal<br />
Alface, rúcula, agrião, espinafre, abobrinha, pepino, chuchu - desde que bem tolerados.<br />
<br />
<br />
<strong><span style=&quot;font-size:16px&quot;>Frutas:</span></strong><br />
Banana<br />
Morango<br />
Mexerica<br />
Limão<br />
Tâmara (pequenas quantidades)<br />
Uva-passa (pequenas quantidades)<br />
Gorduras boas<br />
Castanhas<br />
Pistache<br />
Leite de coco<br />
Bebidas<br />
Chá verde<br />
Chá de gengibre com limão<br />
Chá de ginseng<br />
<br />
<br />
<strong><span style=&quot;font-size:20px&quot;>Evitar:</span></strong>

<ul>
	<li>Café</li>
	<li>Cafeína</li>
	<li>Leite de vaca</li>
	<li>Trigo</li>
	<li>Aveia</li>
	<li>Soja</li>
	<li>Clara de ovo</li>
	<li>Carne suína</li>
	<li>Camarão</li>
	<li>Chocolate</li>
	<li>Cacau 100% puro</li>
	<li>Mel</li>
	<li>Cogumelos</li>
	<li>Repolho</li>
	<li>Granola</li>
</ul>
&nbsp;<br />
<br />
<strong><span style=&quot;font-size:20px&quot;>Sugestão de cardápio:</span></strong><br />
<br />
<span style=&quot;font-size:14px&quot;><strong>Café da manhã:</strong></span><br />
Tapioca (2 colheres de sopa) recheada com frango desfiado<br />
1 gema cozida<br />
Chá de gengibre com limão<br />
<br />
<strong><span style=&quot;font-size:14px&quot;>Lanche:</span></strong><br />
Banana<br />
Castanhas<br />
<br />
<strong><span style=&quot;font-size:14px&quot;>Almoço:</span></strong><br />
120–150 g de carne bovina ou frango<br />
Arroz integral<br />
Feijão<br />
Brócolis<br />
Salada verde com tomate<br />
Azeite extravirgem<br />
Lanche da tarde<br />
Leite de coco batido com morango e cacau 100% alcalino<br />
Pistache<br />
<br />
<strong><span style=&quot;font-size:14px&quot;>Jantar:</span></strong><br />
Salmão ou peixe branco<br />
Purê de mandioca<br />
Brócolis ou legumes<br />
<br />
<span style=&quot;font-size:14px&quot;><strong>Ceia:</strong></span><br />
Chá verde ou chá de ginseng<br />
Algumas castanhas', 'Ana Carolina Candia Barra', '2026-07-29 16:32:16'),
  ('09470196694', 'atestado', '<div style=&quot;text-align:center&quot;><span style=&quot;font-size:16px&quot;><strong>Teste de Incompatibilidade Alimentar por Biorressonância</strong></span></div>

<h2><span style=&quot;font-size:14px&quot;><strong>Alimentos:</strong><br />
<strong>Café – dissonante</strong><br />
<strong>Camarão – dissonante</strong><br />
Carne bovina – ressonante<br />
Frango – ressonante<br />
<strong>Carne suína – dissonante</strong><br />
<strong>Clara de ovo – dissonante</strong><br />
<strong>Farinha de trigo – dissonante</strong><br />
Gema de ovo – ressonante<br />
<strong>Leite de vaca – dissonante</strong><br />
Peixe branco – ressonante<br />
Arroz (integral) – ressonante<br />
Arroz (branco)&nbsp;– neutro<br />
Sal de cozinha – neutro<br />
Sal do Himalaia – ressonante<br />
<strong>Soja – dissonante</strong><br />
Própolis verde – ressonante<br />
Cacau 100% alcalino – ressonante<br />
<strong>Cacau 100% puro – dissonante</strong><br />
Damasco – neutro<br />
Tâmara – ressonante<br />
Uva-passa – ressonante<br />
Pistache (castanha) – ressonante<br />
Morango – ressonante<br />
Banana – ressonante<br />
Mexerica – ressonante<br />
Limão – ressonante<br />
Chá ginseng – ressonante<br />
Chá de gengibre com limão – ressonante<br />
Leite de coco – ressonante<br />
<strong>Chocolate – dissonante</strong><br />
Feijão – ressonante<br />
Tomate – ressonante<br />
Molho de tomate – ressonante<br />
Leite de castanha – neutro<br />
<strong>Mel – dissonante</strong><br />
Salmão – ressonante<br />
<strong>Cogumelo – dissonante</strong><br />
Mandioca – ressonante<br />
Batata inglesa/doce – neutro<br />
Tapioca – ressonante<br />
<strong>Repolho – dissonante</strong><br />
Brócolis – ressonante<br />
Chá preto – neutro<br />
Chá verde – ressonante<br />
Castanhas – ressonante<br />
<strong>Granola sem acúçar/com açúcar&nbsp; – dissonante</strong><br />
<strong>Aveia – dissonante</strong><br />
<strong>Cafeína – dissonante&nbsp;</strong><br />
<br />
Histamina – neutro</span></h2>
<span style=&quot;font-size:14px&quot;>&nbsp;</span>

<h2><span style=&quot;font-size:14px&quot;><strong>Metais pesados:&nbsp;</strong><br />
<strong>Alumínio – dissonante</strong><br />
<strong>Arsênico – dissonante</strong><br />
<strong>Chumbo – dissonante</strong><br />
<strong>Enxofre – dissonante</strong><br />
<strong>Mercúrio – dissonante</strong><br />
<strong>Níquel – dissonante</strong></span></h2>
<br />
<br />
<span style=&quot;font-size:14px&quot;><strong>Medicamentos:</strong><br />
Lyberdia 15 gotas – ressonante<br />
<strong>Venvance 30 mg – dissonante<br />
Venvance 50 mg – dissonante</strong><br />
<br />
<br />
<strong>Alergia:</strong><br />
<strong>Pele, saliva e caspa de gato – dissonante</strong></span><br />
<br />
<br />
OBS.: Este teste não deve ser utilizado como diagnóstico médico, nem substitui consulta, exame clínico ou exames laboratoriais. Os resultados obtidos por meio da bioressonância têm caráter complementar e devem ser interpretados em conjunto com a avaliação clínica realizada por um profissional habilitado, considerando o histórico, os sintomas e demais exames do paciente.<br />
&nbsp;
<ul>
	<li><strong>ALIMENTOS EM NEGRITO SUGEREM-SE EVITAR NA DIETA.</strong></li>
	<li><strong>ALIMENTOS NEUTROS: PODEM SER CONSUMIDOR DE 2X A 3X POR SEMANA.&nbsp;</strong></li>
</ul>
<br />
Avaliado e revisado por:<br />
<strong>Dra. Ana Carolina Candia Barra<br />
Biomédica – CRBM: 26073</strong>', 'Ana Carolina Candia Barra', '2026-07-29 16:33:09'),
  ('72632100100', 'atestado', '<p>Paciente ficou de avaliar se irá fazer a Vitamina D - 100.000 e Vitamina B12.&nbsp;</p>

<p>R$480,80</p>
', 'Ester Virginio dos Santos Tomaz', '2026-08-17 12:54:54'),
  ('85260665104', 'atestado', 'Ajuste do guia alimentar&nbsp;<br />
<br />
Guia alimentar base - 5S&nbsp;<br />
<br />
<strong>Com os seguintes ajustes a serem feitos:</strong><br />
<br />
<span style=&quot;font-size:12px&quot;>Alimentos que devem ser evitados ( após o probiome)&nbsp;</span>
<p><span style=&quot;font-size:12px&quot;>Principais fermentadores:</span></p>

<p>açúcar<br />
mel<br />
frutas muito doces<br />
farinha de trigo<br />
pão<br />
massas<br />
aveia<br />
feijão<br />
lentilha<br />
grão de bico<br />
leite<br />
queijos frescos<br />
cebola<br />
alho cru<br />
couve-flor<br />
brócolis cru<br />
repolho<br />
batata doce em excesso<br />
banana madura<br />
<br />
Ou seja: alimentos que tenha no primeiro guia de base, mas que estão na lista de alimentos não permitidos devem ser evitados.&nbsp;<br />
&nbsp;</p>
', 'Ana Carolina Candia Barra', '2026-08-27 17:57:05'),
  ('25520199191', 'atestado', 'Em caso de excesso de ferro (como na hemocromatose ou ferritina alta), você deve evitar o consumo de <!--qkimaf RrffE_n/HugV6--><!--cqw1tb RrffE_n/HugV6-->carnes vermelhas, vísceras e alimentos fortificados<!--TgQPHd|||[[]]-->.<br />
<!--TgQPHd|||[]--><br />
Alimentos para Evitar<!--TgQPHd|||[]-->
<ul>
	<li><strong>Vísceras:<!--TgQPHd|||[]--></strong> Fígado (bovino ou de frango), coração e moela.<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
</ul>

<ul>
	<li><strong>Carnes vermelhas:<!--TgQPHd|||[]--></strong> Carne bovina, suína e cordeiro.<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
</ul>

<ul>
	<li><strong>Frutos do mar crus:<!--TgQPHd|||[]--></strong> Devem ser evitados por risco de infecções graves em quem tem excesso de ferro.<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
</ul>

<ul>
	<li><strong>Alimentos industrializados:<!--TgQPHd|||[]--></strong> Produtos fortificados com ferro (como farinhas e cereais matinais enriquecidos). sempre observe os rótulos e evite alimentos fortificados com ferro.<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
</ul>

<ul>
	<li><strong>Leguminosas e oleaginosas em excesso:<!--TgQPHd|||[]--></strong> Feijão, lentilha, grão-de-bico, soja e sementes de abóbora.</li>
</ul>

<ul>
</ul>
', 'Ana Carolina Candia Barra', '2026-08-28 16:10:45'),
  ('76823660104', 'atestado', 'Em caso de excesso de ferro (como na hemocromatose ou ferritina alta), você deve evitar o consumo de&nbsp;carnes vermelhas, vísceras e alimentos fortificados.<br />
<br />
Alimentos para Evitar
<ul>
	<li><strong>Vísceras:</strong>&nbsp;Fígado (bovino ou de frango), coração e moela.</li>
</ul>

<ul>
	<li><strong>Carnes vermelhas:</strong>&nbsp;Carne bovina, suína e cordeiro.</li>
</ul>

<ul>
	<li><strong>Frutos do mar crus:</strong>&nbsp;Devem ser evitados por risco de infecções graves em quem tem excesso de ferro.</li>
</ul>

<ul>
	<li><strong>Alimentos industrializados:</strong>&nbsp;Produtos fortificados com ferro (como farinhas e cereais matinais enriquecidos). sempre observe os rótulos e evite alimentos fortificados com ferro.</li>
</ul>

<ul>
	<li><strong>Leguminosas e oleaginosas em excesso:</strong>&nbsp;Feijão, lentilha, grão-de-bico, soja e sementes de abóbora.</li>
</ul>
', 'Ana Carolina Candia Barra', '2026-08-28 18:12:30'),
  ('04288150140', 'atestado', '<strong>Encaminhamento Psicoterapêutico</strong><br />
<br />
<br />
Encaminho o paciente&nbsp;<strong>Ícaro Figueiredo Almeida</strong>&nbsp;para acompanhamento psicológico.<br />
<strong>CID-10: F40</strong><br />
<br />
<br />
<br />
Brasília, 02 de setembro de 2026.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-09-02 12:23:15'),
  ('69982490125', 'atestado', '<strong>Guia&nbsp; Alimentar<br />
<br />
Manutenção + ganho de massa muscular</strong><br />
<br />
Peso atual: 78,2 kg<br />
Objetivo: preservar o peso, reduzir/manter gordura e estimular ganho de aproximadamente 1 kg de massa muscular.<br />
Estratégia<br />
<br />
<strong>CAFÉ DA MANHÃ</strong><br />
<br />
<strong>Opção 1 — Aveia + ovos</strong><br />
2 ovos inteiros<br />
Aveia: 25 g<br />
Leite de coco em pó: 15 g<br />
Morangos: 100–150 g<br />
Chia: 5 g<br />
Café<br />
Preparo: aveia com água e leite de coco em pó, podendo acrescentar canela.<br />
<br />
<strong>Opção 2 — Tapioca</strong><br />
Goma de tapioca: 35 g<br />
2 ovos<br />
Frango desfiado: 50 g<br />
1 pequena porção de fruta<br />
<br />
<strong>Opção 3 — Cuscuz</strong><br />
<br />
Cuscuz cozido: 80–100 g<br />
2 ovos<br />
1 porção pequena de fruta<br />
Café<br />
<br />
<strong>Opção 4 — Vitamina</strong><br />
Banana: 80 g<br />
Aveia: 20 g<br />
Leite de coco em pó: 15 g<br />
Proteína vegetal ou whey isolado sem lactose: 25 g<br />
Água + gelo + canela<br />
<br />
<strong>ALMOÇO</strong><br />
<br />
Carne/frango/peixe: 150 g<br />
Arroz cozido: 80 a 100g<br />
Feijão: 60 g<br />
Salada e legumes: à vontade<br />
Azeite: 1 colher de chá.<br />
<br />
<strong>Combinações</strong><br />
Frango + arroz + feijão + legumes<br />
Patinho + arroz + feijão + salada<br />
Peixe + arroz + feijão + legumes<br />
Podemos variar os vegetais livremente.<br />
<br />
Alternativa ao arroz<br />
Quando quiser variar:<br />
batata, mandioca, inhame ou abóbora<br />
<br />
<strong>LANCHE DA TARDE</strong><br />
.<br />
<strong>Opção 1 — Creme de iogurte vegetal</strong><br />
Iogurte vegetal sem açúcar: 170–200 g<br />
Aveia: 20 g<br />
Fruta: 1 porção<br />
Chia: 5 g<br />
Proteína vegetal/whey isolado sem lactose: 20–25g<br />
<br />
<strong>Opção 2 — Tapioca + ovos</strong><br />
Tapioca: 30 g<br />
2 ovos<br />
1 fruta pequena<br />
<br />
<strong>Opção 3 — Sanduíche</strong><br />
Pão integral: 40 g<br />
Frango desfiado: 70 g<br />
Tomate e folhas<br />
1 fruta pequena<br />
Obs:O pão entra eventualmente, não diariamente como base.<br />
<br />
<strong>Opção 4 — Vitamina proteica</strong><br />
Banana: 80 g<br />
Aveia: 15–20 g<br />
Leite de coco em pó: 15 g<br />
Proteína vegetal ou whey isolado sem lactose: 25 g<br />
Água + gelo<br />
<br />
<strong>&nbsp;JANTAR</strong><br />
150 g de proteína + 1 raiz/tubérculo + vegetais + azeite.<br />
<br />
Opção 1<br />
Frango grelhado: 150 g<br />
Batata inglesa: 150–180 g<br />
Brócolis + abobrinha<br />
Azeite: 1 colher de chá<br />
<br />
Opção 2<br />
Patinho: 150 g<br />
Mandioca: 90–100 g<br />
Salada grande<br />
Legumes<br />
Azeite:&nbsp;1 colher de chá<br />
<br />
Opção 3<br />
Peixe: 160 g<br />
Batata-doce: 130–150 g<br />
Legumes<br />
Azeite:&nbsp;1 colher de chá<br />
<br />
Opção 4<br />
Carne magra: 150 g<br />
Inhame: 120–140 g<br />
Salada + legumes<br />
Azeite:&nbsp;1 colher de chá<br />
<br />
Opção 5<br />
Salmão: 140–150 g<br />
Mandioquinha: 130–150 g<br />
Legumes<br />
Nesse caso, como o salmão já fornece mais gordura, não precisa acrescentar os 10 g de azeite.<br />
<br />
LISTA DE SUBSTITUIÇÃO — JANTAR<br />
Escolher uma fonte:<br />
Batata inglesa - 150 g<br />
Batata-doce - 130 g<br />
Mandioca - 90g<br />
Inhame- 120g<br />
Cará - 120 g<br />
Mandioquinha - 130 g<br />
Abóbora cabotiá - 200 g<br />
<br />
&nbsp;<strong>SUBSTITUIÇÃO DAS PROTEÍNAS</strong><br />
Para as refeições principais:<br />
<br />
Frango 150g<br />
Patinho 150g<br />
Carne bovina magra 150g<br />
Peixe branco 160–180 g<br />
Salmão 140–150 g<br />
Lombo suíno 150 g<br />
Ovos - 3 unidade, ou 1 ovo para completar a proteína, cada ovo 50g<br />
<br />
SUBSTITUIÇÃO DO CARBOIDRATO DO ALMOÇO<br />
Para substituir a porção de arroz:<br />
Arroz cozido 80–100 g<br />
Batata 150–180 g<br />
Batata-doce 130–150 g<br />
Mandioca 90–100 g<br />
Inhame 120–140 g<br />
Cuscuz 80–100 g<br />
Quinoa cozida 100–120 g<br />
Massa cozida sem glúten&nbsp; 80–100 g<br />
O feijão pode permanecer se quiser&nbsp;<br />
<br />
&nbsp;FRUTAS<br />
até 2&nbsp; porções ao dia&nbsp;<br />
<br />
Uma porção:<br />
Banana: 80–100 g<br />
Maçã: 1 unidade<br />
Pera: 1 unidade<br />
Mamão papaya: 150 g<br />
Morango: 150 g<br />
Kiwi: 2 unidades<br />
Melão: 200 g<br />
Melancia: 200 g<br />
Abacaxi: 150 g<br />
Manga: 100 g<br />
Uva: 80–100 g<br />
Laranja: 1 unidade<br />
<br />
<strong>DIA DE MUSCULAÇÃO</strong><br />
<br />
Pré-treino - 30 a 60 min. antes<br />
Uma opção:<br />
Banana 100 g + 1 opção proteína<br />
ou<br />
Tapioca 50 g + frango 60–70 g<br />
ou<br />
Pão 50 g + 2 ovos<br />
<br />
Pós-treino<br />
Manter o jantar com a porção completa de raiz.<br />
<br />
&nbsp;SÁBADO PRAZEROSO — A CADA 15 DIAS<br />
<br />
Pão de queijo&nbsp;<br />
Pode fazer um café da manhã diferente:<br />
3–4 unidades pequenas/médias de pão de queijo<br />
2 ovos<br />
café<br />
fruta, se desejar<br />
Preferencialmente pão de queijo preparado com queijo sem lactose, conforme tolerância.<br />
Ou:<br />
escolher uma&nbsp; refeição do sábado se não houve o pão de quijo para ser a sua refeição livre&nbsp;<br />
&nbsp;pizza caseira<br />
&nbsp;hambúrguer caseiro<br />
outra preparação que você goste ou esteja com muita vontade<br />
<br />
ObS: A refeição prazerosa substitui uma refeição, não é adicionada a todas as outras.<br />
E não existe compensação no domingo, domengo volte a sua rotina saudável, sem necessidade de ficar sem comer.<br />
<br />
&nbsp;REGRA PARA OS PRÓXIMOS 30 DIAS<br />
<br />
“Não estamos buscando emagrecer mais rapidamente. Nosso objetivo agora é manter o peso enquanto melhoramos a composição corporal e aumentamos a massa muscular.”<br />
Acompanhar:<br />
Peso: 1–2×semana sem jejum , depois de ir ao nanheiro, sem roupa. e me mandar.<br />
Fome: diariamente, pela percepção - me relate.<br />
Energia: especialmente nos dias de treino<br />
Força: evolução da musculação<br />
Saciedade: entre as refeições', 'Ana Carolina Candia Barra', '2026-09-02 18:25:01'),
  ('69982490125', 'atestado', '<strong>Guia&nbsp; Alimentar<br />
<br />
Manutenção + ganho de massa muscular</strong><br />
<br />
<span style=&quot;font-size:11px&quot;>Peso atual: 78,2 kg<br />
Objetivo: preservar o peso, reduzir/manter gordura e estimular ganho de aproximadamente 1 kg de massa muscular.<br />
Estratégia</span><br />
<br />
<strong>CAFÉ DA MANHÃ</strong><br />
<br />
<strong>Opção 1 — Aveia + ovos</strong><br />
<span style=&quot;font-size:11px&quot;>2 ovos inteiros<br />
Aveia: 25 g<br />
Leite de coco em pó: 15 g<br />
Morangos: 100–150 g<br />
Chia: 5 g<br />
Café<br />
Preparo: aveia com água e leite de coco em pó, podendo acrescentar canela.</span><br />
<br />
<strong>Opção 2 — Tapioca</strong><br />
<span style=&quot;font-size:11px&quot;>Goma de tapioca: 35 g<br />
2 ovos<br />
Frango desfiado: 50 g<br />
1 pequena porção de fruta</span><br />
<br />
<strong>Opção 3 — Cuscuz</strong><br />
<br />
<span style=&quot;font-size:11px&quot;>Cuscuz cozido: 80–100 g<br />
2 ovos<br />
1 porção pequena de fruta<br />
Café</span><br />
<br />
<strong>Opção 4 — Vitamina</strong><br />
<span style=&quot;font-size:11px&quot;>Banana: 80 g<br />
Aveia: 20 g<br />
Leite de coco em pó: 15 g<br />
Proteína vegetal ou whey isolado sem lactose: 25 g<br />
Água + gelo + canela</span><br />
<br />
<strong>ALMOÇO</strong><br />
<br />
<span style=&quot;font-size:11px&quot;>Carne/frango/peixe: 150 g<br />
Arroz cozido: 80 a 100g<br />
Feijão: 60 g<br />
Salada e legumes: à vontade<br />
Azeite: 1 colher de chá.</span><br />
<br />
<strong>Combinações</strong><br />
<span style=&quot;font-size:11px&quot;>Frango + arroz + feijão + legumes<br />
Patinho + arroz + feijão + salada<br />
Peixe + arroz + feijão + legumes<br />
Podemos variar os vegetais livremente.<br />
<br />
Alternativa ao arroz<br />
Quando quiser variar:<br />
batata, mandioca, inhame ou abóbora</span><br />
<br />
<strong>LANCHE DA TARDE</strong><br />
<br />
<strong>Opção 1 — Creme de iogurte vegetal</strong><br />
<span style=&quot;font-size:11px&quot;>Iogurte vegetal sem açúcar: 170–200 g<br />
Aveia: 20 g<br />
Fruta: 1 porção<br />
Chia: 5 g<br />
Proteína vegetal/whey isolado sem lactose: 20–25g</span><br />
<br />
<strong>Opção 2 — Tapioca + ovos</strong><br />
<span style=&quot;font-size:11px&quot;>Tapioca: 30 g<br />
2 ovos<br />
1 fruta pequena</span><br />
<br />
<strong>Opção 3 — Sanduíche</strong><br />
<span style=&quot;font-size:11px&quot;>Pão integral: 40 g<br />
Frango desfiado: 70 g<br />
Tomate e folhas<br />
1 fruta pequena<br />
Obs:O pão entra eventualmente, não diariamente como base.</span><br />
<br />
<strong>Opção 4 — Vitamina proteica</strong><br />
<span style=&quot;font-size:11px&quot;>Banana: 80 g<br />
Aveia: 15–20 g<br />
Leite de coco em pó: 15 g<br />
Proteína vegetal ou whey isolado sem lactose: 25 g<br />
Água + gelo</span><br />
<br />
<strong>&nbsp;JANTAR</strong><br />
<span style=&quot;font-size:11px&quot;>150 g de proteína + 1 raiz/tubérculo + vegetais + azeite.<br />
<br />
Opção 1<br />
Frango grelhado: 150 g<br />
Batata inglesa: 150–180 g<br />
Brócolis + abobrinha<br />
Azeite: 1 colher de chá<br />
<br />
Opção 2<br />
Patinho: 150 g<br />
Mandioca: 90–100 g<br />
Salada grande<br />
Legumes<br />
Azeite:&nbsp;1 colher de chá<br />
<br />
Opção 3<br />
Peixe: 160 g<br />
Batata-doce: 130–150 g<br />
Legumes<br />
Azeite:&nbsp;1 colher de chá<br />
<br />
Opção 4<br />
Carne magra: 150 g<br />
Inhame: 120–140 g<br />
Salada + legumes<br />
Azeite:&nbsp;1 colher de chá<br />
<br />
Opção 5<br />
Salmão: 140–150 g<br />
Mandioquinha: 130–150 g<br />
Legumes<br />
Nesse caso, como o salmão já fornece mais gordura, não precisa acrescentar os 10 g de azeite.<br />
<br />
LISTA DE SUBSTITUIÇÃO — JANTAR<br />
Escolher uma fonte:<br />
Batata inglesa - 150 g<br />
Batata-doce - 130 g<br />
Mandioca - 90g<br />
Inhame- 120g<br />
Cará - 120 g<br />
Mandioquinha - 130 g<br />
Abóbora cabotiá - 200 g</span><br />
<br />
&nbsp;<strong>SUBSTITUIÇÃO DAS PROTEÍNAS</strong><br />
<span style=&quot;font-size:11px&quot;>Para as refeições principais:<br />
<br />
Frango 150g<br />
Patinho 150g<br />
Carne bovina magra 150g<br />
Peixe branco 160–180 g<br />
Salmão 140–150 g<br />
Lombo suíno 150 g<br />
Ovos - 3 unidade, ou 1 ovo para completar a proteína, cada ovo 50g<br />
<br />
SUBSTITUIÇÃO DO CARBOIDRATO DO ALMOÇO<br />
Para substituir a porção de arroz:<br />
Arroz cozido 80–100 g<br />
Batata 150–180 g<br />
Batata-doce 130–150 g<br />
Mandioca 90–100 g<br />
Inhame 120–140 g<br />
Cuscuz 80–100 g<br />
Quinoa cozida 100–120 g<br />
Massa cozida sem glúten&nbsp; 80–100 g<br />
O feijão pode permanecer se quiser&nbsp;<br />
<br />
&nbsp;FRUTAS<br />
até 2&nbsp; porções ao dia&nbsp;<br />
<br />
Uma porção:<br />
Banana: 80–100 g<br />
Maçã: 1 unidade<br />
Pera: 1 unidade<br />
Mamão papaya: 150 g<br />
Morango: 150 g<br />
Kiwi: 2 unidades<br />
Melão: 200 g<br />
Melancia: 200 g<br />
Abacaxi: 150 g<br />
Manga: 100 g<br />
Uva: 80–100 g<br />
Laranja: 1 unidade</span><br />
<br />
<strong>DIA DE MUSCULAÇÃO</strong><br />
<br />
<span style=&quot;font-size:11px&quot;>Pré-treino - 30 a 60 min. antes<br />
Uma opção:<br />
Banana 100 g + 1 opção proteína<br />
ou<br />
Tapioca 50 g + frango 60–70 g<br />
ou<br />
Pão 50 g + 2 ovos<br />
<br />
Pós-treino<br />
Manter o jantar com a porção completa de raiz.<br />
<br />
&nbsp;SÁBADO PRAZEROSO — A CADA 15 DIAS<br />
<br />
Pão de queijo&nbsp;<br />
Pode fazer um café da manhã diferente:<br />
3–4 unidades pequenas/médias de pão de queijo<br />
2 ovos<br />
café<br />
fruta, se desejar<br />
Preferencialmente pão de queijo preparado com queijo sem lactose, conforme tolerância.<br />
Ou:<br />
escolher uma&nbsp; refeição do sábado se não houve o pão de quijo para ser a sua refeição livre&nbsp;<br />
&nbsp;pizza caseira<br />
&nbsp;hambúrguer caseiro<br />
outra preparação que você goste ou esteja com muita vontade<br />
<br />
ObS: A refeição prazerosa substitui uma refeição, não é adicionada a todas as outras.<br />
E não existe compensação no domingo, domengo volte a sua rotina saudável, sem necessidade de ficar sem comer.<br />
<br />
&nbsp;REGRA PARA OS PRÓXIMOS 30 DIAS<br />
<br />
“Não estamos buscando emagrecer mais rapidamente. Nosso objetivo agora é manter o peso enquanto melhoramos a composição corporal e aumentamos a massa muscular.”<br />
Acompanhar:<br />
Peso: 1–2×semana sem jejum , depois de ir ao nanheiro, sem roupa. e me mandar.<br />
Fome: diariamente, pela percepção - me relate.<br />
Energia: especialmente nos dias de treino<br />
Força: evolução da musculação<br />
Saciedade: entre as refeições</span>', 'Ester Virginio dos Santos Tomaz', '2026-09-02 21:40:00'),
  ('21639183191', 'atestado', '<strong><span style=&quot;font-size:20px&quot;>Guia alimentar - Novo estilo de vida</span><br />
<br />
<br />
CAFÉ DA MANHÃ</strong><br />
<br />
<strong>Opção 1 </strong>— Aveia + ovos<br />
2 ovos inteiros<br />
Aveia: 30 g<br />
Leite de coco em pó: 15 g<br />
Morango: 100–150 g<br />
Chia: 5 g<br />
Canela<br />
Café sem açúcar<br />
<br />
<strong>Opção 2 </strong>— Tapioca<br />
Tapioca: 40 g<br />
2 ovos<br />
Frango desfiado: 40 g<br />
1 fruta pequena<br />
Café<br />
<br />
<strong>Opção 3 </strong>— Cuscuz<br />
Cuscuz de milho cozido: 100 g<br />
2 ovos<br />
1 fruta pequena<br />
Café<br />
<br />
<strong>Opção 4 </strong>— Vitamina<br />
Banana: 80–100 g<br />
Aveia: 25 g<br />
Leite de coco em pó: 15 g<br />
Proteína vegetal ou Whey protein isolado: 20–25 g<br />
Canela<br />
Água + gelo<br />
<br />
<strong>Nos dias de musculação</strong><br />
Priorizar as opções 1, 2 ou 4, principalmente se ela continuar sentindo falta de energia após o exercício.<br />
<br />
<strong>&nbsp;APÓS O TREINO</strong><br />
Se o almoço for realizado até aproximadamente 1–2 horas após a musculação:<br />
? não é necessário fazer uma refeição adicional.<br />
O almoço será a refeição de recuperação após o treino;<br />
Se houver um intervalo grande e aparecer fome:<br />
1 fruta<br />
<br />
&nbsp;<strong>ALMOÇO</strong><br />
Base<br />
Proteína: 130 g<br />
Arroz cozido: 80–100 g<br />
Feijão: 70 g<br />
Salada e legumes: à vontade<br />
Azeite extravirgem: 1 colher de chá<br />
Proteínas<br />
Alternar:<br />
frango<br />
patinho<br />
carne bovina magra<br />
peixe<br />
lombo suíno<br />
ovos eventualmente<br />
Exemplo<br />
130 g de frango + 90 g de arroz + 70 g de feijão + legumes + 10 g de azeite para cozinhar<br />
<br />
<strong>&nbsp;LANCHE DA TARDE</strong><br />
<strong>Opção 1 </strong>— Iogurte grego verdadeiro ( vou enviar uns exemplos)<br />
Iogurte&nbsp; 170–200 g<br />
Aveia: 20 g<br />
1 porção de fruta picada<br />
Chia: 5 g<br />
Whey protein isolado 20 g, se necessário.<br />
<br />
<strong>Opção 2 </strong>— Tapioca + ovos<br />
Tapioca: 30–40 g<br />
2 ovos<br />
1 fruta pequena<br />
<br />
<strong>Opção 3 </strong>— Sanduíche<br />
Pão sem glúten: 40–50 g<br />
Frango desfiado: 50–60 g<br />
Tomate e folhas<br />
1 fruta pequena<br />
<br />
<strong>Opção 4 </strong>— Vitamina<br />
Banana: 80 g<br />
Aveia: 20 g<br />
Leite de coco em pó: 15 g<br />
Proteína vegetal: 20–25 g<br />
Água + gelo<br />
<br />
<strong>&nbsp;JANTAR</strong><br />
Proteína: 120–130 g<br />
Legumes e verduras: à vontade<br />
Azeite: 1 colher de chá<br />
<br />
Exemplos<br />
Frango + brócolis + abobrinha<br />
Peixe + legumes assados<br />
Patinho + berinjela + salada<br />
Omelete + vegetais, eventualmente.<br />
<strong>Importante<br />
&nbsp;podemos acrescentar uma pequena fonte de carboidrato:</strong><br />
Batata: 100 g<br />
Batata-doce: 100 g<br />
Inhame: 100g<br />
Abóbora: 150 g<br />
Especialmente nos dias anteriores à musculação.<br />
<br />
<strong>LISTA DE SUBSTITUIÇÕES<br />
PROTEÍNAS</strong><br />
Frango<br />
120–130 g<br />
Patinho<br />
120–130 g<br />
Carne bovina magra<br />
120–130 g<br />
Peixe<br />
140–150 g<br />
Lombo suíno<br />
120–130 g<br />
Salmão<br />
~120 g<br />
Ovos<br />
2–3 unidades, ajustando a refeição<br />
<br />
<strong>CARBOIDRATOS<br />
Para almoço</strong><br />
<br />
Arroz cozido<br />
80–100 g<br />
Batata<br />
150–180 g<br />
Batata-doce<br />
130–150 g<br />
Mandioca<br />
90–100 g<br />
Inhame<br />
120–140 g<br />
Cuscuz<br />
90–100 g<br />
Quinoa cozida<br />
100–120 g<br />
Massa sem glúten<br />
80–100 g<br />
Aveia<br />
25–30 g<br />
Tapioca<br />
35–40 g<br />
<br />
<strong>GORDURAS</strong><br />
Escolher conforme a refeição:<br />
Azeite extravirgem: 10 g<br />
Abacate: 40–50 g<br />
Castanhas: 15 g<br />
Amêndoas: 15 g<br />
Pasta de amendoim: 15 g<br />
Chia/linhaça: 10–15 g<br />
<br />
<strong>&nbsp;FRUTAS</strong><br />
2 porções ao dia, podendo chegar a 3 conforme fome e treinamento.<br />
Exemplos:<br />
banana<br />
maçã<br />
pera<br />
mamão<br />
morango<br />
kiwi<br />
laranja<br />
mexerica<br />
abacaxi<br />
melão<br />
melancia<br />
manga<br />
uva<br />
frutas vermelhas<br />
<br />
&nbsp;<strong>REFEIÇÃO PRAZEROSA — A CADA 15 DIAS</strong><br />
<br />
Poderá comer a preparação da forma que realmente gosta.<br />
<br />
&nbsp;Macarrão<br />
Pode ser:<br />
massa tradicional com glúten;<br />
azeite ou banha de porco;<br />
alho;<br />
extrato de tomate;<br />
carne;<br />
temperos.<br />
<br />
&nbsp;Filé à milanesa<br />
Pode utilizar:<br />
filé;<br />
ovo;<br />
farinha panko tradicional, inclusive com glúten;<br />
preparação da maneira que ela gosta.<br />
<br />
&nbsp;Arroz com carne<br />
Pode preparar o arroz e a carne juntos, como ela gosta.<br />
Apenas orientaria a colocar a porção no prato antes de começar a comer, porque ela relatou medo de perder o controle com esse prato.<br />
<br />
&nbsp;Pão de queijo<br />
Também entra.<br />
Pode ser o pão de queijo tradicional que ela gosta, inclusive com queijo, a cada 15 dias, em uma refeição planejada.<br />
Não precisamos transformar essa refeição em &quot;pão de queijo saudável&quot;.<br />
<br />
<strong>&nbsp;COMO FUNCIONA A REFEIÇÃO PRAZEROSA</strong><br />
Uma refeição a cada 15 dias.<br />
Exemplo:<br />
Sábado: pão de queijo no café da manhã.<br />
Ou:<br />
Sábado: macarrão no almoço.<br />
Ou:<br />
Sábado: filé à milanesa no almoço.<br />
Ou:<br />
Sábado: arroz com carne no jantar.<br />
<br />
Ou seja, escolher uma refeição livre neste dia, as demais refeiçoes do dia devem seguir de acordo com o cardapio.&nbsp;<br />
<br />
E depois?<br />
Volta normalmente para a alimentação planejada.<br />
Sem:<br />
&nbsp;jejum compensatório<br />
&nbsp;cortar carboidrato no dia seguinte<br />
&nbsp;&quot;detox&quot;<br />
&nbsp;culpa<br />
&nbsp;transformar a exceção em um dia inteiro de exageros<br />
A refeição prazerosa é parte da estratégia de manutenção.<br />
&nbsp;', 'Ana Carolina Candia Barra', '2026-09-05 08:56:18'),
  ('83395296768', 'atestado', '1. Metabolismo Ósseo, Mineral e Nutricional<!--TgQPHd|||[]--><br />
<!--TgQPHd|||[]--><!--TgQPHd|||[]-->
<ul>
	<li>Cálcio sérico (Total e Iônico)<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li>Paratormônio (PTH) intacto<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li>Fosfatase Alcalina sérica<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li>Fósforo sérico<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li>Magnésio sérico<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li>Albumina sérica<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li>Hemograma completo + Ferritina<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li>Iodo sérico ( iodemia)</li>
</ul>

<ul>
	<li><strong>Cálcio Urinário de 24 horas<!--TgQPHd|||[]--></strong> (com volume)<!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
</ul>

<ul>
	<li><strong>Cortisol&nbsp;</strong><!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li><strong>Homocisteína</strong><!--TgQPHd|||[]--><!--TgQPHd|||[]--></li>
	<li><strong>Estrogênio e Testosterona</strong></li>
</ul>
<!--TgQPHd|||[]-->', 'Ana Carolina Candia Barra', '2026-09-10 16:10:46'),
  ('53698258153', 'atestado', '<strong>Guia alimentar - sugestão de cardapio.&nbsp;<br />
<br />
café da manhã</strong><br />
<br />
2 ovos ( cozidos, mexidos, omelete, etc).<br />
1 banana da terra cozida com ou sem canela.<br />
<br />
<strong>Lanche da manhã.</strong><br />
<br />
1 yogurte grego verdadeiro&nbsp;<br />
com uam fatita de mamão<br />
ou 3 ameixas secas.<br />
<br />
<strong>Almoço</strong><br />
<br />
150g de proteína pesada depois de pronta<br />
slada e verduras variadas á vontade.<br />
3 colheres de sopa de arroz integral ou 3 rodelas de alguma raiz, ( abobora, batata doce, batata baroa etc)<br />
<br />
<strong>Lanche da tarde</strong><br />
<br />
Shayke proteico:<br />
1 scoop de whey protein isolado<br />
leite de coco em pó ou leite de castanhas.<br />
1 fruta - banana, morango, ou mamão<br />
<br />
<strong>Jantar.</strong><br />
<br />
120 g de proteína ou 2 a 3 ovos.&nbsp;<br />
1 fonte de carboidrato ( 80 a 100 g) (konjac, batata doce, arroz etc)<br />
salada ou um vegetal cozidinho.&nbsp;<br />
<br />
Pode fazer uma sopa ou caldo para facilitar a ingestão.&nbsp;<br />
<br />
<strong>OBs: lembre-se da meta de água diária.&nbsp;<br />
peso x 35 ml<br />
<br />
total:&nbsp; 2L e 400ml<br />
ou 4 garrafinhas e meia no dia&nbsp;</strong>', 'Ana Carolina Candia Barra', '2026-09-15 10:21:32'),
  ('12552898807', 'pedido_exame', '<ul>
	<li>Solicito :&nbsp;</li>
	<li>&nbsp;</li>
	<li>&nbsp;</li>
	<li>• Ultrassonografia de abdome total</li>
	<li>• Ultrassonografia da tireoide com Doppler</li>
	<li>• Ultrassonografia da próstata</li>
	<li>• Ultrassonografia do aparelho urinário</li>
</ul>

<p>&nbsp;</p>

<p>Cid :Z00</p>
', 'Danielle Candia Barra', '2025-07-24 08:36:58'),
  ('12552898807', 'pedido_exame', '<p>Solicito&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Polissonografia Basal&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Cid :&nbsp;G47.0</p>
', 'Danielle Candia Barra', '2025-07-24 08:37:46'),
  ('12552898807', 'pedido_exame', '<p>Solicito&nbsp;</p>

<p>&nbsp;</p>

<p>Eletrocardiograma&nbsp;</p>

<p>Holter 24 horas&nbsp;</p>

<p>&nbsp;</p>

<p>Cid : Z00</p>
', 'Danielle Candia Barra', '2025-07-24 08:39:55'),
  ('12552898807', 'pedido_exame', '<ul>
	<li>Solicito exames:</li>
	<li>&nbsp;</li>
	<li>• TSH ultrassensível</li>
	<li>• T3 livre</li>
	<li>• T4 livre</li>
	<li>• Tireoglobulina</li>
	<li>• Anticorpo antimicrossomal / Anticorpo antitireoglobulina</li>
	<li>• Cortisol matinal</li>
	<li>• SDHEA</li>
	<li>• FSH</li>
	<li>• LH</li>
	<li>• Estradiol</li>
	<li>• Estrona</li>
	<li>• Testosterona Total</li>
	<li>• SHBG</li>
	<li>• Serotonina</li>
	<li>• Prolactina</li>
	<li>• IGF-1 (obs: dosado em nanogramas/ml)</li>
	<li>• 25-hidróxi Vitamina D3</li>
	<li>• Vitamina B12</li>
	<li>• Cálcio sérico</li>
	<li>• Cálcio Ionizado</li>
	<li>• Fósforo Sérico</li>
	<li>• PTH</li>
	<li>• Hemograma completo</li>
	<li>• TGO</li>
	<li>• TGP</li>
	<li>• Gama GT</li>
	<li>• Creatinina</li>
	<li>• Uréia</li>
	<li>• Ácido Úrico</li>
	<li>• Homocisteína</li>
	<li>• Ferro sérico</li>
	<li>• Ferritina</li>
	<li>• Proteína C reativa ultrassensível</li>
	<li>• Fibrinogênio</li>
	<li>• Lipoproteína A</li>
	<li>• Glicemia de jejum</li>
	<li>• HB A1C</li>
	<li>• Insulina de jejum</li>
	<li>• Colesterol total</li>
	<li>• HDL</li>
	<li>• LDL</li>
	<li>• Triglicéride</li>
	<li>• Coprológico Funcional</li>
	<li>• Cortisol salivar: 8h, 12h, 16h e 22h</li>
</ul>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Solicito Urina I</p>

<p>&nbsp;</p>

<p><br />
<br />
____________________________________<br />
Assinatura / Carimbo Médico</p>
', 'Danielle Candia Barra', '2025-07-24 08:40:46'),
  ('12552898807', 'pedido_exame', '<p>RECOMENDAÇÕES:</p>

<ul>
	<li>• Evitar leite integral, semidesnatado e desnatado (comum).</li>
	<li>• Evitar queijos frescos: ricota, minas frescal, cottage, muçarela tradicional.</li>
	<li>• Evitar iogurtes tradicionais e creme de leite.</li>
	<li>• Preferir leites vegetais (amêndoas, coco, aveia sem adição de açúcar).</li>
	<li>• Utilizar queijos maturados (parmesão, grana padano, gouda) com moderação.</li>
	<li>• Iogurtes zero lactose e bebidas fermentadas vegetais são permitidos.</li>
	<li>• Utilizar enzima Lactase (ex: Lactosil®, Lacday®) 1 cápsula antes de refeições com lactose.</li>
	<li>• Observar sintomas como distensão abdominal, gases, fezes amolecidas e cólicas após refeições.</li>
</ul>

<p><br />
SUPLEMENTAÇÃO OPCIONAL:</p>

<ul>
	<li>• Probiótico com Lactobacillus acidophilus e Bifidobacterium – 1 cápsula ao dia em jejum.</li>
	<li>• Lactase (Lactosil® ou similar) – 1 cápsula 10 minutos antes de refeições com derivados lácteos.</li>
</ul>

<p><br />
<br />
____________________________________<br />
Assinatura / Carimbo Médico</p>
', 'Danielle Candia Barra', '2025-07-24 09:23:49'),
  ('57862680120', 'pedido_exame', 'Solicito&nbsp;<br />
<br />
<br />
Ultrassom de abdomen total<br />
Ultrassom Tireoide com doppler<br />
Ultrassom de mamas<br />
Ultrassom transvaginal<br />
<br />
<br />
Cid: Z00', 'Danielle Candia Barra', '2025-07-24 10:32:15'),
  ('27771730876', 'pedido_exame', '<p>Solicito&nbsp;</p>

<p>&nbsp;</p>

<p>Coprológico funcional</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Cid : Z00</p>
', 'Danielle Candia Barra', '2025-07-24 11:43:40'),
  ('27771730876', 'pedido_exame', '<p>Uso oral&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>1) Ultrogestam 200mg&nbsp;</p>

<p>&nbsp;</p>

<p>Tomar 01 cp vo antes de dormir a partir do décimo quinto dia da menstruação por 14 dias ou até a menstruação descer.</p>
', 'Danielle Candia Barra', '2025-07-24 11:47:09'),
  ('82608270506', 'pedido_exame', '<p>Solicito os seguintes exames:<br />
o TSH ultrassensível - T3 livre – T4 livre – Tireoglobulina<br />
o o SDHEA<br />
o FSH, LH o Estradiol, Estrona<br />
o Testosterona Total – SHBG<br />
o Serotonina, Prolactina<br />
o IGF-1 ( obs: dosado em nanogramas / ml )<br />
o 25-hidróxi Vitamina D3<br />
o Vitamina B12<br />
o Cálcio sérico, Cálcio Ionizado, Fósforo Sérico, PTH<br />
o Hemograma completo o TGO – TGP – Gama GT<br />
o Creatinina, Uréia, Ácido Úrico<br />
o Homocisteína<br />
o Ferro sérico, ferritina<br />
o Proteína C reativa ultrassensível<br />
o Fibrinogênio, Lipoproteína A<br />
o Glicemia de jejum – HB A1C – Insulina de jejum&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Cid:&nbsp;E88.81</p>
', 'Danielle Candia Barra', '2025-07-31 10:08:05'),
  ('82608270506', 'pedido_exame', '<p>Solicito:</p>

<p><br />
- Ultrassom de abdome total<br />
- Ultrassom de mamas<br />
- Ultrassom transvaginal<br />
- Ultrassom de tireoide com doppler</p>

<p>&nbsp;</p>

<p>Cid:E88.81</p>
', 'Danielle Candia Barra', '2025-07-31 10:09:24'),
  ('07844057602', 'pedido_exame', 'Solicito os seguintes exames:<br />
<br />
o TSH ultrassensível - T3 livre – T4 livre – Tireoglobulina<br />
o Anticorpo antimicrossomal /Anticorpo antitireoglobulina<br />
o Cortisol matinal o SDHEA<br />
o FSH, LH o Estradiol, Estrona<br />
o Testosterona Total – SHBG<br />
o Serotonina, Prolactina o IGF-1 ( obs: dosado em nanogramas / ml )<br />
o 25-hidróxi Vitamina D3<br />
o Vitamina B12<br />
o Cálcio sérico, Cálcio Ionizado, Fósforo Sérico, PTH<br />
o Hemograma completo o TGO – TGP – Gama GT<br />
o Creatinina, Uréia, Ácido Úrico<br />
o Homocisteína o Ferro sérico, ferritina<br />
o Proteína C reativa ultrassensível<br />
o Fibrinogênio, Lipoproteína A<br />
o Glicemia de jejum – HB A1C – Insulina de jejum<br />
o Colesterol total – HDL – LDL – Triglicérides<br />
o Urina EAS<br />
<br />
<br />
o Coprológico Funcional&nbsp;<br />
&nbsp;', 'Danielle Candia Barra', '2025-08-07 11:01:32'),
  ('07844057602', 'pedido_exame', 'Solicito:&nbsp;<br />
<br />
<br />
<br />
Apolipoproteína A&nbsp;<br />
<br />
<br />
Apoliproteína B<br />
<br />
<br />
Coagulograma<br />
<br />
<br />
D. Dímero.&nbsp;<br />
<br />
<br />
<br />
Cid :&nbsp; Z00', 'Danielle Candia Barra', '2025-09-04 11:43:40'),
  ('07844057602', 'pedido_exame', 'Solicito:&nbsp;<br />
<br />
<br />
<br />
Apolipoproteína A&nbsp;<br />
<br />
<br />
Apoliproteína B<br />
<br />
<br />
Coagulograma<br />
<br />
<br />
D. Dímero.<br />
Cid :&nbsp; Z00', 'Danielle Candia Barra', '2025-09-04 11:45:47'),
  ('07844057602', 'pedido_exame', '<br />
Cid :&nbsp; Z00<br />
Solicito:&nbsp;<br />
<br />
<br />
<br />
Apolipoproteína A&nbsp;<br />
<br />
<br />
Apoliproteína B<br />
<br />
<br />
Coagulograma<br />
<br />
<br />
D. Dímero.<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-04 11:46:17'),
  ('01663482799', 'pedido_exame', 'Solicito :&nbsp;<br />
<br />
<br />
<br />
&nbsp;<br />
1. Glicemia de jejum<br />
2. Glicemia pós-prandial (2 horas)<br />
3. Hemoglobina glicada (HbA1c)<br />
4. Insulina basal<br />
5. Insulina pós-prandial (2 horas)<br />
6. Peptídeo C<br />
7. HOMA-IR (cálculo)<br />
8. Hemograma completo<br />
9. Colesterol Total e frações<br />
<br />
<br />
Cid : Z00<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 09:22:58'),
  ('01663482799', 'pedido_exame', 'Cid : Z00<br />
<br />
Solicito :&nbsp;<br />
<br />
&nbsp;<br />
1. Glicemia de jejum<br />
2. Glicemia pós-prandial (2 horas)<br />
3. Hemoglobina glicada (HbA1c)<br />
4. Insulina basal<br />
5. Insulina pós-prandial (2 horas)<br />
6. Peptídeo C<br />
7. HOMA-IR (cálculo)<br />
8. Hemograma completo<br />
9. Colesterol Total e frações<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 09:26:47'),
  ('57895392115', 'pedido_exame', 'CRM: 22677-DF<br />
<br />
<br />
Solicito a realização do exame abaixo relacionado:<br />
?? **Espirometria com prova broncodilatadora (caso indicado)**<br />
<br />
?? Indicação Clínica:<br />
Avaliação da função pulmonar para investigação de queixas respiratórias, controle de doenças obstrutivas ou restritivas, e seguimento clínico.<br />
<br />
?? Observações:<br />
- Paciente deve comparecer ao exame em jejum leve e trazer exames pulmonares prévios, se houver.<br />
- Suspender broncodilatadores conforme orientação prévia do laboratório.<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 10:29:35'),
  ('57895392115', 'pedido_exame', 'Solicito a realização do exame abaixo relacionado:<br />
&nbsp;**Espirometria com prova broncodilatadora (caso indicado)**<br />
<br />
&nbsp;Indicação Clínica:<br />
Avaliação da função pulmonar para investigação de queixas respiratórias, controle de doenças obstrutivas ou restritivas, e seguimento clínico.<br />
<br />
&nbsp;Observações:<br />
- Paciente deve comparecer ao exame em jejum leve e trazer exames pulmonares prévios, se houver.<br />
- Suspender broncodilatadores conforme orientação prévia do laboratório.<br />
&nbsp;', 'Danielle Candia Barra', '2025-09-18 10:30:52'),
  ('34600779134', 'pedido_exame', '<p>Solicito&nbsp; videoestroboscopia por quadro de pigarro e disfonia recorrente.&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><br />
Cid : R04</p>
', 'Danielle Candia Barra', '2025-10-02 09:10:49'),
  ('34600779134', 'pedido_exame', '<p>Solicito a realização dos seguintes exames laboratoriais e complementares:</p>

<p>- Hemograma completo</p>

<p>- Glicemia de jejum</p>

<p>- Hemoglobina glicada (HbA1c)</p>

<p>- Insulina basal</p>

<p>- Eletrólitos séricos: Sódio, Potássio, Magnésio, Cálcio total e ionizado</p>

<p>- CK (creatinofosfoquinase)</p>

<p>- Função renal e hepática: Ureia, Creatinina, AST (TGO), ALT (TGP), GGT, FA, Bilirrubinas</p>

<p>- TSH e T4 Livre</p>

<p>- Vitamina B12 e Vitamina D3</p>

<p>- Ácido fólico e Homocisteína</p>

<p>- Ferritina</p>

<p>- PCR ultrasensível</p>

<p>- EAS + urina de 24h (cálcio, potássio e magnésio)</p>

<p>&nbsp;</p>

<p><br />
CIDs sugeridos:</p>

<p>- R25.1 – Tremor não especificado</p>

<p>- R25.2 – Cãibras e espasmos</p>

<p>- R53.8 – Outros sintomas e sinais gerais (fadiga, mal-estar)</p>

<p>- E11.9 – Diabetes mellitus tipo 2 sem complicações (pré-diabetes)</p>

<p>- I70.9 – Aterosclerose não especificada</p>

<p>- E78.5 – Dislipidemia não especificada</p>
', 'Danielle Candia Barra', '2025-10-02 09:12:14'),
  ('28722219803', 'pedido_exame', '<p><strong>PEDIDO MÉDICO - ECOGRAFIA TRANSVAGINAL</strong></p>

<p><br />
&nbsp;</p>

<p>Paciente: Miriam Vidal de Negreiros</p>

<p>Data: 02/10/2025</p>

<p><br />
Exame solicitado:</p>

<p>• Ecografia Transvaginal seriada para acompanhamento da ovulação</p>

<p><br />
CID sugerido: N97.0 – Infertilidade feminina associada à anovulação</p>

<p><br />
Justificativa clínica: Monitoramento do ciclo menstrual e acompanhamento da ovulação.</p>

<p><br />
&nbsp;</p>

<p>Dra. Danielle Candia Barra<br />
CRM-DF 22677</p>
', 'Danielle Candia Barra', '2025-10-02 10:22:43'),
  ('70122741153', 'pedido_exame', '<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Solicito&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Ultrassonografia de tireide com Doppler.&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Cid : Z00</p>
', 'Danielle Candia Barra', '2025-10-16 10:42:35'),
  ('05221311666', 'pedido_exame', '<h2>&nbsp;EXAMES SOLICITADOS</h2>

<h3>&nbsp;VECTONISTAGMOGRAFIA COMPUTADORIZADA (VNG)</h3>

<p>Realizar protocolo completo contendo:</p>

<ul>
	<li>
	<p>Pesquisa de nistagmo espontâneo</p>
	</li>
	<li>
	<p>Nistagmo semi-espontâneo</p>
	</li>
	<li>
	<p>Provas oculomotoras (sacádicos, rastreio pendular, optocinético)</p>
	</li>
	<li>
	<p>Provas posicionais e de posicionamento</p>
	</li>
	<li>
	<p>Prova calórica bilateral com cálculo de preponderância labiríntica e direcional</p>
	</li>
</ul>

<h3>&nbsp;ELETROCOCLEOGRAFIA (ECoG)</h3>

<ul>
	<li>
	<p>Com cálculo da relação SP/AP (Summating Potential / Action Potential)</p>
	</li>
	<li>
	<p>Técnica extratimpânica ou transtimpânica conforme protocolo do serviço<br />
	<br />
	Cid: 83.0</p>
	</li>
</ul>
', 'Danielle Candia Barra', '2026-02-23 12:38:21'),
  ('05221311666', 'pedido_exame', '<p>FORMULA 1 METILACAO E SUPORTE VASCULAR<br />
Capsulas gastro resistentes</p>

<p>Metilfolato 800 mcg<br />
Metilcobalamina 1000 mcg<br />
Piridoxal 5 fosfato 25 mg<br />
Riboflavina 25 mg<br />
Betaína 500 mg<br />
Magnesio bisglicinato 200 mg</p>

<p>Tomar 1 capsula 2 vezes ao dia apos refeicoes<br />
90 capsulas</p>

<hr />
<p>FORMULA 2 ANTIOXIDANTE COCLEAR E NEUROVASCULAR<br />
Capsulas gastro resistentes</p>

<p>N acetilcisteina 600 mg<br />
Coenzima Q10 100 mg<br />
Vitamina C 500 mg<br />
Selenio 100 mcg<br />
Vitamina E tocoferois mistos 200 UI</p>

<p>Tomar 1 capsula 2 vezes ao dia<br />
90 capsulas</p>

<hr />
<p>&nbsp;</p>
', 'Danielle Candia Barra', '2026-02-23 12:40:52'),
  ('83395296768', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
Hemoglobina Glicada<br />
Glicemia de Jejum<br />
HB1AC<br />
Ferro Sérico<br />
Ferritina<br />
Fibrinogênio<br />
TGO, TGP, GGT, FA<br />
TSH, T4 livre, T3 livre<br />
AntiTPO<br />
Ureia<br />
Creatinina<br />
Insulinemia<br />
Ácido úrico<br />
Lipidograma<br />
Homocisteína<br />
Na, Zinco e Selênio<br />
Vitamina C<br />
Vitamina A<br />
Vitamina B12<br />
Biotina<br />
25 OH VIT D<br />
Cálcio Sérico (Total e Iônico)<br />
Cortisol Sérico<br />
Testosterona total e livre calculada<br />
Estradiol<br />
IGF-1<br />
17 OH Progesterona<br />
FSH, LH<br />
SDHEA<br />
PTH<br />
PCR<br />
Fósforo sérico<br />
Magnésio sérico<br />
Albumina sérica<br />
Iodo sérico (iodemia)<br />
Cálcio Urinário de 24 horas&nbsp;(com volume)<br />
Estrogênio<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-10 17:39:43'),
  ('53103335253', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
HB1AC<br />
Glicose<br />
Ferro Sérico<br />
Ferritina<br />
TGO, TGP, GGT, FA<br />
Homocisteína<br />
PCR<br />
TSH, T4 livre, T3 livre Anti TPO, T3 Reverso<br />
Insulinemia, HOMA IR<br />
Lipidograma<br />
Sódio e Potássio<br />
Vitamina B12<br />
25 OH VIT D<br />
Ácido Úrico<br />
Ureia<br />
Creatinina<br />
G6PD<br />
Zinco<br />
Selênio<br />
Biotina<br />
Cortisol Sérico<br />
PTH<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-21 15:56:27'),
  ('03783788218', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
Hemoglobina Glicada<br />
Glicemia de Jejum<br />
HB1AC<br />
Ferro Sérico<br />
Ferritina<br />
Fibrinogênio<br />
TGO, TGP, GGT, FA<br />
TSH, T4 livre, T3 livre<br />
AntiTPO<br />
Ureia<br />
Creatinina<br />
Insulinemia<br />
Ácido úrico<br />
Lipidograma<br />
Homocisteína<br />
Na, Zinco e Selênio<br />
Vitamina C<br />
Vitamina A<br />
Vitamina B12<br />
Biotina<br />
25 OH VIT D<br />
Cálcio Sérico (Total e Iônico)<br />
Cortisol Sérico<br />
Testosterona total e livre calculada<br />
Estradiol<br />
IGF-1<br />
17 OH Progesterona<br />
FSH, LH<br />
SDHEA<br />
PTH<br />
PCR<br />
Fósforo sérico<br />
Magnésio sérico<br />
Albumina sérica<br />
Iodo sérico (iodemia)<br />
Estrogênio<br />
G6PD<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-22 11:13:09'),
  ('03783788218', 'pedido_exame', 'Ecodoppler venoso de membros inferiores bilateral&nbsp;', 'Ana Carolina Candia Barra', '2026-09-22 11:15:34'),
  ('87474808153', 'pedido_exame', 'Cortisol sérico&nbsp;<br />
Cortisol salivar&nbsp; 8:00, 12:00, 17:00 e 22:00', 'Ana Carolina Candia Barra', '2026-09-22 12:28:11'),
  ('75538784134', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
HB1AC<br />
Glicose<br />
Ferro Sérico<br />
Ferritina<br />
TGO, TGP, GGT, FA<br />
Homocisteína<br />
TSH, T4 livre, T3 livre Anti TPO, T3 Reverso<br />
Insulinemia, HOMA IR<br />
Lipidograma<br />
Sódio e Potássio<br />
Vitamina B12<br />
25 OH VIT D<br />
Ácido Úrico<br />
Ureia<br />
Creatinina<br />
G6PD<br />
Zinco<br />
Selênio<br />
Biotina<br />
Cortisol Sérico<br />
PTH<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-22 16:12:22'),
  ('78680166120', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
HB1AC<br />
Glicose<br />
Ferro Sérico<br />
Ferritina<br />
TGO, TGP, GGT, FA<br />
Homocisteína<br />
fibrinogênio<br />
TSH, T4 livre, T3 livre Anti TPO, T3 Reverso<br />
Insulinemia, HOMA IR<br />
Lipidograma<br />
Sódio e Potássio<br />
Vitamina B12<br />
25 OH VIT D<br />
Ácido Úrico<br />
Ureia<br />
Creatinina<br />
Zinco<br />
Selênio<br />
Biotina<br />
Cortisol Sérico<br />
PTH<br />
PCR<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-23 11:43:06'),
  ('83786210144', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
Hemoglobina Glicada<br />
Glicemia de Jejum<br />
HB1AC<br />
Ferro Sérico<br />
Ferritina<br />
Fibrinogênio<br />
TGO, TGP, GGT, FA<br />
TSH, T4 livre, T3 livre<br />
AntiTPO<br />
Ureia<br />
Creatinina<br />
Insulinemia, homa Beta e Homa IR<br />
Ácido úrico<br />
Lipidograma<br />
Homocisteína<br />
Na, Zinco e Selênio<br />
Vitamina C<br />
Vitamina A<br />
Vitamina B12<br />
Biotina<br />
25 OH VIT D<br />
Cálcio Sérico (Total e Iônico)<br />
Cortisol Sérico<br />
Testosterona total e livre calculada<br />
Estradiol<br />
IGF-1<br />
17 OH Progesterona<br />
FSH, LH<br />
SDHEA<br />
PTH<br />
PCR<br />
Fósforo sérico<br />
Magnésio sérico<br />
Albumina sérica<br />
Iodo sérico (iodemia)<br />
Estrogênio<br />
G6PD</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Apolipoproteína A&nbsp;</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Apolipoproteína B</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>SHBG</span></p>

<p><span style=&quot;font-family:courier new,courier,monospace&quot;>DHT<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-23 16:19:25'),
  ('53932072120', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
Hemoglobina Glicada<br />
Glicemia de Jejum<br />
HB1AC<br />
Ferro Sérico<br />
Ferritina<br />
Fibrinogênio<br />
TGO, TGP, GGT, FA<br />
TSH, T4 livre, T3 livre<br />
AntiTPO<br />
Ureia<br />
Creatinina<br />
Insulinemia<br />
Ácido úrico<br />
Lipidograma<br />
Homocisteína<br />
Na, Zinco e Selênio<br />
Vitamina C<br />
Vitamina A<br />
Vitamina B12<br />
Biotina<br />
25 OH VIT D<br />
Cálcio Sérico (Total e Iônico)<br />
Cortisol Sérico<br />
Testosterona total e livre calculada<br />
Estradiol<br />
IGF-1<br />
17 OH Progesterona<br />
FSH, LH<br />
SDHEA<br />
PTH<br />
PCR<br />
Fósforo sérico<br />
Magnésio sérico<br />
Albumina sérica<br />
Iodo sérico (iodemia)<br />
Cálcio Urinário de 24 horas&nbsp;(com volume)<br />
Estrogênio<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-24 10:09:02'),
  ('13138812104', 'pedido_exame', 'PTH<br />
Cálcio total + Albumina<br />
Cálcio Ionizado<br />
Fósforo&nbsp;<br />
Magnésio<br />
cratinina + eTFG<br />
Fosfatase alcalina<br />
Cálciúria de 24 horas', 'Ana Carolina Candia Barra', '2026-09-24 11:46:57'),
  ('05394684790', 'pedido_exame', '<p><span style=&quot;font-family:courier new,courier,monospace&quot;>Hemograma completo<br />
Hemoglobina Glicada<br />
Glicemia de Jejum<br />
HB1AC<br />
Ferro Sérico<br />
Ferritina<br />
Fibrinogênio<br />
TGO, TGP, GGT, FA<br />
TSH, T4 livre, T3 livre<br />
AntiTPO<br />
Ureia<br />
Creatinina<br />
Insulinemia<br />
Ácido úrico<br />
Lipidograma<br />
Homocisteína<br />
Na, Zinco e Selênio<br />
Vitamina C<br />
Vitamina A<br />
Vitamina B12<br />
Biotina<br />
CPK<br />
25 OH VIT D<br />
Cálcio Sérico (Total e Iônico)<br />
Cortisol Sérico<br />
Testosterona total e livre calculada<br />
Estradiol<br />
IGF-1<br />
17 OH Progesterona<br />
FSH, LH<br />
SDHEA<br />
PTH<br />
PCR<br />
Fósforo sérico<br />
Magnésio sérico<br />
Albumina sérica<br />
Iodo sérico (iodemia)<br />
Cálcio Urinário de 24 horas&nbsp;(com volume)<br />
Estrogênio<br />
G6PD<br />
&nbsp;</span></p>
', 'Ana Carolina Candia Barra', '2026-09-24 16:55:32'),
  ('05394684790', 'pedido_exame', 'Coprologico funcional&nbsp;', 'Ana Carolina Candia Barra', '2026-09-24 16:58:39'),
  ('05394684790', 'pedido_exame', 'Ultrassom de abdomen total', 'Ana Carolina Candia Barra', '2026-09-24 17:13:58')
) AS v(cpf, type, content, professional, note_date)
JOIN patients p ON p.cpf = v.cpf
ON CONFLICT DO NOTHING;

-- Verificação:
SELECT type, COUNT(*) FROM patient_clinical_notes GROUP BY type ORDER BY count DESC;