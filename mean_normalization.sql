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