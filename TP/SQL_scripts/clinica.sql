.headers on
.mode columns

PRAGMA foreign_keys = on;

DROP TABLE IF EXISTS MedicamentoPrescricao;
DROP TABLE IF EXISTS Medicamento;
DROP TABLE IF EXISTS Prescricao;
DROP TABLE IF EXISTS ConsultasMarcadas;
DROP TABLE IF EXISTS Disponibilidade;
DROP TABLE IF EXISTS HorarioConsultas;
DROP TABLE IF EXISTS Doente;
DROP TABLE IF EXISTS Medico;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Especialidade;

CREATE TABLE Especialidade (
	idespec INTEGER PRIMARY KEY,
	nome TEXT
);

CREATE TABLE Pessoa (
	codpessoa INTEGER PRIMARY KEY,
	nome TEXT,
	nif TEXT UNIQUE,
	morada TEXT,
	codPostal TEXT,
	telefone TEXT,
	datanasc TEXT
);

CREATE TABLE Medico (
	codmedico INTEGER PRIMARY KEY REFERENCES Pessoa,
	idespec INTEGER REFERENCES Especialidade(idespec)
);

CREATE TABLE Doente (
	coddoente INTEGER PRIMARY KEY REFERENCES Pessoa,
	profissao TEXT
);

CREATE TABLE HorarioConsultas (
	idhorarioconsulta INTEGER PRIMARY KEY,
	horainicio REAL,
	numdoentes INTEGER
);

CREATE TABLE Disponibilidade (
	codmedico INTEGER REFERENCES Medico(codmedico),
	idhorarioconsulta INTEGER REFERENCES HorarioConsultas(idhorarioconsulta),
	dia TEXT,
	CONSTRAINT uk_disponibilidade UNIQUE (codmedico, dia),
	CONSTRAINT pk_disponibilidade PRIMARY KEY (codmedico, dia)
);

CREATE TABLE ConsultasMarcadas (
	idConsultaMarcada INTEGER PRIMARY KEY,
	data TEXT,
	horainicio REAL,
	preco REAL,
	relatorio TEXT,
	classificacao TEXT,
	codmedico INTEGER REFERENCES Medico(codmedico),
	coddoente INTEGER REFERENCES Doente(coddoente)
);

CREATE TABLE Prescricao (
	idprescricao INTEGER PRIMARY KEY,
	data TEXT,
	codmedico INTEGER REFERENCES Medico(codmedico),
	coddoente INTEGER REFERENCES Doente(coddoente)
);

CREATE TABLE Medicamento (
	idmedicamento INTEGER PRIMARY KEY,
	nome TEXT,
	laboratorio TEXT,
	modo TEXT,
	quantidade INTEGER
);

CREATE TABLE MedicamentoPrescricao (
	idprescricao INTEGER REFERENCES Prescricao(idprescricao),
	idmedicamento INTEGER REFERENCES Medicamento(idmedicamento),
	numembalagens INTEGER,
	CONSTRAINT pk_prescricaomedicamento PRIMARY KEY (idprescricao, idmedicamento)
);

----------------------------------------------------------

INSERT INTO Especialidade (idespec, nome) VALUES (1, 'ortopedia');
INSERT INTO Especialidade (idespec, nome) VALUES (2, 'oftalmologia');
INSERT INTO Especialidade (idespec, nome) VALUES (3, 'otorrinolaringologia');

INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (1, 'Jose Andrade Simoes', '117689827', 'Av. da Republica, 105, Vila do Conde', '4340-121', '936254908', '1959-05-17');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (2, 'Ana Fernandes de Oliveira', '132459827', 'Rua Amalia Rodrigues, 375, 2ºDir, Penafiel', '4500-240', '917689325', '1965-12-12');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (3, 'Fernando Carlos Goncalves Cardoso', '109365809', 'Rua de Timor, 327 1 Esq, Vila Nova de Gaia', '4300-029', '964517329', '1973-04-03');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (4, 'Mariana Guedes de Araujo', '111091452', 'Rua de Recarei, 10, Porto', '4000-350', '925938479', '1981-11-03');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (5, 'Carlos Antunes de Vasconcelos', '129430908', 'Rua Diogo Borges, 102 5 Dir T, Porto', '4000-080', '936254908', '1959-05-17');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (6, 'Marilia de Jesus Almeida', '121110903', 'Carreiro da Lama, 27, Lousada', '4560-390', '912829354', '1984-03-11');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (7, 'Joao Carvalho e Silva', '102394465', 'Rua 15, 372 2 Dir, Espinho', '4600-520', '902009412', '1952-02-27');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (8, 'Armando Botelho Veiga', '101320890', 'Rua da preciosa, 105 2 Dir, Porto', '4200-450', '936254908', '1959-05-17');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (9, 'Belmira de Mesquita Seixas', '121146915', 'Rua da restauracao', '4250-805', '924928356', '1979-07-19');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (10, 'Rui Manuel Alves de Sousa', '105310083', 'Avenida do casino, 110 7 Dir, Povoa de Varzim', '4600-750', '913097891', '1967-01-07');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (11, 'Manuel Veloso Gomes', '100430152', 'Rua de Golgota, 32, Porto', '4000-300', '918276890', '1984-06-15');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (12, 'Ines Salgado Barbosa', '125340728', 'Rua de Timor, 327 3 Esq, Paredes', '4580-730', '923908612', '1982-03-19');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (13, 'Ana Rita Santos Ribeiro', '111525746', 'Av. Julio Pereira, 312, Penafiel', '4560-392', '962305460', '1966-10-20');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (14, 'Rute Lopes Duarte', '107320568', 'Rua 22, 93, Espinho', '4600-320', '924097301', '1962-01-11');
INSERT INTO Pessoa (codpessoa, nome, nif, morada, codpostal, telefone, datanasc) 
	VALUES (15, 'Luisa Faria Leal', '102560798', 'Rua do Mirante, 200, Porto', '4000-210', '918147275', '1956-08-02');

