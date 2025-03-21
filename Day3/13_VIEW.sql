USE Northwind;

SELECT * FROM dbo.Employees;

SELECT EmployeeID, LastName + ' ' + FirstName, Title
FROM dbo.Employees
ORDER BY LastName;

GO

CREATE OR ALTER VIEW dbo.EmployeeInfo
AS
SELECT TOP(100) PERCENT
EmployeeID, LastName + ' ' + FirstName AS EmployeeName, Title
FROM dbo.Employees
ORDER BY LastName;
GO

SELECT * FROM dbo.EmployeeInfo;


EXEC sp_help 'dbo.EmployeeInfo';
EXEC sp_helptext 'dbo.EmployeeInfo';

GO
CREATE OR ALTER VIEW dbo.EmployeeInfo
--WITH ENCRYPTION
AS
SELECT TOP(100) PERCENT
EmployeeID, LastName + ' ' + FirstName AS EmployeeName, Title
FROM dbo.Employees
ORDER BY LastName;
GO


EXEC sp_help 'dbo.EmployeeInfo';
EXEC sp_helptext 'dbo.EmployeeInfo';

USE AdventureWorks2022;

SELECT * FROM sys.databases;
SELECT * FROM sys.schemas;
SELECT * FROM sys.tables;
SELECT * FROM sys.columns;
SELECT * FROM sys.objects;
SELECT * FROM sys.views;
SELECT * FROM sys.procedures;
SELECT * FROM sys.triggers;

SELECT SCHEMA_NAME(4);
SELECT OBJECT_NAME(3);
SELECT SCHEMA_ID('sys');
SELECT OBJECT_ID('sys.sysrscols');


--SQL 2005
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
SELECT * FROM INFORMATION_SCHEMA.VIEWS;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES;
SELECT * FROM INFORMATION_SCHEMA.SEQUENCES;

SELECT * FROM INFORMATION_SCHEMA.ROUTINE_COLUMNS
