
DECLARE @MetersPerMile FLOAT = 1609.344;
DECLARE @Miles Float = 2
Declare @geopoint as Geography;
SET @geopoint =  geography::STPointFromText('POINT(-119.639658 36.746375)', 4326);

Select geo.NPI
		,geo.Longitude
		,geo.Latitude
		,npi.Provider_Org_Name
		,npi.Provider_First_Line_Business_Practice_Location_Address
		,npi.Provider_Business_Practice_Location_Address_City_Name
From dbo.npigeo as geo, dbo.npidata as npi
Where @geopoint.STDistance(geo.Geopoint) < @MetersPerMile*@Miles
	 and geo.NPI = npi.NPI
	 and npi.Entity_Type_Code = 2
;