#Requires -Version 7.0
#TODO: make filter optional in this script
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $plfilename, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filtercol, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filterval `
       )

[int] $numcols = 10 # update this value if number of columns in input file changes

# Parameters hardcoded for development and reference
#[string] $filtercol = "col4"
#[string] $filterval = "CA"

# Get SQL credentials
$sqlparms = ./Get-SQLCredential.ps1
$server = $sqlparms['server']
$user   = $sqlparms['userid']
$pswd   = $sqlparms['password']


[string[]] $csvheader= @()
for($i=0; $i -lt $numcols; $i++) 
{$csvheader += "col" + ($i+1)}

# Process the Provider Location datafile 
get-content $plfilename | select-object -skip 1 | `
ForEach-Object { write-progress -Activity Processing -Status "Record: $linein";$linein++;Write-Output $_} | `
ConvertFrom-Csv -Header $csvheader | `
Where-Object {$_.$filtercol -eq $filterval} | `
ForEach-Object { write-progress -Id 1 -Activity Writing -Status "Record: $lineout"; $lineout++; Write-Output $_} | `
ConvertTo-Csv -UseQuotes Never -Delimiter '|' | Select-Object -Skip 1 | Out-File -FilePath tmp_pl.dat

#Write-Host "Loading Provider Location data into SQL Server using bcp..."
bcp NPPES.dbo.prov_loc IN tmp_pl.dat -f prov_loc_format.xml -e error.dat -m 10 -U $user -P $pswd -S $server

