--creating db
CREATE DATABASE crm_system
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--adding tables
CREATE TABLE public.products
(
    id serial NOT NULL,
    name character varying(50) NOT NULL,
    description text NOT NULL,
    price numeric(10, 2) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;

CREATE TABLE public.customers
(
    id serial NOT NULL,
    name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    phone character varying(15),
    address character varying(50),
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.custormers
    OWNER to postgres;

CREATE TABLE public.orders
(
    id serial NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    PRIMARY KEY (id)
    FOREIGN KEY (customer_id)
        REFERENCES public.custormers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID;
    FOREIGN KEY (product_id)
        REFERENCES public.products (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID;
);

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;

CREATE TABLE public.support_tickets
(
    id serial NOT NULL,
    customer_id integer NOT NULL,
    status character varying(50) NOT NULL,
    title character varying(50) NOT NULL,
    details text NOT NULL,
    submit_date timestamp without time zone NOT NULL,
    resolved_date timestamp without time zone,
    priority character varying(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id)
        REFERENCES public.custormers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.support_tickets
    OWNER to postgres;