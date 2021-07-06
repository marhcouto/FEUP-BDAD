PRAGMA foreign_keys=on;


DROP TRIGGER IF EXISTS insertBilhete;
CREATE TRIGGER insertBilhete
AFTER INSERT ON Bilhete
BEGIN
    UPDATE Bilhete SET valor_pagamento = ((NEW.hora_saida - NEW.hora_entrada) * 60 + NEW.minuto_saida - NEW.minuto_entrada) * (
        SELECT taxa
        FROM Bilhete JOIN Estacionamento USING(numero_estacionamento)
    )
    WHERE ID_bilhete = NEW.ID_bilhete;
END;

DROP TRIGGER IF EXISTS updateBilhete;
CREATE TRIGGER updateBilheteB
AFTER UPDATE ON Bilhete
BEGIN
    UPDATE Bilhete SET valor_pagamento = ((NEW.hora_saida - NEW.hora_entrada) * 60 + NEW.minuto_saida - NEW.minuto_entrada) * (
        SELECT taxa
        FROM Bilhete JOIN Estacionamento USING(numero_estacionamento)
    )
    WHERE ID_bilhete = NEW.ID_bilhete;
END;