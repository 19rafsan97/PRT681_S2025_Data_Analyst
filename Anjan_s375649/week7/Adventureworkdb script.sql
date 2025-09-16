
USE AdventureWorksLT2022;

-- Top-priced products
SELECT TOP 10 ProductID, Name, ProductNumber, Color, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;

-- Products with price range
SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Color IS NOT NULL
  AND ListPrice BETWEEN 500 AND 2000
ORDER BY ListPrice DESC, Name;

-- Products by category
SELECT pc.Name AS Category, p.ProductID, p.Name AS Product, p.ListPrice
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS pc
  ON p.ProductCategoryID = pc.ProductCategoryID
ORDER BY Category, Product;

-- Customers
SELECT TOP 20 CustomerID, FirstName, LastName, EmailAddress, CompanyName
FROM SalesLT.Customer
ORDER BY CustomerID;

-- Customers with addresses
SELECT c.CustomerID, c.FirstName, c.LastName,
       a.AddressLine1, a.City, a.StateProvince, a.PostalCode, a.CountryRegion
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
  ON c.CustomerID = ca.CustomerID
LEFT JOIN SalesLT.Address AS a
  ON ca.AddressID = a.AddressID
ORDER BY c.CustomerID;

-- Orders per year
SELECT YEAR(h.OrderDate) AS Year,
       COUNT(*)          AS Orders,
       SUM(h.SubTotal)   AS SalesSubTotal,
       SUM(h.TotalDue)   AS SalesTotalDue
FROM SalesLT.SalesOrderHeader AS h
GROUP BY YEAR(h.OrderDate)
ORDER BY Year;

-- Revenue by product
SELECT TOP 15 p.ProductID, p.Name,
       SUM(d.OrderQty)  AS Qty,
       SUM(d.LineTotal) AS Revenue
FROM SalesLT.SalesOrderDetail AS d
JOIN SalesLT.SalesOrderHeader AS h ON d.SalesOrderID = h.SalesOrderID
JOIN SalesLT.Product         AS p ON d.ProductID     = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY Revenue DESC;

-- Products per color
SELECT Color, COUNT(*) AS ProductCount
FROM SalesLT.Product
GROUP BY Color
ORDER BY ProductCount DESC;

-- Avg price by category
SELECT pc.ProductCategoryID, pc.Name AS Category,
       AVG(p.ListPrice) AS AvgPrice, COUNT(*) AS ProductCount
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory AS pc
  ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.ProductCategoryID, pc.Name
HAVING COUNT(*) >= 5
ORDER BY AvgPrice DESC;

-- Top products per category by revenue
WITH revenue AS (
  SELECT pc.ProductCategoryID, pc.Name AS Category,
         p.ProductID, p.Name AS Product,
         SUM(d.LineTotal) AS Revenue
  FROM SalesLT.SalesOrderDetail AS d
  JOIN SalesLT.Product         AS p  ON d.ProductID = p.ProductID
  JOIN SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
  GROUP BY pc.ProductCategoryID, pc.Name, p.ProductID, p.Name
)
SELECT Category, Product, Revenue,
       RANK() OVER (PARTITION BY Category ORDER BY Revenue DESC) AS RevenueRank
FROM revenue
WHERE Revenue > 0
ORDER BY Category, RevenueRank;

-- Monthly running sales totals
WITH month_sales AS (
  SELECT CAST(EOMONTH(h.OrderDate) AS date) AS MonthEnd,
         SUM(h.TotalDue) AS Sales
  FROM SalesLT.SalesOrderHeader AS h
  GROUP BY CAST(EOMONTH(h.OrderDate) AS date)
)
SELECT MonthEnd, Sales,
       SUM(Sales) OVER (ORDER BY MonthEnd ROWS UNBOUNDED PRECEDING) AS RunningSales
FROM month_sales
ORDER BY MonthEnd;

-- Customers with > 3 orders
WITH orders_by_customer AS (
  SELECT CustomerID, COUNT(*) AS Orders
  FROM SalesLT.SalesOrderHeader
  GROUP BY CustomerID
)
SELECT c.CustomerID, c.FirstName, c.LastName, o.Orders
FROM orders_by_customer AS o
JOIN SalesLT.Customer AS c ON o.CustomerID = c.CustomerID
WHERE o.Orders > 3
ORDER BY o.Orders DESC, c.CustomerID;

-- Products never ordered
SELECT p.ProductID, p.Name
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS d ON p.ProductID = d.ProductID
WHERE d.ProductID IS NULL
ORDER BY p.ProductID;

-- Create a view
CREATE OR ALTER VIEW dbo.vProductRevenue AS
SELECT p.ProductID, p.Name,
       SUM(d.OrderQty)  AS Qty,
       SUM(d.LineTotal) AS Revenue
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS d ON p.ProductID = d.ProductID
GROUP BY p.ProductID, p.Name;

-- Use the view
SELECT TOP 20 * FROM dbo.vProductRevenue ORDER BY Revenue DESC;

-- Example procedure
CREATE OR ALTER PROCEDURE dbo.usp_TopProductsByRevenue
  @TopN int = 10
AS
BEGIN
  SET NOCOUNT ON;
  SELECT TOP (@TopN) ProductID, Name, Qty, Revenue
  FROM dbo.vProductRevenue
  ORDER BY Revenue DESC;
END;

EXEC dbo.usp_TopProductsByRevenue @TopN = 12;

-- Sandbox DML
SELECT TOP 50 *
INTO #ProductSandbox
FROM SalesLT.Product;

BEGIN TRAN;
  UPDATE #ProductSandbox
  SET ListPrice = ListPrice * 1.10
  WHERE Color = 'Black';

  DELETE FROM #ProductSandbox
  WHERE ListPrice < 100;

  SELECT COUNT(*) AS RowsAfter, SUM(ListPrice) AS TotalListPrice
  FROM #ProductSandbox;
ROLLBACK;
