#!/bin/sh

FEWS_BIN_DIR=$(realpath "$(dirname "$(readlink -f "$0")")/..")

chmod +x ${FEWS_BIN_DIR}/linux/fssLauncher
chmod +x ${FEWS_BIN_DIR}/linux/fssShutdownAllAtThisHost
chmod +x ${FEWS_BIN_DIR}/linux/createShortcuts
chmod +x ${FEWS_BIN_DIR}/linux/gbak
chmod +x ${FEWS_BIN_DIR}/linux/gfix
chmod +x ${FEWS_BIN_DIR}/linux/jre/bin/java
chmod +x ${FEWS_BIN_DIR}/linux/mcLauncher
chmod +x ${FEWS_BIN_DIR}/linux/mctools

