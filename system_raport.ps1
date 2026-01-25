# skript system_raport


# teeme valmis raporti failinime kasutades skript käivitamise kuupäeva ja kellaaega
$aeg = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$raporti_nimi = "raport_$aeg.txt"

# alustame raportit kirjutades sinna rea millega tegu on
"-- See on raport skripti system_raport.ps1 väljundite kohta --`n" | Out-File -FilePath $raporti_nimi

# palume kasutajal sisestada nime
# kui nimi tühjaks jätta annab veateate ja väljub skriptist
[string]$nimi = Read-Host "Palun sisesta oma nimi"
    if( [string]::IsNullOrWhiteSpace($nimi) )
        {
            Write-Host "`nNime ei ole sisestatud. Väljun skriptist." -ForegroundColor Red
         }
    else
        {
            # küsime mitu korda tervitust kuvatakse
            $sisestatud_tervitusi = Read-Host "Mitu korda soovid tervitust"
            # kui sisestatakse komaga arv muudetase see punktiks et powershell seda arvuna ei loeks
            # kui sisestada 1,3 loeb powershell seda kui 13
            # lisaks kontroll et sisestatakse number mitte täht, kui on vigane sisestus annab veateate
            $asendakoma = $sisestatud_tervitusi.Replace(',','.')
            [int]$tervitusi = $asendakoma
            if( -not ($tervitusi -as [int] ))
                {
                   Write-Host "`nTervituste arv ei ole korrektne, tervituste arv peab olema number." -ForegroundColor Red
                   Write-Host "`nNimi ja tervituste arv peavad mõlemad olema sisestatud. Väljun skriptist." -ForegroundColor Red
                 }
            else
                {
                    # juhuks kui sisestatakse komaga arv ümardatakse täisarvuks
                    $tervitusi_umardatud = [Math]::Round($tervitusi, [MidpointRounding]::AwayFromZero)


                    # tsükkel while tervituste kuvamiseks mis töötab nii palju kordi kui kasutaja sisestas
                    $terv = 0
                    Write-Host "`n"
                    while( $terv -lt $tervitusi_umardatud )
                        {
                            # tervitustekst salvestatud muutuja väärtuseks et oleks võimalik raportisse pipe-ida
                            $while_terv = "Tere, $nimi"
                            Write-Host $while_terv -ForegroundColor Green
                            $while_terv | Out-File -FilePath $raporti_nimi -Append
                            $terv++
                        }

                    # kasutame süsteemimuutujaid et saada arvuti nimi, kasutajanimi ja powershelli versioon
                    $arvuti = $env:COMPUTERNAME
                    $kasutaja = $env:USERNAME
                    # muudame powershelli versiooni nime stringiks et seda oleks hiljem lihtsam if tingimuslauses kasutada
                    $powershell = $PSVersionTable.PSVersion.ToString()

                    # teavitused salvestatud muutujate väärtusteks et oleks võimalik raportisse pipe-ida
                    $print_arvuti = "`n`nArvuti nimi on: $arvuti"
                    Write-Host $print_arvuti -ForegroundColor Yellow
                    $print_arvuti | Out-File -FilePath $raporti_nimi -Append

                    $print_kasutaja = "Kasutaja nimi on: $kasutaja"
                    Write-Host $print_kasutaja -ForegroundColor Yellow
                    $print_kasutaja | Out-File -FilePath $raporti_nimi -Append

                    $print_powershell = "PowerShelli versioon on: $powershell"
                    Write-Host $print_powershell -ForegroundColor Yellow
                    $print_powershell | Out-File -FilePath $raporti_nimi -Append

                    # kontrollime powershelli versiooni kasutades varem loodud muutuja $powershell väärtust
                    # kui versiooni number on suurem kui 5 teavitatakse rahuldava tekstiga kui mitte siis mitterahuldava tekstiga
                    # teavitused salvestatud muutujate väärtusteks et oleks võimalik raportisse pipe-ida
                    if( $powershell -lt "5" )
                        {
                            $ps_kontroll = "Sinu PowerShell on vana! Uuenda see vähemalt versioonile 5.0"
                            Write-Host $ps_kontroll -ForegroundColor Red
                            $ps_kontroll | Out-File -FilePath $raporti_nimi -Append
                         }
                    else
                        {
                            $ps_kontroll = "Sinu PowerShelli versioon on uuem kui 5.0. Sinu PowerShell on sobiv."
                            Write-Host $ps_kontroll -ForegroundColor Green
                            $ps_kontroll | Out-File -FilePath $raporti_nimi -Append
                         }

                    # funktsioon protsesside välja võtmiseks ning saadud info ekraanile kuvamiseks ja raportisse lisamiseks
                    function protsessid
                        {
                            # kasutame Get-Process et saada 3 suvalist protsessi ja võtame välja nende protsesside nimed
                            $protsessid = Get-Process | Get-Random -Count 3 | Select-Object -ExpandProperty ProcessName
                            # teavitus salvestatud muutuja väärtuseks et oleks võimalik raportisse pipe-ida
                            $tiitel = "`n`nSiin on kolm hetkel töötavat protsessi:"
                            Write-Host $tiitel -ForegroundColor Green
                            $tiitel | Out-File -FilePath $raporti_nimi -Append
                            
                            # iga protsessi kohta mis salvestati $protsessid muutja väärtuseks
                            # kuvatakse teavitus ekraanile ja pipe-itakse see raportisse
                            $protsessid | ForEach-Object {
                                    Write-Host $_ -ForegroundColor Green
                                    $_ | Out-File -FilePath $raporti_nimi -Append
                                 }
                         }

                    # funktsioon teenuste välja võtmiseks ning saadud info ekraanile kuvamiseks ja raportisse lisamiseks
                    function teenused
                        {
                            # kasutame Get-service et saada 3 suvalist teenust ja võtame välja teenuse nime ja staatuse
                            $teenused = Get-Service | Get-Random -Count 3 | Select-Object Name,Status
                            # teavitus salvestatud muutuja väärtuseks et oleks võimalik raportisse pipe-ida
                            $tiitel = "`nSiin on kolm teenust ja nende staatused:"
                            Write-Host $tiitel -ForegroundColor Green
                            $tiitel | Out-File -FilePath $raporti_nimi -Append

                            # iga teenuse kohta mis salvestati $teenused muutja väärtuseks
                            # loome ajutise muutuja et kokku panna rida valitud teenuse kohta kus on selle nimi ja staatus
                            # iga rida kuvatakse ekraanile ja pipe-itakse raportisse
                            $teenused | ForEach-Object {
                                    $rida = "$($_.Name) [$($_.Status)]"
                                    Write-Host $rida -ForegroundColor Green
                                    $rida | Out-File -FilePath $raporti_nimi -Append
                                 }
                         }

                    # käivitame funktsioonid mis eelnevalt sai loodud
                    protsessid
                    teenused

                    # lõpu teavitus et skript lõpetas töö edukalt
                    Write-Host "`n`n============================" -ForegroundColor Green
                    Write-Host "Script finished successfully" -ForegroundColor Green
                    Write-Host "============================" -ForegroundColor Green
                 }
         }