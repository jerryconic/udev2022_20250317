
USE db01;

DROP TABLE IF EXISTS dbo.CardBalance;
DROP TABLE IF EXISTS dbo.CardTran;
GO

--卡片餘額
CREATE TABLE dbo.CardBalance
(
card_id int PRIMARY KEY,
amount int
);

--卡片異動紀錄
CREATE TABLE dbo.CardTran
(
id int PRIMARY KEY IDENTITY(1,1),
card_id int ,
tran_amount int,
tran_type tinyint, --1: Stored Value, 2: Payed value
tran_datetime datetime DEFAULT GETDATE()
);
GO

CREATE OR ALTER TRIGGER dbo.trgCheckCardUpdateDelete
ON dbo.CardTran
INSTEAD OF UPDATE, DELETE
AS
THROW 50000, N'Cannot UPDATE, DELETE dbo.CardTran',  1;
GO


CREATE OR ALTER TRIGGER dbo.trgCheckCard
ON dbo.CardTran
INSTEAD OF INSERT
AS
SET NOCOUNT ON;
DECLARE @tbltotal AS TABLE(card_id int, total int);
WITH tran_total
AS
(
SELECT card_id, tran_amount  FROM inserted WHERE tran_type = 1
UNION ALL
SELECT card_id, -tran_amount  FROM inserted WHERE tran_type = 2
UNION ALL
SELECT card_id, amount FROM dbo.CardBalance WHERE card_id IN (SELECT card_id FROM inserted)
)
INSERT INTO @tbltotal(card_id, total)
SELECT card_id, SUM(tran_amount) FROM tran_total GROUP BY card_id;

IF EXISTS(SELECT * FROM @tbltotal
	WHERE total < 0)
	THROW 50001, 'insufficient balance', 1;
ELSE
BEGIN
	INSERT INTO CardTran(card_id, tran_amount, tran_type)
	SELECT card_id, tran_amount, tran_type FROM inserted;

	UPDATE CardBalance
	SET amount =  t.total
	FROM CardBalance c
	INNER JOIN @tbltotal t ON c.card_id = t.card_id	
END

GO
----------------------------------------------------------------------
--Test
INSERT INTO dbo.CardBalance(card_id, amount)
VALUES(1, 0), (2, 0), (3, 0);

SELECT * FROM dbo.CardBalance;
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(1, 100, 1); -- Card No.1 加值 100

SELECT * FROM dbo.CardBalance;
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(1, 50, 2); -- Card No.1 扣款 50



SELECT * FROM dbo.CardBalance;
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO


INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(1, 80, 2); -- Card No.1 扣款 80 (餘額不足)

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(1, 50, 1); -- Card No.1 加值 50

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(2, 100, 1); -- Card No.2 加值 100

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(1, 100, 2); -- Card No.1 扣款 100

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(2, 100, 1); -- Card No.2 加值 100

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(2, 100, 2);  -- Card No.2 扣款 100

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(2, 100, 2);  -- Card No.2 扣款 100

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO

INSERT INTO dbo.CardTran(card_id, tran_amount, tran_type)
VALUES(2, 100, 2); -- Card No.2 扣款 100(餘額不足)

SELECT * FROM dbo.CardBalance
SELECT id, card_id, tran_amount, tran_type, tran_datetime,
CASE tran_type WHEN 1 THEN N'加值' WHEN 2 THEN N'扣款' END AS tran_type_desc FROM dbo.CardTran;
GO