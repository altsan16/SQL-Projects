--USING IF FUNCTION AND CASE FUNCTION

/* IF FUNCTION is not available in Postgre SQL

in case we work with other rdbms such as MS SQL and MySQL, the IF functions goes as follows:

IF(expression, value_if_true, value_if_false) --> same with excel

EXAMPLE:

SELECT
	Firstname,
	Lastname,
	IF(Gender='M', Male, 'Female') AS Gender
FROM people


--NESTED IF

EXAMPLE:

SELECT 
	Firstname,
	Lastname,
	IF(Gender = 'M','Male'
		IF (Gender = 'F','Female',
		IF (Gender='0', 'Male',
		IF (Gender='1', 'Female', Gender)))) AS Gender
FROM people;
*/



-- CASE Conditional Statement
/*
CASE
	WHEN condition_1 THEN result_1
	WHEN condition_2 THEN result_2
	WHEN...
	ELSE else_result
END



EQUIVALENT SCRIPT BASED ON THE PREVIOUS EXAMPLE:

SELECT
	Firtsname,
	Lastname,
	CASE
		WHEN Gender='M' THEN 'Male'
		WHEN Gender='F' THEN 'Female'
		WHEN Gender='0' THEN 'Male'
		WHEN Gender='1' THEN 'Female'
		ELSE Gender
	END AS Gender
FROM people

*/

SELECT * FROM people_gender

--changing values using CASE Function
SELECT people_id, first_name, last_name, gender,
CASE
	WHEN gender='M' THEN 'Male'
	WHEN gender='0' THEN 'Male'
	WHEN gender='F' THEN 'Female'
	WHEN gender='1' THEN 'Female'
	ELSE gender
	END AS gender_cleaned
FROM people_gender;