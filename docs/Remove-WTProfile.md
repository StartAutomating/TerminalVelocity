Remove-WTProfile
----------------
### Synopsis
Removes a Windows Terminal Profile

---
### Description

Removes Windows Terminal Profiles,
or removes one or more -Property from a Windows Terminal profile.

---
### Related Links
* [Add-WTProfile](Add-WTProfile.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Add-WTProfile -Name 'DOS' -CommandLine cmd # Add a DOS profile
```
Remove-WTProfile -Name DOS # and get rid of it.
---
### Parameters
#### **ProfileName**

The name of the profile.



> **Type**: ```[String[]]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Default**

If -Default is present with no other parameters, clears the default profile settings.
If -Property is also present, removes properties from the default profile settings.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Property**

The name of one or more properties to remove from a profile.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



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
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Remove-WTProfile -ProfileName <String[]> [-Property <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Remove-WTProfile -Default [-Property <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
