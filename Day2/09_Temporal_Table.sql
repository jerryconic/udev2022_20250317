USE master;

IF EXISTS(SELECT * FROM sys.databases WHERE name='db01')
BEGIN
	ALTER DATABASE db01 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE db01;
END

CREATE DATABASE db01;
GO

USE db01;
GO


--Create system-versioned temporal table. It must have primary key and two datetime2 columns that are part of SYSTEM_TIME period definition
CREATE TABLE dbo.Employee
(
    emp_id int PRIMARY KEY,
	emp_name nvarchar(20),
    --Period columns and PERIOD FOR SYSTEM_TIME definition
    s_time datetime2 GENERATED ALWAYS AS ROW START,
    e_time datetime2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME(s_time, e_time)
)
WITH
(
    SYSTEM_VERSIONING = ON 
    (HISTORY_TABLE = dbo.EmployeeHistory)
)
GO

INSERT INTO dbo.Employee(emp_id, emp_name)
VALUES(1, 'John'), (2, 'Peter'), (3, 'Linda'), (4, 'Alice');

SELECT * FROM dbo.Employee;
SELECT emp_id, emp_name, SWITCHOFFSET(s_time, '+08:00') AS s_time, e_time FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

--Wait 10 Secs
WAITFOR DELAY '0:0:10';

UPDATE dbo.Employee
SET emp_name = 'Nick'
WHERE emp_id = 3;

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

SELECT emp_id, emp_name, SWITCHOFFSET(s_time, '+08:00') AS s_time, e_time FROM dbo.Employee;
SELECT emp_id, emp_name, SWITCHOFFSET(s_time, '+08:00') AS s_time, 
	SWITCHOFFSET(e_time, '+08:00') AS e_time FROM dbo.EmployeeHistory;

WAITFOR DELAY '0:0:10';

DELETE FROM dbo.Employee
WHERE emp_id = 4;

SELECT * FROM dbo.Employee;
SELECT * FROM dbo.EmployeeHistory;

SELECT emp_id, emp_name, SWITCHOFFSET(s_time, '+08:00') AS s_time, e_time FROM dbo.Employee;
SELECT emp_id, emp_name, SWITCHOFFSET(s_time, '+08:00') AS s_time, 
	SWITCHOFFSET(e_time, '+08:00') AS e_time FROM dbo.EmployeeHistory;

--@t1 = '2025-03-18 05:36:36.0755277'
--@t2 = '2025-03-18 05:39:17.8792047'
--@t3 = '2025-03-18 05:42:26.8390452'
DECLARE @t1 datetime2, @t2 datetime2, @t3 datetime2
SET @t1 = (SELECT s_time FROM dbo.Employee WHERE emp_id = 1);
SET @t2 = (SELECT s_time FROM dbo.Employee WHERE emp_id = 3);
SET @t3 = (SELECT e_time FROM dbo.EmployeeHistory WHERE emp_id = 4);
SELECT @t1, @t2, @t3;
SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF @t1
SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF @t2
SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF @t3

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF '2025-03-18 05:36:36.0755277'

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF '2025-03-18 05:39:17.8792047'

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME AS OF '2025-03-18 05:42:26.8390452'

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME ALL;

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME CONTAINED IN('2025-03-18 05:36:36.0755277', '2025-03-18 05:39:17.8792047')

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME FROM '2025-03-18 05:36:36.0755277' TO '2025-03-18 05:39:17.8792047'

SELECT * FROM dbo.Employee
FOR SYSTEM_TIME BETWEEN '2025-03-18 05:36:36.0755277' AND '2025-03-18 05:39:17.8792047'


---------------
DELETE FROM dbo.EmployeeHistory
DROP TABLE dbo.Employee;
DROP TABLE dbo.EmployeeHistory;

ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING=OFF);

ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING=ON(HISTORY_TABLE=dbo.EmployeeHistory))

ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING=OFF);

ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING=ON(HISTORY_TABLE=dbo.EmployeeHistory2))
