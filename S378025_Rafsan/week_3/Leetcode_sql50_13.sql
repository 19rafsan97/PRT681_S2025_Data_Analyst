-- Managers with at Least 5 Direct Reports
SELECT name FROM
(SELECT managerId, COUNT(*) AS Reportee FROM Employee
GROUP BY managerId) AS CountReportee
JOIN Employee 
ON CountReportee.managerID = Employee.id
WHERE Reportee>=5;