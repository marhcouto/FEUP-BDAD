PRAGMA foreign_keys = on;


DROP TRIGGER IF EXISTS managerAssign;
CREATE TRIGGER managerAssign
BEFORE INSERT ON Estabelecimento
BEGIN 
    SELECT
        CASE
            WHEN (EXISTS (
                    SELECT * 
                    FROM Funcionario_Interno f
                    WHERE f.ID_funcionario = NEW.ID_manager AND (f.numero_espaco IS NOT NULL OR f.numero_piso IS NOT NULL OR f.nome_empresa IS NOT NULL)))
            THEN RAISE(rollback, "Manager from this establishment is already employed elsewhere")
    END;
    UPDATE Funcionario_Interno SET nome_empresa = NEW.nome_empresa, numero_espaco = NEW.numero_espaco, numero_piso = NEW.numero_piso
    WHERE ID_funcionario = NEW.ID_manager;
END;