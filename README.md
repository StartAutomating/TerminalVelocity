
WTX [0.1]
=========

Windows Terminal Extras | Optimize-WindowsTerminal -with PowerShell
---------

### Commands
-----------------------
|  Verb|Noun          |
|-----:|:-------------|
|   Add|-WTColorScheme|
|      |-WTProfile    |
|   Get|-WTColorScheme|
|      |-WTProfile    |
|   New|-WTColorScheme|
|      |-WTProfile    |
|Remove|-WTProfile    |
|   Set|-WTColorScheme|
|      |-WTProfile    |
|  Show|-WT           |
| Start|-WT           |
|  Stop|-WT           |
-----------------------
### WTX is a PowerShell module that lets you customize Windows Terminal.


Here are a few handy things you can do with WTX:

#### Adding a new Profile
~~~
Add-WTProfile -Name kali-linux-pwsh -CommandLine 'wsl -d kali-linux -e pwsh'
~~~


#### Adding a new color scheme
~~~
Add-WTColorScheme -Name AdventureTime
~~~


#### Changing the color scheme
~~~
Set-WTColorScheme -Name AdventureTime # The profile is automatically detected.
~~~


#### Starting a new Terminal
~~~
Start-WT -ProfileName PowerShell -CommandLine 'powershell -nologo -noexit -command $psVersionTable'
~~~

#### Flashing an image in Terminal
~~~
# The profile is automatically detected
# The .gif will play once and then dissapear.
Show-WT -ImagePath $home\Picture\Gif\Whoa.gif 
~~~




