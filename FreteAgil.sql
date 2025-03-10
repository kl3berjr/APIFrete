PGDMP  :    :                }         	   FreteAgil    17.4    17.4     "           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            #           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            $           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            %           1262    16388 	   FreteAgil    DATABASE     q   CREATE DATABASE "FreteAgil" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'pt-BR';
    DROP DATABASE "FreteAgil";
                     postgres    false            �            1255    16398    atualizar_timestamp()    FUNCTION     �   CREATE FUNCTION public.atualizar_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.atualizar_timestamp();
       public               postgres    false            �            1259    16390    veiculos    TABLE     E  CREATE TABLE public.veiculos (
    id integer NOT NULL,
    marca character varying(100) NOT NULL,
    modelo character varying(100) NOT NULL,
    ano character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.veiculos;
       public         heap r       postgres    false            �            1259    16389    veiculos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.veiculos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.veiculos_id_seq;
       public               postgres    false    218            &           0    0    veiculos_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.veiculos_id_seq OWNED BY public.veiculos.id;
          public               postgres    false    217            �           2604    16393    veiculos id    DEFAULT     j   ALTER TABLE ONLY public.veiculos ALTER COLUMN id SET DEFAULT nextval('public.veiculos_id_seq'::regclass);
 :   ALTER TABLE public.veiculos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217    218                      0    16390    veiculos 
   TABLE DATA           R   COPY public.veiculos (id, marca, modelo, ano, created_at, updated_at) FROM stdin;
    public               postgres    false    218   n       '           0    0    veiculos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.veiculos_id_seq', 9, true);
          public               postgres    false    217            �           2606    16397    veiculos veiculos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.veiculos
    ADD CONSTRAINT veiculos_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.veiculos DROP CONSTRAINT veiculos_pkey;
       public                 postgres    false    218            �           2620    16399 $   veiculos trigger_atualizar_timestamp    TRIGGER     �   CREATE TRIGGER trigger_atualizar_timestamp BEFORE UPDATE ON public.veiculos FOR EACH ROW EXECUTE FUNCTION public.atualizar_timestamp();
 =   DROP TRIGGER trigger_atualizar_timestamp ON public.veiculos;
       public               postgres    false    218    219               �   x�}�A
�@EיSx�I��8�z�n�IU�PT�Rҋuv-������G���>Ck�Mw
(%H�@5Q��2j@O�`J��FI<a�Src��}ׯp�q�6t�J��|�B�J��U�ǲ��E���u[�;�*"f�32"�ݼs�з3     