#!/bin/bash

# Oh-My-Git installation script
# This script installs or updates Oh-My-Git in the user's environment

set -e  # Exit on error

# Define constants
REPO_URL="https://github.com/imcodekhan/oh-my-git.git"
INSTALL_DIR="$HOME/.oh-my-git"
OH_MY_GIT_FILE="$INSTALL_DIR/oh-my-git.sh"

# Detect shell configuration files
SHELL_RC_FILES=()
if [ -f "$HOME/.bashrc" ]; then
    SHELL_RC_FILES+=("$HOME/.bashrc")
fi
if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC_FILES+=("$HOME/.zshrc")
fi

# Check Git installation
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git first."
    exit 1
fi

# Handle existing installation
if [ -d "$INSTALL_DIR" ]; then
    echo "Oh-My-Git is already installed."
    echo "Updating Oh-My-Git..."
    if cd "$INSTALL_DIR"; then
        # Fetch the default branch dynamically
        DEFAULT_BRANCH=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
        if [ -n "$DEFAULT_BRANCH" ]; then
            git pull origin "$DEFAULT_BRANCH" || { echo "Error: Failed to update Oh-My-Git."; exit 1; }
        else
            echo "Error: Unable to determine the default branch."
            exit 1
        fi
    else
        echo "Error: Failed to access the installation directory."
        exit 1
    fi
else
    # Clone repository
    echo "Cloning Oh-My-Git repository..."
    if ! git clone "$REPO_URL" "$INSTALL_DIR"; then
        echo "Error: Installation failed."
        exit 1
    fi
fi

# Make the oh-my-git.sh file executable
echo "Ensuring oh-my-git.sh is executable..."
chmod +x "$OH_MY_GIT_FILE"

# Setup shell configuration
ALIAS_LINE="alias omg='$OH_MY_GIT_FILE'"

# Add alias to shell configuration files
for SHELL_RC_FILE in "${SHELL_RC_FILES[@]}"; do
    if ! grep -qF "$ALIAS_LINE" "$SHELL_RC_FILE"; then
        echo "Adding Oh-My-Git alias to $SHELL_RC_FILE..."
        echo -e "\n# Oh-My-Git configuration" >> "$SHELL_RC_FILE"
        echo "$ALIAS_LINE" >> "$SHELL_RC_FILE"
    fi
done

# Attempt to reload shell configuration
for SHELL_RC_FILE in "${SHELL_RC_FILES[@]}"; do
    if [ -f "$SHELL_RC_FILE" ]; then
        source "$SHELL_RC_FILE" 2>/dev/null || true
    fi
done

echo "✨ Oh-My-Git is installed and up-to-date!"
echo "🔄 Please restart your terminal or run: source <your-shell-rc-file>"
