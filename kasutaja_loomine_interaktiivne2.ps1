# skript mis loob kasutajakonto nime ja perekonnanime järgi
# kasutaja sisestab nime ja perekonnanime skripti jooksutamise ajal

# küsime kasutaja nime ja perekonnanime
Write-Host "`nSee skript loob kautajakonto sisestatud nime alusel.`n" -ForegroundColor Yellow

[string]$eesnimi = Read-Host "Sisesta oma eesnimi"
[string]$perenimi = Read-Host "Sisesta oma perkonnanimi"

# kui ei ole sisestatud eesnime ja perekonnanime teavitab kasutajat
# ja käivitab skripti uuesti
if( $eesnimi.Length -eq "0" -or $perenimi.Length -eq "0" )
    {
        Write-host "`n`tViga! `tPalun sisesta nii eesnimi kui ka perekonnanimi!`n" -ForegroundColor Red
        Write-Host "`tKui soovid skriptist väljuda vajuta crtl+c" -ForegroundColor Red
         
        .\kasutaja_loomine_interaktiivne.ps1
     }
else
    {

        # loome muutujad kasutaja loomiseks ja
        # kasutame sisestatud väärtusi selle tegemiseks

        $kasutajanimi = $eesnimi.ToLower() + "." + $perenimi.ToLower()
        $taisnimi = "$eesnimi $perenimi"
        $kirjeldus = "$eesnimi $perenimi lokaalne kasutajakonto" 

        # loome kasutajale parooli
        $kasutajaparool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force

      
        
        try
            {
                # loome kasutaja vastavate parameetritega
                # kasutame -ErrorAction Stop et püüda kasutaja loomist
                # takistanud viga kinni catch plokis
                New-LocalUser $kasutajanimi -Password $kasutajaparool -FullName "$taisnimi" -Description "$kirjeldus" -ErrorAction Stop
                Write-Host "Kasutaja loomine õnnestus!`n" -ForegroundColor Green
             }

        catch
            {
                # kasutame süsteemi veaobjekti
                $viga = $_
                # võtame välja PowerShelli vea ID
                $veakood = $viga.FullyQualifiedErrorID
                # kuvame veateate koos põhjusega
                Write-Host "`nKasutja loomine ei õnnestunud!" -ForegroundColor Red
                
                # kontrollime vea põhjust
                if( $veakood -like "*UserExists*" )
                    {
                        Write-Host "Sellise nimega kasutaja on juba olemas." -ForegroundColor Red
                     }
                elseif( $veakood -like "*AccessDenied*" )
                    {
                        Write-Host "Kasutaja loomine ei ole lubatud. Käivitage PowerShell administraatori õigustega." -ForegroundColor Red
                     }
                elseif( $veakood -like "*PasswordComplexity*" )
                    {
                       Write-Host "Parool ei vasta keerukuse nõuetele." -ForegroundColor Red
                     }
                elseif( $veakood -like "*InvalidName*" )
                    {
                        Write-Host "Kasutajanimi sisaldab keelatud sümboleid." -ForegroundColor Red
                     }
                else
                    {
                        Write-Host "Tekkis ootamatu viga: $($_.Exception.Message)" -ForegroundColor Red
                     }

                Write-Host "Süsteemi veakood: $veakood" -ForegroundColor Red
             }
     }