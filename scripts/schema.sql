--
-- PostgreSQL database dump
--

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: log_metricas_changes(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.log_metricas_changes() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
declare
    v_old_data jsonb;
    v_new_data jsonb;
    v_key text;
    v_old_value text;
    v_new_value text;
begin
    if (TG_OP = 'UPDATE') then
        v_old_data := to_jsonb(OLD);
        v_new_data := to_jsonb(NEW);
        
        for v_key in select jsonb_object_keys(v_new_data)
        loop
            v_old_value := v_old_data->>v_key;
            v_new_value := v_new_data->>v_key;
            
            if (v_key not in ('updated_at', 'created_at', 'monto_total')) and (v_old_value is distinct from v_new_value) then
                insert into public.logs_actualizacion (usuario_id, proyecto_id, campo_modificado, valor_anterior, valor_nuevo)
                values (NULLIF(current_setting('app.current_user_id', true), '')::uuid, NEW.proyecto_id, 'METRICA: ' || v_key, v_old_value, v_new_value);
            end if;
        end loop;
    end if;
    return NEW;
end;
$$;

--
-- Name: log_proyecto_changes(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.log_proyecto_changes() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
declare
    v_old_data jsonb;
    v_new_data jsonb;
    v_key text;
    v_old_value text;
    v_new_value text;
begin
    if (TG_OP = 'UPDATE') then
        v_old_data := to_jsonb(OLD);
        v_new_data := to_jsonb(NEW);
        
        for v_key in select jsonb_object_keys(v_new_data)
        loop
            v_old_value := v_old_data->>v_key;
            v_new_value := v_new_data->>v_key;
            
            if (v_key not in ('updated_at', 'created_at')) and (v_old_value is distinct from v_new_value) then
                insert into public.logs_actualizacion (usuario_id, proyecto_id, campo_modificado, valor_anterior, valor_nuevo)
                values (NULLIF(current_setting('app.current_user_id', true), '')::uuid, NEW.id, v_key, v_old_value, v_new_value);
            end if;
        end loop;
    end if;
    return NEW;
end;
$$;

--
-- Name: recalculate_finanzas_aportes(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.recalculate_finanzas_aportes() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    target_year INTEGER;
    total_monto NUMERIC;
BEGIN
    -- 1. Determinar el año afectado
    IF (TG_OP = 'DELETE') THEN
        target_year := OLD.anio;
    ELSE
        target_year := NEW.anio;
    END IF;

    -- 2. Calcular la suma total de aportes para ese año
    SELECT COALESCE(SUM(monto), 0) INTO total_monto
    FROM public.aportes
    WHERE anio = target_year;

    -- 3. Actualizar o Insertar en finanzas_anual (SOLO escenario = 'Real')
    IF EXISTS (SELECT 1 FROM public.finanzas_anual WHERE año = target_year AND rubro = 'Aportes' AND escenario = 'Real') THEN
        UPDATE public.finanzas_anual
        SET monto = total_monto
        WHERE año = target_year AND rubro = 'Aportes' AND escenario = 'Real';
    ELSE
        INSERT INTO public.finanzas_anual (año, rubro, monto, escenario)
        VALUES (target_year, 'Aportes', total_monto, 'Real');
    END IF;

    -- 4. Si el año cambió en un UPDATE, recalcular también el año antiguo
    IF (TG_OP = 'UPDATE' AND OLD.anio <> NEW.anio) THEN
        SELECT COALESCE(SUM(monto), 0) INTO total_monto
        FROM public.aportes
        WHERE anio = OLD.anio;

        IF EXISTS (SELECT 1 FROM public.finanzas_anual WHERE año = OLD.anio AND rubro = 'Aportes' AND escenario = 'Real') THEN
            UPDATE public.finanzas_anual
            SET monto = total_monto
            WHERE año = OLD.anio AND rubro = 'Aportes' AND escenario = 'Real';
        ELSE
            INSERT INTO public.finanzas_anual (año, rubro, monto, escenario)
            VALUES (OLD.anio, 'Aportes', total_monto, 'Real');
        END IF;
    END IF;

    RETURN NULL;
END;
$$;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aportantes_anual; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aportantes_anual (
    id integer NOT NULL,
    "año" integer NOT NULL,
    empresa text NOT NULL,
    monto numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: aportantes_anual_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aportantes_anual_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: aportantes_anual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.aportantes_anual_id_seq OWNED BY public.aportantes_anual.id;

--
-- Name: aportes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aportes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    empresa_ruc text,
    anio integer NOT NULL,
    monto numeric(15,2),
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: avance_beca; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avance_beca (
    id bigint NOT NULL,
    beca_id integer NOT NULL,
    etapa_id integer NOT NULL,
    fecha date DEFAULT CURRENT_DATE NOT NULL,
    sustento text DEFAULT 'Cargado desde Sistema FONDOEMPLEO'::text,
    created_at timestamp with time zone DEFAULT now(),
    monto numeric DEFAULT 0 NOT NULL
);

--
-- Name: TABLE avance_beca; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.avance_beca IS 'Historial de avances y cambios de etapa para los beneficiarios de becas.';

--
-- Name: avance_beca_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.avance_beca ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.avance_beca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

--
-- Name: avance_proyecto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avance_proyecto (
    id bigint NOT NULL,
    proyecto_id integer NOT NULL,
    etapa_id integer NOT NULL,
    fecha date NOT NULL,
    sustento text DEFAULT 'Cargado desde Base7'::text,
    created_at timestamp with time zone DEFAULT now(),
    monto numeric DEFAULT 0
);

--
-- Name: avance_proyecto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.avance_proyecto ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.avance_proyecto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

--
-- Name: avances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avances (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    proyecto_id integer,
    fecha date,
    porcentaje numeric,
    descripcion text,
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: becas_nueva; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.becas_nueva (
    id integer NOT NULL,
    periodo integer,
    eje_id integer,
    linea_id integer,
    nombre text,
    documento text,
    institucion_id integer,
    modalidad_id integer,
    region_id integer,
    beneficiarios integer DEFAULT 1,
    presupuesto numeric DEFAULT 0,
    avance numeric DEFAULT 0,
    etapa_id integer,
    provincia_procedencia text,
    distrito_procedencia text,
    edad integer,
    tipo_estudio_id integer,
    naturaleza_ie_id integer,
    especialidad text,
    formato_id integer,
    condicion_id integer,
    duracion_meses integer,
    created_at timestamp with time zone DEFAULT now(),
    grupo_id integer,
    fecha_nacimiento date,
    celular text,
    correo_electronico text,
    empresa_id bigint,
    sexo text,
    CONSTRAINT becas_nueva_sexo_check CHECK ((sexo = ANY (ARRAY['Masculino'::text, 'Femenino'::text])))
);

--
-- Name: COLUMN becas_nueva.provincia_procedencia; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.provincia_procedencia IS 'Provincia de procedencia del postulante';

--
-- Name: COLUMN becas_nueva.distrito_procedencia; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.distrito_procedencia IS 'Distrito de procedencia del postulante';

--
-- Name: COLUMN becas_nueva.tipo_estudio_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.tipo_estudio_id IS 'FK a tabla tipo_estudio';

--
-- Name: COLUMN becas_nueva.naturaleza_ie_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.naturaleza_ie_id IS 'FK a tabla naturaleza_ie';

--
-- Name: COLUMN becas_nueva.especialidad; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.especialidad IS 'Especialidad del postulante';

--
-- Name: COLUMN becas_nueva.formato_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.formato_id IS 'FK a tabla formato';

--
-- Name: COLUMN becas_nueva.fecha_nacimiento; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.fecha_nacimiento IS 'Fecha de nacimiento';

--
-- Name: COLUMN becas_nueva.celular; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.celular IS 'Número de celular';

--
-- Name: COLUMN becas_nueva.correo_electronico; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.correo_electronico IS 'Correo electrónico';

--
-- Name: COLUMN becas_nueva.empresa_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.empresa_id IS 'FK a tabla empresa';

--
-- Name: COLUMN becas_nueva.sexo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.becas_nueva.sexo IS 'Sexo: Masculino o Femenino';

--
-- Name: becas_nueva_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.becas_nueva_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: becas_nueva_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.becas_nueva_id_seq OWNED BY public.becas_nueva.id;

--
-- Name: condicion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.condicion (
    id integer NOT NULL,
    descripcion text NOT NULL
);

--
-- Name: condicion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.condicion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: condicion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.condicion_id_seq OWNED BY public.condicion.id;

--
-- Name: documentos_gerenciales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documentos_gerenciales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    fecha_documento date NOT NULL,
    nombre_archivo text NOT NULL,
    url_pdf text NOT NULL,
    observaciones text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

--
-- Name: ejes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ejes (
    id integer NOT NULL,
    descripcion text,
    fase text
);

--
-- Name: empresas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empresas (
    ruc text NOT NULL,
    razon_social text NOT NULL,
    ciiu_id bigint
);

--
-- Name: especialistas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.especialistas (
    id integer NOT NULL,
    nombre text NOT NULL
);

--
-- Name: especialistas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.especialistas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: especialistas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.especialistas_id_seq OWNED BY public.especialistas.id;

--
-- Name: etapas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.etapas (
    id integer NOT NULL,
    descripcion text,
    fase text
);

--
-- Name: finanzas_anual; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.finanzas_anual (
    id integer NOT NULL,
    "año" integer NOT NULL,
    rubro text NOT NULL,
    monto numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    escenario text DEFAULT 'Real'::text
);

--
-- Name: finanzas_anual_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.finanzas_anual_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: finanzas_anual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.finanzas_anual_id_seq OWNED BY public.finanzas_anual.id;

--
-- Name: formato; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.formato (
    id integer NOT NULL,
    descripcion text NOT NULL
);

--
-- Name: formato_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.formato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: formato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.formato_id_seq OWNED BY public.formato.id;

--
-- Name: grupo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grupo (
    id integer NOT NULL,
    descripcion text NOT NULL,
    orden integer NOT NULL,
    tipo integer DEFAULT 1
);

--
-- Name: grupo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grupo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: grupo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grupo_id_seq OWNED BY public.grupo.id;

--
-- Name: institucion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institucion (
    id integer NOT NULL,
    descripcion text NOT NULL
);

--
-- Name: institucion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.institucion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: institucion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.institucion_id_seq OWNED BY public.institucion.id;

--
-- Name: instituciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instituciones (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre text NOT NULL,
    correo text,
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: instituciones_ejecutoras; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instituciones_ejecutoras (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre text,
    ruc text,
    correo text,
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: lineas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lineas (
    id integer NOT NULL,
    descripcion text,
    fase text
);

--
-- Name: logs_actualizacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.logs_actualizacion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    usuario_id uuid,
    proyecto_id uuid,
    campo_modificado text,
    valor_anterior text,
    valor_nuevo text,
    fecha timestamp with time zone DEFAULT now()
);

--
-- Name: metricas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metricas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    proyecto_id uuid,
    monto_fondoempleo numeric DEFAULT 0,
    monto_contrapartida numeric DEFAULT 0,
    monto_total numeric GENERATED ALWAYS AS ((COALESCE(monto_fondoempleo, (0)::numeric) + COALESCE(monto_contrapartida, (0)::numeric))) STORED,
    van numeric DEFAULT 0,
    tir numeric DEFAULT 0,
    beneficiarios integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: modalidades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modalidades (
    id integer NOT NULL,
    descripcion text,
    fase text
);

--
-- Name: naturaleza_ie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.naturaleza_ie (
    id integer NOT NULL,
    descripcion text NOT NULL
);

--
-- Name: naturaleza_ie_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.naturaleza_ie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: naturaleza_ie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.naturaleza_ie_id_seq OWNED BY public.naturaleza_ie.id;

--
-- Name: pagos_gestoras; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pagos_gestoras (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    gestora text,
    nro_pago integer,
    mes_pago date,
    periodo_servicio text,
    monto numeric,
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: presupuesto_anual_comparativo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.presupuesto_anual_comparativo (
    id integer NOT NULL,
    unidad_operativa_id integer,
    "año" integer NOT NULL,
    poi numeric NOT NULL,
    ejecutado numeric NOT NULL
);

--
-- Name: presupuesto_anual_comparativo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.presupuesto_anual_comparativo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: presupuesto_anual_comparativo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.presupuesto_anual_comparativo_id_seq OWNED BY public.presupuesto_anual_comparativo.id;

--
-- Name: presupuesto_mensual; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.presupuesto_mensual (
    id integer NOT NULL,
    unidad_operativa_id integer,
    "año" integer DEFAULT 2026,
    mes integer NOT NULL,
    presupuesto numeric NOT NULL,
    ejecutado numeric DEFAULT 0,
    CONSTRAINT presupuesto_mensual_mes_check CHECK (((mes >= 1) AND (mes <= 12)))
);

--
-- Name: presupuesto_mensual_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.presupuesto_mensual_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: presupuesto_mensual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.presupuesto_mensual_id_seq OWNED BY public.presupuesto_mensual.id;

--
-- Name: programa_proyecto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.programa_proyecto (
    id integer NOT NULL,
    proyecto_id integer,
    fecha date NOT NULL,
    monto numeric(15,2) DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

--
-- Name: programa_proyecto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.programa_proyecto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: programa_proyecto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.programa_proyecto_id_seq OWNED BY public.programa_proyecto.id;

--
-- Name: proyectos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.proyectos (
    id integer NOT NULL,
    codigo_proyecto text,
    nombre text,
    linea_id integer,
    eje_id integer,
    region_id integer,
    etapa_id integer,
    modalidad_id integer,
    institucion_ejecutora_id uuid,
    monto_fondoempleo numeric DEFAULT 0,
    beneficiarios integer DEFAULT 0,
    "año" integer,
    gestora text,
    created_at timestamp with time zone DEFAULT now(),
    evaluacion_config_id uuid,
    url_archivo_proyecto text,
    avance numeric,
    contrapartida numeric DEFAULT 0,
    avance_tecnico integer DEFAULT 0 NOT NULL,
    grupo_id integer,
    provincia text,
    especialista_id integer,
    sustento text,
    contacto text
);

--
-- Name: COLUMN proyectos.url_archivo_proyecto; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.proyectos.url_archivo_proyecto IS 'URL del PDF del proyecto postulante subido a Storage';

--
-- Name: regiones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regiones (
    id integer NOT NULL,
    descripcion text
);

--
-- Name: sectores_ciiu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sectores_ciiu (
    id bigint NOT NULL,
    ciiu_codigo text,
    clase_desc text,
    grupo_desc text,
    division_desc text,
    seccion_desc text
);

--
-- Name: sectores_ciiu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.sectores_ciiu ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.sectores_ciiu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

--
-- Name: tipo_estudio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipo_estudio (
    id integer NOT NULL,
    descripcion text NOT NULL
);

--
-- Name: tipo_estudio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tipo_estudio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: tipo_estudio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipo_estudio_id_seq OWNED BY public.tipo_estudio.id;

--
-- Name: unidades_operativas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unidades_operativas (
    id integer NOT NULL,
    siglas text NOT NULL,
    nombre_completo text,
    orden integer DEFAULT 0 NOT NULL
);

--
-- Name: unidades_operativas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unidades_operativas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: unidades_operativas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unidades_operativas_id_seq OWNED BY public.unidades_operativas.id;

--
-- Name: aportantes_anual id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aportantes_anual ALTER COLUMN id SET DEFAULT nextval('public.aportantes_anual_id_seq'::regclass);

--
-- Name: becas_nueva id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva ALTER COLUMN id SET DEFAULT nextval('public.becas_nueva_id_seq'::regclass);

--
-- Name: condicion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condicion ALTER COLUMN id SET DEFAULT nextval('public.condicion_id_seq'::regclass);

--
-- Name: especialistas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.especialistas ALTER COLUMN id SET DEFAULT nextval('public.especialistas_id_seq'::regclass);

--
-- Name: finanzas_anual id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finanzas_anual ALTER COLUMN id SET DEFAULT nextval('public.finanzas_anual_id_seq'::regclass);

--
-- Name: formato id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formato ALTER COLUMN id SET DEFAULT nextval('public.formato_id_seq'::regclass);

--
-- Name: grupo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grupo ALTER COLUMN id SET DEFAULT nextval('public.grupo_id_seq'::regclass);

--
-- Name: institucion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institucion ALTER COLUMN id SET DEFAULT nextval('public.institucion_id_seq'::regclass);

--
-- Name: naturaleza_ie id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.naturaleza_ie ALTER COLUMN id SET DEFAULT nextval('public.naturaleza_ie_id_seq'::regclass);

--
-- Name: presupuesto_anual_comparativo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_anual_comparativo ALTER COLUMN id SET DEFAULT nextval('public.presupuesto_anual_comparativo_id_seq'::regclass);

--
-- Name: presupuesto_mensual id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_mensual ALTER COLUMN id SET DEFAULT nextval('public.presupuesto_mensual_id_seq'::regclass);

--
-- Name: programa_proyecto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programa_proyecto ALTER COLUMN id SET DEFAULT nextval('public.programa_proyecto_id_seq'::regclass);

--
-- Name: tipo_estudio id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_estudio ALTER COLUMN id SET DEFAULT nextval('public.tipo_estudio_id_seq'::regclass);

--
-- Name: unidades_operativas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidades_operativas ALTER COLUMN id SET DEFAULT nextval('public.unidades_operativas_id_seq'::regclass);

--
-- Name: aportantes_anual aportantes_anual_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aportantes_anual
    ADD CONSTRAINT aportantes_anual_pkey PRIMARY KEY (id);

--
-- Name: aportes aportes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aportes
    ADD CONSTRAINT aportes_pkey PRIMARY KEY (id);

--
-- Name: avance_beca avance_beca_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avance_beca
    ADD CONSTRAINT avance_beca_pkey PRIMARY KEY (id);

--
-- Name: avance_proyecto avance_proyecto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avance_proyecto
    ADD CONSTRAINT avance_proyecto_pkey PRIMARY KEY (id);

--
-- Name: avances avances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avances
    ADD CONSTRAINT avances_pkey PRIMARY KEY (id);

--
-- Name: becas_nueva becas_nueva_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_pkey PRIMARY KEY (id);

--
-- Name: condicion condicion_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condicion
    ADD CONSTRAINT condicion_descripcion_key UNIQUE (descripcion);

--
-- Name: condicion condicion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.condicion
    ADD CONSTRAINT condicion_pkey PRIMARY KEY (id);

--
-- Name: documentos_gerenciales documentos_gerenciales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documentos_gerenciales
    ADD CONSTRAINT documentos_gerenciales_pkey PRIMARY KEY (id);

--
-- Name: ejes ejes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ejes
    ADD CONSTRAINT ejes_pkey PRIMARY KEY (id);

--
-- Name: empresas empresas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empresas
    ADD CONSTRAINT empresas_pkey PRIMARY KEY (ruc);

--
-- Name: especialistas especialistas_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.especialistas
    ADD CONSTRAINT especialistas_nombre_key UNIQUE (nombre);

--
-- Name: especialistas especialistas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.especialistas
    ADD CONSTRAINT especialistas_pkey PRIMARY KEY (id);

--
-- Name: etapas etapas_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etapas
    ADD CONSTRAINT etapas_descripcion_key UNIQUE (descripcion);

--
-- Name: etapas etapas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etapas
    ADD CONSTRAINT etapas_pkey PRIMARY KEY (id);

--
-- Name: finanzas_anual finanzas_anual_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.finanzas_anual
    ADD CONSTRAINT finanzas_anual_pkey PRIMARY KEY (id);

--
-- Name: formato formato_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formato
    ADD CONSTRAINT formato_descripcion_key UNIQUE (descripcion);

--
-- Name: formato formato_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formato
    ADD CONSTRAINT formato_pkey PRIMARY KEY (id);

--
-- Name: grupo grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grupo
    ADD CONSTRAINT grupo_pkey PRIMARY KEY (id);

--
-- Name: institucion institucion_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institucion
    ADD CONSTRAINT institucion_descripcion_key UNIQUE (descripcion);

--
-- Name: institucion institucion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (id);

--
-- Name: instituciones instituciones_correo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituciones
    ADD CONSTRAINT instituciones_correo_key UNIQUE (correo);

--
-- Name: instituciones_ejecutoras instituciones_ejecutoras_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituciones_ejecutoras
    ADD CONSTRAINT instituciones_ejecutoras_nombre_key UNIQUE (nombre);

--
-- Name: instituciones_ejecutoras instituciones_ejecutoras_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituciones_ejecutoras
    ADD CONSTRAINT instituciones_ejecutoras_pkey PRIMARY KEY (id);

--
-- Name: instituciones instituciones_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituciones
    ADD CONSTRAINT instituciones_nombre_key UNIQUE (nombre);

--
-- Name: instituciones instituciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituciones
    ADD CONSTRAINT instituciones_pkey PRIMARY KEY (id);

--
-- Name: lineas lineas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lineas
    ADD CONSTRAINT lineas_pkey PRIMARY KEY (id);

--
-- Name: logs_actualizacion logs_actualizacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs_actualizacion
    ADD CONSTRAINT logs_actualizacion_pkey PRIMARY KEY (id);

--
-- Name: metricas metricas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metricas
    ADD CONSTRAINT metricas_pkey PRIMARY KEY (id);

--
-- Name: modalidades modalidades_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidades
    ADD CONSTRAINT modalidades_descripcion_key UNIQUE (descripcion);

--
-- Name: modalidades modalidades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modalidades
    ADD CONSTRAINT modalidades_pkey PRIMARY KEY (id);

--
-- Name: naturaleza_ie naturaleza_ie_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.naturaleza_ie
    ADD CONSTRAINT naturaleza_ie_descripcion_key UNIQUE (descripcion);

--
-- Name: naturaleza_ie naturaleza_ie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.naturaleza_ie
    ADD CONSTRAINT naturaleza_ie_pkey PRIMARY KEY (id);

--
-- Name: pagos_gestoras pagos_gestoras_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pagos_gestoras
    ADD CONSTRAINT pagos_gestoras_pkey PRIMARY KEY (id);

--
-- Name: presupuesto_anual_comparativo presupuesto_anual_comparativo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_anual_comparativo
    ADD CONSTRAINT presupuesto_anual_comparativo_pkey PRIMARY KEY (id);

--
-- Name: presupuesto_anual_comparativo presupuesto_anual_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_anual_comparativo
    ADD CONSTRAINT presupuesto_anual_unico UNIQUE (unidad_operativa_id, "año");

--
-- Name: presupuesto_mensual presupuesto_cronologico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_mensual
    ADD CONSTRAINT presupuesto_cronologico UNIQUE (unidad_operativa_id, "año", mes);

--
-- Name: presupuesto_mensual presupuesto_mensual_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_mensual
    ADD CONSTRAINT presupuesto_mensual_pkey PRIMARY KEY (id);

--
-- Name: programa_proyecto programa_proyecto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programa_proyecto
    ADD CONSTRAINT programa_proyecto_pkey PRIMARY KEY (id);

--
-- Name: proyectos proyectos_servicios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_servicios_pkey PRIMARY KEY (id);

--
-- Name: regiones regiones_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_descripcion_key UNIQUE (descripcion);

--
-- Name: regiones regiones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_pkey PRIMARY KEY (id);

--
-- Name: sectores_ciiu sectores_ciiu_ciiu_codigo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectores_ciiu
    ADD CONSTRAINT sectores_ciiu_ciiu_codigo_key UNIQUE (ciiu_codigo);

--
-- Name: sectores_ciiu sectores_ciiu_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectores_ciiu
    ADD CONSTRAINT sectores_ciiu_pkey PRIMARY KEY (id);

--
-- Name: tipo_estudio tipo_estudio_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_estudio
    ADD CONSTRAINT tipo_estudio_descripcion_key UNIQUE (descripcion);

--
-- Name: tipo_estudio tipo_estudio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_estudio
    ADD CONSTRAINT tipo_estudio_pkey PRIMARY KEY (id);

--
-- Name: unidades_operativas unidades_operativas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidades_operativas
    ADD CONSTRAINT unidades_operativas_pkey PRIMARY KEY (id);

--
-- Name: unidades_operativas unidades_operativas_siglas_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidades_operativas
    ADD CONSTRAINT unidades_operativas_siglas_key UNIQUE (siglas);

--
-- Name: idx_aportes_anio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_aportes_anio ON public.aportes USING btree (anio);

--
-- Name: idx_aportes_empresa; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_aportes_empresa ON public.aportes USING btree (empresa_ruc);

--
-- Name: idx_aportes_empresa_ruc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_aportes_empresa_ruc ON public.aportes USING btree (empresa_ruc);

--
-- Name: idx_avance_proyecto_etapa_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_avance_proyecto_etapa_id ON public.avance_proyecto USING btree (etapa_id);

--
-- Name: idx_avance_proyecto_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_avance_proyecto_fecha ON public.avance_proyecto USING btree (fecha);

--
-- Name: idx_avance_proyecto_proyecto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_avance_proyecto_proyecto_id ON public.avance_proyecto USING btree (proyecto_id);

--
-- Name: idx_etapas_descripcion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_etapas_descripcion ON public.etapas USING btree (descripcion);

--
-- Name: idx_etapas_fase; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_etapas_fase ON public.etapas USING btree (fase);

--
-- Name: idx_grupo_orden; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_grupo_orden ON public.grupo USING btree (orden);

--
-- Name: idx_grupo_tipo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_grupo_tipo ON public.grupo USING btree (tipo);

--
-- Name: idx_programa_proyecto_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_programa_proyecto_fecha ON public.programa_proyecto USING btree (fecha);

--
-- Name: idx_programa_proyecto_proyecto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_programa_proyecto_proyecto_id ON public.programa_proyecto USING btree (proyecto_id);

--
-- Name: idx_proyectos_anio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_anio ON public.proyectos USING btree ("año");

--
-- Name: idx_proyectos_eje_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_eje_id ON public.proyectos USING btree (eje_id);

--
-- Name: idx_proyectos_especialista_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_especialista_id ON public.proyectos USING btree (especialista_id);

--
-- Name: idx_proyectos_etapa_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_etapa_id ON public.proyectos USING btree (etapa_id);

--
-- Name: idx_proyectos_grupo_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_grupo_id ON public.proyectos USING btree (grupo_id);

--
-- Name: idx_proyectos_institucion_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_institucion_id ON public.proyectos USING btree (institucion_ejecutora_id);

--
-- Name: idx_proyectos_linea_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_linea_id ON public.proyectos USING btree (linea_id);

--
-- Name: idx_proyectos_modalidad_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_modalidad_id ON public.proyectos USING btree (modalidad_id);

--
-- Name: idx_proyectos_region_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proyectos_region_id ON public.proyectos USING btree (region_id);

--
-- Name: aportes tr_actualizar_finanzas_aportes; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_actualizar_finanzas_aportes AFTER INSERT OR DELETE OR UPDATE ON public.aportes FOR EACH ROW EXECUTE FUNCTION public.recalculate_finanzas_aportes();

--
-- Name: metricas trigger_log_metricas_changes; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_log_metricas_changes AFTER UPDATE ON public.metricas FOR EACH ROW EXECUTE FUNCTION public.log_metricas_changes();

--
-- Name: aportes aportes_empresa_ruc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aportes
    ADD CONSTRAINT aportes_empresa_ruc_fkey FOREIGN KEY (empresa_ruc) REFERENCES public.empresas(ruc);

--
-- Name: avance_beca avance_beca_beca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avance_beca
    ADD CONSTRAINT avance_beca_beca_id_fkey FOREIGN KEY (beca_id) REFERENCES public.becas_nueva(id) ON DELETE CASCADE;

--
-- Name: avance_beca avance_beca_etapa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avance_beca
    ADD CONSTRAINT avance_beca_etapa_id_fkey FOREIGN KEY (etapa_id) REFERENCES public.etapas(id);

--
-- Name: avance_proyecto avance_proyecto_etapa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avance_proyecto
    ADD CONSTRAINT avance_proyecto_etapa_id_fkey FOREIGN KEY (etapa_id) REFERENCES public.etapas(id);

--
-- Name: avance_proyecto avance_proyecto_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avance_proyecto
    ADD CONSTRAINT avance_proyecto_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES public.proyectos(id);

--
-- Name: avances avances_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avances
    ADD CONSTRAINT avances_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES public.proyectos(id);

--
-- Name: becas_nueva becas_nueva_condicion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_condicion_id_fkey FOREIGN KEY (condicion_id) REFERENCES public.condicion(id);

--
-- Name: becas_nueva becas_nueva_eje_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_eje_id_fkey FOREIGN KEY (eje_id) REFERENCES public.ejes(id);

--
-- Name: becas_nueva becas_nueva_etapa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_etapa_id_fkey FOREIGN KEY (etapa_id) REFERENCES public.etapas(id);

--
-- Name: becas_nueva becas_nueva_formato_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_formato_id_fkey FOREIGN KEY (formato_id) REFERENCES public.formato(id);

--
-- Name: becas_nueva becas_nueva_grupo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_grupo_id_fkey FOREIGN KEY (grupo_id) REFERENCES public.grupo(id);

--
-- Name: becas_nueva becas_nueva_institucion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_institucion_id_fkey FOREIGN KEY (institucion_id) REFERENCES public.institucion(id);

--
-- Name: becas_nueva becas_nueva_linea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_linea_id_fkey FOREIGN KEY (linea_id) REFERENCES public.lineas(id);

--
-- Name: becas_nueva becas_nueva_modalidad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_modalidad_id_fkey FOREIGN KEY (modalidad_id) REFERENCES public.modalidades(id);

--
-- Name: becas_nueva becas_nueva_naturaleza_ie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_naturaleza_ie_id_fkey FOREIGN KEY (naturaleza_ie_id) REFERENCES public.naturaleza_ie(id);

--
-- Name: becas_nueva becas_nueva_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regiones(id);

--
-- Name: becas_nueva becas_nueva_tipo_estudio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.becas_nueva
    ADD CONSTRAINT becas_nueva_tipo_estudio_id_fkey FOREIGN KEY (tipo_estudio_id) REFERENCES public.tipo_estudio(id);

--
-- Name: empresas empresas_ciiu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empresas
    ADD CONSTRAINT empresas_ciiu_id_fkey FOREIGN KEY (ciiu_id) REFERENCES public.sectores_ciiu(id);

--
-- Name: proyectos fk_proyectos_grupo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT fk_proyectos_grupo FOREIGN KEY (grupo_id) REFERENCES public.grupo(id);

--
-- Name: presupuesto_anual_comparativo presupuesto_anual_comparativo_unidad_operativa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_anual_comparativo
    ADD CONSTRAINT presupuesto_anual_comparativo_unidad_operativa_id_fkey FOREIGN KEY (unidad_operativa_id) REFERENCES public.unidades_operativas(id);

--
-- Name: presupuesto_mensual presupuesto_mensual_unidad_operativa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.presupuesto_mensual
    ADD CONSTRAINT presupuesto_mensual_unidad_operativa_id_fkey FOREIGN KEY (unidad_operativa_id) REFERENCES public.unidades_operativas(id);

--
-- Name: programa_proyecto programa_proyecto_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programa_proyecto
    ADD CONSTRAINT programa_proyecto_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES public.proyectos(id) ON DELETE CASCADE;

--
-- Name: proyectos proyectos_especialista_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_especialista_id_fkey FOREIGN KEY (especialista_id) REFERENCES public.especialistas(id);

--
-- Name: proyectos proyectos_servicios_eje_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_servicios_eje_id_fkey FOREIGN KEY (eje_id) REFERENCES public.ejes(id);

--
-- Name: proyectos proyectos_servicios_etapa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_servicios_etapa_id_fkey FOREIGN KEY (etapa_id) REFERENCES public.etapas(id);

--
-- Name: proyectos proyectos_servicios_institucion_ejecutora_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_servicios_institucion_ejecutora_id_fkey FOREIGN KEY (institucion_ejecutora_id) REFERENCES public.instituciones_ejecutoras(id);

--
-- Name: proyectos proyectos_servicios_linea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_servicios_linea_id_fkey FOREIGN KEY (linea_id) REFERENCES public.lineas(id);

--
-- Name: proyectos proyectos_servicios_modalidad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_servicios_modalidad_id_fkey FOREIGN KEY (modalidad_id) REFERENCES public.modalidades(id);

--
-- Name: proyectos proyectos_servicios_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proyectos
    ADD CONSTRAINT proyectos_servicios_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regiones(id);

