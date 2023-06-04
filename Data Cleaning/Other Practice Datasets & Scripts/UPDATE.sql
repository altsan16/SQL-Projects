-- SELECTS rows from table, and arranges rows in ascedning manner using r_id as basis
SELECT * FROM responses ORDER BY r_id;

-- UPDATE
UPDATE responses
SET gender = 'TBD', satisfied = 'U', score = 3, base_score = 5
WHERE gender IS NULL AND satisfied IS NULL AND score IS NULL AND base_score IS NULL;
-- LINE 7 specifies the conditions in choosing rows to be updated with the set values in LINE 6


UPDATE responses
SET satisfied = 'U', score = 3
WHERE  satisfied IS NULL AND score IS NULL
RETURNING *;
SELECT * FROM responses ORDER BY r_id;