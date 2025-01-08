#!/bin/bash

# Function to handle errors
error() {
  echo "Error: $1"
  exit 1
}

# Function to execute Git commands
git_command() {
  git "$@" || error "Git command failed: git $@"
}

# Create a new branch
create_branch() {
  if [ -z "$1" ]; then
    error "Branch name is required"
  fi
  git_command checkout -b "$1"
}

# Switch to an existing branch
switch_branch() {
  if [ -z "$1" ]; then
    error "Branch name is required"
  fi
  git_command checkout "$1"
}

# List all local branches
list_branches() {
  git_command branch
}

# Delete a branch
delete_branch() {
  if [ -z "$1" ]; then
    error "Branch name is required"
  fi
  git_command branch -d "$1"
}

# Show status of the current repository
status() {
  git_command status
}

# Add all changes
add_all() {
  git_command add .
}

# Commit changes with a message
commit() {
  if [ -z "$1" ]; then
    error "Commit message is required"
  fi
  git_command commit -m "$1"
}

# Push changes to the remote repository
push() {
  git_command push
}

# Pull changes from the remote repository
pull() {
  git_command pull
}

# Show the current remote repository URL
remote_url() {
  git_command remote get-url origin
}

# Initialize a new Git repository
init_repo() {
  git_command init
}

# Clone a repository
clone_repo() {
  if [ -z "$1" ]; then
    error "Repository URL is required"
  fi
  git_command clone "$1"
}

# Show the Git log
log() {
  git_command log --oneline --graph --decorate --all
}

# Show the diff of changes
diff() {
  git_command diff
}

# Stash your changes
stash() {
  git_command stash
}

# Apply stashed changes
apply_stash() {
  git_command stash apply
}

# Check the Git version
version() {
  git_command --version
}

# Main function to route the command to the correct function
main() {
  case "$1" in
    "create branch")
      create_branch "$2"
      ;;
    "switch to branch")
      switch_branch "$2"
      ;;
    "list branches")
      list_branches
      ;;
    "delete branch")
      delete_branch "$2"
      ;;
    "status")
      status
      ;;
    "add all")
      add_all
      ;;
    "commit")
      commit "$2"
      ;;
    "push")
      push
      ;;
    "pull")
      pull
      ;;
    "remote url")
      remote_url
      ;;
    "init")
      init_repo
      ;;
    "clone")
      clone_repo "$2"
      ;;
    "log")
      log
      ;;
    "diff")
      diff
      ;;
    "stash")
      stash
      ;;
    "apply stash")
      apply_stash
      ;;
    "version")
      version
      ;;
    *)
      error "Unknown command: $1"
      ;;
  esac
}

# Run the main function with the arguments passed to the script
main "$@"
