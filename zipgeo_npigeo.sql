-- Geocodes each No_Match address with a zip code geolocation.
-- Not the best solution, but good enough for my purposes.

USE NPPES;
Update dbo.npigeo
Set Longitude = zip.Longitude, Latitude = zip.Latitude
from dbo.npigeo as geo, dbo.npidata as npi, dbo.zipgeo as zip
where geo.Matchflag IN ('No_Match') and geo.NPI = npi.NPI
		and substring(npi.Provider_Business_Practice_Location_Address_Postal_Code, 1, 5)
			= zip.Zip
       and geo.Longitude is NULL
;

GO
