PRAGMA foreign_keys = on;
.mode columns
.headers on

DROP TABLE IF EXISTS Funcionario_Interno;
DROP TABLE IF EXISTS Receita_Estacionamento;
DROP TABLE IF EXISTS Bilhete;
DROP TABLE IF EXISTS Estacionamento;
DROP TABLE IF EXISTS Funcionario_Externo;
DROP TABLE IF EXISTS Prestador_de_servico;
DROP TABLE IF EXISTS Servico;
DROP TABLE IF EXISTS Contrato;
DROP TABLE IF EXISTS Estabelecimento;
DROP TABLE IF EXISTS Empresa;
DROP TABLE IF EXISTS Fiscalizacao;
DROP TABLE IF EXISTS Casa_de_Banho;
DROP TABLE IF EXISTS Espaco;
DROP TABLE IF EXISTS Evento_Piso;
DROP TABLE IF EXISTS Piso;
DROP TABLE IF EXISTS Evento;

CREATE TABLE Empresa (
    nome_empresa TEXT 
                 PRIMARY KEY
);


CREATE TABLE Piso (
    numero_piso INTEGER
                PRIMARY KEY
);


CREATE TABLE Evento (
    nome_evento         TEXT,

    data_evento         DATE,

    hora                TEXT
                        NOT NULL
                        CHECK (hora >= 0 AND hora <= 22),

    lotacao             INTEGER
                        NOT NULL
                        CHECK ((lotacao > 0)),

    duracao             INTEGER
                        NOT NULL
                        CHECK ((duracao > 0)),

    preco_bilhetes      REAL
                        NOT NULL
                        CHECK ((preco_bilhetes >= 0)),

    preco_realizacao    REAL
                        NOT NULL
                        DEFAULT (0.0),

    bilhetes_vendidos   INTEGER
                        NOT NULL
                        DEFAULT (0)
                        CHECK ((bilhetes_vendidos >= 0)),


    PRIMARY KEY (
        nome_evento,
        data_evento
    )
);


