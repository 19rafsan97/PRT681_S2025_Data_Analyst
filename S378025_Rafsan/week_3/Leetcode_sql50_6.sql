-- Replace Employee ID With The Unique Identifier
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees left join EmployeeUNI on Employees.id = EmployeeUNI.id;