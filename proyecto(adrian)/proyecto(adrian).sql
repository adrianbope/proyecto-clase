CREATE TABLE EVENTOS (
    cod_evento                NUMBER PRIMARY KEY,
    fecha                     DATE,
    lugar                     VARCHAR2(50),
    num_entradas_disponibles   NUMBER CHECK (num_entradas_disponibles >= 0)
);

CREATE TABLE COMBATES (
    cod_combate      NUMBER PRIMARY KEY,
    fecha            DATE,
    tiempo_duracion  NUMBER,
    num_KOs          NUMBER CHECK (num_KOs >= 0),
    cod_evento       NUMBER,
    CONSTRAINT fk_combate_evento
        FOREIGN KEY (cod_evento) REFERENCES EVENTOS(cod_evento)
        ON DELETE CASCADE
);

CREATE TABLE BARES (
    cod_bar     NUMBER PRIMARY KEY,
    nombre      VARCHAR2(50),
    comida      VARCHAR2(50),
    bebidas     VARCHAR2(50),
    cod_evento  NUMBER,
    CONSTRAINT fk_bar_evento
        FOREIGN KEY (cod_evento) REFERENCES EVENTOS(cod_evento)
        ON DELETE CASCADE
);

CREATE TABLE ANIMADORAS (
    NIF     VARCHAR2(9) PRIMARY KEY,
    grupo   VARCHAR2(50),
    nombre  VARCHAR2(50)
);

CREATE TABLE ARBITROS (
    id_arbitro              NUMBER PRIMARY KEY,
    num_partidos_arbitrados NUMBER CHECK (num_partidos_arbitrados >= 0),
    num_detenciones         NUMBER CHECK (num_detenciones >= 0)
);

CREATE TABLE ENTRENADORES (
    DNI                VARCHAR2(9) PRIMARY KEY,
    num_entrenamientos NUMBER CHECK (num_entrenamientos >= 0)
);

CREATE TABLE LUCHADORES (
    cod_luchador     NUMBER PRIMARY KEY,
    anos_entrenando  NUMBER CHECK (anos_entrenando >= 0),
    DNI_entrenador   VARCHAR2(9),
    CONSTRAINT fk_luchador_entrenador
        FOREIGN KEY (DNI_entrenador) REFERENCES ENTRENADORES(DNI)
        ON DELETE SET NULL
);

CREATE TABLE ASISTEN (
    cod_evento  NUMBER,
    NIF         VARCHAR2(9),
    CONSTRAINT pk_asisten PRIMARY KEY (cod_evento, NIF),
    CONSTRAINT fk_asisten_evento
        FOREIGN KEY (cod_evento) REFERENCES EVENTOS(cod_evento)
        ON DELETE CASCADE,
    CONSTRAINT fk_asisten_animadora
        FOREIGN KEY (NIF) REFERENCES ANIMADORAS(NIF)
        ON DELETE CASCADE
);

CREATE TABLE ARBITRAN (
    cod_combate  NUMBER,
    id_arbitro   NUMBER,
    CONSTRAINT pk_arbitran PRIMARY KEY (cod_combate, id_arbitro),
    CONSTRAINT fk_arbitran_combate
        FOREIGN KEY (cod_combate) REFERENCES COMBATES(cod_combate)
        ON DELETE CASCADE,
    CONSTRAINT fk_arbitran_arbitro
        FOREIGN KEY (id_arbitro) REFERENCES ARBITROS(id_arbitro)
        ON DELETE CASCADE
);

CREATE TABLE PARTICIPAN (
    cod_combate      NUMBER,
    cod_luchador     NUMBER,
    golpes_dados     NUMBER CHECK (golpes_dados >= 0),
    golpes_recibidos NUMBER CHECK (golpes_recibidos >= 0),
    CONSTRAINT pk_participan PRIMARY KEY (cod_combate, cod_luchador),
    CONSTRAINT fk_participan_combate
        FOREIGN KEY (cod_combate) REFERENCES COMBATES(cod_combate)
        ON DELETE CASCADE,
    CONSTRAINT fk_participan_luchador
        FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE BOXEO (
    cod_luchador NUMBER PRIMARY KEY,
    onzas        NUMBER,
    CONSTRAINT fk_boxeo_luchador
        FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE JIUJITSU (
    cod_luchador NUMBER PRIMARY KEY,
    cinturon     VARCHAR2(30),
    CONSTRAINT fk_jiujitsu_luchador
        FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE JUDO (
    cod_luchador NUMBER PRIMARY KEY,
    cinturon     VARCHAR2(30),
    CONSTRAINT fk_judo_luchador
        FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE MUAYTHAI (
    cod_luchador NUMBER PRIMARY KEY,
    CONSTRAINT fk_muaythai_luchador
        FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);
