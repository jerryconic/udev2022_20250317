USE db01;

DROP TABLE IF EXISTS dbo.TestDF
GO

CREATE TABLE dbo.TestDF
(
id int IDENTITY(1, 1) CONSTRAINT PK_TestDF PRIMARY KEY,
num1 int,
num2 int DEFAULT 0
);

INSERT INTO dbo.TestDF(num1, num2)
VALUES(10, 10);
SELECT * FROM dbo.TestDF;


INSERT INTO dbo.TestDF(num1)
VALUES(10);
SELECT * FROM dbo.TestDF;

INSERT INTO dbo.TestDF(num2)
VALUES(10);
SELECT * FROM dbo.TestDF;

INSERT INTO dbo.TestDF(num1, num2)
VALUES(DEFAULT, DEFAULT);
SELECT * FROM dbo.TestDF;

INSERT INTO dbo.TestDF DEFAULT VALUES;
SELECT * FROM dbo.TestDF;

GO

DROP TABLE IF EXISTS dbo.DataLog;

CREATE TABLE dbo.DataLog
(
id int IDENTITY(1, 1) CONSTRAINT PK_DataLog PRIMARY KEY,
data_log nvarchar(20),
add_time datetime DEFAULT GETDATE()
);

GO

INSERT INTO dbo.DataLog(data_log) VALUES(N'�}��');

WAITFOR DELAY '0:0:10';

INSERT INTO dbo.DataLog(data_log) VALUES(N'����');

SELECT * FROM dbo.DataLog;
