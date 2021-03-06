USE [master]
GO
/****** Object:  Database [ElectronicChipTattooSchema]    Script Date: 12/7/2015 8:32:59 PM ******/
CREATE DATABASE [ElectronicChipTattooSchema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ElectronicChipTattooSchema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ElectronicChipTattooSchema.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ElectronicChipTattooSchema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ElectronicChipTattooSchema_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ElectronicChipTattooSchema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET ARITHABORT OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET  MULTI_USER 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ElectronicChipTattooSchema]
GO
/****** Object:  User [saa]    Script Date: 12/7/2015 8:32:59 PM ******/
CREATE USER [saa] FOR LOGIN [saa] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[BrainWaves]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BrainWaves](
	[PatientID] [int] NULL,
	[ChipID] [int] NOT NULL,
	[Alpha] [float] NOT NULL,
	[Beta] [float] NOT NULL,
	[Gama] [float] NOT NULL,
	[Theta] [float] NOT NULL,
	[Delta] [float] NOT NULL,
	[TimeStamps] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChipID] ASC,
	[TimeStamps] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BrainWavesPeakValueMedicalHistory]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BrainWavesPeakValueMedicalHistory](
	[PatientID] [int] NOT NULL,
	[ChipID] [int] NOT NULL,
	[Alpha] [float] NOT NULL,
	[Beta] [float] NOT NULL,
	[Gama] [float] NOT NULL,
	[Theta] [float] NOT NULL,
	[Delta] [float] NOT NULL,
	[TimeStamps] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChipID] ASC,
	[TimeStamps] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chip]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chip](
	[ChipID] [int] IDENTITY(1000,1) NOT NULL,
	[ChipTypeID] [int] NOT NULL,
	[PatientID] [int] NOT NULL,
	[IntiatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ChipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChipType]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChipType](
	[ChipTypeID] [int] NOT NULL,
	[ChipType] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[ChipTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(100,1) NOT NULL,
	[DepartmentName] [varchar](45) NULL,
	[HospitalID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department_Has_Employees]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department_Has_Employees](
	[DepartmentID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1000,1) NOT NULL,
	[EmployeeTypeID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](45) NULL,
	[LastName] [varchar](45) NOT NULL,
	[PhoneNumber] [varchar](45) NULL,
	[EmailID] [varchar](45) NULL,
	[Street] [varchar](50) NULL,
	[HouseNumber] [int] NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZipCode] [int] NOT NULL,
	[Country] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee_Monitors_Chip]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Monitors_Chip](
	[ChipID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChipID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeType]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeType](
	[EmployeeTypeID] [int] NOT NULL,
	[EmployeeType] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Hospital]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Hospital](
	[HospitalID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](45) NULL,
	[PhoneNumber] [varchar](45) NULL,
	[FaxNumber] [varchar](45) NULL,
	[Street] [varchar](45) NULL,
	[HouseNumber] [int] NULL,
	[City] [varchar](45) NOT NULL,
	[State] [varchar](45) NOT NULL,
	[ZipCode] [int] NOT NULL,
	[Country] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HospitalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] IDENTITY(10000,1) NOT NULL,
	[PatientTypeID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NOT NULL,
	[PhoneNumber] [varchar](45) NOT NULL,
	[Age] [int] NULL,
	[Gender] [varchar](30) NULL,
	[EmailAddres] [varchar](45) NULL,
	[Street] [varchar](50) NULL,
	[HouseNumber] [int] NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZipCode] [int] NOT NULL,
	[Country] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientType]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientType](
	[PatientTypeID] [int] NOT NULL,
	[PatientType] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VitalSign]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VitalSign](
	[PatientID] [int] NULL,
	[ChipID] [int] NOT NULL,
	[HeartRate] [int] NOT NULL,
	[Temperature] [int] NOT NULL,
	[PulseRate] [int] NOT NULL,
	[RespirationRate] [int] NOT NULL,
	[BloodPressure] [float] NULL,
	[SugarLevel] [float] NOT NULL,
	[TimeStamps] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChipID] ASC,
	[TimeStamps] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VitalSignPeakValueMedicalHistory]    Script Date: 12/7/2015 8:33:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VitalSignPeakValueMedicalHistory](
	[PatientID] [int] NOT NULL,
	[ChipID] [int] NOT NULL,
	[HeartRate] [int] NOT NULL,
	[Temperature] [int] NOT NULL,
	[PulseRate] [int] NOT NULL,
	[RespirationRate] [int] NOT NULL,
	[BloodPressure] [float] NULL,
	[SugarLevel] [float] NOT NULL,
	[TimeStamps] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChipID] ASC,
	[TimeStamps] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Chip] ON 

INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1006, 1, 10000, CAST(N'2015-11-28 02:42:59.777' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1007, 2, 10000, CAST(N'2015-11-28 02:42:59.947' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1008, 1, 10001, CAST(N'2015-11-28 02:43:02.643' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1009, 1, 10002, CAST(N'2015-11-28 02:43:02.710' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1010, 2, 10002, CAST(N'2015-12-07 00:20:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1014, 1, 10005, CAST(N'2015-12-08 00:00:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1015, 2, 10005, CAST(N'2015-12-08 00:00:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1016, 1, 10006, CAST(N'2015-12-09 00:00:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1017, 1, 10007, CAST(N'2015-12-10 00:00:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1018, 2, 10007, CAST(N'2015-11-22 00:00:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1019, 1, 10008, CAST(N'2015-12-21 00:00:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1020, 2, 10008, CAST(N'2015-12-22 00:00:00.000' AS DateTime))
INSERT [dbo].[Chip] ([ChipID], [ChipTypeID], [PatientID], [IntiatedDate]) VALUES (1021, 1, 10009, CAST(N'2015-12-16 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Chip] OFF
INSERT [dbo].[ChipType] ([ChipTypeID], [ChipType]) VALUES (1, N'BrainWaves')
INSERT [dbo].[ChipType] ([ChipTypeID], [ChipType]) VALUES (2, N'VitalSigns')
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (103, N'Neurology', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (104, N'Gynaecology', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (105, N'Surgery', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (106, N'Anesthesia', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (107, N'Pediatrics', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (108, N'Nursing', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (110, N'Physiotherapy', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (111, N'Administration', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [HospitalID]) VALUES (112, N'Admission', 1)
SET IDENTITY_INSERT [dbo].[Department] OFF
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (103, 1000)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (103, 1001)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (104, 1003)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (104, 1004)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (105, 1005)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (105, 1006)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (106, 1007)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (106, 1009)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (107, 1010)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (107, 1011)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (108, 1012)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (108, 1013)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (110, 1014)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (110, 1016)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (111, 1001)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (111, 1017)
INSERT [dbo].[Department_Has_Employees] ([DepartmentID], [EmployeeID]) VALUES (112, 1005)
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1000, 1, N'A', N'A ', N'A', N'1', N'A', N'A', 23, N'A', N'MA', 912, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1001, 2, N'B', N'B', N'B', N'2', N'B', N'N', 34, N'M', N'KS', 232, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1003, 1, N'M', N'M', N'M', N'4', N'K', N'J', 33, N'K', N'M', 23, N'M')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1004, 2, N'A', N'Q', N'W', N'757-851-5452', N'C', N'Z', 95, N'WQ', N'BS', 2526, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1005, 1, N'L', N'K', N'H', N'515-854-8523', N'H', N'J', 85, N'A', N'MA', 2547, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1006, 2, N'M', N'H', N'T', N'852-752-9654', N'J', N'Y', 25, N'Z', N'Q', 7584, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1007, 1, N'J', N'T', N'C', N'545-965-5241', N'S', N'Q', 75, N'Z', N'G', 4526, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1009, 2, N'A', N'V', N'R', N'457-147-4126', N'Z', N'SD', 45, N'AS', N'MA', 4545, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1010, 1, N'Z', N'W', N'G', N'147-852-3697', N'CV', N'Q', 51, N'MN', N'LM', 2589, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1011, 2, N'S', N'V', N'L', N'745-854-2198', N'C', N'SA', 63, N'NC', N'K', 2526, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1012, 1, N'X', N'B', N'M', N'743-583-9571', N'M', N'K', 71, N'ML', N'P', 5471, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1013, 2, N'N', N'H', N'T', N'457-527-9365', N'Z', N'DS', 73, N'M', N'SA', 4812, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1014, 1, N'S', N'X', N'L', N'784-952-8461', N'P', N'U', 31, N'L', N'K', 8745, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1016, 2, N'Q', N'Y', N'B', N'457-741-963', N'A', N'X', 42, N'KL', N'SA', 7859, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1017, 1, N'O', N'Q', N'K', N'512-471-8946', N'Z', N'QW', 46, N'L', N'MA', 4715, N'USA')
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [EmailID], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1018, 2, N'W', N'E', N'R', N'745-896-325', N'Z', N'W', 74, N'S', N'MA', 7548, N'USA')
SET IDENTITY_INSERT [dbo].[Employee] OFF
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1006, 1000)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1006, 1001)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1007, 1003)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1007, 1004)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1008, 1005)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1008, 1006)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1009, 1007)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1009, 1009)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1010, 1010)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1010, 1011)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1014, 1012)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1014, 1013)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1015, 1014)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1015, 1016)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1016, 1001)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1016, 1017)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1017, 1003)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1017, 1004)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1018, 1005)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1018, 1006)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1019, 1007)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1019, 1009)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1020, 1010)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1020, 1011)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1021, 1012)
INSERT [dbo].[Employee_Monitors_Chip] ([ChipID], [EmployeeID]) VALUES (1021, 1013)
INSERT [dbo].[EmployeeType] ([EmployeeTypeID], [EmployeeType]) VALUES (1, N'Doctor')
INSERT [dbo].[EmployeeType] ([EmployeeTypeID], [EmployeeType]) VALUES (2, N'Nurse')
SET IDENTITY_INSERT [dbo].[Hospital] ON 

