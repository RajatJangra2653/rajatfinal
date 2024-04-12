New-Item -ItemType File -Path "C:\Users\Public\logfilecse.txt"
$logFilePath = "C:\Users\Public\logfilecse.txt"
Start-Transcript -Path $logFilePath -Append
$url = "https://drive.usercontent.google.com/download?id=1uUwnvqqMWRCZ2L33J2lOLXcCuQFka-Xc&export=download&authuser=0&confirm=t&uuid=051cd117-8e88-40da-8111-9fcad42c199c&at=APZUnTUzd73NR6YZ_fku52ndq_qu:1712846598660"
$tempFilePath = "C:\Users\Public\chromeandiis.ps1"
Invoke-WebRequest -Uri $url -OutFile $tempFilePath


# function Get-CurrentUserSID {
#     $currentUserSID = whoami /user /fo csv | ConvertFrom-Csv | Select-Object -ExpandProperty SID
#     return $currentUserSID
# }
# Get current username using whoami command
$username = whoami

# Function to retrieve SID for a given username
function Get-SID {
    param (
        [string]$Username
    )
    try {
        $sid = (New-Object System.Security.Principal.NTAccount($Username)).Translate([System.Security.Principal.SecurityIdentifier]).Value
        return $sid
    } catch {
        Write-Host "Error: $_"
        return $null
    }
}

# Main script
# try {
#     Write-Host "Username: $username"
    
#     # Get SID for the username
#     $sid = Get-SID -Username $username
#     if ($sid) {
#         Write-Host "SID: $sid"
#         # Now you can pass the SID to your function
#         # your_function($sid)
#     } else {
#         Write-Host "Failed to retrieve SID."
#     }
# } catch {
#     Write-Host "Error: $_"
# }
$username
$sid


$trigger = New-ScheduledTaskTrigger -AtLogOn -User $sid
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $tempFilePath"
Register-ScheduledTask -TaskName ABC  -Action $action -Trigger $trigger -User $sid -Password "Rjangra#2021" -TaskPath "\"
Stop-Transcript
