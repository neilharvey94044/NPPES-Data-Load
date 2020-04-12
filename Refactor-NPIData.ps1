#Requires -Version 7.0
# This script de-normalizes the taxonomy and other provider information

# Get SQL credentials
$sqlparms = ./Get-SQLCredential.ps1
$server = $sqlparms['server']
$user   = $sqlparms['userid']
$pswd   = $sqlparms['password']

Write-Host "Refactoring npidata..."
sqlcmd -e -i npidata_refactor.sql -S $server -U $user -P $pswd
