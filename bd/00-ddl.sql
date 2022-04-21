CREATE DATABASE IF NOT EXISTS Gastronomia;

Create table Gastronomia.Plato
idPlato Varchar(25) NOT NULL
Descripcion Varchar(45) NOT NULL
Precio DECIMAL(5,2) NOT NULL
Restaurant Varchar(25) NOT NULL
Disponible Boolean NOT NULL
Primary key (idPlato)
CONSTRAINT FK_Restaurant FOREIGN KEY (Restaurant);

Create Table Gastronomia.Restaurant
idRestaurant SMALLINT NOT NULL
Email Varchar(25) NOT NULL
Domicilio VARCHAR(25) NOT NULL
Contrasena CHAR(N) NOT NULL
PRIMARY KEY (idRestaurant);

Create table Gastronomia.Pedido
idPedido MEDIUMINT NOT NULL
FechaYHora DATETIME NOT NULL
Restaurant VARCHAR(25) NOT NULL
Cliente VARCHAR(25) NOT NULL
Plato INT NOT NULL
PrecioUnitario DECIMAL(5,2) NOT NULL
CantPlato VARCHAR(25) NOT NULL
PRIMARY KEY (idPedido)
CONSTRAINT FK_Cliente FOREIGN KEY Cliente
CONSTRAINT FK_Plato FOREIGN KEY Plato;

Create Table Gastronomia.Cantidad
CantPlato VARCHAR (25) NOT NULL;

Create Table Gastronomia.Cliente
NombreC VARCHAR(25) NOT NULL
Apellido VARCHAR(25) NOT NULL
EmailCliente VARCHAR (45) NOT NULL
ContrasenaC Char(N) NOT NULL
PRIMARY KEY (NombreC);

