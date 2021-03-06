USE [master]
GO
/****** Object:  Database [NPPES]    Script Date: 5/7/2020 9:58:24 AM ******/
CREATE DATABASE [NPPES]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NPPES', FILENAME = N'/var/opt/mssql/data/NPPES.mdf' , SIZE = 925696KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NPPES_log', FILENAME = N'/var/opt/mssql/data/NPPES_log.ldf' , SIZE = 860160KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [NPPES] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NPPES].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NPPES] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NPPES] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NPPES] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NPPES] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NPPES] SET ARITHABORT OFF 
GO
ALTER DATABASE [NPPES] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NPPES] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NPPES] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NPPES] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NPPES] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NPPES] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NPPES] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NPPES] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NPPES] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NPPES] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NPPES] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NPPES] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NPPES] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NPPES] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NPPES] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NPPES] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NPPES] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NPPES] SET RECOVERY FULL 
GO
ALTER DATABASE [NPPES] SET  MULTI_USER 
GO
ALTER DATABASE [NPPES] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NPPES] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NPPES] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NPPES] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NPPES] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NPPES', N'ON'
GO
ALTER DATABASE [NPPES] SET QUERY_STORE = OFF
GO
USE [NPPES]
GO
/****** Object:  Table [dbo].[ca_covid]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ca_covid](
	[COUNTY_NAME] [nvarchar](50) NOT NULL,
	[DATE] [date] NOT NULL,
	[TOTAL_COUNT_CONFIRMED] [int] NULL,
	[TOTAL_COUNT_DEATHS] [int] NULL,
	[COVID_19_POSITIVE_PATIENTS] [int] NULL,
	[SUSPECTED_COVID_19_POSITIVE_PATIENTS] [int] NULL,
	[ICU_COVID_19_POSITIVE_PATIENTS] [int] NULL,
	[ICU_COVID_19_SUSPECTED_PATIENTS] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cvt_current]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cvt_current](
	[state] [varchar](2) NULL,
	[positive] [int] NULL,
	[positiveScore] [smallint] NULL,
	[negativeScore] [smallint] NULL,
	[negativeRegularScore] [smallint] NULL,
	[commercialScore] [smallint] NULL,
	[grade] [varchar](1) NULL,
	[score] [smallint] NULL,
	[negative] [int] NULL,
	[pending] [smallint] NULL,
	[hospitalizedCurrently] [smallint] NULL,
	[hospitalizedCumulative] [int] NULL,
	[inIcuCurrently] [smallint] NULL,
	[inIcuCumulative] [smallint] NULL,
	[onVentilatorCurrently] [smallint] NULL,
	[onVentilatorCumulative] [smallint] NULL,
	[recovered] [smallint] NULL,
	[lastUpdateEt] [varchar](11) NULL,
	[checkTimeEt] [varchar](11) NULL,
	[death] [smallint] NULL,
	[hospitalized] [int] NULL,
	[total] [int] NULL,
	[totalTestResults] [int] NULL,
	[posNeg] [int] NULL,
	[fips] [smallint] NULL,
	[dateModified] [datetime] NULL,
	[dateChecked] [datetime] NULL,
	[notes] [varchar](81) NULL,
	[hash] [varchar](44) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cvt_history]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cvt_history](
	[date] [date] NULL,
	[state] [varchar](2) NULL,
	[positive] [int] NULL,
	[negative] [int] NULL,
	[pending] [int] NULL,
	[hospitalizedCurrently] [int] NULL,
	[hospitalizedCumulative] [int] NULL,
	[inIcuCurrently] [int] NULL,
	[inIcuCumulative] [int] NULL,
	[onVentilatorCurrently] [int] NULL,
	[onVentilatorCumulative] [int] NULL,
	[recovered] [int] NULL,
	[hash] [varchar](40) NULL,
	[dateChecked] [datetimeoffset](0) NULL,
	[death] [int] NULL,
	[hospitalized] [int] NULL,
	[total] [int] NULL,
	[totalTestResults] [int] NULL,
	[posNeg] [int] NULL,
	[fips] [int] NULL,
	[deathIncrease] [int] NULL,
	[hospitalizedIncrease] [int] NULL,
	[negativeIncrease] [int] NULL,
	[positiveIncrease] [int] NULL,
	[totalTestResultsIncrease] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[healthcare_facility_beds]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[healthcare_facility_beds](
	[FACID] [numeric](18, 0) NOT NULL,
	[FACNAME] [nvarchar](100) NOT NULL,
	[FAC_FDR] [nvarchar](50) NOT NULL,
	[BED_CAPACITY_TYPE] [nvarchar](50) NOT NULL,
	[COUNT_BEDS] [int] NOT NULL,
	[COUNTY_NAME] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[healthcare_facility_locations]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[healthcare_facility_locations](
	[FACID] [numeric](18, 0) NULL,
	[NPI] [numeric](18, 0) NULL,
	[FACNAME] [nvarchar](100) NOT NULL,
	[FAC_TYPE_CODE] [nvarchar](50) NOT NULL,
	[FAC_FDR] [nvarchar](50) NOT NULL,
	[LTC] [nvarchar](50) NOT NULL,
	[CAPACITY] [int] NOT NULL,
	[ADDRESS] [nvarchar](50) NOT NULL,
	[CITY] [nvarchar](50) NOT NULL,
	[ZIP] [int] NULL,
	[ZIP9] [int] NULL,
	[FACADMIN] [nvarchar](50) NULL,
	[CONTACT_EMAIL] [nvarchar](50) NULL,
	[CONTACT_FAX] [nvarchar](50) NULL,
	[CONTACT_PHONE_NUMBER] [nvarchar](50) NULL,
	[COUNTY_CODE] [nvarchar](50) NOT NULL,
	[COUNTY_NAME] [nvarchar](50) NOT NULL,
	[DISTRICT_NUMBER] [int] NULL,
	[DISTRICT_NAME] [nvarchar](50) NOT NULL,
	[ISFACMAIN] [nvarchar](50) NOT NULL,
	[LICENSE_NUMBER] [nvarchar](15) NULL,
	[BUSINESS_NAME] [nvarchar](100) NULL,
	[INITIAL_LICENSE_DATE] [date] NULL,
	[LICENSE_EFFECTIVE_DATE] [date] NULL,
	[LICENSE_EXPIRATION_DATE] [date] NULL,
	[ENTITY_TYPE_DESCRIPTION] [nvarchar](50) NULL,
	[LATITUDE] [float] NULL,
	[LONGITUDE] [float] NULL,
	[LOCATION] [nvarchar](50) NOT NULL,
	[OSHPD_ID] [nvarchar](15) NULL,
	[STREETNUM] [nvarchar](50) NOT NULL,
	[STREETNAME] [nvarchar](50) NOT NULL,
	[CCLHO_CODE] [nvarchar](50) NOT NULL,
	[CCLHO_NAME] [nvarchar](50) NOT NULL,
	[FIPS_COUNTY_CODE] [nvarchar](15) NOT NULL,
	[BIRTHING_FACILITY_FLAG] [nvarchar](50) NULL,
	[TRAUMA_PED_CTR] [nvarchar](50) NULL,
	[TRAUMA_CTR] [nvarchar](50) NULL,
	[TYPE_OF_CARE] [nvarchar](50) NULL,
	[CRITICAL_ACCESS_HOSPITAL] [nvarchar](50) NULL,
	[GEOPOINT] [geography] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[healthcare_facility_services]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[healthcare_facility_services](
	[FACID] [numeric](18, 0) NOT NULL,
	[FACNAME] [nvarchar](100) NOT NULL,
	[FAC_TYPE_CODE] [nvarchar](50) NOT NULL,
	[FAC_FDR] [nvarchar](50) NOT NULL,
	[SERVICE_TYPE_CODE] [nvarchar](50) NOT NULL,
	[SERVICE_TYPE_NAME] [nvarchar](100) NOT NULL,
	[SERVICE_OTHER_NAME] [nvarchar](50) NULL,
	[IS_OFFSITE_SERVICE] [nvarchar](50) NOT NULL,
	[OFFSITE_NAME] [nvarchar](100) NULL,
	[OFFSITE_ADDRESS1] [nvarchar](50) NULL,
	[OFFSITE_CITY] [nvarchar](50) NULL,
	[OFFSITE_STATE] [nvarchar](50) NULL,
	[OFFSITE_ZIP] [nvarchar](50) NULL,
	[COUNTY_NAME] [nvarchar](50) NOT NULL,
	[START_DATE] [date] NOT NULL,
	[LONGITUDE] [nvarchar](50) NULL,
	[LATITUDE] [nvarchar](50) NULL,
	[LOCATION] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[npi_oth_prov]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[npi_oth_prov](
	[NPI] [numeric](18, 0) NULL,
	[Other_Provider_Identifier] [varchar](20) NULL,
	[Other_Provider_Identifier_Type_Code] [varchar](2) NULL,
	[Other_Provider_Identifier_State] [varchar](2) NULL,
	[Other_Provider_Identifier_Issuer] [varchar](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[npi_taxonomy]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[npi_taxonomy](
	[NPI] [numeric](18, 0) NULL,
	[Healthcare_Provider_Taxonomy_Code] [varchar](10) NULL,
	[Provider_License_Number] [varchar](20) NULL,
	[Provider_License_Number_State_Code] [varchar](2) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch] [varchar](1) NULL,
	[Healthcare_Provider_Taxonomy_Group] [varchar](45) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[npidata]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[npidata](
	[NPI] [numeric](18, 0) NULL,
	[Entity_Type_Code] [int] NULL,
	[Replacement_NPI] [numeric](18, 0) NULL,
	[Employer_Identification_Number] [varchar](9) NULL,
	[Provider_Org_Name] [varchar](70) NULL,
	[Provider_Last_Name] [varchar](35) NULL,
	[Provider_First_Name] [varchar](20) NULL,
	[Provider_Middle_Name] [varchar](20) NULL,
	[Provider_Name_Prefix_Text] [varchar](5) NULL,
	[Provider_Name_Suffix_Text] [varchar](5) NULL,
	[Provider_Credential_Text] [varchar](20) NULL,
	[Provider_Other_Organization_Name] [varchar](70) NULL,
	[Provider_Other_Organization_Name_Type_Code] [varchar](1) NULL,
	[Provider_Other_Last_Name] [varchar](35) NULL,
	[Provider_Other_First_Name] [varchar](20) NULL,
	[Provider_Other_Middle_Name] [varchar](20) NULL,
	[Provider_Other_Name_Prefix_Text] [varchar](5) NULL,
	[Provider_Other_Name_Suffix_Text] [varchar](5) NULL,
	[Provider_Other_Credential_Text] [varchar](20) NULL,
	[Provider_Other_Last_Name_Type_Code] [int] NULL,
	[Provider_First_Line_Business_Mailing_Address] [varchar](55) NULL,
	[Provider_Second_Line_Business_Mailing_Address] [varchar](55) NULL,
	[Provider_Business_Mailing_Address_City_Name] [varchar](40) NULL,
	[Provider_Business_Mailing_Address_State_Name] [varchar](40) NULL,
	[Provider_Business_Mailing_Address_Postal_Code] [varchar](20) NULL,
	[Provider_Business_Mailing_Address_Country_Code] [varchar](2) NULL,
	[Provider_Business_Mailing_Address_Telephone_Number] [varchar](20) NULL,
	[Provider_Business_Mailing_Address_Fax_Number] [varchar](20) NULL,
	[Provider_First_Line_Business_Practice_Location_Address] [varchar](55) NULL,
	[Provider_Second_Line_Business_Practice_Location_Address] [varchar](55) NULL,
	[Provider_Business_Practice_Location_Address_City_Name] [varchar](40) NULL,
	[Provider_Business_Practice_Location_Address_State_Name] [varchar](40) NULL,
	[Provider_Business_Practice_Location_Address_Postal_Code] [varchar](20) NULL,
	[Provider_Business_Practice_Location_Address_Country_Code] [varchar](2) NULL,
	[Provider_Business_Practice_Location_Address_Telephone_Number] [varchar](20) NULL,
	[Provider_Business_Practice_Location_Address_Fax_Number] [varchar](20) NULL,
	[Provider_Enumeration_Date] [date] NULL,
	[Last_Update_Date] [date] NULL,
	[NPI_Deactivation_Reason_Code] [varchar](2) NULL,
	[NPI_Deactivation_Date] [date] NULL,
	[NPI_Reactivation_Date] [date] NULL,
	[Provider_Gender_Code] [varchar](1) NULL,
	[Authorized_Official_Last_Name] [varchar](35) NULL,
	[Authorized_Official_First_Name] [varchar](20) NULL,
	[Authorized_Official_Middle_Name] [varchar](20) NULL,
	[Authorized_Official_Title_or_Position] [varchar](35) NULL,
	[Authorized_Official_Telephone_Number] [varchar](20) NULL,
	[Is_Sole_Proprietor] [varchar](1) NULL,
	[Is_Organization_Subpart] [varchar](1) NULL,
	[Parent_Organization_LBN] [varchar](70) NULL,
	[Parent_Organization_TIN] [varchar](9) NULL,
	[Authorized_Official_Name_Prefix_Text] [varchar](5) NULL,
	[Authorized_Official_Name_Suffix_Text] [varchar](5) NULL,
	[Authorized_Official_Credential_Text] [varchar](20) NULL,
	[Certification_Date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[npidata_stage]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[npidata_stage](
	[NPI] [numeric](18, 0) NULL,
	[Entity_Type_Code] [int] NULL,
	[Replacement_NPI] [numeric](18, 0) NULL,
	[Employer_Identification_Number] [varchar](11) NULL,
	[Provider_Org_Name] [varchar](100) NULL,
	[Provider_Last_Name] [varchar](35) NULL,
	[Provider_First_Name] [varchar](25) NULL,
	[Provider_Middle_Name] [varchar](25) NULL,
	[Provider_Name_Prefix_Text] [varchar](20) NULL,
	[Provider_Name_Suffix_Text] [varchar](20) NULL,
	[Provider_Credential_Text] [varchar](50) NULL,
	[Provider_Other_Organization_Name] [varchar](100) NULL,
	[Provider_Other_Organization_Name_Type_Code] [varchar](30) NULL,
	[Provider_Other_Last_Name] [varchar](50) NULL,
	[Provider_Other_First_Name] [varchar](25) NULL,
	[Provider_Other_Middle_Name] [varchar](25) NULL,
	[Provider_Other_Name_Prefix_Text] [varchar](10) NULL,
	[Provider_Other_Name_Suffix_Text] [varchar](10) NULL,
	[Provider_Other_Credential_Text] [varchar](25) NULL,
	[Provider_Other_Last_Name_Type_Code] [int] NULL,
	[Provider_First_Line_Business_Mailing_Address] [varchar](100) NULL,
	[Provider_Second_Line_Business_Mailing_Address] [varchar](100) NULL,
	[Provider_Business_Mailing_Address_City_Name] [varchar](56) NULL,
	[Provider_Business_Mailing_Address_State_Name] [varchar](56) NULL,
	[Provider_Business_Mailing_Address_Postal_Code] [varchar](25) NULL,
	[Provider_Business_Mailing_Address_Country_Code] [varchar](50) NULL,
	[Provider_Business_Mailing_Address_Telephone_Number] [varchar](25) NULL,
	[Provider_Business_Mailing_Address_Fax_Number] [varchar](25) NULL,
	[Provider_First_Line_Business_Practice_Location_Address] [varchar](100) NULL,
	[Provider_Second_Line_Business_Practice_Location_Address] [varchar](100) NULL,
	[Provider_Business_Practice_Location_Address_City_Name] [varchar](55) NULL,
	[Provider_Business_Practice_Location_Address_State_Name] [varchar](40) NULL,
	[Provider_Business_Practice_Location_Address_Postal_Code] [varchar](25) NULL,
	[Provider_Business_Practice_Location_Address_Country_Code] [varchar](50) NULL,
	[Provider_Business_Practice_Location_Address_Telephone_Number] [varchar](25) NULL,
	[Provider_Business_Practice_Location_Address_Fax_Number] [varchar](25) NULL,
	[Provider_Enumeration_Date] [varchar](20) NULL,
	[Last_Update_Date] [varchar](20) NULL,
	[NPI_Deactivation_Reason_Code] [varchar](50) NULL,
	[NPI_Deactivation_Date] [varchar](20) NULL,
	[NPI_Reactivation_Date] [varchar](20) NULL,
	[Provider_Gender_Code] [varchar](50) NULL,
	[Authorized_Official_Last_Name] [varchar](35) NULL,
	[Authorized_Official_First_Name] [varchar](25) NULL,
	[Authorized_Official_Middle_Name] [varchar](25) NULL,
	[Authorized_Official_Title_or_Position] [varchar](50) NULL,
	[Authorized_Official_Telephone_Number] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_1] [varchar](50) NULL,
	[Provider_License_Number_1] [varchar](25) NULL,
	[Provider_License_Number_State_Code_1] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_1] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_2] [varchar](50) NULL,
	[Provider_License_Number_2] [varchar](25) NULL,
	[Provider_License_Number_State_Code_2] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_2] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_3] [varchar](50) NULL,
	[Provider_License_Number_3] [varchar](25) NULL,
	[Provider_License_Number_State_Code_3] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_3] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_4] [varchar](50) NULL,
	[Provider_License_Number_4] [varchar](25) NULL,
	[Provider_License_Number_State_Code_4] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_4] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_5] [varchar](50) NULL,
	[Provider_License_Number_5] [varchar](25) NULL,
	[Provider_License_Number_State_Code_5] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_5] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_6] [varchar](50) NULL,
	[Provider_License_Number_6] [varchar](25) NULL,
	[Provider_License_Number_State_Code_6] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_6] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_7] [varchar](50) NULL,
	[Provider_License_Number_7] [varchar](25) NULL,
	[Provider_License_Number_State_Code_7] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_7] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_8] [varchar](50) NULL,
	[Provider_License_Number_8] [varchar](25) NULL,
	[Provider_License_Number_State_Code_8] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_8] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_9] [varchar](50) NULL,
	[Provider_License_Number_9] [varchar](25) NULL,
	[Provider_License_Number_State_Code_9] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_9] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_10] [varchar](50) NULL,
	[Provider_License_Number_10] [varchar](25) NULL,
	[Provider_License_Number_State_Code_10] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_10] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_11] [varchar](50) NULL,
	[Provider_License_Number_11] [varchar](25) NULL,
	[Provider_License_Number_State_Code_11] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_11] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_12] [varchar](50) NULL,
	[Provider_License_Number_12] [varchar](25) NULL,
	[Provider_License_Number_State_Code_12] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_12] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_13] [varchar](50) NULL,
	[Provider_License_Number_13] [varchar](25) NULL,
	[Provider_License_Number_State_Code_13] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_13] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_14] [varchar](50) NULL,
	[Provider_License_Number_14] [varchar](25) NULL,
	[Provider_License_Number_State_Code_14] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_14] [varchar](50) NULL,
	[Healthcare_Provider_Taxonomy_Code_15] [varchar](50) NULL,
	[Provider_License_Number_15] [varchar](25) NULL,
	[Provider_License_Number_State_Code_15] [varchar](50) NULL,
	[Healthcare_Provider_Primary_Taxonomy_Switch_15] [varchar](50) NULL,
	[Other_Provider_Identifier_1] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_1] [varchar](50) NULL,
	[Other_Provider_Identifier_State_1] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_1] [varchar](100) NULL,
	[Other_Provider_Identifier_2] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_2] [varchar](50) NULL,
	[Other_Provider_Identifier_State_2] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_2] [varchar](100) NULL,
	[Other_Provider_Identifier_3] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_3] [varchar](50) NULL,
	[Other_Provider_Identifier_State_3] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_3] [varchar](100) NULL,
	[Other_Provider_Identifier_4] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_4] [varchar](50) NULL,
	[Other_Provider_Identifier_State_4] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_4] [varchar](100) NULL,
	[Other_Provider_Identifier_5] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_5] [varchar](50) NULL,
	[Other_Provider_Identifier_State_5] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_5] [varchar](100) NULL,
	[Other_Provider_Identifier_6] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_6] [varchar](50) NULL,
	[Other_Provider_Identifier_State_6] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_6] [varchar](100) NULL,
	[Other_Provider_Identifier_7] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_7] [varchar](50) NULL,
	[Other_Provider_Identifier_State_7] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_7] [varchar](100) NULL,
	[Other_Provider_Identifier_8] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_8] [varchar](50) NULL,
	[Other_Provider_Identifier_State_8] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_8] [varchar](100) NULL,
	[Other_Provider_Identifier_9] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_9] [varchar](50) NULL,
	[Other_Provider_Identifier_State_9] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_9] [varchar](100) NULL,
	[Other_Provider_Identifier_10] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_10] [varchar](50) NULL,
	[Other_Provider_Identifier_State_10] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_10] [varchar](100) NULL,
	[Other_Provider_Identifier_11] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_11] [varchar](50) NULL,
	[Other_Provider_Identifier_State_11] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_11] [varchar](100) NULL,
	[Other_Provider_Identifier_12] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_12] [varchar](50) NULL,
	[Other_Provider_Identifier_State_12] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_12] [varchar](100) NULL,
	[Other_Provider_Identifier_13] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_13] [varchar](50) NULL,
	[Other_Provider_Identifier_State_13] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_13] [varchar](100) NULL,
	[Other_Provider_Identifier_14] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_14] [varchar](50) NULL,
	[Other_Provider_Identifier_State_14] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_14] [varchar](100) NULL,
	[Other_Provider_Identifier_15] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_15] [varchar](50) NULL,
	[Other_Provider_Identifier_State_15] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_15] [varchar](100) NULL,
	[Other_Provider_Identifier_16] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_16] [varchar](50) NULL,
	[Other_Provider_Identifier_State_16] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_16] [varchar](100) NULL,
	[Other_Provider_Identifier_17] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_17] [varchar](50) NULL,
	[Other_Provider_Identifier_State_17] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_17] [varchar](100) NULL,
	[Other_Provider_Identifier_18] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_18] [varchar](50) NULL,
	[Other_Provider_Identifier_State_18] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_18] [varchar](100) NULL,
	[Other_Provider_Identifier_19] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_19] [varchar](50) NULL,
	[Other_Provider_Identifier_State_19] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_19] [varchar](100) NULL,
	[Other_Provider_Identifier_20] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_20] [varchar](50) NULL,
	[Other_Provider_Identifier_State_20] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_20] [varchar](100) NULL,
	[Other_Provider_Identifier_21] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_21] [varchar](50) NULL,
	[Other_Provider_Identifier_State_21] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_21] [varchar](100) NULL,
	[Other_Provider_Identifier_22] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_22] [varchar](50) NULL,
	[Other_Provider_Identifier_State_22] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_22] [varchar](100) NULL,
	[Other_Provider_Identifier_23] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_23] [varchar](50) NULL,
	[Other_Provider_Identifier_State_23] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_23] [varchar](100) NULL,
	[Other_Provider_Identifier_24] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_24] [varchar](50) NULL,
	[Other_Provider_Identifier_State_24] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_24] [varchar](100) NULL,
	[Other_Provider_Identifier_25] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_25] [varchar](50) NULL,
	[Other_Provider_Identifier_State_25] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_25] [varchar](100) NULL,
	[Other_Provider_Identifier_26] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_26] [varchar](50) NULL,
	[Other_Provider_Identifier_State_26] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_26] [varchar](100) NULL,
	[Other_Provider_Identifier_27] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_27] [varchar](50) NULL,
	[Other_Provider_Identifier_State_27] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_27] [varchar](100) NULL,
	[Other_Provider_Identifier_28] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_28] [varchar](50) NULL,
	[Other_Provider_Identifier_State_28] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_28] [varchar](100) NULL,
	[Other_Provider_Identifier_29] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_29] [varchar](50) NULL,
	[Other_Provider_Identifier_State_29] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_29] [varchar](100) NULL,
	[Other_Provider_Identifier_30] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_30] [varchar](50) NULL,
	[Other_Provider_Identifier_State_30] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_30] [varchar](100) NULL,
	[Other_Provider_Identifier_31] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_31] [varchar](50) NULL,
	[Other_Provider_Identifier_State_31] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_31] [varchar](100) NULL,
	[Other_Provider_Identifier_32] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_32] [varchar](50) NULL,
	[Other_Provider_Identifier_State_32] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_32] [varchar](100) NULL,
	[Other_Provider_Identifier_33] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_33] [varchar](50) NULL,
	[Other_Provider_Identifier_State_33] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_33] [varchar](100) NULL,
	[Other_Provider_Identifier_34] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_34] [varchar](50) NULL,
	[Other_Provider_Identifier_State_34] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_34] [varchar](100) NULL,
	[Other_Provider_Identifier_35] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_35] [varchar](50) NULL,
	[Other_Provider_Identifier_State_35] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_35] [varchar](100) NULL,
	[Other_Provider_Identifier_36] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_36] [varchar](50) NULL,
	[Other_Provider_Identifier_State_36] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_36] [varchar](100) NULL,
	[Other_Provider_Identifier_37] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_37] [varchar](50) NULL,
	[Other_Provider_Identifier_State_37] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_37] [varchar](100) NULL,
	[Other_Provider_Identifier_38] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_38] [varchar](50) NULL,
	[Other_Provider_Identifier_State_38] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_38] [varchar](100) NULL,
	[Other_Provider_Identifier_39] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_39] [varchar](50) NULL,
	[Other_Provider_Identifier_State_39] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_39] [varchar](100) NULL,
	[Other_Provider_Identifier_40] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_40] [varchar](50) NULL,
	[Other_Provider_Identifier_State_40] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_40] [varchar](100) NULL,
	[Other_Provider_Identifier_41] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_41] [varchar](50) NULL,
	[Other_Provider_Identifier_State_41] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_41] [varchar](100) NULL,
	[Other_Provider_Identifier_42] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_42] [varchar](50) NULL,
	[Other_Provider_Identifier_State_42] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_42] [varchar](100) NULL,
	[Other_Provider_Identifier_43] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_43] [varchar](50) NULL,
	[Other_Provider_Identifier_State_43] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_43] [varchar](100) NULL,
	[Other_Provider_Identifier_44] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_44] [varchar](50) NULL,
	[Other_Provider_Identifier_State_44] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_44] [varchar](100) NULL,
	[Other_Provider_Identifier_45] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_45] [varchar](50) NULL,
	[Other_Provider_Identifier_State_45] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_45] [varchar](100) NULL,
	[Other_Provider_Identifier_46] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_46] [varchar](50) NULL,
	[Other_Provider_Identifier_State_46] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_46] [varchar](100) NULL,
	[Other_Provider_Identifier_47] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_47] [varchar](50) NULL,
	[Other_Provider_Identifier_State_47] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_47] [varchar](100) NULL,
	[Other_Provider_Identifier_48] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_48] [varchar](50) NULL,
	[Other_Provider_Identifier_State_48] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_48] [varchar](100) NULL,
	[Other_Provider_Identifier_49] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_49] [varchar](50) NULL,
	[Other_Provider_Identifier_State_49] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_49] [varchar](100) NULL,
	[Other_Provider_Identifier_50] [varchar](50) NULL,
	[Other_Provider_Identifier_Type_Code_50] [varchar](50) NULL,
	[Other_Provider_Identifier_State_50] [varchar](50) NULL,
	[Other_Provider_Identifier_Issuer_50] [varchar](100) NULL,
	[Is_Sole_Proprietor] [varchar](50) NULL,
	[Is_Organization_Subpart] [varchar](50) NULL,
	[Parent_Organization_LBN] [varchar](80) NULL,
	[Parent_Organization_TIN] [varchar](80) NULL,
	[Authorized_Official_Name_Prefix_Text] [varchar](50) NULL,
	[Authorized_Official_Name_Suffix_Text] [varchar](50) NULL,
	[Authorized_Official_Credential_Text] [varchar](25) NULL,
	[Healthcare_Provider_Taxonomy_Group_1] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_2] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_3] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_4] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_5] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_6] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_7] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_8] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_9] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_10] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_11] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_12] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_13] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_14] [varchar](70) NULL,
	[Healthcare_Provider_Taxonomy_Group_15] [varchar](70) NULL,
	[Certification_Date] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[npigeo]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[npigeo](
	[NPI] [numeric](18, 0) NOT NULL,
	[Matchflag] [varchar](20) NULL,
	[Matchtype] [varchar](20) NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[Geopoint] [geography] NULL,
 CONSTRAINT [PK_NPIGEO_NPI] PRIMARY KEY CLUSTERED 
(
	[NPI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prov_loc]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prov_loc](
	[NPI] [numeric](18, 0) NULL,
	[Provider_Secondary_Practice_Location_Address_Line1] [varchar](55) NULL,
	[Provider_Secondary_Practice_Location_Address_Line2] [varchar](55) NULL,
	[Provider_Secondary_Practice_Location_Address_City_Name] [varchar](40) NULL,
	[Provider_Secondary_Practice_Location_Address_State_Name] [varchar](40) NULL,
	[Provider_Secondary_Practice_Location_Address_Postal_Code] [varchar](20) NULL,
	[Provider_Secondary_Practice_Location_Address_Country_Code] [varchar](2) NULL,
	[Provider_Secondary_Practice_Location_Address_Telephone_Number] [varchar](20) NULL,
	[Provider_Secondary_Practice_Location_Address_Telephone_Ext] [varchar](20) NULL,
	[Provider_Secondar_Practice_Location_Address_Fax_Number] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txcodes]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txcodes](
	[Code] [nchar](10) NULL,
	[Grouping] [nvarchar](80) NULL,
	[Classification] [nvarchar](110) NULL,
	[Specialization] [nvarchar](80) NULL,
	[Definition] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zipgeo]    Script Date: 5/7/2020 9:58:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zipgeo](
	[Zip] [numeric](18, 0) NULL,
	[City] [varchar](40) NULL,
	[State] [varchar](2) NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[Timezone] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [npi_oth_prov_idx]    Script Date: 5/7/2020 9:58:24 AM ******/
