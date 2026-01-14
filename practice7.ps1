# skript mis annab 20-le järjekorranumbrile suvalise värvi valikust
# (punane, roheline, kollane, sinine)

$varvid = @("punane","roheline","kollane","sinine")
$jagatudvarvid = @()

for( $jknumber = 1 ; $jknumber -le 20 ; $jknumber++ )
    {
        $suvalinevarv = Get-Random $varvid
        $temp = [PSCustomObject]@{
                                    JKNumber = $jknumber
                                    Värv = $suvalinevarv
                                  }
        $jagatudvarvid += $temp
    }
$jagatudvarvid