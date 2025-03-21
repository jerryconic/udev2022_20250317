USE Northwind;
GO

CREATE OR ALTER PROC dbo.P1
AS
SELECT EmployeeID, FirstName + ' ' + LastName, Title
FROM dbo.Employees
ORDER BY Title
GO

EXEC dbo.P1;
EXEC dbo.P1;
/*
dbo.P1;
dbo.P1;
*/



EXEC sp_help 'dbo.Employees';
EXEC sp_helptext 'dbo.[Current Product List]';
EXEC sp_help 'dbo.P1';
EXEC sp_helptext 'dbo.P1';


EXEC sp_databases;
EXEC sp_tables  @table_owner='dbo';
EXEC sp_columns @table_owner='dbo', @table_name='%';
EXEC sp_columns @table_owner='dbo', @table_name='Employees';

EXEC sp_configure;

EXEC sp_refreshview 'dbo.[Current Product List]';

EXEC sp_updatestats;
GO

DROP PROC IF EXISTS dbo.P2;
GO
CREATE PROC dbo.P2
@yr int, @mn int
AS
SELECT OrderID, OrderDate, EmployeeID, CustomerID
FROM dbo.Orders
WHERE YEAR(OrderDate) = @yr
AND MONTH(OrderDate) = @mn
GO

EXEC dbo.P2 1997, 1;
EXEC dbo.P2 @yr = 1997, @mn = 2;
EXEC dbo.P2 @mn = 3, @yr = 1997;
EXEC dbo.P2 @yr = 1997;
GO


ALTER PROC dbo.P2
@yr int, @mn int = NULL
AS
SELECT OrderID, OrderDate, EmployeeID, CustomerID
FROM dbo.Orders
WHERE YEAR(OrderDate) = @yr
AND (MONTH(OrderDate) = @mn OR @mn IS NULL)
GO

EXEC dbo.P2 1997, 1;
EXEC dbo.P2 @yr = 1997, @mn = 2;
EXEC dbo.P2 @mn = 3, @yr = 1997;
EXEC dbo.P2 @yr = 1997;

GO


CREATE OR ALTER PROC dbo.P3
@yr int, @mn int = NULL, @eid int = NULL
AS
SELECT e.EmployeeID, e.FirstName,
	MONTH(o.OrderDate) AS Mn,
	SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Employees e
INNER JOIN dbo.Orders o	
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
	ON o.OrderID =od.OrderID
WHERE YEAR(o.OrderDate) = @yr
AND (MONTH(o.OrderDate) = @mn OR @mn IS NULL)
AND (e.EmployeeID = @eid OR @eid IS NULL)
GROUP BY e.EmployeeID, e.FirstName, MONTH(o.OrderDate)
ORDER BY Mn, e.EmployeeID
GO

EXEC dbo.P3 @yr=1997, @mn=1, @eid=1;
EXEC dbo.P3 @yr=1997, @mn=1;
EXEC dbo.P3 @yr=1997, @eid=1;
EXEC dbo.P3 @yr=1997;