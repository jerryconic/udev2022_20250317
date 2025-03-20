USE Northwind;

SELECT OrderID, OrderDate,
	ROW_NUMBER() OVER (ORDER BY OrderID) AS rno
FROM dbo.Orders;

--CTE
WITH Ord
AS
(
SELECT OrderID, OrderDate,
	ROW_NUMBER() OVER (ORDER BY OrderID) AS rno
FROM dbo.Orders
)
SELECT * FROM Ord
WHERE rno BETWEEN 81 AND 100;

--Derived Table
SELECT * FROM (
SELECT OrderID, OrderDate,
	ROW_NUMBER() OVER (ORDER BY OrderID) AS rno
FROM dbo.Orders
) Ord
WHERE rno BETWEEN 81 AND 100;


SELECT CategoryID, ProductID, ProductName, UnitPrice,
RANK() OVER(ORDER BY UnitPrice DESC) AS rnk,
DENSE_RANK() OVER(ORDER BY UnitPrice DESC) AS d_rnk
FROM dbo.Products;

SELECT CategoryID, ProductID, ProductName, UnitPrice,
RANK() OVER(PARTITION BY CategoryID 
			ORDER BY UnitPrice DESC) AS rnk
FROM dbo.Products;


SELECT e.EmployeeID, e.FirstName, MONTH(o.OrderDate) AS mn,
SUM(od.Quantity*od.UnitPrice) AS Total,
RANK() OVER (PARTITION BY MONTH(o.OrderDate) 
			ORDER BY SUM(od.Quantity*od.UnitPrice) DESC) AS rnk
FROM dbo.Employees e
INNER JOIN dbo.Orders o	
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, MONTH(o.OrderDate);


WITH EmpTotal
AS
(
SELECT e.EmployeeID, e.FirstName, MONTH(o.OrderDate) AS mn,
SUM(od.Quantity*od.UnitPrice) AS Total,
RANK() OVER (PARTITION BY MONTH(o.OrderDate) 
			ORDER BY SUM(od.Quantity*od.UnitPrice) DESC) AS rnk
FROM dbo.Employees e
INNER JOIN dbo.Orders o	
	ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, MONTH(o.OrderDate)
)
SELECT * FROM EmpTotal 
WHERE rnk <= 3;

SELECT ProductID, ProductName, UnitPrice,
NTILE(5) OVER (ORDER BY UnitPrice) AS price_type
FROM dbo.Products;

------------------------------------------------

SELECT ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER (ORDER BY ProductID) AS Running_Total
FROM dbo.Products

SELECT ProductID, ProductName, UnitPrice,
(SELECT SUM(UnitPrice) FROM dbo.Products WHERE ProductID <= p.ProductID) AS Running_Total
FROM dbo.Products p

SELECT ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER (ORDER BY UnitPrice) AS Running_Total
FROM dbo.Products


SELECT ProductID, ProductName, UnitPrice,
SUM(UnitPrice) OVER (ORDER BY UnitPrice
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total
FROM dbo.Products;

SELECT ProductID, ProductName, UnitPrice,
AVG(UnitPrice) OVER (ORDER BY UnitPrice
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_Average
FROM dbo.Products;

--SQL 2022

USE Northwind;

WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  SUM(Quantity) OVER( PARTITION BY CustomerID
                 ORDER BY OrderDate, OrderID
                 ROWS UNBOUNDED PRECEDING ) AS RunsQuantity,
  SUM(Total) OVER( PARTITION BY CustomerID
                 ORDER BY OrderDate, OrderID
                 ROWS UNBOUNDED PRECEDING ) AS RunsTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
ORDER BY CustomerID, OrderDate, OrderID;

WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  SUM(Quantity) OVER W AS RunsQuantity,
  SUM(Total) OVER W AS RunsTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
WINDOW W AS 
( PARTITION BY CustomerID
  ORDER BY OrderDate, OrderID
  ROWS UNBOUNDED PRECEDING 
)
ORDER BY CustomerID, OrderDate, OrderID;

----------------------------------------------------


WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  ROW_NUMBER() OVER( PARTITION BY CustomerID
                     ORDER BY OrderDate, OrderID ) AS OrderNo,
  MAX(OrderDate) OVER( PARTITION BY CustomerID ) AS MaxOrderDate,
  SUM(Quantity) OVER( PARTITION BY CustomerID
                 ORDER BY OrderDate, OrderID
                 ROWS UNBOUNDED PRECEDING ) AS RunQuantity,
  SUM(Total) OVER( PARTITION BY CustomerID           
                 ORDER BY orderdate, orderid   
                 ROWS UNBOUNDED PRECEDING ) AS RunTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
ORDER BY CustomerID, OrderDate, OrderID;

WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  ROW_NUMBER() OVER PO AS PO_OrderNo,
  MAX(OrderDate) OVER P AS P_MaxOrderDate,
  SUM(Quantity) OVER POF AS POF_RunQuantity,
  SUM(Total) OVER POF AS POF_RunTotal
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
--WINDOW P AS (PARTITION BY CustomerID),
--PO AS (P Order BY OrderDate, OrderID),
--POF AS (PO ROWS UNBOUNDED PRECEDING)
WINDOW POF AS (PO ROWS UNBOUNDED PRECEDING),
PO AS (P Order BY OrderDate, OrderID),
P AS (PARTITION BY CustomerID)
ORDER BY CustomerID, OrderDate, OrderID;


WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
)
SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
  ROW_NUMBER() OVER (P ORDER BY CustomerID) AS PO_OrderNo,
  MAX(OrderDate) OVER P AS P_MaxOrderDate
FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
WINDOW P AS (PARTITION BY CustomerID)
ORDER BY CustomerID, OrderDate, OrderID;

SELECT 'This is valid'
WINDOW W1 AS (), W2 AS (W1), W3 AS (W2);

SELECT 'This is invalid'
WINDOW W1 AS (W2), W2 AS (W3), W3 AS (W1);


WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
),
C AS
(
  SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
    SUM(Quantity) OVER W AS RunSumQuantity
  FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
  WINDOW W AS ( PARTITION BY CustomerID
                ORDER BY OrderDate, OrderID
                ROWS UNBOUNDED PRECEDING )
)
SELECT *
    --,SUM(Quantity) OVER W AS RunSumQuantity97
