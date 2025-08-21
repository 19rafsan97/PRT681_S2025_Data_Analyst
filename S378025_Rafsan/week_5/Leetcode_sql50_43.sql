-- Movie rating
SELECT results FROM(
(SELECT
    u.name AS results, COUNT(r.movie_id) AS rating_count
FROM
    Users u JOIN MovieRating r
ON
    u.user_id = r.user_id
GROUP BY u.user_id
ORDER BY rating_count DESC, u.name
LIMIT 1)
UNION
(SELECT
    m.title AS results, AVG(r.rating) AS avg_rating
FROM
    Movies m JOIN MovieRating r
ON
    m.movie_id = r.movie_id
WHERE DATE_FORMAT(r.created_at, '%Y-%m') = '2020-02'
GROUP BY m.movie_id
ORDER BY avg_rating DESC, m.title
LIMIT 1) 
) AS UnionResult;