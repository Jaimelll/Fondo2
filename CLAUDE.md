# Fondo2 — Sistema Activa-T (FONDOEMPLEO) sin Supabase

Fork de sistema-activa-t que reemplaza Supabase por infraestructura propia.
Aplicación interna de FONDOEMPLEO para gestión y monitoreo de proyectos
de inserción laboral, mejora de empleabilidad y aumento de ingresos.

## Stack

- **Next.js 16** (App Router, Server Components, Server Actions)
- **React 19**
- **Postgres 17** autogestionado (docker-compose, cliente `pg`)
- **Better-Auth** (email+password, cookie httpOnly, bcrypt, sin registro público)
- **Storage local** de PDFs (`STORAGE_DOCUMENTS_PATH`)
- **Tailwind CSS 3**, **Recharts**, **Leaflet**, **TypeScript 5**

## Cómo correrlo (SIEMPRE en Docker — no instalar nada en el host)

```bash
cp .env.example .env       # completar BETTER_AUTH_SECRET
docker compose up -d --build   # db (host 5434) + app dev (http://localhost:8082)

# schema + auth (solo la primera vez)
docker compose exec -T db psql -U fondo2 -d fondo2 < scripts/schema.sql
docker compose exec -T db psql -U fondo2 -d fondo2 < scripts/auth_schema.sql

# crear usuarios (no hay registro público)
docker compose exec app node scripts/create-user.mjs <email> <password> [nombre]
```

Todo comando (npm, tsc, scripts) corre con `docker compose exec app ...`.
Tras editar server actions, `docker compose restart app` (el hot-reload no
siempre recoge cambios en actions.ts).

El Dockerfile de producción (deps/builder/runner, `output: 'standalone'`)
debe compilar limpio: `docker build .`

## Estructura

```
src/
  app/
    auth/                       # login, signout (Better-Auth)
    api/auth/[...all]/          # handler de Better-Auth
    api/documentos/[archivo]/   # sirve PDFs del storage local (con sesión)
    dashboard/                  # módulo principal protegido por src/proxy.ts
      page.tsx                  # Proyectos: KPIs + mapa + gráficos
      actions.ts                # server actions de proyectos (dashboard + gestión)
      servicios/                # módulo Servicios
      gestion-proyectos/        # bandeja administrativa de proyectos
      gestion-servicios/        # bandeja administrativa de servicios
      gestion-aportantes/       # gestión de aportantes corporativos
      inf-gerencial/            # informe gerencial
      catalogos/                # tablas de referencia (solo super admin)
      (corporativo)/documentos/ # documentos corporativos (PDFs en disco)
    presentation/               # vista pública de presentación
  components/                   # componentes compartidos (charts, modals, tablas)
  config/permissions.ts         # mapa módulo→ruta + helpers puros
  lib/
    db.ts                       # pool pg + query() + withAuditUser()
    auth.ts                     # instancia Better-Auth
    session.ts                  # getSession()/getUserEmail() (server)
    permisos.ts                 # módulos por usuario desde usuarios_modulos
  proxy.ts                      # gate de auth y permisos (middleware Next 16)
scripts/
  schema.sql                    # schema de datos (aplicar primero)
  auth_schema.sql               # tablas Better-Auth + usuarios_modulos + seed
  create-user.mjs               # alta/reset de usuarios
```

## Autorización

- Login email+password (Better-Auth). Usuarios se crean con `create-user.mjs`;
  sus módulos se asignan en la tabla `usuarios_modulos` (`modulo='ALL'` = todo).
- `src/proxy.ts` valida sesión y permisos por módulo contra Postgres en cada
  request; `/dashboard` exacto es libre para autenticados, el resto por módulo.
- Super admin: `jduran@fondoempleo.com.pe` (constante en permissions.ts; único
  con acceso a Catálogos).
- Auditoría: `withAuditUser()` (lib/db.ts) setea `app.current_user_id` por
  transacción; el trigger de `metricas` escribe en `logs_actualizacion`.
  (`log_proyecto_changes` existe pero no está adjunta a ninguna tabla — herencia
  del Supabase original.)

## Convenciones

- Server Actions con `"use server"` viven en `actions.ts` de cada módulo; el
  cliente de datos es `query()`/`withAuditUser()` de `src/lib/db.ts` (nunca pg
  directo en componentes).
- Los "embeds" que antes hacía PostgREST se replican con LEFT JOIN +
  `json_build_object`/`json_agg` lateral, conservando las formas anidadas.
- `numeric`/`bigint` se parsean a número global en db.ts (paridad con
  PostgREST); las fechas que las vistas esperan como string van con `::text`.
- Tablas en snake_case y español; columnas en español (incluyendo `año` con ñ).
- `proyectos.id` es **integer**; `metricas.id`, `aportes.id` y
  `documentos_gerenciales.id` son uuid.
