-- a. Quais as peças com custo unitário inferior a 10€ e cujo código contém ‘98’?
-- SELECT * 
-- FROM Peca p1
-- WHERE p1.custoUnitario < 10 AND codigo LIKE '%98%';

-- b. Quais as matrículas dos carros que foram reparados no mês de Setembro de
--  2010, i.e., cuja reparação terminou nesse mês?
-- SELECT matricula
-- FROM carro, Reparacao USING(idCarro)
-- WHERE dataFim LIKE '2010-09-__' AND dataInicio LIKE '2010-09-__';

-- c. Quais os nomes dos clientes proprietários de carros que utilizaram peças
-- com custo unitário superior a 10€? Apresente o resultado ordenado por ordem
-- descendente do custo unitário.
-- SELECT Cliente.nome
-- FROM Peca NATURAL JOIN PecaModelo NATURAL JOIN modelo join Carro using(idModelo) join Cliente using(idCliente)
-- WHERE custoUnitario > 10
-- ORDER BY custoUnitario;

-- d. Quais os nomes dos clientes que não têm (tanto quanto se saiba) carro?
-- SELECT nome
-- FROM Cliente
-- WHERE idCliente NOT IN (SELECT idCliente FROM Carro);

-- e. Qual o número de reparações feitas a cada carro?
-- SELECT matricula, count(idReparacao)
-- FROM carro JOIN Reparacao USING(idCarro)
-- GROUP BY matricula;

-- f. Qual o número de dias em que cada carro esteve em reparação?
-- SELECT matricula, sum(julianday(dataFim) - julianday(dataInicio))
-- FROM carro JOIN Reparacao USING(idcarro)
-- GROUP BY matricula;

-- g. Qual o custo unitário médio, o valor total e o número de unidades das
-- peças, bem como o valor da peça mais cara e da mais barata?
-- SELECT avg(custoUnitario) as "Custo Unitário Médio", sum(custoUnitario * quantidade) as "Custo Total",
--  count(idPeca) as "Numero de peças", max(custoUnitario) as "Peça mais cara", min(custoUnitario) as "Peça mais barata"
-- FROM Peca;


-- h. Qual a especialidade que foi utilizada mais vezes nas reparações dos
-- carros de cada marca?
-- SELECT max(Especialidade.nome), Marca.nome
-- FROM Reparacao JOIN Carro using(idCarro) JOIN Modelo using(idModelo) JOIN Marca using(idMarca)
--  JOIN FuncionarioReparacao using(idReparacao) JOIN Funcionario using(idFuncionario) JOIN Especialidade using(idEspecialidade)
-- GROUP BY Marca.nome;

-- i. Qual o preço total de cada reparação?
-- SELECT idReparacao as "Reparação",
--     CASE
--         WHEN idPeca is NULL THEN sum(custoHorario * numHoras)
--         WHEN idFuncionario is NULL THEN  sum(ReparacaoPeca.quantidade * custoUnitario)
--         ELSE sum((custoHorario * numHoras + ReparacaoPeca.quantidade * custoUnitario))
--     END "Custo Total"
-- FROM Reparacao LEFT JOIN ReparacaoPeca using(idReparacao) LEFT JOIN Peca using(idPeca) LEFT JOIN FuncionarioReparacao using(idReparacao) LEFT JOIN Funcionario using(idFuncionario) LEFT JOIN Especialidade using(idEspecialidade)
-- GROUP BY idReparacao;

-- j. Qual o preço total das reparações com custo total superior a 60€?
-- DROP VIEW IF EXISTS PrecoReparacao;
-- CREATE VIEW PrecoReparacao as
-- SELECT idReparacao as "Reparação",
--     CASE
--         WHEN idPeca is NULL THEN sum(custoHorario * numHoras)
--         WHEN idFuncionario is NULL THEN  sum(ReparacaoPeca.quantidade * custoUnitario)
--         ELSE sum((custoHorario * numHoras + ReparacaoPeca.quantidade * custoUnitario))
--     END "Custo Total"
-- FROM Reparacao LEFT JOIN ReparacaoPeca using(idReparacao) LEFT JOIN Peca using(idPeca) LEFT JOIN FuncionarioReparacao using(idReparacao) LEFT JOIN Funcionario using(idFuncionario) LEFT JOIN Especialidade using(idEspecialidade)
-- GROUP BY idReparacao;
-- 
-- 
-- SELECT * 
-- FROM PrecoReparacao
-- WHERE "Custo Total" > 60;

