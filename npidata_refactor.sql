-- Load the npidata table from the staging table
-- Does not include the Taxonomy and Other Provider entities
USE NPPES
Insert into dbo.npidata (	
    NPI,
    Entity_Type_Code,
	Replacement_NPI,
	Employer_Identification_Number,
	Provider_Org_Name,
	Provider_Last_Name,
	Provider_First_Name,
	Provider_Middle_Name,
	Provider_Name_Prefix_Text,
	Provider_Name_Suffix_Text,
	Provider_Credential_Text,
	Provider_Other_Organization_Name,
    Provider_Other_Organization_Name_Type_Code,
	Provider_Other_Last_Name,
	Provider_Other_First_Name,
	Provider_Other_Middle_Name,
	Provider_Other_Name_Prefix_Text,
	Provider_Other_Name_Suffix_Text,
	Provider_Other_Credential_Text,
	Provider_Other_Last_Name_Type_Code,
	Provider_First_Line_Business_Mailing_Address,
	Provider_Second_Line_Business_Mailing_Address,
	Provider_Business_Mailing_Address_City_Name,
	Provider_Business_Mailing_Address_State_Name,
	Provider_Business_Mailing_Address_Postal_Code,
	Provider_Business_Mailing_Address_Country_Code,
	Provider_Business_Mailing_Address_Telephone_Number,
	Provider_Business_Mailing_Address_Fax_Number,
	Provider_First_Line_Business_Practice_Location_Address,
	Provider_Second_Line_Business_Practice_Location_Address,
	Provider_Business_Practice_Location_Address_City_Name,
	Provider_Business_Practice_Location_Address_State_Name,
	Provider_Business_Practice_Location_Address_Postal_Code,
	Provider_Business_Practice_Location_Address_Country_Code,
	Provider_Business_Practice_Location_Address_Telephone_Number,
	Provider_Business_Practice_Location_Address_Fax_Number,
	Provider_Enumeration_Date,
	Last_Update_Date,
	NPI_Deactivation_Reason_Code,
	NPI_Deactivation_Date,
	NPI_Reactivation_Date,
	Provider_Gender_Code,
	Authorized_Official_Last_Name,
	Authorized_Official_First_Name,
	Authorized_Official_Middle_Name,
	Authorized_Official_Title_or_Position,
	Authorized_Official_Telephone_Number,
	Is_Sole_Proprietor,
	Is_Organization_Subpart,
	Parent_Organization_LBN,
	Parent_Organization_TIN,
	Authorized_Official_Name_Prefix_Text,
	Authorized_Official_Name_Suffix_Text,
	Authorized_Official_Credential_Text,
	Certification_Date
)
select
    NPI,
    Entity_Type_Code,
	Replacement_NPI,
	Employer_Identification_Number,
	Provider_Org_Name,
	Provider_Last_Name,
	Provider_First_Name,
	Provider_Middle_Name,
	Provider_Name_Prefix_Text,
	Provider_Name_Suffix_Text,
	Provider_Credential_Text,
	Provider_Other_Organization_Name,
    Provider_Other_Organization_Name_Type_Code,
	Provider_Other_Last_Name,
	Provider_Other_First_Name,
	Provider_Other_Middle_Name,
	Provider_Other_Name_Prefix_Text,
	Provider_Other_Name_Suffix_Text,
	Provider_Other_Credential_Text,
	Provider_Other_Last_Name_Type_Code,
	Provider_First_Line_Business_Mailing_Address,
	Provider_Second_Line_Business_Mailing_Address,
	Provider_Business_Mailing_Address_City_Name,
	Provider_Business_Mailing_Address_State_Name,
	Provider_Business_Mailing_Address_Postal_Code,
	Provider_Business_Mailing_Address_Country_Code,
	Provider_Business_Mailing_Address_Telephone_Number,
	Provider_Business_Mailing_Address_Fax_Number,
	Provider_First_Line_Business_Practice_Location_Address,
	Provider_Second_Line_Business_Practice_Location_Address,
	Provider_Business_Practice_Location_Address_City_Name,
	Provider_Business_Practice_Location_Address_State_Name,
	Provider_Business_Practice_Location_Address_Postal_Code,
	Provider_Business_Practice_Location_Address_Country_Code,
	Provider_Business_Practice_Location_Address_Telephone_Number,
	Provider_Business_Practice_Location_Address_Fax_Number,
	cast(Provider_Enumeration_Date as date),
	cast(Last_Update_Date as date),
	NPI_Deactivation_Reason_Code,
	cast(NPI_Deactivation_Date as date),
	cast(NPI_Reactivation_Date as date),
	Provider_Gender_Code,
	Authorized_Official_Last_Name,
	Authorized_Official_First_Name,
	Authorized_Official_Middle_Name,
	Authorized_Official_Title_or_Position,
	Authorized_Official_Telephone_Number,
	Is_Sole_Proprietor,
	Is_Organization_Subpart,
	Parent_Organization_LBN,
	Parent_Organization_TIN,
	Authorized_Official_Name_Prefix_Text,
	Authorized_Official_Name_Suffix_Text,
	Authorized_Official_Credential_Text,
	cast(Certification_Date as date)

