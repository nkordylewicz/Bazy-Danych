USE AdventureWorks2019
GO

--1
--Funkcja
CREATE OR ALTER FUNCTION Fibonacci(@n INT) --n to ilosc liczb ktore chcemy wygenerowac
RETURNS @tab TABLE (liczba INT)
AS
BEGIN 
	DECLARE @i INT = 0,
			@Fn_1 INT = 1, --n-1 element ciagu
			@Fn_2 INT = 0, --n-2 element ciagu
			@tmp INT;
	WHILE @i < @n
	BEGIN
		IF @i = 0
			INSERT INTO @tab(liczba) VALUES (@Fn_2);
		ELSE IF @i = 1
			INSERT INTO @tab(liczba) VALUES (@Fn_1);
		ELSE IF @i > 1
		BEGIN
			SET @tmp = @Fn_1+@Fn_2;
			SET @Fn_2 = @Fn_1
			SET @Fn_1 = @tmp
			INSERT INTO @tab(liczba) VALUES (@tmp);
		END
		SET @i = @i + 1;
	END
	RETURN;
END;
GO

--Procedura
CREATE OR ALTER PROCEDURE wyswietlFibonacci (@n INT)
AS
BEGIN
	SELECT liczba FROM Fibonacci(@n);
END;

EXEC wyswietlFibonacci 15;
GO

--2
CREATE OR ALTER TRIGGER DuzeLitery ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person
	SET LastName = UPPER(LastName)
	FROM Person.Person;
END;

INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, LastName)
VALUES (292, 'EM', 'Adam', 'Nowak');

SELECT * FROM Person.Person
WHERE BusinessEntityID = 292;
GO


--3
CREATE OR ALTER TRIGGER taxRateMonitoring ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	IF EXISTS(
		SELECT 1
		FROM inserted
		JOIN deleted ON inserted.TaxRate > deleted.TaxRate * 1.3
		)
	BEGIN
		PRINT 'Zmiana wartosci w polu TaxRate o wiecej niz 30%!!'
	END;
END;

UPDATE Sales.SalesTaxRate
SET TaxRate = TaxRate * 1.5
WHERE TaxRate = 6.75;

SELECT * FROM Sales.SalesTaxRate