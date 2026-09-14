-- Corrige el CIIU de empresas aportantes y normaliza el catálogo sectores_ciiu.
--
-- El grupo de cada aportante ("Minería y petróleo", "Energía", "Industria",
-- "Comercial", "Transporte y almacenamiento", "Otros") se calcula a partir del
-- CIIU de la empresa (src/config/sectoresAgrupados.ts). Varias empresas tenían
-- un CIIU que no corresponde a su actividad: se contrastaron con la actividad
-- registrada en SUNAT y con información pública de cada empresa (11/09/2026).
--
-- Idempotente: se puede correr las veces que sea. actualizar_bd_servidor.sh lo
-- reaplica después de cada carga desde Supabase, porque esa carga reemplaza
-- empresas y sectores_ciiu completos.
--
--   docker compose exec -T db psql -U fondo2 -d fondo2 -v ON_ERROR_STOP=1 < scripts/corrige_ciiu_aportantes.sql

begin;

-- ── 1. Catálogo ─────────────────────────────────────────────────────────────

-- 4630 venía con un espacio al final del código.
update sectores_ciiu set ciiu_codigo = trim(ciiu_codigo)
 where ciiu_codigo <> trim(ciiu_codigo)
   and not exists (select 1 from sectores_ciiu s2 where s2.ciiu_codigo = trim(sectores_ciiu.ciiu_codigo));

-- Nombres de sección: una sola redacción por sección CIIU, para que la columna
-- "Sector" y su filtro no muestren la misma sección escrita de cinco formas.
update sectores_ciiu s set seccion_desc = v.seccion
  from (values
    ('0210', 'Agricultura, ganadería, silvicultura y pesca'),
    ('1622', 'Industria manufacturera'),
    ('4210', 'Construcción'),
    -- 4630 es venta al por mayor de alimentos, no la industria de alimentos.
    ('4630', 'Comercio al por mayor y al por menor; reparación de vehículos automotores y motocicletas'),
    ('4773', 'Comercio al por mayor y al por menor; reparación de vehículos automotores y motocicletas'),
    ('6120', 'Información y comunicaciones'),
    ('6511', 'Actividades financieras y de seguros'),
    -- 7020 es consultoría de gestión (sección M), no manufactura.
    ('7020', 'Actividades profesionales, científicas y técnicas'),
    ('9329', 'Actividades artísticas, de entretenimiento y recreativas')
  ) as v(codigo, seccion)
 where s.ciiu_codigo = v.codigo
   and s.seccion_desc is distinct from v.seccion;

-- 1073 no estaba en el catálogo (Confiperu elabora chocolates y confites).
insert into sectores_ciiu (id, ciiu_codigo, seccion_desc, division_desc, grupo_desc, clase_desc)
select (select coalesce(max(id), 0) + 1 from sectores_ciiu), '1073',
       'Industria manufacturera',
       'Elaboración de productos alimenticios',
       'Elaboración de otros productos alimenticios',
       'Elaboración de cacao, chocolate y de productos de confitería'
 where not exists (select 1 from sectores_ciiu where ciiu_codigo = '1073');

select setval(pg_get_serial_sequence('sectores_ciiu', 'id'), (select max(id) from sectores_ciiu));

-- ── 2. CIIU de cada empresa ─────────────────────────────────────────────────

update empresas e set ciiu_id = s.id
  from (values
    -- Opera la mina de oro El Toro (Huamachuco). En SUNAT figura como comercio
    -- de metales (4662) con la 0729 de secundaria, por eso caía en Comercial.
    ('20522025071', '0729'),  -- SUMMA GOLD CORPORATION S.A.C.
    -- Mineras de oro y estaño registradas como generación eléctrica (3510).
    ('20209133394', '0729'),  -- MINERA BOROO MISQUICHILCA S.A.
    ('20100136741', '0729'),  -- MINSUR S.A.
    -- SUNAT: actividades de apoyo a la explotación de minas (0990).
    ('20608604261', '0990'),  -- SERVICIOS GENERALES E INVERSIONES QORIANKA S.A.C.
    -- Generadora hidroeléctrica (Cañón del Pato) registrada como forja de metales.
    ('20338646802', '3510'),  -- DUKE ENERGY EGENOR S. EN C. POR A.
    -- Distribuidora de acero y materiales de construcción, no fábrica de cemento.
    ('20100020361', '4663'),  -- COMERCIAL DEL ACERO S.A.
    -- Constructora (CyM), no comercio de metales.
    ('20330546612', '4100'),  -- CONSTRUCTORES Y MINEROS CONTRATISTAS GENERALES S.A.C.
    -- Confecciones, no forja de metales.
    ('20101022944', '1410'),  -- CONSTRUCCIONES E INVERSIONES ALPAMA S.A.
    -- Chocolates y confites, no consultoría de gestión.
    ('20258908849', '1073')   -- CONFIPERU S.A.
  ) as v(ruc, codigo)
  join sectores_ciiu s on s.ciiu_codigo = v.codigo
 where e.ruc = v.ruc
   and e.ciiu_id is distinct from s.id;

commit;

-- Verificación: las empresas corregidas con su CIIU y sección actuales.
select e.ruc, left(e.razon_social, 45) as razon_social, s.ciiu_codigo, left(s.seccion_desc, 45) as seccion
  from empresas e
  left join sectores_ciiu s on s.id = e.ciiu_id
 where e.ruc in ('20522025071', '20209133394', '20100136741', '20608604261', '20338646802',
                 '20100020361', '20330546612', '20101022944', '20258908849')
 order by s.ciiu_codigo;
