PRAGMA foreign_keys = on;


DROP TRIGGER IF EXISTS montanteReceitasUpd;
CREATE TRIGGER montanteReceitasUpd
AFTER UPDATE OF valor_pagamento ON Bilhete 
BEGIN
    UPDATE Receita_Estacionamento SET montante = montante + NEW.valor_pagamento - OLD.valor_pagamento
    WHERE mes = strftime('%m', NEW.data) AND ano = strftime('%Y', NEW.data);
END;

DROP TRIGGER IF EXISTS montanteReceitasDel;
CREATE TRIGGER montanteReceitasDel
BEFORE DELETE ON Bilhete 
BEGIN
    UPDATE Receita_Estacionamento SET montante = montante - OLD.valor_pagamento
    WHERE mes = strftime('%m', OLD.data) AND ano = strftime('%Y', OLD.data);
END;