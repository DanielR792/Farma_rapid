--
-- PostgreSQL database dump
--

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 17.0

-- Started on 2025-09-03 17:01:21

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
-- TOC entry 3562 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 3562
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 5 (class 2615 OID 33026)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 869 (class 1247 OID 33044)
-- Name: batch_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.batch_status AS ENUM (
    'available',
    'expired',
    'out_of_stock'
);


ALTER TYPE public.batch_status OWNER TO postgres;

--
-- TOC entry 863 (class 1247 OID 33028)
-- Name: payment_method; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_method AS ENUM (
    'cash',
    'card',
    'transfer'
);


ALTER TYPE public.payment_method OWNER TO postgres;

--
-- TOC entry 872 (class 1247 OID 33052)
-- Name: prescription_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.prescription_status AS ENUM (
    'active',
    'closed'
);


ALTER TYPE public.prescription_status OWNER TO postgres;

--
-- TOC entry 866 (class 1247 OID 33036)
-- Name: sale_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sale_status AS ENUM (
    'pending',
    'paid',
    'canceled'
);


ALTER TYPE public.sale_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 33130)
-- Name: batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batches (
    id integer NOT NULL,
    medicine_id integer NOT NULL,
    supplier_id integer NOT NULL,
    batch_code character varying(60) NOT NULL,
    expiration_date date NOT NULL,
    current_stock integer NOT NULL,
    status public.batch_status DEFAULT 'available'::public.batch_status NOT NULL
);


ALTER TABLE public.batches OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 33129)
-- Name: batches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.batches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batches_id_seq OWNER TO postgres;

--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 229
-- Name: batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.batches_id_seq OWNED BY public.batches.id;


--
-- TOC entry 216 (class 1259 OID 33058)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 33057)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 215
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 220 (class 1259 OID 33074)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    document character varying(50),
    name character varying(120) NOT NULL,
    phone character varying(50),
    email character varying(120),
    address character varying(200)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33073)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 219
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 224 (class 1259 OID 33092)
-- Name: medicines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicines (
    id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying(150) NOT NULL,
    description character varying(255),
    sale_price numeric(12,2) NOT NULL
);


ALTER TABLE public.medicines OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 33091)
-- Name: medicines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicines_id_seq OWNER TO postgres;

--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 223
-- Name: medicines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicines_id_seq OWNED BY public.medicines.id;


--
-- TOC entry 232 (class 1259 OID 33148)
-- Name: medicines_prescriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicines_prescriptions (
    id integer NOT NULL,
    medicine_id integer NOT NULL,
    prescription_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.medicines_prescriptions OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 33147)
-- Name: medicines_prescriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicines_prescriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicines_prescriptions_id_seq OWNER TO postgres;

--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 231
-- Name: medicines_prescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicines_prescriptions_id_seq OWNED BY public.medicines_prescriptions.id;


--
-- TOC entry 234 (class 1259 OID 33165)
-- Name: medicines_sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicines_sales (
    id integer NOT NULL,
    sale_id integer NOT NULL,
    medicine_id integer NOT NULL,
    batch_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(12,2) NOT NULL
);


ALTER TABLE public.medicines_sales OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 33164)
-- Name: medicines_sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicines_sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicines_sales_id_seq OWNER TO postgres;

--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 233
-- Name: medicines_sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicines_sales_id_seq OWNED BY public.medicines_sales.id;


--
-- TOC entry 236 (class 1259 OID 33187)
-- Name: medicines_sales_taxes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicines_sales_taxes (
    id integer NOT NULL,
    medicines_sale_id integer NOT NULL,
    tax_id integer NOT NULL
);


ALTER TABLE public.medicines_sales_taxes OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 33186)
-- Name: medicines_sales_taxes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicines_sales_taxes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicines_sales_taxes_id_seq OWNER TO postgres;

--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 235
-- Name: medicines_sales_taxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicines_sales_taxes_id_seq OWNED BY public.medicines_sales_taxes.id;


--
-- TOC entry 238 (class 1259 OID 33204)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    sale_id integer NOT NULL,
    method public.payment_method NOT NULL,
    amount_paid numeric(14,2) NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 33203)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 237
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 226 (class 1259 OID 33104)
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescriptions (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    issue_date date NOT NULL,
    status public.prescription_status DEFAULT 'active'::public.prescription_status NOT NULL
);


ALTER TABLE public.prescriptions OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33103)
-- Name: prescriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prescriptions_id_seq OWNER TO postgres;

--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 225
-- Name: prescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescriptions_id_seq OWNED BY public.prescriptions.id;


