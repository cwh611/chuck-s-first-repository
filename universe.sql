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
-- Name: black_holes; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.black_holes (
    black_hole_id integer NOT NULL,
    name character varying(60) NOT NULL,
    solar_masses numeric,
    galaxy_id integer,
    distance_from_earth_ly numeric,
    scariness_one_to_ten integer
);


ALTER TABLE public.black_holes OWNER TO chuck;

--
-- Name: black_holes_black_hole_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.black_holes_black_hole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.black_holes_black_hole_id_seq OWNER TO chuck;

--
-- Name: black_holes_black_hole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.black_holes_black_hole_id_seq OWNED BY public.black_holes.black_hole_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    morphology text,
    effective_radius_kpc numeric,
    stellar_masses numeric,
    age_years_billions integer,
    where_i_live boolean
);


ALTER TABLE public.galaxy OWNER TO chuck;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO chuck;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    star_id integer NOT NULL,
    planet_id integer NOT NULL,
    diameter_km numeric,
    orbital_period_days numeric,
    name character varying(50) NOT NULL
);


ALTER TABLE public.moon OWNER TO chuck;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO chuck;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(50) NOT NULL,
    earth_masses numeric,
    diameter_km numeric,
    gravity numeric,
    has_life boolean
);


ALTER TABLE public.planet OWNER TO chuck;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO chuck;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    solar_masses numeric,
    solar_radii numeric,
    distance_from_earth_ly numeric,
    effective_temp_k numeric,
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO chuck;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO chuck;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: black_holes black_hole_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.black_holes ALTER COLUMN black_hole_id SET DEFAULT nextval('public.black_holes_black_hole_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: black_holes; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.black_holes (black_hole_id, name, solar_masses, galaxy_id, distance_from_earth_ly, scariness_one_to_ten) FROM stdin;
1	Sagittarius A	4000000	1	27000	10
2	M87	6500000000	7	55000000	10
3	TON 618	66000000000	\N	10400000000	10
\.


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.galaxy (galaxy_id, name, morphology, effective_radius_kpc, stellar_masses, age_years_billions, where_i_live) FROM stdin;
1	Milky Way	Spiral	15	150000000000	14	t
2	Andromeda	Spiral	20	120000000000	10	f
3	Triangulum	Spiral	5	5500000000	10	f
4	Sombrero	Lenticular	7	8000000000	10	f
5	Whirlpool	Spiral	10	5500000000	10	f
6	Large Magellanic Cloud	Irregular Dwarf Galaxy	5500	1000000000	14	f
7	Messier 87	Elliptical	20	2700000000000	13	f
\.


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.moon (moon_id, galaxy_id, star_id, planet_id, diameter_km, orbital_period_days, name) FROM stdin;
1	1	1	1	3474	27.3	The Moon
2	1	1	5	3643	1.8	Io
3	1	1	5	3121	3.5	Europa
4	1	1	5	5268	7.15	Ganymede
5	1	1	5	4821	16.7	Callisto
6	1	1	6	5151	15.9	Titan
7	1	1	6	1527	4.5	Rhea
8	1	1	8	2710	5.88	Triton
9	1	1	7	471.6	1.4	Miranda
10	1	1	6	396	0.9	Mimas
11	1	1	6	504.2	1.4	Enceladus
12	1	1	2	22.4	0.3	Phobos
13	1	1	2	12.4	1.3	Deimos
15	1	1	6	1472	79.3	Iapetus
16	1	1	6	1066	1.89	Tethys
17	1	1	6	1123	2.7	Dione
18	1	1	6	270	21.3	Hyperion
19	1	1	7	1159	2.5	Ariel
20	1	1	7	1169	4.1	Umbriel
21	1	1	7	1579	8.7	Titania
\.


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.planet (planet_id, star_id, galaxy_id, name, earth_masses, diameter_km, gravity, has_life) FROM stdin;
1	1	1	Earth	1	12742	9.81	t
2	1	1	Mars	0.107	6779	3.71	f
3	1	1	Venus	0.815	12104	8.87	f
4	1	1	Mercury	0.055	4880	3.7	f
5	1	1	Jupiter	318	139820	24.79	f
6	1	1	Saturn	95	116460	10.44	f
7	1	1	Uranus	14.5	50724	8.69	f
8	1	1	Neptune	17.2	49244	11.15	f
9	16	1	Proxima Centauri b	1.17	12742	10.8	f
10	17	1	Kepler 22b	7.2	30000	24.8	f
11	18	1	HD 209485 b	220	143000	9.3	f
12	19	1	Gliese 581b	3.1	16000	1.1	f
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.star (star_id, name, solar_masses, solar_radii, distance_from_earth_ly, effective_temp_k, galaxy_id) FROM stdin;
1	The Sun	1	1	0	5778	1
2	Sirius A	2.1	1.71	8.6	9940	1
3	Alpha Centauri A	1.1	1.22	4.37	5790	1
4	Alpheratz	2.4	3.6	97.8	10300	2
5	Mirach	1.2	2.4	200	4800	2
6	Almach	1.3	12.2	350	4330	2
7	Triangulum - Star 1	50	30	3000000	40000	3
8	Triangulum - Star 2	16	6.6	3000000	33000	3
9	Triangulum - Star 3	15	10	3000000	20000	3
10	Sombrero - Star 1	1.5	3.4	28000000	5500	4
11	Sombrero - Star 2	1.3	2.8	28000000	5400	4
12	Sombrero - Star 3	1.4	6.1	28000000	4700	4
13	Whirlpool - Star 1	20	10	23000000	50000	5
14	Whirlpool - Star 2	25	12	23000000	60000	5
15	Whirlpool - Star 3	30	20	23000000	40000	5
16	Proxima Centauri	0.12	0.15	4.24	3042	1
17	Kepler 22	0.97	0.98	620	5518	1
18	HD 209458	1.15	1.2	159	6092	1
19	Gliese 581	0.31	0.29	20.3	3480	1
\.


--
-- Name: black_holes_black_hole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.black_holes_black_hole_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.star_star_id_seq', 19, true);


--
-- Name: black_holes black_hole_id_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.black_holes
    ADD CONSTRAINT black_hole_id_pkey PRIMARY KEY (black_hole_id);


--
-- Name: black_holes black_holes_black_hole_id_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.black_holes
    ADD CONSTRAINT black_holes_black_hole_id_key UNIQUE (black_hole_id);


--
-- Name: black_holes black_holes_name_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.black_holes
    ADD CONSTRAINT black_holes_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_galaxy_id_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_id_key UNIQUE (galaxy_id);


--
-- Name: galaxy galaxy_id_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_id_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: moon moon_id_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_id_pkey PRIMARY KEY (moon_id);


--
-- Name: moon moon_moon_id_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_moon_id_key UNIQUE (moon_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: planet planet_id_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_id_pkey PRIMARY KEY (planet_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_planet_id_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_id_key UNIQUE (planet_id);


--
-- Name: star star_id_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_id_pkey PRIMARY KEY (star_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_star_id_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_id_key UNIQUE (star_id);


--
-- Name: star fkey_galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fkey_galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: planet fkey_galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fkey_galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon fkey_galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fkey_galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: black_holes fkey_galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.black_holes
    ADD CONSTRAINT fkey_galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon fkey_planet_id; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fkey_planet_id FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fkey_star_id; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fkey_star_id FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: moon fkey_star_id; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fkey_star_id FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

