#!/bin/sh

if command -v zenity >/dev/null 2>&1; then
  zenity --question --title="Restart" --text="Reboot?"
  [ $? -eq 0 ] && ans=3 || ans=4
elif command -v gxmessage >/dev/null 2>&1; then
  gxmessage -nearmouse -buttons "Yes:3,No:4" -name "Restart" "Reboot?"
  ans=$?
elif command -v xmessage >/dev/null 2>&1; then
  xmessage -nearmouse -buttons "Yes:3,No:4" -name "Restart" "Reboot?"
  ans=$?
else
  ans=4
fi
case $ans in
3) /sbin/reboot ;;
*) echo "abort Reboot" ;;
esac
