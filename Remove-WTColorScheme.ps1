function Remove-WTColorScheme
{
    [CmdletBinding(SupportsShouldProcess)]
    param(
    # The name of the color scheme.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string[]]
    $ColorScheme
    )

    process {
        #region Get Color Scheme
        $matchingSchemes = Get-WTColorScheme @PSBoundParameters           # call Get-WTProfile
        $matchingSchemeNames = $matchingSchemes | 
            Select-Object -ExpandProperty Name
        $allSchemes = Get-WTProfile -ColorScheme *
        $updatedSchemes = @($allSchemes | 
            Where-Object {
                foreach ($cs in $ColorScheme) {
                    if ($_.Name -like $cs) { return $false } 
                }
                return $true
            })
        
        Set-WTProfile -ColorScheme $updatedSchemes
        #endregion Get Color Scheme

    }


}
