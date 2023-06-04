SELECT * FROM responses;

ALTER TABLE responses
ALTER COLUMN gender SET DATA TYPE VARCHAR

SELECT satisfied, COUNT(*) AS response_count
FROM responses
GROUP BY satisfied;


SELECT *, COALESCE(satisfied, 'No Response') AS satisfied2 FROM responses;

SELECT participant, score, base_score,(COALESCE (score, 3)/base_score) AS rate FROM responses;