USE [AdventureWorks2022]
GO
/****** Object:  Index [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID]    Script Date: 2025/3/19 ¤U¤È 01:25:57 ******/
ALTER TABLE [Person].[PersonPhone] DROP CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] WITH ( ONLINE = OFF )
ALTER TABLE [Person].[PersonPhone] DROP CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID]
ALTER TABLE [Person].[PersonPhone] DROP CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID]
GO
DROP INDEX [IX_PersonPhone_PhoneNumber] ON [Person].[PersonPhone]
GO
CREATE CLUSTERED COLUMNSTORE INDEX CCI_PersonPhone ON Person.PersonPhone 
DROP INDEX [CCI_PersonPhone] ON [Person].[PersonPhone]
GO


EXEC sp_spaceused 'Person.PersonPhone'
SELECT * FROM Person.PersonPhone;

/*
name				rows	reserved	data		index_size	unused
PersonPhone			19972   1480 KB		1464 KB		8 KB		8 KB
PersonPhone			19972	392 KB		296 KB		0 KB		96 KB
*/

EXEC sp_spaceused 'Person.Person'

/*
name	rows	reserved	data		index_size	unused
Person	19972   85032 KB	30496 KB	52640 KB	1896 KB
Person	19972   85296 KB	30496 KB	52768 KB	2032 KB
*/


CREATE NONCLUSTERED COLUMNSTORE INDEX [NCCI_Person] ON [Person].[Person]
(
	[BusinessEntityID],
	[PersonType],
	[Title],
	[Suffix],
	[EmailPromotion],
	[ModifiedDate]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)

GO


