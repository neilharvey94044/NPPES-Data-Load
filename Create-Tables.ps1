#Requires -Version 7.0
# Creates the NPPES tables
# CAUTION!!! - DROPS ALL THE EXISTING TABLES USED BY THIS DATA LOAD
$sqlparms = ./Get-SQLCredential.ps1
$user   = $sqlparms['userid']
$pswd   = $sqlparms['password']
$server = $sqlparms['server']

Write-Host "Processing nppes_database.sql"
sqlcmd -e -i nppes_database.sql -S $server -U $user -P $pswd 
Write-Host "Processing npidata_stage_tbl.sql"
sqlcmd -e -i npidata_stage_tbl.sql -S $server -U $user -P $pswd 
Write-Host "Processing npidata_tbls.sql"
sqlcmd -e -i npidata_tbls.sql -S $server -U $user -P $pswd 
Write-Host "Processing prov_loc_tbl.sql"
sqlcmd -e -i prov_loc_tbl.sql -S $server -U $user -P $pswd 
Write-Host "Processing txcodes_tbl.sql"
sqlcmd -e -i txcodes_tbl.sql -S $server -U $user -P $pswd 
