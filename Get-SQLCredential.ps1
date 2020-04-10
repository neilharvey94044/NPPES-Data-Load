#Requires -Version 7.0
# This script reads the encrypted SQL Server Credentials from a json file,
# decrypts them, and returns them in an object used by various scripts. 

$pwdfile = Get-Content -Path .\passwords.json -raw | ConvertFrom-Json
$pwdss = ConvertTo-SecureString $pwdfile.sqlserver.password 
$userss = ConvertTo-SecureString $pwdfile.sqlserver.userid
$user = ConvertFrom-SecureString -SecureString $userss -AsPlainText
$pwd = ConvertFrom-SecureString -SecureString $pwdss -AsPlainText
$server = $pwdfile.sqlserver.server

$sqlparms = @{ "server"=$server; "userid"=$user; "password" = $pwd } 
return $sqlparms
