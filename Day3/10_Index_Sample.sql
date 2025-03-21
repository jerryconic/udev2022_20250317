

USE db01;

SELECT * FROM dbo.Person
WHERE BusinessEntityID = 1001;


SELECT *
FROM dbo.Orders
WHERE OrderID = 10400

SELECT e.EmployeeID, e.FirstName,
	SUM(od.Quantity*od.UnitPrice) AS Total
FROM dbo.Employees e
INNER JOIN dbo.Orders o
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.OrderDetails od
	ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 1
GROUP BY e.EmployeeID, e.FirstName;
