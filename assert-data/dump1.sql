--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: contratos; Type: TABLE; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE TABLE contratos (
    id integer NOT NULL,
    numero character varying(60) NOT NULL,
    orgao text,
    data_assinatura timestamp without time zone,
    vigencia integer,
    objeto text,
    modalidade text,
    evento text,
    processo_administrativo text,
    cnpj text,
    nome_fornecedor text,
    valor numeric(19,2),
    licitacao character varying(60) NOT NULL,
    data_publicacao timestamp without time zone,
    file_url text,
    txt_file_url text
);


ALTER TABLE contratos OWNER TO gastosabertos;

--
-- Name: contratos_id_seq; Type: SEQUENCE; Schema: public; Owner: gastosabertos
--

CREATE SEQUENCE contratos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contratos_id_seq OWNER TO gastosabertos;

--
-- Name: contratos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gastosabertos
--

ALTER SEQUENCE contratos_id_seq OWNED BY contratos.id;


--
-- Name: execucao; Type: TABLE; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE TABLE execucao (
    code character varying(100) NOT NULL,
    data jsonb,
    point geometry(Point),
    searched boolean
);


ALTER TABLE execucao OWNER TO gastosabertos;

--
-- Name: lake; Type: TABLE; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE TABLE lake (
    id integer NOT NULL,
    name character varying,
    geom geometry(Polygon)
);


ALTER TABLE lake OWNER TO gastosabertos;

--
-- Name: lake_id_seq; Type: SEQUENCE; Schema: public; Owner: gastosabertos
--

CREATE SEQUENCE lake_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lake_id_seq OWNER TO gastosabertos;

--
-- Name: lake_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gastosabertos
--

ALTER SEQUENCE lake_id_seq OWNED BY lake.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying,
    geo geometry(Polygon)
);


ALTER TABLE regions OWNER TO gastosabertos;

--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: gastosabertos
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE regions_id_seq OWNER TO gastosabertos;

--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gastosabertos
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: revenue; Type: TABLE; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE TABLE revenue (
    id integer NOT NULL,
    original_code character varying(30) NOT NULL,
    code_id integer,
    description text NOT NULL,
    date timestamp without time zone,
    monthly_predicted numeric(19,2),
    monthly_outcome numeric(19,2),
    economical_category integer,
    economical_subcategory integer,
    source integer,
    rubric integer,
    paragraph integer,
    subparagraph integer
);


ALTER TABLE revenue OWNER TO gastosabertos;

--
-- Name: revenue_code; Type: TABLE; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE TABLE revenue_code (
    id integer NOT NULL,
    code character varying(30) NOT NULL,
    description text NOT NULL
);


ALTER TABLE revenue_code OWNER TO gastosabertos;

--
-- Name: revenue_code_id_seq; Type: SEQUENCE; Schema: public; Owner: gastosabertos
--

CREATE SEQUENCE revenue_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE revenue_code_id_seq OWNER TO gastosabertos;

--
-- Name: revenue_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gastosabertos
--

ALTER SEQUENCE revenue_code_id_seq OWNED BY revenue_code.id;


--
-- Name: revenue_id_seq; Type: SEQUENCE; Schema: public; Owner: gastosabertos
--

CREATE SEQUENCE revenue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE revenue_id_seq OWNER TO gastosabertos;

--
-- Name: revenue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gastosabertos
--

ALTER SEQUENCE revenue_id_seq OWNED BY revenue.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gastosabertos
--

ALTER TABLE ONLY contratos ALTER COLUMN id SET DEFAULT nextval('contratos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gastosabertos
--

ALTER TABLE ONLY lake ALTER COLUMN id SET DEFAULT nextval('lake_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gastosabertos
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gastosabertos
--

ALTER TABLE ONLY revenue ALTER COLUMN id SET DEFAULT nextval('revenue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gastosabertos
--

ALTER TABLE ONLY revenue_code ALTER COLUMN id SET DEFAULT nextval('revenue_code_id_seq'::regclass);


--
-- Name: contratos_pkey; Type: CONSTRAINT; Schema: public; Owner: gastosabertos; Tablespace: 
--

ALTER TABLE ONLY contratos
    ADD CONSTRAINT contratos_pkey PRIMARY KEY (id);


--
-- Name: execucao_pkey; Type: CONSTRAINT; Schema: public; Owner: gastosabertos; Tablespace: 
--

ALTER TABLE ONLY execucao
    ADD CONSTRAINT execucao_pkey PRIMARY KEY (code);


--
-- Name: lake_pkey; Type: CONSTRAINT; Schema: public; Owner: gastosabertos; Tablespace: 
--

ALTER TABLE ONLY lake
    ADD CONSTRAINT lake_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: gastosabertos; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: revenue_code_pkey; Type: CONSTRAINT; Schema: public; Owner: gastosabertos; Tablespace: 
--

ALTER TABLE ONLY revenue_code
    ADD CONSTRAINT revenue_code_pkey PRIMARY KEY (id);


--
-- Name: revenue_pkey; Type: CONSTRAINT; Schema: public; Owner: gastosabertos; Tablespace: 
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT revenue_pkey PRIMARY KEY (id);


--
-- Name: idx_execucao_point; Type: INDEX; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE INDEX idx_execucao_point ON execucao USING gist (point);


--
-- Name: idx_lake_geom; Type: INDEX; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE INDEX idx_lake_geom ON lake USING gist (geom);


--
-- Name: idx_regions_geo; Type: INDEX; Schema: public; Owner: gastosabertos; Tablespace: 
--

CREATE INDEX idx_regions_geo ON regions USING gist (geo);


--
-- Name: revenue_code_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gastosabertos
--

ALTER TABLE ONLY revenue
    ADD CONSTRAINT revenue_code_id_fkey FOREIGN KEY (code_id) REFERENCES revenue_code(id);


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

