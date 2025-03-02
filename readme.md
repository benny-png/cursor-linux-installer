# Cursor AI IDE Installation Guide for Linux

This guide walks you through installing, uninstalling, and setting up Cursor AI IDE on Linux systems.

## What is Cursor AI IDE?

Cursor is an AI-powered code editor built on top of VSCode, integrating powerful AI features to help you code faster and more efficiently. It offers:

- AI-powered code completion
- Chat interface for coding assistance
- Code explanation and documentation generation
- Automatic bug fixing
- Smart code refactoring

## System Requirements

- Linux distribution (Ubuntu, Fedora, Arch, openSUSE, etc.)
- x86_64 architecture
- At least 4GB RAM (8GB+ recommended)
- 1GB free disk space
- Internet connection for AI features

## Installation

1. Download the installation script:
   ```bash
   curl -O https://raw.githubusercontent.com/benny-png/cursor-linux-installer/master/install_cursor.sh
   ```

2. Make the script executable:
   ```bash
   chmod +x ./install_cursor.sh
   ```

3. Run the script:
   ```bash
   ./install_cursor.sh
   ```

## Using the Installation Script

The installation script supports the following commands:

```bash
# Install or update Cursor
./install_cursor.sh install

# Uninstall Cursor
./install_cursor.sh uninstall
```

## Setting Up Command Line Access

The installation script automatically sets up command line access. You can launch Cursor from any terminal by typing:

```bash
cursor
```

To open a specific file or directory:

```bash
cursor /path/to/file-or-directory
```

> **Note**: The `--no-sandbox` flag is included automatically to avoid permission issues on many Linux distributions.

## Uninstallation

To uninstall Cursor:

```bash
./install_cursor.sh uninstall
```

## Troubleshooting

### Sandbox Error

If you see an error like:
```
The SUID sandbox helper binary was found, but is not configured correctly.
```

Make sure you're using the `--no-sandbox` flag when launching Cursor. The command line script created by the installer includes this flag automatically.

### AppImage Permissions

If you get a permission error when running Cursor:

```bash
sudo chmod +x /opt/cursor.appimage
```

### Cursor Command Not Found

If the `cursor` command isn't recognized:
1. Make sure you've created the command line script as described above
2. Check if `/usr/local/bin` is in your PATH:
```bash
echo $PATH
```
3. If not, add it:
```bash
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc
```

### Graphics Issues

If you experience graphics issues:
1. Try running with software rendering:
```bash
cursor --disable-gpu
```
2. Or update your graphics drivers

## Updates

The installation script always downloads the latest version available from Cursor's servers. To update your existing installation:

```bash
./install_cursor.sh install
```

## Getting Started with Cursor

After installation, you can:

1. Launch Cursor from your application menu or by typing `cursor` in the terminal
2. Sign in with your Cursor account (or create one)
3. Connect your preferred AI model API keys in settings
4. Explore the AI features like code completion, chat, and code explanation

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Open AI Chat | Ctrl+Shift+L |
| Generate Code | Ctrl+L |
| Explain Code | Ctrl+Shift+E |
| Fix Issues | Ctrl+Shift+F |
| AI Settings | Ctrl+, (then navigate to AI) |

## Additional Resources

- [Official Cursor Documentation](https://cursor.sh/docs)
- [Cursor GitHub Repository](https://github.com/getcursor/cursor)
- [Cursor Discord Community](https://discord.gg/cursor)

## License

This installation script is provided under the MIT License. Cursor AI IDE has its own licensing terms.

## Contributing

Contributions to improve this installer are welcome! Please submit a pull request or open an issue on the GitHub repository.

### Manual Installation

If you prefer to install manually:

1. Download the Cursor AppImage:
   ```bash
   sudo curl -L https://downloader.cursor.sh/linux/appImage/x64 -o /opt/cursor.appimage
   sudo chmod +x /opt/cursor.appimage
   ```

2. Download an icon:
   ```bash
   sudo curl -L https://raw.githubusercontent.com/benny-png/cursor-linux-installer/master/cursor.png -o /opt/cursor.png
   ```

3. Create a desktop entry:
   ```bash
   sudo bash -c 'cat > /usr/share/applications/cursor.desktop << EOL
   [Desktop Entry]
   Name=Cursor AI IDE
   Comment=AI-powered code editor
   Exec=/opt/cursor.appimage --no-sandbox %F
   Icon=/opt/cursor.png
   Terminal=false
   Type=Application
   Categories=Development;IDE;TextEditor;
   MimeType=text/plain;inode/directory;
   StartupWMClass=Cursor
   Keywords=cursor;code;editor;ide;ai;
   EOL'
   ```

4. Set up command line access:
   ```bash
   sudo bash -c 'echo "#!/bin/bash
   /opt/cursor.appimage --no-sandbox \$@" > /usr/local/bin/cursor'
   sudo chmod +x /usr/local/bin/cursor
   ```