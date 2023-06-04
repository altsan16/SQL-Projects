/*Task3: Create a column "Last_name" and populate with values derived from "Name" column*/
SELECT * FROM titanic

/* Code splits the column "Name" using comma(,) as the separator and returns first part (1) in new column "Last_Name"*/ 
SELECT *, SPLIT_PART("Name",',',1) AS "Last_Name" FROM titanic;

/*Code splits column Name first by comma, then chooses the second part
this second part is further split using dot(.) as separator, and returns the Title*/

SELECT *, SPLIT_PART((SPLIT_PART("Name",',',2)),'.',1) AS "Title" FROM titanic;


/*Code splits column Name first by comma, then chooses the second part.
this second part is further split using dot(.) as separator,
the remaining part is further split using space ( ) as separator to obtain the First_Name

Note:
	- I observed that some of the listed first names starts with parenthesis,
	that is why I added CASE and SUBSTRING functions to ensure that the returned First_Name starts with an alphabeth, not parenthesis
	- Result only displays column "Name" and "First_Name" for faster query and comparison
*/
SELECT "Name", 
CASE
	WHEN (SUBSTRING(SPLIT_PART((SPLIT_PART((SPLIT_PART("Name",',',2)),'.',2)),' ',2),1,1)~*'[A-Z]') IS NOT TRUE
		THEN SUBSTRING(SPLIT_PART((SPLIT_PART((SPLIT_PART("Name",',',2)),'.',2)),' ',2),2)
		ELSE SPLIT_PART((SPLIT_PART((SPLIT_PART("Name",',',2)),'.',2)),' ',2)
	END AS "First_Name"
FROM titanic;