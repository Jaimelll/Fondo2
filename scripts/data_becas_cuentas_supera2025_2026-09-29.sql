-- ====================================================================
-- Paso 4 — beca_cuenta vigente (Supéra-T 2025 I y II)
-- Generado por scripts/oneoff/genera_becas_supera2025.cjs el 2026-09-29.
-- Fuente: BD becarios 2025-II (OP 205), correo Servicios 28/09/2026; BD becarios 2025-I (OP 206), correo Servicios 28/09/2026 (hoja «OP's 2026»). Emparejado por DNI.
-- Idempotente. No toca becas_nueva.avance ni avance_beca.
-- Solo inserta si la beca no tiene ya una cuenta vigente.
-- ====================================================================
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 667, 'BECARIO', 'ADCO DIAZ JHOSEPT ALEXANDER', '75431266', 1, '40515269265087', '00240511526926508790', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 667 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 668, 'BECARIO', 'ADVINCULA MORAN CAMILA DEL ROSARIO', '71152851', 1, '26515251144042', '00226511525114404270', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 668 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 669, 'BECARIO', 'ALAYZA SUYO CHRYSTIAN ZAYR', '61177692', 1, '19411028394090', '00219411102839409092', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 669 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 670, 'BECARIO', 'ALLCCAHUAMAN QUISPE EDILSON MATEO', '74842505', 2, '898 3503565104', '00389801350356510445', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 670 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 671, 'BECARIO', 'ALTAMIRANO ROJAS YONI', '60154375', 4, '0011-0814-0292269485-12', '01181400029226948512', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 671 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 672, 'BECARIO', 'AMORETTI ZAVALA NICOLE STEFANY', '73879829', 1, '194-15300393-0-41', '00219411530039304195', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 672 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 673, 'BECARIO', 'AMPUDIA CORTABRAZO FIORELLA ABIGAIL', '60736397', 1, '19115257482096', '00219111525748209653', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 673 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 674, 'BECARIO', 'APAZA CONDORI CARMEN NIEVES', '71509585', 1, '49515259557071', '00249511525955707102', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 674 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 675, 'BECARIO', 'APAZA CONDORI DIANA MARIBEL', '60517170', 1, '49515255874051', '00249511525587405108', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 675 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 677, 'BECARIO', 'ARCAYA POMA EDGAR', '74835779', 1, '495-15255432-0-05', '00249511525543200509', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 677 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 678, 'BECARIO', 'ARCE MORALES HAROLD LENN', '70721727', 1, '19315287167081', '00219311528716708114', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 678 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 679, 'BECARIO', 'AUCCAPUCLLA ORIUNDO GONZALO ERACLIO', '74349689', 1, '22015237935054', '00222011523793505427', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 679 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 680, 'BECARIO', 'AVILES GUEVARA GIOVANA RAQUEL', '74219860', 2, '8983503641781', '00389801350364178148', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 680 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 681, 'BECARIO', 'AYUQUE SOSAYA MERELYN', '73997585', 4, '0011-0202-0200706925', '01120200020070692591', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 681 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 682, 'BECARIO', 'AZA TACCA GLENY ABIGAIL', '60067535', 1, '405-15257198-0-98', '00240511525719809894', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 682 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 837, 'BECARIO', 'BABA BABA MUCHA SULI YEMIL', '76981301', 2, '898 3431648654', '00389801343164865444', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 837 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 683, 'BECARIO', 'BARRIENTOS TAMBRA BRUCE LEE', '70565841', 1, '22092834199017', '00222019283419901725', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 683 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 684, 'BECARIO', 'BARRIOS YUPANQUI GARY IVAN', '60231706', 2, '440 3503714038', '00344001350371403855', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 684 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 685, 'BECARIO', 'BOHORQUEZ CURO ROY NOEL', '74170062', 1, '19106737469022', '00219110673746902258', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 685 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 686, 'BECARIO', 'BOHORQUEZ ONCEBAY DIANA CAROLINA', '61173477', 2, '8983503610983', '00389801350361098347', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 686 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 687, 'BECARIO', 'CABALLERO FLORES SILVIA ESTHER', '71036838', 1, '39015239199001', '00239011523919900135', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 687 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 688, 'BECARIO', 'CAINAMARI TAMAYO CESIA KEREN', '63284262', 1, '39015250518036', '00239011525051803632', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 688 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 689, 'BECARIO', 'CALCINA QUISPE LUZ ESTRELLA', '71822204', 5, '04709418594', '01870900470941859460', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 689 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 690, 'BECARIO', 'CALDERÓN CHUNGA INGRID YACZUMY', '60522790', 1, '475-15257267-0-38', '00247511525726703826', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 690 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 691, 'BECARIO', 'CAMONES DIANDERAS MADAME LORENA', '71480918', 1, '400-15299679-0-03', '00240011529967900304', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 691 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 692, 'BECARIO', 'CAMPOS PÉREZ SHEYLA YHOSELIN', '76181221', 1, '410-15294671-0-55', '00241011529467105593', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 692 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 693, 'BECARIO', 'CANCHARI SANTIAGO FLOR ESTRELLA', '76390875', 1, '31515300626075', '00231511530062607502', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 693 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 694, 'BECARIO', 'CANO AYQUIPA JOSHUA ANTONIO', '76398138', 1, '19195751685071', '00219119575168507156', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 694 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 676, 'BECARIO', 'APAZA ENRIQUEZ YOSELYN BRENDA', '71154900', 1, '19113575458082', '00219111357545808250', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 676 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 695, 'BECARIO', 'CARBAJAL QUISPE YOSELIN BRIYID', '62191422', 1, '22015233320093', '00222011523332009327', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 695 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 696, 'BECARIO', 'CARHUA ESPINOZA DIOGENES', '60080720', 1, null, '00236511529124004455', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'En «N° cuenta» venía un número con forma de tarjeta; no se guarda'
where not exists (select 1 from public.beca_cuenta where beca_id = 696 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 697, 'BECARIO', 'CARRANZA CARRASCO YOISI', '60576429', 1, '47514629836069', '00247511462983606924', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 697 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 839, 'BECARIO', 'CASTILLA VALGA JOHANA ELIZABETH', '70872053', 1, '19410315685082', '00219411031568508299', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 839 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 698, 'BECARIO', 'CASTILLO MONTALVAN LEYDI MARIA', '60244088', 1, '575-15233754-0-89', '00257511523375408990', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 698 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 699, 'BECARIO', 'CASTILLO NIQUEN BRENDA LUZ', '76927247', 3, '0227897998', '00921620022789799838', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 699 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 700, 'BECARIO', 'CASTILLO PRETELL JEREMY JOSSTIN', '61514826', 2, '898 3489096643', '00389801348909664342', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 700 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 701, 'BECARIO', 'CASTRO CHAVEZ NELCY ANDREA', '60741307', 2, '8983503831246', '00389801350383124642', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 701 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 702, 'BECARIO', 'CASTRO VILCAS YULISA', '60143712', 1, '38013714801096', '00238011371480109649', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 702 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 703, 'BECARIO', 'CCESA PEREZ ALVARO MARTIN', '73808598', 6, '008033994428', '03810110803399442823', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 703 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 833, 'BECARIO', 'CHAGUA AMES  WILLIAM ALEXANDER', '75324474', 1, '19198553381067', '00219119855338106758', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 833 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 704, 'BECARIO', 'CHAMBILLA PEREZ JUAN CARLOS', '74663868', 2, '8983503516111', '00389801350351611140', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 704 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 705, 'BECARIO', 'CHAMPI TUPA SHARMELY', '60019326', 1, '28515315579047', '00228511531557904756', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 705 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 706, 'BECARIO', 'CHAPOÑAN GUEVARA PATRICK JAVIER', '71726931', 1, '19115254514099', '00219111525451409956', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 706 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 707, 'BECARIO', 'CHECCO ITO MARÍA LIZ', '61469477', 1, '405-15252117-0-67', '00240511525211706798', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 707 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 708, 'BECARIO', 'CONDOR MANYA CESIA ANTHOANELA', '74850977', 1, '19297770664044', '00219219777066404436', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 708 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 709, 'BECARIO', 'CONDORI ANGELES ALLYSON ARIANA', '74889009', 1, '19497945631078', '00219419794563107892', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 709 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 710, 'BECARIO', 'CONTRERAS ROBLES ALEX KENRJI', '75229117', 2, '283 3202175734', '00328301320217573490', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 710 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 711, 'BECARIO', 'CONTRERAS SORIA MILAGROS MAYTE', '75801950', 2, '8983324465970', '00389801332446597041', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 711 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 712, 'BECARIO', 'COTERA MUNGUIA TABHATA MAYELI', '71451007', 1, '400-15231861-0-01', '00240011523186100109', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 712 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 713, 'BECARIO', 'COTRINA CHAVEZ ARACELY', '61100404', 4, '001102810200842889', '01128100020084288934', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 713 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 714, 'BECARIO', 'CRIALES LIZANA MARUSSIA GULNARA', '61164844', 1, '220-15238399-0-22', '00222011523839902221', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 714 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 715, 'BECARIO', 'CRISTOBAL HUERTAS ISAI GERSON ALBERTH', '73254833', 1, '19215244783069', '00219211524478306934', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 715 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 831, 'BECARIO', 'CRUZ HUAITALLA CESAR MAURICIO', '71156385', 1, '191-16528068-0-16', '00219111652806801656', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 831 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 716, 'BECARIO', 'CRUZ ZURITA SANDRA', '61200795', 1, '194-15303135-0-11', '00219411530313501195', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 716 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 717, 'BECARIO', 'CUBA VENTURA MELISIO EMILIO', '60231736', 1, '22015248082003', '00222011524808200322', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 717 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 718, 'BECARIO', 'CULQUI MAS JOSE SAMUEL', '74448712', 3, '5622323086', '00901020562232308603', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 718 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 719, 'BECARIO', 'DE LA CRUZ OYOLA LEYLA KORIANKA', '60791807', 1, '22007805083022', '00222010780508302228', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 719 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 720, 'BECARIO', 'DE LA ROSA ESPINOZA GABRIEL ENRIQUE', '71996672', 1, '194-15324734-0-28', '00219411532473402890', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 720 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 721, 'BECARIO', 'DEL AGUILA PRADO ADMER ENRIQUE', '60578439', 1, '39012382506054', '00239011238250605433', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 721 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 722, 'BECARIO', 'DELGADO CAPCHA GERALDINE FIORELLA', '60581980', 1, '365-15289021-0-02', '00236511528902100252', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 722 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 723, 'BECARIO', 'DOMINGUEZ RAFAEL JHON ANTONY', '71580300', 1, '54093181254002', '00254019318125400234', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 723 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 724, 'BECARIO', 'ESCOBAR CAMPOS YOVANA', '71308567', 4, '0011-0814-0292251977', '01181400029225197718', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 724 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 725, 'BECARIO', 'ESPEJO HEREDIA SAMUEL SEBASTIÁN', '70724949', 1, '19115254451035', '00219111525445103555', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 725 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 727, 'BECARIO', 'FLORES GERDEL VALENTINA', '04080158', 1, null, '00219111438434504051', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'En «N° cuenta» venía un número con forma de tarjeta; no se guarda'
where not exists (select 1 from public.beca_cuenta where beca_id = 727 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 728, 'BECARIO', 'FLORES HOLANDA GLORIA ISABEL', '60609682', 1, '39015232746084', '00239011523274608434', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 728 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 729, 'BECARIO', 'FLORES PASAPERA ROSITA ELIZABETH', '61311393', 1, '475-15250478-0-81', '00247511525047808126', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 729 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 730, 'BECARIO', 'FUENTES PLAZA AMANDA MARISOL', '70540374', 1, '19115318042068', '00219111531804206855', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 730 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 731, 'BECARIO', 'GAGO MONTOYA CIELO DARLENE', '76782746', 2, '8983503487022', '00389801350348702244', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 731 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 835, 'BECARIO', 'GALINDO CUEVA FABRIZZIO ABDIEL', '71894275', 2, '898 3508789965', '00389801350878996548', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 835 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 834, 'BECARIO', 'GAMANIEL VILLANUEVA MELISSA ZARAY', '61072056', 4, '0011-0814-0295253326', '01181400029525332619', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 834 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 732, 'BECARIO', 'GARIBAY PERALTA DAVID NELSON', '75154600', 1, '19115283900082', '00219111528390008253', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 732 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 733, 'BECARIO', 'GONZALES GARCIA LESLY KATHERINE', '74933530', 2, '200 3273078890', '00320001327307889039', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 733 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 734, 'BECARIO', 'GRADOS HUAMANI MARIA FERNANDA', '73059835', 1, '19100159047052', '00219110015904705259', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 734 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 735, 'BECARIO', 'GRANADOS SALAS MHIA CELESTE', '72614692', 1, '192-15248100-0-20', '00219211524810002034', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 735 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 736, 'BECARIO', 'GUTIERREZ ESTEBAN ALISSON JANET', '60861499', 1, '19102933786018', '00219110293378601851', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 736 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 737, 'BECARIO', 'HUACACHI SILVA JEFERSON', '70735176', 1, '19115235549042', '00219111523554904254', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 737 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 830, 'BECARIO', 'HUAMANI HUAMANI EMILY PAZ', '60961273', 2, '898 3508690292', '00389801350869029245', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 830 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 738, 'BECARIO', 'HUANCCO TACCA RUTH CINTHYA', '60065442', 1, '405-15283237-0-01', '00240511528323700197', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 738 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 739, 'BECARIO', 'INFANTE ROMANI JHON ALEXANDER', '74435983', 4, '0011-0814-0292256006', '01181400029225600611', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 739 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 740, 'BECARIO', 'INGA APARCO FLOR MELISSA', '60082713', 1, '35015280861045', '00235011528086104573', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 740 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 741, 'BECARIO', 'INGA VÁSQUEZ KEYLA NAIARA', '60571428', 1, '575-15248242-0-23', '00257511524824202397', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 741 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 742, 'BECARIO', 'INUMA PASHANASTE ARGELIO', '61701273', 1, '39015237579065', '00239011523757906534', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 742 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 743, 'BECARIO', 'JARAMILLO RAMIREZ EDIN JUAN', '74281360', 1, '47515248234014', '00247511524823401426', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 743 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 744, 'BECARIO', 'JERI POMA KAREN SAYURI', '72539237', 4, '0011-0814-0292278433', '01181400029227843311', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 744 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 745, 'BECARIO', 'JIMENEZ MOLERO MARIAN SAMIRA', '60163180', 1, '475-15248241-0-21', '00247511524824102122', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 745 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 746, 'BECARIO', 'QUINTEROS ESPICHAN NATHALY LISSET', '43713646', 1, '194-15912150-0-77', '00219411591215007794', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 746 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 747, 'BECARIO', 'JULCA PAREDES IRIS MILENE', '72206393', 5, '04747135350', '01874700474713535069', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BN'
where not exists (select 1 from public.beca_cuenta where beca_id = 747 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 832, 'BECARIO', 'LANDA VILLANUEVA YORDI IVAN', '60659634', 4, '0011-0814-0269360548', '01181400026936054813', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 832 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 748, 'BECARIO', 'LAVADO CASTRO KIRCHNER FRANKS', '60420735', 4, '0011-0814-0292248968', '01181400029224896813', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 748 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 749, 'BECARIO', 'LUJAN DE LA CRUZ ANGELES CELESTE', '74723834', 1, '19115253497071', '00219111525349707158', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 749 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 750, 'BECARIO', 'MALCA GONZALES YANELA BELEN', '61622674', 1, '318-15255845-0-44', '00231811525584504449', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 750 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 751, 'BECARIO', 'MAMANI CALDERON JEAN FINAM NIELS', '60983099', 4, '0011-0814-0292270351-13', '01181400029227035113', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 751 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 752, 'BECARIO', 'MAMANI LOPINTA MEILY LUZ', '73303548', 1, '285-15298753-0-51', '00228511529875305154', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 752 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 753, 'BECARIO', 'MARAPARA SILVANO CIANA JAELY', '77201469', 1, '39015232880019', '00239011523288001936', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 753 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 754, 'BECARIO', 'MARCHENA CÓRDOVA JESÚS ANAYELY', '76641781', 1, '19378278052037', '00219317827805203717', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 754 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 755, 'BECARIO', 'MARQUINA MUÑOZ MIGUEL ANGEL', '77919539', 1, '22075216740005', '00222017521674000525', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 755 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 756, 'BECARIO', 'MASCO SACA NIKOL NAYELY', '60460300', 5, '04-219672875', '01871500421967287534', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 756 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 757, 'BECARIO', 'MAYHUA QUISPE FRANKS OVALDO', '70793092', 1, '19196452401066', '00219119645240106653', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 757 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 758, 'BECARIO', 'MAYHUIRE BARRIOS JHON MARCY', '60336213', 1, '200-15295308-0-87', '00220011529530808744', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 758 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 759, 'BECARIO', 'MEDINA RAMOS HASHIRA MICAELA', '74279797', 4, '0011-0960-0200259599', '01196000020025959925', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 759 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 760, 'BECARIO', 'MEDINA YUPANQUI YUDI EDITH', '60525333', 1, '220-15237697-0-13', '00222011523769701321', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 760 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 761, 'BECARIO', 'MERMAO MURAYARI MARIANA MILAGROS', '76825001', 1, '390-14221129-0-49', '00239011422112904938', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 761 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 762, 'BECARIO', 'MEZA CUADROS YAIR CARLOS', '60781291', 1, '19115229471002', '00219111522947100253', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 762 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 829, 'BECARIO', 'MOSCOSO BERROCAL KEVIN ABRAHAN', '74082201', 1, '19116468966017', '00219111646896601756', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 829 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 763, 'BECARIO', 'MURAYARI PEREZ MATIAS ALFREDO', '75172546', 1, '39015234144096', '00239011523414409632', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 763 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 764, 'BECARIO', 'NAPAN MALDONADO PEDRO MIGUEL', '70324085', 1, '191-15247729-0-45', '00219111524772904554', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 764 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 765, 'BECARIO', 'NUÑEZ BUSTAMANTE LESLIE YOSELIN', '60910012', 1, '19115252660026', '00219111525266002655', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 765 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 766, 'BECARIO', 'NUÑEZ CHOTA NERY ELIZA', '60688285', 1, '39015280276094', '00239011528027609430', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 766 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 767, 'BECARIO', 'NUÑEZ LOZANO KATERY VALERIA', '62874414', 1, '390-15288083-0-79', '00239011528808307937', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 767 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 768, 'BECARIO', 'ORE SOLIER ALEXANDER', '76666741', 1, '22015236152053', '00222011523615205327', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 768 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 769, 'BECARIO', 'ORELLANA RECUENCO EDUARD ANTONIO', '72420897', 2, '898 3503860947', '00389801350386094749', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 769 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 770, 'BECARIO', 'OSCCO MOREAU BRENDA CHRIS', '74719246', 2, '8983462106418', '00389801346210641844', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 770 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 771, 'BECARIO', 'OVIAGA TOSCANO PAOLA YNES', '75346935', 1, '192-15266107-0-09', '00219211526610700932', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 771 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 772, 'BECARIO', 'PAHUARA VASQUEZ LEHI JUAN', '76199170', 1, '191-15235660-0-54', '00219111523566005452', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 772 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 773, 'BECARIO', 'PAITAN QUISPE EMELY BETZABE', '60083153', 2, '8983503593930', '00389801350359393049', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 773 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 774, 'BECARIO', 'PALACIOS CULUPÚ SUSAN JUDITH', '60426452', 1, '47515242842068', '00247511524284206829', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 774 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 775, 'BECARIO', 'PALOMINO VELAZQUE RENEE', '75007205', 2, '8983503573387', '00389801350357338746', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 775 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 838, 'BECARIO', 'PAREDES CALLAHUANCA ANGELO JOSEPH', '61102526', 5, '04210943078', '01816000421094307827', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 838 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 776, 'BECARIO', 'PASHANASTE SHUÑA JEIMY', '61701280', 2, '8983499371910', '00389801349937191040', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 776 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 777, 'BECARIO', 'PAZO PURIZACA IRINA DEL PILAR', '71430650', 1, '475-15241838-0-54', '00247511524183805427', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 777 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 778, 'BECARIO', 'PERALTA MORALES NOEMI DINA', '75616195', 1, '22015293118095', '00222011529311809522', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 778 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 779, 'BECARIO', 'PINTADO ALBERCA DENY LUZ', '60859729', 2, '8983503681112', '00389801350368111247', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 779 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 780, 'BECARIO', 'POLO VILLARREAL CAREN NICOL', '74405410', 1, '19212691287080', '00219211269128708037', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 780 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 781, 'BECARIO', 'POMA YNOÑAN GREYZ JOSELYN', '60947263', 1, '191-15243144-0-14', '00219111524314401456', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 781 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 782, 'BECARIO', 'PONCIANO NÚÑEZ ISABEL YULIANA', '74942413', 1, '19215245310002', '00219211524531000234', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 782 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 783, 'BECARIO', 'PONTE TOSO KIARA YAMILE', '70713333', 1, '19113637023069', '00219111363702306951', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 783 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 784, 'BECARIO', 'POTOCINO VILLAVICENCIO JHON ANDERSON', '71952846', 1, '22007346792002', '00222010734679200227', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 784 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 785, 'BECARIO', 'RAFAEL RAMOS BETSI JARIKZA', '75625795', 1, '191-15231153-0-02', '00219111523115300254', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 785 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 786, 'BECARIO', 'RAMÍREZ RODRÍGUEZ JHON HEDVER', '76646338', 2, '898 3475409789', '00389801347540978944', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 786 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 787, 'BECARIO', 'RAMOS MOROCCOIRE NELLY NANCY', '74701373', 2, '8983503871949', '00389801350387194942', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 787 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 788, 'BECARIO', 'RAMOS RAMOS KAROL MELODY', '76607451', 1, '19407198972087', '00219410719897208795', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 788 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 789, 'BECARIO', 'RAYMUNDO HUATUCO REYNA YADIRA', '72237936', 1, '19199732885085', '00219119973288508550', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 789 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 790, 'BECARIO', 'ROJAS OLIVARES YAIZA', '61421164', 1, '19118739365049', '00219111873936504958', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 790 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 791, 'BECARIO', 'ROQUE PUMA EMERSON', '60370651', 1, '20015236740027', '00220011523674002740', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 791 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 792, 'BECARIO', 'RUIZ AQUINO KEVIN JOSUE', '60916055', 1, '19315287000013', '00219311528700001318', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 792 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 793, 'BECARIO', 'RUIZ MARAPARA JOE ARNULFO', '61701303', 1, '39015234184036', '00239011523418403639', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 793 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 794, 'BECARIO', 'RUIZ RAMIREZ CAMERON MICHELLE', '70711464', 1, '19110223001063', '00219111022300106352', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 794 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 795, 'BECARIO', 'SALDAÑA PEÑA OSCAR SEBASTIAN', '72932240', 4, '0011-0814-0292321509', '01181400029232150915', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 795 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 796, 'BECARIO', 'SANCHEZ NUÑEZ LIANA YOMAIRA', '61412318', 1, '39015319400013', '00239011531940001335', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 796 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 797, 'BECARIO', 'SÁNCHEZ TAYPE GLORIA MARIMAR', '73988275', 1, '20079059220078', '00220017905922007841', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 797 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 798, 'BECARIO', 'SANDOVAL LUDEÑA EVA SERAISA', '75663000', 1, '19115238384005', '00219111523838400553', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 798 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 799, 'BECARIO', 'SANTI GÓMEZ PERCY ANDRES', '76211573', 1, '191-15238491-0-13', '00219111523849101357', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 799 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 800, 'BECARIO', 'SILVA VASQUEZ RONICZON', '74280790', 1, '24515619753053', '00224511561975305397', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 800 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 801, 'BECARIO', 'SINARAHUA YEPEZ DANILO', '60012942', 4, '001103040200584344', '01130400020058434432', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 801 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 802, 'BECARIO', 'SOTO VALENZUELA LUCERO CIELO', '72086253', 1, '19190538810041', '00219119053881004153', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 802 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 803, 'BECARIO', 'TAPIA SOTELO HARUMI NAYU', '70636805', 4, '0011-0814-0273230993', '01181400027323099311', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 803 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 804, 'BECARIO', 'TAPULLIMA HUAYMANA ALEX WALDIR', '72416584', 1, '19213536476006', '00219211353647600639', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 804 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 805, 'BECARIO', 'TELLO LIMA JOSE ALEJANDRO', '72813386', 4, '0011-0814-0292316211', '01181400029231621115', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 805 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 806, 'BECARIO', 'TICLIAHUANCA SANTA CRUZ LESLY', '70704826', 4, '0011-0814-0292331644', '01181400029233164418', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 806 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 807, 'BECARIO', 'TICLLASUCA MEDINA WALTER', '71316489', 1, '22015296690002', '00222011529669000227', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 807 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 808, 'BECARIO', 'TIMANA PALACIOS ROSALINDA FHYORY', '72947025', 1, '47515237189057', '00247511523718905723', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 808 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 809, 'BECARIO', 'TINEO LOPEZ LIN KRAMER', '73393741', 2, '898 35034959', '00389801350349599845', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 809 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 810, 'BECARIO', 'TITO SEGURA ELIOT JEREMY', '76824790', 1, '19115260229072', '00219111526022907256', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BBVA» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 810 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 811, 'BECARIO', 'TOLENTINO ALTAMIRANO GUILLERMINA NELIDA', '61156805', null, '00547652902100001012', '80311500547652900157', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 811 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 812, 'BECARIO', 'TORIBIO PAMO SOFIA', '60071392', 1, '25515237832085', '00225511523783208585', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 812 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 813, 'BECARIO', 'TORRES ESTELA SELENY ODALIS', '70589027', 4, '0011-0814-0292247929', '01181400029224792916', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 813 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 814, 'BECARIO', 'VALDIVIESO COLQUE ASHLEY THAÍS', '72796173', 2, '898 3497894516', '00389801349789451647', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de Interbank'
where not exists (select 1 from public.beca_cuenta where beca_id = 814 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 815, 'BECARIO', 'VALENTE ROJAS JHON ANTONY', '60014499', 1, '20015251164097', '00220011525116409749', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 815 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 816, 'BECARIO', 'VALVERDE ZEVALLOS DANIEL REYNALDO', '61141134', 4, '0011-0814-0292286835', '01181400029228683517', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «BCP» pero el CCI es de BBVA'
where not exists (select 1 from public.beca_cuenta where beca_id = 816 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 817, 'BECARIO', 'VARGAS MANZUR MASSIEL YAMILET', '61277391', 1, '39015254327083', '00239011525432708337', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 817 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 818, 'BECARIO', 'VASQUEZ MANZUR PABLO ALBERTO', '62874412', 1, '390-15238216-0-09', '00239011523821600939', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 818 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 819, 'BECARIO', 'VÁSQUEZ PIÑA AYRTON KEVIN', '61034668', 1, '43510991881027', '00243511099188102764', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 819 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 820, 'BECARIO', 'VEGA CHIPANA SHARMELY NATIVIDAD', '75093252', 1, '20074037156086', '00220017403715608643', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 820 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 821, 'BECARIO', 'VELASQUE ROJAS ANGELA YENNIFER', '60996133', 1, '20006565032026', '00220010656503202642', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 821 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 822, 'BECARIO', 'VELASQUEZ CAYTUIRO LILI GIOVANNA', '60015809', 1, '191-15286960-0-72', '00219111528696007254', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', 'El BD dice «Interbank» pero el CCI es de BCP'
where not exists (select 1 from public.beca_cuenta where beca_id = 822 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 823, 'BECARIO', 'VITE CERVANTES ALEXANDRA ISABELLA', '61118356', 1, '335-15229616-0-67', '00233511522961606782', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 823 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 824, 'BECARIO', 'YACILA NEIRA ARELY ELIZABET', '60240122', 4, '0011-0814-0292258408', '01181400029225840817', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 824 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 825, 'BECARIO', 'YESQUEN TEMOCHE CRISTELL DEL SOCORRO', '74120382', 3, '0630554921', '00924420063055492159', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 825 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 826, 'BECARIO', 'YONG ZEA KARLA SAMIRA', '70668381', 2, '8983503594945', '00389801350359494546', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 826 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 827, 'BECARIO', 'ZAMBRANO RIVAS MARIA SALOME', '75157796', 1, '20099296347020', '00220019929634702045', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 827 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 828, 'BECARIO', 'ZAMBRANO TAPAYURI DANIEL PIRLO', '60270209', 1, '39010847147085', '00239011084714708536', true, true, 'BD becarios 2025-II (OP 205), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 828 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 1, 'BECARIO', 'AGUILAR MACEDO INES', '60114600', 1, '39007522521078', '00239010752252107831', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 1 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 2, 'BECARIO', 'ALARCÓN AYALA  ANALY LILIA', '72905485', 1, '19407523395087', '00219410752339508793', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 2 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 3, 'BECARIO', 'ALVAREZ SUSANIBAR ROBERTO', '75349934', 4, '001108140275148569', '01181400027514856915', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 3 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 4, 'BECARIO', 'ANGELES SECLEN JUANA AGRIPINA', '70558152', 1, '19107520340002', '00219110752034000254', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 4 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 5, 'BECARIO', 'ANGLAS VALQUI ROSA ELIANIE', '71429135', 1, '19107499598049', '00219110749959804951', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 5 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 6, 'BECARIO', 'AROHUANCA SANDOVAL JAZMIN LUCERO', '77128113', 1, '43007560771055', '00243010756077105576', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 6 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 7, 'BECARIO', 'AVILES CONDORI KAREN YOSSELIN', '74630396', 1, '21507550580044', '00221510755058004422', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 7 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 8, 'BECARIO', 'BARBOZA CANAQUIRI ESAU ISAAC', '60111513', 1, '39007523352017', '00239010752335201731', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 8 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 9, 'BECARIO', 'BASURTO RUIZ DORINA NAYELLY', '73857414', 1, '19107526631056', '00219110752663105655', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 9 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 10, 'BECARIO', 'BENAVIDEZ MARTEL FREDY', '76014693', 1, '56007499096087', '00256010749909608718', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 10 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 11, 'BECARIO', 'CABANA HUANCA KELLY JHASMIN', '60209492', 1, '40507097645026', '00240510709764502694', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 11 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 12, 'BECARIO', 'CAHUACHI PEÑA  LIDIA JUANITA', '76373869', 1, '39007523405071', '00239010752340507135', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 12 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 13, 'BECARIO', 'CAHUAZA ALVARADO ALVARO', '61102251', 1, '39007521575022', '00239010752157502236', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 13 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 14, 'BECARIO', 'CASAFRANCA SAYAS JUAN ROLANDO', '74234582', 1, '22007502313095', '00222010750231309529', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 14 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 15, 'BECARIO', 'COICO ISIDRO NICOLE DAIANA', '70409591', 1, '19207521144014', '00219210752114401435', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 15 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 16, 'BECARIO', 'CORZO MEZA SHERLY YAQUELIN', '74603826', 1, '19107565080093', '00219110756508009352', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 16 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 17, 'BECARIO', 'CRISTOBAL RIVERA LESLY FIDELA', '74126615', 1, '28007552195040', '00228010755219504063', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 17 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 18, 'BECARIO', 'CRUZ TRINIDAD YOSALINDA', '71399076', 1, '19107512500083', '00219110751250008357', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 18 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 19, 'BECARIO', 'DAVILA RIVERA SELENA XIOMARA', '74907353', 1, '19107541403078', '00219110754140307854', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 19 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 20, 'BECARIO', 'DE JESÚS NINAHUILLCA ANA ELENA', '72941187', 1, '19107550472038', '00219110755047203855', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 20 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 21, 'BECARIO', 'DE SOUZA RIVERA MAYRIN', '76491901', 1, '39007548581000', '00239010754858100037', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 21 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 22, 'BECARIO', 'DIESTRA LOPEZ KAROLIN BRILLY', '75175347', 1, '19107518454096', '00219110751845409652', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 22 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 23, 'BECARIO', 'ENCINAS PEZO  ASTRID', '60854492', 1, '39007505283065', '00239010750528306531', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 23 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 24, 'BECARIO', 'ESCOBAR RODAS MADELY MERISEL', '70775187', 1, '19107547523059', '00219110754752305956', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 24 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 25, 'BECARIO', 'ESTELA DÁVILA MILTON HAROL', '74403195', 1, '24507528904079', '00224510752890407993', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 25 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 26, 'BECARIO', 'FABIAN CARLIN JULLIANA LUCIA', '76625783', 1, '47507520622046', '00247510752062204620', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 26 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 27, 'BECARIO', 'FLORES CONDEÑA MILAGROS ANTONELLA', '76731403', 1, '19107522820007', '00219110752282000758', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 27 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 28, 'BECARIO', 'FLORES JIMENEZ ROSA JHAQUELINE', '62566707', 1, '39007499648073', '00239010749964807331', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 28 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 29, 'BECARIO', 'GARCÍA HUAMANTUCO  LISETH MIRIAM', '76283132', 1, '19107499395044', '00219110749939504457', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 29 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 30, 'BECARIO', 'GARCIA QUISPE  ANDREA BENEDICTA', '74774163', 1, '19107498704047', '00219110749870404758', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 30 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 31, 'BECARIO', 'GARRIDO PINILLOS FRANK DAVID', '74746696', 1, '47507521152081', '00247510752115208123', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 31 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 32, 'BECARIO', 'GUERRA GARCIA JEMIMÁ MADELEYNE', '75595805', 1, '19107534889097', '00219110753488909752', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 32 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 33, 'BECARIO', 'HUACACHINO SANTOS JEAN PIERRE', '73664278', 1, '36507499740041', '00236510749974004155', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 33 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 34, 'BECARIO', 'HUAYANA APARCO ASTRID AKEMI', '70645802', 1, '19107525641056', '00219110752564105655', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 34 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 35, 'BECARIO', 'HURTADO HORTA MARLON FRANCISCO', '71016655', 1, '19107521054023', '00219110752105402354', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 35 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 36, 'BECARIO', 'ILLESCA MARQUEZ RAFAEL GONZALO', '72872221', 1, '19107521107077', '00219110752110707757', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 36 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 37, 'BECARIO', 'IPUSHIMA LOPEZ KEBERSON WENCESLAO', '60548479', 1, '39007528378093', '00239010752837809331', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 37 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 38, 'BECARIO', 'JUAREZ ARELLANO NALLELY GIULIANNA', '70824019', 1, '19207520403066', '00219210752040306633', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 38 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 39, 'BECARIO', 'KURIC AMASIFUEN  ANGIE MILAGROS', '77136897', 1, '39007555457046', '00239010755545704636', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 39 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 40, 'BECARIO', 'LLICÁN YOUNG JENNIFER ALEXANDRA', '61242496', 1, '45014053755045', '00245011405375504554', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 40 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 41, 'BECARIO', 'LOAYZA GUTIERREZ JOSE NOLBERTO', '60489032', 1, '47009492393028', '00247010949239302835', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 41 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 42, 'BECARIO', 'LUZA ESQUIVEL DANIELA ALEJANDRA', '72954805', 1, '19107521264035', '00219110752126403554', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 42 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 43, 'BECARIO', 'MANAYAY ROJAS MARIJULIA FERNANDA', '60812750', 1, '19107554832042', '00219110755483204254', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 43 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 44, 'BECARIO', 'MANIHUARI PACAYA  BILLY ARON', '62116647', 1, '390-16384456-0-27', '00239011638445602731', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 44 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 45, 'BECARIO', 'MARAPARA SILVANO JAGDER WILLY', '77201470', 1, '39007521553000', '00239010752155300038', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 45 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 46, 'BECARIO', 'MARIN MACHACUAY KIMBERLY MAITE', '72355545', 1, '19107500542004', '00219419745067602493', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 46 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 47, 'BECARIO', 'MENDOZA TIMANA YOMARA ELIZABETH', '60907306', 1, '47507503868022', '00247510750386802220', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 47 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 48, 'BECARIO', 'MEZA TAQUIRE DENISE KATIUSKA', '62260904', 1, '22007501403076', '00222010750140307622', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 48 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 49, 'BECARIO', 'MORE CALLE  VALERYT ELIZABET', '70942873', 1, '47507517115003', '00247510751711500321', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 49 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 50, 'BECARIO', 'MORE INGA LETICIA ABIGAIL', '71963603', 1, '47507525290060', '00247510752529006021', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 50 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 51, 'BECARIO', 'OCHOA ROJAS FRANK ALEX', '63365373', 1, '23214562550059', '00223211456255005972', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 51 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 52, 'BECARIO', 'ORTIZ APAZA JUVENAL JUSEF', '60180572', 1, '21507520195052', '00221510752019505225', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 52 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 53, 'BECARIO', 'OSEDA ESTRADA ABIEL CALEB', '78308465', 1, '19107553763062', '00219110755376306257', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 53 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 54, 'BECARIO', 'PADILLA CHAUPIJULCA MILUSKA', '73930503', 1, '19107526550074', '00219110752655007455', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 54 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 55, 'BECARIO', 'PEÑA CALLE YANELI', '60160326', 1, '39505779365018', '00239510577936501824', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 55 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 56, 'BECARIO', 'PEREIRA CANAQUIRI  MARILY', '76947785', 1, '39007518142054', '00239010751814205439', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 56 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 57, 'BECARIO', 'PEREZ HERMOZA JENNYFER VIVIAN', '75624087', 1, '19107520834001', '00219110752083400159', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 57 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 58, 'BECARIO', 'PILCO VARGAS  HAROLD RUBEN', '74641375', 1, '19107520073032', '00219110752007303254', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 58 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 59, 'BECARIO', 'QUILLA HUILLCA LUZ GEORGETTE', '75800336', 1, '19107565218033', '00219110756521803353', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 59 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 60, 'BECARIO', 'QUIROZ LOZADA KLEVER DOMINIC', '73267916', 1, '57007520225041', '00257010752022504102', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 60 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 61, 'BECARIO', 'QUISPE CCALA OSCAR ALAN', '74434207', 1, '49507526772077', '00249510752677207700', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 61 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 62, 'BECARIO', 'QUISPE PUMA ANABEL', '74762486', 1, '40507555857066', '00240510755585706690', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 62 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 63, 'BECARIO', 'REYES RUEDA FATIMA LUCERO', '60028218', 1, null, '00219110780075705153', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', 'En «N° cuenta» venía un número con forma de tarjeta; no se guarda'
where not exists (select 1 from public.beca_cuenta where beca_id = 63 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 64, 'BECARIO', 'RIVAS LUCANAS JUAN CARLOS', '77574963', 1, '19107520271032', '00219110752027103254', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 64 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 65, 'BECARIO', 'ROMAÑOL DAHUA KENLLI', '60671437', 1, '39007522972033', '00239010752297203330', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 65 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 66, 'BECARIO', 'RUIZ MIÑANO ERIKA DANIELA', '60799413', 1, '57007499630037', '00257010749963003706', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 66 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 67, 'BECARIO', 'RUIZ SOTO CARLOS DANIEL', '61183053', 1, '53515300459028', '00253511530045902833', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 67 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 68, 'BECARIO', 'SACACA GUZMAN CELIA MARTHA', '74704594', 1, '49507531099048', '00249510753109904807', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 68 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 69, 'BECARIO', 'SALDAÑA APAGUEÑO ESTHER VALENTINA', '61229190', 1, '39014956902053', '00239011495690205334', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 69 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 70, 'AVAL', 'PUSCAN CIAS ELVA', '44667260', 1, '39007947251097', '00239010794725109736', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', 'Titular: Aval/Madre'
where not exists (select 1 from public.beca_cuenta where beca_id = 70 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 71, 'BECARIO', 'SARMIENTO TELLO  DIEGO REY', '60542497', 1, '39015074846089', '00239011507484608938', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 71 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 72, 'BECARIO', 'SULCA QUISPE SHIRLEY MARINELA', '74216945', 1, '22007554403011', '00222010755440301128', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 72 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 73, 'BECARIO', 'TORRES PEREZ JHEFERSON', '60452178', 1, '39007528603021', '00239010752860302139', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 73 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 74, 'BECARIO', 'TRINIDAD SOLORZANO  ELIZABETH', '71340685', 1, '19407552721010', '00219410755272101099', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 74 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 75, 'BECARIO', 'VILLAFANA PALOMINO JHADET SAMIRA', '73045761', 1, '19107523764060', '00219110752376406053', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 75 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 76, 'BECARIO', 'VILLARREAL CORDOVA ELIZABETH SARAI', '76161436', 1, '19107574233039', '00219110757423303953', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 76 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 77, 'BECARIO', 'VILLARREAL CÓRDOVA REBECA SARAÍ', '76161437', 1, '19107529865022', '00219110752986502258', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 77 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 78, 'BECARIO', 'VILLOGAS GAMARRA YUDITH LAURA', '71707854', 1, '19107545789007', '00219110754578900758', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 78 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 79, 'BECARIO', 'YUCRA MENDOZA MARIA VANESA', '73492242', 1, '40507554239032', '00240510755423903294', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 79 and vigente);
insert into public.beca_cuenta (beca_id, titular_tipo, titular_nombre, titular_dni, banco_id, numero_cuenta, cci, cci_valido, vigente, fuente, observacion)
select 80, 'BECARIO', 'ZELADA CHOTA PAOLO MIGUEL', '70721705', 1, '19114687523080', '00219111468752308057', true, true, 'BD becarios 2025-I (OP 206), correo Servicios 28/09/2026', null
where not exists (select 1 from public.beca_cuenta where beca_id = 80 and vigente);