- `dynamic = 'force-dynamic'` en páginas que dependen de filtros frescos.

## Pagos trazables (proyectos y becas/servicios)

Porteado del original el 2026-09-06 (commit 7f22fc6 de sistema-activa-t).

Los pagos se registran en la bitácora (`avance_proyecto` / `avance_beca`) como
eventos con su monto **parcial**; `proyectos.avance` y `becas_nueva.avance` son
campos **derivados** (suma de la bitácora con fecha <= hoy, ver
`recalculateProyectoAvance` / `recalculateBecaAvance`). Los formularios no
permiten editarlos y los server actions descartan `avance` del payload.

Convenciones (helpers en `src/lib/pagos.ts`, sin columnas nuevas):

- **Orden de pago al inicio del sustento**: `OP 138-UPS-AS - S/ 903.40`. Es la
  clave de trazabilidad y lo que evita registrar dos veces la misma OP.
- **Arrastre**: evento con sustento que empieza con `Arrastre:`. Concentra el
  acumulado pagado antes de la trazabilidad. Los datos llegan ya migrados desde
  el dump de Supabase (el script `migra_pagos_arrastre.cjs` corre en el original).
- **Desglosar el arrastre**: al registrar una OP ya incluida en el acumulado,
  marcar `descontarDeArrastre` (casilla en el modal); el arrastre baja en el
  mismo monto (`src/lib/arrastre-server.ts`) y el avance total no cambia.
- El sustento narrativo de `proyectos.sustento` lo define el último evento que
  **no** sea un pago ni arrastre.

## Órdenes de pago de becas

Desde el 2026-09-29 (encargo «tablas de becas para el skill pago-becas»). Las OP de
becas son registros propios; `avance_beca` sigue siendo la bitácora de la que sale el
avance, y cada línea pagada queda enlazada a su evento.

### Modelo de datos (`scripts/migration_becas_pagos.sql`)

- **Catálogos**: `bancos` (por los 3 primeros dígitos del CCI), `concepto_beca`
  (código canónico + `codigos_anexo`, los alias `OTR-000x-…` que cambian por
  convocatoria) y columnas de pago en `institucion` (RUC, convenio, banco, cuenta, CCI).
  La cuenta contable 4699xxxx NO va en `institucion`: cambia por convocatoria y va en
  la línea de la OP.
- **Gestión de Servicios**: `becas_nueva.codigo_convenio` / `codigo_interno`;
  `beca_cuenta` (una vigente por beca + historial, `cci_valido`); `beca_presupuesto`
  (programado por beca y concepto); `beca_orden_pago` (cabecera) y
  `beca_orden_pago_detalle` (una línea por fila del Anexo 02, `avance_beca_id` único).
- `v_beca_saldo`: programado − Σ líneas PAGADA. El ejecutado y el saldo no se guardan.
- Un comprobante no se reembolsa dos veces (índice `beca_opd_comprobante_uq`).

### Estados

- OP: `GENERADA → ENVIADA → EN_TESORERIA → PENDIENTE_FIRMA → PAGADA`, más `OBSERVADA`
  y `ANULADA`. PAGADA solo con «Registrar pago ejecutado»; ANULADA solo si no hay
  líneas pagadas.
- Línea: `PENDIENTE → PAGADA | RECHAZADA | ANULADA`. Una rechazada se vuelve a pagar
  en otra OP.

### Flujo con pago-becas y pagos-eli

