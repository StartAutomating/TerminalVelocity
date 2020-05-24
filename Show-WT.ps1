function Show-WT
{
    <#
    .Synopsis
        Shows Images in the Windows Terminal
    .Description
        Shows Images in the Windows Terminal.

        By default, .GIF files will play once, and non-GIFs will stay for 15 seconds.
    .Example
        Show-WT -ImagePath .\My.gif  # Shows My.gif in the current Windows Terminal profile.
    .Example
        Show-WT -ImagePath .\My.gif -Wait -1 # Shows My.gif forever
    .Link
        Get-WTProfile
    .Link
        Set-WTProfile
    #>
    [OutputType([Management.Automation.Job], [Nullable])]
    param(
    # The path to an image file.
    [Parameter(Mandatory,ParameterSetName='ImageFile',ValueFromPipelineByPropertyName,Position=0)]
    [ValidatePattern('\.(gif|jpg|jpeg|png)$')]
    [Alias('FullName','Image','BackgroundImage')]
    [string]
    $ImagePath,

    # If set, will display content in a given profile.
    # If not set, will attempt to auto-detect the profile.
    # If the profile cannot be automatically detected, content will be displayed using the default profile settings.
    # (this will not override an existing image)
    [string]
    $ProfileName,


    # Sets the alignment of the Image to draw over the window background.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [ValidateSet('bottom','bottomLeft','bottomRight','center','left','right','top','topLeft','topRight')]
    [Alias('BackgroundImageAlignment', 'ImageAlignment')]
    [string]
    $Alignment= 'center',

    # Sets the opacity of the Image to draw over the window background.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [Alias('BackgroundImageOpacity','ImageOpacity')]
    [float]
    $Opacity = .9,
    # Sets how the background image is resized to fill the window.

    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [ValidateSet('fill','none','uniform','uniformToFill')]
    [Alias('BackgroundImageStretchMode', 'ImageStretchMode')]
    [string]
    $StretchMode= 'uniformToFill',

    # Sets how long the image should be displayed.
    # If the duration is negative, the image will not be automatically cleared.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [Timespan]
    $Wait,

    # Sets the number of times an animated .gif should be looped.
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [int]
    $LoopCount = 1,

    <#
    When useAcrylic is set to true, it sets the transparency of the window for the profile.
    Accepts floating point values from 0-1 (default 0.5).
    #>
    [Parameter(ParameterSetName='ImageFile',ValueFromPipelineByPropertyName)]
    [float]
    $AcrylicOpacity,

    <#
    When set to true, the window will have an acrylic background.
    When set to false, the window will have a plain, untextured background.
    #>
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $UseAcrylic,

    # If set, will run in a background job.
    [switch]
    $AsJob
    )


    begin {
        #region Prepare Background Job
        $jobCmd = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Start-ThreadJob','Alias,Cmdlet,Function')
        if (-not $jobCmd) {
            $jobCmd = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Start-Job','Alias,Cmdlet,Function')
        }

        $jobDef = [ScriptBlock]::Create(@"
param([Collections.IDictionary]`$parameters)
Import-Module '$($MyInvocation.MyCommand.Module.Path | Split-Path)'
$($MyInvocation.MyCommand.Name) @parameters
"@)
        #endregion Prepare Background Job

        $getGifLength = {
            param([string]$resolvedPath)
            if (-not ('Drawing.Image' -as [type])) {
                Add-Type -AssemblyName System.Drawing
            }
            $img = [Drawing.Image]::FromFile($resolvedPath)
            $frameCount =
                try {
                    $img.GetFrameCount([Drawing.Imaging.FrameDimension]::Time)
                } catch {0}

            $frameTimes = try { $img.GetPropertyItem(20736).Value } catch { 0 }
            if ($frameTimes) {
                $totalMS = 0
                for ($i=0; $i -lt $frameCount; $i++) {
                    $totalMS+=[BitConverter]::ToInt32($frameTimes,$i * 4) * 10
                }
                [Timespan]::FromMilliseconds($totalMS)
            }
            $img.Dispose()
        }
        $accumulateArgs = [Collections.Generic.List[Collections.IDictionary]]::new()
    }


    process {
        $accumulateArgs.Add((@{} + $PSBoundParameters))
    }
    end {
        foreach ($acc in $accumulateArgs) {
            foreach ($kv in $acc.GetEnumerator()) {
                $ExecutionContext.SessionState.PSVariable.Set($kv.Key, $kv.Value)
            }
            if ($PSCmdlet.ParameterSetName -eq 'ImageFile') {



            if (-not $targetProfile) {
                $targetProfile =
                    if (-not $ProfileName) {
                        Get-WTProfile -Current
                    } else {
                        Get-WTProfile -ProfileName $ProfileName
                    }
            }

            if (-not $targetProfile) {
                $targetProfile = Get-WTProfile -Default
            }

            if (-not $targetProfile) {
                Write-Error "No target profile - WT_PROFILE_ID '$env:WT_PROFILE_ID'"
                return
            }

            $imageFileUri = $imagePath -as [uri]
            if ($imageFileUri.Authority) {
                $imageDest =
                    if ($PSVersionTable.OS -and $PSVersionTable.OS -notlike '*windows*') {
                        Join-Path "/home/$($env:USER)/Pictures" $imageFileUri.Segments[-1]
                    } else {
                        Join-Path "$home\Pictures" $imageFileUri.Segments[-1]
                    }
                $newFile = New-Item -ItemType File -Path $imageDest -Force
                [Net.Webclient]::new().DownloadFile($imageFileUri, $newFile.FullName)
                $imagePath = $newFile.FullName
            }
            $resolvedPath = $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($ImagePath)
            if (-not $resolvedPath) { return }


            $myParameters = @{} + $PSBoundParameters
            $resolvedPath = Get-Item -LiteralPath $resolvedPath | Select-Object -ExpandProperty Fullname

            $myParameters['ImagePath'] = "$resolvedPath"
            if (-not $ProfileName -and $ENV:WT_PROFILE_ID) {
                $ProfileName = $myParameters['ProfileName'] = $ENV:WT_PROFILE_ID
            }
            if ($AsJob) {
                $myParameters.Remove('AsJob')
                & $jobCmd -ScriptBlock $jobDef -ArgumentList $MyParameters
                return
            }




            $wasUsingAcrylic = ($targetProfile.useAcrylic -as [bool])
            $oldAcrylicOpacity = ($targetProfile.acrylicOpacity -as [float])
            $realPath =
                if ($resolvedPath -like '/mnt/*') { # If we're trying to show an image with a mounted path
                    $resolvedPath -replace '/mnt/(?<Letter>[a-z])', '${Letter}:\' -replace '/', '\'
                } elseif ($PSVersionTable.OS -and
                    $PSVersionTable.OS -notlike '*Windows*' -and $env:WSL_DISTRO_NAME) {
                    "\\wsl$\$($env:WSL_DISTRO_NAME)\" + ($resolvedPath -replace '/','\')
                } else {
                    $resolvedPath
                }


            $updatedProfile = $targetProfile |
                Add-Member backgroundImage "$realPath" -Force -PassThru |
                Add-Member backgroundImageOpacity $Opacity -Force -PassThru |
                Add-Member backgroundImageAlignment $Alignment -Force -PassThru |
                Add-Member backgroundImageStrechMode $StretchMode -Force -PassThru |
                Add-Member useAcrylic ([bool]$UseAcrylic) -Force -PassThru

            

            if ($AcrylicOpacity) {
                $updatedProfile = $updatedProfile |
                    Add-Member acrylicOpacity $AcrylicOpacity -Force -PassThru
            }

            if ($targetProfile.guid) {
                Set-WTProfile -ProfileName $targetProfile.guid -Confirm:$false -InputObject $updatedProfile
            } else {
                Set-WTProfile -Default -Confirm:$false -InputObject $updatedProfile
            }

            if (-not $PSBoundParameters['Wait'] -and $ImagePath -like '*.gif') {
                $Wait = try {
                    & $getGifLength $resolvedPath
                } catch {
                    [Timespan]::FromSeconds(2.5 * (Get-Item -LiteralPath $resolvedPath).Length /1mb)
                }
            }
            if ($LoopCount -ne 1) {
                $wait = [Timespan]::FromMilliseconds((& $getGifLength $resolvedPath).TotalMilliseconds * $LoopCount)
            }
            if ($Wait.TotalMilliseconds -ge 0) {
                Start-Sleep -milliseconds $Wait.TotalMilliseconds
                if ($acc -eq $accumulateArgs[-1]) {
                    $blankImageFields = [PSCustomObject]@{
                        backgroundImage =''
                        backgroundImageOpacity = ''
                        backgroundImageAlignment = ''
                        backgroundImageStretchMode = ''
                        useAcrylic = $wasUsingAcrylic
                        acrylicOpacity = $oldAcrylicOpacity
                    }
                    if ($targetProfile.guid) {
                        $blankImageFields |
                            Set-WTProfile -ProfileName $targetProfile.guid -Confirm:$false
                    } else {
                        $blankImageFields |
                            Set-WTProfile -Default -Confirm:$false
                    }
                }


            }
        }
        }
    }
}
