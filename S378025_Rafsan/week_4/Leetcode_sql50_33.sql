-- Last Person to Fit in the Bus
WITH CumulativeWeight AS(
    SELECT
        person_id,
        person_name,
        weight,
        SUM(weight) OVER(ORDER BY turn) AS cumulativeWeight,
        turn
    FROM 
        Queue
)
SELECT person_name FROM CumulativeWeight WHERE cumulativeWeight<=1000 ORDER BY cumulativeWeight DESC LIMIT 1;