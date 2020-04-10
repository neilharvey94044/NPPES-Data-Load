#Requires -Version 7.0
#TODO: make filter optional in this script
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $npifilename, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filtercol, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filterval `
       )

[int] $numcols = 330 # update this value if number of columns in input file changes

# Parameters hardcoded for development and reference
#[string] $filtercol = "col32"
#[string] $filterval = "CA"

# Get SQL credentials
$sqlparms = ./Get-SQLCredential.ps1
$server = $sqlparms['server']
$user   = $sqlparms['userid']
$pswd   = $sqlparms['sserver']


[string[]] $csvheader= @()
for($i=0; $i -lt $numcols; $i++) 
{$csvheader += "col" + ($i+1)}

# Process the NPI datafile; output the new file to stdout
get-content $npifilename | select-object -skip 1 | `
ForEach-Object { write-progress -Activity Processing -Status "Record: $linein";$linein++;Write-Output $_} | `
ConvertFrom-Csv -Header $csvheader | `
Where-Object {$_.$filtercol -eq $filterval} | `
ForEach-Object { write-progress -Id 1 -Activity Writing -Status "Record: $lineout"; $lineout++; Write-Output $_} | `
ConvertTo-Csv -UseQuotes Never -Delimiter '|' | Select-Object -Skip 1 | Out-File -FilePath tmp_npi.dat

Write-Host "Loading npidata into SQL Server using bcp..."
bcp NPPES.dbo.npidata IN tmp_npi.dat -f npi_format.xml -e error.dat -m 10 -U $user -P $pswd -S $server

