#Requires -Version 7.0
#Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $txfilename)

# Get the SQL Server credentials
$sqlparms = ./Get-SQLCredential.ps1
$user     = $sqlparms['userid'] 
$pswd     = $sqlparms['password']
$server   = $sqlparms['server']

$linein = 1

# Process the Taxonomy Code File
get-content $txfilename | `
ConvertFrom-Csv | `
ForEach-Object { write-progress -Activity Processing -Status "Record: $linein";$linein++;Write-Output $_} | `
ConvertTo-Csv -UseQuotes Never -Delimiter '|' | Select-Object -Skip 1 | Out-File -FilePath .\tmp_txcodes.dat

bcp NPPES.dbo.txcodes IN .\tmp_txcodes.dat -f tx_format.xml -e error.dat -m 10 -U $user -P $pswd -S $server 
