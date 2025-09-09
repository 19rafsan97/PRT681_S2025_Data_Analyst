-- Week 3: DML Operations Practice (SQLite)
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER,
    Grade TEXT
);
INSERT INTO Students (ID, Name, Age, Grade) VALUES
(1, 'Aisha', 20, 'B'),
(2, 'Ben', 22, 'C'),
(3, 'Chen', 21, 'A'),
(4, 'Dev', 23, 'B'),
(5, 'Eva', 20, 'A');
UPDATE Students SET Grade = 'A+' WHERE Name = 'Chen';
DELETE FROM Students WHERE ID = 2;
SELECT * FROM Students ORDER BY ID;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    CustomerName TEXT,
    City TEXT
);
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER,
    OrderDate TEXT,
    Amount REAL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(101, 'Acme Pty', 'Sydney'),
(102, 'Blue Ocean', 'Melbourne'),
(103, 'Coral Tech', 'Darwin');
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(1001, 101, '2025-08-01', 250.00),
(1002, 101, '2025-08-03', 125.00),
(1003, 102, '2025-08-04', 980.00),
(1004, 103, '2025-08-06', 310.00);
UPDATE Orders SET Amount = Amount * 1.10 WHERE OrderID = 1002;
DELETE FROM Orders WHERE OrderID = 1004;
-- Total per customer
SELECT c.CustomerName, SUM(o.Amount) AS TotalSpent
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC;
