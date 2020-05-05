USE NPPES
DROP TABLE [dbo].[npigeo];
GO
CREATE TABLE [dbo].[npigeo] (
	[NPI] numeric not null,
	[Matchflag] varchar(20) null,
	[Matchtype] varchar(20) null,
	[Longitude] float null,
	[Latitude] float null
);
GO
