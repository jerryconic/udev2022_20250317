USE db01;

CREATE TABLE dbo.Score
(
id int PRIMARY KEY,
c1 smallint,
c2 smallint,
c3 smallint
);


INSERT INTO dbo.Score(id, c1, c2, c3)
VALUES(1, 90, 80, 70),
(2, 100, 60, 80),
(3, 50, 70, 70);

SELECT * FROM dbo.Score;

ALTER TABLE dbo.Score
ADD total smallint;

SELECT * FROM dbo.Score;

UPDATE dbo.Score
SET total = c1 + c2 + c3;

SELECT * FROM dbo.Score;

UPDATE dbo.Score
SET c1 = 60
WHERE id = 1;

SELECT * FROM dbo.Score;

GO

ALTER TABLE dbo.Score
DROP COLUMN total;

GO

ALTER TABLE dbo.Score
ADD total AS c1 + c2 + c3 PERSISTED;

SELECT * FROM dbo.Score;

UPDATE dbo.Score
SET c3 = 0;

SELECT * FROM dbo.Score;

INSERT INTO dbo.Score(id, c1, c2, c3)
VALUES(4, 100, 100, 100);

SELECT * FROM dbo.Score;
