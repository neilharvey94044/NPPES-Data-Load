#Requires -Version 7.0
#TODO: make filter optional in this script
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $plfilename, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filtercol, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filterval `
       )

# Get SQL credentials
$sqlparms = ./Get-SQLCredential.ps1
$server = $sqlparms['server']
$user   = $sqlparms['userid']
$pswd   = $sqlparms['password']

python CleanCSV.py $plfilename "tmp_pl.dat" $filtercol $filterval

Write-Host "Loading Provider Location data into SQL Server using bcp..."
bcp NPPES.dbo.prov_loc IN tmp_pl.dat -f prov_loc_format.xml -e error.dat -m 10 -U $user -P $pswd -S $server

