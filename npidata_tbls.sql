USE NPPES
DROP TABLE [dbo].[npidata];
CREATE TABLE [dbo].[npidata] (
	[NPI] numeric,
	[Entity_Type_Code] int,
	[Replacement_NPI] numeric,
	[Employer_Identification_Number] varchar(9),
	[Provider_Org_Name] varchar(70),
	[Provider_Last_Name] varchar(35),
	[Provider_First_Name] varchar(20),
	[Provider_Middle_Name] varchar(20),
	[Provider_Name_Prefix_Text] varchar(5),
	[Provider_Name_Suffix_Text] varchar(5),
	[Provider_Credential_Text] varchar(20),
	[Provider_Other_Organization_Name] varchar(70),
	[Provider_Other_Organization_Name_Type_Code] varchar(1),
	[Provider_Other_Last_Name] varchar(35),
	[Provider_Other_First_Name] varchar(20),
	[Provider_Other_Middle_Name] varchar(20),
	[Provider_Other_Name_Prefix_Text] varchar(5),
	[Provider_Other_Name_Suffix_Text] varchar(5),
	[Provider_Other_Credential_Text] varchar(20),
	[Provider_Other_Last_Name_Type_Code] int,
	[Provider_First_Line_Business_Mailing_Address] varchar(55),
	[Provider_Second_Line_Business_Mailing_Address] varchar(55),
	[Provider_Business_Mailing_Address_City_Name] varchar(40),
	[Provider_Business_Mailing_Address_State_Name] varchar(40),
	[Provider_Business_Mailing_Address_Postal_Code] varchar(20),
	[Provider_Business_Mailing_Address_Country_Code] varchar(2),
	[Provider_Business_Mailing_Address_Telephone_Number] varchar(20),
	[Provider_Business_Mailing_Address_Fax_Number] varchar(20),
	[Provider_First_Line_Business_Practice_Location_Address] varchar(55),
	[Provider_Second_Line_Business_Practice_Location_Address] varchar(55),
	[Provider_Business_Practice_Location_Address_City_Name] varchar(40),
	[Provider_Business_Practice_Location_Address_State_Name] varchar(40),
	[Provider_Business_Practice_Location_Address_Postal_Code] varchar(20),
	[Provider_Business_Practice_Location_Address_Country_Code] varchar(2),
	[Provider_Business_Practice_Location_Address_Telephone_Number] varchar(20),
	[Provider_Business_Practice_Location_Address_Fax_Number] varchar(20),
	[Provider_Enumeration_Date] date,
	[Last_Update_Date] date,
	[NPI_Deactivation_Reason_Code] varchar(2),
	[NPI_Deactivation_Date] date,
	[NPI_Reactivation_Date] date,
	[Provider_Gender_Code] varchar(1),
	[Authorized_Official_Last_Name] varchar(35),
	[Authorized_Official_First_Name] varchar(20),
	[Authorized_Official_Middle_Name] varchar(20),
	[Authorized_Official_Title_or_Position] varchar(35),
	[Authorized_Official_Telephone_Number] varchar(20),
	[Is_Sole_Proprietor] varchar(1),
	[Is_Organization_Subpart] varchar(1),
	[Parent_Organization_LBN] varchar(70),
	[Parent_Organization_TIN] varchar(9),
	[Authorized_Official_Name_Prefix_Text] varchar(5),
	[Authorized_Official_Name_Suffix_Text] varchar(5),
	[Authorized_Official_Credential_Text] varchar(20),
    [Certification_Date] date
)
USE NPPES
CREATE INDEX npi_idx on [dbo].[npidata] (NPI);

USE NPPES
DROP TABLE [dbo].[npi_taxonomy];
CREATE TABLE [dbo].[npi_taxonomy] (
	[NPI] numeric,
	[Healthcare_Provider_Taxonomy_Code] varchar(10),
	[Provider_License_Number] varchar(20),
	[Provider_License_Number_State_Code] varchar(2),
	[Healthcare_Provider_Primary_Taxonomy_Switch] varchar(1),
    [Healthcare_Provider_Taxonomy_Group] varchar(45)
)
USE NPPES
CREATE INDEX npi_tax_idx on [dbo].[npi_taxonomy] (NPI);

USE NPPES
DROP TABLE [dbo].[npi_oth_prov];
CREATE TABLE [dbo].[npi_oth_prov] (
	[NPI] numeric,
	[Other_Provider_Identifier] varchar(20),
	[Other_Provider_Identifier_Type_Code] varchar(2),
	[Other_Provider_Identifier_State] varchar(2),
	[Other_Provider_Identifier_Issuer] varchar(80)
)
USE NPPES
CREATE INDEX npi_oth_prov_idx on [dbo].[npi_oth_prov] (NPI);
