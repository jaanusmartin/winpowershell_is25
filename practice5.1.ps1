# skript mis näitab Notepadi "Process Name" ja "Id"

Get-Process | where{$_.ProcessName -eq "notepad"} | select ProcessName,Id