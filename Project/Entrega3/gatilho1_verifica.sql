PRAGMA foreign_keys = on;


INSERT INTO Piso (numero_piso) VALUES (-10);
INSERT INTO Estacionamento (numero_estacionamento,max_lugares,taxa) VALUES (-10,120,0.001);
INSERT INTO Receita_Estacionamento (mes,ano,numero_estacionamento) VALUES (10,2090,-10);

SELECT * FROM Bilhete;
SELECT * FROM Receita_Estacionamento;
INSERT INTO Bilhete (data,hora_entrada,minuto_entrada,hora_saida,minuto_saida,numero_estacionamento) VALUES ('2090-10-04',16,9,21,8,-10);
SELECT * FROM Bilhete;
SELECT * FROM Receita_Estacionamento;
INSERT INTO Bilhete (data,hora_entrada,minuto_entrada,hora_saida,minuto_saida,numero_estacionamento) VALUES ('2090-10-04',16,11,22,15,-10);
SELECT * FROM Bilhete;
SELECT * FROM Receita_Estacionamento;
INSERT INTO Bilhete (data,hora_entrada,minuto_entrada,hora_saida,minuto_saida,numero_estacionamento) VALUES ('2070-10-04',16,11,22,15,-10);
SELECT * FROM Bilhete;
SELECT * FROM Receita_Estacionamento;
DELETE FROM Bilhete WHERE ID_bilhete = 1;
SELECT * FROM Bilhete;
SELECT * FROM Receita_Estacionamento;