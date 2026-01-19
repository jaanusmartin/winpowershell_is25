# skript mis näitab kausta c:\temp\test sisu ja otsib sealt välja .csv faild
# ning kuvab nende suuruse kilobaitides ja megabaitides

Get-ChildItem -Path "C:\temp\test"
$file = Get-ChildItem -Path "C:\temp\test" | where {$_.Name -like "*.csv"} | select Name,Length
$suurusKB = $file.Length/1KB
$suurusMB = $file.Length/1MB

Write-Host "`nFailiNimi : "$file.Name
Write-Host "Suurus kilobaitides : "$suurusKB
Write-Host "Suurus megabaitides : "$suurusMB