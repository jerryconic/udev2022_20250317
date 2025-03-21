USE db01
/*
--刪除dbo.Person上所有的Index
DROP INDEX CX_BusinessEntityID ON dbo.Person WITH ( ONLINE = OFF )
DROP INDEX IX_FirstName_LastName ON dbo.Person
GO
*/



EXEC sp_spaceused 'dbo.Person'


CREATE UNIQUE CLUSTERED INDEX CX_BusinessEntityID 
ON dbo.Person(BusinessEntityID)


CREATE NONCLUSTERED INDEX IX_FirstName_LastName 
ON dbo.Person(FirstName ASC, LastName ASC)
INCLUDE(MiddleName) 

GO
CREATE NONCLUSTERED INDEX [IX_FirstName_Coverying] ON [dbo].[Person]
(
	[FirstName] ASC
)
INCLUDE([PersonType],[NameStyle],[Title],[MiddleName],[LastName],[Suffix],[EmailPromotion],[AdditionalContactInfo],[Demographics],[rowguid],[ModifiedDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO


/*
name	rows	 reserved		data		index_size		unused
Person	19972    22,424 KB		22,032 KB	  	 72 KB		320 KB  --RAW Data
Person	19972    22,936 KB		22,032 KB		136 KB		768 KB  --Clustered Index
Person	19,972   24,000 KB		22,032 KB	  1,016 KB	    952 KB  --Nonclustered Index INCLUDE(MiddleName)
Person	19,972   46,856 KB		22,032 KB    23,328 KB	  1,496 KB  --Nonclustered Index Coverying
*/