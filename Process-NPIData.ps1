#Requires -Version 7.0
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $npifilename, `
        [Parameter(Mandatory=$False)] [ValidateNotNull()] [string] $filtercol, `
        [Parameter(Mandatory=$False)] [ValidateNotNull()] [string] $filterval `
       )

# Get SQL credentials
$sqlparms = ./Get-SQLCredential.ps1
$server = $sqlparms['server']
$user   = $sqlparms['userid']
$pswd   = $sqlparms['password']


# Process the NPI datafile; cleans and filters for the state of California
python CleanCSV.py $npifilename "tmp_npi.dat" $filtercol $filterval

Write-Host "Loading npidata into SQL Server using bcp..."
bcp NPPES.dbo.npidata_stage IN tmp_npi.dat -f npi_format.xml -e error.dat -m 10 -U $user -P $pswd -S $server

