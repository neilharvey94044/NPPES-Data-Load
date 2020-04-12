#Requires -Version 7.0
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $txfilename)

# Get the SQL Server credentials
$sqlparms = ./Get-SQLCredential.ps1
$user     = $sqlparms['userid'] 
$pswd     = $sqlparms['password']
$server   = $sqlparms['server']

python CleanCSV.py $txfilename "tmp_txcodes.dat"

bcp NPPES.dbo.txcodes IN .\tmp_txcodes.dat -f tx_format.xml -e error.dat -m 10 -U $user -P $pswd -S $server 
