/*
Date: December 10,2021
Data Analyst: Spencer Tang
Goal: How do annual members and casual riders use Cyclistic bikes differently?
*/

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

-- 
