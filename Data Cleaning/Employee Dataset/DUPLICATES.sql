--finding duplicates

SELECT * FROM employee;


--selects all account with the same lastname and firstname
SELECT lastname, firstname, COUNT(*) AS rec_count
FROM employee
GROUP BY lastname, firstname;


--selects records with duplicates (count>1)
SELECT lastname, firstname, COUNT(*) AS rec_count
FROM employee
GROUP BY lastname, firstname
HAVING COUNT(*)>1;


--selects duplicates using all columns as basis
SELECT empid,lastname, firstname, startdate, position_title, COUNT(*) AS rec_count
FROM employee
GROUP BY empid,lastname, firstname, startdate, position_title;


--displacys identical rows based on all columns
SELECT empid,lastname, firstname, startdate, position_title, COUNT(*) AS rec_count
FROM employee
GROUP BY empid,lastname, firstname, startdate, position_title
HAVING COUNT(*)>1;





--counts/checks duplicates based on the set parameters inside the partition clause
--rec_count displays how many times the rows (lastname+firstname) appeared in the record while displaying the said rows
SELECT *, COUNT(*) OVER (PARTITION BY lastname, firstname) AS rec_count
FROM employee



--using subqeuery
--line 46 to 47 is the main query, adding lines 45-48-49 creates a subquery from the main query (employee_count)
--the ff code displays all rows from the main query  with rec_count>1
SELECT * FROM
(SELECT *, COUNT(*) OVER (PARTITION BY lastname, firstname) AS rec_count
FROM employee
) employee_count
WHERE employee_count.rec_count>1;

---------------------------------------------------------------------------

--deleting duplicates

--method 1: extract distinct rows to another table
/* 
SELECT DISTINCT * FROM people
-> selects all distinct row from specified table

or
SELECT DISTINCT ON (firstname, lastname) * FROM PEOPLE
--> selects all distinct rows based on chosen parameters from the specified table
*/

--method 2: deleting duplicates
--example below used subquery after the main query distinct on
/*
DELETE FROM people
WHERE id NOT IN
(SELECT id FROM 
(
SELECT DISTINCT ON  (firstname, lastname) * FROM people
)
);
*/

SELECT * FROM employee;


--selects all unique values under column lastname
SELECT DISTINCT lastname FROM employee;

--selects all unique records based on lastname and firstname
SELECT DISTINCT lastname, firstname FROM employee;

--laymans explanation: concat empid+lastname+firtsname, if unique then return row
SELECT DISTINCT empid, lastname, firstname FROM employee;

--shows all unique rows based on lastname and firstname
--note: displays the firsts instances of each record
SELECT DISTINCT ON (lastname, firstname) * FROM employee;

--using subquery to return specific values
--in this example, empid is extracted from the main query named 'distinct_records' using a subquery
SELECT empid FROM
(
	SELECT  DISTINCT ON (lastname,  firstname) *
	from employee
) distinct_records;


--selects the duplicates using another subquery
--in this example, the empids not found in previous subquery are returned
SELECT * FROM employee
WHERE empid NOT IN
(
	SELECT empid FROM
	(
		SELECT  DISTINCT ON (lastname,  firstname) *
		FROM employee
	) distinct_records
);


--deleting the duplicates using another subquery
--in this example, only the empids in the subquery are retained and all others are deleted
DELETE FROM employee
WHERE empid NOT IN
(
	SELECT empid FROM
	(
		SELECT  DISTINCT ON (lastname,  firstname) *
		FROM employee
	) distinct_records
);
