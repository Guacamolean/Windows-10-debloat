function NewItemCheck ($Path) {
    if (!(Test-Path $Path)) {
        New-Item $Path
    }
}

$tasks = Get-ScheduledTask | Where-Object {$_.TaskName -like "Windows Defender*"}
foreach ($task in $tasks) {
    Disable-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath
}

NewItemCheck -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender"
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" "DisableAntiSpyware" 1
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" "DisableRoutinelyTakingAction" 1
NewItemCheck -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection"
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection" "DisableRealtimeMonitoring" 1
