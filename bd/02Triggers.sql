DELIMITER $$
DROP TRIGGER IF EXISTS AftInsMenuPlato $$
CREATE TRIGGER AftInsMenuPlato AFTER INSERT ON Menuplato
FOR EACH ROW
BEGIN
        DECLARE mesActual INT DEFAULT MONTH(NOW());
        DECLARE anoActual INT DEFAULT YEAR(NOW());
        DECLARE unResto INT;
       
        SELECT idRestaurant INTO unResto
        FROM Plato
        WHERE idPlato = NEW.idPlato;
       
    IF (NOT EXISTS (SELECT *
                FROM VentaResto
                WHERE idResto = unResto AND Anio = anoActual AND MES = mesActual AND idPlato = NEW.idPlato)) THEN
            CALL altaVentaResto (unResto, anoActual, mesActual, new.idPlato, new.PrecioUnitario * NEW.CantPlato);
    ELSE
       
       
        UPDATE VentaResto
        SET Monto = Monto + (NEW.PrecioUnitario * NEW.CantPlato)
        WHERE idPlato = NEW.idPlato
        AND Anio = anoActual
        AND MES = mesActual
        AND idResto = unResto;
    END IF;
END $$
 
 
DROP TRIGGER IF EXISTS AftDELMenuPlato $$
CREATE TRIGGER AftDELMenuPlato AFTER DELETE ON Menuplato
FOR EACH ROW
BEGIN
       
       
    IF (EXISTS (SELECT *
                FROM VentaResto
                WHERE idPlato = OLD.idPlato AND Anio = YEAR(NOW()) AND MES = MONTH(NOW()))) THEN
            CALL altaVentaResto (YEAR(NOW()), MONTH(NOW()), OLD.idPlato, OLD.PrecioUnitario * OLD.CantPlato);
    END IF;
        IF (EXISTS (SELECT *
                FROM VentaResto
                WHERE idPlato != OLD.idPlato AND Anio != YEAR(NOW()) AND MES != MONTH(NOW()))) THEN
                UPDATE VentaResto
                SET Monto = Monto + (OLD.PrecioUnitario* OLD.CantPlato)
                WHERE idPlato = OLD.idPlato;
    END IF;
END $$
 
