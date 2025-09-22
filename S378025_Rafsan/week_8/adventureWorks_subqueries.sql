USE AdventureWorks2022;
GO

-- Products above average price
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);

-- Customers with more than 5 orders
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(*) > 5;

-- CTE: Top 5 sales reps by sales
WITH SalesCTE AS (
    SELECT sp.BusinessEntityID, SUM(soh.TotalDue) AS TotalSales
    FROM Sales.SalesPerson AS sp
    JOIN Sales.SalesOrderHeader AS soh ON sp.BusinessEntityID = soh.SalesPersonID
    GROUP BY sp.BusinessEntityID
)
SELECT TOP 5 sc.BusinessEntityID, p.FirstName, p.LastName, sc.TotalSales
FROM SalesCTE AS sc
JOIN Person.Person AS p ON sc.BusinessEntityID = p.BusinessEntityID
ORDER BY sc.TotalSales DESC;
