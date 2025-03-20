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
               ON PER.BusinessEntityID = CUST.PersonID

GO
SELECT * FROM dbo.V1;
EXEC sp_spaceused 'dbo.V1';

GO
CREATE UNIQUE CLUSTERED INDEX CX_V1 
ON dbo.V1(CustomerID ASC, SalesOrderID ASC, ProductID ASC)


GO

EXEC sp_spaceused 'dbo.V1';

SELECT * FROM dbo.V1;

SELECT * FROM dbo.V1 WITH(NOEXPAND);

SELECT * FROM dbo.V1
WHERE CustomerID = 29825;

SELECT * FROM dbo.V1 WITH(NOEXPAND)
WHERE CustomerID = 29825;

EXEC sp_spaceused 'dbo.V1'
GO
CREATE NONCLUSTERED INDEX IX_FirstName
ON dbo.V1(FirstName)
INCLUDE(LastName,OrderDate,Status,Name,OrderQty)


GO
EXEC sp_spaceused 'dbo.V1'

SELECT *
FROM dbo.V1 
WHERE FirstName = 'James';

SELECT *
FROM dbo.V1 WITH(NOEXPAND)
WHERE FirstName = 'James';