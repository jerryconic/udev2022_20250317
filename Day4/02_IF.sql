USE Northwind;

DECLARE @n int = 50;
IF @n < 60
	PRINT 'C-Class';
ELSE IF @n < 80
	PRINT 'B-Class';
ELSE
	PRINT 'C-Class';
GO


DECLARE @name nvarchar(20);
SET @name= N'Nancy';
--SET @name= N'John';
--SET @name=NULL;

IF EXISTS(SELECT * FROM dbo.Employees 
	WHERE FirstName=@name)
	PRINT CONCAT('Yes,', @name, ' is here!');
ELSE
	PRINT CONCAT('No,', @name, ' is not here!');
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	PRINT 'ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE';
	PRINT 'DROP DATABASE db01';
END
ELSE
	PRINT 'db01 does not exist!';
GO



DECLARE @n int, @result nvarchar(20);
SET @n = 8;
IF @n < 5
	SET @result = N'Less than 5';
ELSE IF @n BETWEEN 5 AND 10
	SET @result = N'Between 5 and 10';
ELSE IF @n > 10
	SET @result = N'Greater than 10';
ELSE
	SEt @result = N'Unknown';
SELECT @n AS num, @result AS result;
GO

DECLARE @n int, @result nvarchar(20);
SET @n = 8;
SET @result = CASE 
WHEN @n < 5 THEN N'Less than 5'
WHEN @n BETWEEN 5 AND 10 THEN N'Between 5 and 10'
WHEN @n > 10 THEN N'Greater than 10'
ELSE N'Unknown'
END;
SELECT @n AS num, @result AS result;
GO