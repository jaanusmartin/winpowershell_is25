

function loenda-teenused
    {
        param
            (
                [string]$status
             )
        if( $status -eq "Running")
            {
                $tootav = Get-Service | ?{$_.Status -eq "Running"}
                Write-Host "Töötavate teenuste arv on"$tootav.count
             }
        elseif( $status -eq "Stopped" )
            {
                $peatatud = Get-Service | ?{$_.Status -eq "Stopped"}
                Write-Host "Seisvaid teenuseid on"$peatatud.count
             }
     }

loenda-teenused -status Running
loenda-teenused -status Stopped