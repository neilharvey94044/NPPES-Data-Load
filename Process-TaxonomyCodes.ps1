#Requires -Version 7.0
#Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $txfilename)

# Parameters hardcoded for development
$txfilename = "D:\dev\Health_Data\NPPES\NPPES_Data_Dissemination_March_2020\nucc_taxonomy_200.csv"
$linein = 1

# Process the Taxonomy Code File
get-content $txfilename | `
ConvertFrom-Csv | `
ForEach-Object { write-progress -Activity Processing -Status "Record: $linein";$linein++;Write-Output $_} | `
ConvertTo-Csv -UseQuotes Never -Delimiter '|' | Select-Object -Skip 1 | Out-File -FilePath .\tmp_txcodes.dat

bcp NPPES.dbo.txcodes IN .\tmp_txcodes.dat -f tx_format.xml -e error.dat -m 10 -U sa -P Bracket4Tree@ -S 127.0.0.1