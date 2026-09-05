#!/bin/sh

if [ ! -z "$(which dbus-send)" ]; then
  SHUTDOWN="dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop"
else
  SHUTDOWN="/bin/sh -c '/bin/echo give root password for POWEROFF or press C-d to exit; /bin/su -c /sbin/poweroff'"
fi
if command -v zenity >/dev/null 2>&1; then
  zenity --question --title="Power off" --text="Shutdown?"
  [ $? -eq 0 ] && ans=3 || ans=4
elif command -v gxmessage >/dev/null 2>&1; then
  gxmessage -nearmouse -buttons "Yes:3,No:4" -name "Power off" "Shutdown?"
  ans=$?
elif command -v xmessage >/dev/null 2>&1; then
  xmessage -nearmouse -buttons "Yes:3,No:4" -name "Power off" "Shutdown?"
  ans=$?
else
  ans=4
fi
case $ans in
3) ${SHUTDOWN} ;;
*) echo "abort Shutdown" ;;
esac
