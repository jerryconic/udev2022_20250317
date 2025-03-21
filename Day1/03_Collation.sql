USE db01;


DROP TABLE IF EXISTS dbo.Data1;

CREATE TABLE dbo.Data1
(
id int PRIMARY KEY,
name1 varchar(20) COLLATE Chinese_Taiwan_Stroke_CI_AS,
name2 varchar(20) COLLATE Latin1_General_CI_AS
);

INSERT INTO dbo.Data1(id, name1, name2) VALUES(1, 'John', 'John');

SELECT * FROM dbo.Data1;

SELECT * FROM dbo.Data1
WHERE name1 = name2;

SELECT * FROM dbo.Data1
WHERE name1 = name2 COLLATE Chinese_Taiwan_Stroke_CI_AS;

SELECT '中文字'
SELECT 'おはよう';

SELECT name, collation_name
FROM sys.databases;

SELECT COLLATIONPROPERTY('Chinese_Taiwan_Stroke_CI_AS', 'codepage');
--950 (Big-5)

/*
EXEC sp_who
kill 82
kill 71
*/
USE [master]
GO
ALTER DATABASE [db01] COLLATE Latin1_General_CI_AS 
GO

USE db01;

SELECT '中文字'


SELECT COLLATIONPROPERTY('Latin1_General_CI_AS', 'codepage');
--1252 (Ansi)

SELECT N'中文字' --65001, UNICODE

INSERT INTO dbo.Data1(id, name1, name2)
VALUES(2, '中文字', '中文字');

SELECT '中文字' 

SELECT * FROM dbo.Data1


INSERT INTO dbo.Data1(id, name1, name2)
VALUES(3, N'中文字', N'中文字');

SELECT * FROM dbo.Data1;

ALTER TABLE dbo.Data1
ALTER COLUMN name1 nvarchar(20)

ALTER TABLE dbo.Data1
ALTER COLUMN name2 nvarchar(20)

SELECT * FROM dbo.Data1;


INSERT INTO dbo.Data1(id, name1, name2)
VALUES(4, N'中文字', N'中文字');


SELECT * FROM dbo.Data1;

INSERT INTO dbo.Data1(id, name1, name2)
VALUES(5, N'おはよう', N'おはよう');


SELECT * FROM dbo.Data1;
