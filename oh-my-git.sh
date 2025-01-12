#!/bin/bash

show_help() {
  echo "Available commands:"
  echo "  create branch <branch-name>       Create a new branch"
  echo "  switch to branch <branch-name>    Switch to an existing branch"
  echo "  list branches                     List all branches"
  echo "  delete branch <branch-name>       Delete a branch"
  echo "  uninstall                         Remove Oh-My-Git"
}

case "$1" in
  "create branch")
    if [ -z "$2" ]; then
      echo "Error: Branch name not provided"
    else
      git checkout -b "$2"
    fi
    ;;
  "switch to branch")
    if [ -z "$2" ]; then
      echo "Error: Branch name not provided"
    else
      git checkout "$2"
    fi
    ;;
  "list branches")
    git branch
    ;;
  "delete branch")
    if [ -z "$2" ]; then
      echo "Error: Branch name not provided"
    else
      git branch -d "$2"
    fi
    ;;
  "uninstall")
    rm -rf "$HOME/.oh-my-git"
    for RC_FILE in "$HOME/.bashrc" "$HOME/.zshrc"; do
      [ -f "$RC_FILE" ] && sed -i '/# Oh-My-Git configuration/d;/alias omg=/d' "$RC_FILE"
    done
    echo "✨ Oh-My-Git uninstalled"
    echo "🔄 Please restart terminal"
    ;;
  *)
    show_help
    ;;
esac