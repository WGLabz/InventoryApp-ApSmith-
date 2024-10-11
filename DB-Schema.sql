--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13
-- Dumped by pg_dump version 14.13

-- Started on 2024-10-11 15:04:35 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS appsmith;
--
-- TOC entry 3527 (class 1262 OID 16384)
-- Name: appsmith; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE appsmith WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE appsmith OWNER TO postgres;

\connect appsmith

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 240 (class 1255 OID 24692)
-- Name: save_notes_history(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.save_notes_history() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO notes_history (note_id, component_id, note_text, updated_at)
    VALUES (OLD.note_id, OLD.component_id, OLD.note_text, NOW());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.save_notes_history() OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 24690)
-- Name: save_video_history(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.save_video_history() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO video_history (video_id, title, description, script, status, updated_at)
    VALUES (OLD.video_id, OLD.title, OLD.description, OLD.script, OLD.status, NOW());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.save_video_history() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: boxes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.boxes (
    box_id integer NOT NULL,
    box_label character varying(255) NOT NULL,
    box_code character varying,
    box_qr_filename text,
    box_qr_content bytea,
    box_qr_file_type text
);


ALTER TABLE public.boxes OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16390)
-- Name: boxes_box_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.boxes_box_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boxes_box_id_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 210
-- Name: boxes_box_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.boxes_box_id_seq OWNED BY public.boxes.box_id;


--
-- TOC entry 211 (class 1259 OID 16391)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16394)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 212
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 237 (class 1259 OID 24703)
-- Name: component_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_files (
    file_id integer NOT NULL,
    component_id integer NOT NULL,
    minio_file_name character varying(255) NOT NULL,
    minio_bucket character varying(255) NOT NULL,
    minio_file_type character varying(50),
    upload_date timestamp without time zone DEFAULT now(),
    description text
);


ALTER TABLE public.component_files OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 24702)
-- Name: component_files_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.component_files_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.component_files_file_id_seq OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 236
-- Name: component_files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.component_files_file_id_seq OWNED BY public.component_files.file_id;


--
-- TOC entry 213 (class 1259 OID 16395)
-- Name: components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.components (
    component_id integer NOT NULL,
    name character varying(255) NOT NULL,
    imaeg_name text,
    category_id integer,
    box_id integer,
    description text,
    date_added date DEFAULT CURRENT_DATE,
    image_content bytea,
    image_type text
);


ALTER TABLE public.components OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16401)
-- Name: components_component_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.components_component_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_component_id_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 214
-- Name: components_component_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.components_component_id_seq OWNED BY public.components.component_id;


--
-- TOC entry 225 (class 1259 OID 16543)
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    invoice_id integer NOT NULL,
    order_id integer,
    invoice_date date NOT NULL,
    minio_file_name text,
    total_amount numeric(10,2),
    created_at timestamp without time zone DEFAULT now(),
    minio_bucket text,
    minio_file_type text,
    description text
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16542)
-- Name: invoices_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoices_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoices_invoice_id_seq OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 224
-- Name: invoices_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoices_invoice_id_seq OWNED BY public.invoices.invoice_id;


--
-- TOC entry 231 (class 1259 OID 24640)
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    note_id integer NOT NULL,
    component_id integer,
    note_text text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24671)
-- Name: notes_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes_history (
    history_id integer NOT NULL,
    note_id integer NOT NULL,
    component_id integer,
    note_text text,
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notes_history OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 24670)
-- Name: notes_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_history_history_id_seq OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 234
-- Name: notes_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notes_history_history_id_seq OWNED BY public.notes_history.history_id;


--
-- TOC entry 230 (class 1259 OID 24639)
-- Name: notes_note_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_note_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_note_id_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 230
-- Name: notes_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notes_note_id_seq OWNED BY public.notes.note_id;


--
-- TOC entry 215 (class 1259 OID 16402)
-- Name: order_parts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_parts (
    order_part_id integer NOT NULL,
    order_id integer,
    component_id integer,
    quantity_ordered integer NOT NULL,
    unit_cost numeric(10,2) NOT NULL,
    url character varying(8000)
);


ALTER TABLE public.order_parts OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16405)
-- Name: order_parts_order_part_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_parts_order_part_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_parts_order_part_id_seq OWNER TO postgres;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 216
-- Name: order_parts_order_part_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_parts_order_part_id_seq OWNED BY public.order_parts.order_part_id;


--
-- TOC entry 217 (class 1259 OID 16406)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    vendor_id integer,
    order_date date NOT NULL,
    total_cost numeric(10,2) NOT NULL,
    delivery_date date,
    status character varying(50) DEFAULT 'Pending'::character varying
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16410)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 218
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 219 (class 1259 OID 16411)
-- Name: project_components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_components (
    project_id integer NOT NULL,
    component_id integer NOT NULL,
    quantity_used integer NOT NULL,
    date date
);


ALTER TABLE public.project_components OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24739)
-- Name: project_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_files (
    file_id integer NOT NULL,
    project_id integer NOT NULL,
    minio_bucket character varying(255) NOT NULL,
    minio_file_name character varying(255) NOT NULL,
    minio_file_type character varying(100) NOT NULL,
    uploaded_at timestamp without time zone DEFAULT now(),
    description text
);


