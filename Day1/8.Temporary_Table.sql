--�ϰ�ʼȦs��ƪ�(Local Temporary Table)

CREATE TABLE #tmp
(
id int PRIMARY KEY,
data nvarchar(20)
);


INSERT INTO #tmp(id, data)
VALUES(1, 'aaa');

SELECT * FROM #tmp;

DROP TABLE #tmp;
-------------------

CREATE TABLE ##tmp
(
id int PRIMARY KEY,
data nvarchar(20)
);


INSERT INTO ##tmp(id, data)
VALUES(1, 'aaa');

SELECT * FROM ##tmp;

-------------------

CREATE TABLE tempdb.dbo.tmp
(
id int PRIMARY KEY,
data nvarchar(20)
);

INSERT INTO tempdb.dbo.tmp(id, data) VALUES(1, 'aaa');

SELECT * FROM tempdb.dbo.tmp;