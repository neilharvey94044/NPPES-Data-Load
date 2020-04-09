-- This file contains multiple separate queries against the NPPES database
-- Each query should be run separately, which can easily be accomplished 
-- by loading this .sql file into Microsoft SQL Server Management Studio,
-- selecting the query, then clicking the "Execute" button.

-- Query Non-Organizational Providers and their Taxonomies
USE NPPES
select npi.NPI,
        concat(npi.Provider_Name_Prefix_Text, ' ',
		npi.Provider_First_Name,' ',
		npi.Provider_Last_Name, ' ',
		npi.Provider_Name_Suffix_Text) as Provider_Name,
		tx.Classification,
		tx.Specialization,
		npi.Provider_First_Line_Business_Practice_Location_Address as BusAddrl1,
		npi.Provider_Second_Line_Business_Practice_Location_Address as BusAddrl2,
		Provider_Business_Practice_Location_Address_City_Name as City,
	    tax.Provider_License_Number as licNum,
	    tax.Provider_License_Number_State_Code as State,
	    tax.Healthcare_Provider_Primary_Taxonomy_Switch as taxSwitch
From dbo.npidata npi, dbo.npi_taxonomy tax, dbo.txcodes tx
Where (npi.Entity_Type_Code = 1) and (npi.NPI = tax.NPI) and  (tax.Healthcare_Provider_Taxonomy_Code = tx.Code) 
Order by Provider_Business_Practice_Location_Address_City_Name;

-- Query Non-Organization Providers for their relationships with other Providers
USE NPPES
select npi.NPI, 
        concat(npi.Provider_Name_Prefix_Text, ' ',
		npi.Provider_First_Name,' ',
		npi.Provider_Last_Name,
		npi.Provider_Name_Suffix_Text) as Provider_Name,
		npi.Provider_First_Line_Business_Practice_Location_Address as BusAddrl1,
		npi.Provider_Second_Line_Business_Practice_Location_Address as BusAddrl2,
		Provider_Business_Practice_Location_Address_City_Name as City,
		oth.Other_Provider_Identifier as OthProvId,
		oth.Other_Provider_Identifier_Type_Code as OthProvTypeCd,
		oth.Other_Provider_Identifier_State as OthProvState,
		oth.Other_Provider_Identifier_Issuer as OthProvIssuer
from dbo.npidata npi, dbo.npi_oth_prov oth
Where npi.Entity_Type_Code = 1 and npi.NPI = oth.NPI
Order by npi.NPI;

-- find those Non-Organizational Providers who have identified more than 10 Taxonomies
USE NPPES
select npi.NPI,  
		concat(npi.Provider_Name_Prefix_Text, ' ',
		npi.Provider_First_Name,' ',
		npi.Provider_Last_Name,
		npi.Provider_Name_Suffix_Text) as Provider_Name,
		npi.Provider_Business_Practice_Location_Address_City_Name,
		COUNT(tax.Healthcare_Provider_Taxonomy_Code) as count_taxcodes
From dbo.npidata npi left outer join dbo.npi_taxonomy tax on npi.NPI = tax.NPI
where npi.Entity_Type_Code = 1
Group by npi.NPI, 
		 npi.Provider_Name_Prefix_Text,
		 npi.Provider_First_Name,
		 npi.Provider_Last_Name,
		 npi.Provider_Name_Suffix_Text,
		 npi.Provider_Business_Practice_Location_Address_City_Name
Having COUNT(tax.Healthcare_Provider_Taxonomy_Code) > 10
Order by count_taxcodes DESC;

-- Find the taxonomies for a single Non-Organizational Provider
USE NPPES
DECLARE @provider int
SET @provider = 1679550032
select DISTINCT npi.NPI,  
		concat(npi.Provider_Name_Prefix_Text, ' ',
		npi.Provider_First_Name,' ',
		npi.Provider_Last_Name,
		npi.Provider_Name_Suffix_Text) as Provider_Name,
		npi.Provider_Business_Practice_Location_Address_City_Name,
		tx.Code,
		tx.Classification,
		tx.Specialization
From dbo.npidata npi, dbo.npi_taxonomy tax, dbo.txcodes tx
Where npi.NPI = tax.NPI and tax.Healthcare_Provider_Taxonomy_Code = tx.Code
		and npi.Entity_Type_Code = 1
		and npi.NPI = @provider
;

-- Find Non-Organizational Providers with a specific Taxonomy in a specific city
-- In this case all forms of Psychologist in San Francisco
USE NPPES
DECLARE @code VARCHAR(12)
DECLARE @cityname VARCHAR(35)
SET @code = '103T%X'
SET @cityname = 'SAN FRANCISCO'
select DISTINCT npi.NPI,  
		concat(npi.Provider_Name_Prefix_Text, ' ',
		npi.Provider_First_Name,' ',
		npi.Provider_Last_Name,
		npi.Provider_Name_Suffix_Text) as Provider_Name,
		npi.Provider_Business_Practice_Location_Address_City_Name,
		tx.Code,
		tx.Classification,
		tx.Specialization
