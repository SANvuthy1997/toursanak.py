--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.9
-- Dumped by pg_dump version 9.5.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE alembic_version OWNER TO postgres;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE category (
    id integer NOT NULL,
    name character varying(100),
    slug character varying(100),
    is_menu integer
);


ALTER TABLE category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_id_seq OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE category_id_seq OWNED BY category.id;


--
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    email character varying(255),
    comment text,
    published_at timestamp without time zone DEFAULT now()
);


ALTER TABLE contact OWNER TO postgres;

--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contact_id_seq OWNER TO postgres;

--
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contact_id_seq OWNED BY contact.id;


--
-- Name: email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE email (
    id integer NOT NULL,
    email character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    published_at timestamp without time zone DEFAULT now()
);


ALTER TABLE email OWNER TO postgres;

--
-- Name: email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE email_id_seq OWNER TO postgres;

--
-- Name: email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE email_id_seq OWNED BY email.id;


--
-- Name: emailgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE emailgroup (
    id integer NOT NULL,
    email_id integer,
    group_id integer,
    published_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emailgroup OWNER TO postgres;

--
-- Name: emailgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE emailgroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emailgroup_id_seq OWNER TO postgres;

--
-- Name: emailgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE emailgroup_id_seq OWNED BY emailgroup.id;


--
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "group" (
    id integer NOT NULL,
    name character varying(255),
    published_at timestamp without time zone DEFAULT now()
);


ALTER TABLE "group" OWNER TO postgres;

--
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_id_seq OWNER TO postgres;

--
-- Name: group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE group_id_seq OWNED BY "group".id;


--
-- Name: member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE member (
    id integer NOT NULL,
    name character varying(50),
    slug character varying(50),
    feature_image character varying(300),
    possition character varying(300),
    detail character varying(1000),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE member OWNER TO postgres;

--
-- Name: member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE member_id_seq OWNER TO postgres;

--
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE member_id_seq OWNED BY member.id;


--
-- Name: page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE page (
    id integer NOT NULL,
    title character varying(255),
    slug character varying(255),
    description text,
    published_at timestamp without time zone DEFAULT now(),
    is_menu integer
);


ALTER TABLE page OWNER TO postgres;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE page_id_seq OWNER TO postgres;

--
-- Name: page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE page_id_seq OWNED BY page.id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE post (
    id integer NOT NULL,
    title character varying(255),
    description text,
    feature_image character varying(300),
    slug character varying(255),
    category_id integer,
    user_id integer,
    published_at timestamp without time zone DEFAULT now(),
    views integer,
    images text,
    price integer,
    date character varying(200),
    participants character varying(200),
    cost character varying(200)
);


ALTER TABLE post OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_id_seq OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE post_id_seq OWNED BY post.id;


--
-- Name: user_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_member (
    id integer NOT NULL,
    name character varying(50),
    email character varying(100),
    password character varying(600),
    password2 character varying(200),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE user_member OWNER TO postgres;

--
-- Name: user_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_member_id_seq OWNER TO postgres;

--
-- Name: user_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_member_id_seq OWNED BY user_member.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact ALTER COLUMN id SET DEFAULT nextval('contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY email ALTER COLUMN id SET DEFAULT nextval('email_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emailgroup ALTER COLUMN id SET DEFAULT nextval('emailgroup_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "group" ALTER COLUMN id SET DEFAULT nextval('group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member ALTER COLUMN id SET DEFAULT nextval('member_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY page ALTER COLUMN id SET DEFAULT nextval('page_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post ALTER COLUMN id SET DEFAULT nextval('post_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_member ALTER COLUMN id SET DEFAULT nextval('user_member_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY alembic_version (version_num) FROM stdin;
efa91ad1eabc
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY category (id, name, slug, is_menu) FROM stdin;
1	Blog	blog	0
2	Bicycle Tours	bicycle-tours	0
6	FAQ	faq	0
7	Upcoming Tour	upcoming-tour	0
8	Promotion	promotion	0
9	Discovery Tours	discovery-tours	0
4	Custom Tours	custom-tours	0
5	Family Trip Adventure 	family-trip-adventure	0
3	Development and Culture Program	development-and-culture-program	0
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('category_id_seq', 9, true);


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contact (id, firstname, lastname, email, comment, published_at) FROM stdin;
\.


--
-- Name: contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contact_id_seq', 1, false);


--
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY email (id, email, firstname, lastname, published_at) FROM stdin;
\.


--
-- Name: email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('email_id_seq', 1, false);


--
-- Data for Name: emailgroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY emailgroup (id, email_id, group_id, published_at) FROM stdin;
\.


--
-- Name: emailgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('emailgroup_id_seq', 1, false);


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "group" (id, name, published_at) FROM stdin;
\.


--
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('group_id_seq', 1, false);


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY member (id, name, slug, feature_image, possition, detail, created_at) FROM stdin;
1	San Vuthy	san-vuthy	20170901192520221938-20229365_755265874646288_4310884059345824620_n.jpg	Web Designer		2017-09-01 19:22:12.833539
6	Panha Suon	panha-suon	20170907141606313917-panha.jpg	Trip Leader	<p dir="ltr">Panha loves environment, biking and adventure.&nbsp;He lives by three life principles: being happy, healthy, and altruistic.&nbsp;Panha following his dream to become a national champion as a cyclist.</p>\r\n	2017-09-07 10:13:47.029466
4	Rithy Thul 	rithy-thul	20170912192319957941-telegram-cloud-file-5-852240528-125919--3789024113259431313.jpg	Promoter	<p dir="ltr">Rithy, a co-founder of Toursanak and Smallworld, enjoys exploring the provinces of Cambodia by bicycle.</p>\r\n\r\n<p dir="ltr">He has many great and inspired life experiences to share and learn from.&nbsp;His dream is to see young Cambodians startups their own business.</p>\r\n	2017-09-07 10:11:14.826231
3	Thavry Thon	thavry-thon	20170925143939331408-photo_2017-09-25_14-38-45.jpg	Managing Director	<p dir="ltr">Thavry joined Toursanak in 2013.&nbsp;She has experienced leading trips for over 5 years for PEPY, Wheretherebedragons and Ayana Journey.</p>\r\n\r\n<p dir="ltr">Her true passion is traveling, painting, and writing.&nbsp;Thavry is an author of a successful book Proper Woman</p>\r\n	2017-09-07 10:09:23.642651
2	Tom Hanak	tom-hanak	20170925143949612893-photo_2017-09-25_14-19-37.jpg	Project & Financial Manager	<p dir="ltr">Tom, a bicycle and nature lover, has joined Toursanak in 2017.</p>\r\n\r\n<p dir="ltr">His dream is to build up an eco-community and environmental education centre in Cambodia promoting a sustainable living.</p>\r\n	2017-09-07 10:08:36.384789
5	Chhet Vicheata	chhet-vicheata	20170928095330133047-Untitled_drawing_5.jpg	Customer Service & Trip Leader	<p dir="ltr">Chhet joined our team in 2017.&nbsp;Her positive, cheerful attitude is appreciated by our customers.&nbsp;She loves travelling and environment.</p>\r\n	2017-09-07 10:12:39.730095
\.


--
-- Name: member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('member_id_seq', 6, true);


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY page (id, title, slug, description, published_at, is_menu) FROM stdin;
1	about	about	<p><span style="font-size:26px"><strong><span style="color:#077849">T</span></strong></span><span style="font-size:16px">oursanak is an educational adventure travel experience with operations based in Phnom Penh and expanding outward.</span></p>\r\n\r\n<p><span style="font-size:16px">We provide new and interesting ways to experience the authentic Cambodia few others have the opportunity to see.</span></p>\r\n\r\n<p><span style="font-size:16px">Our programs are designed and planned to bring our participants up close and personal in Cambodia.</span></p>\r\n\r\n<p><span style="font-size:16px">We offer bicycle exploration tours, custom family tour and discovery tours in a mutually supportive setting where learning and discovery is an exchange between visitors and hosts.</span></p>\r\n\r\n<p><span style="font-size:16px">The tours are for institutions, groups and independent adventurers who want to explore hidden places and to learn about Cambodian culture.</span></p>\r\n	2017-09-01 19:02:14.421522	0
\.


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('page_id_seq', 1, true);


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY post (id, title, description, feature_image, slug, category_id, user_id, published_at, views, images, price, date, participants, cost) FROM stdin;
36	Pailin	<p>Explore Phnom Sompov and learn about destructive mining and logging practices.</p>\r\n		pailin	3	2	2017-10-11 19:48:56.295203	0		88	1 day	290 km - 5 hours away from Phnom Penh	
35	Battambang 	<p>Participate in an exchange program with local students, cycling and exploring the countryside of Battambang.<br />\r\nExplore the city by a bicycle or tuk tuk. Learn the truth about orphanage tourism in Cambodia, try the bamboo train and visit local natural caves.&nbsp;</p>\r\n\r\n<p><strong>Itinerary:</strong><br />\r\n<strong>Day 1:</strong> Exchange program with local students<br />\r\n<strong>Day 2: </strong>City exploration - Orphanage tourism educational tour<br />\r\n<strong>Day 3:</strong> Bamboo train - Caves visit<br />\r\n&nbsp;</p>\r\n		battambang	3	2	2017-10-11 19:46:58.936572	0		192	3 days & 2 nights	295 km - 5 hours away from Phnom Penh	
34	Siem Reap	<p>Explore Angkor complex and learn about the environmental and developmental challenges Tonle Sap lake faces.&nbsp;</p>\r\n\r\n<p><strong>Itinerary:</strong><br />\r\n<strong>Day 1:</strong> Angkor complex - Angkor Thom, Angkor Wat, Ta Prohm, Bayon by tuk tuk or a bicycle<br />\r\n<strong>Day 2:</strong> Tonle Sap lake educational tour - Floating village<br />\r\n&nbsp;</p>\r\n		siem-reap	3	2	2017-10-11 19:44:25.994235	0		150	2 days & 1 night	315 km - 6 hours away from Phnom Penh	
37	Koh Ksach Tunlea homestay	<p>Participate together with your host family in daily life activities such as farming, feeding and caring for livestock, fishing and harvesting practices. Learn Cambodian oral history and Khmer language directly from host families.&nbsp;<br />\r\n&nbsp;</p>\r\n		koh-ksach-tunlea-homestay	3	2	2017-10-11 19:49:48.603854	0		110	3 days & 2 nights	30 km - 1 hour away from Phnom Penh	
55	Traveling lightweight makes your life easier	<p dir="ltr"><strong>I am not so interested in bringing the makeup supplies, sometimes, I did not even comb my hair or wash my face, so there is no reasons to bring all of these stuffs. I like to travel light, carry less stuff. </strong></p>\r\n\r\n<p dir="ltr"><strong>I love to be minimalistic, carrying as light backpack as possible. </strong></p>\r\n\r\n<p dir="ltr"><strong>My backpack for 8 to 12 days trip weights from 3 to 4.5 kg. Every time I make sure all important things are packed. I don&rsquo;t bother with choosing what type clothes to bring, so it takes me about 20 minutes to pack my bag. The best is to sort things out into smaller bags and put those in the backpack. </strong></p>\r\n\r\n<p dir="ltr"><strong>Here as list of stuff I pack with myself:</strong></p>\r\n\r\n<ul>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>Mini first aid, in case I will have some stomach ache, temperature, or cut myself. </strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>An umbrella/rain jacket (during rainy season).</strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>My personal computer as I love to write, a power bank.</strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A toiletries bag (shampoo, conditioner, toothpaste, shower gel, sunscreen). All in mini bottles. </strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>T-shirts (3 or 4), a dress, 2 leggings, 2 undershirts , 3 underwears and one shirt.</strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A scarf that I can either use as a blanket, a towel or a hat. </strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A headlamp.</strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A sunglasses. </strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A notebook and a pen (sometimes my drawing book). </strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A book.</strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A water bottle (I don&rsquo;t want to pollute this world &nbsp;using so many plastic bottles. Better to have own). </strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A hipster (a belly- wallet design style, so I can wear it around my hips and no one knows that this is my hidden wallet.)</strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>A pair of shoes/ and two pairs of socks (depends on where I travel to).</strong></p>\r\n\t</li>\r\n\t<li dir="ltr">\r\n\t<p dir="ltr"><strong>Money, a passport and a copy of my passport (in case I lose the original).</strong></p>\r\n\t</li>\r\n</ul>\r\n\r\n<p><strong>As you see, they all fit into my carry-on luggage. &nbsp;</strong></p>\r\n	20171025092741434644-0.png	traveling-lightweight-makes-your-life-easier	1	4	2017-10-25 09:27:40.678653	0	20171025092741434644-4.png$$$$$20171025092741434644-12.png$$$$$20171025092741434644-untitledpp.png	0			
28	Crossing the border to Malaysia	<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">Bangkok has remained one of their favorite place, not because of the city itself, but the warm welcoming of locals. Three days New Year celebration with Thai people gave them unforgettable experience.</div>\r\n\r\n<div dir="ltr"><br />\r\nTheir next destination is Krabi, located in the Southwestern Thailand&rsquo;s coast. There are many sheer limestone cliffs, beautiful green water with more than hundred offshore islands. For those who love sea and swimming, Krabi will make you falling in love with it.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">A bus ride took about 12 hours from Bangkok. Afterwards, they found some cheap accommodation for $3 each. As this is a low budget trip, street food, in range between 30 to 35 bath (about $1) for a meal, is a great and surprisingly tasty choice.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">Krabi is an awesome place to relax, more costly than Phi Phi island. It is quite similar to Sihanoukville &nbsp;in Cambodia. Traveling makes you stronger, gives you skills to read people&rsquo;s mind, behaviour and forces you to solve problems alone or together with friends.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">A meal just for about $1, accommodation around $3 per night and transportation between $10 to $15. Why not to travel then? Sometimes, it is even cheaper to travel than living in Phnom Penh.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">When they were crossing a border from Thailand to Malaysia, immigration officer wanted to cheat on them, seeing Sela and his friend holding Cambodian passports. They were taken to the immigration office, unlike other travellers. They were asked to pay 200 bath each for a stamp and leave Thailand. Sela and his friends kept asking what is the money for? After a while, immigration officers felt annoyed and let them go.</div>\r\n	20170915154253088159-pcs_004-01.jpg	crossing-the-border-to-malaysia	1	2	2017-09-15 15:42:52.420897	1	20170915154253088159-pcs_002.jpg$$$$$20170915154253088159-pcs_004.jpg	0			
59	Rattanakiri Tour	<div>Trek through the forested jungle to find a hidden waterfall, observing the birds and wildlife while stopping off for lunch. Learn the facts of deforestation and how the forest has been changed forever. Visit a small remote jungle village where ethnic minority groups still live simple lives.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><strong>Itinerary:</strong></div>\r\n\r\n<div><strong>Day 1: </strong>Banlung exploration</div>\r\n\r\n<div><strong>Day 2:</strong> Waterfall trip - Cycling</div>\r\n\r\n<div><strong>Day 3:</strong> Cycling to YakLom lake</div>\r\n		rattanakiri-tour	5	2	2017-10-25 14:24:13.149514	0		265	3 days & 2 nights	Minivan - 8 hours away from Phnom Penh	$265
39	Islands of Mekong Bicycle Exploration	<p>Cycle to Silk Island to visit a silk farm and learn how silk is made by hand.</p>\r\n		islands-of-mekong-bicycle-exploration	5	2	2017-10-11 19:57:02.48932	0		137	1 day & 1 night 	35 km bicycle trip	
21	Family Trip Adventure 		20170907112215161065-Copy_of_IMG_2333.jpg	family-trip-adventure	4	2	2017-09-07 11:21:48.535166	0	20170907112148861668-Copy_of_IMG_2333.jpg	0			
41	Kratie homestay	<p>Visit and stay with a local family at Koh Trong to see famous dolphins.</p>\r\n		kratie-homestay	5	2	2017-10-11 20:12:15.912109	0		137	2 days & 1 night	Minivan - 5 hours away from Phnom Penh	
43	Rattanakiri	<p>Trek through the forested jungle to find a hidden waterfall, observing the birds and wildlife while stopping off for lunch. Learn the facts of deforestation and how the forest has been changed forever. Visit a small remote jungle village where ethnic minority groups still live simple lives.</p>\r\n\r\n<p><br />\r\n<strong>Itinerary:</strong><br />\r\n<strong>Day 1:</strong> Banlung exploration&nbsp;<br />\r\n<strong>Day 2: </strong>Waterfall trip - Cycling<br />\r\n<strong>Day 3:</strong> Cycling to YakLom lake<br />\r\n&nbsp;</p>\r\n		rattanakiri	3	2	2017-10-11 20:17:11.270857	0		265	3 days & 2 nights		
38	Kampot	<p>Help plant mangroves and learn about environmental issues affecting the fishery community coastal Cambodia.<br />\r\nExplore the nearby town, visit a pepper farm, secret lake and kayak on Kampot river.</p>\r\n\r\n<p><strong>Itinerary:</strong><br />\r\n<strong>Day 1:</strong> Fishery community - Kayaking&nbsp;<br />\r\n<strong>Day 2: </strong>Town exploration - Pepper farm - Secret lake<br />\r\n&nbsp;</p>\r\n		kampot	3	2	2017-10-11 19:51:00.54509	0		137	2 days & 1 night 	145km - 3 hours away from Phnom Penh	
56	Panha Suon :  Cycling 3500 KM with $350 [ Part 1 ]	<p dir="ltr"><strong>How many young Cambodians would dare to pursue their dreams? How many would go against the norms or even parents and do anything they want to?<br />\r\nCambodians respect elders and children, mostly, are expected to obey their parents. Traditionally, elders will always think their children are not mature enough to take care of themselves. And they should also follow the social norms. </strong></p>\r\n\r\n<p><strong>It is hard for parents to accept when their children are doing something different than others. Extreme cycling, solo traveling, running, or anything that is challenging. They would prefer their children to live a comfortable life. &nbsp;Honestly, is living in a comfort zone something anyone would want? What is spice of our life then?</strong></p>\r\n\r\n<p><strong>Panha Suon is a 20 years old Cambodian who challenges the norms and fights to do what he really loves. He loves cycling. Panhas dream is to become a national cyclist representing Cambodia at the Olympic games and other international competitions. Isn&rsquo;t it a big dream? </strong></p>\r\n\r\n<p dir="ltr"><strong>Panha decided to quit school and follow his dream. He thinks sitting in a classroom is a waste of his time and parents money. Real education should guide students according to their interest. Today&rsquo;s education system is not designed right way. &ldquo;I am not going to school to get a certificate or a degree just because in the future, I will have a good job. I think, I go to school, because I want to be educated, not to pursue the degree. The education should support my passion instead of studying this or that, and most of those assigned classes are not useful for our lives.&rdquo; - said Panha Suon. Education in broader understanding can be pursued in many different ways. </strong></p>\r\n\r\n<p><strong>The Internet is an amazing, revolutionary tool generations only have dreamed of. All the knowledge in your hand, in one device, accessible from anywhere and everywhere. Free course from sound universities, the biggest library in the world and much more. The whole new world. </strong></p>\r\n\r\n<p dir="ltr"><strong>It is only up to you, how you use internet. </strong></p>\r\n	20171025095212949284-P_20170227_075846.jpg	panha-suon-cycling-3500-km-with-350-part-1	1	4	2017-10-25 09:52:12.186566	0	20171025095212949284-P_20170310_130410.jpg$$$$$20171025095212949284-FB_IMG_1487972154461.jpg$$$$$20171025095212949284-P_20170226_111645.jpg	0			
57	Siem Reap Tour	<p>Exploring the Angkor Temples by bicycle, enjoy a Khmer cooking class, visit the butterfly garden, a circus show and much more.</p>\r\n\r\n<p><strong>Itinerary:</strong><br />\r\n<strong>Day 1:</strong> Cycling to Angkor temples - Circus night&nbsp;<br />\r\n<strong>Day 2:</strong> Kbal Spean visit - Trekking - Banteay Srey temple - Butterfly garden// minivan<br />\r\n<strong>Day 3:</strong> Cooking class - Floating village<br />\r\n&nbsp;</p>\r\n		siem-reap-tour	5	2	2017-10-25 14:20:02.825839	0		285	3 days & 2 nights	Minivan - 6 hours away from Phnom Penh	$285
49	Sangamon trip 2017: Explore an ancient land [Part 2]	<p dir="ltr"><strong>It was a long day on the bus to an ancient city of Cambodia, Siem Reap. The group was very energetic and funny. Shortly after arriving in Siem Reap, some students went to enjoy a hotel swimming pool. </strong></p>\r\n\r\n<p><strong>The group was excited about Angkor Wat and agreed to wake up at 4am to see dawn. They had a chance to explore and learn about history of Angkor complex, Bayon, and Ta Prohm. The following day they went to Kulen Mountain to swim at waterfalls. </strong></p>\r\n\r\n<p><strong>On the way back, there was a stop at the Landmines Museum -- &ldquo;an impact during the war. There were many Cambodian died, children became an orphan, many people become a disable. Most part of Cambodia was covered by the mines after the war.&rdquo;</strong></p>\r\n\r\n<p><strong>Next day they explored a floating village and stopped at Kampong Phluk Village port taken a boat into Tonle Sap. The group visited Pagna Cambodian Education Foundation, providing free English classes for poor children in the village. It was pleasant to speak with the local kid and sing with them.</strong></p>\r\n\r\n<p><strong>It was an eye-opening experience. Coming to a land that is a thousands miles far from their home to learn and immerse different cultures. A life changing experience, indeed. </strong></p>\r\n\r\n<p><br />\r\n&nbsp;</p>\r\n	20171024094410837472-IMG_1770.JPG	sangamon-trip-2017-explore-an-ancient-land-part-2	1	4	2017-10-24 09:44:09.371743	0	20171024094410837472-IMG_1141.JPG$$$$$20171024094410837472-IMG_8826.JPG$$$$$20171024094410837472-IMG_1303.JPG$$$$$20171024094410837472-IMG_1296.JPG$$$$$20171024094410837472-IMG_1283.JPG$$$$$20171024095253190846-IMG_9149.JPG$$$$$20171024095253190846-IMG_9112.JPG	0			
22	Development and Culture Program		20170907114942987683-Copy_of_IMG_7735.jpg	development-and-culture-program	4	2	2017-09-07 11:49:41.775885	1		0			
44	Mondulkiri 	<p>Explore the mountain areas and what has become known as the &quot;Cambodian Switzerland&quot;.</p>\r\n\r\n<p><br />\r\n<strong>Itinerary:</strong><br />\r\n<strong>Day 1:</strong> Trekking<br />\r\n<strong>Day 2:</strong> Waterfall trip - Strawberry farm</p>\r\n		mondulkiri	5	2	2017-10-11 20:18:08.258437	0		195	2 days & 1 night		
48	Sangamon trip 2017: Overwhelming moment but exciting! [Part 1]	<p dir="ltr"><strong>Even though July is a rainy season in Cambodia, Sangamon Camp loves that period. Every year new students are sent to learn, discover and explore the best of Cambodia. </strong></p>\r\n\r\n<p><strong>This year, there were 11 students, 3 camp leaders and Toursanak team as a local guide. It is a bit overwhelming when they first arrived at the airport, realizing many things are different from their homelands. Busy streets, motorbikes everywhere, tuk tuk rolling on the streets and the heat. Yet, they were every excited about the new upcoming 15-day-adventure ahead of them. </strong></p>\r\n\r\n<p dir="ltr"><strong>Tousanak Team provided an orientation session, explaining Cambodian culture and social norms, safety tips, local food and habits. The following day, the group explored the island of the Mekong. It was a splendid tuk-tuk trip with countless hello and smiles. Students learned about the process of creating silk and explored the beautiful countryside.</strong></p>\r\n\r\n<p><strong>After they visited main landmarks of Cambodia such as Royal Palace, the S-21 and Killing fields. The group learned a lot about Cambodian culture, history, society, issues locals are facing, and the way people live here. </strong></p>\r\n\r\n<p><br />\r\n<br />\r\n&nbsp;</p>\r\n	20171024092429081024-20108484_10155194517675100_7431353539924665664_n.jpg	sangamon-trip-2017-overwhelming-moment-but-exciting-part-1	1	4	2017-10-24 09:21:28.835487	0	20171024092429081024-19990036_10209792405862001_1572446449478286012_n.jpg$$$$$20171024092429081024-IMG_1019.JPG$$$$$20171024092429081024-20046461_10209797313624692_3804990171876449151_n.jpg$$$$$20171024092429081024-19059668_10209797313184681_8156507749652634692_n.jpg	0			
40	Koh Ksach Tunlea homestay - Free The Bears Project - Kep & Kampot	<p><strong>Koh Ksach Tunlea homestay - 1 hour by minivan from Phnom Penh</strong>&nbsp;Stay with your local host family to learn about recent Cambodian history and the way if affects contemporary culture. Experience farming, fishing, everyday chores and a little bit of the Khmer language.<br />\r\nFree The Bears Project - bicycle - 30 km from Koh Ksach Tunlea&nbsp;<br />\r\nLearn about Cambodian wildlife in an enjoyable way, visit an educational center for youth, and explore a small zoo to feed the bears.&nbsp;</p>\r\n\r\n<p><strong>Kep &amp; Kampot - bicycle - 140 km&nbsp;</strong><br />\r\nExplore the beauty of coastal Cambodia, paddle board along the Kampot river, visit Bokor mountain and go trekking in the Kep National Park.</p>\r\n\r\n<p><strong>Itinerary:</strong><br />\r\n<strong>Day 1:</strong> Koh Ksach Tunlea homestay - Bicycle journey around island&nbsp;<br />\r\n<strong>Day 2:</strong> Homestay activities<br />\r\n<strong>Day 3:</strong> Departing homestay - Cycling to Free the Bears Project - Educational Program - Cycling to Kep<br />\r\n<strong>Day 4:</strong> Kep bicycle exploration - Trekking at national park &nbsp;- Cave visit<br />\r\n<strong>Day 5:</strong> Bokor mountain - Tapeang Sangke fishery community - Paddle boarding<br />\r\n<strong>Day 6:</strong> Kampot cycling - Salt Farm - Pepper Farm - Boat Tour<br />\r\n&nbsp;</p>\r\n		koh-ksach-tunlea-homestay-free-the-bears-project-kep-kampot	5	2	2017-10-11 19:58:55.665518	0		750	6 days & 5 nights 		
23	What if I have special requests?	<p>We do our best to satisfy our clients. Please if you have any special request, don&rsquo;t hesitate to email us.</p>\r\n		what-if-i-have-special-requests	6	2	2017-09-07 16:38:29.910817	0		0			
60	Panha Suon: A successful  journey of 3500 KM  [The end]	<p dir="ltr"><strong>It is not common to break free from parents in Cambodia, like Panha does. He is passionate about cycling and solo long distance bicycle touring. On top of that, he wants to learn about new cultures and meet new people than just stay home.</strong></p>\r\n\r\n<p><strong>Panha had decided to follow his dream to cycle from Phnom Penh to Chiang Rai, Thailand.</strong></p>\r\n\r\n<p dir="ltr"><strong>The main goal was to meet and learn from a former French professional road cyclist living there. </strong></p>\r\n\r\n<p><strong>The dream of becoming a professional cyclist was his biggest motivation. Living his life to the fullest, enjoying to do things he loves are important values for him. &ldquo;I don&rsquo;t want to live the life of regret if I really want to something I am passionate about, then I should be brave enough to do it.&rdquo;</strong></p>\r\n\r\n<p><strong>Panha spent only $350 ($100 out of $350 spent on bicycle service and maintenance) on his &nbsp;48 days trip.</strong></p>\r\n\r\n<p><strong>There were many challenges. A pressure of seeing his mother crying when she was told about his upcoming journey. She wanted Panha to go back to Phnom Penh to take care of his sick dad. Part of him wanted to go back, but his passion kept pushing him forward. It was one of the most difficult moments. </strong></p>\r\n\r\n<p><strong>Along his journey, Panha learned so many things. He has noticed Thailand has better environmental awareness and understanding of this issue. </strong></p>\r\n\r\n<p dir="ltr"><strong>Panha&rsquo;s trip was about amazing 3500 km. His advice to people who really want to travel but still can&rsquo;t decide -- &ldquo; You don&#39;t need so much money to travel, there are a lot of people who have done that. You just need some money with yourself, but along the way you will enjoy your trip and meet some amazing people who would be happy enough to be your friends. Or if you travel on the bike, you can do camping, there are &nbsp;some website that host cyclists in big cities such as <a href="https://www.warmshowers.org/">warmshower</a>, <a href="http://wwoof.net/">WWOOF</a> </strong></p>\r\n\r\n<p dir="ltr"><strong>What you need is food and drink. If you want to travel don&rsquo;t let money stop you from doing that, you can just do it!&rdquo;- Panha Suon</strong></p>\r\n	20171026154226040036-Panha1.png	panha-suon-a-successful-journey-of-3500-km-the-end	1	4	2017-10-26 15:42:24.886195	0	20171026154226040036-Panha.png$$$$$20171026154226040036-Panha2.png$$$$$20171026154226040036-Panha3.png	0			
14	Village Homestay Bicycle Tour	<div dir="ltr">Cycle with us to Koh Ksach Tonlea or &quot;Widows Island,&quot; a small agricultural island 35km south of Phnom Penh.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">Stay with local host family and leisurely ride a bicycle around the island, play volleyball with villagers and canoe along Basak river.&nbsp;Get to know more about climate change impact on the villagers. Farmers will show you how they make a living growing plants, raising animals or making mattresses.&nbsp;Enjoy delicious Khmer food with the community, and learn to make some Khmer dishes.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong><span style="color:#077849">ITINERARY</span></strong></div>\r\n\r\n<div dir="ltr"><strong>Day 1:</strong> Depart Phnom Penh - Arrive Koh Ksach Tunlea, Widows island - Tour around Island</div>\r\n\r\n<div dir="ltr"><strong>Day 2:</strong> Visiting Mattress Makers - Canoeing along Bassac river - Cooking Khmer foods - Community exploration</div>\r\n\r\n<div dir="ltr"><strong>Day 3:</strong> Farewell lunch with the host family - Depart Phnom Penh</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong><span style="color:#077849">STANDART INCLUDES AND EXCLUDES</span></strong></div>\r\n\r\n<div><strong>Includes</strong></div>\r\n\r\n<div>- Accommodations</div>\r\n\r\n<div>- Meals and transportation</div>\r\n\r\n<div>- Entrance fees</div>\r\n\r\n<div>- English speaking trip leaders</div>\r\n\r\n<div>- Mountain bike, panniers and&nbsp;helmet</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><strong>Excludes</strong></div>\r\n\r\n<div>- Insurance</div>\r\n\r\n<div>- Alcohol &amp; soft drinks</div>\r\n\r\n<div>- Personal expenses</div>\r\n\r\n<div>- Tips &amp; gratuities</div>\r\n	20170906222348722428-IMG_1334.JPG	village-homestay-bicycle-tour	2	2	2017-09-06 22:23:48.399033	107	20170907160059342965-Copy_of_IMG_0466.jpg$$$$$20170907160059342965-Copy_of_IMG_0578.jpg$$$$$20170907160059342965-Copy_of_IMG_0690.jpg$$$$$20170907160059342965-Copy_of_IMG_0706.jpg$$$$$20170907160059342965-Copy_of_IMG_0878.jpg$$$$$20170907160059342965-Copy_of_IMG_0980.jpg$$$$$20170907160059342965-Copy_of_IMG_0989.jpg	119	3 days & 2 nights	2 min / 16 max	$119 per person / 10 or more, less 10%
13	Southern Cambodia Bicycle Tour	<div>Step out of your comfort zone!&nbsp;Cycle and explore southern Cambodia with us.&nbsp;In Phnom Penh our mountain bikes are prepared in advance.&nbsp;</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div>On our first day out, we cycle to Takeo for a comfy overnight.&nbsp;We&rsquo;re challenged along the way, but we&rsquo;re exploring, relaxing, and having fun.&nbsp;Support is provided for all of your needs, and you can ride along if you&rsquo;re tired.&nbsp;The rural nightlife of the Cambodian people will begin to come alive for you.&nbsp;See and hear how traditional Buddhist culture influences our Khmer roots.</div>\r\n\r\n<div><br />\r\nThe next day brings us to Kep, where bountiful and delicious dinners will be enjoyed for plenty of fresh seafood protein.&nbsp;Take a boat to Rabbit Island where we enjoy the white sands beach for swimming.&nbsp;Each night is a delight, as we snuggle up in comfortable and elegant grass roof bungalows.&nbsp;Next day we will leave to Kampot, exploring the secret lake, a natural cave, a fishery community, and learn about environmental projects.&nbsp;Enjoy the fresh air and wild Kampot river with a stand-up paddleboard adventure.</div>\r\n\r\n<div>The next day we&rsquo;ll catch a bus back to Phnom Penh for more fun and food.&nbsp;</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><strong><span style="color:#077849">ITINERARY</span></strong><br />\r\n<strong>Day 1:</strong> Depart Phnom Penh - Arrive Takeo - 80 km<br />\r\n<strong>Day 2:</strong> Depart Takeo - Arrive Kep (Crab Market) - 100 km<br />\r\n<strong>Day 3:</strong> Depart Kep - Arrive Rabbit Island - 20 minutes by boat &nbsp;<br />\r\n<strong>Day 4:</strong> Depart Rabbit Island - Arrive Kampot &nbsp;or Kampot Exploration - 25 km<br />\r\n<strong>Day 5:</strong> Secret Lake - Pepper Farm - Cave - Fishery Community - Paddle Board<br />\r\n<strong>Day 6:</strong> Depart Kampot - Arrive Phnom Penh - 3 to 4 hours by bus&nbsp;</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><strong><span style="color:#077849">STANDARD INCLUDES AND EXCLUDES</span></strong></div>\r\n\r\n<div><strong>Includes</strong></div>\r\n\r\n<div dir="ltr">- Accommodations</div>\r\n\r\n<div dir="ltr">- Meals and transportation</div>\r\n\r\n<div dir="ltr">- Entrance fees</div>\r\n\r\n<div dir="ltr">- English speaking trip leaders</div>\r\n\r\n<div dir="ltr">- Mountain bike, panniers, helmet and paddle board</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong>Excludes</strong></div>\r\n\r\n<div dir="ltr">- Insurance</div>\r\n\r\n<div dir="ltr">- Alcohol &amp; soft drinks</div>\r\n\r\n<div dir="ltr">- Personal expenses</div>\r\n\r\n<div dir="ltr">- Tips &amp; gratuities</div>\r\n	20170906220637331531-Copy_of_IMG_2118.jpg	southern-cambodia-bicycle-tour	2	2	2017-09-06 22:02:22.654283	102		399	6 days & 5 nights	2 min / 10 max	$ 399 per person / 5 or more, less 10%
50	Sangamon trip 2017: Homestay in Koh Ksach Tunlea  [Part 3]	<p dir="ltr"><strong>Half of the trip was behind us. From today onward the students change a comfortable bed for a simple mattress in a wooden rural house. It took 10 hours from Siem Reap to a homestay in Saang district, Kandal province. The group was welcomed by their host families. </strong></p>\r\n\r\n<p><strong>The village homestay offers to learn how locals live, about their culture, language and habits. To enhance students&rsquo; knowledge, Toursanak team held a session about a teenager&rsquo;s life on the island. </strong></p>\r\n\r\n<p><strong>The first teenager participant &nbsp;was a girl who had dropped out of school at the age of 14. She decided to work at the factory in Phnom Penh. Her dream of becoming a doctor had never been fulfilled, as taking care of her family was a priority. </strong></p>\r\n\r\n<p dir="ltr"><strong>The second teenager participant was a 15 years old boy who quitted school at grade 6. He was illiterate. Unfortunately, Cambodian educational system has long way to go to become sufficient. </strong></p>\r\n\r\n<p><strong>The group learned how lucky they are being able to study and pursue a good education. They all were grateful to their parents that they don&#39;t have to quit school and find a job like the two teenagers in the village. </strong></p>\r\n\r\n<p><strong>The following day, the students met Khmer Rouge survivors; a grandmother who got married during the war by the Khmer Rouge order and a man used to be a Khmer Rouge child soldier. He was sent far from home at the age of 11, but managed to survive and returned back home after 2 years, in 1980. </strong></p>\r\n\r\n<p><strong>Board games, volleyball and footballs were popular activities among the students during their free time at the village. All together, we explored the island by a bicycle and helped locals to harvest their vegetable. &nbsp;</strong></p>\r\n\r\n<p><strong>The village homestay had given them so much to learn. They would never experienced that in their homelands. After this part of the trip, they all could understand the daily struggles of the locals. </strong></p>\r\n\r\n<p dir="ltr">&nbsp;</p>\r\n	20171024100118143134-IMG_1333.JPG	sangamon-trip-2017-homestay-in-koh-ksach-tunlea-part-3	1	4	2017-10-24 10:01:16.882687	0	20171024100118143134-IMG_20170725_152630.jpg$$$$$20171024100118143134-IMG_20170724_083516.jpg$$$$$20171024100118143134-IMG_20170726_075401.jpg$$$$$20171024100118143134-IMG_20170725_202657.jpg$$$$$20171024100118143134-IMG_20170726_081052.jpg	0			
53	Camping on top of the world	<p dir="ltr"><strong>Although September is rainy, we wanted to escape noisy and dusty Phnom Penh. &nbsp;Our group of six people were longing for an overnight camping on top of Phnom Pdach Jevith mountain located in Kirirom national park. </strong></p>\r\n\r\n<p dir="ltr"><strong>After arriving at Kirirom roundabout, we hiked around 10 km up to Phnom Pdach Jevith mountain. It was a pleasant hike with few steep parts near the peak. It took us about 3 hours including water breaks. </strong></p>\r\n\r\n<p><strong>We arrived at the top around 2PM. Pure jungle, fresh air and quietness were surrounding us. After lunch on the top of the world we started setting up our tents, enjoying blow-minded view at green ocean and fluffy clouds floating below us. </strong></p>\r\n\r\n<p dir="ltr"><strong>Late September breeze was chilling our skins while we were cooking rice. </strong></p>\r\n\r\n<p dir="ltr"><strong>In the evening we eat grilled fish and sat around a bonfire, wearing jumpers protecting us from cooler weather. The feeling of a freedom was so amazing. At night, the temperature went down to 15 ℃. Honestly, we did not expect that.</strong></p>\r\n\r\n<p><strong>In the morning, we packed our tents and went back through a foggy forest. Perfect weather for such hike. </strong></p>\r\n\r\n<p><strong>We will return to this paradise. </strong></p>\r\n\r\n<p><br />\r\n<br />\r\n&nbsp;</p>\r\n	20171024111621798509-HIIG5526.jpg	camping-on-top-of-the-world	1	4	2017-10-24 11:16:21.418411	0	20171024111621798509-1.jpg$$$$$20171024111621798509-p1.jpg$$$$$20171024111621798509-photo_2017-10-17_09-17-14.jpg$$$$$20171024111621798509-photo_2017-10-17_09-17-01.jpg$$$$$20171024111621798509-photo_2017-10-17_09-16-58.jpg$$$$$20171024111621798509-photo_2017-09-24_21-09-55.jpg$$$$$20171024111621798509-photo_2017-10-13_15-42-03.jpg$$$$$20171024111621798509-photo_2017-09-26_02-45-56.jpg	0			
51	Sangamon trip 2017: Trip in Rabbit Island [Part 4]	<p dir="ltr"><strong>The ride from the homestay to the Rabbit island took us about 4 hours. We were expected to be on the island by 2PM for lunch and enjoying the swimming, but everything did not turn out right. As soon as we arrived at a port, there was a big rain storm and we were not allowed to cross the sea. </strong></p>\r\n\r\n<p><strong>Everyone was so hungry and we got to eat what we brought along with us. We had some chips, mango jam and we bought some steam corn.</strong></p>\r\n\r\n<p><strong>One hour later,raining stopped and we took a boat to the island. </strong></p>\r\n\r\n<p dir="ltr"><strong>Some students were nervous and some were enjoying the waves.</strong></p>\r\n\r\n<p dir="ltr"><strong>After arriving at the island, we had an amazing seafoods for our lunch. Relaxation, massage or &nbsp;reading a book &nbsp;in a hammock were well deserved treats. &nbsp;</strong></p>\r\n\r\n<p><strong>Next day, some of students preferred to play games and read &nbsp;a book on the beach. The rest wanted to trek around the island. It was a splendid walk although we got lost few times the path was muddy sometimes. However, we decided to go along the sea, and finally, we did the loop. Each one of them got a reward of a fresh coconut drink at a local shop. &nbsp;</strong></p>\r\n\r\n<p><strong>They enjoyed the time on Rabbit island. </strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p dir="ltr">&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n	20171024101336878419-20292989_10213817321693824_5075636184899278898_n.jpg	sangamon-trip-2017-trip-in-rabbit-island-part-4	1	4	2017-10-24 10:13:34.940645	0	20171024101336878419-IMG_20170728_103100.jpg$$$$$20171024101336878419-20374737_10213817323333865_3036321076910319715_n.jpg$$$$$20171024101336878419-IMG_1462.JPG$$$$$20171024101336878419-IMG_20170727_114100_1.jpg$$$$$20171024101336878419-20376072_10213817320693799_7927316300030165302_n.jpg$$$$$20171024101336878419-20292649_10213817323293864_114142541875268603_n.jpg$$$$$20171024101336878419-IMG_20170727_092943.jpg	0			
52	Sangamon trip 2017: Explore the beauty of Kampot [Part 5]	<p dir="ltr"><strong>Kampot was our last destination of our trip. We had only four days left and stayed at the Trapeang Sangke fishery community. The community is doing a great work to protect a mangrove forest. </strong></p>\r\n\r\n<p dir="ltr"><strong>Its leader, Mr. SIM HIM, shared with us how and why the community was founded in 2009. There are almost 3000 members now. Before the foundation, there were so many illegal fishing land abusing cases. Some fishermen stood up to protect the mangrove. They decided to plant the mangrove trees and pick up the seeds to grow another ones.</strong></p>\r\n\r\n<p><strong>The students had some down times and we took Romok (a giant tuk tuk) to explore Kampot town. The next day we explored Kampot river with a kayak, and enjoyed dinner with a beautiful sunset. </strong></p>\r\n\r\n<p><strong>Bokor Mountain was one of the last place we visited before going back to Phnom Penh. It was raining and foggy along the way, hard to see anything. </strong></p>\r\n\r\n<p><strong>The last farewell dinner was at Friends International with Smallworld people. The following day, we asked them to pack everything ready to go by 9AM and there was the last surprise, movie time. They were very excited. &nbsp;<br />\r\n<br />\r\nOur last ceremony was The Stone Ceremony where everyone say something unique about another person. It was very nice to hear how much they had learned and how much fun they had had together.</strong></p>\r\n	20171024111115572659-Copy_of_IMG_1530.JPG	sangamon-trip-2017-explore-the-beauty-of-kampot-part-5	1	4	2017-10-24 11:11:14.149472	0	20171024111115572659-IMG_1612.JPG$$$$$20171024111115572659-IMG_20170729_095033.jpg$$$$$20171024111115572659-IMG_1633.JPG$$$$$20171024111115572659-IMG_20170728_160408.jpg$$$$$20171024111115572659-IMG_1679.JPG	0			
18	Kampot and Bokor Mountain Discovery	<div dir="ltr">Have you considered exploring Kampot? Kampot is such a beautiful and quiet place, and a special place to visit for both visitors and locals. Join along and let us be your guide as we explore the amazing sights and outdoor activities in Kampot province.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">On this tour we&rsquo;ll explore the natural environment as we find ourselves in unexpected places along the way by a bus. We&rsquo;ll stay for a while at a fishing community, lending a helping-hand as we learn about the mangrove tree reserve growing along the ocean water coastline.</div>\r\n\r\n<div dir="ltr">The mangrove fishing village is a community-based project which grew out of the villagers stand against rich and powerful influences who were attempting to gain control over their land for profit. We&rsquo;ll learn about the local ecosystem, as well as the needs and sensitive issues affecting this small and fragile community.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">In addition, we&rsquo;ll spend a day exploring Bokor mountain, enjoying beautiful and historic scenery, including a waterfall hidden among the natural mountain environment. In the evening after coming down from the mountain, we&rsquo;ll enjoy a cool and quiet boat ride at sunset along the majestic Kampot river.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>ITINERARY</strong></span></div>\r\n\r\n<div dir="ltr"><strong>Day 1:</strong> Depart Phnom Penh - Arrive Kampot - 3 hours</div>\r\n\r\n<div dir="ltr"><strong>Day 2:</strong> Boat trip to the sea - Mangrove tree plantation - Pepper plantation - Cave visit</div>\r\n\r\n<div dir="ltr"><strong>Day 3:</strong> Bokor mountain &amp; waterfall - Sunset boat on Kampot river</div>\r\n\r\n<div dir="ltr"><strong>Day 4:</strong> Farewell lunch - Depart Phnom Penh - 2 to 3 hours by bus</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>STANDART INCLUDES AND EXLUDES</strong></span></div>\r\n\r\n<div><strong>Includes</strong></div>\r\n\r\n<div dir="ltr">- Accommodations</div>\r\n\r\n<div dir="ltr">- Meals and transportation</div>\r\n\r\n<div dir="ltr">- Entrance fees</div>\r\n\r\n<div dir="ltr">- English speaking trip leaders</div>\r\n\r\n<div dir="ltr">- Paddle board and kayak fees</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong>Excludes</strong></div>\r\n\r\n<div dir="ltr">- Insurance</div>\r\n\r\n<div dir="ltr">- Alcohol &amp; soft drinks</div>\r\n\r\n<div dir="ltr">- Personal expenses</div>\r\n\r\n<div dir="ltr">- Tips &amp; gratuities</div>\r\n	20170913141600990620-IMG_20170728_160408_1.jpg	kampot-and-bokor-mountain-discovery	9	2	2017-09-07 10:28:52.87553	105	20170907104506813714-IMG_20170304_164523.jpg$$$$$20170907155634256213-nature.jpg$$$$$20170907155634256213-IMG_20170202_180824.jpg$$$$$20170907155634256213-Copy_of_IMG_1530.JPG$$$$$20170907155634256213-IMG_1559.JPG	219	4 days & 3 nights	2 min / 20 max	$ 219 per person / 5 or more, less 10%
46	Kirirom Camping  2 days & 1 night	<div dir="ltr">Do you want to escape crowded Phnom Penh and spend weekend in pure nature? Camping on the top of Phnom Pdach Jivit mountain, in Kirirom is here for you. Enjoy a splendid 10 km hike up to the peak through green jungle. Relax at the campsite, let a breeze to chill your skin and watch clouds floating below you. Join us and experience the freedom!</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr"><span style="color:#077849"><strong>ITINERARY</strong></span></div>\r\n\r\n<div dir="ltr"><strong>Day 1:</strong> Departing Phnom Penh at 6:30AM - Arriving at Kirirom national park around 10AM - 10 km hike, with water breaks, up to Phnom Pdach Jivit mountain - Lunch - Setting up tents - Free time - Mountain exploration - Dinner - Free time, sharing</div>\r\n\r\n<div dir="ltr"><strong>Day 2:</strong> Breakfast - Meditation - Free time - 10km hike back to a minivan - Lunch with a local family living in Kirirom national park - Arriving in Phnom Penh around 5PM</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>STANDARD INCLUDES AND EXCLUDES</strong></span></div>\r\n\r\n<div><strong>Includes </strong></div>\r\n\r\n<div dir="ltr">- Transportation</div>\r\n\r\n<div dir="ltr">- Tent</div>\r\n\r\n<div dir="ltr">- 4 meals (B/L2/D)</div>\r\n\r\n<div dir="ltr">- Water &amp; snacks</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong>Excludes </strong></div>\r\n\r\n<div dir="ltr">- Breakfast at day 1</div>\r\n\r\n<div dir="ltr">- Insurance</div>\r\n\r\n<div dir="ltr">- Alcohol &amp; soft drinks</div>\r\n\r\n<div dir="ltr">- Personal expenses</div>\r\n\r\n<div dir="ltr">- Entrance fee (foreigners $5)</div>\r\n\r\n<div><br />\r\n&nbsp;</div>\r\n	20171019141638038150-photo_2017-09-24_13-44-11.jpg	kirirom-camping-2-days-1-night	8	4	2017-10-19 14:16:37.491801	151	20171019141638038150-p1.jpg$$$$$20171019141638038150-photo_2017-10-17_09-17-06.jpg$$$$$20171019141848641402-1.jpg$$$$$20171019141848641402-photo_2017-10-17_09-16-56.jpg	39	18 & 19th NOVEMBER	5 min / 20 max	$39
31	How to travel cheap and absorb most experiences	<p dir="ltr"><br></p><p dir="ltr">Sela was thinking to give a try to solo travelling. Because he had never crossed a state border by himself, he decided to travel with 2 of his friends. &nbsp;</p><p data-empty="true"><br></p><p dir="ltr">The 13 day trip around Cambodia-Thailand-Malaysia was initially estimated at $600. But by traveling as a local, Sela cut down his actual spending to $350 including a bus, train, taxi, flight from KL to Phnom Penh, accommodation costs, food and entrance fees.&nbsp;</p><p data-empty="true"><br></p><p dir="ltr"><strong>Here is their route.</strong></p><p dir="ltr">Phnom Penh &nbsp;&gt;&gt; Bangkok &gt;&gt; Krabi &gt;&gt; Hat Yai &gt;&gt; Penang &gt;&gt; Kuala Lumpur &gt;&gt; Phnom Penh.</p><p data-empty="true"><br></p><p dir="ltr"><strong>How did they manage to spend less?</strong><br>First-ever they washed their clothes by themselves, They were open minded and willing to experience new things, eat street food, make friends with locals, stay at hostels and travel like locals.&nbsp;</p><p data-empty="true"><br></p><p dir="ltr"><strong>What have they learned for themselves?</strong></p><p dir="ltr">The biggest lesson was to control the mind and to stay strong in challenging situations. Many people staying at fancy places, eat at expensive restaurants, shop at luxury branded stores. That&rsquo;s not their taste of travelling- &ldquo;we have fun with less money, even street food is the best.&rdquo; said Sela. They learned how to be a leader. Each day, they change a leadership role. The leader of the day decides what to do, to see, or where to go after a discussion with team members.&nbsp;</p><p data-empty="true"><strong><br></strong></p><p dir="ltr"><strong>Advice for people who want to travel but don&rsquo;t dare yet.</strong></p><p dir="ltr">You don&rsquo;t need to have a lot of money to do a road trip. Believe in yourself, expect unexpected, enjoy and be yourself. The most important is a courage to make it happen. Older you will be more amazing stories you will have to tell your children.&nbsp;</p>	20170928112242733235-photo_2017-09-28_11-20-48.jpg	how-to-travel-cheap-and-absorb-most-experiences	1	2	2017-09-28 11:22:42.614652	1	20170928112242733235-photo_2017-09-28_11-20-51.jpg$$$$$20170928112242733235-photo_2017-09-28_11-19-33.jpg	0			
24	How can I make my payment?	<p dir="ltr">You can choose from a variety of different ways.&nbsp;Most of our clients use a bank transfer, cash or local online payment methods as Wing or others.</p>\r\n\r\n<p dir="ltr">Recently we accept a Bitcoin payment.</p>\r\n		how-can-i-make-my-payment	6	2	2017-09-12 19:14:03.325113	0		0			
25	Can I purchase insurance for my trip?	<p dir="ltr">We do not provide health, liability or travel insurance. Therefore we strongly advise you to purchase a travel insurance before taking a trip with us.</p>\r\n		can-i-purchase-insurance-for-my-trip	6	2	2017-09-12 19:22:21.22577	0		0			
19	Self -discovery tour	<div dir="ltr">Build and exchange leadership skills, learn healthy habits, develop essential life skills and play traditional games as we stay two nights and three days at the Cham fishing village near Kampot.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div>Learn about the importance of mangroves in relation to fish habitat and biodiversity from the founder.&nbsp;We will take a boat down the river to plant mangroves.</div>\r\n\r\n<div>Informal workshops during day will focus on the core components of our leadership program, with an aim toward developing self-confidence and proactive participation. We focus on developing core values such as honesty, compassion, responsibility, respect for oneself and others.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>ITINERARY</strong></span></div>\r\n\r\n<div dir="ltr"><strong>Day 1:</strong> Depart Phnom Penh - Arrive Kampot - Group activities - 2 to 3 hours by bus</div>\r\n\r\n<div dir="ltr"><strong>Day 2:</strong> Educational route - Mangrove plantation - Sport activities &nbsp;- Leadership program</div>\r\n\r\n<div dir="ltr"><strong>Day 3:</strong> Group activities - Depart Kampot - Arrive Phnom Penh</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>CORE COMPONENTS</strong></span></div>\r\n\r\n<div dir="ltr"><strong>Self Reflection:</strong> Individuals are given an opportunity for self-reflection during the camp.</div>\r\n\r\n<div dir="ltr"><strong>Team Building:</strong> Team cooperation and discovery as a means of building team spirit.</div>\r\n\r\n<div dir="ltr"><strong>Community Service:</strong> Creating a sense of togetherness with the greater community.</div>\r\n\r\n<div dir="ltr"><strong>Sharing &amp; Discussion:</strong> Sharing experiences to gain deeper understandings of history and our contemporary world.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>STANDART INCLUDES AND EXCLUDES</strong> </span></div>\r\n\r\n<div><strong>Includes</strong></div>\r\n\r\n<div dir="ltr">- Accommodations</div>\r\n\r\n<div dir="ltr">- Meals and transportation</div>\r\n\r\n<div dir="ltr">- Entrance fees</div>\r\n\r\n<div dir="ltr">- English speaking trip leaders</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong>Excludes</strong></div>\r\n\r\n<div dir="ltr">- Insurance</div>\r\n\r\n<div dir="ltr">- Alcohol &amp; soft drinks</div>\r\n\r\n<div dir="ltr">- Personal expenses</div>\r\n\r\n<div dir="ltr">- Tips &amp; gratuities</div>\r\n	20170913141518981728-IMG_20170728_101503_1.jpg	self-discovery-tour	9	2	2017-09-07 10:42:55.745007	108	20170907155313677142-IMG_20170728_101503.jpg$$$$$20170907155313677142-IMG_20170728_160408.jpg	139	3 days & 2 nights	8 min / 30 max	$139 per person / 20 or more, less 10%
17	Adventure to Areng Valley 3 days & 2 nights	<div>Immerse yourself with the nature in Areng valley. Take an adventure on the back of the motorbike to the community, enjoy the beautiful view and swimming. Meet and learn from the local indigenous community, trekking to the top of the mountain and spend a night camping there.&nbsp;</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>ITINERARY</strong></span>&nbsp;<br />\r\n<strong>Day 1:</strong>&nbsp;Departing Phnom Penh to Phlov Bobak Thma Bang &nbsp;-&nbsp;Chhay Ta heing waterfall by a community motorcycle - Swimming - Setting up a tent&nbsp;&nbsp;</div>\r\n\r\n<div><strong>Day 2:&nbsp;</strong>Chonab Village (the indigenous village) visit - 3 km trek&nbsp;to the top of Mrech Kangkeb mountain -&nbsp;&nbsp;Discussion about environmental issues with Mother&rsquo;s nature team<br />\r\n<strong>Day 3:</strong>&nbsp;Trekking - Breakfast - Departing Koh Kong</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>STANDARD INCLUDES AND EXCLUDES&nbsp;</strong></span></div>\r\n\r\n<div><strong>Includes</strong></div>\r\n\r\n<div dir="ltr">- Accommodations</div>\r\n\r\n<div dir="ltr">- Meals and transportation</div>\r\n\r\n<div dir="ltr">- Entrance fees</div>\r\n\r\n<div dir="ltr">- English speaking trip leaders</div>\r\n\r\n<div dir="ltr">- Tent</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong>Excludes</strong></div>\r\n\r\n<div>- Insurance</div>\r\n\r\n<div dir="ltr">- Alcohol &amp; soft drinks</div>\r\n\r\n<div dir="ltr">- Personal expenses</div>\r\n\r\n<div dir="ltr">- Tips &amp; gratuities</div>\r\n	20170907100447555076-20961091_1058188637646718_368225253_o_-_Copy.jpg	adventure-to-areng-valley-3-days-2-nights	8	2	2017-09-07 10:03:25.636438	340	20170907100447555076-20961138_1058187817646800_1875521772_o_-_Copy.jpg$$$$$20170907100447555076-20991212_1058194894312759_474171025_o.jpg$$$$$20170907114341250710-20961269_1058190010979914_584860022_o.jpg$$$$$20170907114341250710-20945420_1058190237646558_741904228_o_-_Copy.jpg$$$$$20170907114417894055-20951950_1058188460980069_1102043209_o_-_Copy.jpg$$$$$20170907114417894055-20991466_1058194997646082_1305340836_o.jpg	125	2-4th November	10 min / 14 max	$125
27	Adventure road trip in Southeast Asia 	<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">When you plan your own trip, do you usually wait until you have enough money? Do you prefer going with a group of people or solo?</div>\r\n\r\n<div dir="ltr">Traveling has many forms. You don&rsquo;t need to wait to travel until you become rich or have free time. You don&rsquo;t need to wait until you have enough money to travel the world.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">Here is a story of 3 young Cambodians traveling on a low budget to 2 different countries. They dream of having an independent life and &nbsp;being able to explore the world.</div>\r\n\r\n<div dir="ltr">They have decided for backpacking to Thailand and Malaysia for 13 days.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">Sela, a 22 years old, have visited few countries in SouthEast Asia already and initially reserved $600 for the upcoming trip. The actual expenses was much lower at the end. Two of his other friends, Panha Sok, and Souheang Ly joined the journey.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">They traveled with less stuff but brought back home more experience.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">Their journey started by a night bus ride from Phnom Penh to Bangkok Sela learned that New Year celebration in Thailand and Cambodia is different. In Thailand people were having fun using both balloons filled with water and baby powder. Men in Cambodia would just try to put powder on pretty girl&#39;s face only.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">It was a great time in Bangkok, meeting new people and made friends with locals. They explore the city through local&rsquo;s eyes. And this is the best way of traveling.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">Panha Sok fell in love with Bangkok because of the kind and friendly people he had met. It was his first time traveling and it has given him very good experience. Many people said that Bangkok is always busy, jammed. It is true, but these guys know how to enjoy and seek for their experiences.</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div dir="ltr">Since they traveled as a group of three, they always took turn for a leadership role. The leader of the day, had to decide where to go, what to do, things to see, where to eat, sleep, plan ahead and being flexible for whatever things may happen unexpectedly.</div>\r\n\r\n<div dir="ltr">They learned how to have more fun with less money.</div>\r\n\r\n<div dir="ltr">After Bangkok, what is next?</div>\r\n	20170913141038340197-20170913104933797993-pcs_001.jpg	adventure-road-trip-in-southeast-asia	1	3	2017-09-13 10:49:33.567923	1	20170913104933797993-kl-06.jpg$$$$$20170913104933797993-pcs_001.jpg	0			
15	Islands of the Mekong	<div dir="ltr">Book this tour and explore the island of the Mekong on bicycle, try rural foods and enhance your knowledge of local farmers and craft makers with us.&nbsp;</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr">Explore the natural beauty of Silk Island and Koh Dach Island.&nbsp;We will take an educational route at Silk farm to see how silk is being made from a scratch.&nbsp;You will have an opportunity to purchase hand made silk goods.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>STANDART INCLUDES AND EXCLUDES</strong></span></div>\r\n\r\n<div><strong>Includes</strong></div>\r\n\r\n<div dir="ltr">- Meals and transportation</div>\r\n\r\n<div dir="ltr">- Entrance fees</div>\r\n\r\n<div dir="ltr">- English speaking trip leaders</div>\r\n\r\n<div dir="ltr">- Mountain bike, panniers and helmet</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong>Excludes</strong></div>\r\n\r\n<div dir="ltr">- Insurance</div>\r\n\r\n<div dir="ltr">- Alcohol &amp; soft drinks</div>\r\n\r\n<div dir="ltr">- Personal expenses</div>\r\n\r\n<div dir="ltr">- Tips &amp; gratuities</div>\r\n	20170907152119420465-Copy_of_IMG_1853.jpg	islands-of-the-mekong	2	2	2017-09-06 22:45:55.737776	97	20170907155126820733-Copy_of_IMG_1862.jpg$$$$$20170907155126820733-Copy_of_IMG_2112.jpg	29	4 to 5 hours	2 min / 10 max 	$29 per person / 5 or more, less 10% 
54	Homestay Experience for Thacher’s school 	<p dir="ltr"><strong>Homestays are great source of experience for foreign students. New environment, a language barrier, different culture and an interaction with locals challenge students to discover and explore more. Not only about Cambodia, but also about themselves. &nbsp;</strong></p>\r\n\r\n<p><strong>When students met their host families for the first time, they were practising their basics of Khmer language. The host family walked them to their home for lunch afterwards. </strong></p>\r\n\r\n<p><strong>The students spent most of the time with the host family, getting to know each other, eating meals together, playing games and laughing together. This is the best way to learn about Cambodian culture.</strong></p>\r\n\r\n<p><strong>The weather is unpredictable during rainy season. When it was raining hard, many of the students were very excited to run and play in the rain. I still remember how Jina could not stop laughing, standing in the rain and saying &ldquo;I am very happy, I love the rain&rdquo;. </strong></p>\r\n\r\n<p><strong>Some afternoons, we joined a workshop making a mango jam and banana tapioca. The student got very excited to work with the coconut or just to cut mangos. They learned many new different things. </strong></p>\r\n\r\n<p dir="ltr"><strong>After seven days of our homestay we had a farewell dinner with the local host families and the villagers, before leaving. Beautiful memories from this homestay remain for whole life as a friendship on the island of Bassac river does. &nbsp;</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n	20171024112625040610-IMG_1324.JPG	homestay-experience-for-thachers-school	1	4	2017-10-24 11:26:23.490106	0	20171024112625040610-IMG_20170723_090411.jpg$$$$$20171024112625040610-IMG_20170724_083516.jpg$$$$$20171024112625040610-IMG_1321.JPG$$$$$20171024112625040610-IMG_1329.JPG$$$$$20171025090116612631-IMG_20170714_091602.jpg$$$$$20171025090116612631-IMG_20170716_090758.jpg	0			
33	Phnom Penh	<div dir="ltr">Visit architectural highlights of the city, explore Islands of the Mekong on a bicycle and enjoy Sunset Boat Trip.</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr"><strong>Itinerary:</strong></div>\r\n\r\n<div dir="ltr"><strong>Day 1:</strong> Tuk tuk city tour - Choeung Ek Killing Fields - Tuol Sleng prison - Royal Palace</div>\r\n\r\n<div dir="ltr"><strong>Day 2:</strong> Islands of Mekong bicycle exploration - Sunset boat trip</div>\r\n		phnom-penh	3	2	2017-10-11 19:38:10.53869	0		142	2 days & 1 night	8 min / 16 max	
16	Chambok Trekking  Full Day Trip 	<div>Join our full day trip to Chambok community, Kirirom national park. We will hike 12 km, swim in a waterfall and enjoy mind-blowing view.&nbsp;</div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div><span style="color:#077849"><strong>ITINERARY</strong></span></div>\r\n\r\n<div dir="ltr"><strong>6:30am: </strong>&nbsp;&nbsp;Depart&nbsp;Phnom Penh</div>\r\n\r\n<div dir="ltr"><strong>10:00am:</strong> Arrive&nbsp;Chambok community - Trekking&nbsp;to waterfall level 3 with a local guide - Lunch</div>\r\n\r\n<div dir="ltr"><strong>12:30pm:</strong>&nbsp;Trekking&nbsp;to waterfall level 4 - Swimming - Viewpoint trekk - Resting &nbsp;</div>\r\n\r\n<div dir="ltr"><strong>2:30pm:</strong> &nbsp;&nbsp;Trekking down</div>\r\n\r\n<div dir="ltr"><strong>4:00pm:</strong> &nbsp;&nbsp;30 min break - Sharing and a discussion</div>\r\n\r\n<div dir="ltr"><strong>4:30pm:</strong> &nbsp;&nbsp;Depart&nbsp;Chambok community</div>\r\n\r\n<div dir="ltr"><strong>7:30pm:</strong> &nbsp;&nbsp;Arrive&nbsp;Phnom Penh</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div dir="ltr"><span style="color:#077849"><strong>STANDART INCLUDES AND EXCLUDES</strong></span></div>\r\n\r\n<div><strong>Includes</strong></div>\r\n\r\n<div>- Lunch, snacks, water and transportation</div>\r\n\r\n<div dir="ltr">- English speaking trip leaders</div>\r\n\r\n<div dir="ltr">&nbsp;</div>\r\n\r\n<div><strong>Excludes</strong></div>\r\n\r\n<div dir="ltr">- Insurance</div>\r\n\r\n<div dir="ltr">- Alcohol &amp; soft drinks</div>\r\n\r\n<div dir="ltr">- Personal expenses</div>\r\n\r\n<div dir="ltr">- Entrance fees</div>\r\n\r\n<div dir="ltr">- Tips &amp; gratuities</div>\r\n	20171019142252869145-photo_2017-09-29_16-39-06.jpg	chambok-trekking-full-day-trip	8	2	2017-09-06 22:58:38.757425	228	20170907113427707044-IMG_2454.JPG$$$$$20170907113645573425-IMG_2278.JPG$$$$$20170907113645573425-IMG_2409.JPG$$$$$20170907113746803794-IMG_2462.JPG$$$$$20170907113746803794-IMG_2471.JPG	25	28th October	10 min / 13 max	$25
\.


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('post_id_seq', 60, true);


--
-- Data for Name: user_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_member (id, name, email, password, password2, created_at) FROM stdin;
1	SAN Vuthy	san.vuthy08@gmail.com	$6$rounds=656000$t8mYx28wJLmWAk.X$TUJdq8tHP1r.FArq9xxx3mFxoLp86sD1e9MHIFtOhzQLR5kQA4iI3pCDy.LBIqErQz3GB4p71hlFTDYT9NFYG/	vuthy1997*	2017-08-31 22:32:13.960212
2	Tom	tom.han22@gmail.com	$6$rounds=65447$1R1cBkPmA2CllxWZ$nIp8k395qlMOoPjhazgF8a5UcI7ESm9BWm6af9NFO5RSqAvDuFk5aNtpMAq4K5IiunNOEpCJE2nWNpdFfrlOI0	thavry89	2017-09-06 21:52:24.744946
3	Thavry	thavry@gmail.com	$6$rounds=62007$EDcrCrDBh4qSu0bU$VSjHLOOz4VVzbJ2FkGs78s9TW9zIqTXtfndO3w7DWXmIViJN14wBqxQE6nkUo9DTa00q1EbQNAgfZgVe1eG6C/	aproperwoman1952	2017-09-13 10:40:49.236444
4	Vicheata	chhetrongvicheata@gmail.com	$6$rounds=61392$cROtAEN5yDDeRAZZ$Ht8nnH8mCqPUFZV.03Iim6Us4cWYuxYCqbEbGvGrzSxwhvUZ5j99UI3ztUnAMP0gwPM8vZ2AP61zMwq0rZV0k1	093853696	2017-10-18 15:01:17.743353
\.


--
-- Name: user_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_member_id_seq', 4, true);


--
-- Name: alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_name_key UNIQUE (name);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: contact_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_email_key UNIQUE (email);


--
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: email_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY email
    ADD CONSTRAINT email_email_key UNIQUE (email);


--
-- Name: email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: emailgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emailgroup
    ADD CONSTRAINT emailgroup_pkey PRIMARY KEY (id);


--
-- Name: group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: page_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page_title_key UNIQUE (title);


--
-- Name: post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: post_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_slug_key UNIQUE (slug);


--
-- Name: post_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_title_key UNIQUE (title);


--
-- Name: user_member_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_email_key UNIQUE (email);


--
-- Name: user_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_member
    ADD CONSTRAINT user_member_pkey PRIMARY KEY (id);


--
-- Name: emailgroup_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emailgroup
    ADD CONSTRAINT emailgroup_email_id_fkey FOREIGN KEY (email_id) REFERENCES email(id);


--
-- Name: emailgroup_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emailgroup
    ADD CONSTRAINT emailgroup_group_id_fkey FOREIGN KEY (group_id) REFERENCES "group"(id);


--
-- Name: post_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_category_id_fkey FOREIGN KEY (category_id) REFERENCES category(id);


--
-- Name: post_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_member(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

