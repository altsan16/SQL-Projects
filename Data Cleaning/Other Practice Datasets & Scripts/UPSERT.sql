-- UPSERT USING INSERT ON CONFLICT Statement
-- IN RDB, UPSERT is merge. If record is not found in the db, a new record iss created, otherwise old record is updated


-- SET r_id as primary keys
ALTER TABLE responses
ADD CONSTRAINT p_key
PRIMARY KEY (r_id)


--adding a constraint
--adds unique value constraint in column participant as unique_participant
ALTER TABLE public.responses
ADD CONSTRAINT unique_participant UNIQUE (participant);



SELECT * FROM responses
ORDER BY r_id;

--INSERTS a new row with r_id 16. if r_id exists, it updates the value in that existing row on conditon that there is no conflicts
--example redundant p_key
INSERT INTO responses (r_id, participant, gender, satisfied,score, base_score
VALUES (16, 'Test Participant', 'female', 'N', 2,5)

--INSERTS a new row with r_id 16. and check if there are conflicts on specific column (duplicate)
--example redundant participant name
INSERT INTO responses (r_id, participant, gender, satisfied,score, base_score
VALUES (16, 'Test Participant', 'female', 'N', 2,5)
ON CONFLICT (participant)
DO NOTHING;
--returns an error if the selected column does not hold any unique or exclusion constraint


--In the succeeding example, a conflict (particularly with primary key) is observed, thus with additional ON CONSTRAINT
--to handle errors. REMEMBER EXCEPTION HANDLING in Python

--INSERTS a new row with r_id 16. if r_id exists, it does nothing. DOES NOT INSERT ANY ROW
INSERT INTO responses (r_id, participant, gender, satisfied,score, base_score
VALUES (16, 'Test Participant', 'female', 'N', 2,5)
ON CONFLICT ON CONSTRAINT p_key
DO NOTHING;
-- using this error handling prevents the program from reading the succeeding lines


--UPDATES an existing row
INSERT INTO responses (r_id, participant, gender, satisfied,score, base_score
VALUES (16, 'Test Participant', 'female', 'N', 2,5)
ON CONFLICT ON CONSTRAINT p_key
DO UPDATE SET satisfied= EXCLUDED.satisfied,
			  score=EXCLUDED.score;
/*lines
DO UPDATE SET satisfied= EXCLUDED.satisfied,
			  score=EXCLUDED.score;
sets which columns are to be updated in the existing row/record 

