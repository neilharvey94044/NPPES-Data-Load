-- Define the input type - a list of NPI values
Create Type npilist As Table
(NPI numeric);
GO

Create Procedure sp_provider
@npivalues npilist READONLY
AS

-- Get Attributes of Provider
Select npi.NPI
	,npi.Entity_Type_Code as Type
    ,npi.Provider_Name_Prefix_Text as NamePrefix
	,npi.Provider_First_Name as NameFirst
	,npi.Provider_Last_Name as NameLast
	,npi.Provider_Name_Suffix_Text as NameSuffix
    ,npi.Provider_Org_Name as OrgName
	,npi.Provider_First_Line_Business_Practice_Location_Address as AddrLine1
    ,npi.Provider_Second_Line_Business_Practice_Location_Address as AddrLine2
	,npi.Provider_Business_Practice_Location_Address_City_Name as AddrCity
    ,npi.Provider_Business_Practice_Location_Address_State_Name as AddrState
    ,npi.Provider_Business_Practice_Location_Address_Postal_Code as AddrZip
 From dbo.npidata as npi, @npivalues as prov
 Where prov.NPI = npi.NPI;

 -- Get Taxonomy of Provider
Select prov.NPI
	,tx.Healthcare_Provider_Taxonomy_Code as TxCode
	,txc.Classification
	,txc.Specialization
 From dbo.npi_taxonomy as tx, dbo.txcodes txc, @npivalues as prov
 Where prov.NPI = tx.NPI and tx.Healthcare_Provider_Taxonomy_Code = txc.Code;

  -- Get Relationships to other Providers
Select prov.NPI
	,oth.Other_Provider_Identifier as OthId
	,oth.Other_Provider_Identifier_Type_Code as OthTypeCode
	,oth.Other_Provider_Identifier_Issuer as OthIssuer
	,oth.Other_Provider_Identifier_State as OthState
 From dbo.npi_oth_prov as oth, @npivalues as prov
 Where prov.NPI = oth.NPI;
 GO

 -- Takes a single NPI and returns the provider
 Create Procedure sp_provider_get
 (@NPI numeric)
 AS

 Declare @npivalues npilist;
 Insert into @npivalues select @NPI;
 Execute sp_provider @npivalues;