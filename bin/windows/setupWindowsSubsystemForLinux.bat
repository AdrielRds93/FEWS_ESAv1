@ECHO OFF
ECHO Running FEWS in Windows Subsystem For Linux (WSL) enables you 
ECHO to run Linux executables in the General adapter on Windows without the need for using a Linux virtual machine.
ECHO. 
ECHO FEWS runs on clean WSL Linux distribution
ECHO There is no need to install any linux library or java runtime
ECHO There is no need to copy the FEWS bin to the Linux partition. 
ECHO There is no need to copy config or datastores to the Linux partition
ECHO. 
ECHO Linux partition will be available from any Windows file explorer at //wsl$/Ubuntu
ECHO. 
ECHO MobaxXTerm should be running before starting FEWS on Windows Subsystem For Linux
ECHO. 
ECHO Just double click the /bin/linux/createShortcuts from Windows to create a sh file for your clientConfig.xml. 
ECHO This sh file can be double clicked from Windows 
ECHO The SA/OC will start and appears as a normal Windows Application.
ECHO. 
ECHO You need Windows 10 Version 1903 or higher, with Build 18362 or higher
ECHO Run this script once with admin rights.
PAUSE
CLS
ASSOC .sh=wsl
FTYPE wsl=cmd /c start /min C:\Windows\System32\wsl.exe `wslpath '%%1'`
ASSOC .=wsl
FTYPE wsl=cmd /c start /min C:\Windows\System32\wsl.exe `wslpath '%%1'`
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
:: firebrid datastores will not run in wsl2
wsl --set-default-version 2
ECHO. 
ECHO When the VirtualMachinePlatform was not already enabled you need to restart your PC
ECHO and run this setupWindowsSubsystemForLinux.bat again. Inspect the log above
PAUSE
CLS
ECHO Now install Ubuntu.
ECHO After installation launch Unbuntu to continue the installation.
ECHO You are asked for a user name password. You can enter any username password you want. 
ECHO You only need the password to update the linux distribution or install a program (e.g. phyton)
ECHO Run "wsl --unregister Unbuntu" and install Ubuntu again if you need a clean uptodate installation or forgot the password. 
ECHO Press any key to go to the Microsoft Ubuntu installation page
PAUSE
CLS
start msedge "https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab"
ECHO Now download MobaXterm.
ECHO All editions will work. The portable edition is just single small executable you can put anywhere.  
ECHO Press any key to go to the mobaxterm download page.
PAUSE
start msedge "https://mobaxterm.mobatek.net/download-home-edition.html"
