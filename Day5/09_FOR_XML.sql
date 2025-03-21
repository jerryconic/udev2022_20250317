USE Northwind;

SELECT CustomerID, CompanyName
FROM dbo.Customers AS Customer
FOR XML AUTO;

SELECT CustomerID, CompanyName
FROM dbo.Customers AS Customer
FOR XML RAW('Customer');


SELECT CustomerID, CompanyName
FROM dbo.Customers AS Customer
FOR XML AUTO, ROOT('Customers');

SELECT CustomerID, CompanyName
FROM dbo.Customers AS Customer
FOR XML RAW('Customer'), ROOT('Customers');


SELECT CustomerID, CompanyName
FROM dbo.Customers AS Customer
FOR XML AUTO, ROOT('Customers'), ELEMENTS;

SELECT CustomerID, CompanyName
FROM dbo.Customers AS Customer
FOR XML RAW('Customer'), ROOT('Customers'), ELEMENTS;

-----------------------------------


SELECT Customer.CustomerID AS CustomerID, 
	Customer.CompanyName AS CompanyName,
	SalesOrder.OrderID AS OrderID, 
	SalesOrder.OrderDate AS OrderDate
FROM dbo.Customers AS Customer
INNER JOIN dbo.Orders AS SalesOrder
	ON Customer.CustomerID = SalesOrder.CustomerID
ORDER BY CustomerID, OrderID
FOR XML AUTO, ROOT('Customers');

SELECT Customer.CustomerID AS CustomerID, 
	Customer.CompanyName AS CompanyName,
	SalesOrder.OrderID AS OrderID, 
	SalesOrder.OrderDate AS OrderDate
FROM dbo.Customers AS Customer
INNER JOIN dbo.Orders AS SalesOrder
	ON Customer.CustomerID = SalesOrder.CustomerID
ORDER BY CustomerID, OrderID
FOR XML RAW('Customer'), ROOT('Customers');


SELECT SalesOrder.OrderID AS OrderID, 
	SalesOrder.OrderDate AS OrderDate,
	Customer.CustomerID AS CustomerID, 
	Customer.CompanyName AS CompanyName
FROM dbo.Customers AS Customer
INNER JOIN dbo.Orders AS SalesOrder
	ON Customer.CustomerID = SalesOrder.CustomerID
ORDER BY CustomerID, OrderID
FOR XML AUTO, ROOT('Customers'), XMLSCHEMA;

SELECT Customer.CustomerID AS CustomerID, 
	Customer.CompanyName AS CompanyName,
	SalesOrder.OrderID AS OrderID, 
	SalesOrder.OrderDate AS OrderDate
FROM dbo.Customers AS Customer
INNER JOIN dbo.Orders AS SalesOrder
	ON Customer.CustomerID = SalesOrder.CustomerID
ORDER BY OrderID, CustomerID
FOR XML AUTO, ROOT('Customers');

---------------------------

SELECT ProductName, UnitPrice
FROM dbo.Products
FOR XML PATH('a');

SELECT ProductName, UnitPrice
FROM dbo.Products
FOR XML PATH('');

SELECT ProductID
FROM dbo.[Order Details]
WHERE OrderID = 10248
FOR XML PATH('');


SELECT CONCAT(ProductID, ',')
FROM dbo.[Order Details]
WHERE OrderID = 10248
FOR XML PATH('');


SELECT OrderID, OrderDate,
(
SELECT CONCAT(ProductID, ',')
FROM dbo.[Order Details]
WHERE OrderID = o.OrderID
FOR XML PATH('')
) AS Details
FROM dbo.Orders o
WHERE OrderDate BETWEEN '1997-1-1' AND' 1997-1-5' 