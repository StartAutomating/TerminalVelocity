Stop-WT
-------
### Synopsis
Stops Windows Terminal

---
### Description

Stops Windows Terminal Processes

---
### Related Links
* [Start-WT](Start-WT.md)



* [Stop-Process](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Management/Stop-Process)



---
### Examples
#### EXAMPLE 1
```PowerShell
Stop-WT
```

---
### Parameters
#### **ID**

The Process ID



> **Type**: ```[Int32[]]```

> **Required**: true

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
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)




---
### Syntax
```PowerShell
Stop-WT [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Stop-WT -ID <Int32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
