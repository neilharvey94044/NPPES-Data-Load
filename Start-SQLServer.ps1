docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Bracket4Tree@" `
   -v d:\sql1\data:/var/opt/mssql/data `
   -v d:\sql1\logs:/var/opt/mssql/log `
   -v d:\sql1\backup:/var/opt/mssql/backup `
   -p 1433:1433 --name sql1 `
   -d mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04