-- k. Qual o proprietário do carro que teve a reparação mais cara?
-- DROP VIEW IF EXISTS PrecoReparacao;
-- CREATE VIEW PrecoReparacao as
-- SELECT idReparacao as "Reparação",
--     CASE
--         WHEN idPeca is NULL THEN sum(custoHorario * numHoras)
--         WHEN idFuncionario is NULL THEN  sum(ReparacaoPeca.quantidade * custoUnitario)
--         ELSE sum((custoHorario * numHoras + ReparacaoPeca.quantidade * custoUnitario))
--     END "Custo Total", idCliente
-- FROM Reparacao LEFT JOIN ReparacaoPeca using(idReparacao) LEFT JOIN Peca using(idPeca) LEFT JOIN FuncionarioReparacao using(idReparacao) LEFT JOIN Funcionario using(idFuncionario) LEFT JOIN Especialidade using(idEspecialidade)
-- GROUP BY idReparacao;
-- 
-- SELECT nome as "Name of the Client", max("Custo Total") as "Most Expensive Reparation"
-- FROM PrecoReparacao JOIN Cliente using(idCliente);

-- l. Qual a matrícula do carro com a segunda reparação mais cara?
-- DROP VIEW IF EXISTS PrecoReparacao;
-- CREATE VIEW PrecoReparacao as
-- SELECT idReparacao,
--     CASE
--         WHEN idPeca is NULL THEN sum(custoHorario * numHoras)
--         WHEN idFuncionario is NULL THEN  sum(ReparacaoPeca.quantidade * custoUnitario)
--         ELSE sum((custoHorario * numHoras + ReparacaoPeca.quantidade * custoUnitario))
--     END "Custo Total", idCarro
-- FROM Reparacao LEFT JOIN ReparacaoPeca using(idReparacao) LEFT JOIN Peca using(idPeca) LEFT JOIN FuncionarioReparacao using(idReparacao) LEFT JOIN Funcionario using(idFuncionario) LEFT JOIN Especialidade using(idEspecialidade)
-- GROUP BY idReparacao;
-- 
-- SELECT Matricula
-- FROM PrecoReparacao p JOIN Carro using(idCarro)
-- WHERE (SELECT count(idReparacao) FROM PrecoReparacao p1 WHERE p1."Custo Total" > p."Custo Total" AND p1.idReparacao <> p.idReparacao) = 1;

-- m. Quais são as três reparações mais caras (ordenadas por ordem
-- decrescente de preço)?
-- DROP VIEW IF EXISTS PrecoReparacao;
-- CREATE VIEW PrecoReparacao as
-- SELECT idReparacao,
--     CASE
--         WHEN idPeca is NULL THEN sum(custoHorario * numHoras)
--         WHEN idFuncionario is NULL THEN  sum(ReparacaoPeca.quantidade * custoUnitario)
--         ELSE sum((custoHorario * numHoras + ReparacaoPeca.quantidade * custoUnitario))
--     END "Custo Total"
-- FROM Reparacao LEFT JOIN ReparacaoPeca using(idReparacao) LEFT JOIN Peca using(idPeca) LEFT JOIN FuncionarioReparacao using(idReparacao) LEFT JOIN Funcionario using(idFuncionario) LEFT JOIN Especialidade using(idEspecialidade)
-- GROUP BY idReparacao;
-- 
-- SELECT *
-- FROM PrecoReparacao p
-- WHERE (SELECT count(idReparacao) FROM PrecoReparacao p1 WHERE p1."Custo Total" > p."Custo Total" AND p1.idReparacao <> p.idReparacao) < 3
-- ORDER BY "Custo Total" DESC;

-- n. Quais os nomes dos clientes responsáveis por reparações de carros e
-- respetivos proprietários (só para os casos em que não são coincidentes)?
-- SELECT proprietário, cliente
-- FROM (
--     (SELECT idCarro, idCliente as idProprietário, nome as proprietário FROM Cliente JOIN Carro USING(idCliente))
--     JOIN (SELECT idCarro, idCliente as idCliente, nome cliente FROM Reparacao JOIN Cliente USING(idCliente))
--     USING(idCarro)
-- )
-- WHERE idCliente <> idProprietário;


-- o. Quais as localidades onde mora alguém, seja ele cliente ou funcionário?
-- SELECT localidade
-- FROM Funcionario JOIN CodPostal using(codPostal1)
-- UNION 
-- SELECT localidade
-- FROM Cliente JOIN CodPostal using(codPostal1);


