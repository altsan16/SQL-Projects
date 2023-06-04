/* TASK 2: Standardize the values found under column "Sex".
In this code:
	A. Distinct values are checked to see all cases needed to be standardized
	B. Used CASE function to replace values
	
Note: Displayed only the columns needed for faster query and comparison
*/

SELECT DISTINCT "Sex" FROM titanic;  --> A

SELECT "Sex",						--> B
		CASE
			WHEN "Sex" = 'M' THEN 'male'
			WHEN "Sex" = 'F' THEN 'female'
			ELSE "Sex"
		END AS "cleaned_Sex"
FROM titanic;





