USE db01;

CREATE TABLE dbo.Employee
(
employee_id int PRIMARY KEY,
employee_name nvarchar(20),
birth_date date,
salary int
);

ALTER TABLE dbo.Employee 
ADD	phone varchar(20),
	mobile varchar(20)

ALTER TABLE dbo.Employee
ALTER COLUMN phone varchar(30);

ALTER TABLE dbo.Employee
ALTER COLUMN mobile varchar(30);

ALTER TABLE dbo.Employee
DROP COLUMN phone, mobile

DROP TABLE IF EXISTS dbo.Employee;