-- Delete duplicate email
DELETE FROM Person
WHERE id NOT IN (SELECT id FROM (SELECT MIN(id) AS id FROM Person Group by email) AS a);