FROM C
WHERE orderdate >= '1997-1-1';

WITH OrderValues AS
(
    SELECT o.OrderID, o.CustomerID, o.OrderDate, od.Quantity, od.Quantity * od.UnitPrice AS Total
    FROM dbo.Orders o
    INNER JOIN dbo.[Order Details] od
        ON o.OrderID = od.OrderID
),
C AS
(
  SELECT OrderID, CustomerID, OrderDate, Quantity, Total,
    SUM(Quantity) OVER W AS RunSumQuantity
  FROM OrderValues
WHERE CustomerID IN('ALFKI', 'ANATR')
  WINDOW W AS ( PARTITION BY CustomerID
                ORDER BY OrderDate, OrderID
                ROWS UNBOUNDED PRECEDING )
)
SELECT *
    ,SUM(Quantity) OVER W AS RunSumQuantity97
FROM C
WHERE orderdate >= '1997-1-1'
  WINDOW W AS ( PARTITION BY CustomerID
                ORDER BY OrderDate, OrderID
                ROWS UNBOUNDED PRECEDING )
;

-----------------------------------------
USE db01;

DROP TABLE IF EXISTS dbo.T1;

CREATE TABLE dbo.T1
(
  id INT NOT NULL CONSTRAINT PK_T1 PRIMARY KEY,
  col1 INT NULL,
  col2 INT NULL
);
GO

INSERT INTO dbo.T1(id, col1, col2) VALUES
  ( 2, NULL,  200),
  ( 3,   10, NULL),
  ( 5,   -1, NULL),
  ( 7, NULL,  202),
  (11, NULL,  150),
  (13,  -12,   50),
  (17, NULL,  180),
  (19, NULL,  170),
  (23, 1759, NULL);

  WITH C AS
(
  SELECT id, col1,
    MAX(CASE WHEN col1 IS NOT NULL THEN id END)
    --MAX(id)
      OVER(ORDER BY id
           ROWS UNBOUNDED PRECEDING) AS grp
  FROM dbo.T1
)
SELECT id, col1,
  MAX(col1) OVER(PARTITION BY grp
                 ORDER BY id
                 ROWS UNBOUNDED PRECEDING) AS lastknowncol1
FROM C;
GO

SELECT id, col1,
  LAST_VALUE(col1) IGNORE NULLS OVER( ORDER BY id ROWS UNBOUNDED PRECEDING ) AS lastknowncol
FROM dbo.T1;

SELECT id, 
  col1, LAST_VALUE(col1) IGNORE NULLS OVER W AS lastknowncol1,
  col2, LAST_VALUE(col2) IGNORE NULLS OVER W AS lastknowncol2
FROM dbo.T1
WINDOW W AS ( ORDER BY id ROWS UNBOUNDED PRECEDING );

SELECT id, col1, 
  LAG(col1) IGNORE NULLS OVER ( ORDER BY id ) AS prevknowncol1
FROM dbo.T1;

SELECT id, col1, 
  LAG(col1) RESPECT NULLS OVER ( ORDER BY id ) AS prevknowncol1
FROM dbo.T1;