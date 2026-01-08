# skript kuvab menüü riikide nimedega ja laseb kasutajal sisestada riigi järjekorranumbri
# ning selle alusel kuvab ekraanile vastava pealinna

Write-Host "Vali riik :" -ForegroundColor Yellow
Write-Host " 1 : India" -ForegroundColor Cyan
Write-Host " 2 : Austraalia" -ForegroundColor Cyan
Write-Host " 3 : Hiina" -ForegroundColor Cyan

$maa = Read-Host "Palun sisesta soovitud riigi järjekorranumber"

if ( $maa -eq 1 )
    { Write-Host "India pealinn on New Delhi." -ForegroundColor Green
    }
elseif ( $maa -eq 2 )
    { Write-Host "Austraalia pealinn on Canberra." -ForegroundColor Green
    }
elseif ( $maa -eq 3 )
    { Write-Host "Hiina pealinn on Peking." -ForegroundColor Green
    }
else
    { Write-Host " Vali riigi menüü järjekorranumber. Näiteks: 2" -ForegroundColor Red
    }