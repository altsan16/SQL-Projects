SELECT * FROM responses;


LOWER()
UPPER()
INITCAP()

SELECT LOWER(participant) AS participant
FROM responses;


SELECT UPPER(participant) AS participant
FROM responses;


-- Capitalizes all first letter of each word in a string
SELECT INITCAP(participant) AS participant
FROM responses;