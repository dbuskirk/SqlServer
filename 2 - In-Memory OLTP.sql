-- Demonstration 2 - Use the local AdventureWorks2016 database


-- Step 1: Open a new query window 
-- Select and execute the following script to connect to the AdventureWorks database
USE AdventureWorks2016
GO


-- Step 2: Check Pre-Requisites 
-- In Object Explorer, right-click on the AdventureWorks2016 database, and then click Properties.
-- On the File page, point out the AdventureWorks2016_mod file.
-- On the Filegroups page, point out the MEMORY_OPTIMIZED DATA file.


-- Step 3: Create MemoryOptimized Schema
-- Select and execute the following script to create a new schema
CREATE SCHEMA MemoryOptimized;
GO


-- Step 4: Create MemoryOptimized Table
-- Select and execute the following script to create a new table based on Production.Product
CREATE TABLE MemoryOptimized.Product
(
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50)  NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[MakeFlag] [bit] NOT NULL,
	[FinishedGoodsFlag] [bit] NOT NULL,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] NOT NULL,
	[ReorderPoint] [smallint] NOT NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Size] [nvarchar](5) NULL,
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int] NOT NULL,
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	CONSTRAINT [PK_MemoryOptimized_Product] PRIMARY KEY NONCLUSTERED ([ProductID])
)
WITH 
	(
		MEMORY_OPTIMIZED = ON, 
		DURABILITY = SCHEMA_AND_DATA 
	)
GO


-- Step 5: Create Natively Compiled Procedure
-- Select and execute the following script to create a  Natively Compiled Procedure
CREATE PROCEDURE [MemoryOptimized].[spGetMemoryOptimizedProducts]
WITH NATIVE_COMPILATION, SCHEMABINDING
AS 
BEGIN ATOMIC WITH
	(
	 TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english'
	)
SELECT [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[ModifiedDate]
  FROM [MemoryOptimized].[Product]
END
GO

