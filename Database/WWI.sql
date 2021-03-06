USE [master]
GO
/****** Object:  Database [WWI]    Script Date: 28.05.2020 9:54:21 ******/
CREATE DATABASE [WWI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WWI', FILENAME = N'E:\sql-server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WWI.mdf' , SIZE = 204800KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WWI_log', FILENAME = N'E:\sql-server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WWI_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WWI] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WWI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WWI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WWI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WWI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WWI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WWI] SET ARITHABORT OFF 
GO
ALTER DATABASE [WWI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WWI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WWI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WWI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WWI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WWI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WWI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WWI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WWI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WWI] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WWI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WWI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WWI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WWI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WWI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WWI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WWI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WWI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WWI] SET  MULTI_USER 
GO
ALTER DATABASE [WWI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WWI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WWI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WWI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WWI] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WWI', N'ON'
GO
ALTER DATABASE [WWI] SET QUERY_STORE = OFF
GO
USE [WWI]
GO
/****** Object:  Schema [DW]    Script Date: 28.05.2020 9:54:21 ******/
CREATE SCHEMA [DW]
GO
/****** Object:  Schema [STG]    Script Date: 28.05.2020 9:54:21 ******/
CREATE SCHEMA [STG]
GO
/****** Object:  Table [DW].[InvoiceLines]    Script Date: 28.05.2020 9:54:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DW].[InvoiceLines](
	[InvoiceLineID] [int] NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[LineProfit] [decimal](18, 2) NOT NULL,
	[ExtendedPrice] [decimal](18, 2) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [DW].[Invoices]    Script Date: 28.05.2020 9:54:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DW].[Invoices](
	[InvoiceID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[BillToCustomerID] [int] NOT NULL,
	[OrderID] [int] NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[ContactPersonID] [int] NOT NULL,
	[AccountsPersonID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PackedByPersonID] [int] NOT NULL,
	[InvoiceDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsCreditNote] [bit] NOT NULL,
	[CreditNoteReason] [nvarchar](max) NULL,
	[Comments] [nvarchar](max) NULL,
	[DeliveryInstructions] [nvarchar](max) NULL,
	[InternalComments] [nvarchar](max) NULL,
	[TotalDryItems] [int] NOT NULL,
	[TotalChillerItems] [int] NOT NULL,
	[DeliveryRun] [nvarchar](5) NULL,
	[RunPosition] [nvarchar](5) NULL,
	[ReturnedDeliveryData] [nvarchar](max) NULL,
	[ConfirmedDeliveryTime] [datetime2](7) NULL,
	[ConfirmedReceivedBy] [nvarchar](4000) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [DW].[Orders]    Script Date: 28.05.2020 9:54:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DW].[Orders](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PickedByPersonID] [int] NULL,
	[ContactPersonID] [int] NOT NULL,
	[BackorderOrderID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[ExpectedDeliveryDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsUndersupplyBackordered] [bit] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[DeliveryInstructions] [nvarchar](max) NULL,
	[InternalComments] [nvarchar](max) NULL,
	[PickingCompletedWhen] [datetime2](7) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [DW].[SalesInvoiceLines]    Script Date: 28.05.2020 9:54:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DW].[SalesInvoiceLines](
	[InvoiceLineID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[LoadDate] [datetime] NOT NULL,
	[Source] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [STG].[InvoiceLines]    Script Date: 28.05.2020 9:54:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[InvoiceLines](
	[InvoiceLineID] [int] NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[LineProfit] [decimal](18, 2) NOT NULL,
	[ExtendedPrice] [decimal](18, 2) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [STG].[Invoices]    Script Date: 28.05.2020 9:54:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[Invoices](
	[InvoiceID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[BillToCustomerID] [int] NOT NULL,
	[OrderID] [int] NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[ContactPersonID] [int] NOT NULL,
	[AccountsPersonID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PackedByPersonID] [int] NOT NULL,
	[InvoiceDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsCreditNote] [bit] NOT NULL,
	[CreditNoteReason] [nvarchar](max) NULL,
	[Comments] [nvarchar](max) NULL,
	[DeliveryInstructions] [nvarchar](max) NULL,
	[InternalComments] [nvarchar](max) NULL,
	[TotalDryItems] [int] NOT NULL,
	[TotalChillerItems] [int] NOT NULL,
	[DeliveryRun] [nvarchar](5) NULL,
	[RunPosition] [nvarchar](5) NULL,
	[ReturnedDeliveryData] [nvarchar](max) NULL,
	[ConfirmedDeliveryTime]  AS (TRY_CONVERT([datetime2](7),json_value([ReturnedDeliveryData],N'$.DeliveredWhen'),(126))),
	[ConfirmedReceivedBy]  AS (json_value([ReturnedDeliveryData],N'$.ReceivedBy')),
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [STG].[Orders]    Script Date: 28.05.2020 9:54:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [STG].[Orders](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[SalespersonPersonID] [int] NOT NULL,
	[PickedByPersonID] [int] NULL,
	[ContactPersonID] [int] NOT NULL,
	[BackorderOrderID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[ExpectedDeliveryDate] [date] NOT NULL,
	[CustomerPurchaseOrderNumber] [nvarchar](20) NULL,
	[IsUndersupplyBackordered] [bit] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[DeliveryInstructions] [nvarchar](max) NULL,
	[InternalComments] [nvarchar](max) NULL,
	[PickingCompletedWhen] [datetime2](7) NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [WWI] SET  READ_WRITE 
GO
