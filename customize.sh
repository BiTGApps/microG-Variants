#!/sbin/sh
#
# This file is part of The BiTGApps Project

# Default Permission
umask 022

# Manipulate SELinux State
setenforce 0

# Control and customize installation process
SKIPUNZIP=1

# Set environmental variables in the global environment
export ZIPFILE="$3"
export OUTFD="$2"
export TMP="/tmp"
export ASH_STANDALONE=1

# Installation base is Magisk not bootmode script
if [[ "$(getprop "sys.boot_completed")" = "1" ]]; then
  setprop sys.bootmode "2"
fi

# Allow override, when installation base is Magisk
if [[ "$(getprop "sys.bootmode")" = "2" ]]; then
  # Override environmental variable
  export TMP="/dev/tmp"
  # Avoid leading directories
  install -d $TMP
fi

# Check customization script
if [ -f "$MODPATH/customize.sh" ]; then
  ZIPFILE="/data/user/0/*/cache/flash/install.zip"
fi

# Handle Magisk Package Name
for f in $ZIPFILE; do
  echo "$f" >> $TMP/ZIPFILE
done

# Extend Globbing Package ID
ZIPFILE="$(cat $TMP/ZIPFILE)"

# Extract pre-bundled busybox
$(unzip -o "$ZIPFILE" "busybox-arm" -d "$TMP" >/dev/null 2>&1)
chmod +x "$TMP/busybox-arm"

# Extract installer script
$(unzip -o "$ZIPFILE" "installer.sh" -d "$TMP" >/dev/null 2>&1)
chmod +x "$TMP/installer.sh"

# Execute installer script
exec $TMP/busybox-arm sh "$TMP/installer.sh" "$@"

# Exit
exit "$?"
