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