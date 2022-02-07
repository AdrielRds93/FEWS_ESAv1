%~dp0fssLauncherService.exe --WinRun4J:RegisterService
sc config fssLauncher start= delayed-auto
sc failure fssLauncher actions= restart/60000ms/restart/60000/restart/60000ms// reset= 3600000