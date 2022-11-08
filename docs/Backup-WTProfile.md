Backup-WTProfile
----------------
### Synopsis
Backs up the Windows Terminal Profile

---
### Description

Backs up the Windows Terminal Profile.

By default, backups will be placed in the same directory as $profile, and will include a datestamp.

---
### Related Links
* [Get-WTProfile](Get-WTProfile.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Backup-WTProfile
```

---
### Parameters
#### **DestinationPath**

The destination path for the backup.
By default, this will be in the same directory as $profile, and will include a datestamp.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Backup-WTProfile [[-DestinationPath] <String>] [<CommonParameters>]
```
---
