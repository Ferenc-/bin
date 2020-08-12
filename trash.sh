#!/bin/bash
# Based on:
# http://ubuntuhandbook.org/index.php/2018/08/add-trash-icon-dock-launcher-ubuntu-18-04/
# But enhanced in the r) branch to also update back with non full trash
# Furthermore it has been moved to $HOME/.local/bin/trash.sh


# Further optimized to only overwrite the trash.desktop file if it is really needed.
# So check first if it is even needed. This can reduce the constant syslog message
# 'gnome-software[9934]: failed to rescan: Failed to parse /home/user1/.local/share/applications/trash.desktop file: cannot process file of type application/x-desktop'
# Which can make gnome-software consume up to 100% CPU!

# For user level systemd unit cat > ~/.config/systemd/user/trashcan.service

# [Unit]
# Description=Service that changes the trashcan icon to full or empty
# After=graphical.target
# 
# [Service]
# Type=simple
# RemainAfterExit=no
# ExecStart=/home/user1/.local/bin/trash.sh -d
# ExecStop=/usr/bin/killall trash.sh
# NoNewPrivileges=true
# Restart=on-failure

icon=$HOME/.local/share/applications/trash.desktop

while getopts "red" opt; do
    case $opt in
    r)
    # Trash icon has to be full
    if [ "$(gio list trash://)" ]; then
      # Trash icon is not full yet
      if ! grep "Icon=user-trash-full" ${icon}; then
        echo -e '[Desktop Entry]\nType=Application\nName=Trash\nComment=Trash\nIcon=user-trash-full\nExec=nautilus trash://\nCategories=Utility;\nActions=trash;\n\n[Desktop Action trash]\nName=Empty Trash\nExec='$HOME/.local/bin/trash.sh -e'\n' > $icon
      fi
    # Trash icon has to be empty
    else
      # Trash icon is not empty yet
      if grep "Icon=user-trash-full" ${icon}; then
        echo -e '[Desktop Entry]\nType=Application\nName=Trash\nComment=Trash\nIcon=user-trash\nExec=nautilus trash://\nCategories=Utility;\nActions=trash;\n\n[Desktop Action trash]\nName=Empty Trash\nExec='$HOME/.local/bin/trash.sh -e'\n' > $icon
      fi
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