from dbo.npidata_stage;
GO

-- Denormalize the taxonomy (aka provider specialty) fields into a separate table
-- This approach uses dynamic SQL to minimize redundancy in the code
DECLARE @template nvarchar(max);
DECLARE @sql nvarchar(max);

SET @template = N'

insert into dbo.npi_taxonomy (
	NPI,
	Healthcare_Provider_Taxonomy_Code,
	Provider_License_Number,
	Provider_License_Number_State_Code,
	Healthcare_Provider_Primary_Taxonomy_Switch,
    Healthcare_Provider_Taxonomy_Group
)
select 
	NPI,
	Healthcare_Provider_Taxonomy_Code_@anchor,
	Provider_License_Number_@anchor,
	Provider_License_Number_State_Code_@anchor,
	Healthcare_Provider_Primary_Taxonomy_Switch_@anchor,
    Healthcare_Provider_Taxonomy_Group_@anchor

from dbo.npidata_stage stage
where stage.Healthcare_Provider_Taxonomy_Code_@anchor IS NOT NULL;'

DECLARE @offset nvarchar(4);
DECLARE @counter INT = 1;
 
WHILE @counter <= 15
BEGIN
    SET @offset = ltrim(str(@counter));
	SET @sql = @template;
	SET @sql = REPLACE(@sql, '@anchor', @offset);
    EXEC sp_executesql @sql;
	SET @counter = @counter + 1;
END
GO

--
-- Denormalize the Other Provider information
--
--
USE NPPES
DECLARE @template2 nvarchar(max);
DECLARE @sql2 nvarchar(max);

SET @template2 = N'

insert into dbo.npi_oth_prov (
	NPI,
	Other_Provider_Identifier,
	Other_Provider_Identifier_Type_Code,
	Other_Provider_Identifier_State,
	Other_Provider_Identifier_Issuer
)
select 
	NPI,
    Other_Provider_Identifier_@anchor,
	Other_Provider_Identifier_Type_Code_@anchor,
	Other_Provider_Identifier_State_@anchor,
	Other_Provider_Identifier_Issuer_@anchor

from dbo.npidata_stage stage
where stage.Other_Provider_Identifier_@anchor IS NOT NULL;'

DECLARE @offset2 nvarchar(4);
DECLARE @counter2 INT = 1;
 
WHILE @counter2 <= 50
BEGIN
    SET @offset2 = ltrim(str(@counter2));
	SET @sql2 = @template2;
	SET @sql2 = REPLACE(@sql2, '@anchor', @offset2);
    EXEC sp_executesql @sql2;
	SET @counter2 = @counter2 + 1;
END
GO

-- Update Statistics on the tables loaded
USE NPPES
UPDATE STATISTICS dbo.npidata;
UPDATE STATISTICS dbo.npi_taxonomy;
UPDATE STATISTICS dbo.npi_oth_prov;
