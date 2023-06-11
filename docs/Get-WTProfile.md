Get-WTProfile
-------------




### Synopsis
Gets a Windows Terminal Profiles



---


### Description

Gets Windows Terminal profiles.

By default, Get-WTProfile gets all tab profiles.

To get the global profile, use Get-WTProfile -Global

To get color schemes, use Get-WTProfile -ColorScheme *



---


### Related Links
* [Set-WTProfile](Set-WTProfile.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
Get-WTProfile
```

#### EXAMPLE 2
```PowerShell
Get-WTProfile -Global
```



---


### Parameters
#### **ProfileName**

Returns Windows Terminal tab profiles, by name.






|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[String[]]`|false   |named   |true (ByPropertyName)|Name   |



#### **Guid**

Returns Windows Terminal tab profiles, by GUID.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Guid[]]`|false   |named   |true (ByPropertyName)|



#### **ColorScheme**

Returns Windows Terminal Color Schemes






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |named   |true (ByPropertyName)|



#### **Setting**

If -Setting is present, Get-WTProfile returns the global settings.






|Type      |Required|Position|PipelineInput        |Aliases                                                 |
|----------|--------|--------|---------------------|--------------------------------------------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Global<br/>Settings<br/>GlobalSetting<br/>GlobalSettings|



#### **Default**

If -Default is present, Get-WTProfile returns the default profile settings.






|Type      |Required|Position|PipelineInput        |Aliases |
|----------|--------|--------|---------------------|--------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Defaults|



#### **Current**

If -Current is present, Get-WTProfile attempts to determine the current profile






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|



#### **KeyBinding**

If -KeyBinding is present, Get-WTProfile will return keybindings.






|Type      |Required|Position|PipelineInput        |Aliases             |
|----------|--------|--------|---------------------|--------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Keys<br/>KeyBindings|



#### **Force**

If set, will force reloading of profile information.
By default, the profile object will be cached to improve performance.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |





---


### Outputs
* WindowsTerminal.Profile


* WindowsTerminal.ColorScheme






---


### Syntax
```PowerShell
Get-WTProfile [-ProfileName <String[]>] [-Force] [<CommonParameters>]
```
```PowerShell
Get-WTProfile [-Guid <Guid[]>] [-Force] [<CommonParameters>]
```
```PowerShell
Get-WTProfile [-ColorScheme <String[]>] [-Force] [<CommonParameters>]
```
```PowerShell
Get-WTProfile -Setting [-Force] [<CommonParameters>]
```
```PowerShell
Get-WTProfile -Default [-Force] [<CommonParameters>]
```
```PowerShell
Get-WTProfile -Current [-Force] [<CommonParameters>]
```
```PowerShell
Get-WTProfile -KeyBinding [-Force] [<CommonParameters>]
```