--
-- TOC entry 228 (class 1259 OID 33117)
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    sale_date timestamp without time zone NOT NULL,
    subtotal numeric(14,2) NOT NULL,
    total_taxes numeric(14,2) NOT NULL,
    total numeric(14,2) NOT NULL,
    status public.sale_status DEFAULT 'pending'::public.sale_status NOT NULL
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 33116)
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_id_seq OWNER TO postgres;

--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 227
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- TOC entry 218 (class 1259 OID 33065)
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    phone character varying(50),
    email character varying(120),
    address character varying(200)
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 33064)
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO postgres;

--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 217
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- TOC entry 222 (class 1259 OID 33085)
-- Name: taxes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxes (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    rate numeric(5,2) NOT NULL
);


ALTER TABLE public.taxes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33084)
-- Name: taxes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taxes_id_seq OWNER TO postgres;

--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 221
-- Name: taxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxes_id_seq OWNED BY public.taxes.id;


--
-- TOC entry 3343 (class 2604 OID 33133)
-- Name: batches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches ALTER COLUMN id SET DEFAULT nextval('public.batches_id_seq'::regclass);


--
-- TOC entry 3334 (class 2604 OID 33061)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 3336 (class 2604 OID 33077)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 3338 (class 2604 OID 33095)
-- Name: medicines id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines ALTER COLUMN id SET DEFAULT nextval('public.medicines_id_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 33151)
-- Name: medicines_prescriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_prescriptions ALTER COLUMN id SET DEFAULT nextval('public.medicines_prescriptions_id_seq'::regclass);


--
-- TOC entry 3346 (class 2604 OID 33168)
-- Name: medicines_sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales ALTER COLUMN id SET DEFAULT nextval('public.medicines_sales_id_seq'::regclass);


--
-- TOC entry 3347 (class 2604 OID 33190)
-- Name: medicines_sales_taxes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales_taxes ALTER COLUMN id SET DEFAULT nextval('public.medicines_sales_taxes_id_seq'::regclass);


--
-- TOC entry 3348 (class 2604 OID 33207)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 3339 (class 2604 OID 33107)
-- Name: prescriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions ALTER COLUMN id SET DEFAULT nextval('public.prescriptions_id_seq'::regclass);


--
-- TOC entry 3341 (class 2604 OID 33120)
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- TOC entry 3335 (class 2604 OID 33068)
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- TOC entry 3337 (class 2604 OID 33088)
-- Name: taxes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxes ALTER COLUMN id SET DEFAULT nextval('public.taxes_id_seq'::regclass);


--
-- TOC entry 3548 (class 0 OID 33130)
-- Dependencies: 230
-- Data for Name: batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batches (id, medicine_id, supplier_id, batch_code, expiration_date, current_stock, status) FROM stdin;
\.


--
-- TOC entry 3534 (class 0 OID 33058)
-- Dependencies: 216
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description) FROM stdin;
\.


--
-- TOC entry 3538 (class 0 OID 33074)
-- Dependencies: 220
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, document, name, phone, email, address) FROM stdin;
\.


--
-- TOC entry 3542 (class 0 OID 33092)
-- Dependencies: 224
-- Data for Name: medicines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicines (id, category_id, name, description, sale_price) FROM stdin;
\.


--
-- TOC entry 3550 (class 0 OID 33148)
-- Dependencies: 232
-- Data for Name: medicines_prescriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicines_prescriptions (id, medicine_id, prescription_id, quantity) FROM stdin;
\.


--
-- TOC entry 3552 (class 0 OID 33165)
-- Dependencies: 234
-- Data for Name: medicines_sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicines_sales (id, sale_id, medicine_id, batch_id, quantity, unit_price) FROM stdin;
\.


--
-- TOC entry 3554 (class 0 OID 33187)
-- Dependencies: 236
-- Data for Name: medicines_sales_taxes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicines_sales_taxes (id, medicines_sale_id, tax_id) FROM stdin;
\.


--
-- TOC entry 3556 (class 0 OID 33204)
-- Dependencies: 238
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, sale_id, method, amount_paid) FROM stdin;
\.


--
-- TOC entry 3544 (class 0 OID 33104)
-- Dependencies: 226
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescriptions (id, customer_id, issue_date, status) FROM stdin;
\.


--
-- TOC entry 3546 (class 0 OID 33117)
-- Dependencies: 228
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (id, customer_id, sale_date, subtotal, total_taxes, total, status) FROM stdin;
\.


--
-- TOC entry 3536 (class 0 OID 33065)
-- Dependencies: 218
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name, phone, email, address) FROM stdin;
\.


