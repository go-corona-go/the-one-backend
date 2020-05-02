CREATE TABLE public.seller_inventory (
    seller_id integer NOT NULL,
    item_id integer NOT NULL,
    units integer NOT NULL,
    price money NOT NULL,
    seller_inventory_id integer NOT NULL
);
CREATE SEQUENCE public."Seller_Inventory_seller_inventory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public."Seller_Inventory_seller_inventory_id_seq" OWNED BY public.seller_inventory.seller_inventory_id;
CREATE TABLE public.sellers (
    id integer NOT NULL,
    user_id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    contact_person_no text NOT NULL,
    registration_status text NOT NULL,
    country_id integer NOT NULL,
    contact_person_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    address text NOT NULL,
    "Whatsap" text,
    "Skype" text,
    "Viber" text,
    fb_messenger text,
    fair_trade_member text NOT NULL,
    fair_trade_principle boolean NOT NULL,
    production_safety_description text NOT NULL,
    production_sanitization_description text NOT NULL,
    production_line_safety_description text NOT NULL,
    other_safety_measures text NOT NULL,
    production_photos text
);
CREATE SEQUENCE public."Seller_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public."Seller_id_seq" OWNED BY public.sellers.id;
CREATE SEQUENCE public.country_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE public.country (
    id integer DEFAULT nextval('public.country_seq'::regclass) NOT NULL,
    iso character(2) NOT NULL,
    name character varying(80) NOT NULL,
    nicename character varying(80) NOT NULL,
    iso3 character(3) DEFAULT NULL::bpchar,
    numcode smallint,
    phonecode integer NOT NULL
);
CREATE VIEW public.inventory_buyer_view AS
SELECT
    NULL::integer AS id,
    NULL::text AS name,
    NULL::text AS category,
    NULL::text AS description,
    NULL::text AS image_link,
    NULL::money AS min_price,
    NULL::money AS max_price;
CREATE TABLE public.inventory_items (
    id integer NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    description text,
    image_link text NOT NULL
);
CREATE SEQUENCE public.inventory_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.inventory_items_id_seq OWNED BY public.inventory_items.id;
CREATE TABLE public.item_category (
    category text NOT NULL
);
CREATE TABLE public.order_cart (
    order_id integer NOT NULL,
    item_id integer NOT NULL,
    item_units integer NOT NULL,
    id integer NOT NULL
);
CREATE SEQUENCE public.order_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.order_cart_id_seq OWNED BY public.order_cart.id;
CREATE TABLE public.orders (
    id integer NOT NULL,
    order_display_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    phone text NOT NULL,
    email text NOT NULL,
    order_status text NOT NULL,
    country_id integer NOT NULL
);
CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.order_id_seq OWNED BY public.orders.id;
CREATE TABLE public.order_status_type (
    value text NOT NULL,
    description text NOT NULL
);
CREATE TABLE public.seller_order_items (
    id integer NOT NULL,
    seller_order_id integer NOT NULL,
    item_id integer NOT NULL,
    item_price money NOT NULL,
    item_units integer NOT NULL
);
CREATE SEQUENCE public.seller_order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.seller_order_items_id_seq OWNED BY public.seller_order_items.id;
CREATE TABLE public.seller_order_threads (
    id integer NOT NULL,
    seller_order_id integer NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.seller_order_threads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.seller_order_threads_id_seq OWNED BY public.seller_order_threads.id;
CREATE TABLE public.seller_orders (
    id integer NOT NULL,
    seller_order_display_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    seller_id integer NOT NULL,
    order_id integer NOT NULL,
    estimated_delivery date NOT NULL,
    receipt text,
    seller_order_status text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.seller_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.seller_orders_id_seq OWNED BY public.seller_orders.id;
CREATE TABLE public.seller_registration_status_type (
    value text NOT NULL,
    description text NOT NULL
);
ALTER TABLE ONLY public.inventory_items ALTER COLUMN id SET DEFAULT nextval('public.inventory_items_id_seq'::regclass);
ALTER TABLE ONLY public.order_cart ALTER COLUMN id SET DEFAULT nextval('public.order_cart_id_seq'::regclass);
ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);
ALTER TABLE ONLY public.seller_inventory ALTER COLUMN seller_inventory_id SET DEFAULT nextval('public."Seller_Inventory_seller_inventory_id_seq"'::regclass);
ALTER TABLE ONLY public.seller_order_items ALTER COLUMN id SET DEFAULT nextval('public.seller_order_items_id_seq'::regclass);
ALTER TABLE ONLY public.seller_order_threads ALTER COLUMN id SET DEFAULT nextval('public.seller_order_threads_id_seq'::regclass);
ALTER TABLE ONLY public.seller_orders ALTER COLUMN id SET DEFAULT nextval('public.seller_orders_id_seq'::regclass);
ALTER TABLE ONLY public.sellers ALTER COLUMN id SET DEFAULT nextval('public."Seller_id_seq"'::regclass);
ALTER TABLE ONLY public.seller_inventory
    ADD CONSTRAINT "Seller_Inventory_pkey" PRIMARY KEY (seller_inventory_id);
ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT "Seller_email_key" UNIQUE (email);
ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT "Seller_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_name_key UNIQUE (name);
ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.item_category
    ADD CONSTRAINT item_category_pkey PRIMARY KEY (category);
ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_order_id_key UNIQUE (order_display_id);
ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.order_status_type
    ADD CONSTRAINT order_status_type_pkey PRIMARY KEY (value);
ALTER TABLE ONLY public.seller_order_items
    ADD CONSTRAINT seller_order_items_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.seller_order_threads
    ADD CONSTRAINT seller_order_threads_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.seller_orders
    ADD CONSTRAINT seller_orders_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.seller_orders
    ADD CONSTRAINT seller_orders_seller_id_order_id_key UNIQUE (seller_id, order_id);
ALTER TABLE ONLY public.seller_registration_status_type
    ADD CONSTRAINT seller_registration_status_type_pkey PRIMARY KEY (value);
CREATE OR REPLACE VIEW public.inventory_buyer_view AS
 SELECT inventory_items.id,
    inventory_items.name,
    inventory_items.category,
    inventory_items.description,
    inventory_items.image_link,
    min(seller_inventory.price) AS min_price,
    max(seller_inventory.price) AS max_price
   FROM (public.inventory_items
     JOIN public.seller_inventory ON ((inventory_items.id = seller_inventory.item_id)))
  GROUP BY inventory_items.id;
ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_category_fkey FOREIGN KEY (category) REFERENCES public.item_category(category) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_items(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_fkey FOREIGN KEY (order_status) REFERENCES public.order_status_type(value) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.seller_inventory
    ADD CONSTRAINT seller_inventory_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_items(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.seller_inventory
    ADD CONSTRAINT seller_inventory_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.sellers(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.seller_order_items
    ADD CONSTRAINT seller_order_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_items(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.seller_order_items
    ADD CONSTRAINT seller_order_items_seller_order_id_fkey FOREIGN KEY (seller_order_id) REFERENCES public.seller_orders(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.seller_order_threads
    ADD CONSTRAINT seller_order_threads_seller_order_id_fkey FOREIGN KEY (seller_order_id) REFERENCES public.seller_orders(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.seller_orders
    ADD CONSTRAINT seller_orders_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.seller_orders
    ADD CONSTRAINT seller_orders_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.sellers(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_registration_status_fkey FOREIGN KEY (registration_status) REFERENCES public.seller_registration_status_type(value) ON UPDATE RESTRICT ON DELETE RESTRICT;
