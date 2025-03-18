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
 --WITH LEDGER = OFF
GO

USE db01;

CREATE TABLE dbo.BigOrder
(
id int IDENTITY(1, 1) PRIMARY KEY,
big_data nchar(4000)
);
GO--8011 bytes

INSERT INTO dbo.BigOrder DEFAULT VALUES;
GO 4096 -- = 4 * 1024
--4 * 1024 * 8KB = 4 * 8MB = 32MB => 36MB = 36864

SELECT 36 * 1024

dbcc loginfo

UPDATE dbo.BigOrder SET big_data = 'AAA'

DELETE FROM dbo.BigOrder

dbcc loginfo

DBCC SHRINKDATABASE(N'db01' )
GO
