-- The Number of Employees Which Report to Each Employee
WITH Managers AS
(SELECT
    reports_to AS employee_id,
    COUNT(employee_id) AS reports_count,
    ROUND(AVG(age), 0) AS average_age
FROM
    Employees
GROUP BY
    reports_to)

SELECT 
    M.employee_id,
    E.name,
    M.reports_count,
    M.average_age AS average_age
FROM
    Employees E JOIN Managers M
ON
    E.employee_id = M.employee_id
ORDER BY
    M.employee_id;