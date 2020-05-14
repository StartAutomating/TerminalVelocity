function Remove-WTProfile
{
    <#
    .Synopsis
        Removes a Windows Terminal Profile
    .Description
        Removes Windows Terminal Profiles,
        or removes one or more -Property from a Windows Terminal profile.
    .Example
        Add-WTProfile -Name 'DOS' -CommandLine cmd # Add a DOS profile

        Remove-WTProfile -Name DOS # and get rid of it.
    .Link
        Add-WTProfile
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High',DefaultParameterSetName='SpecificProfile')]
    [OutputType([PSObject])]
    param(
    # The name of the profile.
    [Parameter(Mandatory,ParameterSetName='SpecificProfile',ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string[]]
    $ProfileName,

    # If -Default is present with no other parameters, clears the default profile settings.
    # If -Property is also present, removes properties from the default profile settings.
    [Parameter(Mandatory,ParameterSetName='DefaultProfile',ValueFromPipelineByPropertyName)]
    [Alias('Defaults')]
    [switch]
    $Default,

    # The name of one or more properties to remove from a profile.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Properties','PropertyName','PropertyNames')]
    [string[]]
    $Property
    )

    process {
        $wtProfile = Get-WTProfile -Global
        $targetProfiles =
            @(if ($Default) {
                $wtProfile.profiles.defaults
            } else {
                Get-WTProfile -ProfileName $ProfileName

            })
        if (-not $targetProfiles) { return }

        #region Removing Profiles
        if (-not $Property) # If no property was provided, we're removing whole profiles
        {
            if (-not $wtProfile.profiles) {
                $wtProfile |
                    Add-Member NoteProperty profiles ([PSCustomObject]@{list=@();defaults=[PSObject]::new()}) -Force
            }
            if ($Default) { # If we're "removing" the default profile, clear it
                $wtProfile.profiles | Add-Member NoteProperty defaults ([PSObject]::new()) -Force
            } else {
                $targetProfilesGuids = # Find all of the target GUIDs
                    $targetProfiles |
                        Select-Object -ExpandProperty GUID

                if ($null -eq $wtProfile.profiles.list) {
                    $wtProfile.profiles |
                        Add-Member NoteProperty list @() -Force
                }

                $wtProfile.profiles.list =  # reassign the profiles property to be
                    @(  # a list
                        foreach ($prof in $wtProfile.profiles.list) {  # containing profiles that were not
                            if ($targetProfilesGuids -notcontains # one of the target guids.
                                $prof.GUID) {
                                $prof
                            }
                        }
                    )
            }
        }
        #endregion Removing Profiles
        #region Removing Properties
        else
        {
            # To remove properties within target profiles
            foreach ($prof in $targetProfiles) # we need to walk each target profile.
            {
                # Then walk over each property.
                :NextProfileProperty # We'll label this loop :NextProfileProperty for performancce.
                    foreach ($prop in @($prof.psobject.properties))
                {
                    # Then we have to walk over each -Property, since they could be wildcards.
                    foreach ($p in $Property) {
                        if ($prop.Name -like $p) { # When the wildcard matches
                            $prof | Add-Member NoteProperty $prop.Name '' -Force
                            # make it blank so that
                            # Set-WTProfile will remove the property.
                            continue NextProfileProperty # then continue to the next profile property.
                        }
                    }
                }

                if ($prof.guid) {
                    $prof | Set-WTProfile
                } else {
                    $prof | Set-WTProfile -Default
                }
            }
            return
        }
        #endregion Removing Properties

        #region Updating Settings
        # Now that we've changed our object, let's update the settings
        if ($PSCmdlet.ShouldProcess("Update $($wtProfile.Path)")) {

            $wtPath = $wtProfile.Path
            $wtProfile.psobject.properties.Remove('Path')
            $wtProfile |
                ConvertTo-Json -Depth 100 |
                Set-Content -LiteralPath $wtPath -Force -Encoding UTF8
        }
        #endregion Updating Settings

        if ($WhatIfPreference -or $PassThru) {
            if ($Property) {
                foreach ($prof in $targetProfiles) {
                    $prof
                }
            } else {
                $wtProfile
            }
        }
    }
}