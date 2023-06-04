--duplicates part2
--selects specified columns from table and groups the result using the parameters set
SELECT
	lastname,
	firstname,
	string_agg(position_title, '/') AS positions
FROM employee
GROUP BY lastname, firstname;


--combining two tables
/*
'A' - refers to table1 where A.columns exists
'B' - refers to table2 where B.column exists
in this example, thou ouput contains the specified A.columns and B.columns
ON the condition that A.lastname = B.lastname AND A.firstname = B.firstname
*/
SELECT A.empid, A.lastname, A.firstname, A.startdate, A.position_title, B.positions
FROM employee A  --> assign employee table as A
INNER JOIN
(
	SELECT lastname, firstname, STRING_AGG(position_title, '/') AS positions
	FROM employee
	GROUP BY lastname, firstname
) B --> assigns the subquery above as B
ON A.lastname = B.lastname AND A.firstname = B.firstname;  -->sets the conditons for joining/merging


--selects all rows with duplicates, lastname+firstname/rec_count > 1
SELECT * FROM
(
	SELECT *, COUNT(*) OVER (PARTITION BY lastname, firstname) AS rec_count
	FROM employee
) employee_count
WHERE employee_count.rec_count > 1;

--Selects the empid of all rows with rec_count>1
SELECT empid FROM
(
	SELECT *, COUNT(*) OVER (PARTITION BY lastname, firstname) AS rec_count
	FROM employee
) employee_count
WHERE employee_count.rec_count > 1;



--Selects all rows rec_count>1 from the table3 (combined table1 and table2)
SELECT A.empid, A.lastname, A.firstname, A.startdate, A.position_title, B.positions
FROM employee A  --> assign employee table as A
INNER JOIN
(
	SELECT lastname, firstname, STRING_AGG(position_title, '/') AS positions
	FROM employee
	GROUP BY lastname, firstname
) B --> assigns the subquery above as B
ON A.lastname = B.lastname AND A.firstname = B.firstname  -->sets the conditons for joining/merging
WHERE A.empid IN
	(
		SELECT empid FROM
		(
			SELECT *, COUNT(*) OVER (PARTITION BY lastname, firstname) AS rec_count
			FROM employee
		) employee_count
		WHERE employee_count.rec_count > 1
	);



--updates employee table column position_title using the string aggregation from table2
--replaces column position_title using b.positions from strng_agg function
INSERT INTO employee(empid, firstname, lastname, startdate, position_title)
	SELECT A.empid, A.lastname, A.firstname, A.startdate, B.positions as position_title
	FROM employee A  --> assign employee table as A
	INNER JOIN
	(
		SELECT lastname, firstname, STRING_AGG(position_title, '/') AS positions
		FROM employee
		GROUP BY lastname, firstname
	) B --> assigns the subquery above as B
	ON A.lastname = B.lastname AND A.firstname = B.firstname  -->sets the conditons for joining/merging
	WHERE A.empid IN
		(
			SELECT empid FROM
			(
				SELECT *, COUNT(*) OVER (PARTITION BY lastname, firstname) AS rec_count
				FROM employee
			) employee_count
			WHERE employee_count.rec_count > 1
		)
ON CONFLICT ON CONSTRAINT employee_pkey
DO UPDATE SET position_title = EXCLUDED.position_title;



SELECT * FROM employee;