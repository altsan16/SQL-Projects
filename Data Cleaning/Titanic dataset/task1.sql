/* CHECK FOR DUPLICATES
Checking for duplicates first before doing task 1 to avoid revisions later. Un-quote to run code.*/
/*
SELECT "Name", COUNT(*) AS rec_count
FROM titanic
GROUP BY "Name"
HAVING COUNT(*)>1;
*/


/* TASK 1: Handle the missing data under columns "Age" and "Cabin" by replacing the appropriate values.
The suceeding code creates new column "cleaned_Age" and "cleaned_Cabin"
where:
	A. null values from column Age are transformed to UNK (acronym for unknown)
	B. float8 values are cast as integer then text to be on the same column as UNK to cater future analysis
	C. null values from column Cabin are transfored to UNK
	D. Cabin codes without minimum details (i.e., first Letter followed by atleast 1 digit) are labeled as UNK
	E. Cabin codes with excess characters are returned with normal cabin code format (i.e., F E69 to E69)
	F. Extra code to check for correct order of cabin code (UpperCase Alphabeth+number) which may be missed from D
	
Note:
	- I added lines E and F from my reading on Postgre documentation website:
		https://www.postgresql.org/docs/current/functions-matching.html#POSIX-EMBEDDED-OPTIONS-TABLE
		https://www.postgresql.org/docs/9.1/functions-string.html
	- Only the columns needed for comparison are displayed for faster query and comparison,
*/

SELECT "Age","Cabin",
		COALESCE (("Age"::int4)::text,'UNK') AS "cleaned_Age", --> A & B
		
		CASE
			WHEN "Cabin" IS NULL THEN 'UNK'  --> C
			WHEN CHAR_LENGTH(TRIM("Cabin"))<2 THEN 'UNK'  --> D
			WHEN ("Cabin" LIKE 'F %') IS TRUE THEN SUBSTRING("Cabin",3)  --> E
			WHEN (SUBSTRING("Cabin",1,1)~*'[A-Z]' AND SUBSTRING("Cabin",2,1)~*'[0-9]') IS NOT TRUE THEN 'UNK' -->F
			ELSE "Cabin"
		END AS "cleaned_Cabin"
FROM titanic;





