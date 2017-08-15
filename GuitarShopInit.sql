USE master
GO

DROP DATABASE IF EXISTS [GuitarShop] 
GO

CREATE DATABASE [GuitarShop]
GO

USE [GuitarShop]
GO

CREATE TABLE [GuitarShop].[dbo].[Warehouse] 
(  
    id INT  PRIMARY KEY NOT NULL IDENTITY (1,1),
	Color VARCHAR(100) NOT NULL,
	Price FLOAT NOT NULL,
	Brand VARCHAR(100) NOT NULL,
	MadeIn VARCHAR(100) NOT NULL 
);
GO

INSERT INTO [GuitarShop].[dbo].[Warehouse]
VALUES
	('Red', 250.0, 'Ibanez', 'Japan'),
	('Light Red', 350.0, 'Fender', 'Mexico'),
	('Dark Red', 250.0, 'Ibanez', 'Japan'),
	('Blue', 450.0, 'Fender', 'Mexico'),
	('Yellow', 600.0, 'Ibanez', 'Japan'),
	('Green', 700.0, 'Fender', 'Mexico'),
	('Black', 500.0, 'ESP','USA'),
	('White', 700.0, 'ESP','USA'),
	('Brown', 500.0, 'Warwick','Germany');



