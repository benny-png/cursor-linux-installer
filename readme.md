I’ll update your README to reflect the latest changes, including the ability to specify a custom URL as an argument for the `install_cursor.sh` script, while keeping your initial dynamic URL (`https://downloader.cursor.sh/linux/appImage/x64`) as the default. I’ll also ensure the documentation aligns with the script’s current functionality, including the retry logic, sandbox fixes, and troubleshooting tips.

Here’s the revised `README.md`:

---

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

### Quick Installation

1. Download the installation script:
   ```bash
   curl -O https://raw.githubusercontent.com/benny-png/cursor-linux-installer/main/install_cursor.sh
   ```

2. Make the script executable:
   ```bash
   chmod +x ./install_cursor.sh
   ```

3. Run the script with the default URL (latest version from `https://downloader.cursor.sh/linux/appImage/x64`):
   ```bash
   ./install_cursor.sh
   ```
   or
   ```bash
   ./install_cursor.sh install
   ```

   **Optional**: Specify a custom AppImage URL for flexibility:
   ```bash
   ./install_cursor.sh install https://downloads.cursor.com/production/client/linux/x64/appimage/Cursor-0.47.8-82ef0f61c01d079d1b7e5ab04d88499d5af500e3.deb.glibc2.25-x86_64.AppImage
   ```

### Manual Installation

If you prefer to install manually:

1. Download the Cursor AppImage:
   ```bash
   sudo curl -L https://downloader.cursor.sh/linux/appImage/x64 -o /opt/cursor.appimage
   sudo chmod +x /opt/cursor.appimage
   ```

2. Download an icon:
   ```bash
   sudo curl -L https://raw.githubusercontent.com/rahuljangirwork/copmany-logos/refs/heads/main/cursor.png -o /opt/cursor.png
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

## Using the Installation Script

The installation script supports the following commands:

```bash
# Install or update Cursor with the default URL
./install_cursor.sh install

# Install or update Cursor with a custom URL
./install_cursor.sh install <custom_appimage_url>

# Uninstall Cursor
./install_cursor.sh uninstall
```

- The default URL (`https://downloader.cursor.sh/linux/appImage/x64`) fetches the latest available AppImage. You can override it by providing a custom URL as an argument (e.g., a specific version like `https://downloads.cursor.com/...`).
- The script includes retry logic (up to 3 attempts) and automatically fixes sandbox permissions if needed.

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

Or manually:

```bash
# Remove the AppImage
sudo rm -f /opt/cursor.appimage

# Remove the icon
sudo rm -f /opt/cursor.png

# Remove the desktop entry
sudo rm -f /usr/share/applications/cursor.desktop

# Remove the command link
sudo rm -f /usr/local/bin/cursor
```

## Troubleshooting

### Sandbox Error

If you see an error like:
```
The SUID sandbox helper binary was found, but is not configured correctly.
```
The script automatically attempts to fix this by setting the correct permissions on `chrome-sandbox`. If the issue persists, ensure you're using the `--no-sandbox` flag (included by default).

### AppImage Permissions

If you get a permission error when running Cursor:

```bash
sudo chmod +x /opt/cursor.appimage
```

### Cursor Command Not Found

If the `cursor` command isn't recognized:
1. Make sure you've created the command line script as described above.
2. Check if `/usr/local/bin` is in your PATH:
   ```bash
   echo $PATH
   ```
3. If not, add it:
   ```bash
   echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
   source ~/.bashrc
   ```

### Access Denied Error

If the script fails with an `AccessDenied` error (e.g., XML response with `<Code>AccessDenied</Code>`):
- Try a specific URL as an argument (e.g., a known working version).
- Check your internet connection or disable any VPN/proxy.
- Contact Cursor support with the `<RequestId>` from the error message.

### Graphics Issues

If you experience graphics issues:
1. Try running with software rendering:
   ```bash
   cursor --disable-gpu
   ```
2. Or update your graphics drivers.

## Updates

The installation script attempts to download the latest version from the default URL (`https://downloader.cursor.sh/linux/appImage/x64`). To update your existing installation:

```bash
./install_cursor.sh install
```

For a specific version, provide the URL:
```bash
./install_cursor.sh install https://downloads.cursor.com/production/client/linux/x64/appimage/Cursor-0.47.8-...
```

## Getting Started with Cursor

After installation, you can:

1. Launch Cursor from your application menu or by typing `cursor` in the terminal.
2. Sign in with your Cursor account (or create one).
3. Connect your preferred AI model API keys in settings.
4. Explore the AI features like code completion, chat, and code explanation.

## Keyboard Shortcuts

| Action            | Shortcut         |
|-------------------|------------------|
| Open AI Chat      | Ctrl+Shift+L     |
| Generate Code     | Ctrl+L           |
| Explain Code      | Ctrl+Shift+E     |
| Fix Issues        | Ctrl+Shift+F     |
| AI Settings       | Ctrl+, (then navigate to AI) |

## Additional Resources

- [Official Cursor Documentation](https://cursor.sh/docs)
- [Cursor GitHub Repository](https://github.com/getcursor/cursor)
- [Cursor Discord Community](https://discord.gg/cursor)

## License

This installation script is provided under the MIT License. Cursor AI IDE has its own licensing terms.

## Contributing

Contributions to improve this installer are welcome! Please submit a pull request or open an issue on the GitHub repository.

---

### Key Changes

1. **Custom URL in Quick Installation**:
   - Added an optional step to specify a custom URL in the "Quick Installation" section, reflecting the script’s new argument feature.

2. **Updated Script Usage**:
   - Revised the "Using the Installation Script" section to include the `install <custom_url>` syntax and mention the default URL and retry logic.

3. **Troubleshooting Enhancements**:
   - Added a new "Access Denied Error" section to address the XML error you encountered, with suggestions to use a custom URL or contact support.

4. **Updates Section**:
   - Clarified that the default URL is used, with an option to specify a custom URL for specific versions.

