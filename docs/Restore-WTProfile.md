Restore-WTProfile
-----------------
### Synopsis
Restores a Windows Terminal Profile

---
### Description

Restores a Windows Terminal Profile backup.

---
### Related Links
* [Backup-WTProfile](Backup-WTProfile.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Restore-WTProfile -SourcePath .\WindowsTerminal.2020-05-17.backup.json
```

---
### Parameters
#### **SourcePath**

> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Restore-WTProfile [-SourcePath] <String> [<CommonParameters>]
```
---
