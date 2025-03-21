USE Northwind;

GO

CREATE FUNCTION dbo.Top3Order(@yr int, @mn int, @eid int)
RETURNS TABLE AS RETURN
(
    SELECT TOP(3) OrderID, OrderDate, CustomerID
	FROM dbo.Orders
	WHERE YEAR(OrderDate) = @yr AND MONTH(OrderID) = @mn AND EmployeeID = @eid
	ORDER BY OrderID DESC
)
GO

SELECT * FROM dbo.Top3Order(1997, 1, 1);
SELECT * FROM dbo.Top3Order(1997, 1, 2);
SELECT * FROM dbo.Top3Order(1997, 1, 3);

SELECT * FROM dbo.Top3Order(1997, 1, 1) t
INNER JOIN dbo.Customers c 
	ON t.CustomerID = c.CustomerID
