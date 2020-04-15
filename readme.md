# NPPES Data Load
### **Project:** Batch Process for Loading Monthly NPPES Data Into SQL Server
### **Author**:     [Neil Harvey](https://www.linkedin.com/in/neil-harvey-07009a2a/)
### **Date**:       April 2020 (during Covid-19 Stay At Home Order)
### **Tools**:    Powershell 7 scripts, Transact-SQL, bcp, SQL Server 2019
### **What is NPPES-Data-Load?**
The National Plan and Provider Enumeration System (NPPES) maintains identifiers for all healthcare providers in the United States.  Each provider obtains a National Provider Identifier (NPI) stored in the NPPES.  This data provides detailed information about each provider, such as licensing, specialties, practice locations, points of contact, etc..  
More information on these files can be found at:  http://download.cms.gov/nppes/NPI_Files.html.   The NPPES also provides a [REST API](https://npiregistry.cms.hhs.gov/registry/help-api).  Additional info at [CMS Data Dissemination](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/DataDissemination)  

At time of this writing Taxonomy Codes can be found at [Taxonomy Codes](http://www.nucc.org/index.php/code-sets-mainmenu-41/provider-taxonomy-mainmenu-40/csv-mainmenu-57), this is likely to change.

  This project downloads and loads these files into a SQL Server Database.  The SQL Server I used is running in Docker desktop using image "mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04".  This approach requires that you have Docker Desktop running on a machine with Hyper-V, e.g. Windows 10 Pro, or Windows Server.  However, there is nothing stopping using these loads against any SQL Server implementation. 

#### Project Goals
- Each step should be scripted, requiring minimal or no human intervention
- Download and unzipping of the Monthly NPPES .csv data files:
  - National Provider Identifier (NPI) File
  - Other Name Reference File 
  - Practice Location Reference File
  - Endpoint Reference File
  - Taxonomy Codes
- Wrangle the .csv files into a format that can be loaded using bcp
- Optionally filter the data by a single state (e.g. CA)
- Create required database and tables in SQL Server
- bcp load into the SQL Server tables
- Provide some representative SQL queries against the data

#### Files and Steps
- **Put-SQLCredential.ps1**
  - Run this script to capture your SQL server credentials and server name.  These are encrypted, stored in passwords.json, and will automatically be used by all subsequent scripts.
- **RunRefresh.ps1**
  - Runs all child scripts and processes necessary to download, cleans, reformat, create necessary tables, and load the data.  Review the steps in this script to determine what steps to uncomment.  For example, starting the SQL Server instance is commented out.

- **npi_queries.sql**  
  - Contains several self contained SQL queries against the loaded data, with instructions.  I used Microsoft SQL Server Management Studio to run these.

- **Other files**
  - There are numerous other .sql, .ps1, and .py files.  However, all of the load is driven by RunRefresh.ps1 which should be your starting place to explore the process.


  #### See Also
  ### CAHealthFacilityDBLoad - process to load California healthcare facility, services, beds information to SQL Server.
  ### CAHealthREST - a REST API for the healthcare data.  Written in C# using ASP.NET Core.
  ### CAHealthQueries - C# queries against healthcare data.