1. Servicios manda el BD de becarios y el Anexo 02 → `SistemaPagos\06_Datos\Becas\`.
2. Maestros (una vez por convocatoria): cuentas, presupuesto y códigos con los
   generadores de `scripts/oneoff/` → `scripts/data_becas_*.sql` + CSV de discrepancias
   en `respaldos_locales/` (nunca se corrige en silencio).
3. pago-becas valida el Anexo, emite Informe Previo / Informe de Pago / OP y registra
   la OP (pantalla «Importar Anexo 02» o script). Queda EN_TESORERIA con líneas PENDIENTE.
4. pagos-eli arma el TXT del BBVA desde las líneas; la OP guarda `dia_pago`/`txt_archivo`.
5. Ejecutado el pago: «Registrar pago ejecutado» (fecha de ejecución + N° de orden del
   banco) → líneas PAGADA, un evento en `avance_beca` por línea con sustento
   `OP 205-UPS-AS - S/ 822.26` y recálculo de avance/etapa (`recalcularEtapasBecas`).
   Es idempotente: si la beca ya tiene un evento de esa OP con ese monto, lo enlaza.

### Pantallas

- `/dashboard/gestion-servicios/ordenes-pago` (lista, filtros, Excel), `/[id]` (detalle,
  cuadre, acciones) e `/importar` (Anexo 02 con vista previa). Las acciones viven en
  `gestion-servicios/actions.ts`, validan el módulo Gestión de Servicios y escriben con
  `withAuditUser`.
- Modal del becario: pestaña «Cuenta y Presupuesto» (solo en Gestión de Servicios, no
  en modo lectura) y chip «OP n · CONCEPTO» en los eventos enlazados.
- Catálogos: «Bancos» y «Conceptos de beca». Los `text[]` se editan como texto separado
  por comas.

### Reglas de validación (`src/lib/becas-validacion.ts`, `src/lib/anexo02.ts`)

- CCI de 20 dígitos; el dígito 19 controla las posiciones 1-6 y el 20 las 7-18 (pesos
  1,2,1,2…, se suman los dígitos de productos ≥ 10, DC = (10 − suma mod 10) mod 10).
  El banco sale del CCI: si el Anexo dice otro banco, manda el CCI.
- Abono a IE → RUC (tipo R) con la cuenta de la IE; reembolso o no académico → DNI (tipo L)
  del titular. Nombre en mayúsculas, sin comas (el BBVA rechazó la OP 196 por una coma).
- Anexo 02: solo filas VISIBLES; se ignoran hojas ocultas y copias de la muestra (columna
  ALEATORIO); encabezados por nombre; una fila sin cuenta hereda la de la anterior.
- Monto ≤ saldo del concepto (alerta), beca Activa, Σ líneas = importe de la OP.
- Trampas vistas: Anexos con el DNI del AVAL en vez del becario (OP 206 Llicán, OP 209
  Loayza); número de tarjeta en «cuenta bancaria»; glosas con el periodo equivocado.

### Carga inicial (2026-09-29, Supéra-T 2025 I y II)

- Presupuesto 2025-II: conceptos del PPTO programado + ACADÉMICOS del bloque «REG. ADM.»
  (así Σ = `becas_nueva.presupuesto`). 2025-I: solo ACADÉMICOS (el BD no desglosa los no
  académicos). Faltan los BD de Supéra-T 2026, Beca Trabajadores y MiBeca.
- Histórico: 78 OP / 1,360 líneas reconstruidas desde `avance_beca` sin crear eventos;
  328 líneas con concepto por defecto (anotado en `observacion`).
- Verificación: `scripts/verifica_becas_pagos.sql` (correr en local y en el servidor).

### OJO al refrescar datos

`bajar-fondo2.sh` y `actualizar_bd_servidor.sh` hacen `TRUNCATE … CASCADE` de
`becas_nueva`/`avance_beca`: arrastran a las tablas `beca_*` que las referencian. Si el
dump de origen no trae esas tablas (p. ej. un servidor sin la migración), hay que volver
a aplicar los `scripts/data_becas_*.sql` después.

## Sincronizar con el original (sistema-activa-t)

- El original está como remote `activa` en este repo (`git fetch activa main`).
  El último commit porteado se anota en el mensaje del commit de porteo.
- Componentes cliente y `src/config/*`, `src/lib/pagos.ts` se copian tal cual.
  Los `actions.ts` se mergean a 3 vías (`git merge-file`) y se traduce
  supabase-js a `query()` de `src/lib/db.ts`.
- Módulos que NO se portan (se desactivan): monitores, evaluación,
  supervisión/campo y sus tablas (`monitores`, `plan_supervision`,
  `supervisiones_registro`, `evaluacion_config`, `evaluaciones_resultados`).
- Cambios de esquema del original van a `scripts/schema.sql` y a un
  `scripts/migration_*.sql` idempotente que `actualizar_bd_servidor.sh` aplica
  antes de restaurar el dump (paso 2b).

## Deuda técnica conocida

- [ ] Registros antiguos de documentos apuntan al Storage de Supabase remoto;
      migrar esos PDFs al storage local.
- [ ] Al registrar el primer avance de un proyecto cuyo `avance` se cargó
      manualmente (sin historial), el recálculo pisa el acumulado con la suma
      del historial (comportamiento heredado del original).
- [ ] Raíz del repo con ~100 scripts one-off (import/check/verify) — mover a
      `scripts/oneoff/` o ignorar.
- [ ] ~200 usos de `any` en `src/`.
- [x] Catálogos cacheados 1h vía `unstable_cache`; el módulo Catálogos invalida
      el tag `catalogos` en cada escritura (`invalidarCatalogos`).
- [ ] Hydration mismatch en `GestionServiciosTable` (formato de fechas/números en
      las filas; visto el 2026-09-29, previo a las órdenes de pago).
- [ ] `recalculateBecaAvance` suma en JS con floats: `becas_nueva.avance` puede quedar
      como 11726.619999999999. Redondear a 2 decimales.
- [ ] La importación del Anexo 02 no empareja por nombre cuando el Anexo trae el DNI
      del aval (queda como error y hay que corregir el Anexo).
- [ ] Sin tests ni CI.
- [ ] Sin sistema de migraciones (schema.sql + auth_schema.sql aplicados a mano).
