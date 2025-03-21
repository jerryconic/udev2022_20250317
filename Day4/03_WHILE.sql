USE Northwind;

DECLARE @n int = 1;

WHILE @n <= 10
BEGIN
	--IF @n = 5 BREAK;
	--IF ... CONTINUE;
	PRINT @n;
	SET @n = @n + 1;
	
END;
GO

DECLARE @tbl AS TABLE(id int);
DECLARE @n int = 1;

WHILE @n <= 10
BEGIN
	INSERT INTO @tbl VALUES(@n);
	SET @n = @n + 1;	
END;
SELECT * FROM @tbl;
GO

DECLARE @tbl AS TABLE(dt date)
DECLARE @d1 date = DATEFROMPARTS(1997, 1, 1);--SQL 2012
DECLARE @d2 date = EOMONTH(@d1); --SQL 2012
DECLARE @d date = @d1;
WHILE @d <= @d2
BEGIN
	INSERT INTO @tbl(dt) VALUES(@d);
	SET @d = DATEADD(DAY, 1, @d);
END
SELECT * FROM @tbl;
GO

SELECT o.OrderDate, SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Orders o
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1997-1-1' AND '1997-1-31'
GROUP BY o.OrderDate
ORDER BY o.OrderDate
GO

CREATE OR ALTER PROC dbo.DailyReport
@yr int, @mn int
AS
SET NOCOUNT ON;
DECLARE @tbl AS TABLE(dt date)
DECLARE @d1 date = DATEFROMPARTS(@yr, @mn, 1);--SQL 2012
DECLARE @d2 date = EOMONTH(@d1); --SQL 2012
DECLARE @d date = @d1;
WHILE @d <= @d2
BEGIN
	INSERT INTO @tbl(dt) VALUES(@d);
	SET @d = DATEADD(DAY, 1, @d);
END;
WITH Ord--CTE(Common Table Expression:SQL 2005)
AS
(
SELECT o.OrderDate, SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Orders o
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN @d1 AND @d2
GROUP BY o.OrderDate
)
SELECT t.dt, ISNULL(o.Total, 0) AS Total
FROM @tbl t
LEFT JOIN Ord o
	ON t.dt = o.OrderDate
ORDER BY t.dt;
GO

EXEC dbo.DailyReport @yr=1997, @mn=1;
EXEC dbo.DailyReport @yr=1997, @mn=2;