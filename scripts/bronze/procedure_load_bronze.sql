/*
--=====================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
--=====================================================================================
Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:
None.
This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze.load_bronze;

--=====================================================================================

*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN 
	DECLARE @start_time DATETIME , @end_time DATETIME;
	BEGIN TRY 
		SET @start_time = GETDATE(); -- WHOLE TIME 
		PRINT'================================================='
		PRINT'Loading Bronze Layer for crm'
		PRINT'================================================='
		
		SET @start_time = GETDATE();
		PRINT '--------------------------------------'
		PRINT 'TRUNCATING TABLE bronze.crm_cust_info'
		
		TRUNCATE TABLE [bronze].[crm_cust_info];

		PRINT 'INSERTING IN bronze.crm_cust_info'
		PRINT '--------------------------------------'
		BULK INSERT [bronze].[crm_cust_info]
		FROM 'C:\Users\shubh\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',' ,
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds'


		--==================================================================================== 
		SET @start_time = GETDATE();
		PRINT '--------------------------------------'
		PRINT 'TRUNCATING TABLE bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT 'INSERTING IN bronze.crm_prd_info'
		PRINT '--------------------------------------'
		

		BULK INSERT [bronze].[crm_prd_info]
		FROM 'C:\Users\shubh\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',' ,
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds'
		--==============================================================================
		SET @start_time = GETDATE();
		PRINT '--------------------------------------'
		PRINT 'TRUNCATING TABLE bronze.crm_sales_details'
		TRUNCATE TABLE [bronze].[crm_sales_details];
		PRINT 'INSERTING IN bronze.crm_sales_details'
		PRINT '--------------------------------------'
		

		BULK INSERT [bronze].[crm_sales_details]
		FROM 'C:\Users\shubh\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',' ,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds'
		--==============================================================================

		SET @start_time = GETDATE();
		PRINT'================================================='
		PRINT'Loading Bronze Layer for erp'
		PRINT'================================================='

		PRINT '--------------------------------------'
		PRINT 'TRUNCATING TABLE bronze.erp_cust_az12'
		TRUNCATE TABLE [bronze].[erp_cust_az12];
		PRINT 'INSERTING IN bronze.erp_cust_az12'
		PRINT '--------------------------------------'
		

		BULK INSERT [bronze].[erp_cust_az12]
		FROM 'C:\Users\shubh\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',' ,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds'
		--==============================================================================
		
		SET @start_time = GETDATE();
		PRINT '--------------------------------------'
		PRINT 'TRUNCATING TABLE bronze.erp_loc_a101'
		TRUNCATE TABLE [bronze].[erp_loc_a101];
		PRINT 'INSERTING IN bronze.erp_loc_a101'
		PRINT '--------------------------------------'

		BULK INSERT [bronze].[erp_loc_a101]
		FROM 'C:\Users\shubh\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',' ,
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds'
		--==============================================================================
		
		SET @start_time = GETDATE();
		PRINT '--------------------------------------'
		PRINT 'TRUNCATING TABLE bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];
		PRINT 'INSERTING IN bronze.erp_px_cat_g1v2'
		PRINT '--------------------------------------'
		

		BULK INSERT [bronze].[erp_px_cat_g1v2]
		FROM 'C:\Users\shubh\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR = ',' ,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds'

		SET @end_time = GETDATE();

		PRINT '--==========/=============/=============/=============/==========/'
		PRINT 'LOADING COMPLETED SUCCESFULLY :)'
		PRINT 'Load Duration (WHOLE TIME ) : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds'
	END TRY 
	
	BEGIN CATCH
		PRINT '================================================'
		PRINT 'ERROR OCCURED !!!'
		PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
		PRINT '================================================'
	END CATCH 
END
