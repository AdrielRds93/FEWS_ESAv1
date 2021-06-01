@echo off
::
:: Delft FEWS
:: Copyright (c) 2003-2010 Deltares - Delft Hydraulics. All Rights Reserved.
::
:: Developed by:
:: Tessella Support Services plc
:: Tauro Kantorencentrum
:: President Kennedylaan 19
:: 2517 JK  Den Haag
:: The Netherlands
:: email: info@tessella.com
:: web:   www.tessella.com
::
:: Project Ref: Tessella/NPD/6204
::
:: File history
:: Version           Date                           Author
:: $Revision: 54677 $     $Date: 2015-06-22 10:08:59 +0200 (ma, 22 jun 2015) $                       $Author: breugel $
::
:: Description:
:: 
:: Script to clean up unused libraries from the Delft FEWS build 
:: (mostly libraries for other operating systems and JMS servers)
::
:: Warning: running the script multiple times selecting different
::  options will render the build in the current directory inoperable!
::
:: Return Values:
::  none
::
:: Command line options and arguments
::  none
::

:: Check if we have the right number of arguments
IF [%1] == [/?] GOTO Syntax 
IF [%1] == [/h] GOTO Syntax 
IF [%1] == [-h] GOTO Syntax 

:: Check if we are running in a Delft FEWS bin/ directroy
IF NOT EXIST ".\Delft_FEWS.jar" GOTO NotInBinDir

:: Make the environment variables local to this batch file
SETLOCAL

:: Variables to hold the names of the various files to be deleted
SET LinuxLibs=lib*.so* hdf5klib.so ods.so
SET WindowsLibs=*.dll *.DLL
SET JBoss4Libs=jbossall-client.jar
SET JBoss5Libs=hornetq-core-client.jar hornetq-jms-client.jar jboss5-client.jar jboss-common-core.jar jboss-javaee.jar jboss-jms-api.jar jboss-remoting.jar jboss-security-spi.jar jboss-serialization.jar jbosssx-client.jar jnp-client.jar netty.jar
SET JBoss7Libs=jboss-client.jar
SET WeblogicLibs=weblogic.jar
SET ActivemqLibs=activemq-client-5.11.1.jar hawtbuf-1.11.jar

IF [%1] == [-c] (
SET choice=%2
GOTO CHOICE_AS_ARG
)

:: Display the menu
CLS
ECHO.
ECHO  Delft FEWS build cleanup script
ECHO.
ECHO  Script to clean up unused libraries from the Delft FEWS build 
ECHO  (mostly libraries for other operating systems and JMS servers)
ECHO.
ECHO  Warning: running the script multiple times selecting different
ECHO   options will render the build in the current directory inoperable!
ECHO.
ECHO  Please select your combination of JMS Server and Operating System
ECHO   for Forecasting Shell and/or Operator Client:
ECHO.
ECHO    1. JBoss 7 and MS Windows
ECHO    2. JBoss 7 and Linux
ECHO    3. JBoss 4 and MS Windows
ECHO    4. JBoss 4 and Linux
ECHO    5. JBoss 5 and MS Windows
ECHO    6. JBoss 5 and Linux
ECHO    7. ActiveMQ and MS Windows
ECHO    8. ActiveMQ and Linux
ECHO    q. quit without deletion
ECHO.

:: Register the choice
SET choice=
SET /P choice="Enter option: "
GOTO DEFAULT

:CHOICE_AS_ARG
ECHO Choice passed as argument: %choice%

:DEFAULT
IF '%choice%'=='' GOTO EndScript
IF '%choice%'=='q' GOTO EndScript
IF '%choice%'=='Q' GOTO EndScript
IF '%choice%'=='1' GOTO Jboss7MS
IF '%choice%'=='2' GOTO Jboss7Linux
IF '%choice%'=='3' GOTO Jboss4MS
IF '%choice%'=='4' GOTO Jboss4Linux
IF '%choice%'=='5' GOTO Jboss5MS
IF '%choice%'=='6' GOTO Jboss5Linux
IF '%choice%'=='7' GOTO ActivemqMS
IF '%choice%'=='8' GOTO ActivemqLinux

