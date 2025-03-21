USE tempdb;

CREATE TABLE dbo.Document
(
id int PRIMARY KEY,
doc xml
);

USE tempdb

GO

CREATE PRIMARY XML INDEX pxi_doc 
ON dbo.Document(doc)

GO

USE tempdb

GO

CREATE XML INDEX SXI_doc_Path ON dbo.Document(doc)
USING XML INDEX pxi_doc FOR PATH 
GO
CREATE XML INDEX SXI_doc_Property ON dbo.Document(doc)
USING XML INDEX pxi_doc FOR PROPERTY
GO
CREATE XML INDEX SXI_doc_Value ON dbo.Document(doc)
USING XML INDEX pxi_doc FOR VALUE
GO


