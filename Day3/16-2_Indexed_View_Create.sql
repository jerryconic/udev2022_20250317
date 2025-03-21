USE AdventureWorks2022;
GO

CREATE VIEW dbo.V1
WITH SCHEMABINDING
AS
SELECT  CUST.CustomerID ,
        PER.FirstName ,
        PER.LastName ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOH.[Status] ,
        SOD.ProductID ,
        PROD.Name ,
        SOD.OrderQty
FROM    Sales.SalesOrderHeader SOH
        INNER JOIN Sales.SalesOrderDetail SOD 
               ON SOH.SalesOrderID = SOD.SalesOrderID
        INNER JOIN Production.Product PROD
               ON PROD.ProductID = SOD.ProductID
        INNER JOIN Sales.Customer CUST
               ON SOH.CustomerID = CUST.CustomerID
        INNER JOIN Person.Person PER
               ON PER.BusinessEntityID = CUST.PersonID;
GO

CREATE UNIQUE CLUSTERED INDEX CX_V1 
ON dbo.V1(CustomerID, SalesOrderID, ProductID)
GO

EXEC sp_spaceused 'dbo.V1';
EXEC sp_spaceused 'HumanResources.vEmployee';
GO

SELECT * FROM dbo.V1;

--SELECT * FROM dbo.V1 WITH(NOEXPAND);

SELECT * FROM dbo.V1
WHERE CustomerID = 11000;
--0.0442532

SELECT * FROM dbo.V1 WITH(NOEXPAND)
WHERE CustomerID = 11000;
--0.0032908

SELECT CustomerID, FirstName, LastName, OrderDate
FROM dbo.V1
WHERE FirstName='Jon'


SELECT CustomerID, FirstName, LastName, OrderDate
FROM dbo.V1 WITH(NOEXPAND)
WHERE FirstName='Jon'
GO
CREATE NONCLUSTERED INDEX IX_FirstName 
ON dbo.V1(FirstName)
INCLUDE(LastName,OrderDate)

GO

SELECT CustomerID, FirstName, LastName, OrderDate
FROM dbo.V1 
WHERE FirstName='Jon'
GO
SELECT CustomerID, FirstName, LastName, OrderDate
FROM dbo.V1 WITH(NOEXPAND)
WHERE FirstName='Jon'
GO

CREATE VIEW dbo.V2
WITH SCHEMABINDING
AS

SELECT  CUST.CustomerID ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOD.ProductID ,
        PROD.Name ,
        SUM(SOD.OrderQty) AS TotalSpent,
		COUNT_BIG(*) AS CNT
FROM    Sales.SalesOrderHeader SOH
        INNER JOIN Sales.SalesOrderDetail SOD
               ON SOH.SalesOrderID = SOD.SalesOrderID
        INNER JOIN Production.Product PROD
               ON PROD.ProductID = SOD.ProductID
        INNER JOIN Sales.Customer CUST
               ON SOH.CustomerID = CUST.CustomerID
        INNER JOIN Person.Person PER
               ON PER.BusinessEntityID = CUST.PersonID
GROUP BY CUST.CustomerID ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOD.ProductID ,
        PROD.Name; 
GO

EXEC sp_spaceused 'dbo.V2';
GO

CREATE UNIQUE CLUSTERED INDEX CX_V2 
ON dbo.V2(CustomerID, SalesOrderID, ProductID)
GO

EXEC sp_spaceused 'dbo.V2';
