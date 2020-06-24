function Clear-WTColorScheme
{
    <#
    .Synopsis
        Clears Windows Terminal Color Schemes
    .Description
        Clears the Windows Terminal Color Scheme for the current profile.
    .Example
        Clear-WTColorScheme
    .Link
        Get-WTColorScheme
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    param()

    process {
        Set-WTProfile -Current -InputObject @{colorScheme=''}
    }
}
