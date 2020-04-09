USE NPPES
DROP TABLE [dbo].[prov_loc_stage]; 
GO
CREATE TABLE [dbo].[prov_loc_stage] (
	[NPI] numeric,
	[Provider_Secondary_Practice_Location_Address_Line1] varchar(100),
	[Provider_Secondary_Practice_Location_Address_Line2] varchar(100),
	[Provider_Secondary_Practice_Location_Address_City_Name] varchar(55),
	[Provider_Secondary_Practice_Location_Address_State_Name] varchar(40),
	[Provider_Secondary_Practice_Location_Address_Postal_Code] varchar(25),
	[Provider_Secondary_Practice_Location_Address_Country_Code] varchar(50),
	[Provider_Secondary_Practice_Location_Address_Telephone_Number] varchar(25),
	[Provider_Secondary_Practice_Location_Address_Telephone_Ext] varchar(25),
	[Provider_Secondar_Practice_Location_Address_Fax_Number] varchar(25),
)
CREATE INDEX prov_loc_idx on [dbo].[prov_loc_stage] (NPI);
GO
