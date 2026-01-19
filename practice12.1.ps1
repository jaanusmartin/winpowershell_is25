# funktsioon ilma parameetriteta mis tagastab töötavate ja peatatud teenuste arvu

function tootavad-teenused
    {
        $tootavad = Get-Service | ?{$_.Status -eq "Running"}
        Write-Host "Töötavaid teenuseid on"$tootavad.count
     }

function seisvad-teenused
    {
        $seisvad = Get-Service | ?{$_.Status -eq "Stopped"}
        Write-Host "Seisvaid teenuseid on"$seisvad.count
     }

tootavad-teenused

seisvad-teenused