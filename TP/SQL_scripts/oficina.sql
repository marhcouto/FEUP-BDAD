.headers on
.mode columns

PRAGMA foreign_keys = on;

DROP Table IF EXISTS FuncionarioReparacao;
DROP Table IF EXISTS Funcionario;
DROP Table IF EXISTS Especialidade;
DROP Table IF EXISTS PecaModelo;
DROP Table IF EXISTS ReparacaoPeca;
DROP Table IF EXISTS Peca;
DROP Table IF EXISTS Reparacao;
DROP Table IF EXISTS Carro;
DROP Table IF EXISTS Cliente;
DROP Table IF EXISTS CodPostal;
DROP Table IF EXISTS Modelo;
DROP Table IF EXISTS Marca;

CREATE TABLE Marca (
	idMarca INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL
);

CREATE TABLE Modelo (
	idModelo INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	idMarca INTEGER REFERENCES Marca(idMarca)
);

CREATE TABLE CodPostal (
	codPostal1 TEXT PRIMARY KEY,
	localidade TEXT
);

CREATE TABLE Cliente (
	idCliente INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL, 
	morada TEXT,
	codPostal1 TEXT REFERENCES CodPostal(codPostal1),
	codPostal2 TEXT,
	telefone TEXT
);

CREATE TABLE Carro (
	idCarro INTEGER PRIMARY KEY AUTOINCREMENT,
	Matricula TEXT UNIQUE,
	idModelo INTEGER REFERENCES Modelo(idModelo),
	idCliente INTEGER REFERENCES Cliente(idCliente)
);

CREATE TABLE Reparacao (
	idReparacao INTEGER PRIMARY KEY AUTOINCREMENT,
	dataInicio TEXT,
	dataFim TEXT,
	idCliente INTEGER REFERENCES Cliente(idCliente),
	idCarro INTEGER REFERENCES Carro(idCarro),
	CONSTRAINT ch_df_di CHECK (dataFim >= dataInicio)
);

CREATE TABLE Peca (
	idPeca INTEGER PRIMARY KEY AUTOINCREMENT,
	codigo TEXT UNIQUE,
	designacao TEXT,
	custoUnitario INTEGER CHECK (custoUnitario >= 0),
	quantidade INTEGER CHECK (quantidade >= 0)
);

CREATE TABLE ReparacaoPeca (
	idReparacao INTEGER REFERENCES Reparacao(idReparacao),
	idPeca INTEGER REFERENCES Peca(idPeca),
	quantidade INTEGER CHECK (quantidade >= 0),
	CONSTRAINT pk_reparacao_peca PRIMARY KEY (idReparacao, idPeca)
);

CREATE TABLE PecaModelo (
	idPeca INTEGER REFERENCES Peca(idPeca),
	idModelo INTEGER REFERENCES Modelo(idModelo),
	CONSTRAINT pk_peca_modelo PRIMARY KEY (idPeca, idModelo)
);

CREATE TABLE Especialidade (
	idEspecialidade INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	custoHorario INTEGER CHECK (custoHorario >= 0)
);

CREATE TABLE Funcionario (
	idFuncionario INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	morada TEXT,
	codPostal1 TEXT REFERENCES CodPostal(codPostal1),
	codPostal2 TEXT,
	telefone TEXT,
	idEspecialidade INTEGER REFERENCES Especialidade(idEspecialidade)
);

CREATE TABLE FuncionarioReparacao (
	idFuncionario INTEGER REFERENCES Funcionario(idFuncionario),
	idReparacao INTEGER REFERENCES Reparacao(idReparacao),
	numHoras INTEGER CHECK (numHoras >= 0),
	CONSTRAINT pk_funcionario_reparacao PRIMARY KEY (idFuncionario, idReparacao)
);

------------------------------------------------------

INSERT INTO CodPostal (codPostal1, localidade) VALUES ('4200','Porto');
INSERT INTO CodPostal (codPostal1, localidade) VALUES ('4400','Vila Nova de Gaia');
INSERT INTO CodPostal (codPostal1, localidade) VALUES ('4450','Matosinhos');

INSERT INTO Cliente (nome, morada, codPostal1, codPostal2, telefone)
	VALUES ('Alberto Sousa', 'Rua Brito e Cunha, 125','4450','086','932853425');
INSERT INTO Cliente (nome, morada, codPostal1, codPostal2, telefone)
	VALUES ('Maria Francisca Pereira Nobre','Avenida Meneres, 201','4450','191','933278005');
