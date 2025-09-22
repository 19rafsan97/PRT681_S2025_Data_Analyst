USE AdventureWorks2022;
GO

-- Show top 10 products
SELECT TOP 10 ProductID, Name, ProductNumber, ListPrice
FROM Production.Product;

-- Get distinct job titles
SELECT DISTINCT JobTitle
FROM HumanResources.Employee;

-- Find employees hired in 2020
SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
WHERE YEAR(HireDate) = 2020;

-- Order products by price, highest first
SELECT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

-- Search product names containing 'Mountain'
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE '%Mountain%';
