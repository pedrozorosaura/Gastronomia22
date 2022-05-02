DROP DATABASE IF EXISTS Gastronomia;
CREATE DATABASE Gastronomia;
USE Gastronomia;

CREATE TABLE Restaurant(
idRestaurant SMALLINT NOT NULL,
Email Varchar (25) NOT NULL,
Domicilio Varchar (25) NOT NULL,
Contrasena CHAR (45) NOT NULL,
PRIMARY KEY (idRestaurant)
);

CREATE TABLE Cliente(
idNombreC VARCHAR (25) NOT NULL,
Apellido VARCHAR (25) NOT NULL,
EmailCliente VARCHAR(45) NOT NULL,
ContrasenaC CHAR(45),
PRIMARY KEY (idNombreC)
);

CREATE TABLE Plato(
idPlato Varchar(25) NOT NULL,
Descripcion Varchar (45) NOT NULL,
Precio Decimal (5,2) NOT NULL,
idRestaurant SMALLINT NOT NULL,
Disponible Boolean NOT NULL,
CantPlato TINYINT NOT NULL,
PRIMARY KEY (idPlato),
CONSTRAINT FK_Plato_Restaurant FOREIGN KEY (idRestaurant)
REFERENCES Restaurant (idRestaurant)
);

CREATE TABLE Pedido (
idPedido MEDIUMINT NOT NULL,
FechayHora DATETIME NOT NULL,
idRestaurant SMALLINT NOT NULL,
idNombreC VARCHAR(25) NOT NULL,
PrecioUnitario DECIMAL (5,2) NOT NULL,
CantPlato TINYINT NOT NULL,
Valoracion TINYINT,
Descripcion VARCHAR(45),
PRIMARY KEY (idPedido),
CONSTRAINT FK_Pedido_Restaurant FOREIGN KEY (idRestaurant)
REFERENCES Restaurant (idRestaurant)
);

CREATE TABLE Menuplato(
CantPlato TINYINT NOT NULL,
idPlato VARCHAR (25) NOT NULL,
idPedido MEDIUMINT NOT NULL,
PRIMARY KEY (idPlato, idPedido),
CONSTRAINT FK_MenuPlato_Plato FOREIGN KEY (idPlato)
REFERENCES Plato (idPlato),
CONSTRAINT FK_Menuplato_Pedido FOREIGN KEY (idPedido)
REFERENCES Pedido (idPedido)
);
