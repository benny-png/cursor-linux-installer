#!/bin/bash

installCursor() {
    echo "Checking for existing installation..."
    if [ -f /opt/cursor.appimage ]; then
        read -p "Cursor AI IDE is already installed. Would you like to reinstall/update? (y/n): " choice
        case "$choice" in 
            y|Y ) echo "Proceeding with reinstallation...";;
            * ) echo "Installation cancelled."; return 1;;
        esac
    fi

    echo "Installing Cursor AI IDE..."

    # URLs for Cursor AppImage and Icon
    CURSOR_URL="https://downloader.cursor.sh/linux/appImage/x64"
    ICON_URL="https://raw.githubusercontent.com/rahuljangirwork/copmany-logos/refs/heads/main/cursor.png"

    # Paths for installation
    APPIMAGE_PATH="/opt/cursor.appimage"
    ICON_PATH="/opt/cursor.png"
    DESKTOP_ENTRY_PATH="/usr/share/applications/cursor.desktop"

    # Detect package manager
    if command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
    elif command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
    elif command -v zypper &> /dev/null; then
        PKG_MANAGER="zypper"
    else
        echo "Warning: Could not detect package manager. You may need to install curl manually."
        PKG_MANAGER="unknown"
    fi

    # Install curl if not installed
    if ! command -v curl &> /dev/null; then
        echo "curl is not installed. Installing..."
        case $PKG_MANAGER in
            apt)
                sudo apt-get update
                sudo apt-get install -y curl
                ;;
            dnf)
                sudo dnf install -y curl
                ;;
            pacman)
                sudo pacman -S --noconfirm curl
                ;;
            zypper)
                sudo zypper install -y curl
                ;;
            *)
                echo "Error: curl is required but could not be installed automatically."
                echo "Please install curl manually and run this script again."
                return 1
                ;;
        esac
    fi

    # Create directories if they don't exist
    sudo mkdir -p "$(dirname "$APPIMAGE_PATH")"
    sudo mkdir -p "$(dirname "$DESKTOP_ENTRY_PATH")"

    # Download Cursor AppImage
    echo "Downloading Cursor AppImage..."
    if ! sudo curl -L "$CURSOR_URL" -o "$APPIMAGE_PATH"; then
        echo "Error: Failed to download Cursor AppImage."
        return 1
    fi
    sudo chmod +x "$APPIMAGE_PATH"

    # Download Cursor icon
    echo "Downloading Cursor icon..."
    if ! sudo curl -L "$ICON_URL" -o "$ICON_PATH"; then
        echo "Warning: Failed to download Cursor icon. Using a default icon."
        # Create a simple text file as a fallback icon
        echo "Cursor" | sudo tee "$ICON_PATH" > /dev/null
    fi

    # Create a .desktop entry for Cursor
    echo "Creating .desktop entry for Cursor..."
    sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=Cursor AI IDE
Comment=AI-powered code editor
Exec=$APPIMAGE_PATH --no-sandbox %F
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Development;IDE;TextEditor;
MimeType=text/plain;inode/directory;
StartupWMClass=Cursor
Keywords=cursor;code;editor;ide;ai;
EOL

    # Set up command line access
    echo "Setting up command line access..."
    sudo bash -c 'echo "#!/bin/bash
/opt/cursor.appimage --no-sandbox \$@" > /usr/local/bin/cursor'
    sudo chmod +x /usr/local/bin/cursor

    # Update desktop database
    if command -v update-desktop-database &> /dev/null; then
        sudo update-desktop-database
    fi

    echo "Cursor AI IDE installation complete. You can find it in your application menu or run 'cursor' in terminal."
}

uninstallCursor() {
    echo "Uninstalling Cursor AI IDE..."
    
    # Remove the AppImage
    if [ -f /opt/cursor.appimage ]; then
        sudo rm -f /opt/cursor.appimage
        echo "Removed AppImage."
    fi

    # Remove the icon
    if [ -f /opt/cursor.png ]; then
        sudo rm -f /opt/cursor.png
        echo "Removed icon."
    fi

    # Remove the desktop entry
    if [ -f /usr/share/applications/cursor.desktop ]; then
        sudo rm -f /usr/share/applications/cursor.desktop
        echo "Removed desktop entry."
    fi

    # Remove the command link
    if [ -f /usr/local/bin/cursor ]; then
        sudo rm -f /usr/local/bin/cursor
        echo "Removed command link."
    fi

    echo "Cursor AI IDE has been uninstalled."
}

# Main script execution
case "${1:-install}" in
    install)
        installCursor
        ;;
    uninstall)
        uninstallCursor
        ;;
    *)
        echo "Usage: $0 [install|uninstall]"
        echo "  install   - Install or update Cursor AI IDE (default)"
        echo "  uninstall - Remove Cursor AI IDE"
        exit 1
        ;;
esac