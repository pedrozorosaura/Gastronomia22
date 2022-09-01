DELIMITER $$
DROP PROCEDURE IF EXISTS altaPlato $$
CREATE PROCEDURE  altaPlato (unidPlato INT, unNombre VARCHAR(25), unDescripcion VARCHAR(45), unPrecioUnitario DECIMAL(5,2), unidRestaurant SMALLINT, unDisponible BOOLEAN)
 
BEGIN
   INSERT INTO Plato (idPlato, Nombre, Descripcion, PrecioUnitario, idRestaurant, Disponible)
           VALUES (unidPlato, unNombre, unDescripcion, unPrecioUnitario, unidRestaurant, unDisponible);
END $$
 
 
DELIMITER $$
DROP PROCEDURE IF EXISTS altaRestaurant $$
CREATE PROCEDURE altaRestaurant (unidRestaurant SMALLINT, unEmail VARCHAR(25), unDomicilio VARCHAR(25), unContrasena CHAR(64), unNombrer VARCHAR(25))
BEGIN
INSERT INTO Restaurant (idRestaurant, Email, Domicilio, Contrasena, Nombrer)
VALUES (unidRestaurant, unEmail, unDomicilio, unContrasena, unNombrer);
END $$
 
 
DELIMITER $$
DROP PROCEDURE IF EXISTS altaMenuplato $$
CREATE PROCEDURE altaMenuplato (unCantPlato TINYINT, unidPlato DECIMAL(5,2), unidPedido MEDIUMINT, unprecioIndividual DECIMAL (5,2))
BEGIN
INSERT INTO Menuplato (CantPlato, idPlato, idPedido, precioIndividual)
VALUES (unCantPlato, unidPlato, unidPedido, unprecioIndividual);
END $$
 
DELIMITER $$
DROP PROCEDURE IF EXISTS altaPedido $$
CREATE PROCEDURE altaPedido (unidPedido MEDIUMINT,
                                                             unFechayHora DATETIME,
                                                             unidRestaurant SMALLINT,
                                                             unidCliente INT,
                                                             unprecioIndividual DECIMAL(5,2),
                                                             unValoracion TINYINT,
                                                             unDescripcion VARCHAR(45))
 
BEGIN
INSERT INTO Pedido (idPedido, FechayHora, idRestaurant, idCliente, precioIndividual, Valoracion, Descripcion)
VALUES (unidPedido, unFechayHora, unidRestaurant, unidCliente, unprecioIndividual, unValoracion, unDescripcion);
END $$
                                         
 
--  Se pide hacer el SP ‘registrarCliente’ que reciba los datos del cliente. Es importante guardar encriptada la contraseña del cliente usando SHA256.
 
DELIMITER $$
DROP PROCEDURE IF EXISTS registrarCliente $$
CREATE PROCEDURE registrarCliente (unidCliente INT,
                                                                     unNombre VARCHAR (25),
                                                                     unApellido VARCHAR (25),
                                                                     unEmailCliente VARCHAR (45),
                                                                     unContrasenaC CHAR (64))
                           
                         
BEGIN
   INSERT INTO Cliente (idCliente, Nombre, Apellido, EmailCliente, ContrasenaC)
      VALUES(unidCliente, unNombre, unApellido, unEmailCliente, SHA2(ContrasenaC, 256));
END $$
 
 
-- Se pide hacer el SF ‘gananciaResto’ que reciba por parámetro un identificador de restaurante y 2 fechas, se debe devolver la ganancia que tuvo ese resto entre esas 2 fechas (inclusive). GANANCIA = SUMATORIA (cantidad * precio unitario plato)
 
DELIMITER $$
DROP FUNCTION IF EXISTS gananciaResto $$
CREATE FUNCTION gananciaResto (unidRestaurante SMALLINT,
                                                                 cotaSuperior DATETIME,
                                                                 cotaInferior DATETIME)
                                                           RETURNS INT READS SQL DATA
   
BEGIN
  DECLARE resultado FLOAT;
  SELECT  SUM (CantPlato * precioUnitario ) INTO resultado
  FROM Menuplato
  JOIN Plato on Plato.IdPlato = Menuplato.IdPlato
  JOIN Pedido on Pedido.IdPedido = Menuplato.IdPedido
  WHERE plato.idPlato = unidRestaurante
  AND FechayHora BETWEEN cotaInferior AND cotaSuperior;
     return resultado;
END $$
 
 
-- Se pide hacer el SP ‘Buscar’ que reciba por parámetro una cadena. El SP tiene que devolver los platos que contengan la cadena en su nombre, descripción o nombre del restaurante (Documentación función MATCH-AGAINST).
 
DELIMITER $$
DROP PROCEDURE IF EXISTS Buscar $$
CREATE PROCEDURE Buscar (busqueda VARCHAR(25))
   BEGIN
   SELECT nombre, Descripcion, PrecioUnitario
   FROM Plato
   JOIN Restaurant on Plato.idRestaurant = Restaurant.idRestaurant
   WHERE  MATCH (nombre, descripcion) AGAINST (busqueda IN BOOLEAN mode);
END $$


DROP PROCEDURE IF EXISTS altaVentaResto $$
CREATE PROCEDURE altaVentaResto (unAnio SMALLINT, unMES SMALLINT, unidPlato INT, unMonto DECIMAL (5,2))
BEGIN
        INSERT INTO VentaResto (Anio, MES, idPlato, Monto)
        VALUES (unAnio, unMES, unidPlato, unMonto);
END $$

DELIMITER $$ 
DROP TRIGGER IF EXISTS AftInsMenuPlato $$
CREATE TRIGGER AftInsMenuPlato AFTER INSERT ON Menuplato 
FOR EACH ROW
BEGIN 
    IF (EXISTS (SELECT *
                FROM VentaResto
            WHERE idPlato != NEW.idPlato )) THEN
            CALL altaVentaResto (YEAR(NOW()) , MONTH(NOW()), new.idPlato, SUM(NEW.precioIndividual * NEW.CantPlato));
	END IF;
        IF (EXISTS (SELECT *
                FROM VentaResto
            WHERE idPlato = NEW.idPlato )) THEN
            UPDATE VentaResto
            SET Monto = SUM(NEW.precioIndividual * NEW.CantPlato)
            WHERE idPlato = NEW.idPlato;
	END IF;
END $$ 
---------------------------------------------------------

DROP TRIGGER IF EXISTS AftDelMenuPlato $$
CREATE TRIGGER AftDelMenuPlato AFTER DELETE ON Menuplato 
FOR EACH ROW
BEGIN 
    IF (EXISTS (SELECT *
                FROM VentaResto
            WHERE idPlato != old.idPlato )) THEN
            CALL altaVentaResto (YEAR(NOW()) , MONTH(NOW()), old.idPlato, SUM(old.precioIndividual * old.CantPlato));
	END IF;
        IF (EXISTS (SELECT *
                FROM VentaResto
            WHERE idPlato = old.idPlato )) THEN
            UPDATE VentaResto
            SET Monto = SUM(old.precioIndividual * old.CantPlato)
            WHERE idPlato = old.idPlato;
	END IF;
END $$ 