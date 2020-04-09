
USE NPPES
DROP TABLE [dbo].[txcodes];
CREATE TABLE [dbo].txcodes (
Code NCHAR(10),
Grouping NVARCHAR(80),
Classification NVARCHAR(110),
Specialization NVARCHAR(80),
Definition NVARCHAR(MAX)
);
USE NPPES
CREATE INDEX txcodes_idx on [dbo].[txcodes](Code);