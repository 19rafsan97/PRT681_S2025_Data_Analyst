USE AdventureWorks2022;
GO

-- Rank products by sales within category
SELECT pc.Name AS Category, p.Name AS Product, 
       SUM(sod.LineTotal) AS TotalSales,
       RANK() OVER (PARTITION BY pc.Name ORDER BY SUM(sod.LineTotal) DESC) AS SalesRank
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory AS pc ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
GROUP BY pc.Name, p.Name;

-- Running total of sales per year
SELECT YEAR(OrderDate) AS OrderYear, SUM(TotalDue) AS YearlySales,
       SUM(SUM(TotalDue)) OVER (ORDER BY YEAR(OrderDate)) AS RunningTotal
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate);

-- Dense rank employees by hire date
SELECT BusinessEntityID, JobTitle, HireDate,
       DENSE_RANK() OVER (ORDER BY HireDate ASC) AS HireRank
FROM HumanResources.Employee;
