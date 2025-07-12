# Dotfiles Makefile
# Usage: $(call command_exists,<command_name>)
command_exists = type "$(1)" >/dev/null 2>&1

DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)

# Declare phony targets
.PHONY: help link unlink brew brew-install brew-uninstall macos-defaults clean all vscode-link vscode-unlink

# Default target
all: brew-install link vscode-link

# Show available targets
help:
	@echo "Available targets:"
	@echo "  all           - Install Homebrew packages and create symlinks"
	@echo "  link          - Create symlinks for dotfiles"
	@echo "  unlink        - Remove symlinks and restore backups"
	@echo "  vscode-link   - Create symlinks for VSCode settings"
	@echo "  vscode-unlink - Remove VSCode symlinks and restore backups"
	@echo "  brew          - Ensure Homebrew is installed"
	@echo "  brew-install  - Install packages from Brewfile"
	@echo "  brew-uninstall- Remove packages from Brewfile"
	@echo "  macos-defaults- Apply macOS system preferences"
	@echo "  clean         - Clean up temporary files"
	@echo "  help          - Show this help message"


link: brew-install
	@echo "Creating symlinks for dotfiles..."
	mkdir -p "$(XDG_CONFIG_HOME)"
	stow -t "$(XDG_CONFIG_HOME)" config
	mkdir -p $(HOME)/.local/runtime
	chmod 700 $(HOME)/.local/runtime
	@echo "✅ Symlinks created successfully!"

unlink:
	@echo "Removing symlinks..."
	stow --delete -t "$(XDG_CONFIG_HOME)" config
	@if [ -d "$(DOTFILES_DIR)/rc" ]; then \
		for FILE in $$(ls -A $(DOTFILES_DIR)/rc 2>/dev/null || true); do \
			if [ -f $(HOME)/$$FILE.bak ]; then \
				echo "Restoring backup: $$FILE"; \
				mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; \
			fi; \
		done; \
	fi
	@echo "✅ Symlinks removed successfully!"

# VSCode configuration management
vscode-link:
	@echo "Creating symlinks for VSCode settings..."
	@mkdir -p "$(HOME)/Library/Application Support/Code/User"
	@if [ -f "$(DOTFILES_DIR)/vscode/settings.json" ]; then \
		if [ -f "$(HOME)/Library/Application Support/Code/User/settings.json" ] && [ ! -L "$(HOME)/Library/Application Support/Code/User/settings.json" ]; then \
			echo "Backing up existing VSCode settings..."; \
			mv "$(HOME)/Library/Application Support/Code/User/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json.bak"; \
		fi; \
		ln -sf "$(DOTFILES_DIR)/vscode/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json"; \
		echo "✅ VSCode settings.json linked"; \
	else \
		echo "⚠️  VSCode settings.json not found in $(DOTFILES_DIR)/vscode/"; \
	fi
	@if [ -f "$(DOTFILES_DIR)/vscode/keybindings.json" ]; then \
		if [ -f "$(HOME)/Library/Application Support/Code/User/keybindings.json" ] && [ ! -L "$(HOME)/Library/Application Support/Code/User/keybindings.json" ]; then \
			echo "Backing up existing VSCode keybindings..."; \
			mv "$(HOME)/Library/Application Support/Code/User/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json.bak"; \
		fi; \
		ln -sf "$(DOTFILES_DIR)/vscode/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json"; \
		echo "✅ VSCode keybindings.json linked"; \
	else \
		echo "⚠️  VSCode keybindings.json not found in $(DOTFILES_DIR)/vscode/"; \
	fi
	@echo "✅ VSCode configuration linked successfully!"

vscode-unlink:
	@echo "Removing VSCode symlinks..."
	@if [ -L "$(HOME)/Library/Application Support/Code/User/settings.json" ]; then \
		rm "$(HOME)/Library/Application Support/Code/User/settings.json"; \
		echo "Removed VSCode settings.json symlink"; \
	fi
	@if [ -f "$(HOME)/Library/Application Support/Code/User/settings.json.bak" ]; then \
		mv "$(HOME)/Library/Application Support/Code/User/settings.json.bak" "$(HOME)/Library/Application Support/Code/User/settings.json"; \
		echo "Restored VSCode settings.json backup"; \
	fi
	@if [ -L "$(HOME)/Library/Application Support/Code/User/keybindings.json" ]; then \
		rm "$(HOME)/Library/Application Support/Code/User/keybindings.json"; \
		echo "Removed VSCode keybindings.json symlink"; \
	fi
	@if [ -f "$(HOME)/Library/Application Support/Code/User/keybindings.json.bak" ]; then \
		mv "$(HOME)/Library/Application Support/Code/User/keybindings.json.bak" "$(HOME)/Library/Application Support/Code/User/keybindings.json"; \
		echo "Restored VSCode keybindings.json backup"; \
	fi
	@echo "✅ VSCode symlinks removed successfully!"

brew:
	@echo "Checking Homebrew installation..."
	@$(call command_exists,brew) || { echo "Installing Homebrew..."; ./install.sh; }
	@echo "✅ Homebrew is ready!"

brew-install: brew
	@echo "Installing packages from Brewfile..."
	brew bundle --file=$(DOTFILES_DIR)/Brewfile || true
	@echo "✅ Homebrew packages installed!"

brew-uninstall: brew
	@echo "Removing packages from Brewfile..."
	brew bundle --file=$(DOTFILES_DIR)/Brewfile cleanup --global --force
	@echo "✅ Homebrew packages removed!"

# Apply macOS system preferences
macos-defaults:
	@echo "Applying macOS system preferences..."
	@if [ -f "$(DOTFILES_DIR)/macos/defaults.sh" ]; then \
		chmod +x $(DOTFILES_DIR)/macos/defaults.sh && \
		$(DOTFILES_DIR)/macos/defaults.sh; \
	else \
		echo "⚠️  macOS defaults script not found"; \
	fi
	@if [ -f "$(DOTFILES_DIR)/macos/dock.sh" ]; then \
		chmod +x $(DOTFILES_DIR)/macos/dock.sh && \
		$(DOTFILES_DIR)/macos/dock.sh; \
	else \
		echo "⚠️  macOS dock script not found"; \
	fi
	@echo "✅ macOS preferences applied!"

# Clean up temporary files
clean:
	@echo "Cleaning up temporary files..."
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@find . -name "*.log" -delete 2>/dev/null || true
	@echo "✅ Cleanup complete!"