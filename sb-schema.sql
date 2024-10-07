--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-06 11:54:49 UTC

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 24593)
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


ALTER TABLE public.boxes OWNER TO "postgres";

--
-- TOC entry 219 (class 1259 OID 24592)
-- Name: boxes_box_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.boxes_box_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.boxes_box_id_seq OWNER TO "postgres";

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 219
-- Name: boxes_box_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.boxes_box_id_seq OWNED BY public.boxes.box_id;


--
-- TOC entry 218 (class 1259 OID 24586)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO "postgres";

--
-- TOC entry 217 (class 1259 OID 24585)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO "postgres";

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 217
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 222 (class 1259 OID 24602)
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


ALTER TABLE public.components OWNER TO "postgres";

--
-- TOC entry 221 (class 1259 OID 24601)
-- Name: components_component_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.components_component_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_component_id_seq OWNER TO "postgres";

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 221
-- Name: components_component_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.components_component_id_seq OWNED BY public.components.component_id;


--
-- TOC entry 226 (class 1259 OID 24635)
-- Name: order_parts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_parts (
    order_part_id integer NOT NULL,
    order_id integer,
    component_id integer,
    quantity_ordered integer NOT NULL,
    unit_cost numeric(10,2) NOT NULL
);


ALTER TABLE public.order_parts OWNER TO "postgres";

--
-- TOC entry 225 (class 1259 OID 24634)
-- Name: order_parts_order_part_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_parts_order_part_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_parts_order_part_id_seq OWNER TO "postgres";

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 225
-- Name: order_parts_order_part_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_parts_order_part_id_seq OWNED BY public.order_parts.order_part_id;


--
-- TOC entry 224 (class 1259 OID 24622)
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


ALTER TABLE public.orders OWNER TO "postgres";

--
-- TOC entry 223 (class 1259 OID 24621)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO "postgres";

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 223
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 229 (class 1259 OID 24675)
-- Name: project_components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_components (
    project_id integer NOT NULL,
    component_id integer NOT NULL,
    quantity_used integer NOT NULL
);


ALTER TABLE public.project_components OWNER TO "postgres";

--
-- TOC entry 228 (class 1259 OID 24669)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    project_id integer NOT NULL,
    project_name character varying(255) NOT NULL,
    start_date date,
    end_date date,
    status character varying(50)
);


ALTER TABLE public.projects OWNER TO "postgres";

--
-- TOC entry 227 (class 1259 OID 24668)
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_project_id_seq OWNER TO "postgres";

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 227
-- Name: projects_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_project_id_seq OWNED BY public.projects.project_id;


--
-- TOC entry 216 (class 1259 OID 24577)
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


ALTER TABLE public.vendors OWNER TO "postgres";

--
-- TOC entry 215 (class 1259 OID 24576)
-- Name: vendors_vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendors_vendor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendors_vendor_id_seq OWNER TO "postgres";

--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 215
-- Name: vendors_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendors_vendor_id_seq OWNED BY public.vendors.vendor_id;


--
-- TOC entry 3216 (class 2604 OID 24596)
-- Name: boxes box_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boxes ALTER COLUMN box_id SET DEFAULT nextval('public.boxes_box_id_seq'::regclass);


--
-- TOC entry 3215 (class 2604 OID 24589)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 3217 (class 2604 OID 24605)
-- Name: components component_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components ALTER COLUMN component_id SET DEFAULT nextval('public.components_component_id_seq'::regclass);


--
-- TOC entry 3221 (class 2604 OID 24638)
-- Name: order_parts order_part_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts ALTER COLUMN order_part_id SET DEFAULT nextval('public.order_parts_order_part_id_seq'::regclass);


--
-- TOC entry 3219 (class 2604 OID 24625)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 3222 (class 2604 OID 24672)
-- Name: projects project_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN project_id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);


--
-- TOC entry 3214 (class 2604 OID 24580)
-- Name: vendors vendor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors ALTER COLUMN vendor_id SET DEFAULT nextval('public.vendors_vendor_id_seq'::regclass);


--
-- TOC entry 3228 (class 2606 OID 24600)
-- Name: boxes boxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boxes
    ADD CONSTRAINT boxes_pkey PRIMARY KEY (box_id);


--
-- TOC entry 3226 (class 2606 OID 24591)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 3230 (class 2606 OID 24610)
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (component_id);


--
-- TOC entry 3234 (class 2606 OID 24640)
-- Name: order_parts order_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts
    ADD CONSTRAINT order_parts_pkey PRIMARY KEY (order_part_id);


--
-- TOC entry 3232 (class 2606 OID 24628)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3238 (class 2606 OID 24679)
-- Name: project_components project_components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_components
    ADD CONSTRAINT project_components_pkey PRIMARY KEY (project_id, component_id);


--
-- TOC entry 3236 (class 2606 OID 24674)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- TOC entry 3224 (class 2606 OID 24584)
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (vendor_id);


--
-- TOC entry 3239 (class 2606 OID 24616)
-- Name: components components_box_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_box_id_fkey FOREIGN KEY (box_id) REFERENCES public.boxes(box_id);


--
-- TOC entry 3240 (class 2606 OID 24611)
-- Name: components components_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- TOC entry 3242 (class 2606 OID 24646)
-- Name: order_parts order_parts_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts
    ADD CONSTRAINT order_parts_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(component_id);


--
-- TOC entry 3243 (class 2606 OID 24641)
-- Name: order_parts order_parts_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_parts
    ADD CONSTRAINT order_parts_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3241 (class 2606 OID 24629)
-- Name: orders orders_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(vendor_id);


--
-- TOC entry 3244 (class 2606 OID 24685)
-- Name: project_components project_components_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_components
    ADD CONSTRAINT project_components_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(component_id);


--
-- TOC entry 3245 (class 2606 OID 24680)
-- Name: project_components project_components_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_components
    ADD CONSTRAINT project_components_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id);
