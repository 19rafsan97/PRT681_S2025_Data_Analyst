-- Confirmation rate
SELECT 
    Signups.user_id,
    COALESCE(ROUND(COALESCE(SUM(Confirmations.action = 'confirmed'), 0)/ COALESCE(COUNT(Confirmations.action), 1), 2), 0) AS confirmation_rate
FROM Signups LEFT JOIN Confirmations
ON Signups.user_id = Confirmations.user_id
GROUP BY Signups.user_id;