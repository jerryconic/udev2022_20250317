/*
DROP DATABASE IF EXISTS db01;
CREATE DATABASE db01;
*/

USE db01;

DROP TABLE IF EXISTS dbo.Employee;

CREATE TABLE dbo.Employee
(
emp_id int PRIMARY KEY,
emp_name nvarchar(20),
birth_date date,
salary decimal(10, 2)
);
GO

ALTER TABLE dbo.Employee 
ADD	mobile nvarchar(10),
	address nvarchar(100)
GO

SELECT * FROM sys.columns
WHERE object_id = object_id('dbo.Employee')

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Employee' 

EXEC sp_help 'dbo.Employee' 

GO
ALTER TABLE dbo.Employee
DROP COLUMN mobile, address
GO

ALTER TABLE dbo.Employee
ALTER COLUMN emp_name nvarchar(30)
GO


DROP TABLE IF EXISTS dbo.Employee;