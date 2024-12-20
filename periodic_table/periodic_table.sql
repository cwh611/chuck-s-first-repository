--
-- PostgreSQL database dump
--

-- Dumped from database version 14.14 (Homebrew)
-- Dumped by pg_dump version 14.14 (Homebrew)

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
-- Name: elements; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.elements (
    atomic_number integer NOT NULL,
    symbol character varying(2) NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE public.elements OWNER TO chuck;

--
-- Name: properties; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.properties (
    atomic_number integer NOT NULL,
    atomic_mass double precision NOT NULL,
    melting_point_celsius numeric NOT NULL,
    boiling_point_celsius numeric NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.properties OWNER TO chuck;

--
-- Name: types; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.types (
    type_id integer NOT NULL,
    type character varying(30) NOT NULL
);


ALTER TABLE public.types OWNER TO chuck;

--
-- Name: types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_type_id_seq OWNER TO chuck;

--
-- Name: types_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.types_type_id_seq OWNED BY public.types.type_id;


--
-- Name: types type_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.types ALTER COLUMN type_id SET DEFAULT nextval('public.types_type_id_seq'::regclass);


--
-- Data for Name: elements; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.elements (atomic_number, symbol, name) FROM stdin;
1	H	Hydrogen
4	Be	Beryllium
5	B	Boron
6	C	Carbon
7	N	Nitrogen
8	O	Oxygen
2	He	Helium
3	Li	Lithium
9	F	Fluorine
10	Ne	Neon
\.


--
-- Data for Name: properties; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) FROM stdin;
2	4.0026	-272.2	-269	1
6	12.011	3550	4027	1
7	14.007	-210.1	-195.8	1
8	15.999	-218	-183	1
3	6.94	180.54	1342	2
4	9.0122	1287	2470	2
5	10.81	2075	4000	3
1	1.008	-259.1	-252.9	1
9	18.998	-220	-188.1	1
10	20.18	-248.6	-246.1	1
\.


--
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.types (type_id, type) FROM stdin;
1	nonmetal
2	metal
3	metalloid
\.


--
-- Name: types_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.types_type_id_seq', 3, true);


--
-- Name: elements elements_atomic_number_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_atomic_number_key UNIQUE (atomic_number);


--
-- Name: elements elements_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (atomic_number);


--
-- Name: elements name_unique; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT name_unique UNIQUE (name);


--
-- Name: properties properties_atomic_number_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_atomic_number_key UNIQUE (atomic_number);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (atomic_number);


--
-- Name: elements symbol_unique; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT symbol_unique UNIQUE (symbol);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (type_id);


--
-- Name: properties properties_atomic_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_atomic_number_fkey FOREIGN KEY (atomic_number) REFERENCES public.elements(atomic_number);


--
-- Name: properties properties_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.types(type_id);


--
-- PostgreSQL database dump complete
--