INSERT INTO Medico (codmedico, idespec) VALUES (1,1);
INSERT INTO Medico (codmedico, idespec) VALUES (2,1);
INSERT INTO Medico (codmedico, idespec) VALUES (3,2);
INSERT INTO Medico (codmedico, idespec) VALUES (4,2);
INSERT INTO Medico (codmedico, idespec) VALUES (5,2);
INSERT INTO Medico (codmedico, idespec) VALUES (6,3);

INSERT INTO Doente (coddoente, profissao) VALUES (7,'advogado');
INSERT INTO Doente (coddoente, profissao) VALUES (8,'electrecista');
INSERT INTO Doente (coddoente, profissao) VALUES (9,'contabilista');
INSERT INTO Doente (coddoente, profissao) VALUES (10,'marceneiro');
INSERT INTO Doente (coddoente, profissao) VALUES (11,'comerciante');
INSERT INTO Doente (coddoente, profissao) VALUES (12,'enfermeiro');
INSERT INTO Doente (coddoente, profissao) VALUES (13,'professor');
INSERT INTO Doente (coddoente, profissao) VALUES (14,'politico');
INSERT INTO Doente (coddoente, profissao) VALUES (15,'taxista');

INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (1, 9.30, 8);
INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (2, 10, 2);
INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (3, 14, 10);
INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (4, 14, 6);

INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (1, '2017-05-02', 1);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (1, '2017-05-03', 1);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (1, '2017-05-04', 1);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (1, '2017-05-05', 1);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (2, '2017-05-02', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (2, '2017-05-03', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (2, '2017-05-04', 3);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (2, '2017-05-05', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (3, '2017-05-02', 3);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (3, '2017-05-03', 3);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (3, '2017-05-04', 3);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (3, '2017-05-05', 3);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (4, '2017-05-02', 1);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (4, '2017-05-03', 1);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (4, '2017-05-04', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (4, '2017-05-05', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (5, '2017-05-02', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (5, '2017-05-03', 3);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (5, '2017-05-04', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (5, '2017-05-05', 2);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (6, '2017-05-02', 4);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (6, '2017-05-03', 4);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (6, '2017-05-04', 4);
INSERT INTO Disponibilidade (codmedico, dia, idhorarioconsulta) VALUES (6, '2017-05-05', 4);

INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (1, '2017-05-02', 9.30, 40, 'fisura na tibia esquerda', 'Amarelo', 1, 10);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (2, '2017-05-02', 10, 30, 'entorse do tornozelo direito', 'Amarelo', 1, 12);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (3, '2017-05-02', 11, 40, 'rutura de ligamentos pe direito', 'Vermelho', 1, 13);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (4, '2017-05-03', 10, 40, 'Sindrome de Quervain no pulso esquerdo', 'Verde', 1, 14);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (5, '2017-05-02', 14, 40, 'hipermetropia do olho esquerdo', 'Amarelo', 3, 10);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (6, '2017-05-05', 10, 40, 'hipermetropia do olho esquerdo', 'Amarelo', 5, 9);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (7, '2017-05-02', 14.30, 40, 'hipermetropia do olho esquerdo', 'Amarelo', 3, 12);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (8, '2017-05-05', 10.30, 30, 'hipermetropia do olho esquerdo', 'Amarelo', 5, 13);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) 
	VALUES (9, '2017-05-06', 15, 40, 'hipermetropia do olho esquerdo', 'Amarelo', 3, 15);

INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (1, '2017-05-02', 1, 10);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (2, '2017-05-02', 1, 12);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (3, '2017-05-02', 1, 13);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (4, '2017-05-03', 1, 14);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (5, '2017-05-03', 3, 10);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (6, '2017-05-04', 5, 9);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (7, '2017-05-05', 3, 12);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (8, '2017-05-05', 5, 13);

INSERT INTO Medicamento (idmedicamento, nome, laboratorio, modo, quantidade) 
	VALUES (1, 'ben-u-ron', 'bene', 'oral', 10);
INSERT INTO Medicamento (idmedicamento, nome, laboratorio, modo, quantidade) 
	VALUES (2, 'clamoxil', 'SmithKline Beecham Pharmaceuticals', 'oral', 4);

INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (2, 1, 1);
INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (1, 2, 1);
INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (3, 1, 1);
INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (3, 2, 2);
