#!/bin/bash
# Based on:
# http://ubuntuhandbook.org/index.php/2018/08/add-trash-icon-dock-launcher-ubuntu-18-04/
# But enhanced in the r) branch to also update back with non full trash
# Furthermore it has been moved to $HOME/.local/bin/trash.sh

icon=$HOME/.local/share/applications/trash.desktop

while getopts "red" opt; do
	case $opt in
    r)
	if [ "$(gio list trash://)" ]; then
		echo -e '[Desktop Entry]\nType=Application\nName=Trash\nComment=Trash\nIcon=user-trash-full\nExec=nautilus trash://\nCategories=Utility;\nActions=trash;\n\n[Desktop Action trash]\nName=Empty Trash\nExec='$HOME/.local/bin/trash.sh -e'\n' > $icon
    else
		echo -e '[Desktop Entry]\nType=Application\nName=Trash\nComment=Trash\nIcon=user-trash\nExec=nautilus trash://\nCategories=Utility;\nActions=trash;\n\n[Desktop Action trash]\nName=Empty Trash\nExec='$HOME/.local/bin/trash.sh -e'\n' > $icon
	fi
	;;
    e)
	gio trash --empty && echo -e '[Desktop Entry]\nType=Application\nName=Trash\nComment=Trash\nIcon=user-trash\nExec=nautilus trash://\nCategories=Utility;\nActions=trash;\n\n[Desktop Action trash]\nName=Empty Trash\nExec='$HOME/.local/bin/trash.sh -e'\n' > $icon
	;;
    d)
	while sleep 5; do ($HOME/.local/bin/trash.sh -r &) ; done
	;;
  esac
done
