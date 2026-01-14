# skript mis kontrollib kas notepad töötab või mitte ja kuvab sellekohase
# teavituse ekraanile

while( Get-Process Notepad -ErrorAction SilentlyContinue )
    {
        Write-Host "Notepad töötab."
        Start-Sleep -Seconds 1
     }