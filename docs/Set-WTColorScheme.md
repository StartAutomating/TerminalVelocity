Set-WTColorScheme
-----------------
### Synopsis
Sets the Windows Terminal Color Scheme

---
### Description

Sets the color scheme used by a given tab profile in Windows Terminal.

If the tab profile is not provided, it will attempt to auto-detect based off of the window title.

---
### Related Links
* [Add-WTColorScheme](Add-WTColorScheme.md)



* [Get-WTColorScheme](Get-WTColorScheme.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Set-WTColorScheme -ColorScheme 'AdventureTime'
```

#### EXAMPLE 2
```PowerShell
Get-WTProfile -Name 'PowerShell' |
    Set-WTColorScheme 'AdventureTime'
```

---
### Parameters
#### **ColorScheme**

The name of the color scheme



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **ProfileName**

The name or ID of the tab profiles the color scheme will be applied to.
If this is not provided, it will attempt to auto-detect based off of the window title.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will pass thru the changes.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.
    
If you pass ```-Confirm:$false``` you will not be prompted.
    
    
If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)




---
### Syntax
```PowerShell
Set-WTColorScheme [-ColorScheme] <String> [[-ProfileName] <String[]>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
