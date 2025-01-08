#!/bin/bash

# Function to display usage instructions
show_help() {
  echo "Available commands:"
  echo "  create branch <branch-name>       Create a new branch"
  echo "  switch to branch <branch-name>    Switch to an existing branch"
  echo "  list branches                     List all branches"
  echo "  delete branch <branch-name>       Delete a branch"
}

# Parse user input
case "$1 $2" in
  "create branch")
    if [ -z "$3" ]; then
      echo "Error: Branch name not provided. Usage: create branch <branch-name>"
    else
      git checkout -b "$3"
    fi
    ;;
  "switch to branch")
    if [ -z "$3" ]; then
      echo "Error: Branch name not provided. Usage: switch to branch <branch-name>"
    else
      git checkout "$3"
    fi
    ;;
  "list branches")
    git branch
    ;;
  "delete branch")
    if [ -z "$3" ]; then
      echo "Error: Branch name not provided. Usage: delete branch <branch-name>"
    else
      git branch -d "$3"
    fi
    ;;
  *)
    echo "Error: Command not recognized."
    show_help
    ;;
esac
