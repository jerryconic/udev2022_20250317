USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END



CREATE DATABASE [db01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db01', FILENAME = N'C:\SQLData\SQL2\db01.mdf' , SIZE = 8192KB , FILEGROWTH = 4096KB )
 LOG ON 
( NAME = N'db01_log', FILENAME = N'C:\SQLData\SQL2\db01_log.ldf' , SIZE = 8192KB , FILEGROWTH = 4096KB )
GO
-----------------------------------------------
USE db01;
CREATE TABLE dbo.BigTable
(
id int IDENTITY(1, 1) PRIMARY KEY,
big_data nchar(4000) DEFAULT ''
);
GO
SET STATISTICS IO ON;

INSERT INTO dbo.BigTable DEFAULT VALUES;
GO 4096
--4096 X 8KB = 32MB + 4MB = 36MB
SELECT 36 * 1024

SELECT * FROM dbo.BigTable
--Logical Read:4112(Pages)
--CPU:0.0046626 => 0.0046626
--IO:3.03646 => 0.0083102
GO


ALTER TABLE [dbo].[BigTable] REBUILD PARTITION = ALL
WITH(DATA_COMPRESSION = ROW) --ROW/PAGE/NONE

ALTER TABLE [dbo].[BigTable] REBUILD PARTITION = ALL
WITH(DATA_COMPRESSION = NONE) --ROW/PAGE/NONE

SELECT * FROM dbo.BigTable

SELECT * FROM dbo.BigTable
WHERE id = 10;

SELECT COUNT(*) FROM dbo.BigTable


USE [db01]
GO
DBCC SHRINKDATABASE(N'db01' )
GO

SET STATISTICS IO ON;

SELECT * FROM dbo.BigTable;

dbcc ind('db01', 'dbo.BigTable', -1);
dbcc traceon(3604)
dbcc page('db01', 1, 504, 1);
dbcc page('db01', 1, 488, 1);





ALTER TABLE [dbo].[BigTable] REBUILD PARTITION = ALL
WITH(DATA_COMPRESSION = NONE)

SELECT * FROM dbo.BigTable;

SELECT * FROM dbo.BigTable
WHERE id = 10;


SELECT COUNT(*) FROM dbo.BigTable


