-- a) Atualizar automaticamente o stock de peças após inserção de registos na 
-- tabela ReparacaoPeca
DROP TRIGGER IF EXISTS atualizaStockPecas;
CREATE TRIGGER atualizaStockPecas
AFTER INSERT ON ReparacaoPeca
BEGIN
  UPDATE Peca SET quantidade = quantidade - NEW.quantidade WHERE idPeca = NEW.idPeca;
END;

-- b)Se, na inserção de uma reparação, não for especificado o cliente, assumir que 
-- este é o proprietário do carro.
DROP TRIGGER IF EXISTS defaultClient;
CREATE TRIGGER defaultClient
AFTER INSERT ON Reparacao
WHEN (NEW.idCliente IS NULL)
BEGIN
  UPDATE Reparacao SET idCliente = (
    SELECT idCliente FROM Carro WHERE idCarro = NEW.idCarro
  );
END;

-- c) Simultaneamente: (1) impedir a atribuição de peças não compatíveis com o 
-- modelo do carro em reparação; e (2) impedir a atribuição de peças sem stock 
-- suficiente para satisfazer a quantidade pretendida na reparação

DROP TRIGGER IF EXISTS stopReparacaoPeca;
CREATE TRIGGER stopReparacaoPeca
BEFORE INSERT ON ReparacaoPeca
WHEN (
  NOT EXISTS (
    SELECT *
    FROM Reparacao JOIN Carro using(idCarro) JOIN PecaModelo using(idModelo) JOIN Peca using(idPeca)
    WHERE Peca.idPeca = NEW.idPeca AND Peca.quantidade >= NEW.quantidade AND Reparacao.idReparacao = NEW.idReparacao
  )
)
BEGIN 
  SELECT RAISE(ABORT, 'There was an error');
END;

-- d) Quando se tenta inserir registos numa vista com os nomes de todos os 
-- modelos e respetivas marcas, estas inserções sejam feitas nas tabelas que 
-- dão origem à vista. A vista deve também ser criada no contexto deste 
-- exercício.

DROP TRIGGER IF EXISTS updateTables;
DROP VIEW IF EXISTS modelBrand;

CREATE VIEW modelBrand AS
SELECT Modelo.nome as modelo, Marca.nome as marca
FROM Modelo JOIN Marca using(idMarca);

CREATE TRIGGER updateTables
INSTEAD OF INSERT ON modelBrand
BEGIN
  INSERT INTO Marca (nome) VALUES (NEW.marca);
  INSERT INTO Modelo (nome, idMarca) VALUES(NEW.modelo, (SELECT idMarca FROM Marca WHERE nome = NEW.marca));
END;