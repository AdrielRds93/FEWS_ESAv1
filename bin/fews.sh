#!/bin/sh
#
# Script to start Delft-FEWS
#
# One argument required: the name of the region directory
# second argument optional - if this is "cm" then start config manager, 
#     if it is "la" start the Fews Launcher
#
# File history
# Version           Date                           Author
# $Revision: 39313 $  $Date: 2013-02-13 17:05:22 +0100 (wo, 13 feb 2013) $   $Author: akker_o $

# Path to the JRE
export JAVA_HOME=$(pwd)/jre

# Remote debugging: uncomment the following line:
#JVM_OPTS="$JVM_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=8800,suspend=y,server=y"

# Solves performance issues SSH
JVM_OPTS="$JVM_OPTS -Dsun.java2d.pmoffscreen=false"

REGIONHOME=$1
CMOPTION=$2

# Check that we have a region name
if [ wl"$REGIONHOME" = "wl" ]; then
   echo "Usage: $0 <region name> [cm|la]"
   exit 1
fi

# Remove any trailing / from the region name
REGIONHOME=$(echo ${REGIONHOME} | sed -e 's/\/$//') 

# Set the time zone (typically GMT)
export TZ="GMT"

# Check if the Config Manager or Launcher option is set
if [ wl"$CMOPTION" != "wl" ]; then
  if [ "$CMOPTION" = "cm" ]; then
    configmanager="true"
  elif [ "$CMOPTION" = "la" ]; then
    launcher="true"
  else
    # Any other 2nd option throws an error
    echo "Usage: $0 <region name> [cm|la]"
    exit 1
  fi
fi

# Make sure region directory exists
if [ ! -d "$REGIONHOME" ]; then
  echo "Error: $REGIONHOME : no such directory."
  exit 1
fi

WORKDIR=$(cd $REGIONHOME/.. ; pwd)
BINDIR=$WORKDIR/bin
JAVA_HOME=$WORKDIR/jre
export JAVA_HOME

# Application must be started from within the /bin/ directory
echo "Working directory is: $BINDIR"
cd $BINDIR || exit 1

echo "Starting $REGIONHOME"

# Assemble the list of jar files in the bin directory
classes=""
for f in $BINDIR/*.jar ;do
    if [ "$classes" = "" ]; then
        classes="$f"
    else
        classes="${classes}:$f"
    fi
done

echo "Using Java runtime: ${JAVA_HOME:-/opt/fews/java}/bin/java - should be at least version 1.7.0_11"
echo "Starting application ..."

# Export library path. Required by gfix and gbak
export LD_LIBRARY_PATH=$BINDIR:$LD_LIBRARY_PATH

if [ "$configmanager" = "true" ]; then
   ${JAVA_HOME:-/opt/fews/java}/bin/java -Xmx512M $JVM_OPTS -Djava.library.path=$BINDIR \
   -classpath "$classes" \
   nl.wldelft.fews.configmanagement.ConfigManagementApplication $REGIONHOME $BINDIR
elif [ "$launcher" = "true" ]; then
   ${JAVA_HOME:-/opt/fews/java}/bin/java -Xmx128M $JVM_OPTS -Djava.library.path=$BINDIR \
   -classpath "$classes" \
   nl.wldelft.fews.launcher.Launcher $REGIONHOME 
else
   ${JAVA_HOME:-/opt/fews/java}/bin/java -Xmx512M $JVM_OPTS -Djava.library.path=$BINDIR \
   -classpath "$classes" \
   nl.wldelft.fews.gui.explorer.Application $REGIONHOME $BINDIR
fi

exit
