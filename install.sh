#!/bin/bash

# Oh-My-Git installation script
# This script installs Oh-My-Git in the user's environment

set -e  # Exit on error

# Define constants
REPO_URL="https://github.com/imcodekhan/oh-my-git.git"
INSTALL_DIR="$HOME/.oh-my-git"

# Detect shell configuration file
get_shell_rc_file() {
    if [ -n "$ZSH_VERSION" ]; then
        echo "$HOME/.zshrc"
    else
        echo "$HOME/.bashrc"
    fi
}

# Check Git installation
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git first."
    exit 1
fi

# Remove existing installation if present
if [ -d "$INSTALL_DIR" ]; then
    echo "Removing existing installation..."
    rm -rf "$INSTALL_DIR"
fi

# Clone repository
echo "Cloning Oh-My-Git repository..."
if ! git clone "$REPO_URL" "$INSTALL_DIR"; then
    echo "Error: Installation failed"
    exit 1
fi

# Setup shell configuration
SHELL_RC_FILE=$(get_shell_rc_file)
SOURCE_LINE="source $INSTALL_DIR/oh-my-git.sh"
ALIAS_LINE="alias omg='oh-my-git'"

# Add source command if not present
if ! grep -q "$SOURCE_LINE" "$SHELL_RC_FILE"; then
    echo "Adding Oh-My-Git to $SHELL_RC_FILE..."
    echo -e "\n# Oh-My-Git configuration" >> "$SHELL_RC_FILE"
    echo "$SOURCE_LINE" >> "$SHELL_RC_FILE"
fi

# Add alias if not present
if ! grep -q "$ALIAS_LINE" "$SHELL_RC_FILE"; then
    echo "Adding alias 'omg'..."
    echo "$ALIAS_LINE" >> "$SHELL_RC_FILE"
fi

# Attempt to reload shell configuration
if [ -f "$SHELL_RC_FILE" ]; then
    source "$SHELL_RC_FILE" 2>/dev/null || true
fi

echo "✨ Oh-My-Git installed successfully!"
echo "🔄 Please restart your terminal or run: source $SHELL_RC_FILE"