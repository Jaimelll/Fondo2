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
- [ ] Catálogos cacheados 1h vía `unstable_cache`; falta invalidación desde
      el módulo Catálogos.
- [ ] Sin tests ni CI.
- [ ] Sin sistema de migraciones (schema.sql + auth_schema.sql aplicados a mano).
