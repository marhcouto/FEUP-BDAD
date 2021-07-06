PRAGMA foreign_keys = on;

.hearders on
.mode columns


-- 1.

DROP TRIGGER IF EXISTS trig1;
CREATE TRIGGER trig1
BEFORE INSERT ON ConsultasMarcadas
WHEN EXISTS (
    SELECT *
    FROM ConsultasMarcadas
    WHERE codmedico = NEW.codmedico AND data = NEW.data AND horainicio = NEW.horainicio
)
BEGIN
    SELECT RAISE(ROLLBACK, 'error');
END;

-- 2.

DROP TRIGGER IF EXISTS trig2;
CREATE TRIGGER trig2
BEFORE INSERT ON Prescricao
WHEN NOT EXISTS (
    SELECT *
    FROM ConsultasMarcadas
    WHERE codDoente = NEW.codDoente AND codMedico = NEW.codMedico AND -- data igual ou inferior
)
BEGIN
    SELECT RAISE(ROLLBACK, 'error');
END;


-- 3.


DROP TRIGGER IF EXISTS trig3;
CREATE TRIGGER trig3
BEFORE INSERT ON ConsultasMarcadas
WHEN (SELECT idhorarioconsulta FROM Disponibilidade WHERE codmedico = NEW.codmedico AND horainicio = NEW.horainicio) < 1
BEGIN
    SELECT RAISE(ROLLBACK, 'error');
END;