ALTER TABLE public.project_files OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 24738)
-- Name: project_files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_files_id_seq OWNER TO postgres;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 238
-- Name: project_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_files_id_seq OWNED BY public.project_files.file_id;


--
-- TOC entry 220 (class 1259 OID 16414)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    project_id integer NOT NULL,
    project_name character varying(255) NOT NULL,
    start_date date,
    end_date date,
    status character varying(50),
    description text,
    is_yt_project boolean DEFAULT false,
    git_repository text
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16417)
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_project_id_seq OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 221
-- Name: projects_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_project_id_seq OWNED BY public.projects.project_id;


--
-- TOC entry 222 (class 1259 OID 16418)
-- Name: vendors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors (
    vendor_id integer NOT NULL,
    vendor_name character varying(255) NOT NULL,
    website character varying(255),
    contact_email character varying(255),
    phone_number character varying(50),
    vendor_icon_name text,
    vendor_icon_type text,
    vendor_icon_content bytea
);


ALTER TABLE public.vendors OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16423)
-- Name: vendors_vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendors_vendor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_vendor_id_seq OWNER TO postgres;

--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 223
-- Name: vendors_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendors_vendor_id_seq OWNED BY public.vendors.vendor_id;


--
-- TOC entry 227 (class 1259 OID 24590)
-- Name: video; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.video (
    video_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    script text,
    status character varying(50),
    publish_date timestamp without time zone,
    projects_id integer,
    youtube_video_id text
);


ALTER TABLE public.video OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24656)
-- Name: video_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.video_history (
    history_id integer NOT NULL,
    video_id integer NOT NULL,
    title character varying(255),
    description text,
    script text,
    status character varying(50),
    publish_date timestamp without time zone,
    youtube_url character varying(255),
    is_project boolean,
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.video_history OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 24655)
-- Name: video_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.video_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_history_history_id_seq OWNER TO postgres;

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 232
-- Name: video_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_history_history_id_seq OWNED BY public.video_history.history_id;


--
-- TOC entry 226 (class 1259 OID 24589)
-- Name: video_video_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.video_video_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_video_id_seq OWNER TO postgres;

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 226
-- Name: video_video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_video_id_seq OWNED BY public.video.video_id;


--
-- TOC entry 229 (class 1259 OID 24605)
-- Name: videostatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videostatus (
    status_id integer NOT NULL,
    video_id integer,
    status character varying(50) NOT NULL,
    date_changed timestamp without time zone DEFAULT now()
);


ALTER TABLE public.videostatus OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24604)
-- Name: videostatus_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.videostatus_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videostatus_status_id_seq OWNER TO postgres;

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 228
-- Name: videostatus_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.videostatus_status_id_seq OWNED BY public.videostatus.status_id;


