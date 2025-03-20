USE Northwind;

SELECT 1;
SELECT 2;
SELECT 3 / 0;
SELECT 4;
SELECT 5;
GO

SELECT * FROM sys.messages;
SELECT * FROM sys.messages
WHERE message_id = 8134;

SELECT * FROM sys.syslanguages
SET LANGUAGE N'Traditional Chinese';
SET LANGUAGE N'English';
GO
SELECT 1;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 2;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 3 / 0;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 4;
IF @@ERROR <> 0 GOTO errHandler;

SELECT 5;
IF @@ERROR <> 0 GOTO errHandler;
RETURN;

errHandler:
	SELECT 'Error';

GO

BEGIN TRY
	SELECT 1;
	SELECT 2;
	SELECT 3 / 0;
	SELECT 4;
	SELECT 5;
END TRY
BEGIN CATCH 
	SELECT ERROR_NUMBER() AS err_no,
	ERROR_STATE() AS err_state,
	ERROR_SEVERITY() AS err_level,
	ERROR_LINE() AS err_line,
	ERROR_MESSAGE() AS err_message,
	ERROR_PROCEDURE() AS err_proc
END CATCH