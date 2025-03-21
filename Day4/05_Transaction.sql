USE master;
IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END
GO
CREATE DATABASE db01;
GO

USE db01;
CREATE TABLE dbo.Ord
(
ord_id int CONSTRAINT PK_Ord PRIMARY KEY,
ord_date date,
cust_id int
);

CREATE TABLE dbo.OrdDetail
(
ord_id int,
prdt_id int,
qty int,
CONSTRAINT PK_OrdDetail PRIMARY KEY(ord_id, prdt_id)
);
GO
----------------------------------------------------------------------------------
BEGIN TRY
	INSERT INTO dbo.Ord(ord_id, ord_date, cust_id)	VALUES(1, GETDATE(), 1);

	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 1, 100);
		--ERROR: Duplicate Key(1, 1)
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 1, 200);		
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 3, 300);
END TRY
BEGIN CATCH
	THROW;
	/*
	SELECT ERROR_NUMBER() AS err_no,
	ERROR_STATE() AS err_state,
	ERROR_SEVERITY() AS err_level,
	ERROR_LINE() AS err_line,
	ERROR_MESSAGE() AS err_message,
	ERROR_PROCEDURE() AS err_proc
	*/
END CATCH
GO

SELECT * FROM dbo.Ord;
SELECT * FROM dbo.OrdDetail;

DELETE FROM dbo.OrdDetail;
DELETE FROM dbo.Ord;


dbcc useroptions;
SET XACT_ABORT ON;
SELECT XACT_STATE();
BEGIN TRY
	BEGIN TRAN;
	INSERT INTO dbo.Ord(ord_id, ord_date, cust_id)	VALUES(1, GETDATE(), 1);

	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 1, 100);
		--ERROR: Duplicate Key(1, 1)
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 2, 200);		
	INSERT INTO dbo.OrdDetail(ord_id, prdt_id, qty) VALUES(1, 3, 300);
	COMMIT TRAN; --認可交易
END TRY
BEGIN CATCH
	--ROLLBACK TRAN;  --回復交易
	--THROW;
	SELECT 'Error';
END CATCH
GO

SELECT * FROM dbo.Ord;
SELECT * FROM dbo.OrdDetail;

DELETE FROM dbo.OrdDetail;
DELETE FROM dbo.Ord;

SELECT XACT_STATE();
SELECT @@TRANCOUNT;

BEGIN TRAN;
	SELECT @@TRANCOUNT;
	BEGIN TRAN;
		SELECT @@TRANCOUNT;
		BEGIN TRAN;
			SELECT @@TRANCOUNT;
			ROLLBACK TRAN;

		COMMIT TRAN;
		SELECT @@TRANCOUNT;
	COMMIT TRAN;
	SELECT @@TRANCOUNT;
COMMIT TRAN;
SELECT @@TRANCOUNT;