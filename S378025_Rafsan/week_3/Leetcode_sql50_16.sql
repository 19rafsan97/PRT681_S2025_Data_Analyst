-- Average selling price
SELECT product_id, ROUND(IFNULL((SUM(SellingPrice)/SUM(units)), 0), 2) AS average_price
FROM
(
    SELECT Prices.product_id, (Prices.price*UnitsSold.units)AS SellingPrice, UnitsSold.units 
    FROM Prices LEFT JOIN UnitsSold
    ON Prices.product_id = UnitsSold.product_id AND UnitsSold.purchase_date BETWEEN Start_date AND end_date
    GROUP BY Prices.product_id, UnitsSold.purchase_date
) AS SellingUnit
GROUP BY product_id;