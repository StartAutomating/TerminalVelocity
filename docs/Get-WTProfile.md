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



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Guid**

Returns Windows Terminal tab profiles, by GUID.



> **Type**: ```[Guid[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ColorScheme**

Returns Windows Terminal Color Schemes



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Setting**

If -Setting is present, Get-WTProfile returns the global settings.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Default**

If -Default is present, Get-WTProfile returns the default profile settings.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Current**

If -Current is present, Get-WTProfile attempts to determine the current profile



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **KeyBinding**

If -KeyBinding is present, Get-WTProfile will return keybindings.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Force**

If set, will force reloading of profile information.
By default, the profile object will be cached to improve performance.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



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
---
