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