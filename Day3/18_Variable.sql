USE Northwind;

DECLARE @n int;
SET @n = 50;
PRINT @n;
SELECT @n AS num;
GO

DECLARE @n1 int, @n2 int;
SELECT @n1=10, @n2=20;
SELECT @n1 AS num_1, @n2 AS num_2,
	@n1 + @n2 AS sum_n1_n2
PRINT @n1 + @n2;
GO

DECLARE @f_name nvarchar(30), @l_name nvarchar(30);
SELECT @f_name = FirstName, @l_name = Lastname
FROM dbo.Employees
WHERE EmployeeID = 5;

SELECT @f_name AS f_name, @l_name AS l_name;
GO

DECLARE @total AS decimal(10, 2);
SET @total = (SELECT SUM(UnitPrice)
	FROM dbo.Products);
PRINT CONCAT('Total=', @total);
GO

DECLARE @tbl AS TABLE
(
id int IDENTITY(1, 1) PRIMARY KEY,
data nvarchar(50)
)
INSERT INTO @tbl(data)
VALUES('AAA'), ('BBB'), ('CCC'), ('DDD');

SELECT * FROM @tbl;
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
