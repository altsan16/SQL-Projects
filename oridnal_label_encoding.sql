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