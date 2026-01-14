# skript mis teavitab et notepad töötab kuni notepad töötab

$loendur1 = 0

do
{
    $kontroll = $null
    $kontroll = Get-Process | ?{$_.Name -like "note*"}
    
    if( $kontroll -ne $null )
        {
            $loendur2 = 2
            Write-Host "Notepad töötab"
            Start-Sleep -Seconds 1
            $loendur1++
        }
    
    else
        {
            $loendur2 = 1
         }

}
until( $loendur2 -eq 1 )

$loendur1
    