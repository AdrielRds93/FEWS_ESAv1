rem deletes all environment variables that starts with FEWS_
rem restart the cmd and total commander afterwards
@echo off
cls
for /f "delims== tokens=1,2" %%a in ('set') do call :DeleteEnv %%a
rem force refresh
setx /m dummy dummy
goto End
:DeleteEnv
set name=%1
if /i "%name:~0,5%"=="FEWS_" (
	reg delete "HKCU\Environment" /f /v %name% 
	reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V %name%
)
:End
  