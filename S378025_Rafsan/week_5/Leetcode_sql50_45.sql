-- Friend Requests II: Who Has the Most Friends
WITH FriendCounts AS (
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
),
DistinctFriendCounts AS (
    SELECT id, COUNT(DISTINCT friend_id) AS total_friends
    FROM FriendCounts
    GROUP BY id
),
MaxFriends AS (
    SELECT MAX(total_friends) AS max_friends
    FROM DistinctFriendCounts
)
SELECT id, total_friends AS num
FROM DistinctFriendCounts
WHERE total_friends = (SELECT max_friends FROM MaxFriends);