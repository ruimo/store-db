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
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE address (
    address_id bigint NOT NULL,
    country_code integer NOT NULL,
    first_name character varying(64) NOT NULL,
    middle_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    first_name_kana character varying(64) NOT NULL,
    last_name_kana character varying(64) NOT NULL,
    zip1 character varying(32) NOT NULL,
    zip2 character varying(32) NOT NULL,
    zip3 character varying(32) NOT NULL,
    prefecture integer NOT NULL,
    address1 character varying(256) NOT NULL,
    address2 character varying(256) NOT NULL,
    address3 character varying(256) NOT NULL,
    address4 character varying(256) NOT NULL,
    address5 character varying(256) NOT NULL,
    tel1 character varying(32) NOT NULL,
    tel2 character varying(32) NOT NULL,
    tel3 character varying(32) NOT NULL,
    comment text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.address OWNER TO store_user;

--
-- Name: address_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE address_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_seq OWNER TO store_user;

--
-- Name: category; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE category (
    category_id bigint NOT NULL
);


ALTER TABLE public.category OWNER TO store_user;

--
-- Name: TABLE category; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON TABLE category IS 'Category information. Each item has one category.';


--
-- Name: COLUMN category.category_id; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN category.category_id IS 'Surrogate key.';


--
-- Name: category_name; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE category_name (
    locale_id bigint NOT NULL,
    category_name character varying(32) NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.category_name OWNER TO store_user;

--
-- Name: category_path; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE category_path (
    ancestor bigint NOT NULL,
    descendant bigint NOT NULL,
    path_length integer NOT NULL
);


ALTER TABLE public.category_path OWNER TO store_user;

--
-- Name: category_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE category_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_seq OWNER TO store_user;

--
-- Name: currency; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE currency (
    currency_id bigint NOT NULL,
    currency_code character varying(3) NOT NULL
);


ALTER TABLE public.currency OWNER TO store_user;

--
-- Name: item; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE item (
    item_id bigint NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.item OWNER TO store_user;

--
-- Name: item_description; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE item_description (
    item_description_id bigint NOT NULL,
    locale_id bigint NOT NULL,
    description text NOT NULL,
    item_id bigint NOT NULL,
    site_id bigint NOT NULL
);


ALTER TABLE public.item_description OWNER TO store_user;

--
-- Name: item_description_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE item_description_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_description_seq OWNER TO store_user;

--
-- Name: item_name; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE item_name (
    item_name_id bigint NOT NULL,
    locale_id bigint NOT NULL,
    item_id bigint NOT NULL,
    item_name text NOT NULL
);


ALTER TABLE public.item_name OWNER TO store_user;

--
-- Name: item_name_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE item_name_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_name_seq OWNER TO store_user;

--
-- Name: item_numeric_metadata; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE item_numeric_metadata (
    item_numeric_metadata_id bigint NOT NULL,
    item_id bigint NOT NULL,
    metadata_type integer NOT NULL,
    metadata bigint
);


ALTER TABLE public.item_numeric_metadata OWNER TO store_user;

--
-- Name: item_numeric_metadata_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE item_numeric_metadata_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_numeric_metadata_seq OWNER TO store_user;

--
-- Name: item_price; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE item_price (
    item_price_id bigint NOT NULL,
    site_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.item_price OWNER TO store_user;

--
-- Name: item_price_history; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE item_price_history (
    item_price_history_id bigint NOT NULL,
    item_price_id bigint NOT NULL,
    tax_id bigint NOT NULL,
    currency_id bigint NOT NULL,
    unit_price numeric(15,2) NOT NULL,
    valid_until timestamp without time zone NOT NULL,
    cost_price numeric(15,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.item_price_history OWNER TO store_user;

--
-- Name: item_price_history_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE item_price_history_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_price_history_seq OWNER TO store_user;

--
-- Name: item_price_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE item_price_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_price_seq OWNER TO store_user;

--
-- Name: item_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE item_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_seq OWNER TO store_user;

--
-- Name: item_text_metadata; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE item_text_metadata (
    item_text_metadata_id bigint NOT NULL,
    item_id bigint NOT NULL,
    metadata_type integer NOT NULL,
    metadata text
);


ALTER TABLE public.item_text_metadata OWNER TO store_user;

--
-- Name: item_text_metadata_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE item_text_metadata_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_text_metadata_seq OWNER TO store_user;

--
-- Name: locale; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE locale (
    locale_id bigint NOT NULL,
    lang character varying(8) NOT NULL,
    country character varying(3) DEFAULT ''::character varying NOT NULL,
    precedence integer NOT NULL
);


ALTER TABLE public.locale OWNER TO store_user;

--
-- Name: TABLE locale; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON TABLE locale IS 'Locale information.';


--
-- Name: COLUMN locale.locale_id; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN locale.locale_id IS 'Surrogate key.';


--
-- Name: COLUMN locale.lang; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN locale.lang IS 'ISO 639 lang code such as ja, en.';


--
-- Name: COLUMN locale.country; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN locale.country IS 'ISO 3166 country code such as JP, US.';


--
-- Name: COLUMN locale.precedence; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN locale.precedence IS 'Precedence. If requested locale is not registed in this table, the record having greatest precedence will be used instead.';


--
-- Name: order_notification; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE order_notification (
    order_notification_id bigint NOT NULL,
    store_user_id bigint NOT NULL
);


ALTER TABLE public.order_notification OWNER TO store_user;

--
-- Name: order_notification_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE order_notification_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_notification_seq OWNER TO store_user;

--
-- Name: play_evolutions; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE play_evolutions (
    id integer NOT NULL,
    hash character varying(255) NOT NULL,
    applied_at timestamp without time zone NOT NULL,
    apply_script text,
    revert_script text,
    state character varying(255),
    last_problem text
);


ALTER TABLE public.play_evolutions OWNER TO store_user;

--
-- Name: shipping_address_history; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE shipping_address_history (
    shipping_address_history_id bigint NOT NULL,
    store_user_id bigint NOT NULL,
    address_id bigint NOT NULL,
    updated_time timestamp without time zone NOT NULL
);


ALTER TABLE public.shipping_address_history OWNER TO store_user;

--
-- Name: shipping_address_history_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE shipping_address_history_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_address_history_seq OWNER TO store_user;

--
-- Name: shipping_box; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE shipping_box (
    shipping_box_id bigint NOT NULL,
    site_id bigint NOT NULL,
    item_class bigint NOT NULL,
    box_size integer NOT NULL,
    box_name character varying(32) NOT NULL
);


ALTER TABLE public.shipping_box OWNER TO store_user;

--
-- Name: shipping_box_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE shipping_box_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_box_seq OWNER TO store_user;

--
-- Name: shipping_fee; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE shipping_fee (
    shipping_fee_id bigint NOT NULL,
    shipping_box_id bigint NOT NULL,
    country_code integer NOT NULL,
    location_code integer NOT NULL
);


ALTER TABLE public.shipping_fee OWNER TO store_user;

--
-- Name: shipping_fee_history; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE shipping_fee_history (
    shipping_fee_history_id bigint NOT NULL,
    shipping_fee_id bigint NOT NULL,
    tax_id bigint NOT NULL,
    fee numeric(15,2) NOT NULL,
    valid_until timestamp without time zone NOT NULL
);


ALTER TABLE public.shipping_fee_history OWNER TO store_user;

--
-- Name: shipping_fee_history_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE shipping_fee_history_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_fee_history_seq OWNER TO store_user;

--
-- Name: shipping_fee_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE shipping_fee_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_fee_seq OWNER TO store_user;

--
-- Name: shopping_cart_item; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE shopping_cart_item (
    shopping_cart_item_id bigint NOT NULL,
    store_user_id bigint NOT NULL,
    seq integer NOT NULL,
    site_id bigint NOT NULL,
    item_id bigint NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.shopping_cart_item OWNER TO store_user;

--
-- Name: shopping_cart_item_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE shopping_cart_item_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_cart_item_seq OWNER TO store_user;

--
-- Name: shopping_cart_shipping; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE shopping_cart_shipping (
    shopping_cart_shipping_id bigint NOT NULL,
    store_user_id bigint NOT NULL,
    site_id bigint NOT NULL,
    shipping_date timestamp without time zone NOT NULL
);


ALTER TABLE public.shopping_cart_shipping OWNER TO store_user;

--
-- Name: shopping_cart_shipping_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE shopping_cart_shipping_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_cart_shipping_seq OWNER TO store_user;

--
-- Name: site; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE site (
    site_id bigint NOT NULL,
    locale_id bigint NOT NULL,
    site_name character varying(32) NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.site OWNER TO store_user;

--
-- Name: TABLE site; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON TABLE site IS 'Site information. Site expresses store. In this application, each site treates one locale each other.';


--
-- Name: COLUMN site.site_id; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN site.site_id IS 'Surrogate key.';


--
-- Name: COLUMN site.locale_id; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN site.locale_id IS 'Locale.';


--
-- Name: COLUMN site.site_name; Type: COMMENT; Schema: public; Owner: store_user
--

COMMENT ON COLUMN site.site_name IS 'Name of this site.';


--
-- Name: site_category; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE site_category (
    category_id bigint NOT NULL,
    site_id bigint NOT NULL
);


ALTER TABLE public.site_category OWNER TO store_user;

--
-- Name: site_item; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE site_item (
    item_id bigint NOT NULL,
    site_id bigint NOT NULL
);


ALTER TABLE public.site_item OWNER TO store_user;

--
-- Name: site_item_numeric_metadata; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE site_item_numeric_metadata (
    site_item_numeric_metadata_id bigint NOT NULL,
    site_id bigint NOT NULL,
    item_id bigint NOT NULL,
    metadata_type integer NOT NULL,
    metadata bigint
);


ALTER TABLE public.site_item_numeric_metadata OWNER TO store_user;

--
-- Name: site_item_numeric_metadata_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE site_item_numeric_metadata_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.site_item_numeric_metadata_seq OWNER TO store_user;

--
-- Name: site_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE site_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.site_seq OWNER TO store_user;

--
-- Name: site_user; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE site_user (
    site_user_id bigint NOT NULL,
    site_id bigint NOT NULL,
    store_user_id bigint NOT NULL
);


ALTER TABLE public.site_user OWNER TO store_user;

--
-- Name: site_user_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE site_user_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.site_user_seq OWNER TO store_user;

--
-- Name: store_user; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE store_user (
    store_user_id bigint NOT NULL,
    user_name character varying(64) NOT NULL,
    first_name character varying(64) NOT NULL,
    middle_name character varying(64),
    last_name character varying(64) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash bigint NOT NULL,
    salt bigint NOT NULL,
    deleted boolean NOT NULL,
    user_role integer NOT NULL,
    company_name character varying(64),
    CONSTRAINT user_user_role_check1 CHECK ((user_role = ANY (ARRAY[0, 1])))
);


ALTER TABLE public.store_user OWNER TO store_user;

--
-- Name: store_user_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE store_user_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_user_seq OWNER TO store_user;

--
-- Name: tax; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE tax (
    tax_id bigint NOT NULL
);


ALTER TABLE public.tax OWNER TO store_user;

--
-- Name: tax_history; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE tax_history (
    tax_history_id bigint NOT NULL,
    tax_id bigint NOT NULL,
    tax_type integer NOT NULL,
    rate numeric(5,3) NOT NULL,
    valid_until timestamp without time zone NOT NULL,
    CONSTRAINT tax_history_check1 CHECK ((tax_type = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.tax_history OWNER TO store_user;

--
-- Name: tax_history_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE tax_history_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_history_seq OWNER TO store_user;

--
-- Name: tax_name; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE tax_name (
    tax_name_id bigint NOT NULL,
    tax_id bigint NOT NULL,
    locale_id bigint NOT NULL,
    tax_name character varying(32) NOT NULL
);


ALTER TABLE public.tax_name OWNER TO store_user;

--
-- Name: tax_name_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE tax_name_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_name_seq OWNER TO store_user;

--
-- Name: tax_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE tax_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tax_seq OWNER TO store_user;

--
-- Name: transaction_credit_tender; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transaction_credit_tender (
    transaction_credit_tender_id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    amount numeric(15,2) NOT NULL
);


ALTER TABLE public.transaction_credit_tender OWNER TO store_user;

--
-- Name: transaction_credit_tender_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transaction_credit_tender_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_credit_tender_seq OWNER TO store_user;

--
-- Name: transaction_header; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transaction_header (
    transaction_id bigint NOT NULL,
    store_user_id bigint NOT NULL,
    transaction_time timestamp without time zone NOT NULL,
    currency_id bigint NOT NULL,
    total_amount numeric(15,2) NOT NULL,
    tax_amount numeric(15,2) NOT NULL,
    transaction_type integer NOT NULL
);


ALTER TABLE public.transaction_header OWNER TO store_user;

--
-- Name: transaction_header_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transaction_header_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_header_seq OWNER TO store_user;

--
-- Name: transaction_item; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transaction_item (
    transaction_item_id bigint NOT NULL,
    transaction_site_id bigint NOT NULL,
    item_id bigint NOT NULL,
    item_price_history_id bigint NOT NULL,
    quantity integer NOT NULL,
    amount numeric(15,2) NOT NULL,
    cost_price numeric(15,2) DEFAULT 0 NOT NULL,
    tax_id bigint DEFAULT 2 NOT NULL
);


ALTER TABLE public.transaction_item OWNER TO store_user;

--
-- Name: transaction_item_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transaction_item_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_item_seq OWNER TO store_user;

--
-- Name: transaction_shipping; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transaction_shipping (
    transaction_shipping_id bigint NOT NULL,
    transaction_site_id bigint NOT NULL,
    amount numeric(15,2) NOT NULL,
    address_id bigint NOT NULL,
    item_class bigint NOT NULL,
    box_size integer NOT NULL,
    tax_id bigint NOT NULL,
    shipping_date timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    box_count integer DEFAULT 1 NOT NULL,
    box_name character varying(32) DEFAULT '-'::character varying NOT NULL
);


ALTER TABLE public.transaction_shipping OWNER TO store_user;

--
-- Name: transaction_shipping_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transaction_shipping_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_shipping_seq OWNER TO store_user;

--
-- Name: transaction_site; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transaction_site (
    transaction_site_id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    site_id bigint NOT NULL,
    total_amount numeric(15,2) NOT NULL,
    tax_amount numeric(15,2) NOT NULL
);


ALTER TABLE public.transaction_site OWNER TO store_user;

--
-- Name: transaction_site_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transaction_site_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_site_seq OWNER TO store_user;

--
-- Name: transaction_status; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transaction_status (
    transaction_status_id bigint NOT NULL,
    transaction_site_id bigint NOT NULL,
    status integer NOT NULL,
    transporter_id bigint,
    slip_code character varying(128) DEFAULT NULL::character varying,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    mail_sent boolean DEFAULT false NOT NULL
);


ALTER TABLE public.transaction_status OWNER TO store_user;

--
-- Name: transaction_status_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transaction_status_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_status_seq OWNER TO store_user;

--
-- Name: transaction_tax; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transaction_tax (
    transaction_tax_id bigint NOT NULL,
    transaction_site_id bigint NOT NULL,
    tax_id bigint NOT NULL,
    tax_type integer NOT NULL,
    rate numeric(5,3) NOT NULL,
    target_amount numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL
);


ALTER TABLE public.transaction_tax OWNER TO store_user;

--
-- Name: transaction_tax_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transaction_tax_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_tax_seq OWNER TO store_user;

--
-- Name: transporter; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transporter (
    transporter_id bigint NOT NULL
);


ALTER TABLE public.transporter OWNER TO store_user;

--
-- Name: transporter_name; Type: TABLE; Schema: public; Owner: store_user; Tablespace: 
--

CREATE TABLE transporter_name (
    transporter_name_id bigint NOT NULL,
    locale_id bigint NOT NULL,
    transporter_id bigint NOT NULL,
    transporter_name character varying(64)
);


ALTER TABLE public.transporter_name OWNER TO store_user;

--
-- Name: transporter_name_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transporter_name_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transporter_name_seq OWNER TO store_user;

--
-- Name: transporter_seq; Type: SEQUENCE; Schema: public; Owner: store_user
--

CREATE SEQUENCE transporter_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transporter_seq OWNER TO store_user;

--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY address (address_id, country_code, first_name, middle_name, last_name, first_name_kana, last_name_kana, zip1, zip2, zip3, prefecture, address1, address2, address3, address4, address5, tel1, tel2, tel3, comment) FROM stdin;
1000	152	花井		小桃	ハナイ	コモモ	111	1111		1	住所1	住所2				11111111			
1001	152	花井		小桃	ハナイ	コモモ	111	1111		3	住所1	住所2				11111111			
1002	152	花井		小桃	ハナイ	コモモ	111	1111		13	住所1	住所2				11111111			
1003	152	花井		小桃	ハナイ	コモモ	111	1111		18	住所1	住所2				11111111			
1004	152	花井		小桃	ハナイ	コモモ	111	1111		40	住所1	住所2				11111111			
1005	152	花井		小桃	ハナイ	コモモ	111	1111		1	住所1	住所2				11111111			
1006	152	花井		小桃	ハナイ	コモモ	111	1111		13	住所1	住所2				11111111			
1007	152	林		聡子	ハヤシ	サトコ	111	1111		1	北海道札幌市	11-11				00000000000			
1008	152	林		聡子	ハヤシ	サトコ	111	1111		10	北海道札幌市	11-11				00000000000			
1009	152	林		聡子	ハヤシ	サトコ	111	1111		13	港区南青山	2-13-18				00000000000			
1010	152	花井		卯之吉	ハナイ	ウノキチ	111	2222		13	住所1	住所2				12345678			
1011	152	花井		小桃	ハナイ	コモモ	111	1111		13	住所1	住所2				11111111			コメント1\r\nコメント2
1012	152	林		聡子	ハヤシ	サトコ	111	1111		13	港区南青山	2-13-18				00000000000			テスト
1013	152	林		聡子	ハヤシ	サトコ	111	1111		13	港区南青山	2-13-18				00000000000			テストです
1014	152	テスト発注です!!		聡子	ハヤシ	サトコ	111	1111		13	港区南青山	2-13-18				00000000000			!!テスト発注です!!
1015	152	花井		小桃	ハナイ	コモモ	111	1111		1	住所1	住所2				11111111			コメント1\r\nコメント2
1016	152	花井		小桃	ハナイ	コモモ	111	1111		2	住所1	住所2				11111111			コメント1\r\nコメント2
1017	152	花井		小桃	ハナイ	コモモ	111	1111		3	住所1	住所2				11111111			コメント1\r\nコメント2
1018	152	花井		小桃	ハナイ	コモモ	111	1111		4	住所1	住所2				11111111			コメント1\r\nコメント2
1019	152	花井		小桃	ハナイ	コモモ	111	1111		5	住所1	住所2				11111111			コメント1\r\nコメント2
1020	152	花井		小桃	ハナイ	コモモ	111	1111		6	住所1	住所2				11111111			コメント1\r\nコメント2
1021	152	花井		小桃	ハナイ	コモモ	111	1111		7	住所1	住所2				11111111			コメント1\r\nコメント2
1022	152	花井		小桃	ハナイ	コモモ	111	1111		8	住所1	住所2				11111111			コメント1\r\nコメント2
1023	152	花井		小桃	ハナイ	コモモ	111	1111		9	住所1	住所2				11111111			コメント1\r\nコメント2
1024	152	花井		小桃	ハナイ	コモモ	111	1111		10	住所1	住所2				11111111			コメント1\r\nコメント2
1025	152	花井		小桃	ハナイ	コモモ	111	1111		11	住所1	住所2				11111111			コメント1\r\nコメント2
1026	152	花井		小桃	ハナイ	コモモ	111	1111		12	住所1	住所2				11111111			コメント1\r\nコメント2
1027	152	花井		小桃	ハナイ	コモモ	111	1111		13	住所1	住所2				11111111			コメント1\r\nコメント2
1028	152	花井		小桃	ハナイ	コモモ	111	1111		14	住所1	住所2				11111111			コメント1\r\nコメント2
1029	152	花井		小桃	ハナイ	コモモ	111	1111		15	住所1	住所2				11111111			コメント1\r\nコメント2
1030	152	花井		小桃	ハナイ	コモモ	111	1111		16	住所1	住所2				11111111			コメント1\r\nコメント2
1031	152	花井		小桃	ハナイ	コモモ	111	1111		17	住所1	住所2				11111111			コメント1\r\nコメント2
1032	152	花井		小桃	ハナイ	コモモ	111	1111		18	住所1	住所2				11111111			コメント1\r\nコメント2
1033	152	花井		小桃	ハナイ	コモモ	111	1111		19	住所1	住所2				11111111			コメント1\r\nコメント2
1034	152	花井		小桃	ハナイ	コモモ	111	1111		20	住所1	住所2				11111111			コメント1\r\nコメント2
1035	152	花井		小桃	ハナイ	コモモ	111	1111		21	住所1	住所2				11111111			コメント1\r\nコメント2
1036	152	花井		小桃	ハナイ	コモモ	111	1111		22	住所1	住所2				11111111			コメント1\r\nコメント2
1037	152	花井		小桃	ハナイ	コモモ	111	1111		23	住所1	住所2				11111111			コメント1\r\nコメント2
1038	152	花井		小桃	ハナイ	コモモ	111	1111		24	住所1	住所2				11111111			コメント1\r\nコメント2
1039	152	花井		小桃	ハナイ	コモモ	111	1111		25	住所1	住所2				11111111			コメント1\r\nコメント2
1040	152	花井		小桃	ハナイ	コモモ	111	1111		26	住所1	住所2				11111111			コメント1\r\nコメント2
1041	152	花井		小桃	ハナイ	コモモ	111	1111		27	住所1	住所2				11111111			コメント1\r\nコメント2
1042	152	花井		小桃	ハナイ	コモモ	111	1111		28	住所1	住所2				11111111			コメント1\r\nコメント2
1043	152	花井		小桃	ハナイ	コモモ	111	1111		29	住所1	住所2				11111111			コメント1\r\nコメント2
1044	152	花井		小桃	ハナイ	コモモ	111	1111		30	住所1	住所2				11111111			コメント1\r\nコメント2
1045	152	花井		小桃	ハナイ	コモモ	111	1111		31	住所1	住所2				11111111			コメント1\r\nコメント2
1046	152	花井		小桃	ハナイ	コモモ	111	1111		32	住所1	住所2				11111111			コメント1\r\nコメント2
1047	152	花井		小桃	ハナイ	コモモ	111	1111		33	住所1	住所2				11111111			コメント1\r\nコメント2
1048	152	花井		小桃	ハナイ	コモモ	111	1111		34	住所1	住所2				11111111			コメント1\r\nコメント2
1049	152	花井		小桃	ハナイ	コモモ	111	1111		35	住所1	住所2				11111111			コメント1\r\nコメント2
1050	152	花井		小桃	ハナイ	コモモ	111	1111		36	住所1	住所2				11111111			コメント1\r\nコメント2
1051	152	花井		小桃	ハナイ	コモモ	111	1111		37	住所1	住所2				11111111			コメント1\r\nコメント2
1052	152	花井		小桃	ハナイ	コモモ	111	1111		38	住所1	住所2				11111111			コメント1\r\nコメント2
1053	152	花井		小桃	ハナイ	コモモ	111	1111		39	住所1	住所2				11111111			コメント1\r\nコメント2
1054	152	花井		小桃	ハナイ	コモモ	111	1111		40	住所1	住所2				11111111			コメント1\r\nコメント2
1055	152	花井		小桃	ハナイ	コモモ	111	1111		41	住所1	住所2				11111111			コメント1\r\nコメント2
1056	152	花井		小桃	ハナイ	コモモ	111	1111		42	住所1	住所2				11111111			コメント1\r\nコメント2
1057	152	花井		小桃	ハナイ	コモモ	111	1111		43	住所1	住所2				11111111			コメント1\r\nコメント2
1058	152	花井		小桃	ハナイ	コモモ	111	1111		44	住所1	住所2				11111111			コメント1\r\nコメント2
1059	152	花井		小桃	ハナイ	コモモ	111	1111		45	住所1	住所2				11111111			コメント1\r\nコメント2
1061	152	花井		小桃	ハナイ	コモモ	111	1111		47	住所1	住所2				11111111			コメント1\r\nコメント2
1060	152	花井		小桃	ハナイ	コモモ	111	1111		46	住所1	住所2				11111111			コメント1\r\nコメント2
1062	152	花井		小桃	ハナイ	コモモ	146	0082		13	住所1	住所2				11111111			コメント1\r\nコメント2
\.


--
-- Name: address_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('address_seq', 1062, true);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY category (category_id) FROM stdin;
1
\.


--
-- Data for Name: category_name; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY category_name (locale_id, category_name, category_id) FROM stdin;
1	植栽	1
\.


--
-- Data for Name: category_path; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY category_path (ancestor, descendant, path_length) FROM stdin;
1	1	0
\.


--
-- Name: category_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('category_seq', 1000, false);


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY currency (currency_id, currency_code) FROM stdin;
1	JPY
2	USD
\.


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY item (item_id, category_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
11	1
12	1
13	1
14	1
15	1
16	1
17	1
18	1
19	1
20	1
21	1
22	1
23	1
24	1
25	1
26	1
27	1
28	1
29	1
30	1
31	1
32	1
33	1
34	1
35	1
36	1
37	1
38	1
39	1
40	1
41	1
42	1
43	1
44	1
45	1
46	1
47	1
48	1
49	1
50	1
51	1
52	1
53	1
54	1
55	1
56	1
57	1
58	1
59	1
60	1
61	1
62	1
63	1
64	1
65	1
66	1
67	1
68	1
69	1
70	1
71	1
72	1
73	1
74	1
75	1
76	1
77	1
78	1
79	1
80	1
81	1
82	1
83	1
84	1
85	1
86	1
87	1
88	1
89	1
90	1
91	1
92	1
93	1
94	1
95	1
96	1
97	1
98	1
99	1
100	1
101	1
102	1
103	1
104	1
105	1
106	1
107	1
108	1
109	1
110	1
111	1
112	1
113	1
114	1
115	1
116	1
117	1
118	1
119	1
120	1
121	1
122	1
123	1
124	1
125	1
126	1
127	1
128	1
129	1
130	1
131	1
132	1
133	1
134	1
135	1
136	1
137	1
138	1
139	1
140	1
141	1
142	1
143	1
144	1
145	1
146	1
147	1
148	1
149	1
150	1
151	1
152	1
153	1
154	1
155	1
156	1
157	1
158	1
159	1
160	1
161	1
162	1
163	1
164	1
165	1
166	1
167	1
168	1
169	1
170	1
171	1
172	1
173	1
174	1
175	1
176	1
177	1
178	1
179	1
180	1
181	1
182	1
183	1
184	1
185	1
186	1
187	1
188	1
189	1
190	1
191	1
192	1
193	1
194	1
195	1
196	1
197	1
198	1
199	1
200	1
201	1
202	1
203	1
204	1
205	1
206	1
207	1
208	1
209	1
210	1
211	1
212	1
213	1
214	1
215	1
216	1
217	1
218	1
219	1
220	1
221	1
222	1
223	1
224	1
225	1
226	1
227	1
228	1
229	1
230	1
231	1
232	1
233	1
234	1
235	1
236	1
237	1
238	1
239	1
240	1
241	1
242	1
243	1
244	1
245	1
246	1
247	1
248	1
249	1
250	1
251	1
252	1
253	1
254	1
255	1
256	1
257	1
258	1
259	1
260	1
261	1
262	1
263	1
264	1
265	1
266	1
267	1
268	1
269	1
270	1
271	1
272	1
273	1
274	1
275	1
276	1
277	1
278	1
279	1
280	1
281	1
282	1
283	1
284	1
285	1
286	1
287	1
288	1
289	1
290	1
291	1
292	1
293	1
294	1
295	1
296	1
297	1
298	1
299	1
300	1
301	1
302	1
303	1
304	1
305	1
306	1
307	1
308	1
309	1
310	1
311	1
1000	1
1001	1
1002	1
1003	1
1004	1
1005	1
1006	1
1007	1
1008	1
1009	1
1010	1
1011	1
1012	1
1013	1
1014	1
1015	1
1016	1
1017	1
1018	1
1019	1
1020	1
1021	1
1022	1
1023	1
1024	1
1025	1
1026	1
1027	1
1028	1
1029	1
1030	1
1031	1
1032	1
1033	1
1034	1
1035	1
1036	1
1037	1
1038	1
1039	1
1040	1
1041	1
1042	1
1043	1
1044	1
1045	1
1046	1
1047	1
1048	1
1049	1
1050	1
1051	1
1052	1
1053	1
1054	1
1055	1
1056	1
1057	1
1058	1
1059	1
1060	1
1061	1
1062	1
1063	1
1064	1
1065	1
1066	1
1067	1
\.


--
-- Data for Name: item_description; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY item_description (item_description_id, locale_id, description, item_id, site_id) FROM stdin;
1	1		1	1
2	1		2	1
3	1		3	1
4	1		4	1
5	1		5	1
6	1		6	1
7	1		7	1
8	1		8	1
9	1		9	1
10	1		10	1
11	1		11	1
12	1		12	1
13	1		13	1
14	1		14	1
15	1		15	1
16	1		16	1
17	1		17	1
18	1		18	1
19	1		19	1
20	1		20	1
21	1		21	1
22	1		22	1
23	1		23	1
24	1		24	1
25	1		25	1
26	1		26	1
27	1		27	1
28	1		28	1
29	1		29	1
30	1		30	1
31	1		31	1
32	1		32	1
33	1		33	1
34	1		34	1
35	1		35	1
36	1		36	1
37	1		37	1
38	1		38	1
41	1		41	2
42	1		42	2
43	1		43	2
44	1		44	2
45	1		45	2
46	1		46	2
47	1		47	2
48	1		48	2
49	1		49	2
50	1		50	2
51	1		51	2
52	1		52	2
53	1		53	2
54	1		54	2
55	1		55	2
56	1		56	2
57	1		57	2
58	1		58	2
59	1		59	2
60	1		60	2
61	1		61	2
62	1		62	2
63	1		63	2
64	1		64	2
65	1		65	2
66	1		66	2
67	1		67	2
68	1		68	2
69	1		69	2
70	1		70	2
71	1		71	2
72	1		72	2
73	1		73	2
74	1		74	2
75	1		75	2
76	1		76	2
77	1		77	2
78	1		78	2
79	1		79	2
80	1		80	2
81	1		81	2
82	1		82	2
83	1		83	2
84	1		84	2
85	1		85	2
86	1		86	2
87	1		87	2
88	1		88	2
89	1		89	2
90	1		90	2
91	1		91	2
92	1		92	2
93	1		93	2
94	1		94	2
95	1		95	2
96	1		96	2
97	1		97	2
98	1		98	2
99	1		99	2
100	1		100	2
101	1		101	2
102	1		102	2
103	1		103	2
104	1		104	2
105	1		105	2
106	1		106	2
107	1		107	2
108	1		108	2
109	1		109	2
110	1		110	2
111	1		111	2
112	1		112	2
113	1		113	2
114	1		114	2
115	1		115	2
116	1		116	2
117	1		117	2
118	1		118	2
119	1		119	2
120	1		120	2
40	1	常緑	40	2
121	1		121	2
122	1		122	2
123	1		123	2
124	1		124	2
125	1		125	2
126	1		126	2
127	1		127	2
128	1		128	2
129	1		129	2
130	1		130	2
131	1		131	2
132	1		132	2
133	1		133	2
134	1		134	2
135	1		135	2
136	1		136	2
137	1		137	2
138	1		138	2
139	1		139	2
140	1		140	2
141	1		141	2
142	1		142	2
143	1		143	2
144	1		144	2
145	1		145	2
146	1		146	2
147	1		147	2
148	1		148	2
149	1		149	2
150	1		150	2
151	1		151	2
152	1		152	2
153	1		153	2
154	1		154	2
155	1		155	2
156	1		156	2
157	1		157	2
158	1		158	2
159	1		159	2
160	1		160	2
161	1		161	2
162	1		162	2
163	1		163	2
164	1		164	2
165	1		165	2
166	1		166	2
167	1		167	2
168	1		168	2
169	1		169	2
170	1		170	2
171	1		171	2
172	1		172	2
173	1		173	2
174	1		174	2
175	1		175	2
176	1		176	2
177	1		177	2
178	1		178	2
179	1		179	2
180	1		180	2
181	1		181	2
182	1		182	2
183	1		183	2
184	1		184	2
185	1		185	2
186	1		186	2
187	1		187	2
188	1		188	2
189	1		189	2
190	1		190	2
191	1		191	2
192	1		192	2
193	1		193	2
194	1		194	2
195	1		195	2
196	1		196	2
197	1		197	2
198	1		198	2
199	1		199	2
200	1		200	2
201	1		201	2
202	1		202	2
203	1		203	2
204	1		204	2
205	1		205	2
206	1		206	2
207	1		207	2
208	1		208	2
209	1		209	2
210	1		210	2
211	1		211	2
212	1		212	2
213	1		213	2
214	1		214	2
215	1		215	2
216	1		216	2
217	1		217	2
218	1		218	2
219	1		219	2
220	1		220	2
221	1		221	2
222	1		222	2
223	1		223	2
224	1		224	2
225	1		225	2
226	1		226	2
227	1		227	2
228	1		228	2
229	1		229	2
230	1		230	2
231	1		231	2
232	1		232	2
233	1		233	2
234	1		234	2
235	1		235	2
236	1		236	2
237	1		237	2
238	1		238	2
239	1		239	2
240	1		240	2
241	1		241	2
242	1		242	2
243	1		243	2
244	1		244	2
245	1		245	2
246	1		246	2
247	1		247	2
248	1		248	2
249	1		249	2
250	1		250	2
251	1		251	2
252	1		252	2
253	1		253	2
254	1		254	2
255	1		255	2
256	1		256	2
257	1		257	2
258	1		258	2
259	1		259	2
260	1		260	2
261	1		261	2
262	1		262	2
263	1		263	2
264	1		264	2
265	1		265	2
266	1		266	2
267	1		267	2
268	1		268	2
269	1		269	2
270	1		270	2
271	1		271	2
272	1		272	2
273	1		273	2
274	1		274	2
275	1		275	2
276	1		276	2
277	1		277	2
278	1		278	2
279	1		279	2
280	1		280	2
281	1		281	2
282	1		282	2
283	1		283	2
284	1		284	2
285	1		285	2
286	1		286	2
287	1		287	2
288	1		288	2
289	1		289	2
290	1		290	2
291	1		291	2
292	1		292	2
293	1		293	2
294	1		294	2
295	1		295	2
296	1		296	2
297	1		297	2
298	1		298	2
299	1		299	2
300	1		300	2
301	1		301	2
302	1		302	2
303	1		303	2
304	1		304	2
305	1		305	2
306	1		306	2
307	1		307	2
308	1		308	2
309	1		309	2
310	1		310	2
311	1		311	2
1011	1	日なた向き　ツツジとマホニアコンフーサのボリュームセット,01_L,1.5㎡から2.0㎡,10,000,ヒラドツツジ,マホニアコンフーサー,,,,,,日当たりが良い植物向き,やはり春先のツツジの花の美しさは格別。<br>将来少し大きく育てるスペースにもオススメ。<br>細葉でやや濃い緑のコンフーサで足元を締めます。,門まわり,欧風,アプローチ,,ファサード,,,,狭小地,和風,,1万円セット	1011	2
1019	1	半日陰向き　赤い紅葉が綺麗なコバノズイナのナチュラルセット,03_B,1.5㎡から2.0㎡,10,000,コバノズイナ,コクチナシ,ヤブラン,,,,,北側などの日陰向き,コクチナシとヤブランというコンビニに動きのあるちょっと高さのあるコバノズイナを加えました。,門まわり,欧風,アプローチ,,ファサード,ナチュラルモダン,,,,,,1万円セット	1019	2
1027	1	日なた向き　ブルーシルバー系の欧風セット,04_E,1.5㎡から2.0㎡,10,000,オリーブ,ユキヤナギ,バーハーバー,タツタナデシコ,,,,日当たりが良い植物向き,シルバーブルーの葉色をメインに組み合わせ、母の日を思い出すナデシコのピンクと雪のような小さな花をアレンジしたプランです。,門まわり,欧風,アプローチ,,ファサード,ナチュラルモダン,,,,,,1万円セット	1027	2
1037	1	日陰向き　どんなイメージにも合う白花が咲くナチュラルセット,06_A,1.5㎡から2.0㎡,10,000,オオデマリ,シロヤマブキ,ギンバイカ,キチジョウソウ,,,,北側などの日陰向き,柔かな色の地被とやや深めの緑の低木が足元を引き締め、白花で趣の違う二種類の灌木が可憐さと可愛いさの彩りを加えて、愉しい空間が生まれます。,門まわり,欧風,,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット\r\n	1037	2
1046	1	日なた向き　和風ベースの植物のナチュラルモダンセット,09_B,1.5㎡から2.0㎡,10,000,コバノズイナ,ガクアジサイ,サツキ,アベリア,アベリア・コンフェッティ,アジュガ,,日当たりが良い植物向き,ちょっと和風ベースの植物に種類のアベリアが入り、少しずつ複雑に構成してモダンなイメージで魅せます。,,欧風,,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,和風,車庫まわり,1万円セット	1046	2
1048	1	日陰向き　安定のしっとりとした和風セット,10_B,2.5㎡から3.0㎡,20,000,イワナンテン・アキシラリス,ヤブラン,タマリュウ,,,,,北側などの日陰向き,しっとりとした空間に柔らかな小から中木、どれを選んでもしっかりと足元を安定させてくれる構成です。,門まわり,,アプローチ,自然風,ファサード,ナチュラルモダン,,,,和風,,2万円セット	1048	2
1051	1		1051	2
1054	1		1054	2
1003	1	2_1003,01_D,半日陰　艶のある緑のセット,1.5㎡から2.0㎡,"10,000",コクチナシ,ヤブラン,,,,,,北側などの日陰向き,hokuseiarea_hokutouarea,"小さくてとても深く艶やかな緑のコクチナシの葉と梅雨の時期に咲く白い花が美しい。\r\n夏すぎた頃咲く濃い紫のヤブランの花もかわいいです。\r\n葉の形や色の違う植物を組み合わせてみました。",saite10000yenset,,areagate,,,,areaapproach,naturalair,,areafacade,,,saiteunitsetsearch,,,,,japanese,	1003	2
1004	1	2_1004,01_E,日陰向き　和風コントラストセット,1.5㎡から2.0㎡,"10,000",リュウノヒゲ,オカメザサ,,,,,,北側などの日陰向き,hokuseiarea_hokutouarea,強くて安定したコンビネーション明るい色のオカメザサの葉と深い緑のリュウノヒゲのコントラストがキレイです。,saite10000yenset,,areagate,,,,areaapproach,,,areafacade,,,saiteunitsetsearch,,,simplemodern,areanarrow,japanese,	1004	2
1009	1	日なたから半日陰向き　斑入りの葉のナチュラルセット,01_J,1.5㎡から2.0㎡,10,000,アジサイ,シモツケ・ゴールドフレーム,,,,,,日なたから半日陰向き西側もOK,用途としては日当たりが良く少し奥まったところでブルーパシフィック、オタフクナンテンと組み合わせると効果抜群!!<br>アジサイの花とシモツケの花、及び斑入りの葉が美しいです。,,欧風,,,,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1009	2
1012	1	日陰向き　目隠しの欲しい場所に深緑のセット,02_A,1.5㎡から2.0㎡,10,000,アオキ,ヒイラギナンテン,ヤブラン,,,,,北側などの日陰向き,北側の設備などちょっとした目隠しのほしい場所の味方といえばアオキとヒイラギナンテン。<br>深い緑と艶やかな葉に真っ赤な新芽のコンビネーション。,,,アプローチ,,,,ガーデン・庭まわり,シンプルモダン,,和風,,1万円セット	1012	2
1013	1	半日陰向き　白い花が咲くナチュラルセット,02_B,1.5㎡から2.0㎡,10,000,シロヤマブキ,ギンバイカ,キチジョウソウ,,,,,北側などの日陰向き,落葉で抜けるような柔らかい緑のヤマブキ、その白い花と深い緑のギンバイカ。<br>足元にキチジョウソウを合わせて明るいイメージの北庭にします。,,,,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,和風,,1万円セット\r\n	1013	2
1014	1	日なたから日陰向き　ホワイトを基調としたセット,02_C,1.5㎡から2.0㎡,10,000,シルバープリペット,ユキヤナギ,アベリア・ホープレイズ,,,,,日なたから半日陰向き西側もOK,とにかく明るくボリューミーに!!<br>それぞれ性質も強いが花の白、白い斑でさわやかな組み合わせ。,,欧風,アプローチ,,,ナチュラルモダン,ガーデン・庭まわり,シンプルモダン,,,,1万円セット	1014	2
1015	1	日なた向き　爽やかなゴールデンセット,02_D,1.5㎡から2.0㎡,10,000,レンギョウ,フィリフェラオーレア,芝生(ビクトール),,,,,日当たりが良い植物向き,ゴールデンコンビに芝生を加えて爽快に。<br>長い植え込みや広い庭の縁止まりなどにもオススメです。<br>(球根や一年草などを加えても有効的です),,欧風,,,,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1015	2
1002	1	2_1002,01_C,冬に咲くクリスマスローズの半日陰セット,1.5㎡から2.0㎡,"10,000",クリスマスローズ,キチジョウソウ,,,,,,北側などの日陰向き,hokuseiarea_hokutouarea,寒い季節に花を楽しめるクリスマスローズと淡い緑の艶やかな配色キチジョウソウで爽やかなコンビネーションが落ち着きがあり玄関のまわりの小さなスペースにもおススメです。,saite10000yenset,,,,,,areaapproach,naturalair,,areafacade,,,saiteunitsetsearch,,,,,japanese,	1002	2
1005	1	2_1005,01_F,三ツ星！半日陰スタイルセット,1.5㎡から2.0㎡,"10,000",イワナンテン・アキシラリス,キチジョウソウ,,,,,,北側などの日陰向き,hokuseiarea_hokutouarea,"低くしっかりとしたテクスチャーを作る組み合わせです。\r\nやや濃い緑のアキシラリスは新芽の寒い時期の真っ赤な表情が美しい。",saite10000yenset,,areagate,,,,areaapproach,naturalair,,areafacade,,,saiteunitsetsearch,areagarden,,,,japanese,	1005	2
1006	1	01_G,日なた向き　色合いが楽しめるローメンテナンスセット,1.5㎡から2.0㎡,"10,000",フィリフェラオーレア,アベリア・コンフェッティ,,,,,,日当たりが良い植物向き,nantouarea_nanseiarea,"日に当たると一層綺麗な色合いとなり、手入れも簡単で重宝します。\r\n足元に斑入りのコンフェッティの葉が美しいコンビ。ネーションとなり、南側のエクステリアの表情を明るくします。",saite10000yenset,,areagate,european,,,areaapproach,,,areafacade,,naturalmodern,saiteunitsetsearch,areagarden,,simplemodern,areanarrow,,	1006	2
1007	1	01_H,日なた向き　春先に花が咲くゴールデンコンビ,1.5㎡から2.0㎡,"10,000",レンギョウ,フィリフェラオーレア,,,,,,日当たりが良い植物向き,nantouarea_nanseiarea,"春先にレンギョウの黄色い花が咲き、南向きで広めの空間などにオススメです。\r\nオーレアの黄色とレンギョウの黄色い花が出会うとても強いゴールデンコンビ。",saite10000yenset,,areagate,european,,,areaapproach,,,,,naturalmodern,saiteunitsetsearch,areagarden,,,,,	1007	2
1008	1	01_I,日なたから半日陰向き　斑入りの葉が華やぐナチュラルセット,1.5㎡から2.0㎡,"10,000",シモツケ・ゴールドフレーム,アベリア・コンフェッティ,,,,,,日なたから半日陰向き西側もOK,hokutouarea_nantouarea_nanseiarea,"それぞれがキレイな斑入りの小さな花を咲かすコンビです。\r\n小さなスペースにもパッと華やぐ色合いが楽しめます。",saite10000yenset,,areagate,european,,,,,,areafacade,,naturalmodern,saiteunitsetsearch,,,,,,	1008	2
1016	1	半日陰でも鮮やかに彩るセット,02_E,1.5㎡から2.0㎡,10,000,ヤマアジサイ,アベリア・ホープレイズ,リュウノヒゲ,,,,,北側などの日陰向き,足元をリュウノヒゲでギュッと引き締めて、優しいヤマアジサイの花とホープレイスの美しい斑入りが可愛いコンビネーションです。,,欧風,,自然風,,,ガーデン・庭まわり,,,和風,,1万円セット	1016	2
1024	1	半日陰　北側ファサードの植え込みにオススメの落着きのあるセット,04_B,1.5㎡から2.0㎡,10,000,シルバープリペット,ガクアジサイ,イワナンテン・アキシラリス,キチジョウソウ,,,,北側などの日陰向き,しっとりとした空間でもしっかりとした根締めのコンビに加えてパッと弾けたガクアジサイの花をミックス。さらにシルバープリペットが葉の彩りで参加する。<br>北側のファサードの植え込みにオススメです。,,欧風,アプローチ,,,ナチュラルモダン,ガーデン・庭まわり,,,和風,,1万円セット\r\n	1024	2
1017	1	日なたに最適!　ヒラドツツジの自然風セット,02_F,1.5㎡から2.0㎡,10,000,ヒラドツツジ,シモツケ・ゴールドフレーム,アジュガ,,,,,日当たりが良い植物向き,ヒラドツツジを柱にシモツケの斑入りの葉でバランスをとるプラン。<br>根締めのアジュガも彩りを添えています。,門まわり,欧風,アプローチ,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1017	2
1018	1	日陰向き　ハイノキと深い緑の和風セット,03_A,1.5㎡から2.0㎡,10,000,ハイノキ,ヤブラン,タマリュウ,,,,,北側などの日陰向き,しっとりとした小さなスペースでも安定。<br>深めで柔らかい緑にできるコンビ。<br>ハイノキは春先に咲く白い花、細かく可愛い葉を加えて華奢な株立ちが清々しいです。,門まわり,,アプローチ,自然風,ファサード,,,,,和風,,1万円セット	1018	2
1020	1	日なた向き　銅葉のトキワマンサクのリズミカルなセット,03_C,1.5㎡から2.0㎡,10,000,トキワマンサク（赤花赤葉）,アベリア・コンフェッティ,芝生(ビクトール),,,,,日当たりが良い植物向き,美しい可愛いコンフェッティと芝生のコンビネーション。<br>ポイントはトキワマンサクの銅葉の使い方!<br>特に列植の場合リズムよくトキワを入れると連続したパターンができます。,門まわり,欧風,アプローチ,,ファサード,ナチュラルモダン,,,,,,1万円セット\r\n	1020	2
1021	1	日なた向き　オリーブの元気なナチュラルセット,03_D,1.5㎡から2.0㎡,10,000,オリーブ,フィリフェラオーレア,芝生(ビクトール),,,,,日当たりが良い植物向き,明るいゴールドリーフを芝生のスッキリ元気な組み合わせ。<br>特に南にオススメでシルバーブルーのオリーブのリズム感が新鮮。,,欧風,,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1021	2
1022	1	日向から半日陰　王道の自然風セット,03_F,1.5㎡から2.0㎡,10,000,オオデマリ,イワナンテン・アキシラリス,タマリュウ,,,,,半日陰から日陰向き,とにかくアキシラリスだけでも楽しい。<br>ポイントはオオデマリで流れ落ちるような花をどこに植えるかが腕の見せ所。,,,アプローチ,自然風,ファサード,,ガーデン・庭まわり,,,和風,,1万円セット,saiteunitsetsearch\r\n	1022	2
1023	1	日なた向き　明るさ満点のナチュラルセット,04_A,1.5㎡から2.0㎡,10,000,オウゴンマサキ,ギルドエッジ,アベリア・コンフェッティ,芝生(ビクトール),,,,日当たりが良い植物向き,それぞれ明るさ満点の植物!<br>ポイントにオウゴンマサキをチョイス。<br>寄せ植えの明るさに加え、鮮やかな新芽がとても目を引くコンビネーション。,,欧風,,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1023	2
1025	1	日なた向き　シルバーホワイトを基調としたナチュラルセット,04_C,1.5㎡から2.0㎡,10,000,オリーブ,シルバープリペット,バーハーバー,芝生(ビクトール),,,,日当たりが良い植物向き,シルバーアンドホワイトのコンビネーション。<br>夏の日差しにもブルーが映え、冬はシルバーの彩りになります。,門まわり,欧風,,,,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1025	2
1026	1	日なた向き　美しいベルトを作る味わい深いセット,04_D,1.5㎡から2.0㎡,10,000,オウゴンマサキ,ボックスウッド,ガザニア(白),芝生(ビクトール),,,,日当たりが良い植物向き,淡い緑で耳たぶのように可愛い葉っぱのボックスウッドで足元をガザニアの白い花が彩ります。<br>ポイントをオウゴンマサキと縁取りの芝生が美しいベルトを作ります。,門まわり,欧風,,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1026	2
1028	1	半日陰向き　春先に咲くサツキとヒュウガミズキの安定のセット,04_F,1.5㎡から2.0㎡,10,000,トサミズキ,ヒュウガミズキ,サツキ,ヤブラン,,,,半日陰・朝日を好む植物向き,足元をサツキでしっかり押さえた安定モデル。<br>春先に二種類の灌木の可愛い花が彩ります。,門まわり,,,,ファサード,,ガーデン・庭まわり,,,和風,,1万円セット	1028	2
1029	1	日なたから半日陰向き　明るいナチュラルモダンセット,05_A,1.5㎡から2.0㎡,10,000,ガクアジサイ,コバノズイナ,シモツケ・ゴールドフレーム,フイリヤブラン,,,,日なたから半日陰向き西側もOK,シックなアジサイ、小さくて主張しないコバノズイナに明るい葉色のシモツケと斑入りのヤブランが入るとナチュラルでいてモダンで明るく成ります。,門まわり,欧風,アプローチ,,ファサード,ナチュラルモダン,,,,和風,,1万円セット	1029	2
1030	1	半日陰むき　階段壁沿いにも合うナチュラルセット,05_B,1.5㎡から2.0㎡,10,000,コバノズイナ,コデマリ,アベリア・ホープレイズ,キチジョウソウ,,,,半日陰・朝日を好む植物向き,型にはまらない樹姿の灌木２種は、アプローチや階段、壁沿いにゆったりとした空間を演出してくれ、春には新芽と花が可愛らしく揺れます。,門まわり,,,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1030	2
1031	1	日なたから半日陰向き　シルバーホワイトセット,05_C,1.5㎡から2.0㎡,10,000,バーハーバー,シルバープリペット,ラベンダー,タツタナデシコ,,,,日なたから半日陰向き西側もOK,シルバーホワイト系の色みを基調に、少し広めのスペースがあれば個性的でボリューミーな空間に成ります。<br>冬には小さな白花の植物やハーブをもう１種加えると更に美しいガーデンスペースが楽しめます。,門まわり,欧風,,,ファサード,,ガーデン・庭まわり,シンプルモダン,,,,1万円セット\r\n	1031	2
1032	1	日なた向き　柔らかい印象のナチュラルセット,05_D,1.5㎡から2.0㎡,10,000,フィリフェラオーレア,ギルドエッジ,アベリア・コンフェッティ,バーベナ,,,,日当たりが良い植物向き,オーレアをはじめ、しっかり目の色姿で個性派の植物をバーベナが柔らかくつつんでくれる構成です。,門まわり,欧風,アプローチ,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1032	2
1033	1	日なた向き　黄色イメージの彩りを楽しむナチュラルセット,05_E,1.5㎡から2.0㎡,10,000,レンギョウ,フィリフェラオーレア,アベリア・コンフェッティ,ガザニア（白）,,,,日当たりが良い植物向き,黄色系の花、葉色で性質も強めの植物が主役で、引き立て役には主役にも負けない強さを持ち、花も長く楽しめる白花の宿根ガサニアのを組合わせ、道路沿い等でも強さもあり、彩りも楽しめるモデルです。,,欧風,,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,車庫まわり,1万円セット\r\n	1033	2
1034	1	日なた向き　季節の花が楽しめるローメンテナンスセット,05_F,1.5㎡から2.0㎡,10,000,アガパンサス,ヒペリカム・ヒデコート,ヘメロカリス,ヒペリカム・カリシナム,,,,日当たりが良い植物向き,強靭なペレニアルの組み合わせ!<br>草の事も気になるが手入れもなかなか手が回らない、それでも季節の花が欲しい方向けです!(広い面積にも応用が簡単、カリシナムが少々の法面にも対応にゆきます),門まわり,欧風,アプローチ,,ファサード,ナチュラルモダン,,シンプルモダン,,,,1万円セット	1034	2
1035	1	日陰向き　小さな空間にも対応！爽やかな植栽セット,05_G,1.5㎡から2.0㎡,10,000,シロヤマブキ,ヤマアジサイ,クリスマスローズ,ヤブラン,,,,北側などの日陰向き,一言で表せば、爽やかなチーム。<br>しっとりとした小さな空間でも人目を引く清楚な花と、多彩な葉姿が楽しめます。,門まわり,,,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,和風,車庫まわり,1万円セット	1035	2
1036	1	日陰向き　落ち着いた空間を演出する味わいセット,05_H,1.5㎡から2.0㎡,10,000,ヒイラギナンテン,イワナンテン・レインボー,イワナンテン・アキシラリス,タマリュウ,,,,北側などの日陰向き,和風、洋風と言うとまったく違った印象を持ちますが、しっとりとしたエリアに馴染んでくれる和洋問わない彩のあるモデルで、水鉢や石、アイアンのオブジェ等のスパイスを加えると落ち着いた庭空間として味わいも深く楽しめます。,門まわり,欧風,アプローチ,,ファサード,,,,,和風,,1万円セット	1036	2
1041	1	日陰OK! 白い花を基調とした爽やかなセット,07_B,1.5㎡から2.0㎡,10,000,ヤマアジサイ,シロヤマブキ,ヒメウツギ,キチジョウソウ,,,,北側などの日陰向き,清楚でさわさわとした植物はしっとりした少しシャディーな空間の主役。<br>キチジョウソウが冬の足元で優しく緑の主役を演じます。<br>,,欧風,アプローチ,自然風,,,ガーデン・庭まわり,,,和風,,1万円セット	1041	2
1038	1	日なた向き　広めでも狭いエリアでも対応!欧風ナチュラルセット,06_B,1.5㎡から2.0㎡,10,000,シルバープリペット,シモツケ・ゴールドフレーム,ヘメロカリス,ヒメイワダレソウ,,,,日当たりが良い植物向き,シルバープリペットをどの位の大きさで仕立てるかがポイント!<br>広めのスペースなら葉張りを活かしてボリーム感を出して、また、狭めの長いスペースは刈り込んでスッキリ仕立ててもOKです！,門まわり,欧風,,自然風,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1038	2
1039	1	日なた向き　トロピカルな雰囲気の個性派セット,06_C,1.5㎡から2.0㎡,10,000,オリーブ,フィリフェラオーレア,アベリア・コンフェッティ,ガザニア（黄）,,,,日当たりが良い植物向き,ほんの少しトロピカルな雰囲気を感じさせてくれて個性的です。<br>夏の日差しにもしっかり主張してくれる組合せです！,門まわり,欧風,,,ファサード,,,シンプルモダン,,,,1万円セット	1039	2
1040	1	日なた向き　黄色い葉とブルーシルバーのオリーブで欧風セット,07_A,1.5㎡から2.0㎡,10,000,オリーブ,ギルドエッジ,フィリフェラオーレア,タツタナデシコ,,,,日当たりが良い植物向き,強く個性的な黄色のコンビを、オリーブとナデシコのブルーシルバー葉が引き締める。<br>春先のピンクの花も艶やかでかわいい。,門まわり,欧風,,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1040	2
1043	1	日陰向き　季節で変わる風景を楽しむセット,08_A,1.5㎡から2.0㎡,10,000,ヤマアジサイ,シロヤマブキ,クリスマスローズ,タマリュウ,,,,北側などの日陰向き,冬に葉が落ちる潅木の枝姿も美しく楽しみましょう。<br>足元には深い緑が寄り添ってくれます。,門まわり,,アプローチ,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,和風,,1万円セット	1043	2
1052	1	日陰向き　優しい空間を演出するナチュラルセット,13_A,2.5㎡から3.0㎡,20,000,ヒイラギナンテン,シロヤマブキ,ヒゼンマユミ,コバノズイナ,クリスマスローズ,ギボウシ（大）,タマリュウ,北側などの日陰向き,しっとりとしたスペースにこのままでも綺麗なお庭の空間になりますが、好きな花や球根を足せば自分らしい庭となります。,門まわり,欧風,アプローチ,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,和風,,2万円セット	1052	2
1056	1	日なた向き　狭小スペースにもOK!ローメンテナンスな欧風セット,12_B,2.5㎡から3.0㎡,20,000,オリーブ,オウゴンマサキ,シモツケ・ゴールドフレーム,ヒペリカム・カリシナム,芝生（ビクトール）,,,日当たりが良い植物向き,日あたりがよくて、ちょっとした空きのスペースがあれば植物が苦手、手入れが下手な方でもOK!オフィスや駐車場の傍を明るく楽しいスペースにしてくれます。,門まわり,欧風,アプローチ,,,ナチュラルモダン,ガーデン・庭まわり,,,,,2万円セット	1056	2
1042	1	日陰向き　落ち着いた雰囲気の和風セット,07_C,1.5㎡から2.0㎡,10,000,クロモジ,イワナンテン・レインボー,イワナンテン・アキシラリス,ヤブラン,,,,北側などの日陰向き,しっとりとしたスペースに葉色も構成も落ち着いた雰囲気にしても悪くないでしょう。<br>動きは枝や幹肌の綺麗な樹木(クロモジ、アオダモ、シラキ、シャラ、マユミ)等で表現してみませんか？,門まわり,,,自然風,,,ガーデン・庭まわり,,,和風,,1万円セット,saiteunitsetsearch	1042	2
1044	1	日なた向き　しっかりとした枝葉のギルドエッジとレンギョウのナチュラルセット,08_B,1.5㎡から2.0㎡,10,000,レンギョウ,ギルドエッジ,マホニアコンフーサー,アジュガ,,,,日当たりが良い植物向き,しっかりとした枝形と葉形の主役をコンフーサの細やかな葉が包む。<br>地被のアジュガはしっかり光を浴びてすっとした花が楽しい。,,欧風,アプローチ,,,ナチュラルモダン,ガーデン・庭まわり,,,,,1万円セット	1044	2
1045	1	日陰向き　季節で変わる色合いを楽しめるセット,09_A,1.5㎡から2.0㎡,10,000,ヒイラギナンテン,シロヤマブキ,クリスマスローズ,ギンバイカ,イワナンテン・アキシラリス,キチジョウソウ,,北側などの日陰向き,赤、紅、濃緑、そして季節の花。<br>しっとりとして空間にも負けない色合いと、このメンバーだけでも飽きさせない構成となっています。,,欧風,,自然風,ファサード,,ガーデン・庭まわり,,,和風,車庫まわり,1万円セット	1045	2
1047	1	日なた向き　シンプルで綺麗なリーフの定番セット,10_A,2.5㎡から3.0㎡,20,000,フィリフェラオーレア,アベリア・コンフェッティ,アジュガ,,,,,日当たりが良い植物向き,樹木候補：シマトネリコ、アメリカザイフリボク、サルスベリなど<br>シンプルで綺麗なリーフで明るく彩る定番モデル。<br>コニファーや果実類の小中木と合わせると一層楽しめます。,門まわり,欧風,,,ファサード,,ガーデン・庭まわり,シンプルモダン,,,,2万円セット	1047	2
1055	1	日なた向き　黄色とブルーシルバーの欧風セット,12_A,2.5㎡から3.0㎡,20,000,オリーブ,レンギョウ,フィリフェラオーレア,アベリア・コンフェッティ,タツタナデシコ,,,日当たりが良い植物向き,春先から秋頃までの黄色系と、冬でも映えるブルーシルバー系を中心に組み合わせました。<br>足元に咲くナデシコのピンクもポイントです。,門まわり,欧風,,,ファサード,,ガーデン・庭まわり,,,,,2万円セット	1055	2
1049	1	日陰OK! しっとりした空間を季節ごとに彩る和風セット,11_A,2.5㎡から3.0㎡,20,000,フイリアオキ,ガクアジサイ,ヒメウツギ,イワナンテン・アキシラリス,ヤブラン,,,北側などの日陰向き,しっとりとした空間。エリアにも強めの押さえが必要な場所があります。それを少しガクアジサイが和らげ、ウツギが動きを演出して足元は季節の中でもう一つの主役の赤が美しく映えます。,,,アプローチ,自然風,,ナチュラルモダン,ガーデン・庭まわり,,,和風,,2万円セット	1049	2
1050	1	日なた向き　多様な組み合わせで元気なセット,11_B,2.5㎡から3.0㎡,20,000,オウゴンマサキ,ユキヤナギ,アガパンサス,アベリア・ホープレイス,ガザニア(白),,,日当たりが良い植物向き,葉の形、色合いなど多様な組み合わせでお互い引き立てあって元気で楽しい構成です。,門まわり,欧風,,,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,,,2万円セット	1050	2
1053	1	日陰向き　濃い緑から明るい緑の葉をミックスしたナチュラルセット,14_A,2.5㎡から3.0㎡,30,000,ガクアジサイ,コバノズイナ,ハクサンボク,アベリア・ホープレイズ,キチジョウソウ,タマリュウ,,北側などの日陰向き,樹木候補：シロモジ、ヤマボウシ、ガマズミ、アメリカザイフリボク<br>小さなスペースでも奥行の感じられる構成です。濃い緑の葉から明るい緑までバラエティー豊か、ビオラやアリッサムなどの小さな花を季節ごとにほんの少し足すとかわいい私だけの空間になります。,,,アプローチ,自然風,ファサード,ナチュラルモダン,ガーデン・庭まわり,,,和風,,３万円セット	1053	2
39	1	常緑性で艶のある葉が特徴。耐陰性が強いため、直射日光が当たらない場所でもシェードガーデン(日陰の庭)でも重宝します。	39	2
1010	1	全方向OK!　コバノズイナの紅葉がオススメ自然風セット,01_K,1.5㎡から2.0㎡,10,000,コバノズイナ,アベリア・コンフェッティ,,,,,,全方向OK!幅広く植えられます,冬に残り枝となるコバノズイナも春の芽立ちと猫じゃらしのような花が可愛い。<br>また、ブルーベリーを思わせるような紅葉も見逃せない。<br>やや濃い斑入りのコンフェッティで足元を鮮やかにします。,,欧風,アプローチ,自然風,,ナチュラルモダン,ガーデン・庭まわり,,狭小地,,,1万円セット	1010	2
1001	1	2_1001,01_B,全方位OKカラーリーフが楽しめるセット,1.5㎡から2.0㎡,"10,000",アベリア・ホープレイズ,オタフクナンテン,,,,,,全方向OK!幅広く植えられます,hokuseiarea_hokutouarea_nantouarea_nanseiarea,日当たりの量や温度によって多彩な色合いを見せるそれぞれの植物の特徴を使って彩りのある空間ができます。,saite10000yenset,,areagate,european,,,,naturalair,,areafacade,,naturalmodern,saiteunitsetsearch,,,,areanarrow,,	1001	2
1057	1	多年草	1057	1
1058	1		1058	1
1059	1		1059	2
1060	1		1060	1
1000	1	01_A,半日陰自然風セット,1.5㎡から2.0㎡,"10,000",ヤマアジサイ,ギンバイカ,,,,,,北側などの日陰向き,hokuseiarea_hokutouarea,優しい花のヤマアジサイの足元に可愛らしくもしっかりしたギンバイカの葉が一年中映えます。,saite10000yenset,hokuseiarea,,,,hokutouarea,areaapproach,naturalair,,,,,saiteunitsetsearch,areagarden,,,,,1万円セット	1000	2
1062	1		1062	2
1063	1		1063	2
1067	1	宿根草セット	1067	1000
1066	1	宿根草セット	1066	1000
1065	1	宿根草セット	1065	1000
1064	1	宿根草セット	1064	1000
1061	1	宿根草セット	1061	1000
\.


--
-- Name: item_description_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('item_description_seq', 1067, true);


--
-- Data for Name: item_name; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY item_name (item_name_id, locale_id, item_id, item_name) FROM stdin;
1	1	1	ハチジョウススキ・ガバレット
2	1	2	シマススキ
3	1	3	ワイルドオーツ
4	1	4	メリニス・サヴァンナ
5	1	5	カレックス・アウバウム
6	1	6	カレックス・アマゾンミスト
7	1	7	イトススキ (斑入り)
8	1	8	シモツケ
9	1	9	コデマリ・ピンクアイス
10	1	10	ユキヤナギ・オーレア
11	1	11	サルスベリ・チカソー
12	1	12	オオベニウツギ (斑入り)
13	1	13	コバノズイナ
14	1	14	フィソカルパス・ダーツゴールド
15	1	15	イエローストロベリーグァバ
16	1	16	ウツギ (白花)
17	1	17	オオベニウツギ・ブライアントルビドール
18	1	18	サラサウツギ
19	1	19	トキワマンサク (ピンク花)
20	1	20	紅タニウツギ
21	1	21	オーデコロンミント
22	1	22	ジンジャーミント
23	1	23	オミナエシ
24	1	24	ペンステモン・ハスカーレッド
25	1	25	スイショウラン
26	1	26	ツルバキア・シルバーレース
27	1	27	サルビア・エレガンス
28	1	28	サルビア・エレガンスゴールデンデリシャス
29	1	29	サルビア・メキシカナライムライト
30	1	30	ヤマアジサイ・綾
31	1	31	ヤマアジサイ・別子てまり
32	1	32	ヤマアジサイ・レイコ
33	1	33	ヤマアジサイ・紅花
34	1	34	ヤマアジサイ・白花
35	1	35	ヤマアジサイ・白妙
36	1	36	ヤマアジサイ・紅花甘茶
37	1	37	ヤマアジサイ・白花甘茶
38	1	38	ヤマアジサイ・るりあざみ
39	1	39	アオキ
40	1	40	アオダモ（カブ）
41	1	41	アオハダ（カブ）
42	1	42	アガパンサス
43	1	43	アジサイ
44	1	44	アジュガ
45	1	45	アズキナシ
46	1	46	アズキナシ（カブ）
47	1	47	アズキナシ（カブ）
48	1	48	アブラチャン
49	1	49	アベリア
50	1	50	アベリア・エドワードゴーチャー
51	1	51	アベリア・コンフェッティー
52	1	52	アベリア・ホープレイズ
53	1	53	アメリカザイフリボク
54	1	54	アメリカザイフリボク
55	1	55	アメリカザイフリボク（カブ）
56	1	56	アメリカザイフリボク（カブ）
57	1	57	イヌツゲ・ゴールデンジェム
58	1	58	イヌツゲ・ヒレリー
59	1	59	イロハモミジ
60	1	60	イロハモミジ（カブ）
61	1	61	イロハモミジ（カブ）
62	1	62	イワナンテン・アキシラリス
63	1	63	イワナンテン・レインボー
64	1	64	ウバメガシ（生垣）
65	1	65	ウメモドキ
66	1	66	エゴノキ（カブ）
67	1	67	エゴノキ・ピンクチャイム（カブ）
68	1	68	オウゴンマサキ
69	1	69	オウゴンマサキ
70	1	70	オカメザサ
71	1	71	オタフクナンテン
72	1	72	オタフクナンテン
73	1	73	オリーブ
74	1	74	オリーブ
75	1	75	オリーブ
76	1	76	オリーブ
77	1	77	オリーブ
78	1	78	ガクアジサイ
79	1	79	カクレミノ
80	1	80	カクレミノ
81	1	81	カシワバアジサイ
82	1	82	カツラ（カブ）
83	1	83	ガマズミ
84	1	84	ガマズミ
85	1	85	ガマズミ
86	1	86	カリン
87	1	87	カルーナ
88	1	88	カルーナ・アレグロ
89	1	89	カンボク
90	1	90	キチジョウソウ
91	1	91	キリシマツツジ
92	1	92	ギルドエッジ
93	1	93	ギンバイカ
94	1	94	キンマサキ
95	1	95	ギンマサキ
96	1	96	クリーピングタイム
97	1	97	クリスマスローズ
98	1	98	クリスマスローズ(ニガー・オリエンタス)
99	1	99	クリスマスローズ（黄緑）
100	1	100	クリスマスローズ（紫）
101	1	101	クリスマスローズ（赤）
102	1	102	クルメツツジ
103	1	103	クルメツツジ
104	1	104	クルメツツジ（オイノメザメ）
105	1	105	クルメツツジ（ピンク）
106	1	106	クルメツツジ（ムラサキ）
107	1	107	クルメツツジ（混色）
108	1	108	クルメツツジ（赤）
109	1	109	クルメツツジ（白）
110	1	110	クロモジ
111	1	111	クロモジ（カブ）
112	1	112	クロモジ（カブ）
113	1	113	ゲッケイジュ
114	1	114	ゲッケイジュ
115	1	115	ゲッケイジュ・オーレア
116	1	116	イヌツゲ・ゴールデンジェム
117	1	117	コクチナシ
118	1	118	コグマザサ
119	1	119	コデマリ
120	1	120	コデマリ
121	1	121	コトネアスター
122	1	122	コブシ
123	1	123	サツキ
124	1	124	サワフタギ
125	1	125	サワフタギ
126	1	126	シシガシラ
127	1	127	シダ
128	1	128	シバザクラ
129	1	129	シマトネリコ
130	1	130	シマトネリコ（カブ）
131	1	131	シマトネリコ（カブ）
132	1	132	シモツケ・ゴールドフレーム
133	1	133	シャラ（カブ）
134	1	134	シャリンバイ（ピンク）
135	1	135	シャリンバイ（紅花）
136	1	136	シャリンバイ（白）
137	1	137	ジョウリョクヤマボウシ
138	1	138	シラカシ
139	1	139	シラカシ
140	1	140	シラカシ
141	1	141	シラカシ
142	1	142	シラカシ（カブ）
143	1	143	シラカシ（カブ）
144	1	144	シラカシ（カブ）
145	1	145	シラカシ（カブ）
146	1	146	シルバープリペット
147	1	147	シルバープリペット
148	1	148	シルバープリペット
149	1	149	シロダモ
150	1	150	シロダモ
151	1	151	シロダモ
152	1	152	シロダモ
153	1	153	シロダモ（カブ）
154	1	154	シロヤマブキ
155	1	155	シロワビスケ
156	1	156	シロワビスケ
157	1	157	スモークツリー・グレース
158	1	158	スモークツリー・ヤングレディー
159	1	159	ソヨゴ
160	1	160	ソヨゴ
161	1	161	ソヨゴ（カブ）
162	1	162	ソヨゴ（カブ）
163	1	163	ダンコウバイ
164	1	164	ダンコウバイ
165	1	165	チョコベリー（カブ）
166	1	166	ツリバナ
167	1	167	ツリバナ
168	1	168	ツリバナ
169	1	169	ツリバナ
170	1	170	ツワブキ
171	1	171	ドウダンツツジ
172	1	172	ドウダンツツジ
173	1	173	ドウダンツツジ
174	1	174	ドウダンツツジ
175	1	175	ドウダンツツジ
176	1	176	ドウダンツツジ
177	1	177	トウネズミモチトリカラー
178	1	178	トウネズミモチトリカラー
179	1	179	トウネズミモチトリカラー
180	1	180	トキワマンサク（青葉赤花）
181	1	181	トキワマンサク（赤葉赤花）
182	1	182	トキワマンサク（青葉）
183	1	183	トキワマンサク（青葉赤花）
184	1	184	トキワマンサク（青葉白花）
185	1	185	トキワマンサク（青葉白花）
186	1	186	トキワマンサク（赤花青葉）
187	1	187	トキワマンサク（赤花赤葉）
188	1	188	トキワマンサク（赤花赤葉）
189	1	189	トキワマンサク（赤葉）
190	1	190	トキワマンサク（赤葉）
191	1	191	トキワマンサク（赤葉赤花）
192	1	192	トキワマンサク青葉（白）
193	1	193	トキワマンサク赤葉（赤）
194	1	194	トサミズキ
195	1	195	トサミズキ
196	1	196	トサミズキ
197	1	197	トサミズキ
198	1	198	トサミズキ
199	1	199	ナツハゼ
200	1	200	ナツハゼ
201	1	201	ナツメ
202	1	202	ナナミノキ
203	1	203	バーハーバー
204	1	204	バーベナ
205	1	205	ハイノキ
206	1	206	ハイノキ
207	1	207	ハゴロモジャスミン
208	1	208	ハツユキカズラ
209	1	209	ハナミズキ（ピンク）
210	1	210	ハナミズキ（赤）
211	1	211	ハナミズキ（白）
212	1	212	ハマボウ
213	1	213	ヒイラギナンテン
214	1	214	ヒイラギナンテン
215	1	215	ヒイラギナンテン
216	1	216	ヒゼンマユミ
217	1	217	ヒゼンマユミ
218	1	218	ヒゼンマユミ
219	1	219	ヒゼンマユミ
220	1	220	ヒベリカム・カリシナム
221	1	221	ヒペリカム・ヒデコート
222	1	222	ヒメシャラ（カブ）
223	1	223	ヒメシャラ（カブ）
224	1	224	ヒメシャリンバイ
225	1	225	ヒメユズリハ
226	1	226	ヒメユズリハ
227	1	227	ヒメユズリハ
228	1	228	ヒメユズリハ（カブ）
229	1	229	ヒュウガミズキ
230	1	230	ヒラドツツジ（ピンク）
231	1	231	ヒラドツツジ（紫）
232	1	232	ヒラドツツジ（赤）
233	1	233	ヒラドツツジ（白）
234	1	234	ヒラドツツジ
235	1	235	ヒラドツツジ
236	1	236	ビンカマジョール
237	1	237	ビンカマジョールBG
238	1	238	フイリアオキ
239	1	239	フイリアオキ
240	1	240	フイリアオキ
241	1	241	フイリビンカ
242	1	242	フィリフェラオーレア
243	1	243	フイリヤブラン
244	1	244	フェイジョア
245	1	245	フェイジョア
246	1	246	フェイジョア
247	1	247	フェイジョア
248	1	248	フェイジョア
249	1	249	フェイジョア
250	1	250	フッキソウ
251	1	251	プリペット
252	1	252	プリペット
253	1	253	ブルーベリー
254	1	254	ブルーベリー
255	1	255	ブルーベリー
256	1	256	ブルーベリー
257	1	257	ヘデラ・カナリエンシス
258	1	258	ヘデラ・カナリエンシスBG
259	1	259	ヘデラ・ヘリックス
260	1	260	ヘデラ・ヘリックスゴールドハート
261	1	261	ヘデラ・ヘリックスバリエガータ
262	1	262	ベニシダ
263	1	263	ポートワイン
264	1	264	ポートワイン
265	1	265	ポートワイン
266	1	266	ボックスウッド
267	1	267	ボックスウッド
268	1	268	マホニアコンフーサー
269	1	269	マホニアコンフーサー
270	1	270	マホニアコンフーサー
271	1	271	マユミ
272	1	272	マユミ
273	1	273	マユミ
274	1	274	マユミ
275	1	275	マルバシャリンバイ
276	1	276	ミツバツツジ
277	1	277	ミツバツツジ
278	1	278	ミツバツツジ
279	1	279	ミツバツツジ
280	1	280	ミツバツツジ
281	1	281	ミツバツツジ
282	1	282	ミント
283	1	283	モチノキ
284	1	284	モチノキ
285	1	285	モチノキ
286	1	286	モチノキ（カブ）
287	1	287	モミジ
288	1	288	モミジ
289	1	289	ヤエヤマブキ
290	1	290	ヤブコウジ
291	1	291	ヤブツバキ
292	1	292	ヤブツバキ
293	1	293	ヤブツバキ
294	1	294	ヤブツバキ（白）
295	1	295	ヤブラン
296	1	296	ヤマブキ
297	1	297	ヤマボウシ
298	1	298	ヤマボウシ(カブ）
299	1	299	ヤマモミジ
300	1	300	ヤマモミジ（カブ）
301	1	301	ユキヤナギ
302	1	302	ユキヤナギ
303	1	303	ユキヤナギ・フジノピンキー
304	1	304	ユリオプスデージー
305	1	305	ラベンダー
306	1	306	レッドロビン
307	1	307	レモン
308	1	308	レモン
309	1	309	レンギョウ
310	1	310	レンゲツツジ
311	1	311	ローズマリー
1001	1	1001	全方位OKカラーリーフが楽しめるセット　01_B
1044	1	1044	日なた向き　しっかりとした枝葉のギルドエッジとレンギョウのナチュラルセット 08_B
1047	1	1047	日なた向き　シンプルで綺麗なリーフの定番セット 10_A
1054	1	1054	noimage
1051	1	1051	noimage
1002	1	1002	冬に咲くクリスマスローズの半日陰セット01_C
1003	1	1003	半日陰　艶のある緑のセット 01_D
1004	1	1004	日陰向き　和風コントラストセット 01_E
1005	1	1005	三ツ星！半日陰スタイルセット 01_F
1006	1	1006	日なた向き　色合いが楽しめるローメンテナンスセット　01_G
1007	1	1007	日なた向き　春先に花が咲くゴールデンコンビ　01_H
1008	1	1008	日なたから半日陰向き　斑入りの葉が華やぐナチュラルセット 01_I
1009	1	1009	日なたから半日陰向き　斑入りの葉のナチュラルセット 01_J
1010	1	1010	全方向OK!　コバノズイナの紅葉がオススメ自然風セット 01_K
1011	1	1011	日なた向き　ツツジとマホニアコンフーサのボリュームセット 01_L
1012	1	1012	日陰向き　目隠しの欲しい場所に深緑のセット 02_A
1013	1	1013	半日陰向き　白い花が咲くナチュラルセット 02_B
1014	1	1014	日なたから日陰向き　ホワイトを基調としたセット 02_C
1015	1	1015	日なた向き　爽やかなゴールデンセット 02_D
1016	1	1016	半日陰でも鮮やかに彩るセット 02_E
1017	1	1017	日なたに最適!　ヒラドツツジの自然風セット 02_F
1018	1	1018	日陰向き　ハイノキと深い緑の和風セット 03_A
1019	1	1019	半日陰向き　赤い紅葉が綺麗なコバノズイナのナチュラルセット 03_B
1020	1	1020	日なた向き　銅葉のトキワマンサクのリズミカルなセット 03_C
1021	1	1021	日なた向き　オリーブの元気なナチュラルセット 03_D
1022	1	1022	日向から半日陰　王道の自然風セット 03_F
1023	1	1023	日なた向き　明るさ満点のナチュラルセット 04_A
1024	1	1024	半日陰　北側ファサードの植え込みにオススメの落着きのあるセット 04_B
1025	1	1025	日なた向き　シルバーホワイトを基調としたナチュラルセット 04_C
1026	1	1026	日なた向き　美しいベルトを作る味わい深いセット 04_D
1027	1	1027	日なた向き　ブルーシルバー系の欧風セット 04_E
1028	1	1028	半日陰向き　春先に咲くサツキとヒュウガミズキの安定のセット 04_F
1029	1	1029	日なたから半日陰向き　明るいナチュラルモダンセット 05_A
1030	1	1030	半日陰むき　階段壁沿いにも合うナチュラルセット 05_B
1031	1	1031	日なたから半日陰向き　シルバーホワイトセット 05_C
1032	1	1032	日なた向き　柔らかい印象のナチュラルセット 05_D
1033	1	1033	日なた向き　黄色イメージの彩りを楽しむナチュラルセット 05_E
1034	1	1034	日なた向き　季節の花が楽しめるローメンテナンスセット 05_F
1035	1	1035	日陰向き　小さな空間にも対応！爽やかな植栽セット 05_G
1036	1	1036	日陰向き　落ち着いた空間を演出する味わいセット 05_H
1037	1	1037	日陰向き　どんなイメージにも合う白花が咲くナチュラルセット 06_A
1038	1	1038	日なた向き　広めでも狭いエリアでも対応!欧風ナチュラルセット 06_B
1039	1	1039	日なた向き　トロピカルな雰囲気の個性派セット 06_C
1040	1	1040	日なた向き　黄色い葉とブルーシルバーのオリーブで欧風セット 07_A
1041	1	1041	日陰OK! 白い花を基調とした爽やかなセット 07_B
1042	1	1042	日陰向き　落ち着いた雰囲気の和風セット 07_C
1043	1	1043	日陰向き　季節で変わる風景を楽しむセット 08_A
1045	1	1045	日陰向き　季節で変わる色合いを楽しめるセット 09_A
1046	1	1046	日なた向き　和風ベースの植物のナチュラルモダンセット 09_B
1048	1	1048	日陰向き　安定のしっとりとした和風セット 10_B
1049	1	1049	日陰OK! しっとりした空間を季節ごとに彩る和風セット 11_A
1050	1	1050	日なた向き　多様な組み合わせで元気なセット 11_B
1052	1	1052	日陰向き　優しい空間を演出するナチュラルセット 13_A
1053	1	1053	日陰向き　濃い緑から明るい緑の葉をミックスしたナチュラルセット 14_A
1055	1	1055	日なた向き　黄色とブルーシルバーの欧風セット 12_A
1056	1	1056	日なた向き　狭小スペースにもOK!ローメンテナンスな欧風セット 12_B
1057	1	1057	アザミ・ローズビューティー
1058	1	1058	ペニセタム・レッドボタン
1059	1	1059	アネマンセレ・シロッコ
1060	1	1060	エリムス・ブルーグラス
1000	1	1000	半日陰自然風セット 01_A
1061	1	1061	日向向き ブルー×ホワイトガーデン
1062	1	1062	日向向き　ピンク×レッドガーデン
1063	1	1063	日向向き　ビタミンカラーガーデン
1064	1	1064	日陰向き　洋風庭園
1065	1	1065	日陰向き 和モダン庭園
1067	1	1067	日向向き　ビタミンカラーガーデン
1066	1	1066	日向向き　ピンク×レッドガーデン
\.


--
-- Name: item_name_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('item_name_seq', 1067, true);


--
-- Data for Name: item_numeric_metadata; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY item_numeric_metadata (item_numeric_metadata_id, item_id, metadata_type, metadata) FROM stdin;
\.


--
-- Name: item_numeric_metadata_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('item_numeric_metadata_seq', 1000, true);


--
-- Data for Name: item_price; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY item_price (item_price_id, site_id, item_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	1	37
38	1	38
39	2	39
40	2	40
41	2	41
42	2	42
43	2	43
44	2	44
45	2	45
46	2	46
47	2	47
48	2	48
49	2	49
50	2	50
51	2	51
52	2	52
53	2	53
54	2	54
55	2	55
56	2	56
57	2	57
58	2	58
59	2	59
60	2	60
61	2	61
62	2	62
63	2	63
64	2	64
65	2	65
66	2	66
67	2	67
68	2	68
69	2	69
70	2	70
71	2	71
72	2	72
73	2	73
74	2	74
75	2	75
76	2	76
77	2	77
78	2	78
79	2	79
80	2	80
81	2	81
82	2	82
83	2	83
84	2	84
85	2	85
86	2	86
87	2	87
88	2	88
89	2	89
90	2	90
91	2	91
92	2	92
93	2	93
94	2	94
95	2	95
96	2	96
97	2	97
98	2	98
99	2	99
100	2	100
101	2	101
102	2	102
103	2	103
104	2	104
105	2	105
106	2	106
107	2	107
108	2	108
109	2	109
110	2	110
111	2	111
112	2	112
113	2	113
114	2	114
115	2	115
116	2	116
117	2	117
118	2	118
119	2	119
120	2	120
121	2	121
122	2	122
123	2	123
124	2	124
125	2	125
126	2	126
127	2	127
128	2	128
129	2	129
130	2	130
131	2	131
132	2	132
133	2	133
134	2	134
135	2	135
136	2	136
137	2	137
138	2	138
139	2	139
140	2	140
141	2	141
142	2	142
143	2	143
144	2	144
145	2	145
146	2	146
147	2	147
148	2	148
149	2	149
150	2	150
151	2	151
152	2	152
153	2	153
154	2	154
155	2	155
156	2	156
157	2	157
158	2	158
159	2	159
160	2	160
161	2	161
162	2	162
163	2	163
164	2	164
165	2	165
166	2	166
167	2	167
168	2	168
169	2	169
170	2	170
171	2	171
172	2	172
173	2	173
174	2	174
175	2	175
176	2	176
177	2	177
178	2	178
179	2	179
180	2	180
181	2	181
182	2	182
183	2	183
184	2	184
185	2	185
186	2	186
187	2	187
188	2	188
189	2	189
190	2	190
191	2	191
192	2	192
193	2	193
194	2	194
195	2	195
196	2	196
197	2	197
198	2	198
199	2	199
200	2	200
201	2	201
202	2	202
203	2	203
204	2	204
205	2	205
206	2	206
207	2	207
208	2	208
209	2	209
210	2	210
211	2	211
212	2	212
213	2	213
214	2	214
215	2	215
216	2	216
217	2	217
218	2	218
219	2	219
220	2	220
221	2	221
222	2	222
223	2	223
224	2	224
225	2	225
226	2	226
227	2	227
228	2	228
229	2	229
230	2	230
231	2	231
232	2	232
233	2	233
234	2	234
235	2	235
236	2	236
237	2	237
238	2	238
239	2	239
240	2	240
241	2	241
242	2	242
243	2	243
244	2	244
245	2	245
246	2	246
247	2	247
248	2	248
249	2	249
250	2	250
251	2	251
252	2	252
253	2	253
254	2	254
255	2	255
256	2	256
257	2	257
258	2	258
259	2	259
260	2	260
261	2	261
262	2	262
263	2	263
264	2	264
265	2	265
266	2	266
267	2	267
268	2	268
269	2	269
270	2	270
271	2	271
272	2	272
273	2	273
274	2	274
275	2	275
276	2	276
277	2	277
278	2	278
279	2	279
280	2	280
281	2	281
282	2	282
283	2	283
284	2	284
285	2	285
286	2	286
287	2	287
288	2	288
289	2	289
290	2	290
291	2	291
292	2	292
293	2	293
294	2	294
295	2	295
296	2	296
297	2	297
298	2	298
299	2	299
300	2	300
301	2	301
302	2	302
303	2	303
304	2	304
305	2	305
306	2	306
307	2	307
308	2	308
309	2	309
310	2	310
311	2	311
1000	2	1000
1001	2	1001
1002	2	1002
1003	2	1003
1004	2	1004
1005	2	1005
1006	2	1006
1007	2	1007
1008	2	1008
1009	2	1009
1010	2	1010
1011	2	1011
1012	2	1012
1013	2	1013
1014	2	1014
1015	2	1015
1016	2	1016
1017	2	1017
1018	2	1018
1019	2	1019
1020	2	1020
1021	2	1021
1022	2	1022
1023	2	1023
1024	2	1024
1025	2	1025
1026	2	1026
1027	2	1027
1028	2	1028
1029	2	1029
1030	2	1030
1031	2	1031
1032	2	1032
1033	2	1033
1034	2	1034
1035	2	1035
1036	2	1036
1037	2	1037
1038	2	1038
1039	2	1039
1040	2	1040
1041	2	1041
1042	2	1042
1043	2	1043
1044	2	1044
1045	2	1045
1046	2	1046
1047	2	1047
1048	2	1048
1049	2	1049
1050	2	1050
1051	2	1051
1052	2	1052
1053	2	1053
1055	2	1055
1056	2	1056
1057	1	1057
1058	1	1058
1059	2	1059
1060	1	1060
1061	1	1059
1062	1000	1061
1063	2	1062
1064	2	1063
1065	1000	1064
1066	1000	1065
1067	1000	1062
1068	1000	1063
1069	1000	1066
1070	1000	1067
1072	1	1054
\.


--
-- Data for Name: item_price_history; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY item_price_history (item_price_history_id, item_price_id, tax_id, currency_id, unit_price, valid_until, cost_price) FROM stdin;
1057	1057	2	1	710.00	9999-12-31 23:59:59	600.00
1061	1062	2	1	10000.00	9999-12-31 23:59:59	6000.00
1	1	2	1	1000.00	9999-12-31 00:00:00	0.00
1058	1058	2	1	940.00	9999-12-31 23:59:59	800.00
1062	1063	2	1	10000.00	9999-12-31 23:59:59	6000.00
1069	1072	2	1	1000.00	9999-12-31 23:59:59	700.00
1059	1059	2	1	940.00	9999-12-31 23:59:59	800.00
1063	1064	2	1	10000.00	9999-12-31 23:59:59	6000.00
1065	1066	2	1	10000.00	9999-12-31 23:59:59	6000.00
1066	1069	2	1	10000.00	9999-12-31 23:59:59	6000.00
1060	1060	2	1	940.00	9999-12-31 23:59:59	800.00
1064	1065	2	1	10000.00	9999-12-31 23:59:59	6000.00
1067	1070	2	1	10000.00	9999-12-31 23:59:59	6000.00
2	2	2	1	800.00	9999-12-31 00:00:00	0.00
3	3	2	1	1200.00	9999-12-31 00:00:00	0.00
4	4	2	1	1100.00	9999-12-31 00:00:00	0.00
5	5	2	1	420.00	9999-12-31 00:00:00	0.00
6	6	2	1	430.00	9999-12-31 00:00:00	0.00
7	7	2	1	400.00	9999-12-31 00:00:00	0.00
8	8	2	1	1500.00	9999-12-31 00:00:00	0.00
9	9	2	1	1500.00	9999-12-31 00:00:00	0.00
10	10	2	1	1600.00	9999-12-31 00:00:00	0.00
11	11	2	1	1750.00	9999-12-31 00:00:00	0.00
12	12	2	1	1200.00	9999-12-31 00:00:00	0.00
13	13	2	1	1450.00	9999-12-31 00:00:00	0.00
14	14	2	1	1300.00	9999-12-31 00:00:00	0.00
16	16	2	1	1400.00	9999-12-31 00:00:00	0.00
17	17	2	1	1350.00	9999-12-31 00:00:00	0.00
18	18	2	1	1400.00	9999-12-31 00:00:00	0.00
19	19	2	1	1500.00	9999-12-31 00:00:00	0.00
292	292	2	1	4800.00	9999-12-31 00:00:00	0.00
293	293	2	1	6400.00	9999-12-31 00:00:00	0.00
20	20	2	1	1400.00	9999-12-31 00:00:00	0.00
21	21	2	1	500.00	9999-12-31 00:00:00	0.00
22	22	2	1	500.00	9999-12-31 00:00:00	0.00
23	23	2	1	500.00	9999-12-31 00:00:00	0.00
24	24	2	1	500.00	9999-12-31 00:00:00	0.00
25	25	2	1	800.00	9999-12-31 00:00:00	0.00
26	26	2	1	800.00	9999-12-31 00:00:00	0.00
27	27	2	1	400.00	9999-12-31 00:00:00	0.00
28	28	2	1	400.00	9999-12-31 00:00:00	0.00
29	29	2	1	400.00	9999-12-31 00:00:00	0.00
30	30	2	1	1000.00	9999-12-31 00:00:00	0.00
31	31	2	1	1200.00	9999-12-31 00:00:00	0.00
32	32	2	1	1000.00	9999-12-31 00:00:00	0.00
33	33	2	1	1000.00	9999-12-31 00:00:00	0.00
34	34	2	1	1000.00	9999-12-31 00:00:00	0.00
35	35	2	1	1000.00	9999-12-31 00:00:00	0.00
36	36	2	1	1000.00	9999-12-31 00:00:00	0.00
37	37	2	1	1000.00	9999-12-31 00:00:00	0.00
38	38	2	1	1200.00	9999-12-31 00:00:00	0.00
40	40	2	1	10400.00	9999-12-31 00:00:00	0.00
41	41	2	1	10600.00	9999-12-31 00:00:00	0.00
42	42	2	1	300.00	9999-12-31 00:00:00	0.00
43	43	2	1	500.00	9999-12-31 00:00:00	0.00
44	44	2	1	200.00	9999-12-31 00:00:00	0.00
45	45	2	1	6900.00	9999-12-31 00:00:00	0.00
46	46	2	1	4800.00	9999-12-31 00:00:00	0.00
47	47	2	1	9000.00	9999-12-31 00:00:00	0.00
48	48	2	1	10600.00	9999-12-31 00:00:00	0.00
49	49	2	1	400.00	9999-12-31 00:00:00	0.00
50	50	2	1	400.00	9999-12-31 00:00:00	0.00
51	51	2	1	400.00	9999-12-31 00:00:00	0.00
52	52	2	1	500.00	9999-12-31 00:00:00	0.00
53	53	2	1	5800.00	9999-12-31 00:00:00	0.00
54	54	2	1	9500.00	9999-12-31 00:00:00	0.00
55	55	2	1	7400.00	9999-12-31 00:00:00	0.00
56	56	2	1	10000.00	9999-12-31 00:00:00	0.00
57	57	2	1	600.00	9999-12-31 00:00:00	0.00
58	58	2	1	500.00	9999-12-31 00:00:00	0.00
59	59	2	1	4800.00	9999-12-31 00:00:00	0.00
60	60	2	1	4800.00	9999-12-31 00:00:00	0.00
61	61	2	1	9000.00	9999-12-31 00:00:00	0.00
62	62	2	1	400.00	9999-12-31 00:00:00	0.00
63	63	2	1	500.00	9999-12-31 00:00:00	0.00
64	64	2	1	1100.00	9999-12-31 00:00:00	0.00
65	65	2	1	3000.00	9999-12-31 00:00:00	0.00
66	66	2	1	6400.00	9999-12-31 00:00:00	0.00
67	67	2	1	13700.00	9999-12-31 00:00:00	0.00
68	68	2	1	1100.00	9999-12-31 00:00:00	0.00
69	69	2	1	1800.00	9999-12-31 00:00:00	0.00
70	70	2	1	200.00	9999-12-31 00:00:00	0.00
71	71	2	1	400.00	9999-12-31 00:00:00	0.00
72	72	2	1	600.00	9999-12-31 00:00:00	0.00
73	73	2	1	3000.00	9999-12-31 00:00:00	0.00
74	74	2	1	4000.00	9999-12-31 00:00:00	0.00
75	75	2	1	5300.00	9999-12-31 00:00:00	0.00
76	76	2	1	9500.00	9999-12-31 00:00:00	0.00
77	77	2	1	12700.00	9999-12-31 00:00:00	0.00
78	78	2	1	600.00	9999-12-31 00:00:00	0.00
79	79	2	1	2700.00	9999-12-31 00:00:00	0.00
80	80	2	1	3700.00	9999-12-31 00:00:00	0.00
81	81	2	1	600.00	9999-12-31 00:00:00	0.00
82	82	2	1	7200.00	9999-12-31 00:00:00	0.00
83	83	2	1	1200.00	9999-12-31 00:00:00	0.00
84	84	2	1	3700.00	9999-12-31 00:00:00	0.00
85	85	2	1	6900.00	9999-12-31 00:00:00	0.00
86	86	2	1	3200.00	9999-12-31 00:00:00	0.00
87	87	2	1	500.00	9999-12-31 00:00:00	0.00
88	88	2	1	500.00	9999-12-31 00:00:00	0.00
89	89	2	1	5100.00	9999-12-31 00:00:00	0.00
90	90	2	1	200.00	9999-12-31 00:00:00	0.00
91	91	2	1	400.00	9999-12-31 00:00:00	0.00
92	92	2	1	900.00	9999-12-31 00:00:00	0.00
93	93	2	1	800.00	9999-12-31 00:00:00	0.00
94	94	2	1	1800.00	9999-12-31 00:00:00	0.00
95	95	2	1	1200.00	9999-12-31 00:00:00	0.00
96	96	2	1	300.00	9999-12-31 00:00:00	0.00
97	97	2	1	800.00	9999-12-31 00:00:00	0.00
15	15	2	1	3800.00	9999-12-31 00:00:00	3000.00
98	98	2	1	800.00	9999-12-31 00:00:00	0.00
99	99	2	1	800.00	9999-12-31 00:00:00	0.00
100	100	2	1	800.00	9999-12-31 00:00:00	0.00
101	101	2	1	800.00	9999-12-31 00:00:00	0.00
102	102	2	1	400.00	9999-12-31 00:00:00	0.00
103	103	2	1	500.00	9999-12-31 00:00:00	0.00
104	104	2	1	400.00	9999-12-31 00:00:00	0.00
105	105	2	1	500.00	9999-12-31 00:00:00	0.00
106	106	2	1	500.00	9999-12-31 00:00:00	0.00
107	107	2	1	500.00	9999-12-31 00:00:00	0.00
108	108	2	1	400.00	9999-12-31 00:00:00	0.00
109	109	2	1	500.00	9999-12-31 00:00:00	0.00
110	110	2	1	1800.00	9999-12-31 00:00:00	0.00
111	111	2	1	5300.00	9999-12-31 00:00:00	0.00
112	112	2	1	7900.00	9999-12-31 00:00:00	0.00
113	113	2	1	1900.00	9999-12-31 00:00:00	0.00
114	114	2	1	3000.00	9999-12-31 00:00:00	0.00
115	115	2	1	10000.00	9999-12-31 00:00:00	0.00
116	116	2	1	600.00	9999-12-31 00:00:00	0.00
117	117	2	1	400.00	9999-12-31 00:00:00	0.00
118	118	2	1	200.00	9999-12-31 00:00:00	0.00
119	119	2	1	500.00	9999-12-31 00:00:00	0.00
120	120	2	1	500.00	9999-12-31 00:00:00	0.00
121	121	2	1	200.00	9999-12-31 00:00:00	0.00
122	122	2	1	3700.00	9999-12-31 00:00:00	0.00
123	123	2	1	400.00	9999-12-31 00:00:00	0.00
124	124	2	1	6200.00	9999-12-31 00:00:00	0.00
125	125	2	1	10000.00	9999-12-31 00:00:00	0.00
126	126	2	1	700.00	9999-12-31 00:00:00	0.00
127	127	2	1	400.00	9999-12-31 00:00:00	0.00
128	128	2	1	200.00	9999-12-31 00:00:00	0.00
129	129	2	1	4800.00	9999-12-31 00:00:00	0.00
130	130	2	1	3700.00	9999-12-31 00:00:00	0.00
131	131	2	1	6900.00	9999-12-31 00:00:00	0.00
132	132	2	1	500.00	9999-12-31 00:00:00	0.00
133	133	2	1	6900.00	9999-12-31 00:00:00	0.00
134	134	2	1	700.00	9999-12-31 00:00:00	0.00
135	135	2	1	600.00	9999-12-31 00:00:00	0.00
136	136	2	1	600.00	9999-12-31 00:00:00	0.00
137	137	2	1	8500.00	9999-12-31 00:00:00	0.00
138	138	2	1	900.00	9999-12-31 00:00:00	0.00
139	139	2	1	2400.00	9999-12-31 00:00:00	0.00
140	140	2	1	3000.00	9999-12-31 00:00:00	0.00
141	141	2	1	1600.00	9999-12-31 00:00:00	0.00
142	142	2	1	1100.00	9999-12-31 00:00:00	0.00
143	143	2	1	3700.00	9999-12-31 00:00:00	0.00
144	144	2	1	4800.00	9999-12-31 00:00:00	0.00
145	145	2	1	6900.00	9999-12-31 00:00:00	0.00
146	146	2	1	500.00	9999-12-31 00:00:00	0.00
147	147	2	1	600.00	9999-12-31 00:00:00	0.00
148	148	2	1	1200.00	9999-12-31 00:00:00	0.00
149	149	2	1	1000.00	9999-12-31 00:00:00	0.00
150	150	2	1	1900.00	9999-12-31 00:00:00	0.00
151	151	2	1	2700.00	9999-12-31 00:00:00	0.00
152	152	2	1	4300.00	9999-12-31 00:00:00	0.00
153	153	2	1	7200.00	9999-12-31 00:00:00	0.00
154	154	2	1	900.00	9999-12-31 00:00:00	0.00
155	155	2	1	7200.00	9999-12-31 00:00:00	0.00
156	156	2	1	12700.00	9999-12-31 00:00:00	0.00
157	157	2	1	2700.00	9999-12-31 00:00:00	0.00
158	158	2	1	3400.00	9999-12-31 00:00:00	0.00
159	159	2	1	4300.00	9999-12-31 00:00:00	0.00
160	160	2	1	6900.00	9999-12-31 00:00:00	0.00
161	161	2	1	9500.00	9999-12-31 00:00:00	0.00
162	162	2	1	19000.00	9999-12-31 00:00:00	0.00
163	163	2	1	8500.00	9999-12-31 00:00:00	0.00
164	164	2	1	13700.00	9999-12-31 00:00:00	0.00
165	165	2	1	12700.00	9999-12-31 00:00:00	0.00
166	166	2	1	1300.00	9999-12-31 00:00:00	0.00
167	167	2	1	3700.00	9999-12-31 00:00:00	0.00
168	168	2	1	5100.00	9999-12-31 00:00:00	0.00
169	169	2	1	5800.00	9999-12-31 00:00:00	0.00
170	170	2	1	300.00	9999-12-31 00:00:00	0.00
171	171	2	1	800.00	9999-12-31 00:00:00	0.00
172	172	2	1	1600.00	9999-12-31 00:00:00	0.00
173	173	2	1	1900.00	9999-12-31 00:00:00	0.00
174	174	2	1	2700.00	9999-12-31 00:00:00	0.00
175	175	2	1	4800.00	9999-12-31 00:00:00	0.00
176	176	2	1	9000.00	9999-12-31 00:00:00	0.00
177	177	2	1	5300.00	9999-12-31 00:00:00	0.00
178	178	2	1	7900.00	9999-12-31 00:00:00	0.00
179	179	2	1	9500.00	9999-12-31 00:00:00	0.00
180	180	2	1	700.00	9999-12-31 00:00:00	0.00
181	181	2	1	700.00	9999-12-31 00:00:00	0.00
182	182	2	1	2700.00	9999-12-31 00:00:00	0.00
183	183	2	1	1300.00	9999-12-31 00:00:00	0.00
184	184	2	1	1600.00	9999-12-31 00:00:00	0.00
185	185	2	1	2700.00	9999-12-31 00:00:00	0.00
186	186	2	1	2700.00	9999-12-31 00:00:00	0.00
187	187	2	1	2700.00	9999-12-31 00:00:00	0.00
188	188	2	1	5100.00	9999-12-31 00:00:00	0.00
189	189	2	1	2700.00	9999-12-31 00:00:00	0.00
190	190	2	1	6900.00	9999-12-31 00:00:00	0.00
191	191	2	1	1300.00	9999-12-31 00:00:00	0.00
192	192	2	1	700.00	9999-12-31 00:00:00	0.00
193	193	2	1	700.00	9999-12-31 00:00:00	0.00
194	194	2	1	1600.00	9999-12-31 00:00:00	0.00
195	195	2	1	3000.00	9999-12-31 00:00:00	0.00
196	196	2	1	3500.00	9999-12-31 00:00:00	0.00
197	197	2	1	5100.00	9999-12-31 00:00:00	0.00
198	198	2	1	9500.00	9999-12-31 00:00:00	0.00
199	199	2	1	9000.00	9999-12-31 00:00:00	0.00
200	200	2	1	15800.00	9999-12-31 00:00:00	0.00
201	201	2	1	6900.00	9999-12-31 00:00:00	0.00
202	202	2	1	5300.00	9999-12-31 00:00:00	0.00
203	203	2	1	500.00	9999-12-31 00:00:00	0.00
204	204	2	1	200.00	9999-12-31 00:00:00	0.00
205	205	2	1	13700.00	9999-12-31 00:00:00	0.00
206	206	2	1	15800.00	9999-12-31 00:00:00	0.00
207	207	2	1	300.00	9999-12-31 00:00:00	0.00
208	208	2	1	300.00	9999-12-31 00:00:00	0.00
209	209	2	1	8500.00	9999-12-31 00:00:00	0.00
210	210	2	1	7400.00	9999-12-31 00:00:00	0.00
211	211	2	1	6400.00	9999-12-31 00:00:00	0.00
212	212	2	1	6900.00	9999-12-31 00:00:00	0.00
213	213	2	1	700.00	9999-12-31 00:00:00	0.00
214	214	2	1	800.00	9999-12-31 00:00:00	0.00
215	215	2	1	1000.00	9999-12-31 00:00:00	0.00
216	216	2	1	3500.00	9999-12-31 00:00:00	0.00
217	217	2	1	6900.00	9999-12-31 00:00:00	0.00
218	218	2	1	9500.00	9999-12-31 00:00:00	0.00
219	219	2	1	12700.00	9999-12-31 00:00:00	0.00
220	220	2	1	200.00	9999-12-31 00:00:00	0.00
221	221	2	1	200.00	9999-12-31 00:00:00	0.00
222	222	2	1	4800.00	9999-12-31 00:00:00	0.00
223	223	2	1	5300.00	9999-12-31 00:00:00	0.00
224	224	2	1	700.00	9999-12-31 00:00:00	0.00
225	225	2	1	4000.00	9999-12-31 00:00:00	0.00
226	226	2	1	4800.00	9999-12-31 00:00:00	0.00
227	227	2	1	6900.00	9999-12-31 00:00:00	0.00
228	228	2	1	12700.00	9999-12-31 00:00:00	0.00
229	229	2	1	900.00	9999-12-31 00:00:00	0.00
230	230	2	1	600.00	9999-12-31 00:00:00	0.00
231	231	2	1	600.00	9999-12-31 00:00:00	0.00
232	232	2	1	600.00	9999-12-31 00:00:00	0.00
233	233	2	1	600.00	9999-12-31 00:00:00	0.00
234	234	2	1	500.00	9999-12-31 00:00:00	0.00
235	235	2	1	700.00	9999-12-31 00:00:00	0.00
236	236	2	1	200.00	9999-12-31 00:00:00	0.00
237	237	2	1	200.00	9999-12-31 00:00:00	0.00
238	238	2	1	800.00	9999-12-31 00:00:00	0.00
239	239	2	1	1600.00	9999-12-31 00:00:00	0.00
240	240	2	1	2500.00	9999-12-31 00:00:00	0.00
241	241	2	1	200.00	9999-12-31 00:00:00	0.00
242	242	2	1	500.00	9999-12-31 00:00:00	0.00
243	243	2	1	200.00	9999-12-31 00:00:00	0.00
244	244	2	1	1900.00	9999-12-31 00:00:00	0.00
245	245	2	1	3200.00	9999-12-31 00:00:00	0.00
246	246	2	1	2700.00	9999-12-31 00:00:00	0.00
247	247	2	1	4800.00	9999-12-31 00:00:00	0.00
248	248	2	1	6900.00	9999-12-31 00:00:00	0.00
249	249	2	1	9500.00	9999-12-31 00:00:00	0.00
250	250	2	1	200.00	9999-12-31 00:00:00	0.00
251	251	2	1	400.00	9999-12-31 00:00:00	0.00
252	252	2	1	800.00	9999-12-31 00:00:00	0.00
253	253	2	1	2200.00	9999-12-31 00:00:00	0.00
254	254	2	1	2700.00	9999-12-31 00:00:00	0.00
255	255	2	1	4800.00	9999-12-31 00:00:00	0.00
256	256	2	1	8300.00	9999-12-31 00:00:00	0.00
257	257	2	1	200.00	9999-12-31 00:00:00	0.00
258	258	2	1	3200.00	9999-12-31 00:00:00	0.00
259	259	2	1	200.00	9999-12-31 00:00:00	0.00
260	260	2	1	300.00	9999-12-31 00:00:00	0.00
261	261	2	1	200.00	9999-12-31 00:00:00	0.00
262	262	2	1	400.00	9999-12-31 00:00:00	0.00
263	263	2	1	6900.00	9999-12-31 00:00:00	0.00
264	264	2	1	8500.00	9999-12-31 00:00:00	0.00
265	265	2	1	14800.00	9999-12-31 00:00:00	0.00
266	266	2	1	500.00	9999-12-31 00:00:00	0.00
267	267	2	1	600.00	9999-12-31 00:00:00	0.00
268	268	2	1	600.00	9999-12-31 00:00:00	0.00
269	269	2	1	1300.00	9999-12-31 00:00:00	0.00
270	270	2	1	1600.00	9999-12-31 00:00:00	0.00
271	271	2	1	1600.00	9999-12-31 00:00:00	0.00
272	272	2	1	2700.00	9999-12-31 00:00:00	0.00
273	273	2	1	3700.00	9999-12-31 00:00:00	0.00
274	274	2	1	4800.00	9999-12-31 00:00:00	0.00
275	275	2	1	600.00	9999-12-31 00:00:00	0.00
276	276	2	1	1600.00	9999-12-31 00:00:00	0.00
277	277	2	1	2000.00	9999-12-31 00:00:00	0.00
278	278	2	1	2500.00	9999-12-31 00:00:00	0.00
279	279	2	1	4800.00	9999-12-31 00:00:00	0.00
280	280	2	1	7200.00	9999-12-31 00:00:00	0.00
281	281	2	1	10000.00	9999-12-31 00:00:00	0.00
282	282	2	1	200.00	9999-12-31 00:00:00	0.00
283	283	2	1	3000.00	9999-12-31 00:00:00	0.00
284	284	2	1	3700.00	9999-12-31 00:00:00	0.00
285	285	2	1	5100.00	9999-12-31 00:00:00	0.00
286	286	2	1	12700.00	9999-12-31 00:00:00	0.00
287	287	2	1	3000.00	9999-12-31 00:00:00	0.00
288	288	2	1	4800.00	9999-12-31 00:00:00	0.00
289	289	2	1	700.00	9999-12-31 00:00:00	0.00
290	290	2	1	200.00	9999-12-31 00:00:00	0.00
291	291	2	1	3700.00	9999-12-31 00:00:00	0.00
294	294	2	1	5100.00	9999-12-31 00:00:00	0.00
295	295	2	1	200.00	9999-12-31 00:00:00	0.00
296	296	2	1	500.00	9999-12-31 00:00:00	0.00
297	297	2	1	4000.00	9999-12-31 00:00:00	0.00
298	298	2	1	6900.00	9999-12-31 00:00:00	0.00
299	299	2	1	4800.00	9999-12-31 00:00:00	0.00
300	300	2	1	12700.00	9999-12-31 00:00:00	0.00
301	301	2	1	500.00	9999-12-31 00:00:00	0.00
302	302	2	1	1400.00	9999-12-31 00:00:00	0.00
303	303	2	1	1900.00	9999-12-31 00:00:00	0.00
304	304	2	1	200.00	9999-12-31 00:00:00	0.00
305	305	2	1	300.00	9999-12-31 00:00:00	0.00
306	306	2	1	900.00	9999-12-31 00:00:00	0.00
307	307	2	1	10000.00	9999-12-31 00:00:00	0.00
308	308	2	1	4300.00	9999-12-31 00:00:00	0.00
309	309	2	1	500.00	9999-12-31 00:00:00	0.00
310	310	2	1	2700.00	9999-12-31 00:00:00	0.00
311	311	2	1	200.00	9999-12-31 00:00:00	0.00
1000	1000	2	1	10000.00	9999-12-31 23:59:59	0.00
39	39	2	1	2200.00	9999-12-31 00:00:00	1100.00
1001	1001	2	1	10000.00	9999-12-31 23:59:59	9000.00
1002	1002	2	1	10000.00	9999-12-31 23:59:59	9000.00
1003	1003	2	1	10000.00	9999-12-31 23:59:59	9000.00
1004	1004	2	1	10000.00	9999-12-31 23:59:59	9000.00
1005	1005	2	1	10000.00	9999-12-31 23:59:59	9000.00
1006	1006	2	1	10000.00	9999-12-31 23:59:59	9000.00
1007	1007	2	1	10000.00	9999-12-31 23:59:59	9000.00
1008	1008	2	1	10000.00	9999-12-31 23:59:59	9000.00
1009	1009	2	1	10000.00	9999-12-31 23:59:59	9000.00
1010	1010	2	1	10000.00	9999-12-31 23:59:59	9000.00
1011	1011	2	1	10000.00	9999-12-31 23:59:59	9000.00
1012	1012	2	1	10000.00	9999-12-31 23:59:59	9000.00
1013	1013	2	1	10000.00	9999-12-31 23:59:59	9000.00
1014	1014	2	1	10000.00	9999-12-31 23:59:59	9000.00
1015	1015	2	1	10000.00	9999-12-31 23:59:59	9000.00
1016	1016	2	1	10000.00	9999-12-31 23:59:59	9000.00
1017	1017	2	1	10000.00	9999-12-31 23:59:59	9000.00
1018	1018	2	1	10000.00	9999-12-31 23:59:59	9000.00
1019	1019	2	1	10000.00	9999-12-31 23:59:59	9000.00
1020	1020	2	1	10000.00	9999-12-31 23:59:59	9000.00
1021	1021	2	1	10000.00	9999-12-31 23:59:59	9000.00
1022	1022	2	1	10000.00	9999-12-31 23:59:59	9000.00
1023	1023	2	1	10000.00	9999-12-31 23:59:59	9000.00
1024	1024	2	1	10000.00	9999-12-31 23:59:59	9000.00
1025	1025	2	1	10000.00	9999-12-31 23:59:59	9000.00
1026	1026	2	1	10000.00	9999-12-31 23:59:59	9000.00
1027	1027	2	1	10000.00	9999-12-31 23:59:59	9000.00
1028	1028	2	1	10000.00	9999-12-31 23:59:59	9000.00
1029	1029	2	1	10000.00	9999-12-31 23:59:59	9000.00
1030	1030	2	1	10000.00	9999-12-31 23:59:59	9000.00
1031	1031	2	1	10000.00	9999-12-31 23:59:59	9000.00
1032	1032	2	1	10000.00	9999-12-31 23:59:59	9000.00
1033	1033	2	1	10000.00	9999-12-31 23:59:59	9000.00
1034	1034	2	1	10000.00	9999-12-31 23:59:59	9000.00
1035	1035	2	1	10000.00	9999-12-31 23:59:59	9000.00
1036	1036	2	1	10000.00	9999-12-31 23:59:59	9000.00
1037	1037	2	1	10000.00	9999-12-31 23:59:59	9000.00
1038	1038	2	1	10000.00	9999-12-31 23:59:59	9000.00
1039	1039	2	1	10000.00	9999-12-31 23:59:59	9000.00
1040	1040	2	1	10000.00	9999-12-31 23:59:59	9000.00
1041	1041	2	1	10000.00	9999-12-31 23:59:59	9000.00
1042	1042	2	1	10000.00	9999-12-31 23:59:59	9000.00
1043	1043	2	1	10000.00	9999-12-31 23:59:59	9000.00
1044	1044	2	1	10000.00	9999-12-31 23:59:59	9000.00
1045	1045	2	1	10000.00	9999-12-31 23:59:59	9000.00
1046	1046	2	1	10000.00	9999-12-31 23:59:59	9000.00
1047	1047	2	1	20000.00	9999-12-31 23:59:59	18000.00
1048	1048	2	1	20000.00	9999-12-31 23:59:59	18000.00
1049	1049	2	1	20000.00	9999-12-31 23:59:59	18000.00
1050	1050	2	1	20000.00	9999-12-31 23:59:59	18000.00
1051	1051	2	1	20000.00	9999-12-31 23:59:59	18000.00
1052	1052	2	1	20000.00	9999-12-31 23:59:59	18000.00
1053	1053	2	1	20000.00	9999-12-31 23:59:59	18000.00
1055	1055	2	1	20000.00	9999-12-31 23:59:59	18000.00
1056	1056	2	1	20000.00	9999-12-31 23:59:59	18000.00
\.


--
-- Name: item_price_history_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('item_price_history_seq', 1069, true);


--
-- Name: item_price_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('item_price_seq', 1072, true);


--
-- Name: item_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('item_seq', 1067, true);


--
-- Data for Name: item_text_metadata; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY item_text_metadata (item_text_metadata_id, item_id, metadata_type, metadata) FROM stdin;
1234	39	0	約1m
1235	40	0	2m
1236	41	0	2m
1237	43	0	0.5m
1238	45	0	2m
1239	46	0	1.8m
1240	47	0	2m
1241	48	0	2m
1242	49	0	0.4m
1243	50	0	0.3m
1244	51	0	0.2m
1245	52	0	0.2m
1246	53	0	1.5m
1247	54	0	2m
1248	55	0	1.8m
1249	56	0	2m
1250	57	0	0.3m
1251	58	0	0.2m
1252	59	0	2m
1253	60	0	1.5m
1254	61	0	2m
1255	62	0	0.2m
1256	63	0	0.2m
1257	64	0	1.2m
1258	65	0	1.2m
1259	66	0	2m
1260	67	0	2m
1261	68	0	0.8m
1262	69	0	1.2m
1263	71	0	0.25m
1264	72	0	0.3m
1265	73	0	1m
1266	74	0	1.2m
1267	75	0	1.5m
1268	76	0	1.8m
1269	77	0	2m
1270	78	0	0.4m
1271	79	0	1.5m
1272	80	0	1.8m
1273	81	0	0.4m
1274	82	0	2m
1275	83	0	0.8m
1276	84	0	1.5m
1277	85	0	2m
1278	86	0	1.2m
1279	89	0	1.5m
1280	90	0	0.1m
1281	91	0	0.3m
1282	92	0	0.4m
1283	93	0	0.3m
1284	94	0	1.2m
1285	95	0	1.2m
1286	97	0	0.15m
1287	102	0	0.3m
1288	103	0	0.4m
1289	104	0	0.3m
1290	105	0	0.3m
1291	106	0	0.3m
1292	107	0	0.3m
1293	108	0	0.3m
1294	109	0	0.3m
1295	110	0	1m
1296	111	0	1.5m
1297	112	0	1.8m
1298	113	0	1.2m
1299	114	0	1.5m
1300	115	0	2m
1301	117	0	0.2m
1302	119	0	0.4m
1303	120	0	0.5m
1304	122	0	2m
1305	123	0	0.3m
1306	124	0	1.5m
1307	125	0	2m
1308	126	0	0.3m
1309	129	0	2m
1310	130	0	1.5m
1311	131	0	2m
1312	132	0	0.2m
1313	133	0	2m
1314	137	0	2m
1315	138	0	1.2m
1316	139	0	1.8m
1317	140	0	2m
1318	141	0	1.5m
1319	142	0	1.2m
1320	143	0	1.5m
1321	144	0	1.8m
1322	145	0	2m
1323	146	0	0.3m
1324	147	0	0.4m
1325	148	0	1.2m
1326	149	0	1m
1327	150	0	1.5m
1328	151	0	1.8m
1329	152	0	2m
1330	153	0	2m
1331	154	0	0.5m
1332	155	0	1.5m
1333	156	0	2m
1334	157	0	0.5m
1335	158	0	0.5m
1336	159	0	1.5m
1337	160	0	2m
1338	161	0	1.5m
1339	162	0	2m
1340	163	0	1.5m
1341	164	0	2m
1342	165	0	2m
1343	166	0	0.8m
1344	167	0	1.5m
1345	168	0	1.8m
1346	169	0	2m
1347	171	0	0.6m
1348	172	0	0.8m
1349	173	0	1m
1350	174	0	1.2m
1351	175	0	1.5m
1352	176	0	2m
1353	177	0	1.5m
1354	178	0	1.8m
1355	179	0	2m
1356	180	0	0.3m
1357	181	0	0.3m
1358	182	0	1.5m
1359	183	0	1.2m
1360	184	0	1.2m
1361	185	0	1.5m
1362	186	0	1.5m
1363	187	0	1.5m
1364	188	0	2m
1365	189	0	1.5m
1366	190	0	2m
1367	191	0	1.2m
1368	192	0	0.3m
1369	193	0	0.3m
1370	194	0	0.8m
1371	195	0	1m
1372	196	0	1.2m
1373	197	0	1.5m
1374	198	0	2m
1375	199	0	1.5m
1376	200	0	2m
1377	201	0	2m
1378	202	0	2m
1379	203	0	0.3m
1380	205	0	1.5m
1381	206	0	2m
1382	209	0	2m
1383	210	0	2m
1384	211	0	2m
1385	212	0	2m
1386	213	0	0.4m
1387	214	0	0.5m
1388	215	0	0.6m
1389	216	0	1.2m
1390	217	0	1.5m
1391	218	0	1.8m
1392	219	0	2m
1393	222	0	1.8m
1394	223	0	2m
1395	224	0	0.3m
1396	225	0	1.5m
1397	226	0	1.8m
1398	227	0	2m
1399	228	0	2m
1400	229	0	0.5m
1401	230	0	0.4m
1402	231	0	0.4m
1403	232	0	0.4m
1404	233	0	0.4m
1405	234	0	0.4m
1406	235	0	0.5m
1407	238	0	0.5m
1408	239	0	0.8m
1409	240	0	1m
1410	241	0	0.4m
1411	242	0	0.4m
1412	244	0	0.8m
1413	245	0	1m
1414	246	0	1.2m
1415	247	0	1.5m
1416	248	0	1.8m
1417	249	0	2m
1418	251	0	0.5m
1419	252	0	1.2m
1420	253	0	1m
1421	254	0	1.2m
1422	255	0	1.5m
1423	256	0	2m
1424	258	0	0.2m
1425	263	0	1.5m
1426	264	0	1.8m
1427	265	0	2m
1428	266	0	0.3m
1429	267	0	0.5m
1430	268	0	0.3m
1431	269	0	0.5m
1432	270	0	0.6m
1433	271	0	1m
1434	272	0	1.5m
1435	273	0	1.8m
1436	274	0	2m
1437	275	0	0.3m
1438	276	0	0.8m
1439	277	0	1m
1440	278	0	1.2m
1441	279	0	1.5m
1442	280	0	1.8m
1443	281	0	2m
1444	283	0	1.5m
1445	284	0	1.8m
1446	285	0	2m
1447	286	0	2m
1448	287	0	1.5m
1449	288	0	2m
1450	289	0	0.5m
1451	291	0	1.5m
1452	292	0	1.8m
1453	293	0	2m
1454	294	0	1.5m
1455	295	0	0.3m
1456	296	0	0.4m
1457	297	0	2m
1458	298	0	2m
1459	299	0	2m
1460	300	0	2m
1461	301	0	0.4m
1462	302	0	0.8m
1463	303	0	0.8m
1464	306	0	1.2m
1465	307	0	2m
1466	308	0	1.2m
1467	310	0	1m
1468	1057	0	ポットサイズ：18cm
1469	1000	0	植栽セット
1470	1067	0	宿根草セット
1471	1066	0	宿根草セット
1472	1065	0	宿根草セット
1473	1064	0	宿根草セット
1474	1061	0	宿根草セット
\.


--
-- Name: item_text_metadata_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('item_text_metadata_seq', 1474, true);


--
-- Data for Name: locale; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY locale (locale_id, lang, country, precedence) FROM stdin;
1	ja		2
2	en		1
\.


--
-- Data for Name: order_notification; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY order_notification (order_notification_id, store_user_id) FROM stdin;
1014	1008
1016	1001
1017	1011
1019	1003
\.


--
-- Name: order_notification_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('order_notification_seq', 1019, true);


--
-- Data for Name: play_evolutions; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY play_evolutions (id, hash, applied_at, apply_script, revert_script, state, last_problem) FROM stdin;
1	1c64a361c7ede64524367a6027d4f04d3e338994	2013-10-27 00:00:00	create table locale (\nlocale_id bigint not null,\nlang varchar(8) not null,\ncountry varchar(3) not null default '',\nprecedence integer not null,\nconstraint pk_locale primary key (locale_id),\nunique (lang, country)\n);\n\nCOMMENT ON TABLE locale IS 'Locale information.';\nCOMMENT ON COLUMN locale.locale_id IS 'Surrogate key.';\nCOMMENT ON COLUMN locale.lang IS 'ISO 639 lang code such as ja, en.';\nCOMMENT ON COLUMN locale.country IS 'ISO 3166 country code such as JP, US.';\nCOMMENT ON COLUMN locale.precedence IS 'Precedence. If requested locale is not registed in this table, the record having greatest precedence will be used instead.';\n\ninsert into locale (locale_id, lang, precedence) values (1, 'ja', 2);\ninsert into locale (locale_id, lang, precedence) values (2, 'en', 1);\n\ncreate table site (\nsite_id bigint not null,\nlocale_id bigint not null references locale,\nsite_name varchar(32) not null unique,\nconstraint pk_site primary key (site_id)\n);\n\nCOMMENT ON TABLE site IS 'Site information. Site expresses store. In this application, each site treates one locale each other.';\nCOMMENT ON COLUMN site.site_id IS 'Surrogate key.';\nCOMMENT ON COLUMN site.locale_id IS 'Locale.';\nCOMMENT ON COLUMN site.site_name IS 'Name of this site.';\n\ncreate sequence site_seq start with 1000;\n\ncreate table category (\ncategory_id bigint not null,\nconstraint pk_category primary key (category_id)\n);\n\nCOMMENT ON TABLE category IS 'Category information. Each item has one category.';\nCOMMENT ON COLUMN category.category_id IS 'Surrogate key.';\n\ncreate sequence category_seq start with 1000;\n\ncreate table item (\nitem_id bigint not null,\ncategory_id bigint not null references category,\nconstraint pk_item primary key (item_id)\n);\n\ncreate sequence item_seq start with 1000;\n\ncreate table item_numeric_metadata (\nitem_numeric_metadata_id bigint not null,\nitem_id bigint not null references item,\nmetadata_type integer not null,\nmetadata bigint,\nconstraint pk_item_numeric_metadata primary key (item_numeric_metadata_id),\nunique (item_id, metadata_type)\n);\n\ncreate sequence item_numeric_metadata_seq start with 1000;\n\ncreate table site_item_numeric_metadata (\nsite_item_numeric_metadata_id bigint not null,\nsite_id bigint not null references site,\nitem_id bigint not null references item,\nmetadata_type integer not null,\nmetadata bigint,\nconstraint pk_site_item_numeric_metadata primary key (site_item_numeric_metadata_id),\nunique (site_id, item_id, metadata_type)\n);\n\ncreate sequence site_item_numeric_metadata_seq start with 1000;\n\ncreate table item_name (\nitem_name_id bigint not null,\nlocale_id bigint not null references locale,\nitem_id bigint not null references item on delete cascade,\nitem_name text not null,\nconstraint pk_item_name primary key (item_name_id),\nunique (locale_id, item_id)\n);\n\ncreate sequence item_name_seq start with 1000;\n\ncreate index ix_item_name1 on item_name (item_id);\n\ncreate table item_description (\nitem_description_id bigint not null,\nlocale_id bigint not null references locale,\ndescription text not null,\nitem_id bigint not null references item on delete cascade,\nsite_id bigint not null references site on delete cascade,\nconstraint pk_item_description primary key (item_description_id),\nunique (locale_id, item_id, site_id)\n);\n\ncreate sequence item_description_seq start with 1000;\n\ncreate index ix_item_description1 on item_description (item_id);\n\ncreate table site_item (\nitem_id bigint not null references item on delete cascade,\nsite_id bigint not null references site on delete cascade,\nconstraint pk_site_item primary key (item_id, site_id)\n);\n\ncreate table category_name (\nlocale_id bigint not null references locale,\ncategory_name varchar(32) not null,\ncategory_id bigint not null references category on delete cascade,\nconstraint pk_category_name primary key (locale_id, category_id)\n);\n\ncreate index ix_category_name1 on category_name(category_id);\n\ncreate table category_path (\nancestor bigint not null references category on delete cascade,\ndescendant bigint not null references category on delete cascade,\npath_length integer not null,\nprimary key (ancestor, descendant)\n);\n\ncreate index ix_category_path1 on category_path(ancestor);\ncreate index ix_category_path2 on category_path(descendant);\ncreate index ix_category_path3 on category_path(path_length);\n\ncreate table site_category (\ncategory_id bigint not null references category on delete cascade,\nsite_id bigint not null references site on delete cascade,\nconstraint pk_site_category primary key (category_id, site_id)\n);\n\ncreate table tax (\ntax_id bigint not null,\nconstraint pk_tax primary key(tax_id)\n);\n\ncreate sequence tax_seq start with 1000;\n\ncreate table tax_name (\ntax_name_id bigint not null,\ntax_id bigint not null references tax on delete cascade,\nlocale_id bigint not null references locale,\ntax_name varchar(32) not null,\nconstraint pk_tax_name primary key (tax_name_id),\nunique (tax_id, locale_id)\n);\n\ncreate sequence tax_name_seq start with 1000;\n\ncreate table tax_history (\ntax_history_id bigint not null,\ntax_id bigint not null references tax on delete cascade,\ntax_type integer not null,\nrate decimal(5,3) not null,\n-- Exclusive\nvalid_until timestamp not null,\nconstraint tax_history_check1 check (tax_type in (0,1, 2)),\nconstraint pk_tax_history primary key(tax_history_id),\nunique (tax_id, valid_until)\n);\n\ncreate sequence tax_history_seq start with 1000;\n\ncreate index ix_tax_history1 on tax_history (valid_until);\n\ncreate table item_price (\nitem_price_id bigint not null,\nsite_id bigint not null references site on delete cascade,\nitem_id bigint not null references item on delete cascade,\nconstraint pk_item_price primary key (item_price_id),\nunique (site_id, item_id)\n);\n\ncreate sequence item_price_seq start with 1000;\n\ncreate table currency (\ncurrency_id bigint not null,\n-- ISO 4217\ncurrency_code varchar(3) not null,\nconstraint pk_currency primary key (currency_id)\n);\n\ninsert into currency (currency_id, currency_code) values (1, 'JPY');\ninsert into currency (currency_id, currency_code) values (2, 'USD');\n\ncreate table item_price_history (\nitem_price_history_id bigint not null,\nitem_price_id bigint not null references item_price on delete cascade,\ntax_id bigint not null references tax on delete cascade,\ncurrency_id bigint not null references currency on delete cascade,\nunit_price decimal(15,2) not null,\n-- Exclusive\nvalid_until timestamp not null,\nconstraint pk_item_price_history primary key (item_price_history_id),\nunique (item_price_id, valid_until)\n);\n\ncreate sequence item_price_history_seq start with 1000;\n\ncreate table store_user (\nstore_user_id bigint not null,\nuser_name varchar(64) not null unique,\nfirst_name varchar(64) not null,\nmiddle_name varchar(64),\nlast_name varchar(64) not null,\nemail varchar(255) not null,\npassword_hash bigint not null,\nsalt bigint not null,\ndeleted boolean not null,\nuser_role integer not null,\nconstraint user_user_role_check1 check (user_role in (0,1)),\nconstraint pk_user primary key (store_user_id)\n);\n\ncreate sequence store_user_seq start with 1000;\n\ncreate table transaction_header (\ntransaction_id bigint not null,\nstore_user_id bigint not null,\ntransaction_time timestamp not null,\ncurrency_id bigint not null references currency,\ntotal_amount decimal(15,2) not null,\ntax_amount decimal(15,2) not null,\ntransaction_type integer not null,\nconstraint pk_transaction primary key (transaction_id)\n);\n\ncreate sequence transaction_header_seq start with 1000;\n\ncreate table transaction_site (\ntransaction_site_id bigint not null,\ntransaction_id bigint not null references transaction_header on delete cascade,\nsite_id bigint not null,\ntotal_amount decimal(15,2) not null,\ntax_amount decimal(15,2) not null,\nconstraint pk_transaction_site primary key (transaction_site_id),\nunique(transaction_id, site_id)\n);\n\ncreate sequence transaction_site_seq start with 1000;\n\ncreate table address (\naddress_id bigint not null,\ncountry_code integer not null,\nfirst_name varchar(64) not null,\nmiddle_name varchar(64) not null,\nlast_name varchar(64) not null,\nfirst_name_kana varchar(64) not null,\nlast_name_kana varchar(64) not null,\nzip1 varchar(32) not null,\nzip2 varchar(32) not null,\nzip3 varchar(32) not null,\nprefecture integer not null,\naddress1 varchar(256) not null,\naddress2 varchar(256) not null,\naddress3 varchar(256) not null,\naddress4 varchar(256) not null,\naddress5 varchar(256) not null,\ntel1 varchar(32) not null,\ntel2 varchar(32) not null,\ntel3 varchar(32) not null,\n\nconstraint pk_address primary key (address_id)\n);\n\ncreate sequence address_seq start with 1000;\n\ncreate table transaction_shipping (\ntransaction_shipping_id bigint not null,\ntransaction_site_id bigint not null references transaction_site on delete cascade,\namount decimal(15,2) not null,\naddress_id bigint not null,\nitem_class bigint not null,\nbox_size integer not null,\ntax_id bigint not null,\nconstraint pk_transaction_shipping primary key (transaction_shipping_id)\n);\n\ncreate sequence transaction_shipping_seq start with 1000;\n\ncreate table transaction_item (\ntransaction_item_id bigint not null,\ntransaction_site_id bigint not null references transaction_site on delete cascade,\nitem_id bigint not null,\nitem_price_history_id bigint not null,\nquantity integer not null,\namount decimal(15,2) not null,\nconstraint pk_transaction_item primary key (transaction_item_id)\n);\n\ncreate sequence transaction_item_seq start with 1000;\n\ncreate table transaction_tax (\ntransaction_tax_id bigint not null,\ntransaction_site_id bigint not null references transaction_site on delete cascade,\ntax_id bigint not null,\ntax_type integer not null,\nrate decimal(5, 3) not null,\ntarget_amount decimal(15,2) not null,\namount decimal(15,2) not null,\nconstraint pk_transaction_tax primary key (transaction_tax_id)\n);\n\ncreate sequence transaction_tax_seq start with 1000;\n\ncreate table transaction_credit_tender (\ntransaction_credit_tender_id bigint not null,\ntransaction_id bigint not null references transaction_header on delete cascade,\namount decimal(15,2) not null,\nconstraint pk_transaction_credit_tender primary key (transaction_credit_tender_id)\n);\n\ncreate sequence transaction_credit_tender_seq start with 1000;\n\ncreate table site_user (\nsite_user_id bigint not null,\nsite_id bigint not null references site on delete cascade,\nstore_user_id bigint not null references store_user on delete cascade,\nconstraint pk_site_user primary key (site_user_id),\nunique (site_id, store_user_id)\n);\n\ncreate sequence site_user_seq start with 1000;\n\ncreate table shopping_cart_item (\nshopping_cart_item_id bigint not null,\nstore_user_id bigint not null references store_user on delete cascade,\nseq integer not null,\nsite_id bigint not null references site on delete cascade,\nitem_id bigint not null references item on delete cascade,\nquantity integer not null,\nconstraint pk_shopping_cart_item primary key (shopping_cart_item_id),\nunique(store_user_id, seq)\n);\n\ncreate index ix_shopping_cart_item1 on shopping_cart_item (item_id);\n\ncreate sequence shopping_cart_item_seq start with 1000;\n\ncreate table shipping_address_history (\nshipping_address_history_id bigint not null,\nstore_user_id bigint not null references store_user on delete cascade,\naddress_id bigint not null references address on delete cascade,\nupdated_time timestamp not null,\nconstraint pk_shipping_address_history primary key (shipping_address_history_id),\nunique(store_user_id, address_id, updated_time)\n);\n\ncreate sequence shipping_address_history_seq start with 1000;\n\ncreate table shipping_box (\nshipping_box_id bigint not null,\nsite_id bigint not null references site on delete cascade,\nitem_class bigint not null,\nbox_size integer not null,\nbox_name varchar(32) not null,\nconstraint pk_shipping_box primary key(shipping_box_id),\nunique(site_id, item_class)\n);\n\ncreate sequence shipping_box_seq start with 1000;\n\ncreate table shipping_fee (\nshipping_fee_id bigint not null,\nshipping_box_id bigint not null references shipping_box,\ncountry_code integer not null,\nlocation_code integer not null,\nconstraint pk_shipping_fee primary key(shipping_fee_id)\n);\n\ncreate sequence shipping_fee_seq start with 1000;\n\ncreate table shipping_fee_history (\nshipping_fee_history_id bigint not null,\nshipping_fee_id bigint not null references shipping_fee on delete cascade,\ntax_id bigint not null references tax on delete cascade,\nfee decimal(15, 2) not null,\n-- Exclusive\nvalid_until timestamp not null,\nconstraint pk_shipping_fee_history primary key(shipping_fee_history_id),\nunique(shipping_fee_id, valid_until)\n);\n\ncreate index ix_shipping_fee_history1 on shipping_fee_history (shipping_fee_id);\n\ncreate sequence shipping_fee_history_seq start with 1000;\n\ncreate table transaction_status (\ntransaction_status_id bigint not null,\ntransaction_site_id bigint not null references transaction_site,\nstatus integer not null,\nconstraint pk_transaction_status primary key(transaction_status_id),\nunique(transaction_site_id)\n);\n\ncreate sequence transaction_status_seq start with 1000;	-- No down script. Recreate database before reloading 1.sql.	applied	
2	60852da93004794ec624afe8548183b3ba24fb9b	2013-10-27 00:00:00	alter table store_user add company_name varchar(64);	alter table store_user drop company_name;	applied	
3	0563d18ec3fb968cc87c5e0642bab5908a424c57	2013-10-27 00:00:00	create table shopping_cart_shipping (\nshopping_cart_shipping_id bigint not null,\nstore_user_id bigint not null references store_user on delete cascade,\nsite_id bigint not null references site on delete cascade,\nshipping_date timestamp not null,\nconstraint pk_shopping_cart_shipping primary key (shopping_cart_shipping_id),\nunique(store_user_id, site_id)\n);\n\ncreate sequence shopping_cart_shipping_seq start with 1000;	drop table shopping_cart_shipping;\n\ndrop sequence shopping_cart_shipping_seq;	applied	
4	4c53c374201a63717059a062703df56a044959a9	2013-10-27 00:00:00	alter table transaction_shipping add column shipping_date timestamp default timestamp '1970-01-01 00:00:00' not null ;	alter table transaction_shipping_user drop column shipping_date;	applied	
5	682c78e4e69681e07bfb926a76c44b8204334eaa	2013-11-17 00:00:00	create table order_notification (\norder_notification_id bigint not null,\nstore_user_id bigint not null references store_user,\nconstraint pk_order_notification primary key (order_notification_id),\nunique(store_user_id)\n);\n\ncreate sequence order_notification_seq start with 1000;\n\nalter table transaction_shipping add column box_count integer default 1 not null ;\nalter table transaction_shipping add column box_name varchar(32) default '-' not null ;	drop table order_notification;\n\ndrop sequence order_notification_seq;\n\nalter table transaction_shipping drop column box_count;\nalter table transaction_shipping drop column box_name;	applied	
6	febc9e041efa161673792bc874bcaee2a7e85a14	2013-11-17 00:00:00	create table item_text_metadata (\nitem_text_metadata_id bigint not null,\nitem_id bigint not null references item,\nmetadata_type integer not null,\nmetadata text,\nconstraint pk_item_text_metadata primary key (item_text_metadata_id),\nunique (item_id, metadata_type)\n);\n\ncreate sequence item_text_metadata_seq start with 1000;	drop table item_text_metadata;\ndrop sequence item_text_metadata_seq;	applied	
7	c76bf9a638ace9cae8f9c9c7bdc9a9c86b2a2020	2013-11-17 00:00:00	alter table address add column comment text default '' not null;	alter table address drop column comment;	applied	
8	a89918697eab63d01c6568fe45259f4a19076bbf	2013-11-30 00:00:00	create table transporter (\ntransporter_id bigint not null,\nconstraint pk_transporter primary key(transporter_id)\n);\n\ncreate sequence transporter_seq start with 1000;\n\ncreate table transporter_name (\ntransporter_name_id bigint not null,\nlocale_id bigint not null references locale,\ntransporter_id bigint not null references transporter on delete cascade,\ntransporter_name varchar(64),\nconstraint pk_transporter_name primary key(transporter_name_id),\nunique (transporter_name),\nunique (locale_id, transporter_id)\n);\n\ncreate sequence transporter_name_seq start with 1000;\n\nalter table transaction_status add column transporter_id bigint default null;\nalter table transaction_status add constraint transaction_status_fk1 foreign key (transporter_id) references transporter;\nalter table transaction_status add column slip_code varchar(128) default null;\nalter table transaction_status add column shipped_time timestamp default null;	alter table transaction_status drop column transporter_id;\nalter table transaction_status drop column slip_code;\nalter table transaction_status drop column shipped_time;\n\ndrop table transporter;\n\ndrop table transporter_name;\n\ndrop sequence transporter_seq;	applied	
9	a1334b65fbf6752d12e42f714e389d5e3e9ad5ee	2013-12-01 00:00:00	alter table transaction_status drop column shipped_time;\nalter table transaction_status add column last_update timestamp default current_timestamp;\nalter table transaction_status alter column last_update set not null;	alter table transaction_status add column shipped_time timestamp default null;\nalter table transaction_status drop column last_update;	applied	
10	757096a505b1aee0e7295556995ae63798ab032f	2013-12-08 00:00:00	alter table transaction_status add column mail_sent boolean default FALSE;\nalter table transaction_status alter column mail_sent set not null;	alter table transaction_status drop column mail_sent;	applied	
11	1fd9508625b855d2120441a3e75b5831fa7960ae	2014-01-27 00:00:00	alter table shipping_fee add constraint shipping_fee_constraint1 unique(shipping_box_id, country_code, location_code);	alter table shipping_fee drop constraint shipping_fee_constraint1;	applied	
12	57523e62ef2a8c884c73dedec189b8d4a5d0e13e	2014-02-02 00:00:00	alter table item_price_history add column cost_price decimal(15,2) not null default 0;\nalter table transaction_item add column cost_price decimal(15,2) not null default 0;	alter table item_price_history drop column cost_price;\nalter table transaction_item drop column cost_price;	applied	
13	767bcac6c73439e7f9543cd3718948e54cbfe52c	2014-03-22 00:00:00	alter table site add column deleted boolean default FALSE;\nalter table site alter column deleted set not null;	alter table site drop column deleted;	applied	
14	4b777cd7cab0f66385516acb353b69957b4bb8cd	2014-04-27 00:00:00	alter table transaction_item add column tax_id bigint default 2;\nalter table transaction_item alter column tax_id set not null;	alter table transaction_item drop column tax_id;	applied	
\.


--
-- Data for Name: shipping_address_history; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY shipping_address_history (shipping_address_history_id, store_user_id, address_id, updated_time) FROM stdin;
1007	1002	1007	2013-10-28 15:41:34.028
1008	1002	1008	2013-10-28 15:41:59.23
1012	1003	1012	2013-12-06 11:02:59.951
1013	1003	1013	2013-12-17 17:39:34.301
1061	1000	1061	2014-02-25 09:08:59.076
1010	1008	1010	2014-04-16 22:31:55.367
1014	1003	1014	2014-04-18 10:39:54.504
1062	1000	1062	2014-07-15 08:50:00.519
1060	1000	1060	2014-01-11 10:42:10.514
\.


--
-- Name: shipping_address_history_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('shipping_address_history_seq', 1062, true);


--
-- Data for Name: shipping_box; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY shipping_box (shipping_box_id, site_id, item_class, box_size, box_name) FROM stdin;
1	1	1	15	宿根草
2	1	2	8	ポット樹木（小）
3	1	3	2	ポット樹木（大）
4	2	1	50	グランドカバー宿根草等専用
5	2	2	20	低木H0.5m以下専用
6	2	3	1	低木H0.6m～H1.5m以下専用
7	2	4	1	その他規格外
8	2	5	1	セット送料A
9	2	6	1	セット送料B
10	2	7	1	セット送料C
11	2	8	1	セット送料D
12	2	9	1	セット送料E
13	2	10	1	セット送料F
14	2	11	1	セット送料G
15	2	12	1	セット送料H
16	1	13	1	ポットセット送料
1004	2	17	2	芝送料
\.


--
-- Name: shipping_box_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('shipping_box_seq', 1004, true);


--
-- Data for Name: shipping_fee; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY shipping_fee (shipping_fee_id, shipping_box_id, country_code, location_code) FROM stdin;
1	1	152	1
2	2	152	1
3	3	152	1
4	4	152	1
5	5	152	1
6	6	152	1
7	7	152	1
8	1	152	2
9	2	152	2
10	3	152	2
11	4	152	2
12	5	152	2
13	6	152	2
14	7	152	2
15	1	152	3
16	2	152	3
17	3	152	3
18	4	152	3
19	5	152	3
20	6	152	3
21	7	152	3
22	1	152	4
23	2	152	4
24	3	152	4
25	4	152	4
26	5	152	4
27	6	152	4
28	7	152	4
29	1	152	5
30	2	152	5
31	3	152	5
32	4	152	5
33	5	152	5
34	6	152	5
35	7	152	5
36	1	152	6
37	2	152	6
38	3	152	6
39	4	152	6
40	5	152	6
41	6	152	6
42	7	152	6
43	1	152	7
44	2	152	7
45	3	152	7
46	4	152	7
47	5	152	7
48	6	152	7
49	7	152	7
50	1	152	8
51	2	152	8
52	3	152	8
53	4	152	8
54	5	152	8
55	6	152	8
56	7	152	8
57	1	152	9
58	2	152	9
59	3	152	9
60	4	152	9
61	5	152	9
62	6	152	9
63	7	152	9
64	1	152	10
65	2	152	10
66	3	152	10
67	4	152	10
68	5	152	10
69	6	152	10
70	7	152	10
71	1	152	11
72	2	152	11
73	3	152	11
74	4	152	11
75	5	152	11
76	6	152	11
77	7	152	11
78	1	152	12
79	2	152	12
80	3	152	12
81	4	152	12
82	5	152	12
83	6	152	12
84	7	152	12
85	1	152	13
86	2	152	13
87	3	152	13
88	4	152	13
89	5	152	13
90	6	152	13
91	7	152	13
92	1	152	14
93	2	152	14
94	3	152	14
95	4	152	14
96	5	152	14
97	6	152	14
98	7	152	14
99	1	152	15
100	2	152	15
101	3	152	15
102	4	152	15
103	5	152	15
104	6	152	15
105	7	152	15
106	1	152	16
107	2	152	16
108	3	152	16
109	4	152	16
110	5	152	16
111	6	152	16
112	7	152	16
113	1	152	17
114	2	152	17
115	3	152	17
116	4	152	17
117	5	152	17
118	6	152	17
119	7	152	17
120	1	152	18
121	2	152	18
122	3	152	18
123	4	152	18
124	5	152	18
125	6	152	18
126	7	152	18
127	1	152	19
128	2	152	19
129	3	152	19
130	4	152	19
131	5	152	19
132	6	152	19
133	7	152	19
134	1	152	20
135	2	152	20
136	3	152	20
137	4	152	20
138	5	152	20
139	6	152	20
140	7	152	20
141	1	152	21
142	2	152	21
143	3	152	21
144	4	152	21
145	5	152	21
146	6	152	21
147	7	152	21
148	1	152	22
149	2	152	22
150	3	152	22
151	4	152	22
152	5	152	22
153	6	152	22
154	7	152	22
155	1	152	23
156	2	152	23
157	3	152	23
158	4	152	23
159	5	152	23
160	6	152	23
161	7	152	23
162	1	152	24
163	2	152	24
164	3	152	24
165	4	152	24
166	5	152	24
167	6	152	24
168	7	152	24
169	1	152	25
170	2	152	25
171	3	152	25
172	4	152	25
173	5	152	25
174	6	152	25
175	7	152	25
176	1	152	26
177	2	152	26
178	3	152	26
179	4	152	26
180	5	152	26
181	6	152	26
182	7	152	26
183	1	152	27
184	2	152	27
185	3	152	27
186	4	152	27
187	5	152	27
188	6	152	27
189	7	152	27
190	1	152	28
191	2	152	28
192	3	152	28
193	4	152	28
194	5	152	28
195	6	152	28
196	7	152	28
197	1	152	29
198	2	152	29
199	3	152	29
200	4	152	29
201	5	152	29
202	6	152	29
203	7	152	29
204	1	152	30
205	2	152	30
206	3	152	30
207	4	152	30
208	5	152	30
209	6	152	30
210	7	152	30
211	1	152	31
212	2	152	31
213	3	152	31
214	4	152	31
215	5	152	31
216	6	152	31
217	7	152	31
218	1	152	32
219	2	152	32
220	3	152	32
221	4	152	32
222	5	152	32
223	6	152	32
224	7	152	32
225	1	152	33
226	2	152	33
227	3	152	33
228	4	152	33
229	5	152	33
230	6	152	33
231	7	152	33
232	1	152	34
233	2	152	34
234	3	152	34
235	4	152	34
236	5	152	34
237	6	152	34
238	7	152	34
239	1	152	35
240	2	152	35
241	3	152	35
242	4	152	35
243	5	152	35
244	6	152	35
245	7	152	35
246	1	152	36
247	2	152	36
248	3	152	36
249	4	152	36
250	5	152	36
251	6	152	36
252	7	152	36
253	1	152	37
254	2	152	37
255	3	152	37
256	4	152	37
257	5	152	37
258	6	152	37
259	7	152	37
260	1	152	38
261	2	152	38
262	3	152	38
263	4	152	38
264	5	152	38
265	6	152	38
266	7	152	38
267	1	152	39
268	2	152	39
269	3	152	39
270	4	152	39
271	5	152	39
272	6	152	39
273	7	152	39
274	1	152	40
275	2	152	40
276	3	152	40
277	4	152	40
278	5	152	40
279	6	152	40
280	7	152	40
281	1	152	41
282	2	152	41
283	3	152	41
284	4	152	41
285	5	152	41
286	6	152	41
287	7	152	41
288	1	152	42
289	2	152	42
290	3	152	42
291	4	152	42
292	5	152	42
293	6	152	42
294	7	152	42
295	1	152	43
296	2	152	43
297	3	152	43
298	4	152	43
299	5	152	43
300	6	152	43
301	7	152	43
302	1	152	44
303	2	152	44
304	3	152	44
305	4	152	44
306	5	152	44
307	6	152	44
308	7	152	44
309	1	152	45
310	2	152	45
311	3	152	45
312	4	152	45
313	5	152	45
314	6	152	45
315	7	152	45
316	1	152	46
317	2	152	46
318	3	152	46
319	4	152	46
320	5	152	46
321	6	152	46
322	7	152	46
323	1	152	47
324	2	152	47
325	3	152	47
326	8	152	1
327	9	152	1
328	10	152	1
329	11	152	1
330	12	152	1
331	13	152	1
332	14	152	1
333	15	152	1
334	8	152	2
335	9	152	2
336	10	152	2
337	11	152	2
338	12	152	2
339	13	152	2
340	14	152	2
341	15	152	2
342	8	152	3
343	9	152	3
344	10	152	3
345	11	152	3
346	12	152	3
347	13	152	3
348	14	152	3
349	15	152	3
350	8	152	4
351	9	152	4
352	10	152	4
353	11	152	4
354	12	152	4
355	13	152	4
356	14	152	4
357	15	152	4
358	8	152	5
359	9	152	5
360	10	152	5
361	11	152	5
362	12	152	5
363	13	152	5
364	14	152	5
365	15	152	5
366	8	152	6
367	9	152	6
368	10	152	6
369	11	152	6
370	12	152	6
371	13	152	6
372	14	152	6
373	15	152	6
374	8	152	7
375	9	152	7
376	10	152	7
377	11	152	7
378	12	152	7
379	13	152	7
380	14	152	7
381	15	152	7
382	8	152	8
383	9	152	8
384	10	152	8
385	11	152	8
386	12	152	8
387	13	152	8
388	14	152	8
389	15	152	8
390	8	152	9
391	9	152	9
392	10	152	9
393	11	152	9
394	12	152	9
395	13	152	9
396	14	152	9
397	15	152	9
398	8	152	10
399	9	152	10
400	10	152	10
401	11	152	10
402	12	152	10
403	13	152	10
404	14	152	10
405	15	152	10
406	8	152	11
407	9	152	11
408	10	152	11
409	11	152	11
410	12	152	11
411	13	152	11
412	14	152	11
413	15	152	11
414	8	152	12
415	9	152	12
416	10	152	12
417	11	152	12
418	12	152	12
419	13	152	12
420	14	152	12
421	15	152	12
422	8	152	13
423	9	152	13
424	10	152	13
425	11	152	13
426	12	152	13
427	13	152	13
428	14	152	13
429	15	152	13
430	8	152	14
431	9	152	14
432	10	152	14
433	11	152	14
434	12	152	14
435	13	152	14
436	14	152	14
437	15	152	14
438	8	152	15
439	9	152	15
440	10	152	15
441	11	152	15
442	12	152	15
443	13	152	15
444	14	152	15
445	15	152	15
446	8	152	16
447	9	152	16
448	10	152	16
449	11	152	16
450	12	152	16
451	13	152	16
452	14	152	16
453	15	152	16
454	8	152	17
455	9	152	17
456	10	152	17
457	11	152	17
458	12	152	17
459	13	152	17
460	14	152	17
461	15	152	17
462	8	152	18
463	9	152	18
464	10	152	18
465	11	152	18
466	12	152	18
467	13	152	18
468	14	152	18
469	15	152	18
470	8	152	19
471	9	152	19
472	10	152	19
473	11	152	19
474	12	152	19
475	13	152	19
476	14	152	19
477	15	152	19
478	8	152	20
479	9	152	20
480	10	152	20
481	11	152	20
482	12	152	20
483	13	152	20
484	14	152	20
485	15	152	20
486	8	152	21
487	9	152	21
488	10	152	21
489	11	152	21
490	12	152	21
491	13	152	21
492	14	152	21
493	15	152	21
494	8	152	22
495	9	152	22
496	10	152	22
497	11	152	22
498	12	152	22
499	13	152	22
500	14	152	22
501	15	152	22
502	8	152	23
503	9	152	23
504	10	152	23
505	11	152	23
506	12	152	23
507	13	152	23
508	14	152	23
509	15	152	23
510	8	152	24
511	9	152	24
512	10	152	24
513	11	152	24
514	12	152	24
515	13	152	24
516	14	152	24
517	15	152	24
518	8	152	25
519	9	152	25
520	10	152	25
521	11	152	25
522	12	152	25
523	13	152	25
524	14	152	25
525	15	152	25
526	8	152	26
527	9	152	26
528	10	152	26
529	11	152	26
530	12	152	26
531	13	152	26
532	14	152	26
533	15	152	26
534	8	152	27
535	9	152	27
536	10	152	27
537	11	152	27
538	12	152	27
539	13	152	27
540	14	152	27
541	15	152	27
542	8	152	28
543	9	152	28
544	10	152	28
545	11	152	28
546	12	152	28
547	13	152	28
548	14	152	28
549	15	152	28
550	8	152	29
551	9	152	29
552	10	152	29
553	11	152	29
554	12	152	29
555	13	152	29
556	14	152	29
557	15	152	29
558	8	152	30
559	9	152	30
560	10	152	30
561	11	152	30
562	12	152	30
563	13	152	30
564	14	152	30
565	15	152	30
566	8	152	31
567	9	152	31
568	10	152	31
569	11	152	31
570	12	152	31
571	13	152	31
572	14	152	31
573	15	152	31
574	8	152	32
575	9	152	32
576	10	152	32
577	11	152	32
578	12	152	32
579	13	152	32
580	14	152	32
581	15	152	32
582	8	152	33
583	9	152	33
584	10	152	33
585	11	152	33
586	12	152	33
587	13	152	33
588	14	152	33
589	15	152	33
590	8	152	34
591	9	152	34
592	10	152	34
593	11	152	34
594	12	152	34
595	13	152	34
596	14	152	34
597	15	152	34
598	8	152	35
599	9	152	35
600	10	152	35
601	11	152	35
602	12	152	35
603	13	152	35
604	14	152	35
605	15	152	35
606	8	152	36
607	9	152	36
608	10	152	36
609	11	152	36
610	12	152	36
611	13	152	36
612	14	152	36
613	15	152	36
614	8	152	37
615	9	152	37
616	10	152	37
617	11	152	37
618	12	152	37
619	13	152	37
620	14	152	37
621	15	152	37
622	8	152	38
623	9	152	38
624	10	152	38
625	11	152	38
626	12	152	38
627	13	152	38
628	14	152	38
629	15	152	38
630	8	152	39
631	9	152	39
632	10	152	39
633	11	152	39
634	12	152	39
635	13	152	39
636	14	152	39
637	15	152	39
638	8	152	40
639	9	152	40
640	10	152	40
641	11	152	40
642	12	152	40
643	13	152	40
644	14	152	40
645	15	152	40
646	8	152	41
647	9	152	41
648	10	152	41
649	11	152	41
650	12	152	41
651	13	152	41
652	14	152	41
653	15	152	41
654	8	152	42
655	9	152	42
656	10	152	42
657	11	152	42
658	12	152	42
659	13	152	42
660	14	152	42
661	15	152	42
662	8	152	43
663	9	152	43
664	10	152	43
665	11	152	43
666	12	152	43
667	13	152	43
668	14	152	43
669	15	152	43
670	8	152	44
671	9	152	44
672	10	152	44
673	11	152	44
674	12	152	44
675	13	152	44
676	14	152	44
677	15	152	44
678	8	152	45
679	9	152	45
680	10	152	45
681	11	152	45
682	12	152	45
683	13	152	45
684	14	152	45
685	15	152	45
686	8	152	46
687	9	152	46
688	10	152	46
689	11	152	46
690	12	152	46
691	13	152	46
692	14	152	46
693	15	152	46
694	16	152	1
695	16	152	2
696	16	152	3
697	16	152	4
698	16	152	5
699	16	152	6
700	16	152	7
701	16	152	8
702	16	152	9
703	16	152	10
704	16	152	11
705	16	152	12
706	16	152	13
707	16	152	14
708	16	152	15
709	16	152	16
710	16	152	17
711	16	152	18
712	16	152	19
713	16	152	20
714	16	152	21
715	16	152	22
716	16	152	23
717	16	152	24
718	16	152	25
719	16	152	26
720	16	152	27
721	16	152	28
722	16	152	29
723	16	152	30
724	16	152	31
725	16	152	32
726	16	152	33
727	16	152	34
728	16	152	35
729	16	152	36
730	16	152	37
731	16	152	38
732	16	152	39
733	16	152	40
734	16	152	41
735	16	152	42
736	16	152	43
737	16	152	44
738	16	152	45
739	16	152	46
740	16	152	47
1047	1004	152	1
1048	1004	152	2
1049	1004	152	3
1050	1004	152	4
1051	1004	152	5
1052	1004	152	6
1053	1004	152	7
1054	1004	152	8
1055	1004	152	9
1056	1004	152	10
1057	1004	152	11
1058	1004	152	12
1059	1004	152	13
1060	1004	152	14
1061	1004	152	15
1062	1004	152	16
1063	1004	152	17
1064	1004	152	18
1065	1004	152	19
1066	1004	152	20
1067	1004	152	21
1068	1004	152	22
1069	1004	152	23
1070	1004	152	24
1071	1004	152	25
1072	1004	152	26
1073	1004	152	27
1074	1004	152	28
1075	1004	152	29
1076	1004	152	30
1077	1004	152	31
1078	1004	152	32
1079	1004	152	33
1080	1004	152	34
1081	1004	152	35
1082	1004	152	36
1083	1004	152	37
1084	1004	152	38
1085	1004	152	39
1086	1004	152	40
1087	1004	152	41
1088	1004	152	42
1089	1004	152	43
1090	1004	152	44
1091	1004	152	45
1092	1004	152	46
\.


--
-- Data for Name: shipping_fee_history; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY shipping_fee_history (shipping_fee_history_id, shipping_fee_id, tax_id, fee, valid_until) FROM stdin;
241	241	1	900.00	9999-12-31 00:00:00
721	721	1	2700.00	9999-12-31 00:00:00
722	722	1	2700.00	9999-12-31 00:00:00
1	1	1	1900.00	9999-12-31 00:00:00
2	2	1	1900.00	9999-12-31 00:00:00
3	3	1	1900.00	9999-12-31 00:00:00
4	4	1	3500.00	9999-12-31 00:00:00
5	5	1	3730.00	9999-12-31 00:00:00
6	6	1	7250.00	9999-12-31 00:00:00
7	7	1	10250.00	9999-12-31 00:00:00
8	8	1	1500.00	9999-12-31 00:00:00
9	9	1	1500.00	9999-12-31 00:00:00
10	10	1	1500.00	9999-12-31 00:00:00
11	11	1	3100.00	9999-12-31 00:00:00
12	12	1	3230.00	9999-12-31 00:00:00
13	13	1	6750.00	9999-12-31 00:00:00
14	14	1	9750.00	9999-12-31 00:00:00
15	15	1	1500.00	9999-12-31 00:00:00
16	16	1	1500.00	9999-12-31 00:00:00
17	17	1	1500.00	9999-12-31 00:00:00
18	18	1	3100.00	9999-12-31 00:00:00
19	19	1	3230.00	9999-12-31 00:00:00
20	20	1	6750.00	9999-12-31 00:00:00
21	21	1	9750.00	9999-12-31 00:00:00
22	22	1	1500.00	9999-12-31 00:00:00
23	23	1	1500.00	9999-12-31 00:00:00
24	24	1	1500.00	9999-12-31 00:00:00
25	25	1	2500.00	9999-12-31 00:00:00
26	26	1	2730.00	9999-12-31 00:00:00
27	27	1	6250.00	9999-12-31 00:00:00
28	28	1	9250.00	9999-12-31 00:00:00
29	29	1	1500.00	9999-12-31 00:00:00
30	30	1	1500.00	9999-12-31 00:00:00
31	31	1	1500.00	9999-12-31 00:00:00
32	32	1	3100.00	9999-12-31 00:00:00
33	33	1	3230.00	9999-12-31 00:00:00
34	34	1	6750.00	9999-12-31 00:00:00
35	35	1	9750.00	9999-12-31 00:00:00
36	36	1	1500.00	9999-12-31 00:00:00
37	37	1	1500.00	9999-12-31 00:00:00
38	38	1	1500.00	9999-12-31 00:00:00
39	39	1	2500.00	9999-12-31 00:00:00
40	40	1	2730.00	9999-12-31 00:00:00
41	41	1	6250.00	9999-12-31 00:00:00
42	42	1	9250.00	9999-12-31 00:00:00
723	723	1	2700.00	9999-12-31 00:00:00
724	724	1	2200.00	9999-12-31 00:00:00
725	725	1	2200.00	9999-12-31 00:00:00
726	726	1	2200.00	9999-12-31 00:00:00
727	727	1	2200.00	9999-12-31 00:00:00
728	728	1	2200.00	9999-12-31 00:00:00
729	729	1	2700.00	9999-12-31 00:00:00
730	730	1	2700.00	9999-12-31 00:00:00
43	43	1	1500.00	9999-12-31 00:00:00
44	44	1	1500.00	9999-12-31 00:00:00
45	45	1	1500.00	9999-12-31 00:00:00
46	46	1	2500.00	9999-12-31 00:00:00
47	47	1	2730.00	9999-12-31 00:00:00
48	48	1	6250.00	9999-12-31 00:00:00
49	49	1	9250.00	9999-12-31 00:00:00
50	50	1	1300.00	9999-12-31 00:00:00
51	51	1	1300.00	9999-12-31 00:00:00
52	52	1	1300.00	9999-12-31 00:00:00
53	53	1	1550.00	9999-12-31 00:00:00
54	54	1	1580.00	9999-12-31 00:00:00
55	55	1	5100.00	9999-12-31 00:00:00
56	56	1	8100.00	9999-12-31 00:00:00
57	57	1	1300.00	9999-12-31 00:00:00
58	58	1	1300.00	9999-12-31 00:00:00
59	59	1	1300.00	9999-12-31 00:00:00
60	60	1	1550.00	9999-12-31 00:00:00
61	61	1	1580.00	9999-12-31 00:00:00
62	62	1	5100.00	9999-12-31 00:00:00
63	63	1	8100.00	9999-12-31 00:00:00
64	64	1	1300.00	9999-12-31 00:00:00
65	65	1	1300.00	9999-12-31 00:00:00
66	66	1	1300.00	9999-12-31 00:00:00
67	67	1	1550.00	9999-12-31 00:00:00
68	68	1	1580.00	9999-12-31 00:00:00
69	69	1	5100.00	9999-12-31 00:00:00
70	70	1	8100.00	9999-12-31 00:00:00
71	71	1	1300.00	9999-12-31 00:00:00
72	72	1	1300.00	9999-12-31 00:00:00
73	73	1	1300.00	9999-12-31 00:00:00
74	74	1	1550.00	9999-12-31 00:00:00
75	75	1	1580.00	9999-12-31 00:00:00
76	76	1	5100.00	9999-12-31 00:00:00
77	77	1	8100.00	9999-12-31 00:00:00
78	78	1	1300.00	9999-12-31 00:00:00
79	79	1	1300.00	9999-12-31 00:00:00
80	80	1	1300.00	9999-12-31 00:00:00
81	81	1	1550.00	9999-12-31 00:00:00
82	82	1	1580.00	9999-12-31 00:00:00
83	83	1	5100.00	9999-12-31 00:00:00
84	84	1	8100.00	9999-12-31 00:00:00
85	85	1	1300.00	9999-12-31 00:00:00
86	86	1	1300.00	9999-12-31 00:00:00
87	87	1	1300.00	9999-12-31 00:00:00
88	88	1	1550.00	9999-12-31 00:00:00
89	89	1	1580.00	9999-12-31 00:00:00
90	90	1	5100.00	9999-12-31 00:00:00
91	91	1	8100.00	9999-12-31 00:00:00
92	92	1	1300.00	9999-12-31 00:00:00
93	93	1	1300.00	9999-12-31 00:00:00
94	94	1	1300.00	9999-12-31 00:00:00
95	95	1	1550.00	9999-12-31 00:00:00
96	96	1	1580.00	9999-12-31 00:00:00
97	97	1	5100.00	9999-12-31 00:00:00
98	98	1	8100.00	9999-12-31 00:00:00
99	99	1	1300.00	9999-12-31 00:00:00
100	100	1	1300.00	9999-12-31 00:00:00
101	101	1	1300.00	9999-12-31 00:00:00
102	102	1	1550.00	9999-12-31 00:00:00
103	103	1	1580.00	9999-12-31 00:00:00
104	104	1	5100.00	9999-12-31 00:00:00
105	105	1	8100.00	9999-12-31 00:00:00
106	106	1	1100.00	9999-12-31 00:00:00
107	107	1	1100.00	9999-12-31 00:00:00
108	108	1	1100.00	9999-12-31 00:00:00
109	109	1	1420.00	9999-12-31 00:00:00
110	110	1	1480.00	9999-12-31 00:00:00
111	111	1	5000.00	9999-12-31 00:00:00
112	112	1	8000.00	9999-12-31 00:00:00
113	113	1	1100.00	9999-12-31 00:00:00
114	114	1	1100.00	9999-12-31 00:00:00
115	115	1	1100.00	9999-12-31 00:00:00
116	116	1	1420.00	9999-12-31 00:00:00
117	117	1	1480.00	9999-12-31 00:00:00
118	118	1	5000.00	9999-12-31 00:00:00
119	119	1	8000.00	9999-12-31 00:00:00
120	120	1	1100.00	9999-12-31 00:00:00
121	121	1	1100.00	9999-12-31 00:00:00
122	122	1	1100.00	9999-12-31 00:00:00
123	123	1	1420.00	9999-12-31 00:00:00
124	124	1	1480.00	9999-12-31 00:00:00
125	125	1	5000.00	9999-12-31 00:00:00
126	126	1	8000.00	9999-12-31 00:00:00
127	127	1	1300.00	9999-12-31 00:00:00
128	128	1	1300.00	9999-12-31 00:00:00
129	129	1	1300.00	9999-12-31 00:00:00
130	130	1	1550.00	9999-12-31 00:00:00
131	131	1	1580.00	9999-12-31 00:00:00
132	132	1	5100.00	9999-12-31 00:00:00
133	133	1	8100.00	9999-12-31 00:00:00
134	134	1	1300.00	9999-12-31 00:00:00
135	135	1	1300.00	9999-12-31 00:00:00
136	136	1	1300.00	9999-12-31 00:00:00
137	137	1	1550.00	9999-12-31 00:00:00
138	138	1	1580.00	9999-12-31 00:00:00
139	139	1	5100.00	9999-12-31 00:00:00
140	140	1	8100.00	9999-12-31 00:00:00
141	141	1	1100.00	9999-12-31 00:00:00
142	142	1	1100.00	9999-12-31 00:00:00
143	143	1	1100.00	9999-12-31 00:00:00
144	144	1	1420.00	9999-12-31 00:00:00
145	145	1	1480.00	9999-12-31 00:00:00
146	146	1	5000.00	9999-12-31 00:00:00
147	147	1	8000.00	9999-12-31 00:00:00
148	148	1	1100.00	9999-12-31 00:00:00
149	149	1	1100.00	9999-12-31 00:00:00
150	150	1	1100.00	9999-12-31 00:00:00
151	151	1	1420.00	9999-12-31 00:00:00
152	152	1	1480.00	9999-12-31 00:00:00
153	153	1	5000.00	9999-12-31 00:00:00
154	154	1	8000.00	9999-12-31 00:00:00
155	155	1	1100.00	9999-12-31 00:00:00
156	156	1	1100.00	9999-12-31 00:00:00
157	157	1	1100.00	9999-12-31 00:00:00
158	158	1	1420.00	9999-12-31 00:00:00
159	159	1	1480.00	9999-12-31 00:00:00
160	160	1	5000.00	9999-12-31 00:00:00
161	161	1	8000.00	9999-12-31 00:00:00
162	162	1	1100.00	9999-12-31 00:00:00
163	163	1	1100.00	9999-12-31 00:00:00
164	164	1	1100.00	9999-12-31 00:00:00
165	165	1	1420.00	9999-12-31 00:00:00
166	166	1	1480.00	9999-12-31 00:00:00
167	167	1	5000.00	9999-12-31 00:00:00
168	168	1	8000.00	9999-12-31 00:00:00
169	169	1	1000.00	9999-12-31 00:00:00
170	170	1	1000.00	9999-12-31 00:00:00
171	171	1	1000.00	9999-12-31 00:00:00
172	172	1	1300.00	9999-12-31 00:00:00
173	173	1	1380.00	9999-12-31 00:00:00
174	174	1	4900.00	9999-12-31 00:00:00
175	175	1	7900.00	9999-12-31 00:00:00
176	176	1	1000.00	9999-12-31 00:00:00
177	177	1	1000.00	9999-12-31 00:00:00
178	178	1	1000.00	9999-12-31 00:00:00
179	179	1	1300.00	9999-12-31 00:00:00
180	180	1	1380.00	9999-12-31 00:00:00
181	181	1	4900.00	9999-12-31 00:00:00
182	182	1	7900.00	9999-12-31 00:00:00
183	183	1	1000.00	9999-12-31 00:00:00
184	184	1	1000.00	9999-12-31 00:00:00
185	185	1	1000.00	9999-12-31 00:00:00
186	186	1	1300.00	9999-12-31 00:00:00
187	187	1	1380.00	9999-12-31 00:00:00
188	188	1	4900.00	9999-12-31 00:00:00
189	189	1	7900.00	9999-12-31 00:00:00
190	190	1	1000.00	9999-12-31 00:00:00
191	191	1	1000.00	9999-12-31 00:00:00
192	192	1	1000.00	9999-12-31 00:00:00
193	193	1	1300.00	9999-12-31 00:00:00
194	194	1	1380.00	9999-12-31 00:00:00
195	195	1	4900.00	9999-12-31 00:00:00
196	196	1	7900.00	9999-12-31 00:00:00
197	197	1	1000.00	9999-12-31 00:00:00
198	198	1	1000.00	9999-12-31 00:00:00
199	199	1	1000.00	9999-12-31 00:00:00
200	200	1	1300.00	9999-12-31 00:00:00
201	201	1	1380.00	9999-12-31 00:00:00
202	202	1	4900.00	9999-12-31 00:00:00
203	203	1	7900.00	9999-12-31 00:00:00
204	204	1	1000.00	9999-12-31 00:00:00
205	205	1	1000.00	9999-12-31 00:00:00
206	206	1	1000.00	9999-12-31 00:00:00
207	207	1	1300.00	9999-12-31 00:00:00
208	208	1	1380.00	9999-12-31 00:00:00
209	209	1	4900.00	9999-12-31 00:00:00
210	210	1	7900.00	9999-12-31 00:00:00
211	211	1	900.00	9999-12-31 00:00:00
212	212	1	900.00	9999-12-31 00:00:00
213	213	1	900.00	9999-12-31 00:00:00
214	214	1	1200.00	9999-12-31 00:00:00
215	215	1	1380.00	9999-12-31 00:00:00
216	216	1	4900.00	9999-12-31 00:00:00
217	217	1	7900.00	9999-12-31 00:00:00
218	218	1	900.00	9999-12-31 00:00:00
219	219	1	900.00	9999-12-31 00:00:00
220	220	1	900.00	9999-12-31 00:00:00
221	221	1	1200.00	9999-12-31 00:00:00
222	222	1	1380.00	9999-12-31 00:00:00
223	223	1	4900.00	9999-12-31 00:00:00
224	224	1	7900.00	9999-12-31 00:00:00
225	225	1	900.00	9999-12-31 00:00:00
226	226	1	900.00	9999-12-31 00:00:00
227	227	1	900.00	9999-12-31 00:00:00
228	228	1	1200.00	9999-12-31 00:00:00
229	229	1	1380.00	9999-12-31 00:00:00
230	230	1	4900.00	9999-12-31 00:00:00
231	231	1	7900.00	9999-12-31 00:00:00
232	232	1	900.00	9999-12-31 00:00:00
233	233	1	900.00	9999-12-31 00:00:00
234	234	1	900.00	9999-12-31 00:00:00
235	235	1	1200.00	9999-12-31 00:00:00
236	236	1	1380.00	9999-12-31 00:00:00
237	237	1	4900.00	9999-12-31 00:00:00
238	238	1	7900.00	9999-12-31 00:00:00
239	239	1	900.00	9999-12-31 00:00:00
240	240	1	900.00	9999-12-31 00:00:00
242	242	1	1200.00	9999-12-31 00:00:00
243	243	1	1380.00	9999-12-31 00:00:00
244	244	1	4900.00	9999-12-31 00:00:00
245	245	1	7900.00	9999-12-31 00:00:00
246	246	1	1000.00	9999-12-31 00:00:00
247	247	1	1000.00	9999-12-31 00:00:00
248	248	1	1000.00	9999-12-31 00:00:00
249	249	1	1200.00	9999-12-31 00:00:00
250	250	1	1280.00	9999-12-31 00:00:00
251	251	1	4800.00	9999-12-31 00:00:00
252	252	1	7800.00	9999-12-31 00:00:00
253	253	1	1000.00	9999-12-31 00:00:00
254	254	1	1000.00	9999-12-31 00:00:00
255	255	1	1000.00	9999-12-31 00:00:00
256	256	1	1200.00	9999-12-31 00:00:00
257	257	1	1280.00	9999-12-31 00:00:00
258	258	1	4800.00	9999-12-31 00:00:00
259	259	1	7800.00	9999-12-31 00:00:00
260	260	1	1000.00	9999-12-31 00:00:00
261	261	1	1000.00	9999-12-31 00:00:00
262	262	1	1000.00	9999-12-31 00:00:00
263	263	1	1200.00	9999-12-31 00:00:00
264	264	1	1280.00	9999-12-31 00:00:00
265	265	1	4800.00	9999-12-31 00:00:00
266	266	1	7800.00	9999-12-31 00:00:00
267	267	1	1000.00	9999-12-31 00:00:00
268	268	1	1000.00	9999-12-31 00:00:00
269	269	1	1000.00	9999-12-31 00:00:00
270	270	1	1200.00	9999-12-31 00:00:00
271	271	1	1280.00	9999-12-31 00:00:00
272	272	1	4800.00	9999-12-31 00:00:00
273	273	1	7800.00	9999-12-31 00:00:00
274	274	1	900.00	9999-12-31 00:00:00
275	275	1	900.00	9999-12-31 00:00:00
276	276	1	900.00	9999-12-31 00:00:00
277	277	1	1120.00	9999-12-31 00:00:00
278	278	1	1180.00	9999-12-31 00:00:00
279	279	1	4700.00	9999-12-31 00:00:00
280	280	1	7700.00	9999-12-31 00:00:00
281	281	1	900.00	9999-12-31 00:00:00
282	282	1	900.00	9999-12-31 00:00:00
283	283	1	900.00	9999-12-31 00:00:00
284	284	1	1120.00	9999-12-31 00:00:00
285	285	1	1180.00	9999-12-31 00:00:00
286	286	1	4700.00	9999-12-31 00:00:00
287	287	1	7700.00	9999-12-31 00:00:00
288	288	1	900.00	9999-12-31 00:00:00
289	289	1	900.00	9999-12-31 00:00:00
290	290	1	900.00	9999-12-31 00:00:00
291	291	1	1120.00	9999-12-31 00:00:00
292	292	1	1180.00	9999-12-31 00:00:00
293	293	1	4700.00	9999-12-31 00:00:00
294	294	1	7700.00	9999-12-31 00:00:00
295	295	1	900.00	9999-12-31 00:00:00
296	296	1	900.00	9999-12-31 00:00:00
297	297	1	900.00	9999-12-31 00:00:00
298	298	1	1120.00	9999-12-31 00:00:00
299	299	1	1180.00	9999-12-31 00:00:00
300	300	1	4700.00	9999-12-31 00:00:00
301	301	1	7700.00	9999-12-31 00:00:00
302	302	1	900.00	9999-12-31 00:00:00
303	303	1	900.00	9999-12-31 00:00:00
304	304	1	900.00	9999-12-31 00:00:00
305	305	1	1120.00	9999-12-31 00:00:00
306	306	1	1180.00	9999-12-31 00:00:00
307	307	1	4700.00	9999-12-31 00:00:00
308	308	1	7700.00	9999-12-31 00:00:00
309	309	1	900.00	9999-12-31 00:00:00
310	310	1	900.00	9999-12-31 00:00:00
311	311	1	900.00	9999-12-31 00:00:00
312	312	1	1120.00	9999-12-31 00:00:00
313	313	1	1180.00	9999-12-31 00:00:00
314	314	1	4700.00	9999-12-31 00:00:00
315	315	1	7700.00	9999-12-31 00:00:00
316	316	1	900.00	9999-12-31 00:00:00
317	317	1	900.00	9999-12-31 00:00:00
318	318	1	900.00	9999-12-31 00:00:00
319	319	1	1120.00	9999-12-31 00:00:00
320	320	1	1180.00	9999-12-31 00:00:00
321	321	1	4700.00	9999-12-31 00:00:00
322	322	1	7700.00	9999-12-31 00:00:00
323	323	1	1300.00	9999-12-31 00:00:00
324	324	1	1300.00	9999-12-31 00:00:00
325	325	1	1300.00	9999-12-31 00:00:00
327	327	1	7000.00	9999-12-31 00:00:00
328	328	1	7230.00	9999-12-31 00:00:00
329	329	1	11250.00	9999-12-31 00:00:00
330	330	1	3730.00	9999-12-31 00:00:00
331	331	1	7460.00	9999-12-31 00:00:00
332	332	1	11480.00	9999-12-31 00:00:00
333	333	1	7750.00	9999-12-31 00:00:00
334	334	1	3100.00	9999-12-31 00:00:00
335	335	1	6200.00	9999-12-31 00:00:00
336	336	1	6230.00	9999-12-31 00:00:00
337	337	1	10350.00	9999-12-31 00:00:00
338	338	1	3130.00	9999-12-31 00:00:00
339	339	1	6260.00	9999-12-31 00:00:00
340	340	1	10380.00	9999-12-31 00:00:00
341	341	1	7250.00	9999-12-31 00:00:00
342	342	1	3100.00	9999-12-31 00:00:00
343	343	1	6200.00	9999-12-31 00:00:00
344	344	1	6230.00	9999-12-31 00:00:00
345	345	1	10350.00	9999-12-31 00:00:00
346	346	1	3130.00	9999-12-31 00:00:00
347	347	1	6260.00	9999-12-31 00:00:00
348	348	1	10380.00	9999-12-31 00:00:00
349	349	1	7250.00	9999-12-31 00:00:00
350	350	1	2500.00	9999-12-31 00:00:00
351	351	1	5000.00	9999-12-31 00:00:00
352	352	1	5230.00	9999-12-31 00:00:00
353	353	1	9250.00	9999-12-31 00:00:00
354	354	1	2730.00	9999-12-31 00:00:00
355	355	1	5460.00	9999-12-31 00:00:00
356	356	1	9480.00	9999-12-31 00:00:00
357	357	1	6750.00	9999-12-31 00:00:00
358	358	1	3100.00	9999-12-31 00:00:00
359	359	1	6200.00	9999-12-31 00:00:00
360	360	1	6230.00	9999-12-31 00:00:00
361	361	1	10350.00	9999-12-31 00:00:00
362	362	1	3130.00	9999-12-31 00:00:00
363	363	1	6260.00	9999-12-31 00:00:00
364	364	1	10380.00	9999-12-31 00:00:00
365	365	1	7250.00	9999-12-31 00:00:00
366	366	1	2500.00	9999-12-31 00:00:00
367	367	1	5000.00	9999-12-31 00:00:00
368	368	1	5230.00	9999-12-31 00:00:00
369	369	1	9250.00	9999-12-31 00:00:00
370	370	1	2730.00	9999-12-31 00:00:00
371	371	1	5460.00	9999-12-31 00:00:00
372	372	1	9480.00	9999-12-31 00:00:00
373	373	1	6750.00	9999-12-31 00:00:00
374	374	1	2500.00	9999-12-31 00:00:00
375	375	1	5000.00	9999-12-31 00:00:00
376	376	1	5230.00	9999-12-31 00:00:00
377	377	1	9250.00	9999-12-31 00:00:00
378	378	1	2730.00	9999-12-31 00:00:00
379	379	1	5460.00	9999-12-31 00:00:00
380	380	1	9480.00	9999-12-31 00:00:00
381	381	1	6750.00	9999-12-31 00:00:00
382	382	1	1550.00	9999-12-31 00:00:00
383	383	1	3100.00	9999-12-31 00:00:00
384	384	1	3130.00	9999-12-31 00:00:00
385	385	1	7150.00	9999-12-31 00:00:00
386	386	1	1580.00	9999-12-31 00:00:00
387	387	1	3160.00	9999-12-31 00:00:00
388	388	1	7180.00	9999-12-31 00:00:00
389	389	1	5600.00	9999-12-31 00:00:00
390	390	1	1550.00	9999-12-31 00:00:00
391	391	1	3100.00	9999-12-31 00:00:00
392	392	1	3130.00	9999-12-31 00:00:00
393	393	1	7150.00	9999-12-31 00:00:00
394	394	1	1580.00	9999-12-31 00:00:00
395	395	1	3160.00	9999-12-31 00:00:00
396	396	1	7180.00	9999-12-31 00:00:00
397	397	1	5600.00	9999-12-31 00:00:00
398	398	1	1550.00	9999-12-31 00:00:00
399	399	1	3100.00	9999-12-31 00:00:00
400	400	1	3130.00	9999-12-31 00:00:00
401	401	1	7150.00	9999-12-31 00:00:00
402	402	1	1580.00	9999-12-31 00:00:00
403	403	1	3160.00	9999-12-31 00:00:00
404	404	1	7180.00	9999-12-31 00:00:00
405	405	1	5600.00	9999-12-31 00:00:00
406	406	1	1550.00	9999-12-31 00:00:00
407	407	1	3100.00	9999-12-31 00:00:00
408	408	1	3130.00	9999-12-31 00:00:00
409	409	1	7150.00	9999-12-31 00:00:00
410	410	1	1580.00	9999-12-31 00:00:00
411	411	1	3160.00	9999-12-31 00:00:00
412	412	1	7180.00	9999-12-31 00:00:00
413	413	1	5600.00	9999-12-31 00:00:00
414	414	1	1550.00	9999-12-31 00:00:00
415	415	1	3100.00	9999-12-31 00:00:00
416	416	1	3130.00	9999-12-31 00:00:00
417	417	1	7150.00	9999-12-31 00:00:00
418	418	1	1580.00	9999-12-31 00:00:00
419	419	1	3160.00	9999-12-31 00:00:00
420	420	1	7180.00	9999-12-31 00:00:00
421	421	1	5600.00	9999-12-31 00:00:00
422	422	1	1550.00	9999-12-31 00:00:00
423	423	1	3100.00	9999-12-31 00:00:00
424	424	1	3130.00	9999-12-31 00:00:00
425	425	1	7150.00	9999-12-31 00:00:00
426	426	1	1580.00	9999-12-31 00:00:00
427	427	1	3160.00	9999-12-31 00:00:00
428	428	1	7180.00	9999-12-31 00:00:00
429	429	1	5600.00	9999-12-31 00:00:00
430	430	1	1550.00	9999-12-31 00:00:00
431	431	1	3100.00	9999-12-31 00:00:00
432	432	1	3130.00	9999-12-31 00:00:00
433	433	1	7150.00	9999-12-31 00:00:00
434	434	1	1580.00	9999-12-31 00:00:00
435	435	1	3160.00	9999-12-31 00:00:00
436	436	1	7180.00	9999-12-31 00:00:00
437	437	1	5600.00	9999-12-31 00:00:00
438	438	1	1550.00	9999-12-31 00:00:00
439	439	1	3100.00	9999-12-31 00:00:00
440	440	1	3130.00	9999-12-31 00:00:00
441	441	1	7150.00	9999-12-31 00:00:00
442	442	1	1580.00	9999-12-31 00:00:00
443	443	1	3160.00	9999-12-31 00:00:00
444	444	1	7180.00	9999-12-31 00:00:00
445	445	1	5600.00	9999-12-31 00:00:00
446	446	1	1420.00	9999-12-31 00:00:00
447	447	1	2840.00	9999-12-31 00:00:00
448	448	1	2900.00	9999-12-31 00:00:00
449	449	1	6920.00	9999-12-31 00:00:00
450	450	1	1480.00	9999-12-31 00:00:00
451	451	1	2960.00	9999-12-31 00:00:00
452	452	1	6980.00	9999-12-31 00:00:00
453	453	1	5500.00	9999-12-31 00:00:00
454	454	1	1420.00	9999-12-31 00:00:00
455	455	1	2840.00	9999-12-31 00:00:00
456	456	1	2900.00	9999-12-31 00:00:00
457	457	1	6920.00	9999-12-31 00:00:00
458	458	1	1480.00	9999-12-31 00:00:00
459	459	1	2960.00	9999-12-31 00:00:00
460	460	1	6980.00	9999-12-31 00:00:00
461	461	1	5500.00	9999-12-31 00:00:00
462	462	1	1420.00	9999-12-31 00:00:00
463	463	1	2840.00	9999-12-31 00:00:00
464	464	1	2900.00	9999-12-31 00:00:00
465	465	1	6920.00	9999-12-31 00:00:00
466	466	1	1480.00	9999-12-31 00:00:00
467	467	1	2960.00	9999-12-31 00:00:00
468	468	1	6980.00	9999-12-31 00:00:00
469	469	1	5500.00	9999-12-31 00:00:00
470	470	1	1550.00	9999-12-31 00:00:00
471	471	1	3100.00	9999-12-31 00:00:00
472	472	1	3130.00	9999-12-31 00:00:00
473	473	1	7150.00	9999-12-31 00:00:00
474	474	1	1580.00	9999-12-31 00:00:00
475	475	1	3160.00	9999-12-31 00:00:00
476	476	1	7180.00	9999-12-31 00:00:00
477	477	1	5600.00	9999-12-31 00:00:00
478	478	1	1550.00	9999-12-31 00:00:00
479	479	1	3100.00	9999-12-31 00:00:00
480	480	1	3130.00	9999-12-31 00:00:00
481	481	1	7150.00	9999-12-31 00:00:00
482	482	1	1580.00	9999-12-31 00:00:00
483	483	1	3160.00	9999-12-31 00:00:00
484	484	1	7180.00	9999-12-31 00:00:00
485	485	1	5600.00	9999-12-31 00:00:00
486	486	1	1420.00	9999-12-31 00:00:00
487	487	1	2840.00	9999-12-31 00:00:00
488	488	1	2900.00	9999-12-31 00:00:00
489	489	1	6920.00	9999-12-31 00:00:00
490	490	1	1480.00	9999-12-31 00:00:00
491	491	1	2960.00	9999-12-31 00:00:00
492	492	1	6980.00	9999-12-31 00:00:00
493	493	1	5500.00	9999-12-31 00:00:00
494	494	1	1420.00	9999-12-31 00:00:00
495	495	1	2840.00	9999-12-31 00:00:00
496	496	1	2900.00	9999-12-31 00:00:00
497	497	1	6920.00	9999-12-31 00:00:00
498	498	1	1480.00	9999-12-31 00:00:00
499	499	1	2960.00	9999-12-31 00:00:00
500	500	1	6980.00	9999-12-31 00:00:00
501	501	1	5500.00	9999-12-31 00:00:00
502	502	1	1420.00	9999-12-31 00:00:00
503	503	1	2840.00	9999-12-31 00:00:00
504	504	1	2900.00	9999-12-31 00:00:00
505	505	1	6920.00	9999-12-31 00:00:00
506	506	1	1480.00	9999-12-31 00:00:00
507	507	1	2960.00	9999-12-31 00:00:00
508	508	1	6980.00	9999-12-31 00:00:00
509	509	1	5500.00	9999-12-31 00:00:00
510	510	1	1420.00	9999-12-31 00:00:00
511	511	1	2840.00	9999-12-31 00:00:00
512	512	1	2900.00	9999-12-31 00:00:00
513	513	1	6920.00	9999-12-31 00:00:00
514	514	1	1480.00	9999-12-31 00:00:00
515	515	1	2960.00	9999-12-31 00:00:00
516	516	1	6980.00	9999-12-31 00:00:00
517	517	1	5500.00	9999-12-31 00:00:00
518	518	1	1300.00	9999-12-31 00:00:00
519	519	1	2600.00	9999-12-31 00:00:00
520	520	1	2680.00	9999-12-31 00:00:00
521	521	1	6700.00	9999-12-31 00:00:00
522	522	1	1380.00	9999-12-31 00:00:00
523	523	1	2760.00	9999-12-31 00:00:00
524	524	1	6780.00	9999-12-31 00:00:00
525	525	1	5400.00	9999-12-31 00:00:00
526	526	1	1300.00	9999-12-31 00:00:00
527	527	1	2600.00	9999-12-31 00:00:00
528	528	1	2680.00	9999-12-31 00:00:00
529	529	1	6700.00	9999-12-31 00:00:00
530	530	1	1380.00	9999-12-31 00:00:00
531	531	1	2760.00	9999-12-31 00:00:00
532	532	1	6780.00	9999-12-31 00:00:00
533	533	1	5400.00	9999-12-31 00:00:00
534	534	1	1300.00	9999-12-31 00:00:00
535	535	1	2600.00	9999-12-31 00:00:00
536	536	1	2680.00	9999-12-31 00:00:00
537	537	1	6700.00	9999-12-31 00:00:00
538	538	1	1380.00	9999-12-31 00:00:00
539	539	1	2760.00	9999-12-31 00:00:00
540	540	1	6780.00	9999-12-31 00:00:00
541	541	1	5400.00	9999-12-31 00:00:00
542	542	1	1300.00	9999-12-31 00:00:00
543	543	1	2600.00	9999-12-31 00:00:00
544	544	1	2680.00	9999-12-31 00:00:00
545	545	1	6700.00	9999-12-31 00:00:00
546	546	1	1380.00	9999-12-31 00:00:00
547	547	1	2760.00	9999-12-31 00:00:00
548	548	1	6780.00	9999-12-31 00:00:00
549	549	1	5400.00	9999-12-31 00:00:00
550	550	1	1300.00	9999-12-31 00:00:00
551	551	1	2600.00	9999-12-31 00:00:00
552	552	1	2680.00	9999-12-31 00:00:00
553	553	1	6700.00	9999-12-31 00:00:00
554	554	1	1380.00	9999-12-31 00:00:00
555	555	1	2760.00	9999-12-31 00:00:00
556	556	1	6780.00	9999-12-31 00:00:00
557	557	1	5400.00	9999-12-31 00:00:00
558	558	1	1300.00	9999-12-31 00:00:00
559	559	1	2600.00	9999-12-31 00:00:00
560	560	1	2680.00	9999-12-31 00:00:00
561	561	1	6700.00	9999-12-31 00:00:00
562	562	1	1380.00	9999-12-31 00:00:00
563	563	1	2760.00	9999-12-31 00:00:00
564	564	1	6780.00	9999-12-31 00:00:00
565	565	1	5400.00	9999-12-31 00:00:00
566	566	1	1300.00	9999-12-31 00:00:00
567	567	1	2600.00	9999-12-31 00:00:00
568	568	1	2680.00	9999-12-31 00:00:00
569	569	1	6700.00	9999-12-31 00:00:00
570	570	1	1380.00	9999-12-31 00:00:00
571	571	1	2760.00	9999-12-31 00:00:00
572	572	1	6780.00	9999-12-31 00:00:00
573	573	1	5400.00	9999-12-31 00:00:00
574	574	1	1300.00	9999-12-31 00:00:00
575	575	1	2600.00	9999-12-31 00:00:00
576	576	1	2680.00	9999-12-31 00:00:00
577	577	1	6700.00	9999-12-31 00:00:00
578	578	1	1380.00	9999-12-31 00:00:00
579	579	1	2760.00	9999-12-31 00:00:00
580	580	1	6780.00	9999-12-31 00:00:00
581	581	1	5400.00	9999-12-31 00:00:00
582	582	1	1300.00	9999-12-31 00:00:00
583	583	1	2600.00	9999-12-31 00:00:00
584	584	1	2680.00	9999-12-31 00:00:00
585	585	1	6700.00	9999-12-31 00:00:00
586	586	1	1380.00	9999-12-31 00:00:00
587	587	1	2760.00	9999-12-31 00:00:00
588	588	1	6780.00	9999-12-31 00:00:00
589	589	1	5400.00	9999-12-31 00:00:00
590	590	1	1300.00	9999-12-31 00:00:00
591	591	1	2600.00	9999-12-31 00:00:00
592	592	1	2680.00	9999-12-31 00:00:00
593	593	1	6700.00	9999-12-31 00:00:00
594	594	1	1380.00	9999-12-31 00:00:00
595	595	1	2760.00	9999-12-31 00:00:00
596	596	1	6780.00	9999-12-31 00:00:00
597	597	1	5400.00	9999-12-31 00:00:00
598	598	1	1300.00	9999-12-31 00:00:00
599	599	1	2600.00	9999-12-31 00:00:00
600	600	1	2680.00	9999-12-31 00:00:00
601	601	1	6700.00	9999-12-31 00:00:00
602	602	1	1380.00	9999-12-31 00:00:00
603	603	1	2760.00	9999-12-31 00:00:00
604	604	1	6780.00	9999-12-31 00:00:00
605	605	1	5400.00	9999-12-31 00:00:00
606	606	1	1200.00	9999-12-31 00:00:00
607	607	1	2400.00	9999-12-31 00:00:00
608	608	1	2480.00	9999-12-31 00:00:00
609	609	1	6500.00	9999-12-31 00:00:00
610	610	1	1280.00	9999-12-31 00:00:00
611	611	1	2560.00	9999-12-31 00:00:00
612	612	1	6580.00	9999-12-31 00:00:00
613	613	1	5300.00	9999-12-31 00:00:00
614	614	1	1200.00	9999-12-31 00:00:00
615	615	1	2400.00	9999-12-31 00:00:00
616	616	1	2480.00	9999-12-31 00:00:00
617	617	1	6500.00	9999-12-31 00:00:00
618	618	1	1280.00	9999-12-31 00:00:00
619	619	1	2560.00	9999-12-31 00:00:00
620	620	1	6580.00	9999-12-31 00:00:00
621	621	1	5300.00	9999-12-31 00:00:00
622	622	1	1200.00	9999-12-31 00:00:00
623	623	1	2400.00	9999-12-31 00:00:00
624	624	1	2480.00	9999-12-31 00:00:00
625	625	1	6500.00	9999-12-31 00:00:00
626	626	1	1280.00	9999-12-31 00:00:00
627	627	1	2560.00	9999-12-31 00:00:00
628	628	1	6580.00	9999-12-31 00:00:00
629	629	1	5300.00	9999-12-31 00:00:00
630	630	1	1200.00	9999-12-31 00:00:00
631	631	1	2400.00	9999-12-31 00:00:00
632	632	1	2480.00	9999-12-31 00:00:00
633	633	1	6500.00	9999-12-31 00:00:00
634	634	1	1280.00	9999-12-31 00:00:00
635	635	1	2560.00	9999-12-31 00:00:00
636	636	1	6580.00	9999-12-31 00:00:00
637	637	1	5300.00	9999-12-31 00:00:00
638	638	1	1120.00	9999-12-31 00:00:00
639	639	1	2240.00	9999-12-31 00:00:00
640	640	1	2300.00	9999-12-31 00:00:00
641	641	1	6320.00	9999-12-31 00:00:00
642	642	1	1180.00	9999-12-31 00:00:00
643	643	1	2360.00	9999-12-31 00:00:00
644	644	1	6380.00	9999-12-31 00:00:00
645	645	1	5200.00	9999-12-31 00:00:00
646	646	1	1120.00	9999-12-31 00:00:00
647	647	1	2240.00	9999-12-31 00:00:00
648	648	1	2300.00	9999-12-31 00:00:00
649	649	1	6320.00	9999-12-31 00:00:00
650	650	1	1180.00	9999-12-31 00:00:00
651	651	1	2360.00	9999-12-31 00:00:00
652	652	1	6380.00	9999-12-31 00:00:00
653	653	1	5200.00	9999-12-31 00:00:00
654	654	1	1120.00	9999-12-31 00:00:00
655	655	1	2240.00	9999-12-31 00:00:00
656	656	1	2300.00	9999-12-31 00:00:00
657	657	1	6320.00	9999-12-31 00:00:00
658	658	1	1180.00	9999-12-31 00:00:00
659	659	1	2360.00	9999-12-31 00:00:00
660	660	1	6380.00	9999-12-31 00:00:00
661	661	1	5200.00	9999-12-31 00:00:00
662	662	1	1120.00	9999-12-31 00:00:00
663	663	1	2240.00	9999-12-31 00:00:00
664	664	1	2300.00	9999-12-31 00:00:00
665	665	1	6320.00	9999-12-31 00:00:00
666	666	1	1180.00	9999-12-31 00:00:00
667	667	1	2360.00	9999-12-31 00:00:00
668	668	1	6380.00	9999-12-31 00:00:00
669	669	1	5200.00	9999-12-31 00:00:00
670	670	1	1120.00	9999-12-31 00:00:00
671	671	1	2240.00	9999-12-31 00:00:00
672	672	1	2300.00	9999-12-31 00:00:00
673	673	1	6320.00	9999-12-31 00:00:00
674	674	1	1180.00	9999-12-31 00:00:00
675	675	1	2360.00	9999-12-31 00:00:00
676	676	1	6380.00	9999-12-31 00:00:00
677	677	1	5200.00	9999-12-31 00:00:00
678	678	1	1120.00	9999-12-31 00:00:00
679	679	1	2240.00	9999-12-31 00:00:00
680	680	1	2300.00	9999-12-31 00:00:00
681	681	1	6320.00	9999-12-31 00:00:00
682	682	1	1180.00	9999-12-31 00:00:00
683	683	1	2360.00	9999-12-31 00:00:00
684	684	1	6380.00	9999-12-31 00:00:00
685	685	1	5200.00	9999-12-31 00:00:00
686	686	1	1120.00	9999-12-31 00:00:00
687	687	1	2240.00	9999-12-31 00:00:00
688	688	1	2300.00	9999-12-31 00:00:00
689	689	1	6320.00	9999-12-31 00:00:00
690	690	1	1180.00	9999-12-31 00:00:00
691	691	1	2360.00	9999-12-31 00:00:00
692	692	1	6380.00	9999-12-31 00:00:00
693	693	1	5200.00	9999-12-31 00:00:00
694	694	1	5600.00	9999-12-31 00:00:00
695	695	1	4000.00	9999-12-31 00:00:00
696	696	1	4000.00	9999-12-31 00:00:00
697	697	1	4000.00	9999-12-31 00:00:00
698	698	1	4000.00	9999-12-31 00:00:00
699	699	1	4000.00	9999-12-31 00:00:00
700	700	1	4000.00	9999-12-31 00:00:00
701	701	1	3400.00	9999-12-31 00:00:00
702	702	1	3400.00	9999-12-31 00:00:00
703	703	1	3400.00	9999-12-31 00:00:00
704	704	1	3400.00	9999-12-31 00:00:00
705	705	1	3400.00	9999-12-31 00:00:00
706	706	1	3400.00	9999-12-31 00:00:00
707	707	1	3400.00	9999-12-31 00:00:00
708	708	1	3400.00	9999-12-31 00:00:00
709	709	1	3000.00	9999-12-31 00:00:00
710	710	1	3000.00	9999-12-31 00:00:00
711	711	1	3000.00	9999-12-31 00:00:00
712	712	1	3400.00	9999-12-31 00:00:00
713	713	1	3400.00	9999-12-31 00:00:00
714	714	1	3000.00	9999-12-31 00:00:00
715	715	1	3000.00	9999-12-31 00:00:00
716	716	1	3000.00	9999-12-31 00:00:00
717	717	1	3000.00	9999-12-31 00:00:00
718	718	1	2700.00	9999-12-31 00:00:00
719	719	1	2700.00	9999-12-31 00:00:00
720	720	1	2700.00	9999-12-31 00:00:00
731	731	1	2700.00	9999-12-31 00:00:00
732	732	1	2700.00	9999-12-31 00:00:00
733	733	1	1700.00	9999-12-31 00:00:00
734	734	1	1700.00	9999-12-31 00:00:00
735	735	1	1700.00	9999-12-31 00:00:00
736	736	1	1700.00	9999-12-31 00:00:00
737	737	1	1700.00	9999-12-31 00:00:00
738	738	1	1700.00	9999-12-31 00:00:00
739	739	1	1700.00	9999-12-31 00:00:00
740	740	1	4700.00	9999-12-31 00:00:00
326	326	1	3500.00	9999-12-31 00:00:00
1003	1047	1	1940.00	9999-12-31 00:00:00
1004	1048	1	1590.00	9999-12-31 00:00:00
1007	1051	1	1590.00	9999-12-31 00:00:00
1009	1053	1	1590.00	9999-12-31 00:00:00
1008	1052	1	1590.00	9999-12-31 00:00:00
1005	1049	1	1590.00	9999-12-31 00:00:00
1006	1050	1	1590.00	9999-12-31 00:00:00
1010	1054	1	1390.00	9999-12-31 00:00:00
1011	1055	1	1390.00	9999-12-31 00:00:00
1012	1056	1	1390.00	9999-12-31 00:00:00
1013	1057	1	1390.00	9999-12-31 00:00:00
1014	1058	1	1390.00	9999-12-31 00:00:00
1015	1059	1	1390.00	9999-12-31 00:00:00
1016	1060	1	1390.00	9999-12-31 00:00:00
1017	1061	1	1390.00	9999-12-31 00:00:00
1018	1062	1	1290.00	9999-12-31 00:00:00
1019	1063	1	1290.00	9999-12-31 00:00:00
1020	1064	1	1290.00	9999-12-31 00:00:00
1021	1065	1	1390.00	9999-12-31 00:00:00
1022	1066	1	1390.00	9999-12-31 00:00:00
1023	1067	1	1290.00	9999-12-31 00:00:00
1024	1068	1	1290.00	9999-12-31 00:00:00
1025	1069	1	1290.00	9999-12-31 00:00:00
1026	1070	1	1290.00	9999-12-31 00:00:00
1027	1071	1	1240.00	9999-12-31 00:00:00
1028	1072	1	1240.00	9999-12-31 00:00:00
1029	1073	1	1240.00	9999-12-31 00:00:00
1030	1074	1	1240.00	9999-12-31 00:00:00
1031	1075	1	1240.00	9999-12-31 00:00:00
1032	1076	1	1240.00	9999-12-31 00:00:00
1033	1077	1	1240.00	9999-12-31 00:00:00
1034	1078	1	1240.00	9999-12-31 00:00:00
1035	1079	1	1240.00	9999-12-31 00:00:00
1036	1080	1	1240.00	9999-12-31 00:00:00
1037	1081	1	1240.00	9999-12-31 00:00:00
1038	1082	1	1290.00	9999-12-31 00:00:00
1039	1083	1	1290.00	9999-12-31 00:00:00
1040	1084	1	1290.00	9999-12-31 00:00:00
1041	1085	1	1290.00	9999-12-31 00:00:00
1042	1086	1	1240.00	9999-12-31 00:00:00
1043	1087	1	1240.00	9999-12-31 00:00:00
1044	1088	1	1240.00	9999-12-31 00:00:00
1045	1089	1	1240.00	9999-12-31 00:00:00
1046	1090	1	1240.00	9999-12-31 00:00:00
1047	1091	1	1240.00	9999-12-31 00:00:00
1048	1092	1	1240.00	9999-12-31 00:00:00
\.


--
-- Name: shipping_fee_history_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('shipping_fee_history_seq', 1048, true);


--
-- Name: shipping_fee_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('shipping_fee_seq', 1092, true);


--
-- Data for Name: shopping_cart_item; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY shopping_cart_item (shopping_cart_item_id, store_user_id, seq, site_id, item_id, quantity) FROM stdin;
1215	1000	1	2	42	1
1216	1000	2	2	100	1
1218	1000	3	2	1053	1
\.


--
-- Name: shopping_cart_item_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('shopping_cart_item_seq', 1218, true);


--
-- Data for Name: shopping_cart_shipping; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY shopping_cart_shipping (shopping_cart_shipping_id, store_user_id, site_id, shipping_date) FROM stdin;
1009	1000	1	2014-04-14 00:00:00
1010	1008	2	2014-04-21 00:00:00
1011	1003	2	2014-04-23 00:00:00
1012	1000	1000	2014-05-31 00:00:00
1008	1000	2	2014-07-20 00:00:00
\.


--
-- Name: shopping_cart_shipping_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('shopping_cart_shipping_seq', 1012, true);


--
-- Data for Name: site; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY site (site_id, locale_id, site_name, deleted) FROM stdin;
1	1	クロスプランツ	f
2	1	８つの季節	f
1000	1	花の大和	f
\.


--
-- Data for Name: site_category; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY site_category (category_id, site_id) FROM stdin;
1	1
1	2
\.


--
-- Data for Name: site_item; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY site_item (item_id, site_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
11	1
12	1
13	1
14	1
15	1
16	1
17	1
18	1
19	1
20	1
21	1
22	1
23	1
24	1
25	1
26	1
27	1
28	1
29	1
30	1
31	1
32	1
33	1
34	1
35	1
36	1
37	1
38	1
39	2
40	2
41	2
42	2
43	2
44	2
45	2
46	2
47	2
48	2
49	2
50	2
51	2
52	2
53	2
54	2
55	2
56	2
57	2
58	2
59	2
60	2
61	2
62	2
63	2
64	2
65	2
66	2
67	2
68	2
69	2
70	2
71	2
72	2
73	2
74	2
75	2
76	2
77	2
78	2
79	2
80	2
81	2
82	2
83	2
84	2
85	2
86	2
87	2
88	2
89	2
90	2
91	2
92	2
93	2
94	2
95	2
96	2
97	2
98	2
99	2
100	2
101	2
102	2
103	2
104	2
105	2
106	2
107	2
108	2
109	2
110	2
111	2
112	2
113	2
114	2
115	2
117	2
118	2
119	2
120	2
121	2
122	2
123	2
124	2
125	2
126	2
127	2
128	2
129	2
130	2
131	2
132	2
133	2
134	2
135	2
136	2
137	2
138	2
139	2
140	2
141	2
142	2
143	2
144	2
145	2
146	2
147	2
148	2
149	2
150	2
151	2
152	2
153	2
154	2
155	2
156	2
157	2
158	2
159	2
160	2
161	2
162	2
163	2
164	2
165	2
166	2
167	2
168	2
169	2
170	2
171	2
172	2
173	2
174	2
175	2
176	2
177	2
178	2
179	2
180	2
181	2
182	2
183	2
184	2
185	2
186	2
187	2
188	2
189	2
190	2
191	2
192	2
193	2
194	2
195	2
196	2
197	2
198	2
199	2
200	2
201	2
202	2
203	2
204	2
205	2
206	2
207	2
208	2
209	2
210	2
211	2
212	2
213	2
214	2
215	2
216	2
217	2
218	2
219	2
220	2
221	2
222	2
223	2
224	2
225	2
226	2
227	2
228	2
229	2
230	2
231	2
232	2
233	2
234	2
235	2
236	2
237	2
238	2
239	2
240	2
241	2
242	2
243	2
244	2
245	2
246	2
247	2
248	2
249	2
250	2
251	2
252	2
253	2
254	2
255	2
256	2
257	2
258	2
259	2
260	2
261	2
262	2
263	2
264	2
265	2
266	2
267	2
268	2
269	2
270	2
271	2
272	2
273	2
274	2
275	2
276	2
277	2
278	2
279	2
280	2
281	2
282	2
283	2
284	2
285	2
286	2
287	2
288	2
289	2
290	2
291	2
292	2
293	2
294	2
295	2
296	2
297	2
298	2
299	2
300	2
301	2
302	2
303	2
304	2
305	2
306	2
307	2
308	2
309	2
310	2
311	2
1000	2
1001	2
1002	2
1003	2
1004	2
1005	2
1006	2
1007	2
1008	2
1009	2
1010	2
1011	2
1012	2
1013	2
1014	2
1015	2
1016	2
1017	2
1018	2
1019	2
1020	2
1021	2
1022	2
1023	2
1024	2
1025	2
1026	2
1027	2
1028	2
1029	2
1030	2
1031	2
1032	2
1033	2
1034	2
1035	2
1036	2
1037	2
1038	2
1039	2
1040	2
1041	2
1042	2
1043	2
1044	2
1045	2
1046	2
1047	2
1048	2
1049	2
1050	2
1051	2
1052	2
1053	2
1055	2
1056	2
1057	1
1058	1
1060	1
1059	1
1061	1000
1064	1000
1065	1000
1062	1000
1063	1000
1066	1000
1067	1000
1054	1
\.


--
-- Data for Name: site_item_numeric_metadata; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY site_item_numeric_metadata (site_item_numeric_metadata_id, site_id, item_id, metadata_type, metadata) FROM stdin;
1	1	1	0	3
2	1	2	0	5
3	1	3	0	5
4	1	4	0	5
5	1	5	0	5
6	1	6	0	10
7	1	7	0	10
8	1	8	0	8
9	1	9	0	8
10	1	10	0	6
11	1	11	0	3
12	1	12	0	3
13	1	13	0	6
14	1	14	0	5
16	1	16	0	6
17	1	17	0	10
18	1	18	0	10
19	1	19	0	10
20	1	20	0	5
21	1	21	0	5
22	1	22	0	5
23	1	23	0	10
24	1	24	0	15
25	1	25	0	20
26	1	26	0	20
27	1	27	0	30
28	1	28	0	10
29	1	29	0	30
30	1	30	0	4
31	1	31	0	5
32	1	32	0	10
33	1	33	0	10
34	1	34	0	20
35	1	35	0	15
36	1	36	0	5
37	1	37	0	5
38	1	38	0	5
39	1	1	1	2
40	1	2	1	2
41	1	3	1	2
42	1	4	1	2
43	1	5	1	2
44	1	6	1	2
45	1	7	1	2
46	1	8	1	2
47	1	9	1	2
48	1	10	1	2
49	1	11	1	2
50	1	12	1	2
51	1	13	1	2
52	1	14	1	2
54	1	16	1	2
55	1	17	1	2
56	1	18	1	2
57	1	19	1	2
58	1	20	1	2
59	1	21	1	2
60	1	22	1	2
61	1	23	1	2
62	1	24	1	2
63	1	25	1	2
64	1	26	1	2
65	1	27	1	2
66	1	28	1	2
67	1	29	1	2
68	1	30	1	2
69	1	31	1	2
70	1	32	1	2
71	1	33	1	2
72	1	34	1	2
73	1	35	1	2
74	1	36	1	2
75	1	37	1	2
76	1	38	1	2
77	2	39	1	2
78	2	40	1	2
79	2	41	1	2
80	2	42	1	2
81	2	43	1	2
82	2	44	1	2
83	2	45	1	2
84	2	46	1	2
85	2	47	1	2
86	2	48	1	2
87	2	49	1	2
88	2	50	1	2
89	2	51	1	2
90	2	52	1	2
91	2	53	1	2
92	2	54	1	2
93	2	55	1	2
94	2	56	1	2
95	2	57	1	2
96	2	58	1	2
97	2	59	1	2
98	2	60	1	2
99	2	61	1	2
100	2	62	1	2
101	2	63	1	2
102	2	64	1	2
103	2	65	1	2
104	2	66	1	2
105	2	67	1	2
106	2	68	1	2
107	2	69	1	2
108	2	70	1	2
109	2	71	1	2
110	2	72	1	2
111	2	73	1	2
112	2	74	1	2
113	2	75	1	2
114	2	76	1	2
115	2	77	1	2
116	2	78	1	2
117	2	79	1	2
118	2	80	1	2
119	2	81	1	2
120	2	82	1	2
53	1	15	1	2
121	2	83	1	2
122	2	84	1	2
123	2	85	1	2
124	2	86	1	2
125	2	87	1	2
126	2	88	1	2
127	2	89	1	2
128	2	90	1	2
129	2	91	1	2
130	2	92	1	2
131	2	93	1	2
132	2	94	1	2
133	2	95	1	2
134	2	96	1	2
135	2	97	1	2
136	2	98	1	2
137	2	99	1	2
138	2	100	1	2
139	2	101	1	2
140	2	102	1	2
141	2	103	1	2
142	2	104	1	2
143	2	105	1	2
144	2	106	1	2
145	2	107	1	2
146	2	108	1	2
147	2	109	1	2
148	2	110	1	2
149	2	111	1	2
150	2	112	1	2
151	2	113	1	2
152	2	114	1	2
153	2	115	1	2
154	2	116	1	2
155	2	117	1	2
156	2	118	1	2
157	2	119	1	2
158	2	120	1	2
159	2	121	1	2
160	2	122	1	2
161	2	123	1	2
162	2	124	1	2
163	2	125	1	2
164	2	126	1	2
165	2	127	1	2
166	2	128	1	2
167	2	129	1	2
168	2	130	1	2
169	2	131	1	2
170	2	132	1	2
171	2	133	1	2
172	2	134	1	2
173	2	135	1	2
174	2	136	1	2
175	2	137	1	2
176	2	138	1	2
177	2	139	1	2
178	2	140	1	2
179	2	141	1	2
180	2	142	1	2
181	2	143	1	2
182	2	144	1	2
183	2	145	1	2
184	2	146	1	2
185	2	147	1	2
186	2	148	1	2
187	2	149	1	2
188	2	150	1	2
189	2	151	1	2
190	2	152	1	2
191	2	153	1	2
192	2	154	1	2
193	2	155	1	2
194	2	156	1	2
195	2	157	1	2
196	2	158	1	2
197	2	159	1	2
198	2	160	1	2
199	2	161	1	2
200	2	162	1	2
201	2	163	1	2
202	2	164	1	2
203	2	165	1	2
204	2	166	1	2
205	2	167	1	2
206	2	168	1	2
207	2	169	1	2
208	2	170	1	2
209	2	171	1	2
210	2	172	1	2
211	2	173	1	2
212	2	174	1	2
213	2	175	1	2
214	2	176	1	2
215	2	177	1	2
216	2	178	1	2
217	2	179	1	2
218	2	180	1	2
219	2	181	1	2
220	2	182	1	2
221	2	183	1	2
222	2	184	1	2
223	2	185	1	2
224	2	186	1	2
225	2	187	1	2
226	2	188	1	2
227	2	189	1	2
228	2	190	1	2
229	2	191	1	2
230	2	192	1	2
231	2	193	1	2
232	2	194	1	2
233	2	195	1	2
234	2	196	1	2
235	2	197	1	2
236	2	198	1	2
237	2	199	1	2
238	2	200	1	2
239	2	201	1	2
240	2	202	1	2
241	2	203	1	2
242	2	204	1	2
243	2	205	1	2
244	2	206	1	2
245	2	207	1	2
246	2	208	1	2
247	2	209	1	2
248	2	210	1	2
249	2	211	1	2
250	2	212	1	2
251	2	213	1	2
252	2	214	1	2
253	2	215	1	2
254	2	216	1	2
255	2	217	1	2
256	2	218	1	2
257	2	219	1	2
258	2	220	1	2
259	2	221	1	2
260	2	222	1	2
261	2	223	1	2
262	2	224	1	2
263	2	225	1	2
264	2	226	1	2
265	2	227	1	2
266	2	228	1	2
267	2	229	1	2
268	2	230	1	2
269	2	231	1	2
270	2	232	1	2
271	2	233	1	2
272	2	234	1	2
273	2	235	1	2
274	2	236	1	2
275	2	237	1	2
276	2	238	1	2
277	2	239	1	2
278	2	240	1	2
279	2	241	1	2
280	2	242	1	2
281	2	243	1	2
282	2	244	1	2
283	2	245	1	2
284	2	246	1	2
285	2	247	1	2
286	2	248	1	2
287	2	249	1	2
288	2	250	1	2
289	2	251	1	2
290	2	252	1	2
291	2	253	1	2
292	2	254	1	2
293	2	255	1	2
294	2	256	1	2
295	2	257	1	2
296	2	258	1	2
297	2	259	1	2
298	2	260	1	2
299	2	261	1	2
300	2	262	1	2
301	2	263	1	2
302	2	264	1	2
303	2	265	1	2
304	2	266	1	2
305	2	267	1	2
306	2	268	1	2
307	2	269	1	2
308	2	270	1	2
309	2	271	1	2
310	2	272	1	2
311	2	273	1	2
312	2	274	1	2
313	2	275	1	2
314	2	276	1	2
315	2	277	1	2
316	2	278	1	2
317	2	279	1	2
318	2	280	1	2
319	2	281	1	2
320	2	282	1	2
321	2	283	1	2
322	2	284	1	2
323	2	285	1	2
324	2	286	1	2
325	2	287	1	2
326	2	288	1	2
327	2	289	1	2
328	2	290	1	2
329	2	291	1	2
330	2	292	1	2
331	2	293	1	2
332	2	294	1	2
333	2	295	1	2
334	2	296	1	2
335	2	297	1	2
336	2	298	1	2
337	2	299	1	2
338	2	300	1	2
339	2	301	1	2
340	2	302	1	2
341	2	303	1	2
342	2	304	1	2
343	2	305	1	2
344	2	306	1	2
345	2	307	1	2
346	2	308	1	2
347	2	309	1	2
348	2	310	1	2
349	2	311	1	2
350	1	1	2	3
351	1	2	2	3
352	1	3	2	3
353	1	4	2	3
354	1	5	2	1
355	1	6	2	1
356	1	7	2	2
357	1	8	2	3
358	1	9	2	3
359	1	10	2	3
360	1	11	2	3
361	1	12	2	3
362	1	13	2	3
363	1	14	2	3
365	1	16	2	3
366	1	17	2	3
367	1	18	2	3
368	1	19	2	3
369	1	20	2	3
370	1	21	2	1
371	1	22	2	1
372	1	23	2	2
373	1	24	2	1
374	1	25	2	1
375	1	26	2	1
376	1	27	2	2
377	1	28	2	2
378	1	29	2	3
379	1	30	2	2
380	1	31	2	2
381	1	32	2	2
382	1	33	2	2
383	1	34	2	2
384	1	35	2	2
385	1	36	2	2
386	1	37	2	2
387	1	38	2	2
388	2	39	2	3
389	2	40	2	4
390	2	41	2	4
391	2	42	2	1
392	2	43	2	2
393	2	44	2	1
394	2	45	2	4
395	2	46	2	4
396	2	47	2	4
397	2	48	2	4
398	2	49	2	2
399	2	50	2	2
400	2	51	2	2
401	2	52	2	2
402	2	53	2	3
403	2	54	2	4
404	2	55	2	4
405	2	56	2	4
406	2	57	2	2
407	2	58	2	2
408	2	59	2	4
409	2	60	2	3
410	2	61	2	4
411	2	62	2	2
412	2	63	2	2
413	2	64	2	3
414	2	65	2	3
415	2	66	2	4
416	2	67	2	4
417	2	68	2	3
418	2	69	2	3
419	2	70	2	1
420	2	71	2	2
421	2	72	2	2
422	2	73	2	3
423	2	74	2	3
424	2	75	2	3
425	2	76	2	4
426	2	77	2	4
427	2	78	2	2
428	2	79	2	3
429	2	80	2	4
430	2	81	2	2
431	2	82	2	4
432	2	83	2	3
433	2	84	2	3
434	2	85	2	4
435	2	86	2	3
436	2	87	2	1
437	2	88	2	1
438	2	89	2	3
439	2	90	2	1
440	2	91	2	2
441	2	92	2	2
442	2	93	2	2
443	2	94	2	3
444	2	95	2	3
445	2	96	2	1
446	2	97	2	1
447	2	98	2	1
448	2	99	2	1
449	2	100	2	1
450	2	101	2	1
451	2	102	2	2
452	2	103	2	2
453	2	104	2	2
454	2	105	2	2
455	2	106	2	2
456	2	107	2	2
457	2	108	2	2
458	2	109	2	2
459	2	110	2	3
460	2	111	2	3
461	2	112	2	4
462	2	113	2	3
463	2	114	2	3
464	2	115	2	4
465	2	116	2	1
466	2	117	2	2
467	2	118	2	1
468	2	119	2	2
469	2	120	2	2
470	2	121	2	1
471	2	122	2	4
472	2	123	2	2
473	2	124	2	3
474	2	125	2	4
475	2	126	2	2
476	2	127	2	1
477	2	128	2	1
478	2	129	2	4
479	2	130	2	3
480	2	131	2	4
481	2	132	2	2
482	2	133	2	4
483	2	134	2	1
484	2	135	2	1
485	2	136	2	1
486	2	137	2	4
487	2	138	2	3
488	2	139	2	4
489	2	140	2	4
490	2	141	2	3
491	2	142	2	3
492	2	143	2	3
493	2	144	2	4
494	2	145	2	4
495	2	146	2	2
496	2	147	2	2
497	2	148	2	3
498	2	149	2	3
499	2	150	2	3
500	2	151	2	4
501	2	152	2	4
502	2	153	2	4
503	2	154	2	2
504	2	155	2	3
505	2	156	2	4
506	2	157	2	2
507	2	158	2	2
508	2	159	2	3
509	2	160	2	4
510	2	161	2	3
511	2	162	2	4
512	2	163	2	3
513	2	164	2	4
514	2	165	2	4
515	2	166	2	3
516	2	167	2	3
517	2	168	2	4
518	2	169	2	4
519	2	170	2	1
520	2	171	2	3
521	2	172	2	3
522	2	173	2	3
523	2	174	2	3
524	2	175	2	3
525	2	176	2	4
526	2	177	2	3
527	2	178	2	4
528	2	179	2	4
529	2	180	2	2
530	2	181	2	2
531	2	182	2	3
532	2	183	2	3
533	2	184	2	3
534	2	185	2	3
535	2	186	2	3
536	2	187	2	3
537	2	188	2	4
538	2	189	2	3
539	2	190	2	4
540	2	191	2	3
541	2	192	2	2
542	2	193	2	2
543	2	194	2	3
544	2	195	2	3
545	2	196	2	3
546	2	197	2	3
547	2	198	2	4
548	2	199	2	3
549	2	200	2	4
550	2	201	2	4
551	2	202	2	4
552	2	203	2	2
553	2	204	2	1
554	2	205	2	3
555	2	206	2	4
556	2	207	2	1
557	2	208	2	1
558	2	209	2	4
559	2	210	2	4
560	2	211	2	4
561	2	212	2	4
562	2	213	2	2
563	2	214	2	2
564	2	215	2	3
565	2	216	2	3
566	2	217	2	3
567	2	218	2	4
568	2	219	2	4
569	2	220	2	1
570	2	221	2	1
571	2	222	2	4
572	2	223	2	4
573	2	224	2	2
574	2	225	2	3
575	2	226	2	4
576	2	227	2	4
577	2	228	2	4
578	2	229	2	2
579	2	230	2	2
580	2	231	2	2
581	2	232	2	2
582	2	233	2	2
583	2	234	2	2
584	2	235	2	2
585	2	236	2	1
586	2	237	2	1
587	2	238	2	2
588	2	239	2	3
589	2	240	2	3
590	2	241	2	1
591	2	242	2	2
592	2	243	2	1
593	2	244	2	3
594	2	245	2	3
595	2	246	2	3
596	2	247	2	3
597	2	248	2	4
598	2	249	2	4
599	2	250	2	1
600	2	251	2	2
601	2	252	2	3
602	2	253	2	3
603	2	254	2	3
604	2	255	2	3
605	2	256	2	4
606	2	257	2	1
607	2	258	2	1
608	2	259	2	1
609	2	260	2	1
610	2	261	2	1
611	2	262	2	1
612	2	263	2	3
613	2	264	2	4
614	2	265	2	4
615	2	266	2	2
616	2	267	2	2
617	2	268	2	2
618	2	269	2	2
619	2	270	2	3
620	2	271	2	3
621	2	272	2	3
622	2	273	2	4
623	2	274	2	4
624	2	275	2	2
625	2	276	2	3
626	2	277	2	3
627	2	278	2	3
628	2	279	2	3
629	2	280	2	4
630	2	281	2	4
631	2	282	2	1
632	2	283	2	3
633	2	284	2	4
634	2	285	2	4
635	2	286	2	4
636	2	287	2	3
637	2	288	2	4
638	2	289	2	2
639	2	290	2	1
640	2	291	2	3
641	2	292	2	4
642	2	293	2	4
643	2	294	2	3
644	2	295	2	2
645	2	296	2	2
646	2	297	2	4
647	2	298	2	4
648	2	299	2	4
649	2	300	2	4
650	2	301	2	2
651	2	302	2	3
652	2	303	2	3
653	2	304	2	1
654	2	305	2	1
655	2	306	2	3
656	2	307	2	4
657	2	308	2	3
658	2	309	2	1
659	2	310	2	3
660	2	311	2	1
15	1	15	0	20
364	1	15	2	13
1021	2	1017	4	2
1022	2	1018	4	2
1023	2	1019	4	2
1024	2	1014	4	2
1025	2	1020	4	2
1026	2	1021	4	2
1027	2	1022	4	2
1028	2	1023	4	2
1029	2	1025	4	2
1030	2	1026	4	2
1031	2	1027	4	2
1032	2	1028	4	2
1033	2	1029	4	2
1034	2	1010	4	2
1035	2	1024	4	2
1036	2	1030	4	2
1037	2	1031	4	2
1038	2	1032	4	2
1001	2	1000	1	2
1003	2	1000	4	2
1039	2	1033	4	2
1040	2	1034	4	2
1041	2	1035	4	2
1006	2	1001	2	10
1007	2	1001	4	2
1005	2	1001	0	2
1008	2	1002	4	2
1009	2	1005	4	2
1010	2	1004	4	2
1011	2	1003	4	2
1012	2	1009	4	2
1013	2	1008	4	2
1014	2	1007	4	2
1015	2	1006	4	2
1016	2	1011	4	2
1017	2	1012	4	2
1018	2	1013	4	2
1019	2	1015	4	2
1020	2	1016	4	2
1042	2	1036	4	2
1043	2	1037	4	2
1044	2	1038	4	2
1045	2	1039	4	2
1046	2	1040	4	2
1047	2	1041	4	2
1048	2	1042	4	2
1049	2	1043	4	2
1050	2	1044	4	2
1051	2	1045	4	2
1052	2	1046	4	2
1053	2	1047	4	2
1054	2	1048	4	2
1055	2	1049	4	2
1056	2	1050	4	2
1057	2	1054	4	2
1002	2	1000	2	9
1058	2	1053	4	2
1059	2	1052	4	2
1060	2	1051	4	2
1061	2	1056	4	2
1062	2	1055	4	2
1063	1	1057	0	2
1065	1	1057	2	3
1067	1	1057	1	2
1068	1000	1066	1	2
1071	1000	1061	4	3
1072	1000	1065	4	3
1073	1000	1066	4	3
1074	1000	1064	4	3
1075	1000	1067	4	3
\.


--
-- Name: site_item_numeric_metadata_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('site_item_numeric_metadata_seq', 1075, true);


--
-- Name: site_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('site_seq', 1000, true);


--
-- Data for Name: site_user; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY site_user (site_user_id, site_id, store_user_id) FROM stdin;
1000	2	1001
1001	1	1002
1002	1	1004
1003	2	1006
1004	1	1007
1005	2	1009
1006	1	1010
1007	1000	1012
1008	1000	1013
1009	2	1014
1010	2	1015
\.


--
-- Name: site_user_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('site_user_seq', 1010, true);


--
-- Data for Name: store_user; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY store_user (store_user_id, user_name, first_name, middle_name, last_name, email, password_hash, salt, deleted, user_role, company_name) FROM stdin;
1005	myadmin	my	\N	admin	null@ruimo.com	4804543384435164967	-592794198511216473	t	0	myadmincomp
1004	crollplants8787	高野	\N	悠	crossplants@mppf.or.jp	1454057088865561936	7978646123303554535	t	1	みやざき公園協会
1006	8seasons	eight	\N	seasons	shanai@ruimo.com	-2287159503686713760	-63248470124658254	t	1	8company
1000	administrator	さいて	\N	たろう	kanri01@saite.jp	-9019381044106080221	-4429081651061672938	f	0	会社
1007	cross001	cross	\N	plants	ruimo@ruimo.com	-6247986883228333680	-3617050026657777123	t	1	crosscomp
1002	chayashi	林	\N	聡子	s_hayashi@rikcorp.jp	-5563819829025084910	-8233338806997661906	f	1	リック
1009	YLTTNKST7587	西木	\N	まゆみ	ZVE01176@nifty.ne.jp	1402614868826282050	-8622276953950761987	f	1	山崎瑞松園
1010	crossplants8787	高野	\N	悠	crossplants@mppf.or.jp	3179494663919350982	5651632047372996290	f	1	みやざき公園協会
1008	unokichi	花井	\N	卯之吉	null@ruimo.com	7989453017903440699	3662362201119096643	f	1	花井卯之吉商店
1001	8hayashi	林	\N	聡子	s_hayashi@rikcorp.jp	7450642667644903652	-4902743877631183497	f	1	リック
1011	rikadministrator	林	\N	聡子	s_hayashi@rikcorp.jp	-8943022978787299343	5166973055338190539	f	0	ユニマットリック
1012	hanatesthayashi	花の大和テスト	\N	林	s_hayashi@rikcorp.jp	-5431624342949872409	-2472646665153963734	f	1	花の大和
1003	zhayashi	林	\N	聡子	s_hayashi@rikcorp.jp	7375868957483190319	2660658856084271621	f	1	林造園
1013	test07	test_sei	\N	test_mei	moriwken@yahoo.co.jp	3096682911998255063	-4939591042239155811	f	1	test_kaisha
1014	test06	test_sei	\N	test_mei	moriwken@yahoo.co.jp	2749284677500458153	-7762071159670467372	f	1	test_kaisha
1015	test08	test	\N	08	null@ruimo.com	1748816466043127588	1432370984977167439	f	1	test08
\.


--
-- Name: store_user_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('store_user_seq', 1015, true);


--
-- Data for Name: tax; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY tax (tax_id) FROM stdin;
1
2
\.


--
-- Data for Name: tax_history; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY tax_history (tax_history_id, tax_id, tax_type, rate, valid_until) FROM stdin;
1002	1	1	8.000	9999-12-31 00:00:00
1003	2	0	8.000	9999-12-31 00:00:00
1	1	1	5.000	2014-03-28 13:30:00
2	2	0	5.000	2014-03-28 13:30:00
\.


--
-- Name: tax_history_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('tax_history_seq', 1003, true);


--
-- Data for Name: tax_name; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY tax_name (tax_name_id, tax_id, locale_id, tax_name) FROM stdin;
2	2	1	外税品
1	1	1	内税品
\.


--
-- Name: tax_name_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('tax_name_seq', 1000, false);


--
-- Name: tax_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('tax_seq', 1000, false);


--
-- Data for Name: transaction_credit_tender; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transaction_credit_tender (transaction_credit_tender_id, transaction_id, amount) FROM stdin;
\.


--
-- Name: transaction_credit_tender_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transaction_credit_tender_seq', 1000, false);


--
-- Data for Name: transaction_header; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transaction_header (transaction_id, store_user_id, transaction_time, currency_id, total_amount, tax_amount, transaction_type) FROM stdin;
1000	1000	2013-10-27 20:46:10.456	1	9450.00	450.00	0
1001	1000	2013-10-28 09:11:39.984	1	33320.00	1586.00	0
1002	1000	2013-10-28 09:19:17.408	1	73200.00	3485.00	0
1003	1002	2013-10-28 15:36:46.91	1	9400.00	447.00	0
1004	1003	2013-10-28 16:00:37.006	1	15660.00	745.00	0
1005	1000	2013-10-29 07:58:04.279	1	189830.00	9039.00	0
1006	1000	2013-10-29 19:11:48.012	1	44800.00	2133.00	0
1007	1000	2013-10-30 08:52:44.248	1	14600.00	695.00	0
1008	1000	2013-10-30 15:13:43.601	1	11550.00	550.00	0
1009	1000	2013-10-30 15:32:16.775	1	11550.00	550.00	0
1010	1000	2013-11-07 09:17:03.951	1	36180.00	1722.00	0
1011	1000	2013-11-08 20:23:39.882	1	18880.00	899.00	0
1012	1008	2013-11-17 10:30:54.97	1	25700.00	1223.00	0
1013	1000	2013-11-17 15:16:08.253	1	47380.00	2256.00	0
1014	1000	2013-11-17 15:27:07.298	1	1850.00	88.00	0
1015	1000	2013-11-17 16:42:00.358	1	38200.00	1819.00	0
1016	1000	2013-11-17 16:44:00.213	1	7300.00	347.00	0
1017	1000	2013-11-17 17:03:23.093	1	37000.00	1761.00	0
1018	1000	2013-11-17 18:18:58.006	1	7300.00	347.00	0
1019	1000	2013-11-17 18:27:50.358	1	36180.00	1722.00	0
1020	1000	2013-11-17 18:48:44.495	1	36180.00	1722.00	0
1021	1003	2013-12-06 09:56:17.004	1	14930.00	739.00	0
1022	1003	2013-12-06 09:58:38.12	1	1750.00	83.00	0
1023	1003	2013-12-06 10:16:37.352	1	7300.00	352.00	0
1024	1003	2013-12-06 10:26:27.896	1	7300.00	352.00	0
1025	1003	2013-12-06 10:42:20.71	1	7300.00	352.00	0
1026	1003	2013-12-06 10:47:52.689	1	7300.00	352.00	0
1027	1003	2013-12-06 11:03:43.224	1	7300.00	352.00	0
1028	1000	2013-12-10 08:53:25.653	1	15430.00	764.00	0
1029	1003	2013-12-17 17:39:39.236	1	3800.00	186.00	0
1030	1003	2013-12-17 19:24:37.08	1	3800.00	186.00	0
1031	1003	2014-02-18 15:50:51.196	1	289950.00	14164.00	0
1032	1008	2014-04-16 22:32:00.812	1	11550.00	914.00	0
1033	1003	2014-04-18 10:39:56.156	1	11550.00	914.00	0
\.


--
-- Name: transaction_header_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transaction_header_seq', 1033, true);


--
-- Data for Name: transaction_item; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transaction_item (transaction_item_id, transaction_site_id, item_id, item_price_history_id, quantity, amount, cost_price, tax_id) FROM stdin;
1000	1000	39	39	1	2200.00	0.00	2
1001	1001	42	42	1	300.00	0.00	2
1002	1001	39	39	2	4400.00	0.00	2
1003	1001	40	40	1	10400.00	0.00	2
1004	1002	41	41	4	42400.00	0.00	2
1005	1003	5	5	10	4200.00	0.00	2
1006	1003	16	16	1	1400.00	0.00	2
1007	1004	52	52	20	10000.00	0.00	2
1008	1004	43	43	5	2500.00	0.00	2
1009	1005	26	26	1	800.00	0.00	2
1010	1006	49	49	1	400.00	0.00	2
1011	1006	50	50	1	400.00	0.00	2
1012	1006	39	39	2	4400.00	0.00	2
1013	1006	44	44	1	200.00	0.00	2
1014	1006	43	43	1	500.00	0.00	2
1015	1006	40	40	2	20800.00	0.00	2
1016	1006	41	41	7	74200.00	0.00	2
1017	1006	42	42	2	600.00	0.00	2
1018	1007	23	23	5	2500.00	0.00	2
1019	1008	41	41	1	10600.00	0.00	2
1020	1008	39	39	1	2200.00	0.00	2
1021	1008	45	45	1	6900.00	0.00	2
1022	1009	39	39	2	4400.00	0.00	2
1023	1010	1000	1000	1	10000.00	0.00	2
1024	1011	1000	1000	1	10000.00	0.00	2
1025	1012	39	39	2	4400.00	0.00	2
1026	1012	1000	1000	2	20000.00	0.00	2
1027	1013	39	39	1	2200.00	0.00	2
1028	1013	1000	1000	1	10000.00	0.00	2
1029	1014	15	15	1	2500.00	0.00	2
1030	1015	39	39	3	6600.00	0.00	2
1031	1016	40	40	1	10400.00	0.00	2
1032	1016	39	39	1	2200.00	0.00	2
1033	1016	1000	1000	2	20000.00	0.00	2
1034	1017	42	42	1	300.00	0.00	2
1035	1018	15	15	1	2500.00	0.00	2
1036	1019	42	42	80	24000.00	0.00	2
1037	1019	39	39	1	2200.00	0.00	2
1038	1020	39	39	1	2200.00	0.00	2
1039	1021	40	40	2	20800.00	0.00	2
1040	1022	39	39	1	2200.00	0.00	2
1041	1023	39	39	2	4400.00	0.00	2
1042	1023	1000	1000	2	20000.00	0.00	2
1043	1024	39	39	2	4400.00	0.00	2
1044	1024	1000	1000	2	20000.00	0.00	2
1045	1025	42	42	9	2700.00	0.00	2
1046	1025	44	44	6	1200.00	0.00	2
1047	1025	290	290	15	3000.00	0.00	2
1048	1025	296	296	1	500.00	0.00	2
1049	1025	97	97	1	800.00	0.00	2
1050	1025	100	100	1	800.00	0.00	2
1051	1025	147	147	3	1800.00	0.00	2
1052	1025	90	90	5	1000.00	0.00	2
1053	1026	90	90	1	200.00	0.00	2
1054	1027	39	39	1	2200.00	0.00	2
1055	1028	39	39	1	2200.00	0.00	2
1056	1029	39	39	1	2200.00	0.00	2
1057	1030	39	39	1	2200.00	0.00	2
1058	1031	39	39	1	2200.00	0.00	2
1059	1032	42	42	9	2700.00	0.00	2
1060	1032	44	44	6	1200.00	0.00	2
1061	1032	290	290	15	3000.00	0.00	2
1062	1032	296	296	2	1000.00	0.00	2
1063	1032	97	97	1	800.00	0.00	2
1064	1032	100	100	1	800.00	0.00	2
1065	1032	147	147	3	1800.00	0.00	2
1066	1032	90	90	5	1000.00	0.00	2
1067	1033	15	15	1	2500.00	0.00	2
1068	1034	15	15	1	2500.00	0.00	2
1069	1035	5	5	1	420.00	0.00	2
1070	1035	16	16	1	1400.00	0.00	2
1071	1035	21	21	1	500.00	0.00	2
1072	1035	23	23	1	500.00	0.00	2
1073	1035	7	7	1	400.00	0.00	2
1074	1036	118	118	1	200.00	0.00	2
1075	1036	107	107	1	500.00	0.00	2
1076	1036	99	99	1	800.00	0.00	2
1077	1036	93	93	1	800.00	0.00	2
1078	1036	78	78	1	600.00	0.00	2
1079	1036	88	88	1	500.00	0.00	2
1080	1036	87	87	1	500.00	0.00	2
1081	1036	86	86	1	3200.00	0.00	2
1082	1036	82	82	1	7200.00	0.00	2
1083	1036	45	45	1	6900.00	0.00	2
1084	1036	51	51	1	400.00	0.00	2
1085	1036	50	50	1	400.00	0.00	2
1086	1036	54	54	1	9500.00	0.00	2
1087	1036	56	56	1	10000.00	0.00	2
1088	1036	58	58	1	500.00	0.00	2
1089	1036	60	60	1	4800.00	0.00	2
1090	1036	64	64	1	1100.00	0.00	2
1091	1036	66	66	1	6400.00	0.00	2
1092	1036	72	72	1	600.00	0.00	2
1093	1036	70	70	1	200.00	0.00	2
1094	1036	77	77	2	25400.00	0.00	2
1095	1036	74	74	1	4000.00	0.00	2
1096	1036	75	75	1	5300.00	0.00	2
1097	1036	81	81	1	600.00	0.00	2
1098	1036	79	79	1	2700.00	0.00	2
1099	1036	59	59	2	9600.00	0.00	2
1100	1036	47	47	1	9000.00	0.00	2
1101	1036	44	44	1	200.00	0.00	2
1102	1036	39	39	2	4400.00	1100.00	2
1103	1036	40	40	1	10400.00	0.00	2
1104	1036	1000	1000	2	20000.00	0.00	2
1105	1037	1000	1000	1	10000.00	0.00	2
1106	1038	1010	1010	1	10000.00	9000.00	2
\.


--
-- Name: transaction_item_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transaction_item_seq', 1106, true);


--
-- Data for Name: transaction_shipping; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transaction_shipping (transaction_shipping_id, transaction_site_id, amount, address_id, item_class, box_size, tax_id, shipping_date, box_count, box_name) FROM stdin;
1000	1000	7250.00	1000	3	1	1	2013-10-30 00:00:00	1	-
1001	1001	7700.00	1004	4	1	1	2013-10-31 00:00:00	1	-
1002	1001	9400.00	1004	3	1	1	2013-10-31 00:00:00	1	-
1003	1001	1120.00	1004	1	50	1	2013-10-31 00:00:00	1	-
1004	1002	30800.00	1004	4	1	1	2013-10-31 00:00:00	1	-
1005	1003	1900.00	1007	3	2	1	2013-10-31 00:00:00	1	-
1006	1003	1900.00	1007	1	15	1	2013-10-31 00:00:00	1	-
1007	1004	3160.00	1009	2	20	1	2013-10-31 00:00:00	1	-
1008	1005	1300.00	1006	1	15	1	2013-11-01 00:00:00	1	-
1009	1006	72900.00	1006	4	1	1	2013-11-01 00:00:00	1	-
1010	1006	10200.00	1006	3	1	1	2013-11-01 00:00:00	1	-
1011	1006	1580.00	1006	2	20	1	2013-11-01 00:00:00	1	-
1012	1006	1550.00	1006	1	50	1	2013-11-01 00:00:00	1	-
1013	1007	1300.00	1006	2	8	1	2013-11-01 00:00:00	1	-
1014	1008	16200.00	1006	4	1	1	2013-11-01 00:00:00	1	-
1015	1008	5100.00	1006	3	1	1	2013-11-01 00:00:00	1	-
1016	1009	10200.00	1006	3	1	1	2013-11-02 00:00:00	1	-
1017	1010	1550.00	1006	1	50	1	2013-11-02 00:00:00	1	-
1018	1011	1550.00	1006	1	50	1	2013-11-02 00:00:00	1	-
1019	1012	10200.00	1006	3	1	1	2013-11-12 00:00:00	1	-
1020	1012	1580.00	1006	2	20	1	2013-11-12 00:00:00	1	-
1021	1013	5100.00	1006	3	1	1	2013-11-13 00:00:00	1	-
1022	1013	1580.00	1006	2	20	1	2013-11-13 00:00:00	1	-
1023	1014	1300.00	1010	3	2	1	2013-11-22 00:00:00	1	ポット樹木（大）
1024	1015	15300.00	1010	3	1	1	2013-11-22 00:00:00	3	低木H0.6m～H1.5m以下専用
1025	1016	8100.00	1011	4	1	1	2013-11-22 00:00:00	1	その他規格外
1026	1016	5100.00	1011	3	1	1	2013-11-22 00:00:00	1	低木H0.6m～H1.5m以下専用
1027	1016	1580.00	1011	2	20	1	2013-11-22 00:00:00	1	低木H0.5m以下専用
1028	1017	1550.00	1011	1	50	1	2013-11-22 00:00:00	1	グランドカバー宿根草等専用
1029	1018	1300.00	1011	3	2	1	2013-11-22 00:00:00	1	ポット樹木（大）
1030	1019	5100.00	1011	3	1	1	2013-11-22 00:00:00	1	低木H0.6m～H1.5m以下専用
1031	1019	3100.00	1011	1	50	1	2013-11-22 00:00:00	2	グランドカバー宿根草等専用
1032	1020	5100.00	1011	3	1	1	2013-11-22 00:00:00	1	低木H0.6m～H1.5m以下専用
1033	1021	16200.00	1011	4	1	1	2013-11-22 00:00:00	2	その他規格外
1034	1022	5100.00	1011	3	1	1	2013-11-22 00:00:00	1	低木H0.6m～H1.5m以下専用
1035	1023	10200.00	1011	3	1	1	2013-11-22 00:00:00	2	低木H0.6m～H1.5m以下専用
1036	1023	1580.00	1011	2	20	1	2013-11-22 00:00:00	1	低木H0.5m以下専用
1037	1024	10200.00	1011	3	1	1	2013-11-22 00:00:00	2	低木H0.6m～H1.5m以下専用
1038	1024	1580.00	1011	2	20	1	2013-11-22 00:00:00	1	低木H0.5m以下専用
1039	1025	1580.00	1009	2	20	1	2013-12-11 00:00:00	1	低木H0.5m以下専用
1040	1025	1550.00	1009	1	50	1	2013-12-11 00:00:00	1	グランドカバー宿根草等専用
1041	1026	1550.00	1012	1	50	1	2013-12-11 00:00:00	1	グランドカバー宿根草等専用
1042	1027	5100.00	1012	3	1	1	2013-12-11 00:00:00	1	低木H0.6m～H1.5m以下専用
1043	1028	5100.00	1012	3	1	1	2013-12-11 00:00:00	1	低木H0.6m～H1.5m以下専用
1044	1029	5100.00	1012	3	1	1	2013-12-11 00:00:00	1	低木H0.6m～H1.5m以下専用
1045	1030	5100.00	1012	3	1	1	2013-12-11 00:00:00	1	低木H0.6m～H1.5m以下専用
1046	1031	5100.00	1012	3	1	1	2013-12-11 00:00:00	1	低木H0.6m～H1.5m以下専用
1047	1032	1580.00	1011	2	20	1	2013-12-15 00:00:00	1	低木H0.5m以下専用
1048	1032	1550.00	1011	1	50	1	2013-12-15 00:00:00	1	グランドカバー宿根草等専用
1049	1033	1300.00	1013	3	2	1	2013-12-22 00:00:00	1	ポット樹木（大）
1050	1034	1300.00	1014	3	2	1	2013-12-22 00:00:00	1	ポット樹木（大）
1051	1035	1300.00	1014	3	2	1	2014-02-23 00:00:00	1	ポット樹木（大）
1052	1035	1300.00	1014	2	8	1	2014-02-23 00:00:00	1	ポット樹木（小）
1053	1035	1300.00	1014	1	15	1	2014-02-23 00:00:00	1	宿根草
1054	1036	3100.00	1014	5	1	1	2014-02-23 00:00:00	2	セット送料A
1055	1036	89100.00	1014	4	1	1	2014-02-23 00:00:00	11	その他規格外
1056	1036	40800.00	1014	3	1	1	2014-02-23 00:00:00	8	低木H0.6m～H1.5m以下専用
1057	1036	1580.00	1014	2	20	1	2014-02-23 00:00:00	1	低木H0.5m以下専用
1058	1036	1550.00	1014	1	50	1	2014-02-23 00:00:00	1	グランドカバー宿根草等専用
1059	1037	1550.00	1010	5	1	1	2014-04-21 00:00:00	1	セット送料A
1060	1038	1550.00	1014	1	50	1	2014-04-23 00:00:00	1	グランドカバー宿根草等専用
\.


--
-- Name: transaction_shipping_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transaction_shipping_seq', 1060, true);


--
-- Data for Name: transaction_site; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transaction_site (transaction_site_id, transaction_id, site_id, total_amount, tax_amount) FROM stdin;
1000	1000	2	9450.00	450.00
1001	1001	2	33320.00	1586.00
1002	1002	2	73200.00	3485.00
1003	1003	1	9400.00	447.00
1004	1004	2	15660.00	745.00
1005	1005	1	2100.00	100.00
1006	1005	2	187730.00	8939.00
1007	1006	1	3800.00	180.00
1008	1006	2	41000.00	1952.00
1009	1007	2	14600.00	695.00
1010	1008	2	11550.00	550.00
1011	1009	2	11550.00	550.00
1012	1010	2	36180.00	1722.00
1013	1011	2	18880.00	899.00
1014	1012	1	3800.00	180.00
1015	1012	2	21900.00	1042.00
1016	1013	2	47380.00	2256.00
1017	1014	2	1850.00	88.00
1018	1015	1	3800.00	180.00
1019	1015	2	34400.00	1638.00
1020	1016	2	7300.00	347.00
1021	1017	2	37000.00	1761.00
1022	1018	2	7300.00	347.00
1023	1019	2	36180.00	1722.00
1024	1020	2	36180.00	1722.00
1025	1021	2	14930.00	739.00
1026	1022	2	1750.00	83.00
1027	1023	2	7300.00	352.00
1028	1024	2	7300.00	352.00
1029	1025	2	7300.00	352.00
1030	1026	2	7300.00	352.00
1031	1027	2	7300.00	352.00
1032	1028	2	15430.00	764.00
1033	1029	1	3800.00	186.00
1034	1030	1	3800.00	186.00
1035	1031	1	7120.00	346.00
1036	1031	2	282830.00	13817.00
1037	1032	2	11550.00	914.00
1038	1033	2	11550.00	914.00
\.


--
-- Name: transaction_site_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transaction_site_seq', 1038, true);


--
-- Data for Name: transaction_status; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transaction_status (transaction_status_id, transaction_site_id, status, transporter_id, slip_code, last_update, mail_sent) FROM stdin;
1002	1002	0	\N	\N	2013-12-01 21:33:34.906667	f
1003	1003	0	\N	\N	2013-12-01 21:33:34.906667	f
1004	1004	0	\N	\N	2013-12-01 21:33:34.906667	f
1005	1005	0	\N	\N	2013-12-01 21:33:34.906667	f
1006	1006	0	\N	\N	2013-12-01 21:33:34.906667	f
1000	1000	1	\N	\N	2013-12-01 21:33:34.906667	f
1001	1001	2	\N	\N	2013-12-01 21:33:34.906667	f
1007	1007	0	\N	\N	2013-12-01 21:33:34.906667	f
1008	1008	0	\N	\N	2013-12-01 21:33:34.906667	f
1010	1010	0	\N	\N	2013-12-01 21:33:34.906667	f
1011	1011	1	\N	\N	2013-12-01 21:33:34.906667	f
1009	1009	1	\N	\N	2013-12-01 21:33:34.906667	f
1014	1014	0	\N	\N	2013-12-01 21:33:34.906667	f
1015	1015	0	\N	\N	2013-12-01 21:33:34.906667	f
1016	1016	0	\N	\N	2013-12-01 21:33:34.906667	f
1017	1017	0	\N	\N	2013-12-01 21:33:34.906667	f
1019	1019	0	\N	\N	2013-12-01 21:33:34.906667	f
1020	1020	0	\N	\N	2013-12-01 21:33:34.906667	f
1021	1021	0	\N	\N	2013-12-01 21:33:34.906667	f
1022	1022	0	\N	\N	2013-12-01 21:33:34.906667	f
1024	1024	1	1000	123456	2013-12-03 09:14:16.977074	f
1023	1023	0	1000	1234567	2013-12-03 09:15:19.8502	f
1025	1025	0	\N	\N	2013-12-06 09:56:17.066	f
1026	1026	0	\N	\N	2013-12-06 09:58:38.125	f
1027	1027	0	\N	\N	2013-12-06 10:16:37.357	f
1029	1029	0	\N	\N	2013-12-06 10:42:20.714	f
1028	1028	2	\N	\N	2013-12-09 10:39:19.797095	t
1034	1034	1	1005	0000000000	2013-12-17 19:25:42.07721	t
1012	1012	1	1006	123-456-7890	2013-12-19 19:04:51.69135	t
1031	1031	2	\N	\N	2013-12-13 21:14:42.15009	t
1032	1032	2	\N	\N	2013-12-16 10:53:13.172226	t
1013	1013	1	1005	987-654-3210	2013-12-19 19:06:14.405462	t
1030	1030	1	1000	000000000	2013-12-16 13:35:28.731001	t
1033	1033	1	1005	1234567890	2013-12-17 17:40:35.406492	t
1018	1018	2	\N	\N	2013-12-17 17:45:17.728261	t
1036	1036	0	\N	\N	2014-02-18 15:50:51.459	f
1035	1035	1	1005	00000000	2014-04-03 11:36:01.695517	t
1037	1037	1	1005	000000000	2014-06-25 09:23:40.831075	t
1038	1038	1	1005	11111111	2014-06-25 09:53:34.765066	t
\.


--
-- Name: transaction_status_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transaction_status_seq', 1038, true);


--
-- Data for Name: transaction_tax; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transaction_tax (transaction_tax_id, transaction_site_id, tax_id, tax_type, rate, target_amount, amount) FROM stdin;
1000	1000	1	1	5.000	9450.00	450.00
1001	1001	1	1	5.000	33320.00	1586.00
1002	1002	1	1	5.000	73200.00	3485.00
1003	1003	1	1	5.000	9400.00	447.00
1004	1004	1	1	5.000	15660.00	745.00
1005	1005	1	1	5.000	2100.00	100.00
1006	1006	1	1	5.000	187730.00	8939.00
1007	1007	1	1	5.000	3800.00	180.00
1008	1008	1	1	5.000	41000.00	1952.00
1009	1009	1	1	5.000	14600.00	695.00
1010	1010	1	1	5.000	11550.00	550.00
1011	1011	1	1	5.000	11550.00	550.00
1012	1012	1	1	5.000	36180.00	1722.00
1013	1013	1	1	5.000	18880.00	899.00
1014	1014	1	1	5.000	3800.00	180.00
1015	1015	1	1	5.000	21900.00	1042.00
1016	1016	1	1	5.000	47380.00	2256.00
1017	1017	1	1	5.000	1850.00	88.00
1018	1018	1	1	5.000	3800.00	180.00
1019	1019	1	1	5.000	34400.00	1638.00
1020	1020	1	1	5.000	7300.00	347.00
1021	1021	1	1	5.000	37000.00	1761.00
1022	1022	1	1	5.000	7300.00	347.00
1023	1023	1	1	5.000	36180.00	1722.00
1024	1024	1	1	5.000	36180.00	1722.00
1025	1025	1	1	5.000	3130.00	149.00
1026	1025	2	0	5.000	11800.00	590.00
1027	1026	1	1	5.000	1550.00	73.00
1028	1026	2	0	5.000	200.00	10.00
1029	1027	1	1	5.000	5100.00	242.00
1030	1027	2	0	5.000	2200.00	110.00
1031	1028	1	1	5.000	5100.00	242.00
1032	1028	2	0	5.000	2200.00	110.00
1033	1029	1	1	5.000	5100.00	242.00
1034	1029	2	0	5.000	2200.00	110.00
1035	1030	1	1	5.000	5100.00	242.00
1036	1030	2	0	5.000	2200.00	110.00
1037	1031	1	1	5.000	5100.00	242.00
1038	1031	2	0	5.000	2200.00	110.00
1039	1032	1	1	5.000	3130.00	149.00
1040	1032	2	0	5.000	12300.00	615.00
1041	1033	1	1	5.000	1300.00	61.00
1042	1033	2	0	5.000	2500.00	125.00
1043	1034	1	1	5.000	1300.00	61.00
1044	1034	2	0	5.000	2500.00	125.00
1045	1035	1	1	5.000	3900.00	185.00
1046	1035	2	0	5.000	3220.00	161.00
1047	1036	1	1	5.000	136130.00	6482.00
1048	1036	2	0	5.000	146700.00	7335.00
1049	1037	1	1	8.000	1550.00	114.00
1050	1037	2	0	8.000	10000.00	800.00
1051	1038	1	1	8.000	1550.00	114.00
1052	1038	2	0	8.000	10000.00	800.00
\.


--
-- Name: transaction_tax_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transaction_tax_seq', 1052, true);


--
-- Data for Name: transporter; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transporter (transporter_id) FROM stdin;
1000
1004
1005
1006
\.


--
-- Data for Name: transporter_name; Type: TABLE DATA; Schema: public; Owner: store_user
--

COPY transporter_name (transporter_name_id, locale_id, transporter_id, transporter_name) FROM stdin;
1005	1	1005	ヤマト運輸
1006	1	1006	佐川急便
\.


--
-- Name: transporter_name_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transporter_name_seq', 1006, true);


--
-- Name: transporter_seq; Type: SEQUENCE SET; Schema: public; Owner: store_user
--

SELECT pg_catalog.setval('transporter_seq', 1006, true);


--
-- Name: category_path_pkey; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY category_path
    ADD CONSTRAINT category_path_pkey PRIMARY KEY (ancestor, descendant);


--
-- Name: item_description_locale_id_item_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_description
    ADD CONSTRAINT item_description_locale_id_item_id_site_id_key UNIQUE (locale_id, item_id, site_id);


--
-- Name: item_name_locale_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_name
    ADD CONSTRAINT item_name_locale_id_item_id_key UNIQUE (locale_id, item_id);


--
-- Name: item_numeric_metadata_item_id_metadata_type_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_numeric_metadata
    ADD CONSTRAINT item_numeric_metadata_item_id_metadata_type_key UNIQUE (item_id, metadata_type);


--
-- Name: item_price_history_item_price_id_valid_until_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_price_history
    ADD CONSTRAINT item_price_history_item_price_id_valid_until_key UNIQUE (item_price_id, valid_until);


--
-- Name: item_price_site_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_price
    ADD CONSTRAINT item_price_site_id_item_id_key UNIQUE (site_id, item_id);


--
-- Name: item_text_metadata_item_id_metadata_type_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_text_metadata
    ADD CONSTRAINT item_text_metadata_item_id_metadata_type_key UNIQUE (item_id, metadata_type);


--
-- Name: locale_lang_country_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY locale
    ADD CONSTRAINT locale_lang_country_key UNIQUE (lang, country);


--
-- Name: order_notification_store_user_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY order_notification
    ADD CONSTRAINT order_notification_store_user_id_key UNIQUE (store_user_id);


--
-- Name: pk_address; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY address
    ADD CONSTRAINT pk_address PRIMARY KEY (address_id);


--
-- Name: pk_category; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT pk_category PRIMARY KEY (category_id);


--
-- Name: pk_category_name; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY category_name
    ADD CONSTRAINT pk_category_name PRIMARY KEY (locale_id, category_id);


--
-- Name: pk_currency; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY currency
    ADD CONSTRAINT pk_currency PRIMARY KEY (currency_id);


--
-- Name: pk_item; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item
    ADD CONSTRAINT pk_item PRIMARY KEY (item_id);


--
-- Name: pk_item_description; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_description
    ADD CONSTRAINT pk_item_description PRIMARY KEY (item_description_id);


--
-- Name: pk_item_name; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_name
    ADD CONSTRAINT pk_item_name PRIMARY KEY (item_name_id);


--
-- Name: pk_item_numeric_metadata; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_numeric_metadata
    ADD CONSTRAINT pk_item_numeric_metadata PRIMARY KEY (item_numeric_metadata_id);


--
-- Name: pk_item_price; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_price
    ADD CONSTRAINT pk_item_price PRIMARY KEY (item_price_id);


--
-- Name: pk_item_price_history; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_price_history
    ADD CONSTRAINT pk_item_price_history PRIMARY KEY (item_price_history_id);


--
-- Name: pk_item_text_metadata; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY item_text_metadata
    ADD CONSTRAINT pk_item_text_metadata PRIMARY KEY (item_text_metadata_id);


--
-- Name: pk_locale; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY locale
    ADD CONSTRAINT pk_locale PRIMARY KEY (locale_id);


--
-- Name: pk_order_notification; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY order_notification
    ADD CONSTRAINT pk_order_notification PRIMARY KEY (order_notification_id);


--
-- Name: pk_shipping_address_history; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_address_history
    ADD CONSTRAINT pk_shipping_address_history PRIMARY KEY (shipping_address_history_id);


--
-- Name: pk_shipping_box; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_box
    ADD CONSTRAINT pk_shipping_box PRIMARY KEY (shipping_box_id);


--
-- Name: pk_shipping_fee; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_fee
    ADD CONSTRAINT pk_shipping_fee PRIMARY KEY (shipping_fee_id);


--
-- Name: pk_shipping_fee_history; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_fee_history
    ADD CONSTRAINT pk_shipping_fee_history PRIMARY KEY (shipping_fee_history_id);


--
-- Name: pk_shopping_cart_item; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shopping_cart_item
    ADD CONSTRAINT pk_shopping_cart_item PRIMARY KEY (shopping_cart_item_id);


--
-- Name: pk_shopping_cart_shipping; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shopping_cart_shipping
    ADD CONSTRAINT pk_shopping_cart_shipping PRIMARY KEY (shopping_cart_shipping_id);


--
-- Name: pk_site; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site
    ADD CONSTRAINT pk_site PRIMARY KEY (site_id);


--
-- Name: pk_site_category; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site_category
    ADD CONSTRAINT pk_site_category PRIMARY KEY (category_id, site_id);


--
-- Name: pk_site_item; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site_item
    ADD CONSTRAINT pk_site_item PRIMARY KEY (item_id, site_id);


--
-- Name: pk_site_item_numeric_metadata; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site_item_numeric_metadata
    ADD CONSTRAINT pk_site_item_numeric_metadata PRIMARY KEY (site_item_numeric_metadata_id);


--
-- Name: pk_site_user; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site_user
    ADD CONSTRAINT pk_site_user PRIMARY KEY (site_user_id);


--
-- Name: pk_tax; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY tax
    ADD CONSTRAINT pk_tax PRIMARY KEY (tax_id);


--
-- Name: pk_tax_history; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY tax_history
    ADD CONSTRAINT pk_tax_history PRIMARY KEY (tax_history_id);


--
-- Name: pk_tax_name; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY tax_name
    ADD CONSTRAINT pk_tax_name PRIMARY KEY (tax_name_id);


--
-- Name: pk_transaction; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_header
    ADD CONSTRAINT pk_transaction PRIMARY KEY (transaction_id);


--
-- Name: pk_transaction_credit_tender; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_credit_tender
    ADD CONSTRAINT pk_transaction_credit_tender PRIMARY KEY (transaction_credit_tender_id);


--
-- Name: pk_transaction_item; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_item
    ADD CONSTRAINT pk_transaction_item PRIMARY KEY (transaction_item_id);


--
-- Name: pk_transaction_shipping; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_shipping
    ADD CONSTRAINT pk_transaction_shipping PRIMARY KEY (transaction_shipping_id);


--
-- Name: pk_transaction_site; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_site
    ADD CONSTRAINT pk_transaction_site PRIMARY KEY (transaction_site_id);


--
-- Name: pk_transaction_status; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_status
    ADD CONSTRAINT pk_transaction_status PRIMARY KEY (transaction_status_id);


--
-- Name: pk_transaction_tax; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_tax
    ADD CONSTRAINT pk_transaction_tax PRIMARY KEY (transaction_tax_id);


--
-- Name: pk_transporter; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transporter
    ADD CONSTRAINT pk_transporter PRIMARY KEY (transporter_id);


--
-- Name: pk_transporter_name; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transporter_name
    ADD CONSTRAINT pk_transporter_name PRIMARY KEY (transporter_name_id);


--
-- Name: pk_user; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY store_user
    ADD CONSTRAINT pk_user PRIMARY KEY (store_user_id);


--
-- Name: play_evolutions_pkey; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY play_evolutions
    ADD CONSTRAINT play_evolutions_pkey PRIMARY KEY (id);


--
-- Name: shipping_address_history_store_user_id_address_id_updated_t_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_address_history
    ADD CONSTRAINT shipping_address_history_store_user_id_address_id_updated_t_key UNIQUE (store_user_id, address_id, updated_time);


--
-- Name: shipping_box_site_id_item_class_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_box
    ADD CONSTRAINT shipping_box_site_id_item_class_key UNIQUE (site_id, item_class);


--
-- Name: shipping_fee_constraint1; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_fee
    ADD CONSTRAINT shipping_fee_constraint1 UNIQUE (shipping_box_id, country_code, location_code);


--
-- Name: shipping_fee_history_shipping_fee_id_valid_until_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shipping_fee_history
    ADD CONSTRAINT shipping_fee_history_shipping_fee_id_valid_until_key UNIQUE (shipping_fee_id, valid_until);


--
-- Name: shopping_cart_item_store_user_id_seq_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shopping_cart_item
    ADD CONSTRAINT shopping_cart_item_store_user_id_seq_key UNIQUE (store_user_id, seq);


--
-- Name: shopping_cart_shipping_store_user_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY shopping_cart_shipping
    ADD CONSTRAINT shopping_cart_shipping_store_user_id_site_id_key UNIQUE (store_user_id, site_id);


--
-- Name: site_item_numeric_metadata_site_id_item_id_metadata_type_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site_item_numeric_metadata
    ADD CONSTRAINT site_item_numeric_metadata_site_id_item_id_metadata_type_key UNIQUE (site_id, item_id, metadata_type);


--
-- Name: site_site_name_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site
    ADD CONSTRAINT site_site_name_key UNIQUE (site_name);


--
-- Name: site_user_site_id_store_user_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY site_user
    ADD CONSTRAINT site_user_site_id_store_user_id_key UNIQUE (site_id, store_user_id);


--
-- Name: store_user_user_name_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY store_user
    ADD CONSTRAINT store_user_user_name_key UNIQUE (user_name);


--
-- Name: tax_history_tax_id_valid_until_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY tax_history
    ADD CONSTRAINT tax_history_tax_id_valid_until_key UNIQUE (tax_id, valid_until);


--
-- Name: tax_name_tax_id_locale_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY tax_name
    ADD CONSTRAINT tax_name_tax_id_locale_id_key UNIQUE (tax_id, locale_id);


--
-- Name: transaction_site_transaction_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_site
    ADD CONSTRAINT transaction_site_transaction_id_site_id_key UNIQUE (transaction_id, site_id);


--
-- Name: transaction_status_transaction_site_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transaction_status
    ADD CONSTRAINT transaction_status_transaction_site_id_key UNIQUE (transaction_site_id);


--
-- Name: transporter_name_locale_id_transporter_id_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transporter_name
    ADD CONSTRAINT transporter_name_locale_id_transporter_id_key UNIQUE (locale_id, transporter_id);


--
-- Name: transporter_name_transporter_name_key; Type: CONSTRAINT; Schema: public; Owner: store_user; Tablespace: 
--

ALTER TABLE ONLY transporter_name
    ADD CONSTRAINT transporter_name_transporter_name_key UNIQUE (transporter_name);


--
-- Name: item_description_gin_idx; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX item_description_gin_idx ON item_description USING gin (description gin_trgm_ops);


--
-- Name: item_name_gin_idx; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX item_name_gin_idx ON item_name USING gin (item_name gin_trgm_ops);


--
-- Name: ix_category_name1; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_category_name1 ON category_name USING btree (category_id);


--
-- Name: ix_category_path1; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_category_path1 ON category_path USING btree (ancestor);


--
-- Name: ix_category_path2; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_category_path2 ON category_path USING btree (descendant);


--
-- Name: ix_category_path3; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_category_path3 ON category_path USING btree (path_length);


--
-- Name: ix_item_description1; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_item_description1 ON item_description USING btree (item_id);


--
-- Name: ix_item_name1; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_item_name1 ON item_name USING btree (item_id);


--
-- Name: ix_shipping_fee_history1; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_shipping_fee_history1 ON shipping_fee_history USING btree (shipping_fee_id);


--
-- Name: ix_shopping_cart_item1; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_shopping_cart_item1 ON shopping_cart_item USING btree (item_id);


--
-- Name: ix_tax_history1; Type: INDEX; Schema: public; Owner: store_user; Tablespace: 
--

CREATE INDEX ix_tax_history1 ON tax_history USING btree (valid_until);


--
-- Name: category_name_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY category_name
    ADD CONSTRAINT category_name_category_id_fkey FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE;


--
-- Name: category_name_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY category_name
    ADD CONSTRAINT category_name_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES locale(locale_id);


--
-- Name: category_path_ancestor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY category_path
    ADD CONSTRAINT category_path_ancestor_fkey FOREIGN KEY (ancestor) REFERENCES category(category_id) ON DELETE CASCADE;


--
-- Name: category_path_descendant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY category_path
    ADD CONSTRAINT category_path_descendant_fkey FOREIGN KEY (descendant) REFERENCES category(category_id) ON DELETE CASCADE;


--
-- Name: item_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_category_id_fkey FOREIGN KEY (category_id) REFERENCES category(category_id);


--
-- Name: item_description_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_description
    ADD CONSTRAINT item_description_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;


--
-- Name: item_description_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_description
    ADD CONSTRAINT item_description_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES locale(locale_id);


--
-- Name: item_description_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_description
    ADD CONSTRAINT item_description_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: item_name_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_name
    ADD CONSTRAINT item_name_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;


--
-- Name: item_name_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_name
    ADD CONSTRAINT item_name_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES locale(locale_id);


--
-- Name: item_numeric_metadata_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_numeric_metadata
    ADD CONSTRAINT item_numeric_metadata_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: item_price_history_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_price_history
    ADD CONSTRAINT item_price_history_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES currency(currency_id) ON DELETE CASCADE;


--
-- Name: item_price_history_item_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_price_history
    ADD CONSTRAINT item_price_history_item_price_id_fkey FOREIGN KEY (item_price_id) REFERENCES item_price(item_price_id) ON DELETE CASCADE;


--
-- Name: item_price_history_tax_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_price_history
    ADD CONSTRAINT item_price_history_tax_id_fkey FOREIGN KEY (tax_id) REFERENCES tax(tax_id) ON DELETE CASCADE;


--
-- Name: item_price_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_price
    ADD CONSTRAINT item_price_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;


--
-- Name: item_price_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_price
    ADD CONSTRAINT item_price_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: item_text_metadata_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY item_text_metadata
    ADD CONSTRAINT item_text_metadata_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: order_notification_store_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY order_notification
    ADD CONSTRAINT order_notification_store_user_id_fkey FOREIGN KEY (store_user_id) REFERENCES store_user(store_user_id);


--
-- Name: shipping_address_history_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shipping_address_history
    ADD CONSTRAINT shipping_address_history_address_id_fkey FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;


--
-- Name: shipping_address_history_store_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shipping_address_history
    ADD CONSTRAINT shipping_address_history_store_user_id_fkey FOREIGN KEY (store_user_id) REFERENCES store_user(store_user_id) ON DELETE CASCADE;


--
-- Name: shipping_box_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shipping_box
    ADD CONSTRAINT shipping_box_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: shipping_fee_history_shipping_fee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shipping_fee_history
    ADD CONSTRAINT shipping_fee_history_shipping_fee_id_fkey FOREIGN KEY (shipping_fee_id) REFERENCES shipping_fee(shipping_fee_id) ON DELETE CASCADE;


--
-- Name: shipping_fee_history_tax_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shipping_fee_history
    ADD CONSTRAINT shipping_fee_history_tax_id_fkey FOREIGN KEY (tax_id) REFERENCES tax(tax_id) ON DELETE CASCADE;


--
-- Name: shipping_fee_shipping_box_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shipping_fee
    ADD CONSTRAINT shipping_fee_shipping_box_id_fkey FOREIGN KEY (shipping_box_id) REFERENCES shipping_box(shipping_box_id);


--
-- Name: shopping_cart_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shopping_cart_item
    ADD CONSTRAINT shopping_cart_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;


--
-- Name: shopping_cart_item_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shopping_cart_item
    ADD CONSTRAINT shopping_cart_item_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: shopping_cart_item_store_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shopping_cart_item
    ADD CONSTRAINT shopping_cart_item_store_user_id_fkey FOREIGN KEY (store_user_id) REFERENCES store_user(store_user_id) ON DELETE CASCADE;


--
-- Name: shopping_cart_shipping_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shopping_cart_shipping
    ADD CONSTRAINT shopping_cart_shipping_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: shopping_cart_shipping_store_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY shopping_cart_shipping
    ADD CONSTRAINT shopping_cart_shipping_store_user_id_fkey FOREIGN KEY (store_user_id) REFERENCES store_user(store_user_id) ON DELETE CASCADE;


--
-- Name: site_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_category
    ADD CONSTRAINT site_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE;


--
-- Name: site_category_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_category
    ADD CONSTRAINT site_category_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: site_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_item
    ADD CONSTRAINT site_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;


--
-- Name: site_item_numeric_metadata_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_item_numeric_metadata
    ADD CONSTRAINT site_item_numeric_metadata_item_id_fkey FOREIGN KEY (item_id) REFERENCES item(item_id);


--
-- Name: site_item_numeric_metadata_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_item_numeric_metadata
    ADD CONSTRAINT site_item_numeric_metadata_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id);


--
-- Name: site_item_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_item
    ADD CONSTRAINT site_item_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: site_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site
    ADD CONSTRAINT site_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES locale(locale_id);


--
-- Name: site_user_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_user
    ADD CONSTRAINT site_user_site_id_fkey FOREIGN KEY (site_id) REFERENCES site(site_id) ON DELETE CASCADE;


--
-- Name: site_user_store_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY site_user
    ADD CONSTRAINT site_user_store_user_id_fkey FOREIGN KEY (store_user_id) REFERENCES store_user(store_user_id) ON DELETE CASCADE;


--
-- Name: tax_history_tax_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY tax_history
    ADD CONSTRAINT tax_history_tax_id_fkey FOREIGN KEY (tax_id) REFERENCES tax(tax_id) ON DELETE CASCADE;


--
-- Name: tax_name_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY tax_name
    ADD CONSTRAINT tax_name_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES locale(locale_id);


--
-- Name: tax_name_tax_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY tax_name
    ADD CONSTRAINT tax_name_tax_id_fkey FOREIGN KEY (tax_id) REFERENCES tax(tax_id) ON DELETE CASCADE;


--
-- Name: transaction_credit_tender_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_credit_tender
    ADD CONSTRAINT transaction_credit_tender_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES transaction_header(transaction_id) ON DELETE CASCADE;


--
-- Name: transaction_header_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_header
    ADD CONSTRAINT transaction_header_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES currency(currency_id);


--
-- Name: transaction_item_transaction_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_item
    ADD CONSTRAINT transaction_item_transaction_site_id_fkey FOREIGN KEY (transaction_site_id) REFERENCES transaction_site(transaction_site_id) ON DELETE CASCADE;


--
-- Name: transaction_shipping_transaction_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_shipping
    ADD CONSTRAINT transaction_shipping_transaction_site_id_fkey FOREIGN KEY (transaction_site_id) REFERENCES transaction_site(transaction_site_id) ON DELETE CASCADE;


--
-- Name: transaction_site_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_site
    ADD CONSTRAINT transaction_site_transaction_id_fkey FOREIGN KEY (transaction_id) REFERENCES transaction_header(transaction_id) ON DELETE CASCADE;


--
-- Name: transaction_status_fk1; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_status
    ADD CONSTRAINT transaction_status_fk1 FOREIGN KEY (transporter_id) REFERENCES transporter(transporter_id);


--
-- Name: transaction_status_transaction_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_status
    ADD CONSTRAINT transaction_status_transaction_site_id_fkey FOREIGN KEY (transaction_site_id) REFERENCES transaction_site(transaction_site_id);


--
-- Name: transaction_tax_transaction_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transaction_tax
    ADD CONSTRAINT transaction_tax_transaction_site_id_fkey FOREIGN KEY (transaction_site_id) REFERENCES transaction_site(transaction_site_id) ON DELETE CASCADE;


--
-- Name: transporter_name_locale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transporter_name
    ADD CONSTRAINT transporter_name_locale_id_fkey FOREIGN KEY (locale_id) REFERENCES locale(locale_id);


--
-- Name: transporter_name_transporter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: store_user
--

ALTER TABLE ONLY transporter_name
    ADD CONSTRAINT transporter_name_transporter_id_fkey FOREIGN KEY (transporter_id) REFERENCES transporter(transporter_id) ON DELETE CASCADE;


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

