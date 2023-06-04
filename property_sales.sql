-- Importing csv handling null values for later aggregation
COPY property_sales from 'C:\Users\Admin\Desktop\Project SPARTA\Data Engineering\SP 701 - SQL for Data Engineering\Week 5 - Feature Engineering using SQL\property_sales.txt'
WITH DELIMITER ',' NULL AS '';

-- Checking if all columns are loaded with correct data types (i.e., integer not varchar)
SELECT * FROM property_sales

-- Chose entries on column "LandSlope" as categorical variables, but needed to check if the entries are standardized hence the DISTINCT function
SELECT DISTINCT "LandSlope" FROM property_sales

-- Observed that entry 'Gentle Slope' was not standardized therefore an UPDATE function was executed
UPDATE property_sales
SET "LandSlope" = INITCAP("LandSlope")
WHERE "LandSlope" = 'Gentle slope'
RETURNING *;

-- One-Hot encoding
SELECT "Id", "LandSlope",
CASE WHEN	"LandSlope" = 'Gentle Slope' THEN 1 ELSE 0 END AS "Gentle Slope",
CASE WHEN	"LandSlope" = 'Moderate Slope' THEN 1 ELSE 0 END AS "Moderate Slope",
CASE WHEN	"LandSlope" = 'Severe Slope' THEN 1 ELSE 0 END AS "Severe Slope"
FROM property_sales
ORDER BY "Id"


SELECT * FROM property_sales

-- Chose entries on column "OverallCond" as categorical variables, but needed to check if the entries are standardized hence the DISTINCT function
-- verified that entries under the said column are standardized, hence no need to update
SELECT DISTINCT "OverallCond" FROM property_sales


--Ordinal/Label Encoding
SELECT "Id", "OverallCond",
		CASE 
				WHEN "OverallCond" = 'Excellent' THEN 1
				WHEN "OverallCond" = 'Very Good' THEN 2
				WHEN "OverallCond" = 'Good' THEN 3
				WHEN "OverallCond" = 'Above Average' THEN 4
				WHEN "OverallCond" = 'Average' THEN 5
				WHEN "OverallCond" = 'Below Average' THEN 6
				WHEN "OverallCond" = 'Fair' THEN 7
				WHEN "OverallCond" = 'Poor' THEN 8
				WHEN "OverallCond" = 'Very Poor' THEN 9
				END AS "OverallCond_Ordinal"
FROM property_sales
ORDER BY "Id"



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



/*Task 4: Perform Mean Normalization on all the numeric variables to rescale these variables (you
may add new columns for this)


The code for this task is pretty straightforward.
I used coealesce to catch any null values and asssigned 1 as its 
default value (to be easily dealt in future analysis) 
*/
select * from property_sales


select "Id", "LotFrontage", "LotArea", "GarageArea", "GrLivArea", "TotalBsmtSF", "SalePrice",

		COALESCE(("LotFrontage" - AVG("LotFrontage") OVER()) / (MAX("LotFrontage") OVER() - MIN("LotFrontage") OVER()), 1)
		AS LotFrontage_NormMean,

		COALESCE(("GarageArea" - AVG("GarageArea") OVER()) / (MAX("GarageArea") OVER() - MIN("GarageArea") OVER()), 1)
		AS GarageArea_NormMean,

		COALESCE(("GrLivArea" - AVG("GrLivArea") OVER()) / (MAX("GrLivArea") OVER() - MIN("GrLivArea") OVER()), 1)
		AS GrLivArea_NormMean,
		
		COALESCE(("TotalBsmtSF" - AVG("TotalBsmtSF") OVER()) / (MAX("TotalBsmtSF") OVER() - MIN("TotalBsmtSF") OVER()), 1)
		AS TotalBsmtSF_NormMean,
		
		COALESCE(("SalePrice" - AVG("SalePrice") OVER()) / (MAX("SalePrice") OVER() - MIN("SalePrice") OVER()), 1)
		AS SalePrice_NormMean

 from property_sales
 
 
 
select * from property_sales


select "Id", "LotFrontage", "LotArea", "GarageArea", "GrLivArea", "TotalBsmtSF", "SalePrice",


		COALESCE((("LotFrontage" - AVG("LotFrontage") OVER()) / STDDEV_SAMP("LotFrontage") OVER()), 1)
		AS LotFrontage_stddev,

		COALESCE((("GarageArea" - AVG("GarageArea") OVER()) / STDDEV_SAMP("GarageArea") OVER()), 1)
		AS GarageArea_stddev,

		COALESCE((("GrLivArea" - AVG("GrLivArea") OVER()) / STDDEV_SAMP("GrLivArea") OVER()), 1)
		AS GrLivArea_stddev,
		
		COALESCE((("TotalBsmtSF" - AVG("TotalBsmtSF") OVER()) / STDDEV_SAMP("TotalBsmtSF") OVER()), 1)
		AS TotalBsmtSF_stddev,
		
		COALESCE((("SalePrice" - AVG("SalePrice") OVER()) / STDDEV_SAMP("SalePrice") OVER()), 1)
		AS SalePrice_stddev


from property_sales;
