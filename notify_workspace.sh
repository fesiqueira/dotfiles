#!/bin/bash
#Description: Using notify-send, pop-up the current workspace number when changing workspaces
#Requires: xfce4-notifyd, libnotify, wmctrl

CURRENT_WORKSPACE=$(wmctrl -d | grep \* | awk '{print $NF}')
while true; do
	sleep 1
	NEW_WORKSPACE=$(wmctrl -d | grep \* | awk '{print $NF}')
	if [[ $CURRENT_WORKSPACE != $NEW_WORKSPACE ]]; then
		notify-send -t 500 "$NEW_WORKSPACE"
		CURRENT_WORKSPACE=$NEW_WORKSPACE
	fi
done
exit 0
