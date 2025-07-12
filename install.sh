#!/bin/sh
############################################################
# install.sh - Bootstrap macOS development environment
#
# Installs Xcode Command Line Tools, Homebrew, Oh My Zsh,
# and creates the development directory. For further setup
# (symlinks, Brewfile, configs), run `make` as described
# in the Makefile.
############################################################

echo "Setting up..."

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
fi

# Check homebrew is installed otherwise install it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

# Create a development working directory and subdirectories
if [ ! -d "$HOME/Code" ]; then
  echo "Creating development directory..."
  mkdir -p $HOME/Code
else
  echo "Development directory already exists."
fi

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  echo "Installing Oh My Zsh..."
  
  # Backup existing .oh-my-zsh directory if it exists
  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Backing up existing Oh My Zsh installation..."
    mv "$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh.backup.$(date +%Y%m%d_%H%M%S)"
  fi
  
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi