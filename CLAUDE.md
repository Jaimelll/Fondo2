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
