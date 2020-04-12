
$npifilename = (Get-ChildItem npidata_pfile*.csv | Where-Object Name -NotLike "*FileHeader.csv").Name
./Process-NPIData.ps1 $npifilename 31 "CA"
#./Process-NPIData.ps1 $npifilename


