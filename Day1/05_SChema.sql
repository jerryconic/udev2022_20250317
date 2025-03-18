USE [db01]
GO
CREATE SCHEMA [HR]
GO
CREATE TABLE HR.Employee
	(
	id int PRIMARY KEY,
	name nvarchar(20)
	)  
GO

INSERT INTO HR.Employee(id, name) VALUES(1, 'AAA');

SELECT * FROM HR.Employee;