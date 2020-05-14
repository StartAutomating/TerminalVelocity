function Get-WTColorScheme
{
    <#
    .Synopsis
        Gets Windows Terminal Color Schemes
    .Description
        Gets one or more Windows Terminal Color Schemes from the profile
    .Example
        Get-WTColorScheme # Gets all color schemes
    .Example
        Get-WTColorScheme 'Jackie Brown' # Gets the color scheme 'Jackie Brown'
    .Link
        Add-WTColorScheme
    .Link
        New-WTColorScheme
    #>
    [OutputType([PSObject])]
    param(
    # The name of the color scheme.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string[]]
    $ColorScheme
    )

    process {
        #region Get Color Scheme
        if (-not $PSBoundParameters.ColorScheme)   # If no color scheme was provided
        {
            $PSBoundParameters['ColorScheme'] = '*'# default to all
        }

        Get-WTProfile @PSBoundParameters           # call Get-WTProfile
        #endregion Get Color Scheme
    }
}
