#!/bin/bash

echo "Uninstalling Cursor AI IDE..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo."
  exit 1
fi

# Remove the AppImage
if [ -f /opt/cursor.appimage ]; then
    rm -f /opt/cursor.appimage
    echo "Removed AppImage."
fi

# Remove the icon
if [ -f /opt/cursor.png ]; then
    rm -f /opt/cursor.png
    echo "Removed icon."
fi

# Remove the desktop entry
if [ -f /usr/share/applications/cursor.desktop ]; then
    rm -f /usr/share/applications/cursor.desktop
    echo "Removed desktop entry."
fi

# Remove the command link
if [ -f /usr/local/bin/cursor ]; then
    rm -f /usr/local/bin/cursor
    echo "Removed command link."
fi

echo "Cursor AI IDE has been uninstalled."
echo "User configuration files in your home directory have not been removed."
echo "If you want to remove them as well, you can delete the following directories:"
echo "  ~/.config/Cursor"
echo "  ~/.local/share/Cursor" 