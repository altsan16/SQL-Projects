SELECT * FROM responses;

SELECT DISTINCT trim(gender) FROM responses;

SELECT REPLACE(participant, 'Mr.', '') as  participant FROM responses;

SELECT REPLACE(REPLACE(participant, 'Mr.', ''),'mr.', '') as  participant FROM responses;

SELECT REPLACE(REPLACE(REPLACE(participant, 'Mr.', ''),'mr.', ''), 'Miss.', '') as  participant FROM responses;

SELECT REPLACE(participant, 'Mr.', 'Mister' ) as  participant FROM responses;

SELECT DISTINCT REPLACE(gender, ' ', '') AS gender FROM responses;