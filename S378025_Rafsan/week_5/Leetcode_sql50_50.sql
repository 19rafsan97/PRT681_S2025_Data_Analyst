-- Friend Requests II: Who Has the Most Friends
WITH UniqueFriendship AS(
    SELECT
        LEAST(accepter_id, requester_id) AS friend_1,
        GREATEST(accepter_id, requester_id) AS friend_2
    FROM
        RequestAccepted
),
    Result AS (
    SELECT 
        id, 
        SUM(num) AS num
    FROM (
        SELECT
            friend_1 as id,
            COUNT(*) as num
        FROM UniqueFriendship
        GROUP BY friend_1

        UNION 

        SELECT
            friend_2 as id,
            COUNT(*) as num
        FROM UniqueFriendship
        GROUP BY friend_2
    )AS Combined
GROUP BY id)

SELECT 
    DISTINCT id,
    num
FROM Result
WHERE num = (SELECT MAX(num) FROM Result);