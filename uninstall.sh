#!/bin/bash

set -e

INSTALL_DIR="$HOME/.oh-my-git"
SHELL_RC_FILES=()
[ -f "$HOME/.bashrc" ] && SHELL_RC_FILES+=("$HOME/.bashrc")
[ -f "$HOME/.zshrc" ] && SHELL_RC_FILES+=("$HOME/.zshrc")

# Remove directory
[ -d "$INSTALL_DIR" ] && rm -rf "$INSTALL_DIR"

# Remove config lines
for RC_FILE in "${SHELL_RC_FILES[@]}"; do
    sed -i '/# Oh-My-Git configuration/d' "$RC_FILE"
    sed -i '/alias omg=/d' "$RC_FILE"
done

echo "✨ Oh-My-Git uninstalled successfully"
echo "🔄 Please restart your terminal"