INSERT [dbo].[Hospital] ([HospitalID], [Name], [PhoneNumber], [FaxNumber], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (1, N'Hospital ABC', N'716-234-1234', N'22', N'Ac', 123, N'Boston', N'MA', 912712, N'USA')
SET IDENTITY_INSERT [dbo].[Hospital] OFF
SET IDENTITY_INSERT [dbo].[Patient] ON 

INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10000, 1, N'Akansha', N'S', N'VARMA', N'123-344-5324', 22, N'FEMALE', N'A', N'A', 12, N'A', N'A', 2148, N'A')
INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10001, 2, N'Varun', N'A', N'MALIK', N'345-234-1234', 44, N'MALE', N'V', N'V', 23, N'V', N'C', 9273, N'V')
INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10002, 1, N'Mallika', N'K', N'PATNICK', N'345-454-2343', 34, N'FEMALE', N'G', N'G', 44, N'V', N'3', 4566, N'B')
INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10005, 2, N'Saurabh', N'Chand ', N'Chandela', N'425-458-5471', 45, N'MALE', N'Q', N'D', 45, N'C', N'M', 2145, N'C')
INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10006, 1, N'Siddhi', N'Devi', N'Shree', N'122-457-8541', 59, N'FEMALE', N'N', N'09', 34, N'L', N'P', 3256, N'X')
INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10007, 1, N'Priya', N'Kumar', N'Bilal', N'757-454-5236', 25, N'FEMALE', N'K', N'L', 32, N'P', N'K', 2358, N'N')
INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10008, 2, N'Rohit', N'Nand', N'Kumar', N'547-856-9521', 26, N'MALE', N'I', N'F', 23, N'Q', N'Z', 5152, N'O')
INSERT [dbo].[Patient] ([PatientID], [PatientTypeID], [FirstName], [MiddleName], [LastName], [PhoneNumber], [Age], [Gender], [EmailAddres], [Street], [HouseNumber], [City], [State], [ZipCode], [Country]) VALUES (10009, 1, N'Hina', N'Bilawal', N'Bhutto', N'754-585-2165', 15, N'FEMALE', N'O', N'P', 75, N'H', N'T', 2589, N'V')
SET IDENTITY_INSERT [dbo].[Patient] OFF
INSERT [dbo].[PatientType] ([PatientTypeID], [PatientType]) VALUES (1, N'INPATIENT')
INSERT [dbo].[PatientType] ([PatientTypeID], [PatientType]) VALUES (2, N'OUTPATIENT')
/****** Object:  Index [fk_Chip_chip_idx]    Script Date: 12/7/2015 8:33:00 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [fk_Chip_chip_idx] ON [dbo].[Chip]
(
	[ChipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BrainWaves]  WITH CHECK ADD  CONSTRAINT [fk_ChipID] FOREIGN KEY([ChipID])
REFERENCES [dbo].[Chip] ([ChipID])
GO
ALTER TABLE [dbo].[BrainWaves] CHECK CONSTRAINT [fk_ChipID]
GO
ALTER TABLE [dbo].[BrainWavesPeakValueMedicalHistory]  WITH CHECK ADD  CONSTRAINT [fk_ChipID7] FOREIGN KEY([ChipID])
REFERENCES [dbo].[Chip] ([ChipID])
GO
ALTER TABLE [dbo].[BrainWavesPeakValueMedicalHistory] CHECK CONSTRAINT [fk_ChipID7]
GO
ALTER TABLE [dbo].[Chip]  WITH CHECK ADD  CONSTRAINT [fk_Chip_PatientID] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Chip] CHECK CONSTRAINT [fk_Chip_PatientID]
GO
ALTER TABLE [dbo].[Chip]  WITH CHECK ADD  CONSTRAINT [fk_ChipTypeID] FOREIGN KEY([ChipTypeID])
REFERENCES [dbo].[ChipType] ([ChipTypeID])
GO
ALTER TABLE [dbo].[Chip] CHECK CONSTRAINT [fk_ChipTypeID]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [fk_HospitalID] FOREIGN KEY([HospitalID])
REFERENCES [dbo].[Hospital] ([HospitalID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [fk_HospitalID]
GO
ALTER TABLE [dbo].[Department_Has_Employees]  WITH CHECK ADD  CONSTRAINT [fk_DepartmentID] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Department_Has_Employees] CHECK CONSTRAINT [fk_DepartmentID]
GO
ALTER TABLE [dbo].[Department_Has_Employees]  WITH CHECK ADD  CONSTRAINT [fk_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Department_Has_Employees] CHECK CONSTRAINT [fk_EmployeeID]
GO
ALTER TABLE [dbo].[Employee_Monitors_Chip]  WITH CHECK ADD  CONSTRAINT [fk_Employee_Monitors_Chip1] FOREIGN KEY([ChipID])
REFERENCES [dbo].[Chip] ([ChipID])
GO
ALTER TABLE [dbo].[Employee_Monitors_Chip] CHECK CONSTRAINT [fk_Employee_Monitors_Chip1]
GO
ALTER TABLE [dbo].[Employee_Monitors_Chip]  WITH CHECK ADD  CONSTRAINT [fk_Employee_Monitors_Chip2] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employee_Monitors_Chip] CHECK CONSTRAINT [fk_Employee_Monitors_Chip2]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [fk_PatientTypeID] FOREIGN KEY([PatientTypeID])
REFERENCES [dbo].[PatientType] ([PatientTypeID])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [fk_PatientTypeID]
GO
ALTER TABLE [dbo].[VitalSign]  WITH CHECK ADD  CONSTRAINT [fk_ChipID123] FOREIGN KEY([ChipID])
REFERENCES [dbo].[Chip] ([ChipID])
GO
ALTER TABLE [dbo].[VitalSign] CHECK CONSTRAINT [fk_ChipID123]
GO
ALTER TABLE [dbo].[VitalSignPeakValueMedicalHistory]  WITH CHECK ADD  CONSTRAINT [fk_ChipID78] FOREIGN KEY([ChipID])
REFERENCES [dbo].[Chip] ([ChipID])
GO
ALTER TABLE [dbo].[VitalSignPeakValueMedicalHistory] CHECK CONSTRAINT [fk_ChipID78]
GO
USE [master]
GO
ALTER DATABASE [ElectronicChipTattooSchema] SET  READ_WRITE 
GO
