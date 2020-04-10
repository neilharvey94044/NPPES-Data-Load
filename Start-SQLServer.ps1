#Requires -Version 7.0
# Starts SQL Server 2019 in a Docker container
# Mounts data and logs onto the d: drive for my machine where there is more space
$sqlparms = ./Get-SQLCredential.ps1
$pswd   = $sqlparms['password']

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$pswd" `
   -v d:\sql1\data:/var/opt/mssql/data `
   -v d:\sql1\logs:/var/opt/mssql/log `
   -p 1433:1433 --name sql1 `
   -d mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04
