/* Removing Unwanted Duplicate Records

SELECT *
FROM
(SELECT
	id, firstname, lastname, startdate, position,
	ROW_NUMBER() OVER(
				PARTITION BY(firstname, lastname)
				ORDER BY startdate DESC) rn
	FROM people) tmp
WHERE rn=1;
*/


SELECT * FROM employee 


/*adds new column 'row_num' containing the row number of each member of a partition/group based on lastname and firstname
partitions/creates groups from the list based on lastname+firstname
in this example, for group Braund, only 1 row is in the group, hence it is the first row and is labeled as row 1
for the group Cumings, there are three rows, hence rows 1 to 3
for the group Heikkinen, there are 2 rows, hence row 1 and 2.
NOTE: Row number is assigned based on their order/appearance on the list. 
*/
SELECT empid, lastname, firstname, startdate, position_title,
	ROW_NUMBER() OVER (PARTITION BY lastname, firstname) AS row_num
FROM employee;



--same example above, but arranged based on start date parameter
SELECT empid, lastname, firstname, startdate, position_title,
	ROW_NUMBER() OVER (PARTITION BY lastname, firstname ORDER BY startdate DESC) AS row_num
FROM employee;


--extracting the rows with row_num = 1
SELECT * FROM
(
	SELECT empid, lastname, firstname, startdate, position_title,
		ROW_NUMBER() OVER (PARTITION BY lastname, firstname ORDER BY startdate DESC) AS row_num
	FROM employee
) unique_empid
WHERE unique_empid.row_num=1;




--extracting the empid of rows with row_num = 1, these are the rows we need to retain
SELECT empid FROM
(
	SELECT empid, lastname, firstname, startdate, position_title,
		ROW_NUMBER() OVER (PARTITION BY lastname, firstname ORDER BY startdate DESC) AS row_num
	FROM employee
) unique_empid
WHERE unique_empid.row_num=1;




--extracting the empid of rows with row_num = 1, these are the rows we want to delete/dropped
SELECT empid FROM
(
	SELECT empid, lastname, firstname, startdate, position_title,
		ROW_NUMBER() OVER (PARTITION BY lastname, firstname ORDER BY startdate DESC) AS row_num
	FROM employee
) unique_empid
WHERE unique_empid.row_num>1;



--deleting the unwanted rows
DELETE FROM employee
WHERE empid IN
(
	SELECT empid FROM
	(
		SELECT empid, lastname, firstname, startdate, position_title,
			ROW_NUMBER() OVER (PARTITION BY lastname, firstname ORDER BY startdate DESC) AS row_num
		FROM employee
	) unique_empid
	WHERE unique_empid.row_num>1
);



SELECT * FROM employee