USE Northwind;
GO


CREATE OR ALTER FUNCTION dbo.StringTable(@s nvarchar(max))
RETURNS @tbl TABLE(ch nchar(1))
AS
BEGIN
	DECLARE @i int = 1;
	WHILE @i<=LEN(@s)
	BEGIN
		INSERT INTO @tbl(ch) VALUES(SUBSTRING(@s, @i, 1));
		SET @i = @i + 1;
	END
    RETURN 
END
GO

SELECT * FROM dbo.StringTable('Hello world!');
