#Requires -Version 7.0
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $inputfile)

# Loads geocoded zip codes to the NPPES database.
# python script "Load-ZipcodeGeo.py".

# Get SQL credentials
$sqlparms = ./Get-SQLCredential.ps1
$server = $sqlparms['server']
$user   = $sqlparms['userid']
$pswd   = $sqlparms['password']


#################
python Load-ZipcodeGeo.py $inputfile $user $pswd $server
