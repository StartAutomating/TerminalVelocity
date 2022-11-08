@{
    ModuleVersion='0.3'
    RootModule='TerminalVelocity.psm1'
    GUID = '4dbcc223-a65a-4970-ac98-a24e95cec9a8'
    Author = 'James Brundage'
    Copyright = '2020-2022 Start-Automating'
    Description = 'Fine tuning Windows Terminal'
    PrivateData = @{
        PSData = @{
            Tags = 'WindowsTerminal','TerminalVelocity'
            ProjectURI = 'https://github.com/StartAutomating/TerminalVelocity'
            LicenseURI = 'https://github.com/StartAutomating/TerminalVelocity/blob/master/LICENSE'
            ReleaseNotes = @'
## 0.3

* New Commands:
  * Clear-WTColorScheme
* Bugfixes
  * Show-WT now honors -UseAcrylic
  * Set-WTProfile -Current clarifies the current profile.
  * Add-WTProfile will now add profiles to the end.
  * Start-WT now handles -Split and multiple sequences effectively.

---

## 0.2
* New Commands:
  * Backup/Restore-WTProfile
  * Remove-WTColorScheme

* New Formatting:
  * Color Schemes can now be previewed.

* Improved Commands:
  * Show-WT:
    * Can now show from a URI
    * Can now show from within WSL instance
  * Start-WT can now run -Elevated

* Reliability improvements:
  * Set-WTProfile and Set-WTColorScheme now try up to three times
  * Show-WT now only clears the last image in a sequence, for improved perf and experience

* Assetation:
  * Included demo of color scheme preview

---
'@
        }
    }
    FormatsToProcess = 'TerminalVelocity.format.ps1xml'
}