-- List the Products Ordered in a Period
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p JOIN Orders o
ON p.product_id = o.product_id
WHERE DATE_FORMAT(order_date, "%m-%Y") = "02-2020"
GROUP BY p.product_id, p.product_name
HAVING SUM(o.unit)>=100;