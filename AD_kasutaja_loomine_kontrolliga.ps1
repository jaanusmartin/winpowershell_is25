# skript mis loob Active Directory kasutajad vastavalt infole mis on ette antud 
# failis C:\Users\Administrator\Documents\aduser.csv
# 
# kui faili sisestatud kasutja on juba süsteemis olemas annab sellekohase veateate
# kui kasutaja loomine õnnestus siis selle kohta annab ka teavituse


# loeme sisse CSV faili aduser.csv asukoha
$file = "C:\Users\Administrator\Documents\aduser.csv"

# ipordime faili sisu
$users = Import-Csv $file -Encoding Default -Delimiter ";"

# funktsioon mis muudab UTF-8 tähed LATIN tähtedeks
function Translit {
    param(
        [string] $inputstring
          )
    # array tähtedest mis tuleb muuta
        $Translit = @{
            [char]'ä' = "a"
            [char]'ö' = "o"
            [char]'ü' = "u"
            [char]'õ' = "o"
            [char]'š' = "s"
            }
        
        # loome tõlgendamise väljundi
        $outputstring = ""
        # liiguta stringi väärtus tähtede kaupa tähtede array-sse
        foreach( $character in $inputcharacter = $inputstring.ToCharArray() )
            {
               
                # kui täht on tähtede listis mida tuleb muuta lisada
                # väljundfaili Translit arrays kirjeldatud asendus täht
                # kui täht ei ole selles arrays kirjeldatud kirjutatakse see otse väljundfaili
                if( $Translit[$character] -cne $Null )
                    {
                        $outputstring += $Translit[$character]
                     }
                else
                    {
                        $outputstring += $character
                     }
             }
        return $outputstring
}


# iga rea kohta muutuja $users väärtuses
foreach( $user in $users )
    {
        # luua kasutajanimi CSV faili FirstName ja LastName väärtustest
        $username = $user.FirstName + "." + $user.LastName
        # muudame kasutajnime väiketähtedeks
        $username = $username.ToLower()
        # rakendame funktsiooni Translit muutuaja $username väärtusele
        $username = Translit($username)
        
        # kasutaja Principal Name loomine
        $upname = $username + "@sv-koolj.local"

        # Display Name loomine
        $dpname = $user.FirstName + " " + $user.LastName
        

        try
            {
                # loome kasutaja vastavate parameetritega
                # kasutame -ErrorAction Stop et püüda kasutaja loomist
                # takistanud viga kinni catch plokis
        
                # loome iga rea koht listis uue kasutaja kasutades loodud muutujaid
                New-ADUser `                    -Name $username `                    -DisplayName $dpname `                    -GivenName $user.FirstName `                    -Surname $user.LastName `                    -Department $user.Department `                    -Title $user.Role `                    -UserPrincipalName $upname `                    -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
                    Write-Host "`nKasutaja -- $username -- loomine õnnestus!`n" -ForegroundColor Green
             }

        catch
            {
                # kasutame süsteemi veaobjekti
                $viga = $_
                # võtame välja PowerShelli vea ID
                $veakood = $viga.FullyQualifiedErrorID
                # kuvame veateate koos põhjusega
                Write-Host "`nKasutaja -- $username -- loomine ei õnnestunud!" -ForegroundColor Red
                
                # kontrollime vea põhjust
                if( $veakood -like "*1316*" )
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

                Write-Host "Süsteemi veakood:  $veakood" -ForegroundColor Red
             }
     }
