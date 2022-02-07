@ECHO OFF
ECHO Windows subsystem for Linux is automatically shutdown when not used for a couple of minutes
ECHO Windows subsystem for Linux is started on demand.
ECHO When FEWS on Windows subsystem for Linux hangs or a GA executable can't be stopped you can run this script
ECHO FEWS ghost windows will stay visible for 30 seconds, you can ignore them. FEWS will be terminated inmediatelly
wsl --shutdown
PAUSE