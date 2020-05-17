[OutputType('WindowsTerminal.ColorScheme')]
param()

Write-FormatViewExpression -If { $host.UI.SupportsVirtualTerminal } -ScriptBlock {
$colorScheme = $_
$bufferWidth = $host.UI.RawUI.BufferSize.Width

if ($bufferWidth -lt 110){
@(
$colorScheme = $_
. $setOutputStyle -Foreground $colorScheme.foreground -Background $colorScheme.background
$colorScheme.name
. $clearOutputStyle 
) -join ''
return
} 

@(
    @(


    $bgColors = 'Background','Black','Red','Green', 'Yellow', 'Blue', 'Purple','Cyan','White'
    $bgColorWidth = $host.UI.RawUI.BufferSize.Width / ($bgColors.Length + 1)
     
    $bigEnoughForColors =$host.UI.RawUI.BufferSize.Width -ge 124

    

    $headerLine = 
    @(for ($n =0; $n -lt $bgColors.Length; $n++) {
        $colWidth = 
            if ($n -eq 0) {
                14
            } elseif ($n -eq 1) {
                9
            } else {
                $bgColorWidth
            }

        $space = [Math]::Max(0, $colWidth - $bgColors[$n].Length)
        "$(' ' * [Math]::Ceiling($space /2))$($bgColors[$n])$(' ' * [Math]::Floor($space /2))|"

    }) -join ''


(. $setOutputStyle -Background $colorScheme.background -foreground $colorScheme.foreground) + 
    "$('---' + $colorScheme.Name + ('-' * ($headerLine.Length - 4 - $colorScheme.Name.Length)) + '|')" + 
    ( & $clearOutputStyle)

#. $setOutputStyle -Foreground $colorScheme.Foreground -Background $colorScheme.Background
(. $setOutputStyle -Background $colorScheme.background -foreground $colorScheme.foreground) + $headerLine + ( & $clearOutputStyle)
foreach ($fg in 'Foreground','BrightWhite','Black','BrightBlack',
    'Red', 'BrightRed','Green','BrightGreen','Yellow','BrightYellow',
    'Blue','BrightBlue','Purple','BrightPurple', 'Cyan', 'BrightCyan','White','BrightWhite') {
    $line = ''# . $setOutputStyle -Foreground $colorScheme.($fg)
    
    $line += @(
    $n = 0
    
    foreach ($bg in $bgColors) {
        $bgColor = $colorScheme.$bg

        & $setOutputStyle -Background $colorScheme.$bg
        $t = if ($n -eq 0) {
            $fg
            $colWidth = 14
        } elseif ($n -eq 1) {
            "$($colorScheme.$fg)"
            $colWidth = 9
        } else {
            if ($bigEnoughForColors) {
                "$($colorScheme.$fg)"
            } else {
                "E.g"
            }
            $colWidth = $bgColorWidth
        }
        $space = [Math]::Max(0, $colWidth - $t.Length)
        if ($n -gt 0) {
            & $setOutputStyle -Foreground $colorScheme.$fg -Background $bgColor
        } else {
            & $setOutputStyle -Foreground $colorScheme.Foreground -Background $bgColor
        }
        "$(' ' * [Math]::Floor($space /2))$t$(' ' * [Math]::Ceiling($space /2))"

        
        & $setOutputStyle -Foreground $colorScheme.foreground -Background $colorScheme.background
        "|"
        & $clearOutputStyle
        $n++
    }
    ) -join ''
    $line.Trim() + ( & $clearOutputStyle)
    #"$($fg)".PadRight($host.UI.RawUI.BufferSize.Width)
}
) -join [Environment]::NewLine
<#
@(
foreach ($fg in $colorScheme.psobject.properties) {
    if ($fg.Name -eq 'Name') { continue}
    . $setOutputStyle -Foreground $colorScheme.($fg.Name)
    "$($fg.Name)".PadRight($host.UI.RawUI.BufferSize.Width)
}
)
#>
. $clearOutputStyle
) -join ''
return





}



Write-FormatViewExpression -If { -not $Host.ui.SupportsVirtualTerminal } -ScriptBlock {
    $_.Name + ([Environment]::NewLine * 2) + ($_ | Select-Object -Property * -ExcludeProperty Name | Format-List | Out-String)
}

