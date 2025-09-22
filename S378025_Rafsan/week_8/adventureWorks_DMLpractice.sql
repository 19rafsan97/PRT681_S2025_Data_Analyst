USE AdventureWorks2022;
GO

-- Create a test table
IF OBJECT_ID('tempdb..#TestEmployees') IS NOT NULL DROP TABLE #TestEmployees;
CREATE TABLE #TestEmployees (EmpID INT, EmpName NVARCHAR(50));

-- Insert
INSERT INTO #TestEmployees VALUES (1, 'John Doe'), (2, 'Jane Smith'), (3, 'Mark Lee');

-- Update
UPDATE #TestEmployees SET EmpName = 'Jane Doe' WHERE EmpID = 2;

-- Delete
DELETE FROM #TestEmployees WHERE EmpID = 1;

-- Select
SELECT * FROM #TestEmployees;
