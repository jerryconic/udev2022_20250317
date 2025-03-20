USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END

CREATE DATABASE db01;
GO

USE db01;


SELECT *
INTO dbo.Products
FROM Northwind.dbo.Products;

SELECT *
INTO dbo.Customers
FROM Northwind.dbo.Customers;

SELECT *
INTO dbo.Orders
FROM Northwind.dbo.Orders;

SELECT *
INTO dbo.OrderDetails
FROM Northwind.dbo.[Order Details];

SELECT *
INTO dbo.Employees
FROM Northwind.dbo.Employees;

GO

CREATE TABLE dbo.Person
(
	BusinessEntityID int NOT NULL,
	PersonType nchar(2) NOT NULL,
	NameStyle nvarchar(50) NOT NULL,
	Title nvarchar(8),
	FirstName nvarchar(50) NOT NULL,
	MiddleName nvarchar(50),
	LastName nvarchar(50) NOT NULL,
	Suffix nvarchar(10),
	EmailPromotion int NOT NULL,
	AdditionalContactInfo xml,
	Demographics xml,
	rowguid uniqueidentifier ROWGUIDCOL  NOT NULL,
	ModifiedDate datetime NOT NULL
 ) 
GO


INSERT INTO dbo.Person(BusinessEntityID ,PersonType ,NameStyle ,Title ,FirstName ,MiddleName,
LastName, Suffix, EmailPromotion, AdditionalContactInfo, Demographics, rowguid, ModifiedDate)
SELECT BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName,
LastName, Suffix, EmailPromotion, AdditionalContactInfo, Demographics, rowguid, ModifiedDate
FROM AdventureWorks2022.Person.Person

GO
