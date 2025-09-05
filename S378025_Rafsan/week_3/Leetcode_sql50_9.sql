-- Rising temperature
SELECT today.id
FROM Weather Yesterday
join Weather Today

where DATEDIFF(Today.recordDate, Yesterday.recordDate) = 1
AND Today.temperature > Yesterday.temperature;