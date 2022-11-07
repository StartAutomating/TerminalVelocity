function Remove-WTColorScheme
{
    <#
    .Synopsis
        Removes color schemes from Windows Terminal.
    .Description
        Removes registered color schemes from Windows Terminal.
    .Example
        Remove-WTColorScheme -Name "The Hulk"
    .Link
        Add-WTColorScheme
    .Link
        Get-WTColorScheme
    .Link
        Set-WTColorScheme
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Low')]
    param(
    # The name of the color scheme.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string[]]
    $ColorScheme
    )

    process {
        #region Get Color Scheme
        $null = $PSBoundParameters.Remove('Confirm')
        $null = $PSBoundParameters.Remove('WhatIf')
        $allSchemes = Get-WTProfile -ColorScheme * -Global
        $updatedSchemes = @($allSchemes |
            Where-Object {
                foreach ($cs in $ColorScheme) {
                    if ($_.Name -like $cs) { return $false }
                }
                return $true
            })

        if ($PSCmdlet.ShouldProcess("Remove $ColorScheme")) {
            Set-WTProfile -ColorScheme $updatedSchemes -Confirm:$false -Global
        }
        #endregion Get Color Scheme

    }
}
