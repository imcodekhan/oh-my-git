#!/bin/bash

# Oh-My-Git installation script
# This script installs Oh-My-Git in the user's environment

# Define the repository URL and the installation directory
REPO_URL="https://github.com/imcodekhan/oh-my-git.git"
INSTALL_DIR="$HOME/.oh-my-git"

# Function to detect shell configuration file
get_shell_rc_file() {
  if [ -n "$ZSH_VERSION" ]; then
    echo "$HOME/.zshrc"
  else
    echo "$HOME/.bashrc"
  fi
}

# Check if Git is installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

# Clone the repository into the installation directory
echo "Cloning Oh-My-Git repository from $REPO_URL..."
git clone "$REPO_URL" "$INSTALL_DIR"

# Check if cloning was successful
if [ $? -eq 0 ]; then
    echo "Installation successful."
else
    echo "Installation failed."
    exit 1
fi

# Detect shell configuration file
SHELL_RC_FILE=$(get_shell_rc_file)

# Check if Oh-My-Git is already sourced
if grep -q "source $INSTALL_DIR/oh-my-git.sh" "$SHELL_RC_FILE"; then
    echo "Oh-My-Git is already sourced in your $SHELL_RC_FILE."
else
    # Add source command to shell config file
    echo "Adding Oh-My-Git setup to $SHELL_RC_FILE..."
    echo "source $INSTALL_DIR/oh-my-git.sh" >> "$SHELL_RC_FILE"
fi

# Check if alias is already set
if grep -q "alias omg='oh-my-git'" "$SHELL_RC_FILE"; then
    echo "Alias 'omg' is already set in your $SHELL_RC_FILE."
else
    # Add alias for omg
    echo "Adding alias 'omg' to $SHELL_RC_FILE..."
    echo "alias omg='oh-my-git'" >> "$SHELL_RC_FILE"
fi

# Reload shell configuration
echo "Reloading your shell configuration..."
source "$SHELL_RC_FILE"

echo "Oh-My-Git has been installed successfully!"
echo "You may need to restart your terminal for all changes to take effect."
