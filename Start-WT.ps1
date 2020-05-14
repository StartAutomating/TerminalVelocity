function Start-WT
{
    <#
    .Synopsis
        Starts a new instance of Windows Terminal
    .Description
        Starts a new instance of Windows Terminal, and sends commands to it.
    .Link
        Get-WTProfile
    .Example
        Start-WT
    .Example
        Start-WT -Profile PowerShell
    .Example
        Start-WT -Profile 'Windows PowerShell' -CommandLine 'powershell -nologo'
    .Example
        [PSCustomObject]@{
            Profile = 'Windows PowerShell'
            CommandLine = {powershell -nologo -noexit -command $psVersionTable}
        },
        [PSCustomObject]@{
            Profile = 'PowerShell'
            CommandLine = {%programFiles%\PowerShell\7\pwsh -nologo -noexit -command $psVersionTable}
        } |
            Start-WT -Verbose
    #>
    [OutputType([Nullable],[Diagnostics.Process])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", "", Justification="Not changing state"
    )]
    param(
    # The name of the Windows Terminal Tab profile
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Profile')]
    [string]
    $ProfileName,

    # The working directory used by Windows Terminal
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $WorkingDirectory,

    # The command line run by Windows Terminal
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $CommandLine,

    # If set, will split the pane.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Split,

    # If provided, will split the pane horizontally or veritcally
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('Horizontal','H', 'Vertical','V')]
    [string]
    $SplitDirection,

    # If provided, will focus a given tab index.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $FocusTabIndex,

    # If provided, will focus the next tab.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Next')]
    [switch]
    $FocusNextTab,

    # If provided, will focus the previous tab.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Previous')]
    [switch]
    $FocusPreviousTab,

    # If set, will return the created process.
    [switch]
    $Passthru
    )


    begin {
        $allArgs = [Collections.Generic.List[Object]]::new()

    }
    process {
        $allArgs.AddRange(
            @(
            #region New Tabs and Panes
            if ($CommandLine -or $ProfileName -or $WorkingDirectory) {
                if ($Split -or $SplitDirection) {
                    $(if ($wtArgs.Count) {';'} else {''}) + $(
                        if ($Split) {
                            'split-pane'
                        } elseif ('Horizontal','H' -contains $SplitDirection) {
                            'split-pane -H'
                        } elseif ('Vertical','V' -contains $SplitDirection) {
                            'split-pane -V'
                        }
                    )
                } else {
                    $(if ($wtArgs.Count) {';'} else {''}) + 'new-tab'
                }
                if ($ProfileName) {
                    '--profile'
                    "`"$ProfileName`""
                }
                if ($WorkingDirectory) {
                    '--startingDirectory'
                    $WorkingDirectory
                }
                if ($CommandLine) {
                    $CommandLine -replace ';' ,'\;'
                }
            }
            #endregion New Tabs and Panes
            #region Tab Focus
            elseif ($FocusNextTab -or $FocusPreviousTab -or $FocusTabIndex -ge 0)
            {
                ';focus-tab'
                if ($FocusTabIndex -ge 0) {
                    '--target'
                    $FocusTabIndex
                } elseif ($FocusNextTab) {
                    '--next'
                } elseif ($FocusPreviousTab) {
                    '--previous'
                }
            })
            #endregion Tab Focus
        )
    }

    end {
        Write-Verbose "$allArgs"
        Start-Process wt.exe -ArgumentList $allArgs -PassThru:$PassThru
    }
}