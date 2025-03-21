USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END

CREATE DATABASE db01;
GO

USE db01;

CREATE TABLE dbo.Employee
(
emp_id int IDENTITY(1, 1) PRIMARY KEY,
emp_name nvarchar(20)
);

GO

CREATE TRIGGER dbo.trgEmployee
   ON  dbo.Employee
   AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM inserted;
	SELECT * FROM deleted;
END
GO

INSERT INTO dbo.Employee(emp_name)
VALUES('John'), ('Peter'), ('Linda'), ('Alice');

UPDATE dbo.Employee SET emp_name = 'XXX';

DELETE FROM dbo.Employee;
TRUNCATE TABLE dbo.Employee;
GO

ENABLE TRIGGER dbo.trgEmployee ON dbo.Employee;
DISABLE TRIGGER dbo.trgEmployee ON dbo.Employee;


--DROP TRIGGER dbo.trgEmployee

SELECT * FROM sys.triggers;

USE AdventureWorks2022
SELECT SCHEMA_NAME(o.schema_id) + '.' + o.name AS table_name, 
SCHEMA_NAME(o.schema_id) + '.' + t.name AS trigger_name, t.* FROM sys.triggers t
INNER JOIN sys.objects o
	ON t.parent_id = o.object_id

SELECT CONCAT('EXEC sp_helptext ''', 
SCHEMA_NAME(o.schema_id) + '.' + t.name, '''') FROM sys.triggers t
INNER JOIN sys.objects o
	ON t.parent_id = o.object_id

EXEC sp_helptext 'dbo.trgEmployee'

EXEC sp_helptext 'Sales.iduSalesOrderDetail'
EXEC sp_helptext 'Sales.uSalesOrderHeader'
EXEC sp_helptext 'Purchasing.dVendor'
EXEC sp_helptext 'Production.iWorkOrder'
EXEC sp_helptext 'Production.uWorkOrder'
EXEC sp_helptext 'HumanResources.dEmployee'
EXEC sp_helptext 'Person.iuPerson'
EXEC sp_helptext 'Purchasing.iPurchaseOrderDetail'
EXEC sp_helptext 'Purchasing.uPurchaseOrderDetail'
EXEC sp_helptext 'Purchasing.uPurchaseOrderHeader'

USE db01;

CREATE TABLE dbo.EmployeeHistory
(
emp_id int,
emp_name nvarchar(20),
add_datetime datetime DEFAULT GETDATE()
);

GO
CREATE TRIGGER dbo.trgEmployeeLog
   ON  dbo.Employee
   AFTER DELETE, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.EmployeeHistory(emp_id, emp_name)
	SELECT emp_id, emp_name FROM deleted;
END
GO


INSERT INTO dbo.Employee(emp_name)
VALUES('John'), ('Peter'), ('Linda'), ('Alice');

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

UPDATE dbo.Employee SET emp_name = 'XXX';

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

DELETE FROM dbo.Employee;
TRUNCATE TABLE dbo.Employee;
TRUNCATE TABLE dbo.EmployeeHistory;

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

DISABLE TRIGGER dbo.trgEmployeeLog ON dbo.Employee;
GO

CREATE TRIGGER dbo.trgEmployeeForbidden
   ON  dbo.Employee
   AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM inserted WHERE emp_name LIKE '%admin%')
		ROLLBACK;
END
GO
INSERT INTO dbo.Employee(emp_name)
VALUES('John'), ('Peter'), ('Linda'), ('Alice');

INSERT INTO dbo.Employee(emp_name)
VALUES('admin')

INSERT INTO dbo.Employee(emp_name)
VALUES('Nick'),('admin'),('Tom');

UPDATE dbo.Employee
SET emp_name = 'admin' 
WHERE emp_name = 'Peter';

INSERT INTO dbo.Employee(emp_name)
VALUES('John'), ('Peter'), ('Linda'), ('Alice');

SELECT * FROM dbo.Employee;

DISABLE TRIGGER dbo.trgEmployeeForbidden ON dbo.Employee
GO


CREATE OR ALTER TRIGGER dbo.trgEmployeeInstead
   ON  dbo.Employee
   INSTEAD OF INSERT, UPDATE, DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM inserted;
	SELECT * FROM deleted;
END
GO

DISABLE TRIGGER dbo.trgEmployeeInstead ON dbo.Employee;

ENABLE TRIGGER dbo.trgEmployeeInstead ON dbo.Employee;

SELECT * FROM dbo.Employee

INSERT INTO dbo.Employee(emp_name)
VALUES('Nick'),('admin'),('Tom');

UPDATE dbo.Employee
SET emp_name = 'xxx' 

DELETE FROM dbo.Employee;

TRUNCATE TABLE dbo.Employee