#Requires -Version 7.0
# Sample query to quickly test out load and connectivity
$sqlparms = ./Get-SQLCredential.ps1
$user   = $sqlparms['userid']
$pswd   = $sqlparms['password']
$server = $sqlparms['server']

Write-Host "Processing nppes_database.sql"
sqlcmd -e -i test_query.sql -S $server -U $user -P $pswd 
