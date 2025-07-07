# Usage: $(call command_exists,<command_name>)
command_exists = type "$(1)" >/dev/null 2>&1

DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)

link: brew
	mkdir -p "$(XDG_CONFIG_HOME)"
	stow -t "$(XDG_CONFIG_HOME)" config
	mkdir -p $(HOME)/.local/runtime
	chmod 700 $(HOME)/.local/runtime

unlink: brew
	stow --delete -t "$(HOME)" runcom
	stow --delete -t "$(XDG_CONFIG_HOME)" config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	@$(call command_exists,brew) || ./install.sh

brew-install: brew
	brew bundle --file=$(DOTFILES_DIR)/Brewfile || true

brew-uninstall: brew
	brew bundle --file=$(DOTFILES_DIR)/Brewfile cleanup --global --force