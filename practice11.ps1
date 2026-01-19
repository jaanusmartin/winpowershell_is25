# skript kuhu saab sisestada kaks numbrit ja siis valida menüüst mida nendega tehakse
# valikus on liitmine, lahutamine, jagamine, korrutamine
# peale valiku sisestamist kuvatakse ekraanil tehte vastus
Write-Host " Kalkulaator" -ForegroundColor Green
Write-Host " 1: Liitmine" -ForegroundColor Yellow
Write-Host " 2: Lahutamine" -ForegroundColor Yellow
Write-Host " 3: Jagamine" -ForegroundColor Yellow
Write-Host " 4: Korrutamine" -ForegroundColor Yellow

[int]$nr1 = Read-Host "  Sisesta esimene number"
[int]$nr2 = Read-Host "  Sisesta teine number"
$tehe = Read-Host "  Sisesta tehte number millist soovid rakendada"

switch($tehe)
    {
        1
            {
                $liitmine = $nr1+$nr2
                $vastus = $liitmine
             }
        2
            {
                $lahutamine = $nr1-$nr2
                $vastus = $lahutamine
             }
        3
            {
                $jagamine = $nr1/$nr2
                $vastus = $jagamine
             }
        4
            {
                $korrutamine = $nr1*$nr2
                $vastus = $korrutamine
             }
     }

Write-Host " Tehte vastus on :"$vastus