--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Homebrew)
-- Dumped by pg_dump version 14.13 (Homebrew)

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
-- Name: books; Type: TABLE; Schema: public; Owner: israanhayle
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    image character varying(255) NOT NULL,
    bookpdf character varying(255) NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE public.books OWNER TO israanhayle;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: israanhayle
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO israanhayle;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: israanhayle
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: completed; Type: TABLE; Schema: public; Owner: israanhayle
--

CREATE TABLE public.completed (
    id integer NOT NULL,
    users_id integer NOT NULL,
    book_id integer NOT NULL
);


ALTER TABLE public.completed OWNER TO israanhayle;

--
-- Name: completed_id_seq; Type: SEQUENCE; Schema: public; Owner: israanhayle
--

CREATE SEQUENCE public.completed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.completed_id_seq OWNER TO israanhayle;

--
-- Name: completed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: israanhayle
--

ALTER SEQUENCE public.completed_id_seq OWNED BY public.completed.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: israanhayle
--

CREATE TABLE public.favorites (
    id integer NOT NULL,
    users_id integer NOT NULL,
    book_id integer NOT NULL
);


ALTER TABLE public.favorites OWNER TO israanhayle;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: israanhayle
--

CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_id_seq OWNER TO israanhayle;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: israanhayle
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: israanhayle
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    image character varying(255) NOT NULL
);


ALTER TABLE public.genres OWNER TO israanhayle;

--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: israanhayle
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genres_id_seq OWNER TO israanhayle;

--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: israanhayle
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: reading; Type: TABLE; Schema: public; Owner: israanhayle
--

CREATE TABLE public.reading (
    id integer NOT NULL,
    users_id integer NOT NULL,
    book_id integer NOT NULL
);


ALTER TABLE public.reading OWNER TO israanhayle;

--
-- Name: reading_id_seq; Type: SEQUENCE; Schema: public; Owner: israanhayle
--

CREATE SEQUENCE public.reading_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reading_id_seq OWNER TO israanhayle;

--
-- Name: reading_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: israanhayle
--

