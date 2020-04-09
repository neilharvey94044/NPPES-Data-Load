IF DB_ID('NPPES') IS NOT NULL
   print 'The NPPES database already exists'
ELSE
   CREATE DATABASE [NPPES];
GO
