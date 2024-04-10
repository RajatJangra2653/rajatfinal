# Install Microsoft Edge
#$edgeInstallerUrl = "https://go.microsoft.com/fwlink/?linkid=2126703"
$edgeInstallerUrl = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BC11F6829-D84A-B108-1780-8BD39A096C6C%7D%26lang%3Den-GB%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe"
$edgeInstallerPath = "D:\ChromeSetup.exe"
#$edgeInstallerPath = "$env:TEMP\MicrosoftEdgeSetup.exe"

# Download Edge installer
Invoke-WebRequest -Uri $edgeInstallerUrl -OutFile $edgeInstallerPath

# Install Microsoft Edge
#Start-Process -FilePath $edgeInstallerPath -ArgumentList "--silent --install" -Wait
Start-Process -FilePath $edgeInstallerPath -ArgumentList "/S"
#Start-Process powershell -Verb RunAs -ArgumentList "Start-Process -FilePath $edgeInstallerPath"
#Start-Process powershell -Verb RunAs -ArgumentList "-NoNewWindow -Command {Start-Process -FilePath '$edgeInstallerPath'}"
#Invoke-Expression -Command "D:\ChromeSetup.exe /S"


# Remove Edge installer
Remove-Item $edgeInstallerPath -Force

# Configure IIS Server
# Enable required IIS modules
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionDynamic
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DirectoryBrowsing
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebDAV
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter

# Start the IIS service
Start-Service W3SVC

# Set IIS service to start automatically
Set-Service W3SVC -StartupType Automatic

# Create an HTML file for default IIS page
$defaultPagePath = "C:\inetpub\wwwroot\index.html"
@"
<!DOCTYPE html>
<html>
<head>
<title>Welcome to IIS</title>
</head>
<body>
<h1>Welcome to IIS Server</h1>
<p>This is the default page of Internet Information Services (IIS) Server.</p>
</body>
</html>
"@ | Out-File -FilePath $defaultPagePath -Encoding utf8


function LogMessage {
  param(
      [string]$message
  )
  $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  $logMessage = "$timestamp - $message"
  $logMessage | Out-File -FilePath $logFilePath -Append
}

# Redirect output streams to log file
Start-Transcript -Path $logFilePath -Append

# Log script start time
LogMessage "Script started"

# Example commands to execute
try {
  # Command 1
  LogMessage "Executing Command 1"
  # Replace the following line with your command
  # Command-1
  Write-Host "Command 1 executed successfully"

  # Command 2
  LogMessage "Executing Command 2"
  # Replace the following line with your command
  # Command-2
  Write-Host "Command 2 executed successfully"

  # Command 3
  LogMessage "Executing Command 3"
  # Replace the following line with your command
  # Command-3
  Write-Host "Command 3 executed successfully"
}
catch {
  # Log error if any command fails
  LogMessage "Error: $_"
}

# Log script end time
LogMessage "Script ended"

# Stop transcript
Stop-Transcript