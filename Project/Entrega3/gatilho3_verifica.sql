PRAGMA foreign_keys = on;

INSERT INTO Empresa (nome_empresa) VALUES ('Unga Bunga');
INSERT INTO Empresa (nome_empresa) VALUES ('Onga Bonga');
INSERT INTO Piso (numero_piso) VALUES (10);
INSERT INTO Espaco (numero_espaco,numero_piso,dimensoes) VALUES (1,10,500);
INSERT INTO Espaco (numero_espaco,numero_piso,dimensoes) VALUES (2,10,500);
INSERT INTO Funcionario_Interno (ID_funcionario,nome) VALUES (70,'Manuel Armário');
INSERT INTO Estabelecimento (nome_empresa,numero_espaco,numero_piso,tipo_de_estabelecimento, ID_manager) VALUES ('Onga Bonga',2,10,'Loja',70);
INSERT INTO Funcionario_Interno (ID_funcionario,nome,nome_empresa,numero_espaco,numero_piso) VALUES (80,'Manuel Arménio','Onga Bonga',2,10);

SELECT * FROM Estabelecimento;
SELECT * FROM Funcionario_Interno;

INSERT INTO Estabelecimento (nome_empresa,numero_espaco,numero_piso,tipo_de_estabelecimento,ID_manager) VALUES ('Unga Bunga',1,10,'Loja',80);
SELECT * FROM Estabelecimento;
INSERT INTO Funcionario_Interno (ID_funcionario,nome) VALUES (60,'Manuel Arminio');
SELECT * FROM Funcionario_Interno;
INSERT INTO Estabelecimento (nome_empresa,numero_espaco,numero_piso,tipo_de_estabelecimento,ID_manager) VALUES ('Unga Bunga',1,10,'Loja',60);
SELECT * FROM Estabelecimento;
SELECT * FROM Funcionario_Interno;
