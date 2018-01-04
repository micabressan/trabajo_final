------------lab6--------------
USE master;
GO

IF DB_ID ('SecondDB') IS NOT NULL
    DROP DATABASE SecondDB;
GO

CREATE DATABASE SecondDB
 ON (NAME = SecondDB_Primary, FILENAME = '/home/lab6/seconddb.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5%)
    LOG ON (NAME = SecondDB_Log, FILENAME = '/home/lab6/secondlog.ldf', SIZE = 5, MAXSIZE = 25, FILEGROWTH = 5)
GO

USE SecondDB
GO

--Создать таблицу с автоинкрементным первичным ключом

--уникальность свойства IDENTITY гарантирована только в рамках таблицы, в которой оно использовано;
--таблица может содержать только один столбец со свойством IDENTITY;
CREATE SCHEMA FirstSchema
    CREATE TABLE FirstTable(
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    phone CHAR(11) NULL,
    email VARCHAR(50) NOT NULL,
    date DATETIME NOT NULL,
        age INT NOT NULL,
        city VARCHAR(30)
)
GO
/*
--возвращает последнее значение идентификатора, созданного для таблицы
--значение идентификатора может относиться к любому сеансу и любой области
SELECT IDENT_CURRENT('FirstTable') AS [IDENT_CURRENT]
--возвращает последнее значение идентификатора, вставленного
--в любую таблицу в текущем сеансе по всем областям действий
SELECT @@IDENTITY AS [IDENTITY]
--возвращает последнее значение идентификатора, вставленного
--в любую таблицу в текущем сеансе в той же области
SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY]
GO

--Функция IDENT_CURRENT не ограничена областью действия и сеансом, но ограничена указанной таблицей;
--Функция @@IDENTITY ограничена текущим сеансом;
--Функция ыSCOPE_IDENTITY ограничена текущим сеансом и областью действия.
--Под областью подразумевается хранимая процедура, триггер или пакет

INSERT INTO FirstSchema.FirstTable VALUES ('8900000000', 'db@yandex.ru', GETDATE(), 20, 'Berlin')
INSERT INTO FirstSchema.FirstTable VALUES ('8900000001', 'db1@yandex.ru', GETDATE(), 36, 'Rome')
GO

SELECT IDENT_CURRENT('FirstTable') AS [IDENT_CURRENT]
SELECT @@IDENTITY AS [IDENTITY]
SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY]
GO

DROP TABLE FirstSchema.FirstTable
SELECT IDENT_CURRENT('FirstTable') AS [IDENT_CURRENT]
SELECT @@IDENTITY AS [IDENTITY]
SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY]
GO
*/

--Добавить поля, для которых используются ограничения (CHECK), значения по умолчанию (DEFAULT),
ALTER TABLE FirstSchema.FirstTable ADD CONSTRAINT CK_date CHECK (date > CONVERT(DATETIME, '01-09-2010', 105))
ALTER TABLE FirstSchema.FirstTable ADD CONSTRAINT CK_Person CHECK (age >= 18 AND City ='Moscow');
ALTER TABLE FirstSchema.FirstTable ADD CONSTRAINT DFLT_date DEFAULT GETDATE() FOR date;
GO

INSERT INTO FirstSchema.FirstTable (phone, email, age, city) VALUES (89992001010, 'e@mail.ru', 18, 'Moscow')
INSERT INTO FirstSchema.FirstTable VALUES (89992001011, 'e@mail.ru', CONVERT(DATETIME, '01-09-2017', 105), 18, 'Moscow')
INSERT INTO FirstSchema.FirstTable VALUES (89992001018, 'p@mail.ru', CONVERT(DATETIME, '01-09-2017', 105), 20, 'Moscow')
INSERT INTO FirstSchema.FirstTable VALUES (89992001015, 'u@mail.ru', CONVERT(DATETIME, '01-09-2014', 105), 23, 'Moscow')
INSERT INTO FirstSchema.FirstTable VALUES (89992001017, 'o@mail.ru', CONVERT(DATETIME, '01-09-2015', 105), 22, 'Moscow')
--INSERT INTO FirstSchema.FirstTable VALUES (89992001012, 'r@mail.ru', CONVERT(DATETIME, '01-09-2009', 105), 30, 'Bolshevo')
--INSERT INTO FirstSchema.FirstTable VALUES (89992001013, 't@mail.ru', CONVERT(DATETIME, '01-09-2015', 105), 42, 'Mytischi')
--INSERT INTO FirstSchema.FirstTable VALUES (89992001014, 'y@mail.ru', CONVERT(DATETIME, '01-09-2014', 105), 17, 'Shelkovo')
--INSERT INTO FirstSchema.FirstTable VALUES (89992001016, 'i@mail.ru', CONVERT(DATETIME, '01-09-2012', 105), 50, 'Himki')
GO

--Создать таблицу с первичным ключом на основе глобального уникального идентификатора

--уникальный для всей базы данных или всех баз данных во всех компьютерных сетях
CREATE TABLE FirstSchema.UniqueTable (
    workID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    workName VARCHAR(25) NULL
)
GO

INSERT INTO FirstSchema.UniqueTable (workName) VALUES ('Nature');
INSERT INTO FirstSchema.UniqueTable VALUES (NEWID(), 'Sea');

--Создать таблицу с первичным ключом на основе последовательности

--Sequence – генерирует последовательность чисел так же как и identity.
--последовательность не зависит от какой-либо конкретной таблицы
--В системах баз данных последовательности применяют для автоматической генерации PK

CREATE TABLE FirstSchema.SecondTable
(
    customerID INT NOT NULL PRIMARY KEY,
    customerName VARCHAR(25) NOT NULL,
    numberOfWorks INT NULL
)
GO

CREATE TABLE FirstSchema.ThirdTable
(
    customerID1 INT NOT NULL PRIMARY KEY,
    customerName1 VARCHAR(25) NOT NULL,
    numberOfWorks1 INT NULL
)
GO

--сквозная нумерация
CREATE SEQUENCE FirstSequence
START WITH 1
INCREMENT BY 1;
GO

INSERT FirstSchema.SecondTable (customerID, customerName, numberOfWorks)
        VALUES (NEXT VALUE FOR FirstSequence, 'Ivanov', 2)
INSERT FirstSchema.ThirdTable (customerID1, customerName1, numberOfWorks1)
        VALUES (NEXT VALUE FOR FirstSequence, 'Sidorov', 8)
INSERT FirstSchema.SecondTable (customerID, customerName, numberOfWorks)
        VALUES (NEXT VALUE FOR FirstSequence, 'Popov', 1)
GO

--Создать две связанные таблицы
CREATE TABLE FirstSchema.TableWithPK
(
    purchaseID INT PRIMARY KEY IDENTITY NOT NULL,
    quantity INT NOT NULL,
    seller VARCHAR(25) NOT NULL
)
GO

INSERT INTO FirstSchema.TableWithPK VALUES (100, 'Ivan');
INSERT INTO FirstSchema.TableWithPK VALUES (200, 'Petr');
INSERT INTO FirstSchema.TableWithPK VALUES (300, 'Ivan');
INSERT INTO FirstSchema.TableWithPK VALUES (300, 'Ivan');
INSERT INTO FirstSchema.TableWithPK VALUES (900, 'Anna');
INSERT INTO FirstSchema.TableWithPK VALUES (600, 'Petr');


CREATE TABLE FirstSchema.TableWithFK(
  productID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
  productName VARCHAR(30) NOT NULL,
  manufacturer VARCHAR(30) NOT NULL,
  purchaseID INT NULL,
        CONSTRAINT configs FOREIGN KEY (purchaseID) REFERENCES FirstSchema.TableWithPK (purchaseID)
      --выдает ошибку
        --ON DELETE NO ACTION
        --проставлет null
    ON DELETE SET NULL
    --ON DELETE SET DEFAULT
        --удаляет строку
    --ON DELETE CASCADE
)
GO

INSERT INTO FirstSchema.TableWithFK VALUES ('Product1', 'Russia', 1);
INSERT INTO FirstSchema.TableWithFK VALUES ('Product2', 'China', 2);
INSERT INTO FirstSchema.TableWithFK VALUES ('Product2', 'Russia', 3);
INSERT INTO FirstSchema.TableWithFK VALUES ('Product3', 'Italy', 4);
GO

DELETE FirstSchema.TableWithPK WHERE purchaseID = 4
GO

-------------------lab7---------------
CREATE VIEW FirstSchema.FirstView WITH SCHEMABINDING AS
    SELECT o.id, o.phone, o.email, o.date, o.age, o.city
    FROM FirstSchema.FirstTable o
    WHERE age > 19
    WITH CHECK OPTION
GO

--2----создать представление на основе полей обеих связанных таблиц задания 6
CREATE VIEW FirstSchema.SecondView AS
    SELECT a.purchaseID, a.quantity, a.seller, b.manufacturer, b.productID, b.productName
    FROM FirstSchema.TableWithPK a RIGHT JOIN FirstSchema.TableWithFK b
        ON a.purchaseID = b.purchaseID
    --WITH CHECK OPTION
GO

CREATE INDEX FirstIndex ON FirstSchema.FirstTable (email, phone)
    INCLUDE (age)
    GO

CREATE UNIQUE CLUSTERED INDEX SecondIndex ON FirstSchema.FirstView (age)
    GO

SELECT * FROM FirstSchema.FirstView

--------lab8---------------
USE master
GO

IF DB_ID ('MyDB') IS NOT NULL
	DROP DATABASE MyDB;
GO

CREATE DATABASE MyDB
 ON (NAME = MyDB_Primary, FILENAME = '/home/lab6/mydb.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5%)
    LOG ON (NAME = MyDB_Log, FILENAME = '/home/lab6/mydblog.ldf', SIZE = 5, MAXSIZE = 25, FILEGROWTH = 5)
GO

--Создать хранимую процедуру, производящую выборку из некоторой
--таблицы и возвращающую результат выборки в виде курсора.

USE MyDB
GO

CREATE SCHEMA FirstSchema
	CREATE TABLE Customer (
    id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    phone CHAR(11) NULL,
    email VARCHAR(50) NOT NULL,
		name NVARCHAR(25) NOT NULL,
		surname NVARCHAR(25) NOT NULL,
		patronymic VARCHAR(25) NULL,
		city NVARCHAR(30) NOT NULL,
		age INT NOT NULL,
)
GO

INSERT INTO FirstSchema.Customer VALUES (89992001011, 'a@mail.ru', 'Ivan', 'Petrov', 'Ivanovich', 'Moscow', 18)
INSERT INTO FirstSchema.Customer VALUES (89992001012, 'b@mail.ru', 'Nickolay', 'Kotov', '', 'Petersburg', 19)
INSERT INTO FirstSchema.Customer VALUES (89992001013, 'c@mail.ru', 'Vladimir', 'Popov', 'Ivanovich', 'Petersburg', 20)
INSERT INTO FirstSchema.Customer VALUES (89992001014, 'd@mail.ru', 'Anna', 'Eliseeva', 'Olegovna', 'Moscow', 27)
INSERT INTO FirstSchema.Customer VALUES (89992001015, 'e@mail.ru', 'Ivan', 'Ivanov', 'Ivanovich', 'Kazan', 20)
GO

--DECLARE — выполняет объявление явного курсора.
--OPEN — открывает курсор, создавая новый результирующий набор на базе указанного запроса.
--FETCH — выполняет последовательное извлечение строк из результирующего набора от начала до конца.
--CLOSE — закрывает курсор и освобождает занимаемые им ресурсы.

--Опция OUTPUT указывает, что параметр процедуры является возвращаемым, и с его помощью можно возвратить значение
-- из хранимой процедуры вызывающей процедуре или системе.

--@cursor_rows -- параметр процедуры типа cursor
--Опция OUTPUT указывает, что параметр процедуры является возвращаемым, и с его помощью можно возвратить значение из
-- хранимой процедуры вызывающей процедуре или системе.


-- Курсорыявляются расширением результирующих наборов, которые предоставляют механизм, позволяющий
-- обрабатывать одну строку

--функции всегда возвращают одно значение.


CREATE PROCEDURE FirstSchema.get_data @cursor_rows CURSOR VARYING OUTPUT
	AS SET @cursor_rows = CURSOR SCROLL
		FOR SELECT name, surname FROM Customer
	OPEN @cursor_rows
GO

--Хранимая процедура выполняется посредством инструкции EXECUTE пользователем
--Вызов процедуры и вывод на печать данных из выходного курсора
DECLARE @my_cur1 CURSOR
EXEC FirstSchema.get_data @cursor_rows = @my_cur1 OUTPUT
--при попытке запросить состояние строки, удаленной после открытия курсора,
--функция @@FETCH_STATUS возвращает состояние "строка отсутствует“
FETCH NEXT FROM @my_cur1
WHILE (@@FETCH_STATUS = 0)
		FETCH NEXT FROM @my_cur1
CLOSE @my_cur1
DEALLOCATE @my_cur1;
GO

--Модифицировать хранимую процедуру п.1. таким образом, чтобы выборка осуществлялась с формированием столбца,
--значение которого формируется пользовательской функцией

CREATE FUNCTION FirstSchema.create_id (@city VARCHAR(30)) RETURNS int
	AS
		BEGIN
			DECLARE @res int;
			SET @res = 0;
			IF (@city = 'Moscow')
				SET @res = 1
			IF (@city = 'Petersburg')
				SET @res = 2
			IF (@city = 'Kazan')
				SET @res = 3
			RETURN @res
		END
GO


ALTER PROCEDURE FirstSchema.get_data @cursor_rows CURSOR VARYING OUTPUT
	AS SET @cursor_rows = CURSOR
		FOR SELECT name, surname, FirstSchema.create_id(city) AS cityId FROM Customer
	OPEN @cursor_rows
GO

DECLARE @my_cur1 CURSOR
EXEC FirstSchema.get_data @cursor_rows = @my_cur1 OUTPUT
FETCH NEXT FROM @my_cur1
WHILE (@@FETCH_STATUS = 0)
		FETCH NEXT FROM @my_cur1
CLOSE @my_cur1
DEALLOCATE @my_cur1;
GO

--Создать хранимую процедуру, вызывающую процедуру п.1., осуществляющую прокрутку возвращаемого курсора
--и выводящую сообщения, сформированные из записей при выполнении условия, заданного еще одной пользовательской функцией.

CREATE FUNCTION FirstSchema.condition (@age INT, @patronymic VARCHAR(25)) RETURNS int
	AS
		BEGIN
			DECLARE @res INT
			SET @res = 0
			IF (@age <= 20) AND (@patronymic != '')
			SET @res = 1
			RETURN @res
		END
GO

ALTER PROCEDURE FirstSchema.get_data @cursor_rows CURSOR VARYING OUTPUT
	AS SET @cursor_rows = CURSOR SCROLL
		FOR SELECT name, surname, age, patronymic FROM Customer
	OPEN @cursor_rows
GO

CREATE PROCEDURE FirstSchema.scroll_data
		AS
			DECLARE @cursor CURSOR
			DECLARE @name VARCHAR(25)
			DECLARE @surname VARCHAR(25)
			DECLARE @age INT
			DECLARE @patronymic VARCHAR(25)

			EXEC FirstSchema.get_data @cursor_rows = @cursor OUTPUT
			FETCH LAST FROM @cursor INTO @name, @surname, @age, @patronymic
			WHILE (@@FETCH_STATUS = 0)
				BEGIN
					IF (FirstSchema.condition(@age, @patronymic) = 1)
						PRINT @name + ' ' + @surname + ' ' + CAST(@age AS NVARCHAR)+ ' ' + @patronymic;

						FETCH PRIOR FROM @cursor INTO @name, @surname, @age, @patronymic
				END
			CLOSE @cursor
			DEALLOCATE @cursor
GO

EXEC FirstSchema.scroll_data
GO

--Модифицировать хранимую процедуру п.2. таким образом, чтобы выборка формировалась с помощью табличной функции

--inline
CREATE FUNCTION FirstSchema.create_id1 () RETURNS TABLE
AS RETURN (
		SELECT name, surname, FirstSchema.create_id(FirstSchema.Customer.city) AS city FROM Customer
	)
GO

--not inline
CREATE FUNCTION FirstSchema.create_id2 () RETURNS @T TABLE (name VARCHAR(30), surname VARCHAR(30), id int)
	AS BEGIN WITH res(name, surname, id)
		AS (SELECT name, surname, FirstSchema.create_id(FirstSchema.Customer.city) AS city FROM Customer)
		INSERT @T SELECT name, surname, id FROM res
		RETURN
END
GO

ALTER PROCEDURE FirstSchema.get_data @cursor_rows CURSOR VARYING OUTPUT
 AS SET @cursor_rows = CURSOR
		FOR SELECT * FROM FirstSchema.create_id2()
	OPEN @cursor_rows
GO

DECLARE @my_cur3 CURSOR
EXEC FirstSchema.get_data @cursor_rows = @my_cur3 OUTPUT
FETCH NEXT FROM @my_cur3
WHILE (@@FETCH_STATUS = 0)
		FETCH NEXT FROM @my_cur3
CLOSE @my_cur3
DEALLOCATE @my_cur3;
GO


---------------------lab9----------------------------
--Для одной из таблиц пункта 2 задания 7 создать триггеры на вставку, удаление и добавление,
--при выполнении заданных условий один из триггеров должен инициировать возникновение ошибки (RAISERROR / THROW).

USE SecondDB
GO

CREATE TRIGGER insert_trigger
	ON SecondDB.FirstSchema.TableWithPK
	AFTER INSERT
		AS PRINT 'inserted'
GO

CREATE TRIGGER update_trigger
	ON SecondDB.FirstSchema.TableWithPK
	AFTER UPDATE
		AS PRINT 'updated'
GO

CREATE TRIGGER delete_trigger
	ON SecondDB.FirstSchema.TableWithPK
	INSTEAD OF DELETE AS
		BEGIN
			IF ((SELECT purchaseID FROM deleted WHERE purchaseID % 2 = 0) IS NOT NULL )
					RAISERROR ('Can not delete from TableWithPK', 11, 1)
			ELSE DELETE FROM FirstSchema.TableWithPK WHERE purchaseID IN (SELECT purchaseID FROM deleted)
		END
GO


INSERT INTO FirstSchema.TableWithPK VALUES (7, 'Nick');
UPDATE FirstSchema.TableWithPK SET TableWithPK.quantity = 0 WHERE seller = 'Petr'

DELETE FirstSchema.TableWithPK WHERE purchaseID = 1
DELETE FirstSchema.TableWithPK WHERE purchaseID = 6
DELETE FirstSchema.TableWithPK WHERE purchaseID = 5
DELETE FirstSchema.TableWithPK WHERE purchaseID = 2
GO

--Для представления пункта 2 задания 7 создать триггеры на вставку, удаление и добавление, обеспечивающие
--возможность выполнения операций с данными непосредственно через представление.

--CREATE TABLE FirstSchema.TableWithPK
--(
--   purchaseID INT PRIMARY KEY IDENTITY NOT NULL,
--   quantity INT NOT NULL,
--   seller VARCHAR(25) NOT NULL
--)

--CREATE TABLE FirstSchema.TableWithFK(
--  productID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--  productName VARCHAR(30) NOT NULL,
--  manufacturer VARCHAR(30) NOT NULL,
--  purchaseID INT NULL,
--        CONSTRAINT configs FOREIGN KEY (purchaseID) REFERENCES FirstSchema.TableWithPK (purchaseID)
--    ON DELETE SET NULL
--)


--CREATE VIEW FirstSchema.SecondView AS
--SELECT a.purchaseID, a.quantity, a.seller, b.manufacturer, b.productID, b.productName
--FROM FirstSchema.TableWithPK a RIGHT JOIN FirstSchema.TableWithFK b
--    ON a.purchaseID = b.purchaseID
--WITH CHECK OPTION

CREATE TRIGGER view_insert_trigger
	ON SecondDB.FirstSchema.SecondView
	INSTEAD OF INSERT
		AS BEGIN
			SELECT * FROM inserted
			INSERT FirstSchema.TableWithPK (quantity, seller)
				SELECT quantity, seller FROM inserted
			INSERT FirstSchema.TableWithFK (productName, manufacturer, purchaseID)
				SELECT productName, manufacturer, SCOPE_IDENTITY() FROM inserted
END

INSERT INTO FirstSchema.SecondView (quantity, seller, manufacturer, productName) VALUES
	(101, 'Name1', 'Country1', 'Trigger_prod1')
INSERT INTO FirstSchema.SecondView (quantity, seller, manufacturer, productName) VALUES
	(102, 'Name2', 'Country2', 'Trigger_prod2')


CREATE TRIGGER view_delete_trigger
	ON SecondDB.FirstSchema.SecondView
	INSTEAD OF DELETE
		AS BEGIN
			SELECT * FROM deleted
			RAISERROR ('Can not delete from SecondView', 11, 2)
END

DELETE FROM FirstSchema.SecondView

CREATE TRIGGER view_update_trigger
	ON SecondDB.FirstSchema.SecondView
	INSTEAD OF UPDATE AS BEGIN
		--IF (UPDATE(quantity) OR UPDATE(seller) OR UPDATE(manufacturer) OR UPDATE(productName))
		--	BEGIN

		--END

		--pk
		IF (update(purchaseID) OR update(productID))
			BEGIN
				RAISERROR ('Can not update SecondView', 11, 3)
			END

		UPDATE FirstSchema.TableWithPK SET quantity = inserted.quantity, seller = inserted.seller
		UPDATE FirstSchema.TableWithFK SET manufacturer = inserted.manufacturer, productName = inserted.productName
END