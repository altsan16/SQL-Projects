SELECT * FROM responses;

--INSERTING A ROW
INSERT INTO responses(r_id, participant,gender,satisfied,score, base_score)
VALUES (11, 'Dela Cruz, Mr. Juan', 'male','Y',4,5);


--INSERTING MULTIPLE ROWS
INSERT INTO responses(r_id, participant,gender)
VALUES (216, 'Dela Cruz, Mr. Juan', 'male'), (217, 'Jack, Mr. Black', 'male');

--INSERTING VALUES FROM ANOTHER TABLE
INSERT INTO responses(r_id, participant)
SELECT people_id+215 as r_id, (last_name ||', '||first_name) as participant FROM people;
-- +215 to avoid r_id duplication and ||/concat since the destination column participant is a single column 


-- DELETE USED TO PRACTICE REINSERTION :>
DELETE FROM responses WHERE r_id IN (11)
RETURNING *;