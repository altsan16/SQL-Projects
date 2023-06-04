/*In this code, I interlaced the codes from task1 to task5.
Process:
1. I combined the codes from task1 to task5 as a separate table and named it "b".
2. I set the expected columns from the original table (named "a") and table "b" so that the resulting table
matches the required output.
3. I then used INNER JOIN on the condition that a."Passenger"=b."Passenger" AND a."Name"=b."Name"
*/

SELECT a."Passenger",a."Survived",a."Pclass",a."Name",b."cleaned_Sex" as "Sex",b."cleaned_Age" as "Age", a."SibSp",
		a."Parch",a."Ticket", a."Fare", b."cleaned_Cabin" AS "Cabin",a."Embarked", b."Last_Name", b."Title", b."First_Name"
FROM titanic a
INNER JOIN

(SELECT "Passenger", "Name","Sex",
		COALESCE (("Age"::int4)::text,'UNK') AS "cleaned_Age", --> A & B
				CASE
					WHEN "Cabin" IS NULL THEN 'UNK'  --> C
					WHEN CHAR_LENGTH(TRIM("Cabin"))<2 THEN 'UNK'  --> D
					WHEN ("Cabin" LIKE 'F %') IS TRUE THEN SUBSTRING("Cabin",3)  --> E
					WHEN (SUBSTRING("Cabin",1,1)~*'[A-Z]' AND SUBSTRING("Cabin",2,1)~*'[0-9]') IS NOT TRUE THEN 'UNK' -->F
					ELSE "Cabin"
				END AS "cleaned_Cabin",
				CASE
					WHEN "Sex" = 'M' THEN 'male'
					WHEN "Sex" = 'F' THEN 'female'
					ELSE "Sex"
				END AS "cleaned_Sex",
		SPLIT_PART("Name",',',1) AS "Last_Name",
		SPLIT_PART((SPLIT_PART("Name",',',2)),'.',1) AS "Title",
				CASE
					WHEN (SUBSTRING(SPLIT_PART((SPLIT_PART((SPLIT_PART("Name",',',2)),'.',2)),' ',2),1,1)~*'[A-Z]') IS NOT TRUE
					THEN SUBSTRING(SPLIT_PART((SPLIT_PART((SPLIT_PART("Name",',',2)),'.',2)),' ',2),2)
					ELSE SPLIT_PART((SPLIT_PART((SPLIT_PART("Name",',',2)),'.',2)),' ',2)
				END AS "First_Name"
FROM titanic) b
ON a."Passenger"=b."Passenger" AND a."Name"=b."Name"