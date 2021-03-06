DROP DATABASE IF EXISTS Gastronomia;
CREATE DATABASE Gastronomia;
USE Gastronomia;
 
CREATE TABLE Restaurant(
idRestaurant SMALLINT NOT NULL,
Email VARCHAR (25) NOT NULL UNIQUE,
Domicilio VARCHAR (25) NOT NULL,
Contrasena CHAR (64) NOT NULL,
PRIMARY KEY (idRestaurant)
);
 
CREATE TABLE Cliente(
idCliente INT NOT NULL,
Nombre VARCHAR (25) NOT NULL,
Apellido VARCHAR (25) NOT NULL,
EmailCliente VARCHAR(45) NOT NULL,
ContrasenaC CHAR(64),
PRIMARY KEY (idCliente)
);
 
CREATE TABLE Plato(
idPlato INT NOT NULL,
Nombre VARCHAR (25) NOT NULL,
Descripcion Varchar (45) NOT NULL,
PrecioUnitario Decimal (5,2) NOT NULL,
idRestaurant SMALLINT NOT NULL,
Disponible Boolean NOT NULL,
PRIMARY KEY (idPlato),
CONSTRAINT FK_Plato_Restaurant FOREIGN KEY (idRestaurant)
REFERENCES Restaurant (idRestaurant),
FULLTEXT (nombre)
);
 
CREATE TABLE Pedido (
idPedido MEDIUMINT NOT NULL,
FechayHora DATETIME NOT NULL,
idRestaurant SMALLINT NOT NULL,
idCliente INT NOT NULL,
precioIndividual DECIMAL (5,2) NOT NULL,
Valoracion TINYINT NULL,
Descripcion VARCHAR(45) NULL,
PRIMARY KEY (idPedido),
CONSTRAINT FK_Pedido_Restaurant FOREIGN KEY (idRestaurant)
REFERENCES Restaurant (idRestaurant),
CONSTRAINT FK_idCliente_Restaurant FOREIGN KEY (idCliente)
REFERENCES Cliente (idCliente)
);
 
CREATE TABLE Menuplato(
CantPlato TINYINT NOT NULL,
precioIndividual  DECIMAL (5,2) NOT NULL,
idPlato INT NOT NULL,
idPedido MEDIUMINT NOT NULL,
PRIMARY KEY (idPlato, idPedido),
CONSTRAINT FK_MenuPlato_Plato FOREIGN KEY (idPlato)
REFERENCES Plato (idPlato),
CONSTRAINT FK_Menuplato_Pedido FOREIGN KEY (idPedido)
REFERENCES Pedido (idPedido)
);
 
