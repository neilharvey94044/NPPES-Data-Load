-- Returns a table of Provider NPI values for those
-- whos place of business is within @distance miles
-- of @zipcode.  These can be used to obtain details
-- about the providers.

USE NPPES;
GO
Create Procedure sp_npigeo_find
(@zipcode numeric,
 @distance int)
AS
		SET NOCOUNT ON;
		Declare @MetersPerMile FLOAT = 1609.344;
		Declare @zipLat Float;
		Declare @zipLong Float;

		Select	@zipLat = Latitude,
				@zipLong = Longitude
		From dbo.zipgeo zip
		where zip.Zip = @zipcode
		;

		Declare @geopoint as Geography;
		SET @geopoint = geography::STPointFromText('POINT(' + CAST(@zipLong AS VARCHAR(20)) + ' ' +
				CAST(@zipLat AS VARCHAR(20)) + ')', 4326);

		-- Get List of NPI key values for matching Providers
		Select geo.NPI
		 From dbo.npigeo as geo, dbo.npidata as npi
		Where @geopoint.STDistance(geo.Geopoint) < @MetersPerMile*@distance
				and geo.NPI = npi.NPI
				and npi.Entity_Type_Code = 1;
GO

-- Returns Provider details for those providers within @distance in miles
-- from @zipcode
Create Procedure sp_npigeo_get
(@zipcode numeric,
@distance int)
AS

		SET NOCOUNT ON;
		-- Find the Providers
		Declare @npivalues as npilist;
		Insert Into @npivalues Execute sp_npigeo_find @zipcode = @zipcode, @distance = @distance;

		-- Get Details about the Providers
		Execute sp_provider @npivalues;

