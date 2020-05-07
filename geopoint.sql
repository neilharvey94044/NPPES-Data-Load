USE NPPES;
ALTER TABLE dbo.npigeo
ADD Geopoint GEOGRAPHY;
GO

ALTER TABLE dbo.npigeo
ADD CONSTRAINT PK_NPIGEO_NPI PRIMARY KEY CLUSTERED (NPI);
GO

UPDATE [dbo].[npigeo]
SET [Geopoint] = geography::STPointFromText('POINT(' + CAST([Longitude] AS VARCHAR(20)) + ' ' + 
                    CAST([Latitude] AS VARCHAR(20)) + ')', 4326)
;
GO

Create Spatial Index geo_idx on [dbo].[npigeo] (Geopoint);
GO