CREATE NONCLUSTERED INDEX [npi_oth_prov_idx] ON [dbo].[npi_oth_prov]
(
	[NPI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [npi_tax_idx]    Script Date: 5/7/2020 9:58:24 AM ******/
CREATE NONCLUSTERED INDEX [npi_tax_idx] ON [dbo].[npi_taxonomy]
(
	[NPI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [npi_idx]    Script Date: 5/7/2020 9:58:24 AM ******/
CREATE NONCLUSTERED INDEX [npi_idx] ON [dbo].[npidata]
(
	[NPI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [prov_loc_idx]    Script Date: 5/7/2020 9:58:24 AM ******/
CREATE NONCLUSTERED INDEX [prov_loc_idx] ON [dbo].[prov_loc]
(
	[NPI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [txcodes_idx]    Script Date: 5/7/2020 9:58:24 AM ******/
CREATE NONCLUSTERED INDEX [txcodes_idx] ON [dbo].[txcodes]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [geo_idx]    Script Date: 5/7/2020 9:58:24 AM ******/
CREATE SPATIAL INDEX [geo_idx] ON [dbo].[npigeo]
(
	[Geopoint]
)USING  GEOGRAPHY_AUTO_GRID 
WITH (
CELLS_PER_OBJECT = 12, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [NPPES] SET  READ_WRITE 
GO
