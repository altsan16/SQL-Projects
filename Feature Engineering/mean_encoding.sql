select * from property_sales

--check if disctinct entries if standardized
select distinct "LotShape" FROM property_sales

--update entries
UPDATE property_sales
SET "LotShape" = INITCAP("LotShape")
WHERE "LotShape" = 'Slightly irregular'
RETURNING *;


/* For the Mean Encoding, 
the following assumptions based on Lot Shape and Garage Area are made (say a client consultation is done):

- Regular and Garage Area > 300 is approved, thus equal to 1
- Regular and Garage Area < 300 is undesirable, thus equal to 0

- Slightly Irregular and Garage Area > 300 is approved, thus equal to 1
- Slightly Irregular and Garage Area < 300 is undesirable, thus equal to 0.

- Moderately Irregular and Garage Area > 400 is approved, thus equal to 1
- Moderately Irregular and Garage Area < 400 is undesirable, thus equal to 0.

- Irregular and Garage Area > 500 is approved, thus equal to 1
- Irregular and Garage Area < 500 is undesirable, thus equal to 0.


The following code is for the mean encoding,
The thought process is as follows:

1. For the main query, I wanted to evaluate each row based on the assumed parameters, hence creating a new column "target"
and assigning 1 or 0's. Subsequently counting the instances of each lotshape in the database.

2. For the first subquery, I wanted to see how many 1s and 0s are there, so that I can check if the number of 1s and 0s adds up to the number of
instances of each lotshape.

3. For the last subquery, I applied simple division to find the mean. I included casting since the initial result is a column
with all zeros (0). After casting the counts as float8, I observed that the output in the column "encoded_mean" was too lenghty,
that is why I searched for the round function (as I remember in my previous readings) strangely enough I read that it doesn't work
directly with float numbers and it requires the value to be casted as numeric.


Kindly leave a comment in the PGA if there is anyway I can make this code cleaner. Thank you!
*/
SELECT *, round(((target_count::float8/lotshape_count)::float8)::numeric,2) AS encoded_mean
FROM
	(
		SELECT DISTINCT *, COUNT(*) OVER(PARTITION BY "LotShape","target") AS target_count

		FROM(
				SELECT  "LotShape",
					CASE WHEN ("LotShape" = 'Regular' AND "GarageArea">300) THEN 1
						 WHEN ("LotShape" = 'Regular' AND "GarageArea"<300) THEN 0
						 WHEN ("LotShape" = 'Slightly Irregular' AND "GarageArea">300) THEN 1
						 WHEN ("LotShape" = 'Slightly Irregular' AND "GarageArea"<300) THEN 0
						 WHEN ("LotShape" = 'Moderately Irregular' AND "GarageArea">400) THEN 1
						 WHEN ("LotShape" = 'Moderately Irregular' AND "GarageArea"<400) THEN 0
						 WHEN ("LotShape" = 'Irregular' AND "GarageArea">500) THEN 1
						 WHEN ("LotShape" = 'Irregular' AND "GarageArea"<500) THEN 0
						 ELSE 0 
						 END AS "target",
					COUNT(*) OVER (PARTITION BY "LotShape") AS lotshape_count
				FROM property_sales
			) l
	) mean
WHERE mean.target=1

