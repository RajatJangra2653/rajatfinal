New-Item -ItemType File -Path "$env:TEMP\logfile.txt"

$logFilePath = "$env:TEMP\logfile.txt"

Start-Transcript -Path $logFilePath -Append

# Set the URL for the Chrome installer
$chromeInstallerUrl = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BC11F6829-D84A-B108-1780-8BD39A096C6C%7D%26lang%3Den-GB%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe"

# Set the path for the downloaded Chrome installer
$chromeInstallerPath = "$env:TEMP\ChromeSetup.exe"

# Download Chrome installer
Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $chromeInstallerPath

# Install Chrome silently
Start-Process msiexec.exe -ArgumentList "/i `"$chromeInstallerPath`" /qn" -Wait

# Delete the downloaded file
Remove-Item -Path $chromeInstallerPath -Force
# Stop transcript
Stop-Transcript
