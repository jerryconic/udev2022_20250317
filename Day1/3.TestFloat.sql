USE db01;

DROP TABLE IF EXISTS dbo.TestFloat;

CREATE TABLE dbo.TestFloat
(
n1 real,
n2 float, 
n3 decimal(6, 2)
);
GO

INSERT INTO dbo.TestFloat(n1, n2, n3) VALUES(0.1, 0.1, 0.1)
GO 1000

SELECT * FROM dbo.TestFloat;

SELECT SUM(n1), SUM(n2), SUM(n3) 
FROM dbo.TestFloat;