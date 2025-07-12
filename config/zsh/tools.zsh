# Tool initializations and completions

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi

# bashcompinit and terraform completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# zsh-syntax-highlighting
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
