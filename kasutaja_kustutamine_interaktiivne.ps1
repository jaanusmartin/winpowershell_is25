# skript kus kasutaja saab sisestada kasutajanime kelle
# soovib kustutada ja tulemusest teavitatakse kasutajat

Write-Host "`n`tSkript mis kustutab kasutaja`n" -ForegroundColor Yellow

# laseme kasutajal sisestada kasutaja eesnime ja perekonnanime
[string]$nimi = Read-Host "Sisesta kasutaja eesnimi"
[string]$perenimi = Read-Host "Sisesta kasutaja perekonnanimi"

# kui ei ole sisestatud eesnime ja perekonnanime teavitab kasutajat
# ja käivitab skripti uuesti
if( $nimi.Length -eq "0" -or $perenimi.Length -eq "0" )
    {
        Write-host "`n`tViga! `tPalun sisesta nii eesnimi kui ka perekonnanimi!`n" -ForegroundColor Red
        Write-Host "`tKui soovid skriptist väljuda vajuta crtl+c" -ForegroundColor Red
         
        .\kasutaja_kustutamine_interaktiivne.ps1
     }
else
    {
        # teeme kasutaja sisestatud andmetest kasutajanime
        $kasutaja = $nimi.ToLower() + "." + $perenimi.ToLower()

        # et kontrollida kas kasutaja kustutatakse vaatame kas kasutajanimi
        # on olemas ja salvestame tulemuse enne muutuja väärtuseks
        $enne = Get-LocalUser -Name $kasutaja -ErrorAction SilentlyContinue

        # et püüda veateateid kustutamise ebaõnnestumistest kasutame try ja catch
        try
            {
                # kustutame kasutaja
                Remove-LocalUser $kasutaja -Verbose -ErrorAction Stop
             }

        catch
            {
                # kasutame süsteemi veaobjekti
                $vead = $_
                # võtame välja PowerShelli vea ID
                $veakoodid = $vead.FullyQualifiedErrorID
                # loome vastused erinevate vigade kohta
                if( $veakoodid -like "*UserNotFound*" )
                    {
                        Write-Host "`n`tSellise nimega kasutajat ei ole süsteemis." -ForegroundColor Red
                     }
                elseif( $veakoodid -like "*AccessDenied*" )
                    {
                        Write-Host "`n`tKasutaja kustutamine ei ole lubatud. Käivita PowerShell administraatori õigustega." -ForegroundColor Red
                     }
                else
                    {
                        Write-Host "`n`tTekkis ootamatu viga: $($_.Exception.Message)" -ForegroundColor Red
                     }
             }
        # kontrollime kas kasutaja sai eemaldatud
        # vaatame kasutajate nimekirja ja otsime kasutajate nimekirjast seda nime
        # mis sisestati ja paneme saadud tulemuse muutuja kontroll väärtuseks
        # võrdleme muutujate enne ja kontroll väärtusi ja kui need on samad siis
        # ei kustutatud midagi, kui need on erinevad siis eemaldati kasutaja
        $kontroll = Get-LocalUser -Name $kasutaja -ErrorAction SilentlyContinue
            if( $kontroll -eq $enne )
                {
                    Write-Host "`n`tKasutaja kustutamine ei õnnestunud." -ForegroundColor Red
                 }
            else
                {
                    Write-Host "`n`tKasutaja kustutamine õnnestus." -ForegroundColor Green
                 }
     }