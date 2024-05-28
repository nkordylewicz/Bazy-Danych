USE AdventureWorks2019;
SELECT * FROM Production.Product


--1
BEGIN TRANSACTION
UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680
COMMIT;

SELECT * FROM Production.Product WHERE ProductID = 680;


--2
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"; --wy³¹cza wszystkie constrainty we wszystkich tabelach

BEGIN TRANSACTION
DELETE FROM Production.Product
WHERE ProductID = 707
ROLLBACK;

EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"; --w³¹cza wszystkie constrainty we wszystkich tabelach

SELECT * FROM Production.Product WHERE ProductID = 707;


--3
SET IDENTITY_INSERT Production.Product ON;

BEGIN TRANSACTION
INSERT INTO Production.Product(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,rowguid,ModifiedDate)
VALUES (16, 'Rollerblades', 'NA-2024', 0, 0, 'Pink', 700, 600, '50,00', '60,00', NULL, NULL, 'G', 400, 1, NULL, 'H', NULL, NULL, NULL, '2024-05-28', NULL, NULL, NEWID(), '2024-05-28')
COMMIT;

SELECT * FROM Production.Product WHERE ProductID = 16;


--4
BEGIN TRANSACTION
UPDATE Production.Product
SET StandardCost = StandardCost * 1.1

IF(SELECT SUM(StandardCost) FROM Production.Product) > 50000
BEGIN
	ROLLBACK;
END
ELSE
BEGIN
	COMMIT;
END;
	

--5
BEGIN TRANSACTION

IF EXISTS (SELECT * FROM Production.Product WHERE ProductNumber = 'NA-2024')
BEGIN
	PRINT 'Produkt ju¿ istnieje'
	ROLLBACK;
END
ELSE
BEGIN
	INSERT INTO Production.Product(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate,rowguid,ModifiedDate)
	VALUES (16, 'Rollerblades', 'NA-2024', 0, 0, 'Pink', 700, 600, '50,00', '60,00', NULL, NULL, 'G', 400, 1, NULL, 'H', NULL, NULL, NULL, '2024-05-28', NULL, NULL, NEWID(), '2024-05-28')
	COMMIT;
END;


--6
SELECT * FROM Sales.SalesOrderDetail;

BEGIN TRANSACTION
IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
	PRINT 'Transakcja wycofana'
	ROLLBACK;
END
ELSE
BEGIN
	UPDATE Sales.SalesOrderDetail
	SET OrderQty = OrderQty + 1;
	COMMIT;
END;


--7
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

BEGIN TRANSACTION
DECLARE @mean FLOAT;
DECLARE @number INT;

SELECT @mean = AVG(StandardCost) FROM Production.Product;
SELECT @number = COUNT(*) FROM Production.Product WHERE StandardCost > @mean;

IF @number > 10
BEGIN
	PRINT 'Transakcja odrzucona'
	ROLLBACK;
END
ELSE
BEGIN
	DELETE FROM Production.Product WHERE StandardCost > @mean
	COMMIT;
END;
	
EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";
