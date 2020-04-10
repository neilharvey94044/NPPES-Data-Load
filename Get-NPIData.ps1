#Requires -Version 7.0
Param ( [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $month, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $year, `
        [Parameter(Mandatory=$True)] [ValidateNotNull()] [string] $txcodesURI `
      )

# download the NPPES monthly data file
$nppesMonthlyFileURI  = [URI] ("https://download.cms.gov/nppes/NPPES_Data_Dissemination_" + $month + "_" + $year + ".zip")
$nppesMonthlyFileName = $nppesMonthlyFileURI.LocalPath | Split-Path -Leaf
$txcodesURI = [URI] $txcodesURI
$txcodesFileName = $txcodesURI.LocalPath | Split-Path -Leaf

Invoke-WebRequest -URI $nppesMonthlyFileURI -Outfile $nppesMonthlyFileName

Expand-Archive -LiteralPath $nppesMonthlyFileName -DestinationPath . -Force

Invoke-WebRequest -URI $txcodesURI -OutFile $txcodesFileName