ALTER SEQUENCE public.reading_id_seq OWNED BY public.reading.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: israanhayle
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO israanhayle;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: israanhayle
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO israanhayle;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: israanhayle
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: completed id; Type: DEFAULT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.completed ALTER COLUMN id SET DEFAULT nextval('public.completed_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: reading id; Type: DEFAULT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.reading ALTER COLUMN id SET DEFAULT nextval('public.reading_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: israanhayle
--

COPY public.books (id, title, author, image, bookpdf, genre_id) FROM stdin;
1	Big Dummy's Guide to the Internet	Electronic Frontier Foundation	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/%20Guide%20to%20the%20Internet.avif	https://www.gutenberg.org/cache/epub/118/pg118-images.htmll	1
2	How to Succeed as an Inventor	Goodwin Brooke Smith	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/How%20to%20Succeed%20as%20an%20Inventor.avif	https://www.gutenberg.org/cache/epub/46512/pg46512-images.html	1
3	Technology and Books for All 	Marie Lebert	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/technology%20for%20all.avif	https://www.gutenberg.org/cache/epub/27098/pg27098-images.html	1
4	How it Works	Archibald WilliamsS	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/How%20it%20Works.avif	https://www.gutenberg.org/cache/epub/28553/pg28553-images.html	1
5	Practical Mechanics for Boys	James Slough Zerbe	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Practical%20Mechanics%20for%20Boys.avif	https://www.gutenberg.org/cache/epub/22298/pg22298-images.html	1
6	The Invention of the Sewing Machine	Grace Rogers Cooper	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Invention%20of%20the%20Sewing%20Machine.avif	https://www.gutenberg.org/cache/epub/32677/pg32677-images.html	1
7	The Early History of the Airplane	Orville Wright and Wilbur	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Early%20History%20of%20the%20Airplane.avif	https://www.gutenberg.org/cache/epub/25420/pg25420-images.html	1
8	Opportunities in Engineering	Charles M. Horton	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Opportunities%20in%20Engineering.avif	https://www.gutenberg.org/cache/epub/24681/pg24681-images.html	1
9	On Growth and Form	D'Arcy Wentworth Thompson	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/On%20Growth%20and%20Form.avif	https://www.gutenberg.org/cache/epub/55264/pg55264-images.html	2
10	On the Origin of Species By Means of Natural Selection	Charles Darwin	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/On%20the%20Origin%20of%20Species%20By%20Means.avif	https://www.gutenberg.org/cache/epub/1228/pg1228-images.html	2
11	The Nature of Animal Light	E. Newton Harvey	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Nature%20of%20Animal%20Light.avif	https://www.gutenberg.org/cache/epub/34450/pg34450-images.html	2
12	The life of the bee	Maurice Maeterlinck	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/THE%20LIFE%20OF%20THE%20BEE.avif	https://www.gutenberg.org/cache/epub/4511/pg4511-images.html	2
13	The Animal Story Book	Andrew Lang and H. J. Ford	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Animal%20Story%20Book.avif	https://www.gutenberg.org/cache/epub/38208/pg38208-images.html	2
14	Anecdotes of the Habits and Instinct of Animals	Mrs. R. Lee	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Anecdotes%20of%20the%20Habits%20and%20Instinct%20of%20Animals.avif	https://www.gutenberg.org/cache/epub/21973/pg21973-images.html	2
15	Indian Natural History Sketches	Douglas Dewar	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Indian%20Natural%20History%20Sketches.avif	https://www.gutenberg.org/cache/epub/46318/pg46318-images.html	2
16	Myths and Legends of Alaska	Katharine Berry Judson	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Myths%20and%20Legends%20of%20Alaska.avif	https://www.gutenberg.org/cache/epub/47146/pg47146-images.html	2
17	Alice's Adventures in Wonderland	Lewis Carroll	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Alice%20s%20Adventures%20in%20Wonderland..avif	https://www.gutenberg.org/cache/epub/11/pg11-images.html	3
18	Grimms' Fairy Tales	Jacob Grimm and Wilhelm Grimm	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Grimms%20Fairy%20Tales.avif	https://www.gutenberg.org/cache/epub/2591/pg2591-images.html	3
19	A Christmas Carol	Charles Dickens	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/A%20Christmas%20Carol%20.avif	https://www.gutenberg.org/cache/epub/24022/pg24022-images.html	3
20	Adventures of Huckleberry Finn	Mark Twain	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Adventures%20of%20Huckleberry%20Finn.avif	https://www.gutenberg.org/cache/epub/76/pg76-images.html	3
21	Beethoven's Letters 1790-1826	Ludwig van Beethoven	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Beethoven''s%20Letters%201790-1826.avif	https://www.gutenberg.org/cache/epub/13065/pg13065-images.html	4
22	The Congo, and Other Poems	Vachel Lindsay	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Congo%2C%20and%20Other%20Poems.avif	https://www.gutenberg.org/cache/epub/1021/pg1021-images.html	4
23	The Letters of Wolfgang Amadeus Mozart	Wolfgang Amadeus Mozart	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Letters%20of%20Wolfgang%20Amadeus%20Mozart.avif	https://www.gutenberg.org/cache/epub/5307/pg5307-images.html	4
24	The Boy's Voice	J. Spencer Curwen	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Boys%20Voice.avif	https://www.gutenberg.org/cache/epub/32023/pg32023-images.html	4
25	The Phantom of the Opera	Gaston Leroux	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Phantom%20of%20the%20Opera.avif	https://www.gutenberg.org/cache/epub/175/pg175-images.html	4
26	Les adevineaux amoureux	Anonymous	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Les%20adevineaux%20amoureux.avif	https://www.gutenberg.org/cache/epub/57719/pg57719-images.html	5
27	A Romance of Nelson in the Year of the Nile	Sladen	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/A%20Romance%20of%20Nelson%20in%20the%20Year%20of%20the%20Nile.avif	https://www.gutenberg.org/cache/epub/47944/pg47944-images.html	5
28	Historische roman	Ludwig Rellstab	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Historische%20roman.avif	https://www.gutenberg.org/cache/epub/48216/pg48216-images.html	6
29	Michael Angelo Buonarroti	Charles Holroyd	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Michael%20Angelo%20Buonarroti.avif	https://www.gutenberg.org/cache/epub/19332/pg19332-images.html	7
30	The Sculpture and Mural Decorations of the Exposition	 Stella G. S. Perry	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Sculpture%20and%20Mural%20Decorations%20of%20the%20Exposition.avif	https://www.gutenberg.org/cache/epub/6631/pg6631-images.html	7
31	The Common Law	Oliver Wendell Holmes	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Common%20Law.avif	https://www.gutenberg.org/cache/epub/2449/pg2449-images.html	8
32	The Strange Case of Dr. Jekyll and Mr. Hyde	Robert Louis Stevenson	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Strange%20Case.avif	https://www.gutenberg.org/cache/epub/42/pg42-images.html	8
33	Southern Horrors: Lynch Law in All Its Phases	Ida B. Wells-Barnett	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Southern%20Horrors.avif	https://www.gutenberg.org/cache/epub/14975/pg14975-images.html	8
34	The Mysterious Affair at Styles	Agatha Christie	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Mysterious%20Affair%20at%20Styles.avif	https://www.gutenberg.org/cache/epub/863/pg863-images.html	8
35	On the Duty of Civil Disobedience	Henry David Thoreau	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/On%20the%20Duty%20of%20Civil%20Disobedience.avif	https://www.gutenberg.org/cache/epub/71/pg71-images.html	8
\.


--
-- Data for Name: completed; Type: TABLE DATA; Schema: public; Owner: israanhayle
--

COPY public.completed (id, users_id, book_id) FROM stdin;
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: israanhayle
--

COPY public.favorites (id, users_id, book_id) FROM stdin;
1	1	10
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: israanhayle
--

COPY public.genres (id, title, image) FROM stdin;
1	Technology	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/technology.avif
2	Science	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/science.avif
3	Children	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/children.avif
4	Music	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/music.avif
5	Romance	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/love.avif
6	History	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/History.avif
7	Fine arts	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Fine%20art.avif
8	Law	https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Law.avif
\.


--
-- Data for Name: reading; Type: TABLE DATA; Schema: public; Owner: israanhayle
--

COPY public.reading (id, users_id, book_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: israanhayle
--

COPY public.users (id, username, password) FROM stdin;
1	issoooo	$2b$10$y6kWPj2w3KES5Z2UECJl1.C1uazJlhaCQB7zLhsi.EuS1XCwHYNeW
2	sara	$2b$10$zsS/bTz97u0aoN0KTpoaeusRntYzjFt.sup5FcC/LF3O83fiuaPG.
\.


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: israanhayle
--

SELECT pg_catalog.setval('public.books_id_seq', 35, true);


--
-- Name: completed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: israanhayle
--

SELECT pg_catalog.setval('public.completed_id_seq', 1, false);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: israanhayle
--

SELECT pg_catalog.setval('public.favorites_id_seq', 1, true);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: israanhayle
--

SELECT pg_catalog.setval('public.genres_id_seq', 8, true);


--
-- Name: reading_id_seq; Type: SEQUENCE SET; Schema: public; Owner: israanhayle
--

SELECT pg_catalog.setval('public.reading_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: israanhayle
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: completed completed_pkey; Type: CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.completed
    ADD CONSTRAINT completed_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: reading reading_pkey; Type: CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.reading
    ADD CONSTRAINT reading_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: books books_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE CASCADE;


--
-- Name: completed completed_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.completed
    ADD CONSTRAINT completed_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: completed completed_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.completed
    ADD CONSTRAINT completed_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reading reading_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.reading
    ADD CONSTRAINT reading_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: reading reading_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: israanhayle
--

ALTER TABLE ONLY public.reading
    ADD CONSTRAINT reading_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
