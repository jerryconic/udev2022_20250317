SELECT SERVERPROPERTY('Collation')

SELECT name, collation_name FROM sys.databases;

SELECT TABLE_SCHEMA + '.' + TABLE_NAME AS Table_name, DATA_TYPE, COLLATION_NAME
FROM INFORMATION_SCHEMA.COLUMNS

USE AdventureWorks;
SELECT '����r';
SELECT N'����r';

USE db01;
SELECT '����r';