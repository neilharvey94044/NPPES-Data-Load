USE NPPES
DROP TABLE [dbo].[zipgeo];
GO
CREATE TABLE [dbo].[zipgeo] (
	[Zip] numeric,
	[City] varchar(40),
	[State] varchar(2),
	[Latitude] float,
	[Longitude] float,
	[Timezone] int
);
GO
