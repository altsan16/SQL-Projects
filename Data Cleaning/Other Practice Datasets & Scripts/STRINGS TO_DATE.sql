--STRINGS to DATES

/* Using TO_DATE() function
TO_DATE (expression, format)

where
expression - is the date in string
format - is  the date format used in the date string

Example:

TO_DATE('23/11/2010','dd/mm/yyyy')
TO_DATE('May 1, 2020', 'month dd, yyyy
*/


SELECT * FROM production;


SELECT '12/18/2020' AS myDate;


--Method 1 Cast()
SELECT CAST('12/18/2020' AS DATE) AS myDate;
--or
SELECT '12/18/2020'::DATE AS myDate;
--postgre returns an error since the default algo in my system dd/mm/yyyy therefore 18 is out of range

--adding an entry with date involved BUT string input
INSERT INTO production(id, product, order_date)
VALUES (8,'product 8','12/18/2020');
--returns error since system uses dd/mm/yyyy. need to apply to_date() function

--adding an entry with date involved
INSERT INTO production(id, product, order_date)
VALUES (8,'product 8',TO_DATE('12/18/2020','MM/DD/YYYY'));


--Same process but using TO_DATE() to correctly identify the imput date
INSERT INTO production(id, product, order_date)
VALUES (9,'product 9',TO_DATE('May 1, 2020','month dd, yyyy'));
