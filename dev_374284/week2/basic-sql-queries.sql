-- Basic SQL Practice Queries
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employees (ID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 50000),
(2, 'Bob', 'IT', 60000),
(3, 'Charlie', 'Finance', 70000),
(4, 'David', 'IT', 55000),
(5, 'Eve', 'Finance', 80000);

-- Select all employees
SELECT * FROM Employees;

-- Select employees with salary > 60000
SELECT Name, Department, Salary FROM Employees WHERE Salary > 60000;

-- Count employees per department
SELECT Department, COUNT(*) AS EmployeeCount FROM Employees GROUP BY Department;
