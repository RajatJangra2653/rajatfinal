New-Item -ItemType File -Path "C:\Users\Public\logfilecse.txt"
$logFilePath = "C:\Users\Public\logfilecse.txt"
Start-Transcript -Path $logFilePath -Append
$url = "https://drive.google.com/file/d/1uUwnvqqMWRCZ2L33J2lOLXcCuQFka-Xc/view?usp=sharing"
$tempFilePath = "C:\Users\Public\chromeandiis.ps1"
Invoke-WebRequest -Uri $url -OutFile $tempFilePath
# Get the SID of the user
$userSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Name='rajat'").SID
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $userSID
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $tempFilePath"
Register-ScheduledTask -TaskName ABC  -Action $action -Trigger $trigger -User $userSID -Password "Rjangra#2021" -TaskPath "\"
Stop-Transcript