function Stop-WT
{
    <#
    .Synopsis
        Stops Windows Terminal
    .Description
        Stops Windows Terminal Processes
    .Link
        Start-WT
    .Link
        Stop-Process
    .Example
        Stop-WT
    #>
    [CmdletBinding(SupportsShouldProcess,DefaultParameterSetName='All')]
    [OutputType([Nullable])]
    param(
    # The Process ID
    [Parameter(Mandatory,ParameterSetName='ProcessID',ValueFromPipelineByPropertyName)]
    [Alias('PID', 'ProcessID')]
    [int[]]
    $ID
    )

    begin {
        $allIds = [Collections.ArrayList]::new()
    }

    process {
        $allIds.AddRange($ID)
    }

    end {
        #region Stop Terminals
        @(if (-not $allIds) {
            Get-Process WindowsTerminal -ErrorAction Ignore
        } else {
            Get-Process WindowsTerminal -ErrorAction Ignore |
                Where-Object ID -In $allIds
        }) |
            Stop-Process
        #endregion Stop Terminals
    }
}