ECHO Invalid option "%choice%"; script will exit
GOTO EndScript

:: Delete the files
:Jboss5MS
ECHO.
ECHO Deleting files not for JBoss 5 and Windows:
ECHO DEL /Q %LinuxLibs% %JBoss4Libs% %JBoss7Libs% %ActivemqLibs%
DEL /Q %LinuxLibs% %JBoss4Libs% %JBoss7Libs% %ActivemqLibs%
GOTO EndScript

:Jboss5Linux
ECHO.
ECHO Deleting files not for JBoss 5 and Linux:
ECHO DEL /Q %WindowsLibs% %JBoss4Libs% %JBoss7Libs% %ActivemqLibs%
DEL /Q %WindowsLibs% %JBoss4Libs% %JBoss7Libs% %ActivemqLibs%
GOTO EndScript

:Jboss4MS
ECHO.
ECHO Deleting files not for JBoss 4 and Windows:
ECHO DEL /Q %LinuxLibs% %JBoss5Libs% %JBoss7Libs% %ActivemqLibs%
DEL /Q %LinuxLibs% %JBoss5Libs% %JBoss7Libs% %ActivemqLibs%
GOTO EndScript

:Jboss4Linux
ECHO.
ECHO Deleting files not for JBoss 4 and Linux:
ECHO DEL /Q %WindowsLibs% %JBoss5Libs% %JBoss7Libs% %ActivemqLibs%
DEL /Q %WindowsLibs% %JBoss5Libs% %JBoss7Libs% %ActivemqLibs%
GOTO EndScript

:JBoss7MS
ECHO.
ECHO Deleting files not for JBoss 7 and Windows:
ECHO DEL /Q %LinuxLibs% %JBoss4Libs% %JBoss5Libs% %ActivemqLibs%
DEL /Q %LinuxLibs% %JBoss4Libs% %JBoss5Libs% %ActivemqLibs%
GOTO EndScript

:JBoss7Linux
ECHO.
ECHO Deleting files not for JBoss 7 and Linux:
ECHO DEL /Q %WindowsLibs% %JBoss4Libs% %JBoss5Libs% %ActivemqLibs%
DEL /Q %WindowsLibs% %JBoss4Libs% %JBoss5Libs% %ActivemqLibs%
GOTO EndScript

:ActivemqMS
ECHO.
ECHO Deleting files not for ActiveMQ and Windows:
ECHO DEL /Q %LinuxLibs% %JBoss4Libs% %JBoss5Libs% %JBoss7Libs%
DEL /Q %LinuxLibs% %JBoss4Libs% %JBoss5Libs% %JBoss7Libs%
GOTO EndScript

:ActivemqLinux
ECHO.
ECHO Deleting files not for ActiveMQ and Linux:
ECHO DEL /Q %WindowsLibs% %JBoss4Libs% %JBoss5Libs% %JBoss7Libs%
DEL /Q %WindowsLibs% %JBoss4Libs% %JBoss5Libs% %JBoss7Libs%
GOTO EndScript

:: And finish the script
GOTO EndScript

:Syntax
:: Explain the syntax to the user
ECHO Script to clean up unused libraries from the Delft FEWS build 
ECHO (mostly libraries for other operating systems and JMS servers)
ECHO.
ECHO  Warning: running the script multiple times selecting different
ECHO   options will render the build in the current directory inoperable!
ECHO.
ECHO Usage: %0 
ECHO.

GOTO EndScript

:: Explain the user we are not in the bin directory
:NotInBinDir
ECHO.
ECHO ERROR: Please make sure the current directory is the
ECHO Delft FEWS bin/ directory.
ECHO.

GOTO EndScript

:EndScript
@echo on
