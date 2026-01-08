# skript küsib kasutaja käest 2 arvu ja võrdleb kumb nendest on suurem
# ja annab sellekohase teavituse

$nr1 = Read-Host "Sisesta üks number võrdlemiseks"
$nr2 = Read-Host "Sisesta teine number võrdlemiseks"

if ( $nr1 -gt $nr2 )
    { Write-Host "$nr1 on suurem kui $nr2."
    }
elseif ( $nr2 -gt $nr1 )
    { Write-Host "$nr2 on suurem kui $nr1."
    }
elseif ( $nr1 -eq $nr2 )
    { Write-Host "Sisestatud numbrid on võrdsed."
    }