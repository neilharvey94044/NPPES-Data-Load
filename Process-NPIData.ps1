#Requires -Version 7.0
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $npifilename, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filtercol, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $filterval `
       )

# Parameters hardcoded for development
#$csvfilename = "D:\dev\Health_Data\NPPES\NPPES_Data_Dissemination_March_2020\npidata_pfile_20050523-20200308.csv"
[int] $numcols = 330 # update this value if number of columns in input file changes
#[string] $filtercol = "col32"
#[string] $filterval = "CA"


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

bcp NPPES.dbo.npidata IN tmp_npi.dat -f npi_format.xml -e error.dat -m 10 -U sa -P Bracket4Tree@ -S 127.0.0.1
