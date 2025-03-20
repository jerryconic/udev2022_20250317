USE Northwind;
GO

DECLARE @sql nvarchar(1000);
SET @sql = N'SELECT * FROM dbo.Employees';
EXECUTE(@sql);
GO

--SQL Injection
DECLARE @sql nvarchar(1000), @name nvarchar(100);
--SET @name = N'Nancy';
--SET @name = N'xxx'' OR 1=1;--';
SET @name = N'xxx'';SELECT * FROM dbo.Products;--';

SET @sql = N'SELECT * FROM dbo.Employees
			 WHERE FirstName = N''' + @name + '''';
EXECUTE(@sql);
PRINT @sql;
GO

DECLARE @sql nvarchar(1000), @name nvarchar(100);
SET @sql = N'SELECT * FROM dbo.Employees
			 WHERE FirstName = @FirstName';
SET @name = N'Nancy';
--SET @name = N'xxx'' OR 1=1;--';
--SET @name = N'xxx'';SELECT * FROM dbo.Products;--';

EXEC sp_executesql @statement = @sql,
	@params = N'@FirstName nvarchar(30)',
	@FirstName = @name;
GO

--Test From C#
--Nancy
--AAA
--AAA' OR 1=1;--
--aaa';UPDATE dbo.Products SET UnitPrice = 0 WHERE ProductID = 1;--

SELECT * FROM dbo.Products;

UPDATE dbo.Products SET UnitPrice = 37 WHERE ProductID = 1