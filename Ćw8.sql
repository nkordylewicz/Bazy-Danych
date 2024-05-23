
SELECT * FROM AdventureWorks2019.Person.Person
SELECT * FROM AdventureWorks2019.HumanResources.EmployeePayHistory
GO
--1

WITH CTE_1 AS
(
	SELECT p.BusinessEntityID, p.FirstName, p.MiddleName, p.LastName, r.Rate
	FROM AdventureWorks2019.Person.Person p
	JOIN AdventureWorks2019.HumanResources.EmployeePayHistory r
	ON p.BusinessEntityID = r.BusinessEntityID
)
SELECT * INTO TempEmployeeInfo
FROM CTE_1

SELECT * FROM TempEmployeeInfo;


--2
SELECT * FROM AdventureWorksLT2019.SalesLT.Customer;
SELECT * FROM AdventureWorksLT2019.SalesLT.SalesOrderHeader;

WITH CTE_2(CompanyContact,Revenue) AS
(
	SELECT CONCAT(c.CompanyName, ' (',c.FirstName, ' ', c.LastName, ')'), rev.TotalDue
	FROM AdventureWorksLT2019.SalesLT.Customer c
	JOIN AdventureWorksLT2019.SalesLT.SalesOrderHeader rev
	ON c.CustomerID = rev.CustomerID
)
SELECT * FROM CTE_2
ORDER BY CompanyContact


--3
SELECT * FROM AdventureWorksLT2019.SalesLT.ProductCategory;
SELECT * FROM AdventureWorksLT2019.SalesLT.SalesOrderDetail;
SELECT * FROM AdventureWorksLT2019.SalesLT.Product;

WITH CTE_3(Category,SalesValue) AS
(
	SELECT pcat.Name, SUM(sales.UnitPrice*sales.OrderQty) AS SalesValue
	FROM AdventureWorksLT2019.SalesLT.ProductCategory pcat
	JOIN AdventureWorksLT2019.SalesLT.Product p
	ON pcat.ProductCategoryID = p.ProductCategoryID
	JOIN AdventureWorksLT2019.SalesLT.SalesOrderDetail sales
	ON p.ProductID = sales.ProductID	
	GROUP BY pcat.Name
)
SELECT * FROM CTE_3