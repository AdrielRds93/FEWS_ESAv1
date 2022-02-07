%~dp0mcLauncherService.exe --WinRun4J:RegisterService
sc config mcLauncher start= delayed-auto
sc failure mcLauncher actions= restart/60000ms/restart/60000/restart/60000ms// reset= 3600000