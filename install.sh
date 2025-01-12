#!/bin/bash

set -e

# Progress indicator
progress() {
    echo "➜ $1"
}

# Cleanup on failure
cleanup() {
    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
    fi
    echo "Installation failed. Cleaned up temporary files."
    exit 1
}

trap cleanup ERR

# Constants
REPO_URL="https://github.com/imcodekhan/oh-my-git.git"
INSTALL_DIR="$HOME/.oh-my-git"
OH_MY_GIT_FILE="$INSTALL_DIR/oh-my-git.sh"

# Detect shell config
SHELL_RC_FILES=()
[ -f "$HOME/.bashrc" ] && SHELL_RC_FILES+=("$HOME/.bashrc")
[ -f "$HOME/.zshrc" ] && SHELL_RC_FILES+=("$HOME/.zshrc")

# Check Git
command -v git &> /dev/null || { echo "Error: Git required"; exit 1; }

# Handle installation
if [ -d "$INSTALL_DIR" ]; then
    progress "Updating Oh-My-Git"
    cd "$INSTALL_DIR" && git pull origin master
else
    progress "Installing Oh-My-Git"
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Setup
progress "Configuring"
chmod +x "$OH_MY_GIT_FILE"

# Add alias
ALIAS_LINE="alias omg='$OH_MY_GIT_FILE'"
for RC_FILE in "${SHELL_RC_FILES[@]}"; do
    if ! grep -qF "$ALIAS_LINE" "$RC_FILE"; then
        echo -e "\n# Oh-My-Git configuration\n$ALIAS_LINE" >> "$RC_FILE"
    fi
done

# Reload config
for RC_FILE in "${SHELL_RC_FILES[@]}"; do
    source "$RC_FILE" 2>/dev/null || true
done

progress "Installation complete! ✨"
[ -n "${SHELL_RC_FILES[0]}" ] && echo "🔄 Restart terminal or run: source ${SHELL_RC_FILES[0]}"