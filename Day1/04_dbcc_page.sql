
dbcc ind('AdventureWorks2022', 'Person.Person', -1);

dbcc traceon(3604);
dbcc page('AdventureWorks2022', 1, 1304, 0);  --Header Only
dbcc page('AdventureWorks2022', 1, 1304, 1);  --Dump by row
dbcc page('AdventureWorks2022', 1, 1304, 2);  --Dump by page
dbcc page('AdventureWorks2022', 1, 1304, 3);  --Dump detail

USE AdventureWorks2022;
SELECT * FROM Person.Person