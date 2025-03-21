SET STATISTICS IO ON;

USE db01;

SELECT * FROM dbo.Person
WHERE BusinessEntityID = 1001;

GO

CREATE UNIQUE CLUSTERED INDEX CX_BusinessEntityID 
ON dbo.Person(BusinessEntityID)


GO


SELECT * FROM dbo.Person WITH(INDEX(0))
WHERE BusinessEntityID = 1001;

SELECT * FROM dbo.Person
WHERE BusinessEntityID = 1001;

SELECT * FROM dbo.Person
WHERE FirstName = 'Ken';

GO
CREATE NONCLUSTERED INDEX IX_FirstName 
ON dbo.Person(FirstName)
GO

SELECT * FROM dbo.Person
WHERE FirstName = 'Ken';


SELECT BusinessEntityID, FirstName
FROM dbo.Person
WHERE FirstName = 'Ken';


SELECT BusinessEntityID, FirstName,
MiddleName, LastName, Title
FROM dbo.Person
WHERE FirstName = 'Ken';
GO

CREATE NONCLUSTERED INDEX IX_FirstName 
ON dbo.Person(FirstName)
INCLUDE(Title,MiddleName,LastName) 
WITH (DROP_EXISTING = ON)

GO


SELECT BusinessEntityID, FirstName,
MiddleName, LastName, Title
FROM dbo.Person
WHERE FirstName = 'Ken';
GO

DROP INDEX IX_FirstName ON dbo.Person
GO


SELECT BusinessEntityID, FirstName,
MiddleName, LastName, Title
FROM dbo.Person
WHERE FirstName = 'Ken' AND LastName = 'Myer';
GO

CREATE NONCLUSTERED INDEX IX_FirstName_LastName 
ON dbo.Person(FirstName ASC,LastName ASC)
INCLUDE(Title,MiddleName)

GO

SELECT BusinessEntityID, FirstName,
MiddleName, LastName, Title
FROM dbo.Person
WHERE FirstName = 'Ken' AND LastName = 'Myer';

SELECT TOP(10) *
FROM dbo.Person
ORDER BY FirstName ASC, LastName ASC

SELECT TOP(10) *
FROM dbo.Person
ORDER BY FirstName DESC, LastName DESC

SELECT TOP(10) *
FROM dbo.Person
ORDER BY FirstName ASC, LastName DESC
SELECT TOP(10) *
FROM dbo.Person
ORDER BY FirstName DESC, LastName ASC