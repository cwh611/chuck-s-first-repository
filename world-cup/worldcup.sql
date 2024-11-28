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
-- Name: games; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    round character varying(50) NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.games OWNER TO chuck;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO chuck;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: chuck
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.teams OWNER TO chuck;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: chuck
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO chuck;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chuck
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.games (game_id, year, round, winner_id, opponent_id, winner_goals, opponent_goals) FROM stdin;
125	2018	Final	139	140	4	2
126	2018	Third Place	141	142	2	0
127	2018	Semi-Final	140	142	2	1
128	2018	Semi-Final	139	141	1	0
129	2018	Quarter-Final	140	143	3	2
130	2018	Quarter-Final	142	144	2	0
131	2018	Quarter-Final	141	145	2	1
132	2018	Quarter-Final	139	146	2	0
133	2018	Eighth-Final	142	147	2	1
134	2018	Eighth-Final	144	148	1	0
135	2018	Eighth-Final	141	149	3	2
136	2018	Eighth-Final	145	150	2	0
137	2018	Eighth-Final	140	151	2	1
138	2018	Eighth-Final	143	152	2	1
139	2018	Eighth-Final	146	153	2	1
140	2018	Eighth-Final	139	154	4	3
141	2014	Final	155	154	1	0
142	2014	Third Place	156	145	3	0
143	2014	Semi-Final	154	156	1	0
144	2014	Semi-Final	155	145	7	1
145	2014	Quarter-Final	156	157	1	0
146	2014	Quarter-Final	154	141	1	0
147	2014	Quarter-Final	145	147	2	1
148	2014	Quarter-Final	155	139	1	0
149	2014	Eighth-Final	145	158	2	1
150	2014	Eighth-Final	147	146	2	0
151	2014	Eighth-Final	139	159	2	0
152	2014	Eighth-Final	155	160	2	1
153	2014	Eighth-Final	156	150	2	1
154	2014	Eighth-Final	157	161	2	1
155	2014	Eighth-Final	154	148	1	0
156	2014	Eighth-Final	141	162	2	1
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: chuck
--

COPY public.teams (team_id, name) FROM stdin;
139	France
140	Croatia
141	Belgium
142	England
143	Russia
144	Sweden
145	Brazil
146	Uruguay
147	Colombia
148	Switzerland
149	Japan
150	Mexico
151	Denmark
152	Spain
153	Portugal
154	Argentina
155	Germany
156	Netherlands
157	Costa Rica
158	Chile
159	Nigeria
160	Algeria
161	Greece
162	United States
\.


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.games_game_id_seq', 156, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chuck
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 162, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chuck
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

