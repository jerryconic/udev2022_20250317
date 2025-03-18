USE db01;

DROP TABLE IF EXISTS dbo.Ord;
DROP TABLE IF EXISTS dbo.Emp;

CREATE TABLE dbo.Emp
(
emp_id int CONSTRAINT PK_Emp PRIMARY KEY,
emp_name nvarchar(20)
);

CREATE TABLE dbo.Ord
(
ord_id int CONSTRAINT PK_Ord PRIMARY KEY,
emp_id int,
amount int
);
-- Add Foreign Key
/*

	


ALTER TABLE dbo.Ord 
ADD CONSTRAINT FK_Ord_Emp 
FOREIGN KEY(emp_id) 
REFERENCES dbo.Emp(emp_id) 
	ON UPDATE NO ACTION 
	ON DELETE NO ACTION 
	
*/
ALTER TABLE dbo.Ord DROP CONSTRAINT FK_Ord_Emp;
GO
/*
ALTER TABLE dbo.Ord 
ADD CONSTRAINT FK_Ord_Emp 
FOREIGN KEY(emp_id) 
REFERENCES dbo.Emp(emp_id) 
	ON UPDATE NO ACTION 
	ON DELETE NO ACTION 
*/
ALTER TABLE dbo.Ord ADD CONSTRAINT FK_Ord_Emp 
FOREIGN KEY(emp_id) 
REFERENCES dbo.Emp(emp_id) 
	ON UPDATE CASCADE -- NO ACTION/CASCADE/SET NULL/SET DEFAULT
	ON DELETE SET NULL;
GO

INSERT INTO dbo.Emp(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Alice');

INSERT INTO dbo.Ord(ord_id, emp_id, amount)
VALUES(1, 1, 3000),(2, 2, 4000), (3, 2, 5000), (4, 3, 6000);

SELECT * FROM dbo.Emp;
SELECT * FROM dbo.Ord;
GO

INSERT INTO dbo.Emp(emp_id, emp_name) VALUES(4, 'Rookie');

INSERT INTO dbo.Ord(ord_id, emp_id, amount) VALUES(9, 99, 9999);

GO
SELECT * FROM dbo.Emp;
SELECT * FROM dbo.Ord;

SELECT * FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id

	
SELECT e.emp_id, e.emp_name, SUM(o.amount) AS total FROM dbo.Emp e INNER JOIN dbo.Ord o
	ON e.emp_id = o.emp_id
GROUP BY e.emp_id, e.emp_name;
GO

SELECT SUM(amount) FROM dbo.Ord WHERE emp_id IS NOT NULL;

UPDATE dbo.Emp SET emp_id = 11 WHERE emp_id = 1;

DELETE FROM dbo.Emp WHERE emp_id = 2;

SELECT * FROM dbo.Emp;
SELECT * FROM dbo.Ord;
