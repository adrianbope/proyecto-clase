CREATE TABLE EVENTOS (
    cod_evento INT PRIMARY KEY,
    fecha DATE,
    lugar VARCHAR(50),
    num_entradas_disponibles INT CHECK (num_entradas_disponibles >= 0)
);

CREATE TABLE COMBATES (
    cod_combate INT PRIMARY KEY,
    fecha DATE,
    tiempo_duracion INT,
    num_KOs INT CHECK (num_KOs >= 0),
    cod_evento INT,
    FOREIGN KEY (cod_evento) REFERENCES EVENTOS(cod_evento)
        ON DELETE CASCADE
);

CREATE TABLE BARES (
    cod_bar INT PRIMARY KEY,
    nombre VARCHAR(50),
    comida VARCHAR(50),
    bebidas VARCHAR(50),
    cod_evento INT,
    FOREIGN KEY (cod_evento) REFERENCES EVENTOS(cod_evento)
        ON DELETE CASCADE
);

CREATE TABLE ANIMADORAS (
    NIF VARCHAR(9) PRIMARY KEY,
    grupo VARCHAR(50),
    nombre VARCHAR(50)
);

CREATE TABLE ARBITROS (
    id_arbitro INT PRIMARY KEY,
    num_partidos_arbitrados INT CHECK (num_partidos_arbitrados >= 0),
    num_detenciones INT CHECK (num_detenciones >= 0)
);

CREATE TABLE ENTRENADORES (
    DNI VARCHAR(9) PRIMARY KEY,
    num_entrenamientos INT CHECK (num_entrenamientos >= 0)
);

CREATE TABLE LUCHADORES (
    cod_luchador INT PRIMARY KEY,
    anos_entrenando INT CHECK (anos_entrenando >= 0),
    DNI_entrenador VARCHAR(9),
    FOREIGN KEY (DNI_entrenador) REFERENCES ENTRENADORES(DNI)
        ON DELETE SET NULL
);

CREATE TABLE ASISTEN (
    cod_evento INT,
    NIF VARCHAR(9),
    PRIMARY KEY (cod_evento, NIF),
    FOREIGN KEY (cod_evento) REFERENCES EVENTOS(cod_evento)
        ON DELETE CASCADE,
    FOREIGN KEY (NIF) REFERENCES ANIMADORAS(NIF)
        ON DELETE CASCADE
);

CREATE TABLE ARBITRAN (
    cod_combate INT,
    id_arbitro INT,
    PRIMARY KEY (cod_combate, id_arbitro),
    FOREIGN KEY (cod_combate) REFERENCES COMBATES(cod_combate)
        ON DELETE CASCADE,
    FOREIGN KEY (id_arbitro) REFERENCES ARBITROS(id_arbitro)
        ON DELETE CASCADE
);

CREATE TABLE PARTICIPAN (
    cod_combate INT,
    cod_luchador INT,
    golpes_dados INT CHECK (golpes_dados >= 0),
    golpes_recibidos INT CHECK (golpes_recibidos >= 0),
    PRIMARY KEY (cod_combate, cod_luchador),
    FOREIGN KEY (cod_combate) REFERENCES COMBATES(cod_combate)
        ON DELETE CASCADE,
    FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE BOXEO (
    cod_luchador INT PRIMARY KEY,
    onzas INT,
    FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE JIUJITSU (
    cod_luchador INT PRIMARY KEY,
    cinturon VARCHAR(30),
    FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE JUDO (
    cod_luchador INT PRIMARY KEY,
    cinturon VARCHAR(30),
    FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);

CREATE TABLE MUAYTHAI (
    cod_luchador INT PRIMARY KEY,
    FOREIGN KEY (cod_luchador) REFERENCES LUCHADORES(cod_luchador)
        ON DELETE CASCADE
);
