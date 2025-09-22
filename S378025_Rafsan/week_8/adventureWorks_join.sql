USE AdventureWorks2022;
GO

-- Customer orders with customer name
SELECT c.CustomerID, p.FirstName, p.LastName, soh.SalesOrderID, soh.TotalDue
FROM Sales.Customer AS c
JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
ORDER BY soh.TotalDue DESC;

-- Products and their subcategories
SELECT p.Name AS Product, ps.Name AS Subcategory
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID;

-- Employees and their departments
SELECT e.BusinessEntityID, p.FirstName, p.LastName, d.Name AS Department
FROM HumanResources.EmployeeDepartmentHistory AS edh
JOIN HumanResources.Department AS d ON edh.DepartmentID = d.DepartmentID
JOIN Person.Person AS p ON edh.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.Employee AS e ON edh.BusinessEntityID = e.BusinessEntityID;

-- Orders with shipping method
SELECT soh.SalesOrderID, sm.Name AS ShipMethod, soh.Freight
FROM Sales.SalesOrderHeader AS soh
JOIN Purchasing.ShipMethod AS sm ON soh.ShipMethodID = sm.ShipMethodID;
