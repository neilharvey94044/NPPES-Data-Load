# This script captures the SQL Server Credentials, stores them in an
# encrypted JSON file from which they are used for all following 
# operations that require them.

$user = Read-Host -Prompt 'Enter your SQL Server User ID:' -AsSecureString
$pwd = Read-Host -Prompt 'Enter your SQL Server Password:' -AsSecureString

# Encrypt the User Id and Password
$userencr = ConvertFrom-SecureString $user
$pwdencr = ConvertFrom-SecureString $pwd

# Write to a local JSON file
$pwdfile = @"
{
	"sqlserver": {
			"userid": "$userencr",
			"password": "$pwdencr"
		     }
}
"@

Set-Content -Path passwords.json -Value $pwdfile



## Use the following code to recover the plain text version and use to logon
$pwdfile = Get-Content -Path .\passwords.json -raw | ConvertFrom-Json
$pwdss = ConvertTo-SecureString $pwdfile.sqlserver.password 
$userss = ConvertTo-SecureString $pwdfile.sqlserver.userid
$sqluser = ConvertFrom-SecureString -SecureString $userss -AsPlainText
$sqlpwd = ConvertFrom-SecureString -SecureString $pwdss -AsPlainText
"User:" + $sqluser
"Password:" + $sqlpwd
