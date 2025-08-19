-- Immediate food delivery II
WITH First_order AS
(SELECT customer_id, order_date AS first_order_date, customer_pref_delivery_date
FROM(
    SELECT *,
    ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS RN
    FROM Delivery) AS WindowFunc
WHERE RN = 1
)

SELECT ROUND(SUM(CASE WHEN customer_pref_delivery_date = first_order_date THEN 1 ELSE 0 END)*100/COUNT(*), 2) AS immediate_percentage
FROM First_order;