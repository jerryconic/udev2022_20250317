USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END


CREATE DATABASE [db01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db01', FILENAME = N'C:\SQLData\SQL2\db01.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'db01_log', FILENAME = N'C:\SQLData\SQL2\db01_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 --WITH LEDGER = OFF
GO


SELECT * FROM sys.databases;

GO
USE db01;
GO


BEGIN TRANSACTION
CREATE TABLE dbo.Customer
	(
	cust_id nchar(10) NOT NULL,
	cust_name nchar(10) NULL,
	addr nchar(10) NULL,
	phone nchar(10) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Customer ADD CONSTRAINT
	PK_Customer PRIMARY KEY CLUSTERED 
	(
	cust_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