From dbo.npidata npi, dbo.npi_taxonomy tax, dbo.txcodes tx
Where npi.NPI = tax.NPI and tax.Healthcare_Provider_Taxonomy_Code = tx.Code
		and npi.Entity_Type_Code = 1
		and tx.Code LIKE @code
		and npi.Provider_Business_Practice_Location_Address_City_Name = @cityname
;

-- Find the number of Non-Organizational Providers for each City by Taxonomy
USE NPPES
select 
		npi.Provider_Business_Practice_Location_Address_City_Name
		,tx.Code
		,tx.Classification
		,tx.Specialization
		,count(tax.NPI) as Providers
From    dbo.txcodes tx join dbo.npi_taxonomy tax on tx.Code = tax.Healthcare_Provider_Taxonomy_Code
		join dbo.npidata npi on npi.NPI = tax.NPI
Where   npi.Entity_Type_Code = 1
Group by
		 npi.Provider_Business_Practice_Location_Address_City_Name
		,tx.Code 
		,tx.Classification
		,tx.Specialization
Order by 
		 npi.Provider_Business_Practice_Location_Address_City_Name
		,Providers DESC
;
-- Order by tx.Code;

-- Find the number of Non-Organizational Providers in a City for each Taxonomy
-- This query uses outer joins to provide zero values for those Taxonomies with
-- no Providers in the specified city.
USE NPPES
DECLARE @city NVARCHAR(50)
SET @city = 'SAN FRANCISCO'
select @city as City
	   ,tx.Code
	   ,tx.Classification
	   ,tx.Specialization
	   ,COUNT(npi.NPI) as prov_count
From	dbo.npidata npi right join dbo.npi_taxonomy tax on tax.NPI = npi.NPI
								and npi.Entity_Type_Code = 1
								and	npi.Provider_Business_Practice_Location_Address_City_Name IN (@city)
			right join dbo.txcodes tx on tx.Code = tax.Healthcare_Provider_Taxonomy_Code
								
Group by
	   npi.Provider_Business_Practice_Location_Address_City_Name,
	   tx.Code,
	   tx.Classification,
	   tx.Specialization
Order by 
	   COUNT(npi.NPI) DESC
;

-- Query Organization Providers with their Taxonomies (aka medical specialties)
USE NPPES
select npi.NPI,
        npi.Provider_Org_Name,
		tx.Classification,
		tx.Specialization,
		npi.Provider_First_Line_Business_Practice_Location_Address as BusAddrl1,
		npi.Provider_Second_Line_Business_Practice_Location_Address as BusAddrl2,
		Provider_Business_Practice_Location_Address_City_Name as City,
	    tax.Provider_License_Number as licNum,
	    tax.Provider_License_Number_State_Code as State,
	    tax.Healthcare_Provider_Primary_Taxonomy_Switch as taxSwitch
From dbo.npidata npi, dbo.npi_taxonomy tax, dbo.txcodes tx
Where (npi.Entity_Type_Code = 2) and (npi.NPI = tax.NPI) and  (tax.Healthcare_Provider_Taxonomy_Code = tx.Code) 
Order by npi.NPI;

-- find the 10 Organizational Providers who have identified the most relationships with other providers
USE NPPES
select top(10) npi.NPI
		,npi.Provider_Org_Name
		,npi.Provider_Business_Practice_Location_Address_City_Name as City_Name
		,COUNT(oth.Other_Provider_Identifier) as Oth_Count
From dbo.npidata npi left outer join dbo.npi_oth_prov oth on npi.NPI = oth.NPI
Where npi.Entity_Type_Code = 2
Group by npi.NPI, NPI.Provider_Org_Name, npi.Provider_Business_Practice_Location_Address_City_Name
Order by Oth_Count DESC;

-- find those Organizational Providers who have identified more than 10 Taxonomies
USE NPPES
select npi.NPI
		, npi.Provider_Org_Name
		, npi.Provider_Business_Practice_Location_Address_City_Name as City_Name
		, COUNT(tax.Healthcare_Provider_Taxonomy_Code) as Count_Taxonomies
From dbo.npidata npi left outer join dbo.npi_taxonomy tax on npi.NPI = tax.NPI
where npi.Entity_Type_Code = 2
Group by npi.NPI, NPI.Provider_Org_Name, npi.Provider_Business_Practice_Location_Address_City_Name
Having COUNT(tax.Healthcare_Provider_Taxonomy_Code) > 10
Order by Count_Taxonomies DESC;