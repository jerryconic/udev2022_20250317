SET STATISTICS IO ON;

USE AdventureWorks2022;

SELECT * FROM Person.Person;
/*
page

Table 'Person'. Scan count 1, logical reads 3818, physical reads 2, page server reads 0, read-ahead reads 3856,
page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, 
lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
*/


SELECT * FROM Person.Person;
/*
Table 'Person'. Scan count 1, logical reads 3818, physical reads 0, page server reads 0, read-ahead reads 0, 
page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, 
lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
*/