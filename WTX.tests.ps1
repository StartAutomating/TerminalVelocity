#requires -Module Pester, WTX


$wtxModule = Get-Module WTX

$windowsTerminalTestProfile = @{
    '$schema'='https://aka.ms/terminal-profiles-schema'
    confirmCloseAllTabs=$false
    defaultProfile='{61c54bbd-c2c6-5271-96e7-009a87ff44bf}'
    keybindings=@()
    launchMode='default'
    profiles=@{
        defaults=@{
        }
        list= @{
            colorScheme='Blue Matrix'
            commandline='powershell.exe'
            guid='{61c54bbd-c2c6-5271-96e7-009a87ff44bf}'
            hidden=$false
            name='Windows PowerShell'
            padding='0,0,0,0'
        }, @{
            backgroundImageStrechMode='uniformToFill'
            colorScheme='AdventureTime'
            guid='{574e775e-4f2a-5b96-ac1e-a2962a402336}'
            hidden=$false
            name='PowerShell'
            source='Windows.Terminal.PowershellCore'
            useAcrylic=$false
        },
            @{
            guid='{2c4de342-38b7-51cf-b940-2309a097f518}'
            hidden=$false
            name='Ubuntu'
            source='Windows.Terminal.Wsl'
        },
        @{
            backgroundImageStrechMode='uniformToFill'
            colorScheme='Jackie Brown'
            guid='{46ca431a-3a87-5fb3-83cd-11ececc031d2}'
            hidden=$false
            name='kali-linux'
            source='Windows.Terminal.Wsl'
            useAcrylic=$false
        },
        @{
            commandline='wsl -d kali-linux -e pwsh'
            guid='{831f30f1-ce36-4f9f-9889-35b626581bcc}'
            hidden=$false
            name='kali-linux-powershell'
            source='Windows.Terminal.Wsl'
        }
    }
    schemes=@{
        name='AdventureTime'
        background='#1f1d45'
        black='#050404'
        blue='#0f4ac6'
        brightBlack='#4e7cbf'
        brightBlue='#1997c6'
        brightCyan='#c8faf4'
        brightGreen='#9eff6e'
        brightPurple='#9b5953'
        brightRed='#fc5f5a'
        brightWhite='#f6f5fb'
        brightYellow='#efc11a'
        cyan='#70a598'
        foreground='#f8dcc0'
        green='#4ab118'

        purple='#665993'
        red='#bd0013'
        white='#f8dcc0'
        yellow='#e7741e'
    },@{
        name='Batman'
        background='#1b1d1e'
        black='#1b1d1e'
        blue='#737174'
        brightBlack='#505354'
        brightBlue='#919495'
        brightCyan='#a3a3a6'
        brightGreen='#fff27d'
        brightPurple='#9a9a9d'
        brightRed='#fff78e'
        brightWhite='#dadbd6'
        brightYellow='#feed6c'
        cyan='#62605f'
        foreground='#6f6f6f'
        green='#c8be46'
        purple='#747271'
        red='#e6dc44'
        white='#c6c5bf'
        yellow='#f4fd22'
    },@{
        name='Grape'
        background='#171423'
        black='#2d283f'
        blue='#487df4'
        brightBlack='#59516a'
        brightBlue='#a9bcec'
        brightCyan='#9de3eb'
        brightGreen='#53aa5e'
        brightPurple='#ad81c2'
        brightRed='#f0729a'
        brightWhite='#a288f7'
        brightYellow='#b2dc87'
        cyan='#3bdeed'
        foreground='#9f9fa1'
        green='#1fa91b'

        purple='#8d35c9'
        red='#ed2261'
        white='#9e9ea0'
        yellow='#8ddc20'
    }, @{
        background='#2c1d16'
        black='#2c1d16'
        blue='#246eb2'
        brightBlack='#666666'
        brightBlue='#0000ff'
        brightCyan='#00e5e5'
        brightGreen='#86a93e'
        brightPurple='#e500e5'
        brightRed='#e50000'
        brightWhite='#e5e5e5'
        brightYellow='#e5e500'
        cyan='#00acee'
        foreground='#ffcc2f'
        green='#2baf2b'
        name='Jackie Brown'
        purple='#d05ec1'
        red='#ef5734'
        white='#bfbfbf'
        yellow='#bebf00'
    }
    tabWidthMode='titleLength'
}

$wtSettingsPath = if ($PSVersionTable.OS -and $PSVersionTable.OS -notlike '*Windows*') {
    Join-Path '/tmp' 'wtSettingsTest.json'
} else {
    Join-Path $env:Temp 'wtSettingsTest.json'
}


$windowsTerminalTestProfile | ConvertTo-Json -Depth 100 | Set-Content $wtSettingsPath -Encoding UTF8
. $wtxModule {
    $script:WTProfilePath = Get-Item "$args"
} $wtSettingsPath


describe WTX {
    it 'Can Get Global Settings' {
        Get-WTProfile -Global | Select-Object -ExpandProperty Path | should belike '*wtSettingsTest.json'
    }



    context Profiles {


        it 'Can List Profiles' {
            Get-WTProfile |
                Select-Object -ExpandProperty Name |
                should match '^(?>powershell|windows powershell|ubuntu|kali-linux-powershell|kali-linux)$'
        }

        it 'Can add a profile' {
            Add-WTProfile -Name DOS -Commandline cmd

            Get-WTProfile |
                Select-Object -ExpandProperty Name |
                should match '^(?>dos|powershell|windows powershell|ubuntu|kali-linux-powershell|kali-linux)$'
        }

        it 'Can remove a profile' {
            Remove-WTProfile -ProfileName DOS -Confirm:$false

            Get-WTProfile |
                Select-Object -ExpandProperty Name |
                should match '^(?>powershell|windows powershell|ubuntu|kali-linux-powershell|kali-linux)$'
        }
    }

    context ColorSchemes {
        it 'Can get color schemes' {
            Get-WTColorScheme |
                Select-Object -ExpandProperty Name |
                should match '^(?>Jackie Brown|Grape|Batman|AdventureTime)$'
        }
        it 'Can set color schemes' {
            Set-WTColorScheme -ProfileName PowerShell -ColorScheme Batman
            Get-WTProfile -ProfileName PowerShell |
                Select-Object -ExpandProperty ColorScheme |
                should be Batman
        }
    }
}

Remove-Item $wtSettingsPath

. $wtxModule {
    $script:WTProfilePath = $null
}
