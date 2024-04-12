$url = "https://drive.usercontent.google.com/download?id=1uUwnvqqMWRCZ2L33J2lOLXcCuQFka-Xc&export=download&authuser=0&confirm=t&uuid=051cd117-8e88-40da-8111-9fcad42c199c&at=APZUnTUzd73NR6YZ_fku52ndq_qu:1712846598660"
$tempFilePath = "C:\Users\Public\chromeandiis.ps1"
Invoke-WebRequest -Uri $url -OutFile $tempFilePath
#Variables
$TaskName = "Schedule Installation of Chrome"
$username ="rajatvm/rajat"
$password ="Rjangra#2021"

#create a scheduled task with powershell
# $Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "E:\Scripts\AuditLists.ps1"
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $tempFilePath"
$ScheduledTask = New-ScheduledTask -Action $action -Trigger $trigger

Register-ScheduledTask -TaskName $TaskName  -InputObject $ScheduledTask -User $username -Password $password 
