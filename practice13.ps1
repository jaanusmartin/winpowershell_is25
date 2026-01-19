# skript kus saab arvutada kasutaja sisestatud andmete alusel 
# ruudu, ristküliku, ringi ja kolmnurga pindala
# skript koosneb funktsioonidest kus iga välja kutsutud funktsioon on kas valikute menüü või 
# leht kus kasutaja saab sisestada kujundi mõõtmed ja kus peale seda toimub pindala arvutamine

function peamenuu
    {
        Write-Host "`t`tPindala kalkulaator" -ForegroundColor Green
        Write-Host "`n`t`tPeamenüü" -ForegroundColor Yellow
        Write-Host "`nVali millise kujundi pindala soovid arvutada`n" -ForegroundColor Yellow

        Write-Host "1: Ruudu pindala" -ForegroundColor Green
        Write-Host "2: Ristküliku pindala" -ForegroundColor Green
        Write-Host "3: Ringi pindala" -ForegroundColor Green
        Write-Host "4: Kolmnurga pindala" -ForegroundColor Green
        Write-Host "5: Välju`n" -ForegroundColor Green

        $peamenuuvalik = Read-Host "Sisesta valik"
        return $peamenuuvalik
     }

function loppmenuu
    {
        Write-Host "`n`nMida soovid teha" -ForegroundColor Yellow
        Write-Host "`n1: Tagasi peamenüüsse" -ForegroundColor Green
        Write-Host "2: Välju`n" -ForegroundColor Green

        $loppmenuuvalik = Read-Host "Sisesta oma valik"
            if( $loppmenuuvalik -eq "1" )
                {
                    continue
                 }
            if( $loppmenuuvalik -eq "2" )
                {
                    exit
                 }
            else
                {
                    Write-Host "`nSisesta menüüs antud valik" -ForegroundColor Red
                    loppmenuu
                 }
     }

function ruut
    {
        cls
        Write-Host "`t`tRuudu pindala`n" -ForegroundColor Green
        [int]$ruudukulg = Read-Host "Sisesta ruudu külje pikkus"
        $pindala = $ruudukulg * $ruudukulg
        Write-Host "`nRuudu pindala on:"$pindala -ForegroundColor Green

        loppmenuu
     }

function ristkulik
    {
        cls
        Write-Host "`t`tRistküliku pindala`n" -ForegroundColor Green
        [int]$pikkus = Read-Host "Sisesta ristküliku pikkus"
        [int]$laius = Read-Host "Sisesta ristküliku laius"
        $pindala = $pikkus * $laius
        Write-Host "`nRistküliku pindala on:"$pindala -ForegroundColor Green

        loppmenuu
     }

function ring
    {
        cls
        Write-Host "`t`tRingi pindala`n" -ForegroundColor Green
        [int]$raadius = Read-Host "Sisest ringi raadius"
        $pindala = 3.14 * $raadius * $raadius
        Write-Host "`nRingi pindala on:"$pindala -ForegroundColor Green

        loppmenuu
     }

function kolmnurk
    {
        cls
        Write-Host "`t`tKolmnurga pindala`n" -ForegroundColor Green
        [int]$korgus = Read-Host "Sisesta kolmnurga kõrgus"
        [int]$alus = Read-Host "Sisesta kolmnurga alus"
        $pindala = 0.5 * $alus * $korgus
        Write-Host "`nKolmnurga pindala on:"$pindala -ForegroundColor Green

        loppmenuu
     }

do
    {
        cls
        $menuvalik = peamenuu

        switch($menuvalik)
            {
                1
                    {
                        cls
                        ruut
                        loppmenuu
                     }
                2
                    {
                        cls
                        ristkulik
                        loppmenuu
                     }
                3
                    {
                        cls
                        ring
                        loppmenuu
                     }
                4
                    {
                        cls
                        kolmnurk
                        loppmenuu
                     }
             }
     }while( $menuvalik -ne "5" )