INSERT INTO Cliente (nome, morada, codPostal1, codPostal2, telefone)
	VALUES ('Rodrigo Meireles de Aguiar','Rua da Cunha, 310 1º Dir','4200','250','928604666');
INSERT INTO Cliente (nome, morada, codPostal1, codPostal2, telefone)
	VALUES ('Adão Lopes Sá','Rua Domingos de Matos, 200 3º Esq','4400','120','963670913');

INSERT INTO Marca (nome) VALUES ('Renault');
INSERT INTO Marca (nome) VALUES ('Volvo');

INSERT INTO Modelo (nome, idMarca) 
	VALUES ('Clio 1.9D', 1);
INSERT INTO Modelo (nome, idMarca)
	VALUES ('V50 Momentum', 2);
INSERT INTO Modelo (nome, idMarca)
	VALUES ('C30 Drive', 2);

INSERT INTO Carro (matricula, idModelo, idCliente)
	VALUES ('2490CV', 1, 4);
INSERT INTO Carro (matricula, idModelo, idCliente)
	VALUES ('36DH79', 2, 2);
INSERT INTO Carro (matricula, idModelo, idCliente)
	VALUES ('1127XY', 3, 3);
INSERT INTO Carro (matricula, idModelo, idCliente)
	VALUES ('78AB27', 3, 2);
INSERT INTO Carro (matricula, idModelo, idCliente)
	VALUES ('16IU02', 3, 4);

INSERT INTO Reparacao (dataInicio, dataFim, idCliente, idCarro)
	VALUES ('2010-09-17', NULL, 1, 3);
INSERT INTO Reparacao (dataInicio, dataFim, idCliente, idCarro)
	VALUES ('2010-09-15', '2010-09-16', 4, 1);
INSERT INTO Reparacao (dataInicio, dataFim, idCliente, idCarro)
	VALUES ('2009-09-18', '2009-09-27', 4, 5);

INSERT INTO Peca (codigo, designacao, custoUnitario, quantidade)
	VALUES ('37XX98', NULL, 3, 100);
INSERT INTO Peca (codigo, designacao, custoUnitario, quantidade)
	VALUES ('75VBO98', NULL, 25, 10);
INSERT INTO Peca (codigo, designacao, custoUnitario, quantidade)
	VALUES ('A5GH65', NULL, 20, 7);

INSERT INTO PecaModelo (idPeca, idModelo) VALUES (1, 1);
INSERT INTO PecaModelo (idPeca, idModelo) VALUES (2, 3);
INSERT INTO PecaModelo (idPeca, idModelo) VALUES (3, 3);

INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade) VALUES (2, 1, 8);
INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade) VALUES (3, 2, 2);

INSERT INTO Especialidade(nome, custoHorario)
	VALUES ('Electricista', 15);
INSERT INTO Especialidade(nome, custoHorario)
	VALUES ('Mecânico', 12);
INSERT INTO Especialidade(nome, custoHorario)
	VALUES ('Chapeiro', 10);

INSERT INTO Funcionario(nome, morada, codPostal1, codpostal2, telefone, idEspecialidade)
	VALUES ('Abel Sousa', 'Rua da Preciosa, 317-1º Esq', 4200, 137, '226903271', 1);
INSERT INTO Funcionario(nome, morada, codPostal1, codpostal2, telefone, idEspecialidade)
	VALUES ('Mário Teixeira', 'Rua Seca, 17', 4400, 210, '227519090', 2);
INSERT INTO Funcionario(nome, morada, codPostal1, codpostal2, telefone, idEspecialidade)
	VALUES ('Rogério Silva', 'Rua dos Caldeireiros, 312, 3ºF', 4400, 112, '227403728', 2);
INSERT INTO Funcionario(nome, morada, codPostal1, codpostal2, telefone, idEspecialidade)
	VALUES ('Luís Pereira', 'Rua Teixeira de Pascoaes, 117, 2º D', 4450, 117, '225901707', 3);

INSERT INTO FuncionarioReparacao (idFuncionario, idReparacao, numHoras) VALUES (1,1,1);
INSERT INTO FuncionarioReparacao (idFuncionario, idReparacao, numHoras) VALUES (4,1,4);
INSERT INTO FuncionarioReparacao (idFuncionario, idReparacao, numHoras) VALUES (1,2,1);
INSERT INTO FuncionarioReparacao (idFuncionario, idReparacao, numHoras) VALUES (2,2,6);
INSERT INTO FuncionarioReparacao (idFuncionario, idReparacao, numHoras) VALUES (4,2,2);
INSERT INTO FuncionarioReparacao (idFuncionario, idReparacao, numHoras) VALUES (1,3,1);
