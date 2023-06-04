SELECT * FROM responses;

ALTER TABLE responses
ALTER COLUMN gender SET DATA TYPE VARCHAR

SELECT DISTINCT trim(gender) FROM responses;

DELETE FROM responses