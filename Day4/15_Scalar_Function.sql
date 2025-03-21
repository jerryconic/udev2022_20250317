USE Northwind;
GO

CREATE OR ALTER FUNCTION dbo.Fact(@n tinyint)
RETURNS decimal(38, 0)
AS
BEGIN
	DECLARE @result decimal(38, 0)=1, @i tinyint=1;
	WHILE @i <= @n
	BEGIN
		SET @result = @result * @i;
		SET @i = @i + 1;
	END	   
    RETURN @result;
END
GO

PRINT dbo.Fact(1)
PRINT dbo.Fact(2)
PRINT dbo.Fact(3)
PRINT dbo.Fact(4)

PRINT dbo.Fact(33)
PRINT dbo.Fact(34)
GO
DECLARE @i tinyint = 1;
WHILE @i <=33
BEGIN
	PRINT CONCAT(@i, '! =', dbo.Fact(@i));
	SET @i = @i + 1;
END
GO
