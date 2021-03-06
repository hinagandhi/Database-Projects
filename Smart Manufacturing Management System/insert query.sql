USE [master]
GO
/****** Object:  Database [SmartManufacturing]    Script Date: 12/17/2015 9:46:03 PM ******/
CREATE DATABASE [SmartManufacturing]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SmartManufacturing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SmartManufacturing.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SmartManufacturing_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SmartManufacturing_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SmartManufacturing] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SmartManufacturing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SmartManufacturing] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SmartManufacturing] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SmartManufacturing] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SmartManufacturing] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SmartManufacturing] SET ARITHABORT OFF 
GO
ALTER DATABASE [SmartManufacturing] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SmartManufacturing] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SmartManufacturing] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SmartManufacturing] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SmartManufacturing] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SmartManufacturing] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SmartManufacturing] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SmartManufacturing] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SmartManufacturing] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SmartManufacturing] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SmartManufacturing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SmartManufacturing] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SmartManufacturing] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SmartManufacturing] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SmartManufacturing] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SmartManufacturing] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SmartManufacturing] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SmartManufacturing] SET RECOVERY FULL 
GO
ALTER DATABASE [SmartManufacturing] SET  MULTI_USER 
GO
ALTER DATABASE [SmartManufacturing] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SmartManufacturing] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SmartManufacturing] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SmartManufacturing] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SmartManufacturing] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SmartManufacturing', N'ON'
GO
USE [SmartManufacturing]
GO
/****** Object:  User [userLogin]    Script Date: 12/17/2015 9:46:03 PM ******/
CREATE USER [userLogin] FOR LOGIN [userLogin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [tester]    Script Date: 12/17/2015 9:46:04 PM ******/
CREATE USER [tester] FOR LOGIN [tester] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [developer]    Script Date: 12/17/2015 9:46:04 PM ******/
CREATE USER [developer] FOR LOGIN [developer] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Administrator]    Script Date: 12/17/2015 9:46:04 PM ******/
CREATE USER [Administrator] FOR LOGIN [Administrator] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[drugQuantity]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[drugQuantity] (@drugName varchar(45), @warehouseID int)
returns int
as
begin
declare @quantity int
select @quantity = sum(drug.quantity) 
from drug where drug.drugName = @drugName
and drug.warehouseID = @warehouseID group by drug.drugName;
IF (@quantity IS NULL) 
SET @quantity = 0;
RETURN @quantity;
end;
GO
/****** Object:  Table [dbo].[DataFromSensor]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataFromSensor](
	[sensorID] [int] NOT NULL,
	[heatLevel] [float] NULL,
	[liquidLevel] [float] NULL,
	[mixingSpeedRate] [float] NULL,
	[chemicalComposition] [float] NULL,
	[energyConsumption] [float] NULL,
	[timestamps] [datetime] NOT NULL,
	[failure] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[sensorID] ASC,
	[timestamps] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Department]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(100000,1) NOT NULL,
	[DepartmentName] [varchar](45) NULL,
	[factoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DepartmentAcquiresDataFromSensor]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentAcquiresDataFromSensor](
	[DepartmentID] [int] NOT NULL,
	[SensorID] [int] NOT NULL,
	[heatLevel] [float] NULL,
	[liquidLevel] [float] NULL,
	[mixingSpeedRate] [float] NULL,
	[chemicalComposition] [float] NULL,
	[energyConsumption] [float] NULL,
	[timestamps] [datetime] NOT NULL,
	[failure] [int] NULL,
	[departmentName] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC,
	[SensorID] ASC,
	[timestamps] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Drug]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Drug](
	[batchNumber] [int] IDENTITY(10000,1) NOT NULL,
	[drugName] [varchar](45) NOT NULL,
	[quantity] [int] NOT NULL,
	[warehouseID] [int] NOT NULL,
	[manufacturedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[batchNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Factory]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Factory](
	[factoryID] [int] IDENTITY(1,1) NOT NULL,
	[factoryStreet] [varchar](45) NOT NULL,
	[factoryCity] [varchar](45) NOT NULL,
	[factoryState] [varchar](45) NOT NULL,
	[factoryzipcode] [varchar](45) NOT NULL,
	[factoryCountry] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[factoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[machineProducesDrugs]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[machineProducesDrugs](
	[machineryID] [int] NOT NULL,
	[batchNumber] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[machineryID] ASC,
	[batchNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Machinery]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Machinery](
	[machineryID] [int] IDENTITY(100,1) NOT NULL,
	[mahineryType] [varchar](45) NOT NULL,
	[machineWeight] [int] NOT NULL,
	[factoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[machineryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sensor]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sensor](
	[sensorID] [int] IDENTITY(1000,1) NOT NULL,
	[machineryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[sensorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[warehouse]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[warehouse](
	[warehouseID] [int] IDENTITY(10000,1) NOT NULL,
	[warehouseStreet] [varchar](45) NOT NULL,
	[warehouseCity] [varchar](45) NOT NULL,
	[warehouseState] [varchar](45) NOT NULL,
	[warehousezipcode] [varchar](45) NOT NULL,
	[warehouseCountry] [varchar](45) NOT NULL,
	[factoryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[warehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[DrugsInWarehouse]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[DrugsInWarehouse] as
select factory.factoryID, warehouse.warehouseID,
drug.batchNumber, drug.drugName from Factory join
warehouse on Factory.factoryID = warehouse.factoryID join
drug on Drug.warehouseID = warehouse.warehouseID
and factory.factoryID = '1' 

GO
/****** Object:  View [dbo].[SimpleSelectView]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[SimpleSelectView] as
select * from drug where quantity > 800


GO
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 23, 8, 14, 36, 1599, CAST(N'2015-12-15 01:14:52.570' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 673, 63, 11, 17, 573, CAST(N'2015-12-15 01:15:52.597' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 522, 94, 78, 15, 980, CAST(N'2015-12-15 01:16:52.660' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 140, 80, 79, 37, 598, CAST(N'2015-12-15 01:17:52.670' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 744, 63, 19, 1, 1097, CAST(N'2015-12-15 01:18:52.697' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 55, 8, 15, 48, 936, CAST(N'2015-12-15 01:19:52.710' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 327, 39, 77, 38, 135, CAST(N'2015-12-15 01:20:52.733' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 552, 25, 85, 34, 1181, CAST(N'2015-12-15 01:21:52.750' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 347, 75, 81, 4, 1047, CAST(N'2015-12-15 01:22:52.770' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 215, 32, 49, 18, 994, CAST(N'2015-12-15 01:23:52.793' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 416, 21, 47, 49, 885, CAST(N'2015-12-15 01:24:52.810' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 552, 99, 93, 4, 852, CAST(N'2015-12-15 01:25:52.840' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 607, 60, 26, 48, 1117, CAST(N'2015-12-15 01:26:52.857' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 724, 20, 9, 12, 896, CAST(N'2015-12-15 01:27:52.870' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 721, 98, 29, 5, 395, CAST(N'2015-12-15 01:28:52.893' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 100, 4, 17, 14, 199, CAST(N'2015-12-15 01:29:52.920' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 36, 35, 12, 44, 1186, CAST(N'2015-12-15 01:30:52.927' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 925, 86, 19, 22, 437, CAST(N'2015-12-15 01:31:52.943' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 900, 80, 91, 28, 1600, CAST(N'2015-12-17 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1000, 518, 33, 49, 19, 1334, CAST(N'2015-12-17 20:13:21.693' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 746, 85, 5, 35, 357, CAST(N'2015-12-15 01:14:52.573' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 575, 71, 92, 18, 1667, CAST(N'2015-12-15 01:15:52.643' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 273, 33, 64, 16, 1937, CAST(N'2015-12-15 01:16:52.660' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 671, 49, 96, 5, 1854, CAST(N'2015-12-15 01:17:52.677' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 189, 51, 40, 47, 1526, CAST(N'2015-12-15 01:18:52.697' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 128, 57, 90, 30, 1878, CAST(N'2015-12-15 01:19:52.710' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 883, 37, 57, 28, 349, CAST(N'2015-12-15 01:20:52.733' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 833, 96, 51, 33, 146, CAST(N'2015-12-15 01:21:52.753' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 600, 81, 36, 29, 1769, CAST(N'2015-12-15 01:22:52.770' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 488, 73, 46, 3, 613, CAST(N'2015-12-15 01:23:52.793' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 196, 16, 12, 10, 854, CAST(N'2015-12-15 01:24:52.813' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 550, 96, 10, 45, 476, CAST(N'2015-12-15 01:25:52.840' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 350, 49, 92, 16, 134, CAST(N'2015-12-15 01:26:52.857' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 699, 15, 91, 49, 538, CAST(N'2015-12-15 01:27:52.873' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 547, 69, 13, 43, 361, CAST(N'2015-12-15 01:28:52.893' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 569, 26, 84, 31, 502, CAST(N'2015-12-15 01:29:52.920' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 724, 19, 64, 21, 555, CAST(N'2015-12-15 01:30:52.927' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 550, 38, 37, 13, 1671, CAST(N'2015-12-15 01:31:52.943' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1001, 901, 81, 91, 41, 1800, CAST(N'2015-12-16 12:40:30.000' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 560, 41, 6, 35, 928, CAST(N'2015-12-15 01:14:52.573' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 216, 66, 20, 43, 1846, CAST(N'2015-12-15 01:15:52.647' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 255, 12, 90, 32, 854, CAST(N'2015-12-15 01:16:52.660' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 871, 5, 69, 17, 1415, CAST(N'2015-12-15 01:17:52.677' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 195, 3, 79, 9, 1142, CAST(N'2015-12-15 01:18:52.697' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 507, 63, 5, 28, 1037, CAST(N'2015-12-15 01:19:52.710' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 272, 71, 86, 41, 1046, CAST(N'2015-12-15 01:20:52.737' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 667, 93, 23, 3, 681, CAST(N'2015-12-15 01:21:52.753' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 444, 57, 92, 1, 1563, CAST(N'2015-12-15 01:22:52.770' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 250, 31, 96, 1, 1161, CAST(N'2015-12-15 01:23:52.797' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 869, 74, 38, 25, 375, CAST(N'2015-12-15 01:24:52.813' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 56, 87, 21, 19, 1703, CAST(N'2015-12-15 01:25:52.840' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 686, 10, 24, 8, 894, CAST(N'2015-12-15 01:26:52.860' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 598, 25, 65, 46, 1396, CAST(N'2015-12-15 01:27:52.873' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 483, 11, 86, 37, 781, CAST(N'2015-12-15 01:28:52.897' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 568, 47, 27, 45, 460, CAST(N'2015-12-15 01:29:52.920' AS DateTime), 0)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 184, 74, 3, 38, 337, CAST(N'2015-12-15 01:30:52.927' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 541, 36, 32, 28, 1379, CAST(N'2015-12-15 01:31:52.947' AS DateTime), 1)
INSERT [dbo].[DataFromSensor] ([sensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure]) VALUES (1002, 901, 87, 32, 28, 1680, CAST(N'2015-12-16 01:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [factoryID]) VALUES (100000, N'Mechanical Department', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [factoryID]) VALUES (100001, N'Medical Department', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [factoryID]) VALUES (100002, N'Electrical Department', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [factoryID]) VALUES (100003, N'Controller Department', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [factoryID]) VALUES (100004, N'IT department', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [factoryID]) VALUES (100005, N'Chemical Department', 1)
SET IDENTITY_INSERT [dbo].[Department] OFF
INSERT [dbo].[DepartmentAcquiresDataFromSensor] ([DepartmentID], [SensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure], [departmentName]) VALUES (100000, 1002, 901, 87, NULL, NULL, NULL, CAST(N'2015-12-16 01:00:00.000' AS DateTime), 0, N'Mechanical Department')
INSERT [dbo].[DepartmentAcquiresDataFromSensor] ([DepartmentID], [SensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure], [departmentName]) VALUES (100002, 1002, NULL, NULL, NULL, NULL, 1680, CAST(N'2015-12-16 01:00:00.000' AS DateTime), 0, N'Electrical Department')
INSERT [dbo].[DepartmentAcquiresDataFromSensor] ([DepartmentID], [SensorID], [heatLevel], [liquidLevel], [mixingSpeedRate], [chemicalComposition], [energyConsumption], [timestamps], [failure], [departmentName]) VALUES (100003, 1002, 901, 87, 32, 28, 1680, CAST(N'2015-12-16 01:00:00.000' AS DateTime), 0, N'Controller Department')
SET IDENTITY_INSERT [dbo].[Drug] ON 

INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10000, N'accupril', 1000, 10000, CAST(N'2015-12-14' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10001, N'benefix', 7000, 10000, CAST(N'2015-12-15' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10002, N'caverject', 700, 10001, CAST(N'2015-12-15' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10003, N'accupril', 100, 10000, CAST(N'2015-12-14' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10004, N'benefix', 800, 10000, CAST(N'2015-12-14' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10005, N'caverject', 1200, 10001, CAST(N'2015-12-15' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10007, N'antivenin', 200, 10001, CAST(N'2015-12-14' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10008, N'antivenin', 400, 10001, CAST(N'2015-12-15' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10009, N'accupril', 1500, 10001, CAST(N'2015-12-16' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10010, N'accupril', 200, 10003, CAST(N'2015-12-16' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10011, N'accupril', 600, 10003, CAST(N'2015-12-17' AS Date))
INSERT [dbo].[Drug] ([batchNumber], [drugName], [quantity], [warehouseID], [manufacturedDate]) VALUES (10012, N'paracetamol', 100, 10000, CAST(N'2015-12-18' AS Date))
SET IDENTITY_INSERT [dbo].[Drug] OFF
SET IDENTITY_INSERT [dbo].[Factory] ON 

INSERT [dbo].[Factory] ([factoryID], [factoryStreet], [factoryCity], [factoryState], [factoryzipcode], [factoryCountry]) VALUES (1, N'washington street', N'detroit', N'michigan', N'08906', N'USA')
INSERT [dbo].[Factory] ([factoryID], [factoryStreet], [factoryCity], [factoryState], [factoryzipcode], [factoryCountry]) VALUES (2, N'St. Peter street', N'Andover', N'MA', N'07768', N'USA')
INSERT [dbo].[Factory] ([factoryID], [factoryStreet], [factoryCity], [factoryState], [factoryzipcode], [factoryCountry]) VALUES (3, N'symphony street', N'pearl river', N'New York', N'08906', N'USA')
SET IDENTITY_INSERT [dbo].[Factory] OFF
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (103, 10000)
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (103, 10001)
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (103, 10009)
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (104, 10000)
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (104, 10001)
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (104, 10009)
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (105, 10000)
INSERT [dbo].[machineProducesDrugs] ([machineryID], [batchNumber]) VALUES (105, 10001)
SET IDENTITY_INSERT [dbo].[Machinery] ON 

INSERT [dbo].[Machinery] ([machineryID], [mahineryType], [machineWeight], [factoryID]) VALUES (101, N'Preparation Machinery', 90, 2)
INSERT [dbo].[Machinery] ([machineryID], [mahineryType], [machineWeight], [factoryID]) VALUES (102, N'Packing Machinery', 79, 2)
INSERT [dbo].[Machinery] ([machineryID], [mahineryType], [machineWeight], [factoryID]) VALUES (103, N'Tube filing Machinery', 110, 1)
INSERT [dbo].[Machinery] ([machineryID], [mahineryType], [machineWeight], [factoryID]) VALUES (104, N'Preparation Machinery', 90, 1)
INSERT [dbo].[Machinery] ([machineryID], [mahineryType], [machineWeight], [factoryID]) VALUES (105, N'Packing Machinery', 79, 1)
INSERT [dbo].[Machinery] ([machineryID], [mahineryType], [machineWeight], [factoryID]) VALUES (106, N'Drying Machinery', 120, 2)
SET IDENTITY_INSERT [dbo].[Machinery] OFF
SET IDENTITY_INSERT [dbo].[Sensor] ON 

INSERT [dbo].[Sensor] ([sensorID], [machineryID]) VALUES (1000, 103)
INSERT [dbo].[Sensor] ([sensorID], [machineryID]) VALUES (1001, 104)
INSERT [dbo].[Sensor] ([sensorID], [machineryID]) VALUES (1002, 105)
SET IDENTITY_INSERT [dbo].[Sensor] OFF
SET IDENTITY_INSERT [dbo].[warehouse] ON 

INSERT [dbo].[warehouse] ([warehouseID], [warehouseStreet], [warehouseCity], [warehouseState], [warehousezipcode], [warehouseCountry], [factoryID]) VALUES (10000, N'washington street', N'detroit', N'michigan', N'08906', N'USA', 1)
INSERT [dbo].[warehouse] ([warehouseID], [warehouseStreet], [warehouseCity], [warehouseState], [warehousezipcode], [warehouseCountry], [factoryID]) VALUES (10001, N'mainland street', N'detroit', N'michigan', N'08996', N'USA', 1)
INSERT [dbo].[warehouse] ([warehouseID], [warehouseStreet], [warehouseCity], [warehouseState], [warehousezipcode], [warehouseCountry], [factoryID]) VALUES (10002, N'new city street', N'detroit', N'michigan', N'9870', N'USA', 1)
INSERT [dbo].[warehouse] ([warehouseID], [warehouseStreet], [warehouseCity], [warehouseState], [warehousezipcode], [warehouseCountry], [factoryID]) VALUES (10003, N'mary street', N'maryland', N'MA', N'7890', N'USA', 2)
SET IDENTITY_INSERT [dbo].[warehouse] OFF
ALTER TABLE [dbo].[DataFromSensor]  WITH CHECK ADD  CONSTRAINT [fk_data] FOREIGN KEY([sensorID])
REFERENCES [dbo].[Sensor] ([sensorID])
GO
ALTER TABLE [dbo].[DataFromSensor] CHECK CONSTRAINT [fk_data]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [fk_department] FOREIGN KEY([factoryID])
REFERENCES [dbo].[Factory] ([factoryID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [fk_department]
GO
ALTER TABLE [dbo].[DepartmentAcquiresDataFromSensor]  WITH CHECK ADD  CONSTRAINT [fk_departmentID] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[DepartmentAcquiresDataFromSensor] CHECK CONSTRAINT [fk_departmentID]
GO
ALTER TABLE [dbo].[DepartmentAcquiresDataFromSensor]  WITH CHECK ADD  CONSTRAINT [fk_sensorID] FOREIGN KEY([SensorID])
REFERENCES [dbo].[Sensor] ([sensorID])
GO
ALTER TABLE [dbo].[DepartmentAcquiresDataFromSensor] CHECK CONSTRAINT [fk_sensorID]
GO
ALTER TABLE [dbo].[Drug]  WITH CHECK ADD  CONSTRAINT [fk_warehouseID] FOREIGN KEY([warehouseID])
REFERENCES [dbo].[warehouse] ([warehouseID])
GO
ALTER TABLE [dbo].[Drug] CHECK CONSTRAINT [fk_warehouseID]
GO
ALTER TABLE [dbo].[machineProducesDrugs]  WITH CHECK ADD  CONSTRAINT [fk_drugID] FOREIGN KEY([batchNumber])
REFERENCES [dbo].[Drug] ([batchNumber])
GO
ALTER TABLE [dbo].[machineProducesDrugs] CHECK CONSTRAINT [fk_drugID]
GO
ALTER TABLE [dbo].[machineProducesDrugs]  WITH CHECK ADD  CONSTRAINT [fk_machineryID] FOREIGN KEY([machineryID])
REFERENCES [dbo].[Machinery] ([machineryID])
GO
ALTER TABLE [dbo].[machineProducesDrugs] CHECK CONSTRAINT [fk_machineryID]
GO
ALTER TABLE [dbo].[Machinery]  WITH CHECK ADD  CONSTRAINT [fk_factoryID] FOREIGN KEY([factoryID])
REFERENCES [dbo].[Factory] ([factoryID])
GO
ALTER TABLE [dbo].[Machinery] CHECK CONSTRAINT [fk_factoryID]
GO
ALTER TABLE [dbo].[Sensor]  WITH CHECK ADD  CONSTRAINT [fk_machine] FOREIGN KEY([machineryID])
REFERENCES [dbo].[Machinery] ([machineryID])
GO
ALTER TABLE [dbo].[Sensor] CHECK CONSTRAINT [fk_machine]
GO
ALTER TABLE [dbo].[warehouse]  WITH CHECK ADD  CONSTRAINT [fk_factory] FOREIGN KEY([factoryID])
REFERENCES [dbo].[Factory] ([factoryID])
GO
ALTER TABLE [dbo].[warehouse] CHECK CONSTRAINT [fk_factory]
GO
/****** Object:  StoredProcedure [dbo].[AvailabilityStatus]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AvailabilityStatus]  @factoryID int
as
begin
select distinct drugName, 'ENOUGH STOCK' as 'Availability Status' from drug where drugName in (select drugName from drug join warehouse on  drug.warehouseID = warehouse.warehouseID join
factory on factory.factoryID = warehouse.factoryID and factory.factoryID = @factoryID group by drug.drugName
 having sum(drug.quantity) > 500
)

select distinct drugName, 'LOW STOCK' as 'Availability Status' from drug where drugName in (select drugName from drug join warehouse on  drug.warehouseID = warehouse.warehouseID join
factory on factory.factoryID = warehouse.factoryID and factory.factoryID = @factoryID group by drug.drugName
 having sum(drug.quantity) <= 500
)
end
GO
/****** Object:  StoredProcedure [dbo].[DrugQuantitycalculation]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DrugQuantitycalculation] @drugName varchar(45)
as
declare @warehouseID int
declare @quantity int
declare db_cursor_callingFunction cursor for
select distinct warehouse.warehouseID from warehouse join Drug on warehouse.warehouseID = Drug.warehouseID and 
drug.drugName = @drugName
open db_cursor_callingFunction 
fetch next from db_cursor_callingFunction into @warehouseID
WHILE @@FETCH_STATUS = 0   
begin
select distinct @drugName as drugName, @warehouseID as WarehouseID, warehouse.factoryID, 
dbo.drugQuantity(@drugName, @warehouseID) as TotalQuantity from
drug join warehouse on drug.warehouseID = warehouse.warehouseID and drug.drugName = @drugName
and drug.warehouseID = @warehouseID
fetch next from db_cursor_callingFunction into @warehouseID
END 
CLOSE db_cursor_callingFunction  
DEALLOCATE db_cursor_callingFunction
GO
/****** Object:  StoredProcedure [dbo].[fullBackup]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fullBackup]
as
begin
BACKUP DATABASE SmartManufacturing
TO DISK = 'C:\Users\hinag\Desktop\take home exam'
end
GO
/****** Object:  StoredProcedure [dbo].[generatingDataFromSensor]    Script Date: 12/17/2015 9:46:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[generatingDataFromSensor]
as
declare @sensorID int
DECLARE db_cursor cursor for
select sensorID from sensor 
open db_cursor
FETCH NEXT FROM db_cursor INTO @sensorID
WHILE @@FETCH_STATUS = 0   
BEGIN 
insert into datafromsensor values(@sensorID,FLOOR(RAND()*(1000 - 0) + 0),FLOOR(RAND()*(100 - 0) + 0),
FLOOR(RAND()*(100 - 0) + 0),FLOOR(RAND()*(50 - 0) + 0),FLOOR(RAND()*(2000 - 100) + 100),CURRENT_TIMESTAMP,FLOOR(RAND()*(2 - 0) + 0))
FETCH NEXT FROM db_cursor INTO @sensorID
END 
CLOSE db_cursor
deallocate db_cursor
GO
USE [master]
GO
ALTER DATABASE [SmartManufacturing] SET  READ_WRITE 
GO
