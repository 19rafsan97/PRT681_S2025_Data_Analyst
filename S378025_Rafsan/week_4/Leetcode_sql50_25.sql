-- Biggest single number
SELECT MAX(num) AS num
FROM
(SELECT num, COUNT(num) AS countNum
FROM MyNumbers
GROUP BY num) AS CountNum
WHERE countNum = 1;