CREATE TABLE Contrato (
    nome_empresa         TEXT 
                         PRIMARY KEY,

    data_inicio          DATE
                         NOT NULL,

    data_fim             DATE
                         NOT NULL,

    frequencia_pagamento TEXT
                         NOT NULL
                         DEFAULT 'mensal'
                         CHECK (frequencia_pagamento IN('anual', 'mensal', 'semanal', 'trimestral', 'semestral')),

    valor_pagamento      INTEGER
                         NOT NULL,


    FOREIGN KEY (nome_empresa) REFERENCES Empresa ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE Funcionario_Interno (
    ID_funcionario INTEGER 
                   PRIMARY KEY
                   AUTOINCREMENT,

    nome           TEXT,

    numero_espaco  INTEGER
                   CHECK ((numero_espaco > 0)),

    numero_piso    INTEGER,

    nome_empresa   TEXT,


    FOREIGN KEY (
        nome_empresa,
        numero_espaco,
        numero_piso
    ) REFERENCES Estabelecimento ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Estabelecimento (
    nome_empresa            TEXT,

    numero_espaco           INTEGER
                            CHECK ((numero_espaco > 0)),

    numero_piso             INTEGER,

    tipo_de_estabelecimento TEXT
                            NOT NULL
                            CHECK (tipo_de_estabelecimento IN('Lazer', 'Saude e Bem-Estar', 'Restaurante', 'Loja')),

    ID_manager              INTEGER   
                            NOT NULL,


    PRIMARY KEY (
        nome_empresa,
        numero_espaco,
        numero_piso
    ),

    FOREIGN KEY (nome_empresa) REFERENCES Empresa ON DELETE RESTRICT ON UPDATE RESTRICT, 

    FOREIGN KEY (ID_manager) REFERENCES Funcionario_Interno ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (
        numero_espaco,
        numero_piso
    ) REFERENCES Espaco ON DELETE RESTRICT ON UPDATE RESTRICT 
);


CREATE TABLE Fiscalizacao (
    ID_fiscalizacao INTEGER 
                    PRIMARY KEY
                    AUTOINCREMENT,

    data            DATE
                    NOT NULL,

    avaliacao       INTEGER
                    CHECK (avaliacao IN(1, 2, 3, 4, 5)),

    numero_espaco   INTEGER
                    NOT NULL,

    numero_piso     INTEGER
                    NOT NULL,


    FOREIGN KEY (numero_espaco, numero_piso) REFERENCES Espaco ON DELETE RESTRICT ON UPDATE RESTRICT,

    UNIQUE (data, numero_espaco, numero_piso)
);


CREATE TABLE Casa_de_Banho (
    numero_espaco      INTEGER
                       CHECK ((numero_espaco > 0)),

    numero_piso        INTEGER,

    tipo_casa_de_banho TEXT
                       NOT NULL
                       CHECK (tipo_casa_de_banho IN('Masculina', 'Feminina', 'Necessidades Especiais', 'Fraldário')),


    PRIMARY KEY(
        numero_espaco,
        numero_piso
    ),

    FOREIGN KEY (
        numero_espaco,
        numero_piso
    ) REFERENCES Espaco ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE Espaco (
    numero_espaco   INTEGER
                    CHECK ((numero_espaco > 0)),
                    
    numero_piso     INTEGER,

    dimensoes       REAL
                    NOT NULL
                    CHECK ((dimensoes > 0)),


    PRIMARY KEY (
        numero_espaco,
        numero_piso
    ),
    
    FOREIGN KEY (numero_piso) REFERENCES Piso ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE Evento_Piso (
    nome_evento TEXT,

    data_evento DATE,

    numero_piso INTEGER,


    PRIMARY KEY (
        nome_evento,
        data_evento, 
        numero_piso
    ),

    FOREIGN KEY (
        nome_evento,
        data_evento
    ) REFERENCES Evento ON UPDATE RESTRICT ON DELETE CASCADE,

    FOREIGN KEY (numero_piso) REFERENCES Piso ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE Funcionario_Externo (
    ID_funcionario INTEGER
                   PRIMARY KEY
                   AUTOINCREMENT,

    nome           TEXT
                   NOT NULL,

    nome_empresa   TEXT 
                   NOT NULL 
                   REFERENCES Empresa ON UPDATE RESTRICT ON DELETE CASCADE
);


CREATE TABLE Receita_Estacionamento (
    mes                   INTEGER
                          CHECK (mes IN(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 )),

    ano                   INTEGER
                          CHECK ((ano > 0)),

    numero_estacionamento INTEGER,

    montante              REAL
                          NOT NULL
                          DEFAULT 0.0,


    PRIMARY KEY (
        mes,
        ano,
        numero_estacionamento
    ),

    FOREIGN KEY (numero_estacionamento) REFERENCES Estacionamento ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE Bilhete (
    ID_bilhete                      INTEGER PRIMARY KEY AUTOINCREMENT,

    data                    DATE
                            NOT NULL
                            DEFAULT (datetime('now')),

    hora_entrada            INTEGER
                            NOT NULL
                            CHECK ((hora_entrada >= 6 AND hora_entrada <= 22)),

    minuto_entrada          INTEGER
                            NOT NULL
                            CHECK ((minuto_entrada >= 0 AND minuto_entrada <= 59)),

    hora_saida              INTEGER
                            CHECK ((hora_saida >= 6 AND hora_saida <= 23)),

    minuto_saida            INTEGER
                            CHECK ((minuto_saida >= 0 AND minuto_saida <= 59)),

    numero_estacionamento   INTEGER
                            NOT NULL,

    valor_pagamento         REAL
                            NOT NULL
                            DEFAULT 0.0,
    

    CHECK(hora_entrada < hora_saida OR (hora_entrada = hora_saida AND minuto_entrada <= minuto_saida)),
    FOREIGN KEY (numero_estacionamento) REFERENCES Estacionamento ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE Estacionamento (
    numero_estacionamento INTEGER PRIMARY KEY,

    max_lugares           INTEGER
                          NOT NULL
                          CHECK ((max_lugares > 0)),

    taxa                  REAL
                          NOT NULL
                          CHECK ((taxa >= 0)),

    FOREIGN KEY (numero_estacionamento) REFERENCES Piso ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE Prestador_de_Servico (
    nome_empresa TEXT
                 PRIMARY KEY,

    tipo_servico TEXT
                 NOT NULL,
                 CHECK (tipo_servico IN('Segurança', 'Manutenção', 'Limpeza')),


    FOREIGN KEY (nome_empresa) REFERENCES Empresa ON DELETE CASCADE ON UPDATE RESTRICT
);


CREATE TABLE Servico (
    ID_servico     INTEGER
                   PRIMARY KEY
                   AUTOINCREMENT,

    hora           INTEGER
                   NOT NULL,

    data           DATE
                   NOT NULL
                   DEFAULT (datetime('now')),

    ID_funcionario INTEGER
                   NOT NULL,

    numero_espaco  INTEGER
                   NOT NULL,

    numero_piso    INTEGER
                   NOT NULL,


    FOREIGN KEY (ID_funcionario) REFERENCES Funcionario_Externo ON DELETE CASCADE ON UPDATE RESTRICT,

    FOREIGN KEY (
        numero_espaco,
        numero_piso
    ) REFERENCES Espaco ON DELETE CASCADE ON UPDATE RESTRICT,

    UNIQUE (ID_funcionario, data, hora)
);