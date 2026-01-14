# skript mis võtab failist laste nimed ja vanused
# vanuse alusel ütleb kas ta on alg- või põhikoolis ja teeb sellest eraldi massiivi
# 4-10 algkool  11-17 põhikool
# loodud massivi salvestab CSV faili arvutis

$kontroll = @()
$lapsed = Import-Csv C:\Users\Jaanus\powershellscript\vanused.csv

foreach ( $l in $lapsed )
    { if( [int]$l.Vanus -ge 4 -and  [int]$l.Vanus -le 10 )
        { $kool = "algkool"
        }
    elseif( [int]$l.Vanus -ge 11 -and [int]$l.Vanus -le 17 )
        { $kool = "põhikool"
        }
    $temp = [PSCustomObject]@{
            Nimi = $l.Nimi
            Kool = $kool
            }
    $kontroll += $temp
    }
$kontroll
$kontroll | Export-Csv -Path "C:\Users\Jaanus\powershellscript\sorteeritud-koolide-lõikes.csv" -NoTypeInformation