--
-- TOC entry 3309 (class 2604 OID 16424)
-- Name: boxes box_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boxes ALTER COLUMN box_id SET DEFAULT nextval('public.boxes_box_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 16425)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 3331 (class 2604 OID 24706)
-- Name: component_files file_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_files ALTER COLUMN file_id SET DEFAULT nextval('public.component_files_file_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 16426)
-- Name: components component_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components ALTER COLUMN component_id SET DEFAULT nextval('public.components_component_id_seq'::regclass);


--
-- TOC entry 3319 (class 2604 OID 16546)
-- Name: invoices invoice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoices_invoice_id_seq'::regclass);


--
-- TOC entry 3324 (class 2604 OID 24643)
-- Name: notes note_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes ALTER COLUMN note_id SET DEFAULT nextval('public.notes_note_id_seq'::regclass);


--
-- TOC entry 3329 (class 2604 OID 24674)
-- Name: notes_history history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes_history ALTER COLUMN history_id SET DEFAULT nextval('public.notes_history_history_id_seq'::regclass);


--
-- TOC entry 3313 (class 2604 OID 16427)
-- Name: order_parts order_part_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts ALTER COLUMN order_part_id SET DEFAULT nextval('public.order_parts_order_part_id_seq'::regclass);


--
-- TOC entry 3315 (class 2604 OID 16428)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 3333 (class 2604 OID 24742)
-- Name: project_files file_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_files ALTER COLUMN file_id SET DEFAULT nextval('public.project_files_id_seq'::regclass);


--
-- TOC entry 3316 (class 2604 OID 16429)
-- Name: projects project_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN project_id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);


--
-- TOC entry 3318 (class 2604 OID 16430)
-- Name: vendors vendor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors ALTER COLUMN vendor_id SET DEFAULT nextval('public.vendors_vendor_id_seq'::regclass);


--
-- TOC entry 3321 (class 2604 OID 24593)
-- Name: video video_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video ALTER COLUMN video_id SET DEFAULT nextval('public.video_video_id_seq'::regclass);


--
-- TOC entry 3327 (class 2604 OID 24659)
-- Name: video_history history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_history ALTER COLUMN history_id SET DEFAULT nextval('public.video_history_history_id_seq'::regclass);


--
-- TOC entry 3322 (class 2604 OID 24608)
-- Name: videostatus status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videostatus ALTER COLUMN status_id SET DEFAULT nextval('public.videostatus_status_id_seq'::regclass);


--
-- TOC entry 3336 (class 2606 OID 16432)
-- Name: boxes boxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boxes
    ADD CONSTRAINT boxes_pkey PRIMARY KEY (box_id);


--
-- TOC entry 3338 (class 2606 OID 16434)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 3362 (class 2606 OID 24711)
-- Name: component_files component_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_files
    ADD CONSTRAINT component_files_pkey PRIMARY KEY (file_id);


--
-- TOC entry 3340 (class 2606 OID 16436)
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (component_id);


--
-- TOC entry 3350 (class 2606 OID 16551)
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (invoice_id);


--
-- TOC entry 3360 (class 2606 OID 24679)
-- Name: notes_history notes_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes_history
    ADD CONSTRAINT notes_history_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3356 (class 2606 OID 24649)
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (note_id);


--
-- TOC entry 3342 (class 2606 OID 16438)
-- Name: order_parts order_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts
    ADD CONSTRAINT order_parts_pkey PRIMARY KEY (order_part_id);


--
-- TOC entry 3344 (class 2606 OID 16440)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3364 (class 2606 OID 24747)
-- Name: project_files project_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_pkey PRIMARY KEY (file_id);


--
-- TOC entry 3346 (class 2606 OID 16444)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- TOC entry 3348 (class 2606 OID 16446)
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (vendor_id);


--
-- TOC entry 3358 (class 2606 OID 24664)
-- Name: video_history video_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_history
    ADD CONSTRAINT video_history_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3352 (class 2606 OID 24598)
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (video_id);


--
-- TOC entry 3354 (class 2606 OID 24611)
-- Name: videostatus videostatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videostatus
    ADD CONSTRAINT videostatus_pkey PRIMARY KEY (status_id);


--
-- TOC entry 3382 (class 2620 OID 24693)
-- Name: notes before_notes_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_notes_update BEFORE UPDATE ON public.notes FOR EACH ROW EXECUTE FUNCTION public.save_notes_history();


--
-- TOC entry 3381 (class 2620 OID 24691)
-- Name: video before_video_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_video_update BEFORE UPDATE ON public.video FOR EACH ROW EXECUTE FUNCTION public.save_video_history();


--
-- TOC entry 3379 (class 2606 OID 24712)
-- Name: component_files component_files_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_files
    ADD CONSTRAINT component_files_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(component_id);


--
-- TOC entry 3365 (class 2606 OID 16447)
-- Name: components components_box_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_box_id_fkey FOREIGN KEY (box_id) REFERENCES public.boxes(box_id);


--
-- TOC entry 3366 (class 2606 OID 16452)
-- Name: components components_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 3375 (class 2606 OID 24650)
-- Name: notes fk_component; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_component FOREIGN KEY (component_id) REFERENCES public.components(component_id) ON DELETE CASCADE;


--
-- TOC entry 3373 (class 2606 OID 24697)
-- Name: video fk_projects; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT fk_projects FOREIGN KEY (projects_id) REFERENCES public.projects(project_id) NOT VALID;


--
-- TOC entry 3374 (class 2606 OID 24612)
-- Name: videostatus fk_video_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videostatus
    ADD CONSTRAINT fk_video_status FOREIGN KEY (video_id) REFERENCES public.video(video_id) ON DELETE CASCADE;


--
-- TOC entry 3372 (class 2606 OID 16552)
-- Name: invoices invoices_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3378 (class 2606 OID 24685)
-- Name: notes_history notes_history_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes_history
    ADD CONSTRAINT notes_history_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(component_id);


--
-- TOC entry 3377 (class 2606 OID 24680)
-- Name: notes_history notes_history_note_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes_history
    ADD CONSTRAINT notes_history_note_id_fkey FOREIGN KEY (note_id) REFERENCES public.notes(note_id);


--
-- TOC entry 3367 (class 2606 OID 16457)
-- Name: order_parts order_parts_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts
    ADD CONSTRAINT order_parts_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(component_id);


--
-- TOC entry 3368 (class 2606 OID 16462)
-- Name: order_parts order_parts_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts
    ADD CONSTRAINT order_parts_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3369 (class 2606 OID 16467)
-- Name: orders orders_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(vendor_id);


--
-- TOC entry 3370 (class 2606 OID 16472)
-- Name: project_components project_components_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_components
    ADD CONSTRAINT project_components_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(component_id);


--
-- TOC entry 3371 (class 2606 OID 16477)
-- Name: project_components project_components_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_components
    ADD CONSTRAINT project_components_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id);


--
-- TOC entry 3380 (class 2606 OID 24748)
-- Name: project_files project_files_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id) ON DELETE CASCADE;


--
-- TOC entry 3376 (class 2606 OID 24665)
-- Name: video_history video_history_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_history
    ADD CONSTRAINT video_history_video_id_fkey FOREIGN KEY (video_id) REFERENCES public.video(video_id);


-- Completed on 2024-10-11 15:04:35 UTC

--
-- PostgreSQL database dump complete
--

