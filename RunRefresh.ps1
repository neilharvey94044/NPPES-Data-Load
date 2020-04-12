#Requires -Version 7.0
# This script is a master that executes all the required scripts.
# Put along with all other scripts into a single directory.  Clean
# out old .dat, .csv, .zip files ahead of time.
# Rather than thinking of it as the one and only way to refresh
# the NPPES data, think of it as a model to follow for running the
# scripts for a full data refresh.  Comment out the scripts you don't need to run.
#
# This script assumes you have already captured your SQL Server credentials
# into password.json by running the script Put-SQLCredential.ps1

# URI for the Taxonomy codes - likely to change
$txcodesURI = "http://www.nucc.org/images/stories/CSV/nucc_taxonomy_200.csv"

# Step 1 - Download the necessary data
#./Get-NPIData.ps1 "March" "2020" $txcodesURI

# Step 2 - Start the SQL Server instance in Docker
#./Start-SQLServer.ps1

# Step 3 - Create the required tables
#./Create-Tables.ps1

# Step 4 - Filter and load the NPI data
#$npifilename = (Get-ChildItem npidata_pfile*.csv | Where-Object Name -NotLike "*FileHeader.csv").Name
#./Process-NPIData.ps1 $npifilename 31 "CA"

# Step 5 - Refactor the NPI data
#./Refactor-NPIData.ps1

# Step 6 - Load the taxonomy codes
$txcodesFileName = ([URI] $txcodesURI).LocalPath | Split-Path -Leaf
#./Process-TaxonomyCodes.ps1 $txcodesFileName

# Step 7 - Load the Provider Location file
$plfilename = (Get-ChildItem pl_pfile*.csv | Where-Object Name -NotLike "*FileHeader.csv").Name
./Process-ProvLocData.ps1 $plfilename 4 "CA"
