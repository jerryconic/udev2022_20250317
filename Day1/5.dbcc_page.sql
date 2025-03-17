USE Northwind;

SELECT * FROM dbo.Employees;

dbcc ind('Northwind', 'dbo.Employees', -1);

dbcc traceon(3604);
dbcc page('Northwind', 1, 584, 0) --Header Only
dbcc page('Northwind', 1, 584, 1) --Dump by row(Summary)
dbcc page('Northwind', 1, 584, 2) --Dump by page
dbcc page('Northwind', 1, 584, 3) --Dump by row(Detail)

