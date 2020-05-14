Write-FormatView -TypeName WindowsTerminal.Profile -Property Name, Source, CommandLine -Wrap -VirtualProperty @{
    Source = {$_.Source -split '\.' | Select-Object -Last 1 } 
}