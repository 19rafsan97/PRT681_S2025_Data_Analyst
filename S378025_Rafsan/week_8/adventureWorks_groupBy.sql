USE AdventureWorks2022;
GO

-- Total sales per territory
SELECT t.Name AS Territory, SUM(so.TotalDue) AS TotalSales
FROM Sales.SalesTerritory AS t
JOIN Sales.SalesOrderHeader AS so ON t.TerritoryID = so.TerritoryID
GROUP BY t.Name
ORDER BY TotalSales DESC;

-- Count products per subcategory
SELECT ps.Name AS Subcategory, COUNT(p.ProductID) AS ProductCount
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.Name;

-- Average sales per customer
SELECT c.CustomerID, AVG(soh.TotalDue) AS AvgOrderValue
FROM Sales.Customer AS c
JOIN Sales.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
ORDER BY AvgOrderValue DESC;

-- Employees hired per year
SELECT YEAR(HireDate) AS HireYear, COUNT(*) AS NumHires
FROM HumanResources.Employee
GROUP BY YEAR(HireDate)
ORDER BY HireYear;
