## 0.3.1:

* Rebranded module to TerminalVelocity (Fixes #10)
* Added logo (Fixes #13) (thanks to [PSSVG](https://pssvg.start-automating.com))
* Add/New/Set-WTProfile:  Keeping in sync with Schema (Fixing #8) (thanks to [PipeScript](https://github.com/StartAutomating/PipeScript) )
* Set-WTProfile:
  * Added -Overwrite (Fixes #17)
  * Caching profile in memory (Fixes #11)
* Show-WT:
  * Support for -PixelShaders (Fixes #14)
  * Made -Wait wait and added -Duration (Fixes #15)
  * Restoring profiles after -Duration (Fixes #16)
* Autogenerating docs (Fixes #18) (thanks to [HelpOut](https://github.com/StartAutomating/HelpOut))

---

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

