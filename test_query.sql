
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
