# NPPES Data Load
### **Project:** Batch Process for Loading Monthly NPPES Data Into SQL Server
### **Author**:     [Neil Harvey](https://www.linkedin.com/in/neil-harvey-07009a2a/)
### **Date**:       April 2020 (during Covid-19 Stay At Home Order)
### **Tools**:    Powershell 7 scripts, Transact-SQL, bcp, SQL Server 2019
### **What is NPPES?**
The National Plan and Provider Enumeration System (NPPES) maintains identifiers for all healthcare providers in the United States.  Each provider obtains a National Provider Identifier (NPI) stored in the NPPES.  This data provides detailed information about each provider, such as licensing, specialties, practice locations, points of contact, etc.. More information on these files can be found at:  http://download.cms.gov/nppes/NPI_Files.html.  This project downloads and loads these files into a SQL Server Database.  The SQL Server I used is running in Docker desktop using image "mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04".  The NPPES also provides a [REST API](https://npiregistry.cms.hhs.gov/registry/help-api).  Additional info at [CMS Data Dissemination](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/DataDissemination)

#### Project Goals
- Each step should be scripted, requiring minimal or no human intervention
- Download and unzipping of the Monthly NPPES .csv data files:
  - National Provider Identifier (NPI) File
  - Other Name Reference File 
  - Practice Location Reference File
  - Endpoint Reference File
- Wrangle the .csv files into a format that can be loaded using bcp
- Optionally filter the data by a single state (e.g. CA)
- Create required database and tables in SQL Server
- bcp load into the SQL Server tables
- Provide some representative SQL queries against the data

#### Files and Steps
- **Start-SQLServer.ps1**
  - A sample script to start SQL Server in docker using a free Microsoft image running on Ubuntu.  This approach requires that you have Docker Desktop running on a machine with Hyper-V.
- **Create-Tables.ps1**
  - Creates the database (NPPES) and all required tables by running the sqlcmd against the following:
    - npidata_stage_tbl.sql
    - npidata_tbl.sql
    - prov_loc_stage_tbl.sql
    - prov_loc_tbl.sql
    - txcodes_tbl.sql
- **Process-NPIData.ps1**
  - Running this script downloads the npidata, unzips it, filters it by a state code ('CA' in this sample), then denormalizes and loads to the npidata, npi_taxonomy, npi_oth_prov, prov_loc tables.  You can remove the state code filter or change the state as meets your needs.  This is a lot of data so expect it to take a while and may require restarts and debugging. The othername and endpoint files are not loaded by this project, at this time.  As info the npidata can be found monthly at [NPPI Data ZIP](https://download.cms.gov/nppes/NPPES_Data_Dissemination_March_2020.zip), you will need to change the month and year in the .zip filename.
- **Process-TaxonomyCodes.ps1**
  - Running this script loads the taxonomy codes into the txcodes table.  This script assumes you have found and downloaded the Taxonomy codes csv file, the location of the file is in flux because the company providing it was hacked.  At time of this writing they can be found at [Taxonomy Codes](http://www.nucc.org/index.php/code-sets-mainmenu-41/provider-taxonomy-mainmenu-40/csv-mainmenu-57)
- **npi_queries.sql**
  - Contains several self contained SQL queries against the loaded data, with instructions.  I used Microsoft SQL Server Management Studio to run these.


  #### See Also
  ### ????? Project - a REST API against the npidata written in c# using ASP.NET Core.
