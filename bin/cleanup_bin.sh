#!/bin/bash
#
# Delft FEWS
# Copyright (c) 2003-2012 Deltares - Delft Hydraulics. All Rights Reserved.
#
# Developed by:
# Tessella Support Services plc
# Tauro Kantorencentrum
# President Kennedylaan 19
# 2517 JK  Den Haag
# The Netherlands
# email: info@tessella.com
# web:   www.tessella.com
#
# Project Ref: Tessella/NPD/6204
#
# File history
# Version           Date                           Author
# $Revision: 54677 $  $Date: 2015-06-22 10:08:59 +0200 (ma, 22 jun 2015) $    $Author: breugel $
#
# Description:
# 
# Script to clean up unused libraries from the Delft FEWS build 
# (mostly libraries for other operating systems and JMS servers)
#
# Warning: running the script multiple times selecting different
#  options will render the build in the current directory inoperable!
#
# Return Values:
#  none
#
# Command line options and arguments
#  none
#

# Variables to hold the names of the various files to be deleted
LinuxLibs=$(ls lib*.so* hdf5klib.so ods.so)
WindowsLibs=$(ls *.dll *.DLL)
JBoss4Libs=jbossall-client.jar
JBoss5Libs='hornetq-core-client.jar hornetq-jms-client.jar jboss5-client.jar jboss-common-core.jar jboss-javaee.jar jboss-jms-api.jar jboss-remoting.jar jboss-security-spi.jar jboss-serialization.jar jbosssx-client.jar jnp-client.jar netty.jar'
JBoss7Libs=jboss-client.jar
WeblogicLibs=weblogic.jar
ActivemqLibs='activemq-client-5.11.1.jar hawtbuf-1.11.jar'

# Function to inform the user on usage
# Arguments : none
function print_usage() {
 echo "Script to clean up unused libraries from the Delft FEWS build" 
 echo "(mostly libraries for other operating systems and JMS servers)"
 echo 
 echo "Warning: running the script multiple times selecting different"
 echo " options will render the build in the current directory inoperable!"
 echo
 echo "Usage: $0 "
 echo
}

# Function to print the menu 
# Arguments : none
function print_menu() {
 echo 
 echo 
 echo "Delft FEWS build cleanup script"
 echo
 echo "Script to clean up unused libraries from the Delft FEWS build" 
 echo "(mostly libraries for other operating systems and JMS servers)"
 echo
 echo "Warning: running the script multiple times selecting different"
 echo " options will render the build in the current directory inoperable!"
 echo
 echo "Please select your combination of JMS Server and Operating System"
 echo " for Forecasting Shell and/or Operator Client:"
 echo
 echo "   1. JBoss 7 and MS Windows"
 echo "   2. JBoss 7 and Linux"
 echo "   3. JBoss 4 and MS Windows"
 echo "   4. JBoss 4 and Linux"
 echo "   5. JBoss 5 and MS Windows"
 echo "   6. JBoss 5 and Linux"
 echo "   7. ActiveMQ and MS Windows"
 echo "   8. ActiveMQ and Linux"
 echo "   q. quit without deletion"
 echo
 echo "   Please enter your selection: "
}

# Functions to delete files
function Jboss5MS() {
 echo
 echo Deleting files not for JBoss 5 and Windows:
 echo rm ${LinuxLibs} ${JBoss4Libs} ${JBoss7Libs} ${ActivemqLibs}
 rm ${LinuxLibs} ${JBoss4Libs} ${JBoss7Libs} ${ActivemqLibs} 
}

function Jboss5Linux() {
 echo
 echo Deleting files not for JBoss 5 and Linux:
 echo rm ${WindowsLibs} ${JBoss4Libs} ${JBoss7Libs} ${ActivemqLibs}
 rm ${WindowsLibs} ${JBoss4Libs} ${JBoss7Libs} ${ActivemqLibs}
}

function Jboss4MS() {
 echo
 echo Deleting files not for JBoss 4 and Windows:
 echo rm ${LinuxLibs} ${JBoss5Libs} ${JBoss7Libs} ${ActivemqLibs}
 rm ${LinuxLibs} ${JBoss5Libs} ${JBoss7Libs} ${ActivemqLibs}
}

function Jboss4Linux() {
 echo
 echo Deleting files not for JBoss 4 and Linux:
 echo rm ${WindowsLibs} ${JBoss5Libs} ${JBoss7Libs} ${ActivemqLibs}
 rm ${WindowsLibs} ${JBoss5Libs} ${JBoss7Libs} ${ActivemqLibs}
}

function Jboss7MS() {
 echo
 echo Deleting files not for JBoss 7 and Windows:
 echo rm ${LinuxLibs} ${JBoss4Libs} ${JBoss5Libs} ${ActivemqLibs}
 rm ${LinuxLibs} ${JBoss4Libs} ${JBoss5Libs} ${ActivemqLibs}
}

function Jboss7Linux() {
 echo
 echo Deleting files not for JBoss 7 and Linux:
 echo rm ${WindowsLibs} ${JBoss4Libs} ${JBoss5Libs} ${ActivemqLibs}
 rm ${WindowsLibs} ${JBoss4Libs} ${JBoss5Libs} ${ActivemqLibs}
}

function ActivemqMS() {
 echo
 echo Deleting files not for ActiveMQ and Windows:
 echo rm ${LinuxLibs} ${JBoss4Libs} ${JBoss5Libs} ${JBoss7Libs}
 rm ${LinuxLibs} ${JBoss4Libs} ${JBoss5Libs} ${JBoss7Libs}
}

function ActivemqLinux() {
 echo
 echo Deleting files not for ActiveMQ and Linux:
 echo rm ${WindowsLibs} ${JBoss4Libs} ${JBoss5Libs} ${JBoss7Libs}
 rm ${WindowsLibs} ${JBoss4Libs} ${JBoss5Libs} ${JBoss7Libs}
}

## Start of the actual script

# Process any command line options
while getopts "h" options; do
  case $options in 
   h ) print_usage  # help option
          exit 0;;
   \? ) print_usage  # unknown option
          exit 1;;
  esac
done

# Check if we are running in a Delft FEWS bin/ directory
if [ ! -e ./Delft_FEWS.jar ]
then
   echo
   echo "ERROR: Please make sure the current directory is the"
   echo "Delft FEWS bin/ directory."
   echo
   exit 1
fi 

# Print menu and read the choice
print_menu;
read choice;

# Process the choice made
case $choice in
  1 ) Jboss7MS
      exit 0;;
  2 ) Jboss7Linux
      exit 0;;
  3 ) Jboss4MS
      exit 0;;
  4 ) Jboss4Linux
      exit 0;;
  5 ) Jboss5MS
      exit 0;;
  6 ) Jboss5Linux
      exit 0;;
  7 ) ActivemqMS
      exit 0;;
  8 ) ActivemqLinux
      exit 0;;
  q ) exit 0;;
  \? ) echo "Invalid option"
      exit 1;;
esac

