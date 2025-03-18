SET STATISTICS IO ON;

USE db01;
--Ctrl + Shift + R(重新載入資料庫的欄位結構到Intellisense的資料庫中)
SELECT * FROM dbo.Orders;

SELECT * FROM Northwind.dbo.Orders;

SELECT * FROM dbo.Orders
WHERE OrderID = 10400;

SELECT * FROM Northwind.dbo.Orders
WHERE OrderID = 10400;

dbcc ind('db01', 'dbo.Orders', -1);

dbcc traceon(3604);
dbcc page('db01', 1, 312, 3);

dbcc ind('Northwind', 'dbo.Orders', -1);


USE [db01]
GO
CREATE UNIQUE CLUSTERED INDEX CX_OrderID 
ON dbo.Orders(OrderID)
GO

SELECT * FROM dbo.Orders
WHERE OrderID = 10400;

SELECT * FROM Northwind.dbo.Orders
WHERE OrderID = 10400;

dbcc ind('db01', 'dbo.Orders', -1);

SELECT * FROM dbo.Orders
WHERE OrderDate = '1997-1-1';
GO

CREATE NONCLUSTERED INDEX IX_OrderDate 
ON dbo.Orders(OrderDate)


GO

SELECT * FROM dbo.Orders
WHERE OrderDate = '1997-1-1';
GO
SELECT * FROM dbo.Orders 
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';
GO

SELECT * FROM dbo.Orders WITH(INDEX(IX_OrderDate))
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';
GO

SELECT OrderID, OrderDate FROM dbo.Orders 
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';
GO


SELECT OrderID, OrderDate, CustomerID, EmployeeID FROM dbo.Orders 
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';
GO
GO

CREATE NONCLUSTERED INDEX IX_OrderDate
ON dbo.Orders(OrderDate)
INCLUDE(CustomerID,EmployeeID)
WITH (DROP_EXISTING = ON)

GO

SELECT OrderID, OrderDate, CustomerID, EmployeeID FROM dbo.Orders 
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-1-31';
GO