--
-- TOC entry 3540 (class 0 OID 33085)
-- Dependencies: 222
-- Data for Name: taxes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taxes (id, name, rate) FROM stdin;
\.


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 229
-- Name: batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.batches_id_seq', 1, false);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 215
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 219
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 1, false);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 223
-- Name: medicines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicines_id_seq', 1, false);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 231
-- Name: medicines_prescriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicines_prescriptions_id_seq', 1, false);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 233
-- Name: medicines_sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicines_sales_id_seq', 1, false);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 235
-- Name: medicines_sales_taxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicines_sales_taxes_id_seq', 1, false);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 237
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 225
-- Name: prescriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescriptions_id_seq', 1, false);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 227
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_seq', 1, false);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 217
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 1, false);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 221
-- Name: taxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxes_id_seq', 1, false);


--
-- TOC entry 3366 (class 2606 OID 33136)
-- Name: batches batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 33063)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 33083)
-- Name: customers customers_document_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_document_key UNIQUE (document);


--
-- TOC entry 3356 (class 2606 OID 33081)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 33097)
-- Name: medicines medicines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 33153)
-- Name: medicines_prescriptions medicines_prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_prescriptions
    ADD CONSTRAINT medicines_prescriptions_pkey PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 33170)
-- Name: medicines_sales medicines_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales
    ADD CONSTRAINT medicines_sales_pkey PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 33192)
-- Name: medicines_sales_taxes medicines_sales_taxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales_taxes
    ADD CONSTRAINT medicines_sales_taxes_pkey PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 33209)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 3376 (class 2606 OID 33211)
-- Name: payments payments_sale_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_sale_id_key UNIQUE (sale_id);


--
-- TOC entry 3362 (class 2606 OID 33110)
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 33123)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 33072)
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 33090)
-- Name: taxes taxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxes
    ADD CONSTRAINT taxes_pkey PRIMARY KEY (id);


--
-- TOC entry 3380 (class 2606 OID 33137)
-- Name: batches batches_medicine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_medicine_id_fkey FOREIGN KEY (medicine_id) REFERENCES public.medicines(id);


--
-- TOC entry 3381 (class 2606 OID 33142)
-- Name: batches batches_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- TOC entry 3377 (class 2606 OID 33098)
-- Name: medicines medicines_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 3382 (class 2606 OID 33154)
-- Name: medicines_prescriptions medicines_prescriptions_medicine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_prescriptions
    ADD CONSTRAINT medicines_prescriptions_medicine_id_fkey FOREIGN KEY (medicine_id) REFERENCES public.medicines(id);


--
-- TOC entry 3383 (class 2606 OID 33159)
-- Name: medicines_prescriptions medicines_prescriptions_prescription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_prescriptions
    ADD CONSTRAINT medicines_prescriptions_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES public.prescriptions(id);


--
-- TOC entry 3384 (class 2606 OID 33181)
-- Name: medicines_sales medicines_sales_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales
    ADD CONSTRAINT medicines_sales_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id);


--
-- TOC entry 3385 (class 2606 OID 33176)
-- Name: medicines_sales medicines_sales_medicine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales
    ADD CONSTRAINT medicines_sales_medicine_id_fkey FOREIGN KEY (medicine_id) REFERENCES public.medicines(id);


--
-- TOC entry 3386 (class 2606 OID 33171)
-- Name: medicines_sales medicines_sales_sale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales
    ADD CONSTRAINT medicines_sales_sale_id_fkey FOREIGN KEY (sale_id) REFERENCES public.sales(id);


--
-- TOC entry 3387 (class 2606 OID 33193)
-- Name: medicines_sales_taxes medicines_sales_taxes_medicines_sale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales_taxes
    ADD CONSTRAINT medicines_sales_taxes_medicines_sale_id_fkey FOREIGN KEY (medicines_sale_id) REFERENCES public.medicines_sales(id);


--
-- TOC entry 3388 (class 2606 OID 33198)
-- Name: medicines_sales_taxes medicines_sales_taxes_tax_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines_sales_taxes
    ADD CONSTRAINT medicines_sales_taxes_tax_id_fkey FOREIGN KEY (tax_id) REFERENCES public.taxes(id);


--
-- TOC entry 3389 (class 2606 OID 33212)
-- Name: payments payments_sale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_sale_id_fkey FOREIGN KEY (sale_id) REFERENCES public.sales(id);


--
-- TOC entry 3378 (class 2606 OID 33111)
-- Name: prescriptions prescriptions_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3379 (class 2606 OID 33124)
-- Name: sales sales_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2025-09-03 17:01:22

--
-- PostgreSQL database dump complete
--

