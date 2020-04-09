# Creates the NPPES tables
# CAUTION!!! - DROPS ALL THE EXISTING TABLES USED BY THIS DATA LOAD
$user = "sa"
$pswd = "Bracket4Tree@"
$server = "127.0.0.1"

Write-Host "Processing txcodes_tbl.sql"
sqlcmd -i txcodes_tbl.sql -b -e -S $server -U $user -P $pswd 
