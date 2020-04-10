#Requires -Version 7.0
# This script captures the SQL Server Credentials, stores them in an
# encrypted JSON file from which they are used for all following 
# operations that require them.

$server = Read-Host -Prompt 'Enter the server name for your SQL Server:' 
$user = Read-Host -Prompt 'Enter your SQL Server User ID:' -AsSecureString
$pwd = Read-Host -Prompt 'Enter your SQL Server Password:' -AsSecureString

# Encrypt the User Id and Password
$userencr = ConvertFrom-SecureString $user
$pwdencr = ConvertFrom-SecureString $pwd

# Write to a local JSON file
$pwdfile = @"
{
	"sqlserver": {
			"server": "$server",
			"userid": "$userencr",
			"password": "$pwdencr"
		     }
}
"@

Set-Content -Path passwords.json -Value $pwdfile


# Test getting the  sql info back
$sqlparms = ./Get-SQLCredential.ps1
$sqlparms