-- p. Quais as localidades onde moram clientes e funcionários?
-- SELECT localidade
-- FROM Funcionario JOIN CodPostal using(codPostal1)
-- INTERSECT
-- SELECT localidade
-- FROM Cliente JOIN CodPostal using(codPostal1);


-- q. Quais as peças compatíveis com modelos da Volvo cujo preço é maior
-- do que o de qualquer peça compatível com modelos da Renault?
-- DROP VIEW IF EXISTS PecaMarca;
-- CREATE VIEW PecaMarca AS
-- SELECT Marca.nome as marca, custoUnitario, idPeca
-- FROM Peca JOIN PecaModelo using(idPeca) JOIN Modelo using(idModelo) JOIN Marca using(idMarca);
-- 
-- SELECT * 
-- FROM PecaMarca pm
-- WHERE pm.marca = "Volvo" AND NOT EXISTS (
--     SELECT *
--     FROM PecaMarca pm2
--     WHERE pm.custoUnitario < pm2.custoUnitario AND pm2.marca = "Renault"
-- );


-- r. Quais as peças compatíveis com modelos da Volvo cujo preço é maior
-- do que o de alguma peça compatível com modelos da Renault?
-- DROP VIEW IF EXISTS PecaMarca;
-- CREATE VIEW PecaMarca AS
-- SELECT Marca.nome as marca, custoUnitario, idPeca
-- FROM Peca JOIN PecaModelo using(idPeca) JOIN Modelo using(idModelo) JOIN Marca using(idMarca);
-- 
-- SELECT * 
-- FROM PecaMarca pm
-- WHERE pm.marca = "Volvo" AND EXISTS (
--     SELECT *
--     FROM PecaMarca pm2
--     WHERE pm.custoUnitario > pm2.custoUnitario AND pm2.marca = "Renault"
-- );

-- s. Quais as matriculas dos carros que foram reparados mais do que uma vez?
-- DROP VIEW IF EXISTS CarNoRepair;
-- CREATE VIEW CarNoRepair AS
-- SELECT matricula, count(idCarro) as noRepair, Reparacao.idCliente, idModelo, dataInicio, dataFim, idReparacao
-- FROM Reparacao JOIN Carro using(idCarro)
-- GROUP BY idCarro;
-- 
-- SELECT matricula, noRepair
-- FROM CarNoRepair
-- WHERE noRepair > 1;

-- t. Quais as datas de início e de fim e nome do proprietário das reparações
-- feitas por carros que foram reparados mais do que uma vez?
--DROP VIEW IF EXISTS CarNoRepair;
--CREATE VIEW CarNoRepair AS
--SELECT matricula, count(idCarro) as noRepair, Reparacao.idCliente, idModelo, dataInicio, dataFim, idReparacao
--FROM Reparacao JOIN Carro using(idCarro)
--GROUP BY idCarro;
--
--SELECT dataInicio, dataFim, nome
--FROM CarNoRepair JOIN Cliente using(idCliente);

-- u. Quais as reparações que envolveram todas as especialidades?
-- (começar por determinar as reparações que não envolveram todas as especialidades)
-- SELECT *
-- FROM (
--     SELECT idReparacao, count(Especialidade.nome) noSpecs
--     FROM Reparacao JOIN FuncionarioReparacao using(idReparacao) JOIN Funcionario using(idFuncionario) JOIN Especialidade using(idEspecialidade)
--     GROUP BY idReparacao
-- )
-- WHERE noSpecs = (SELECT count(nome) FROM Especialidade);

-- v. Calcule as durações de cada reparação, contabilizando até à data atual
-- os não entregues.
-- SELECT idReparacao, 
--     CASE
--         WHEN dataFim is NULL THEN (strftime('%Y', DATE('now')) - strftime('%Y', dataInicio)) * 365 + (strftime('%m',DATE('now')) - strftime('%m', dataInicio)) * 30 + strftime('%d', DATE('now')) - strftime('%d', dataInicio) 
--         ELSE (strftime('%Y', dataFim) - strftime('%Y', dataInicio)) * 365 + (strftime('%m', dataFim) - strftime('%m', dataInicio)) * 30 + strftime('%d', dataFim) - strftime('%d', dataInicio)
--     END duracao
-- FROM Reparacao;

-- w. Substitua Renault por Top, Volvo por Down e os restantes por NoWay.
-- UPDATE Marca
-- SET nome = "Top" WHERE nome = "Renault";
-- UPDATE Marca
-- SET nome = "Down" WHERE nome = "Volvo";
-- UPDATE Marca 
-- SET nome = "NoWay" WHERE nome <> "Renault" AND nome <> "Volvo";
