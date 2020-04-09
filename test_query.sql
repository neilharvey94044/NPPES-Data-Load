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
GO
