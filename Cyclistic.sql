/*
Date: December 10,2021
Data Analyst: Spencer Tang
Goal: How do annual members and casual riders use Cyclistic bikes differently?
*/

-------------------------------------------------------------------------------PREPARE STEP---------------------------------------------------------------------------
-- After importing 12 files (12 months divvy-tripdata), creating empty table trip_12_month with the original table structure
CREATE TABLE [dbo].[trip_12_month](
	[ride_id] [varchar](50) NULL,
	[rideable_type] [varchar](50) NULL,
	[started_at] [varchar](50) NULL,
	[ended_at] [varchar](50) NULL,
	[start_station_name] [varchar](max) NULL,
	[start_station_id] [varchar](50) NULL,
	[end_station_name] [varchar](max) NULL,
	[end_station_id] [varchar](50) NULL,
	[start_lat] [varchar](50) NULL,
	[start_lng] [varchar](50) NULL,
	[end_lat] [varchar](50) NULL,
	[end_lng] [varchar](50) NULL,
	[member_casual] [varchar](50) NULL
);

-- Combining all tables into one (between 10.2020 and 09.2021)
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202010-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202011-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202012-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202101-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202102-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202103-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202104-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202105-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202106-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202107-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202108-divvy-tripdata];
INSERT INTO [dbo].[trip_12_month] SELECT * FROM dbo.[202109-divvy-tripdata];

---------------------------------------------------------------------------------PROCESS STEP-------------------------------------------------------------------------
-- Removing null values from the combined dataset
INSERT INTO [dbo].[trip_12_month_not_null]
	SELECT *
	FROM [dbo].[trip_12_month]
	WHERE
		[ride_id] NOT LIKE '%NULL%'
		AND [rideable_type] NOT LIKE '%NULL%'
		AND [started_at] NOT LIKE '%NULL%'
		AND [ended_at] NOT LIKE '%NULL%'
		AND [start_station_name] NOT LIKE '%NULL%'
		AND [start_station_id] NOT LIKE '%NULL%'
		AND [end_station_name] NOT LIKE '%NULL%'
		AND [end_station_id] NOT LIKE '%NULL%'
		AND [start_lat] NOT LIKE '%NULL%'
		AND [start_lng] NOT LIKE '%NULL%'
		AND [end_lat] NOT LIKE '%NULL%'
		AND [end_lng] NOT LIKE '%NULL%'
		AND [member_casual] NOT LIKE '%NULL%'

-- Checking the duplication of ride_id and comparision the number of ride_id and the figure of distinct_ride_id
SELECT
	COUNT(ride_id) AS total_ride_id,
	COUNT(DISTINCT ride_id) AS distinct_ride_id
FROM [dbo].[trip_12_month_not_null]

-- Removing the duplication of ride_id
WITH cte
     AS (SELECT ROW_NUMBER() OVER (PARTITION BY [ride_id]
      ,[rideable_type]
      ,[started_at]
      ,[ended_at]
      ,[start_station_name]
      ,[start_station_id]
      ,[end_station_name]
      ,[end_station_id]
      ,[start_lat]
      ,[start_lng]
      ,[end_lat]
      ,[end_lng]
      ,[member_casual]
        ORDER BY ( SELECT 0)) RN
         FROM   [dbo].[trip_12_month_not_null])
DELETE FROM cte
WHERE  RN > 1;

-- Checking the length of each ride where trip duration is less than or equals 0 second
SELECT
	[started_at],
	[ended_at],
	DATEDIFF(SECOND, started_at, ended_at) AS ride_length
FROM [trip_12_month_not_null]
WHERE
	DATEDIFF(SECOND, started_at, ended_at) <= 0
ORDER BY
	ride_length
;

-- Calculating the length of each ride and the day of the week that each ride started
INSERT INTO [trip_12_month_calculation]
	SELECT *,
		DATEDIFF(SECOND, started_at, ended_at) AS ride_length,
		DATEPART(WEEKDAY, started_at) AS day_of_week
	FROM [dbo].[trip_12_month_not_null]
;

-- Deleting negative time in the length of each ride
DELETE *
FROM [trip_12_month_not_null]
WHERE
	DATEDIFF(SECOND, started_at, ended_at) <= 0
;

------------------------------------------------------------------------------ ANALYZE STEP-------------------------------------------------------------------------




