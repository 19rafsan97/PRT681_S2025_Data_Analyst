-- Percentage of Users Attended a Contest
SELECT contest_id, ROUND((COUNT(DISTINCT user_id)/(SELECT COUNT(*) FROM Users))*100, 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY PERCENTAGE DESC, contest_id;