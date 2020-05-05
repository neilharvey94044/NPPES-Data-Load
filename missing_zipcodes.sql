-- Shows the zip codes that could not be found and geocoded.
-- Spot checking these with the USPS shows many are erroneous/invalid zip codes.

USE NPPES
select

	distinct substring(npi.Provider_Business_Practice_Location_Address_Postal_Code,1,5) as Zip


from dbo.npigeo as geo, dbo.npidata as npi
where geo.Matchflag IN ('No_Match') and geo.NPI = npi.NPI
       and geo.Longitude is NULL
;

GO
