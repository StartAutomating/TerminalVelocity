function New-WTColorScheme
{
    <#
    .Synopsis
        Creates Windows Terminal Color Schemes
    .Description
        Creates a new Windows Terminal Color Scheme
    .Link
        Add-WTColorScheme
    .Example
        New-WTColorScheme -Name MyColorScheme
    #>
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", "", Justification="Not changing state"
    )]
    param(
    # The name of the color scheme
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string]
    $Name,

    # The scheme's definition of the color Black.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Black = '#010101',

    # The scheme's definition of the color Red.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Red = '#dd0000',

    # The scheme's definition of the color Green.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Green = '#00dd00',

    # The scheme's definition of the color Yellow.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Yellow = '#dddd00',

    # The scheme's definition of the color Blue.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Blue = '#0000dd',

    # The scheme's definition of the color Cyan.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Cyan = '#00dddd',

    # The scheme's definition of the color Purple.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [Alias('Magenta')]
    [string]
    $Purple = '#dd00dd',

    # The scheme's definition of the color White.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $White = '#efefef',

    # The scheme's definition of the color BrightRed.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightRed = '#ff0000',

    # The scheme's definition of the color BrightGreen.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightGreen = '#00ff00',

    # The scheme's definition of the color BrightYellow.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightYellow = '#ffff00',

    # The scheme's definition of the color BrightBlue.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightBlue = '#0000ff',

    # The scheme's definition of the color BrightPurple.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightPurple = '#ff00ff',

    # The scheme's definition of the color BrightCyan.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightCyan = '#00ffff',

    # The scheme's definition of the color BrightWhite.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightWhite = '#ffffff',

    # The scheme's definition of the color BrightBlack.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $BrightBlack = '#0d0d0d',

    # The scheme's foreground color.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Foreground = '#fefefe',

    # The scheme's background color.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
    [string]
    $Background = '#012456'
    )

    process {
        #region Create Color Scheme Object
        $myCmdMetaData = [Management.Automation.CommandMetaData]$MyInvocation.MyCommand
        $newColorScheme = [Ordered]@{}
        foreach ($p in $myCmdMetaData.Parameters.Keys) {
            $k = $p.Substring(0,1).ToLower() + $p.Substring(1)
            $newColorScheme[$k] = $ExecutionContext.SessionState.PSVariable.Get($p).Value
        }
        [PSCustomObject]$newColorScheme
        #endregion Create Color Scheme Object
    }
}