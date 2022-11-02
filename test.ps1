#Requires -RunAsAdministrator
Clear-Host
Write-Host "What version would you like? GUI (Requires .NET) or CMD? (Case sensitive)"
Write-Host "PLEASE RUN WITH ADMIN!"
$answer = read-host "Your choice:"
if ($answer -eq 'CMD') { 
  Invoke-WebRequest https://raw.githubusercontent.com/eliasailenei/SkipOOBE/main/SkipOOBE%20V2/SkipOOBE%20v2.bat -OutFile c:\SkipOOBE%20v2.bat
  cd C:\
  .\SkipOOBE%20v2.bat
} else {
Write-Host Installing .NET 6.0, please wait...
  Invoke-WebRequest https://download.visualstudio.microsoft.com/download/pr/9f4d3331-ff2a-4415-ab5d-eafc9c4f09ee/1922162c9ed35d6c10160f46c26127d6/dotnet-sdk-6.0.402-win-x64.exe -OutFile c:\dotnet-sdk-6.0.402-win-x64.exe
  cd C:\
  ./dotnet-sdk-6.0.402-win-x64.exe /install /quiet /norestart
  Write-Host please wait...
  Invoke-WebRequest https://www.7-zip.org/a/7z2201.msi -OutFile c:\7z2201.msi
  cd C:\
  ./7z2201.msi /qn
  $7ZipPath = "${Env:ProgramFiles(x86)}"+"\7-Zip\7z.exe"
  set-alias sz $7ZipPath
sz a -tzip
  Invoke-WebRequest https://github.com/eliasailenei/SkipOOBE/archive/refs/heads/main.zip -OutFile c:\main.zip
  cd C:\
  7z x main.zip
  cd C:\SkipOOBE-main\SkipOO
  ./SkipOOBE.exe

} 