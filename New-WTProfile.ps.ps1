function New-WTProfile
{
    <#
    .Synopsis
        Creates a new Windows Terminal profile
    .Description
        Creates a new Windows Terminal tab profile.
    .Link
        Add-WTProfile
    .Example
        New-WTProfile -Name DOS -CommandLine cmd
    .Example
        New-WTProfile -Name kali-linux-pwsh -CommandLine 'wsl -d kali-linux -e pwsh'
    .Example
        New-WTProfile -Default
    #>
    [OutputType('WindowsTerminal.Profile')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", "", Justification="Not changing state"
    )]
    [JSONSchema(SchemaUri='https://aka.ms/terminal-profiles-schema#Profile',RemovePropertyPrefix='Experimental')]
    param()
}
