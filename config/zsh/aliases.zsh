# CLI Shortcuts
alias reloadcli="source $HOME/.zshrc"
alias weather="curl -4 http://wttr.in"
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias hhosts='sudo vi /etc/hosts'
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias reloadshell="omz reload"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
#alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias workspace="cd ~/Workspace"
alias work="cd ~/Workspace"
alias notebooks="cd ~/Workspace/notebooks"
alias infra="cd ~/Workspace/infrastructure-as-code"
alias interview="cd ~/Workspace/interview"
alias www="workspace && cd www"
alias api="workspace && cd api"
alias etl="workspace && cd etl"
alias tool-library="workspace && cd tool-library"
alias plugbunny="projects && cd plugbunny"
alias plugbunny-backend="plugbunny && cd backend"
alias bdrive="projects && cd bdrive/frontend"
alias bdrive-api="projects && cd bdrive/backend"
#alias ll="$(brew --prefix coreutils)/libexec/gnubin/ls -ahlF --color --group-directories-first"
#alias goland='open -a /Applications/Goland.app "`pwd`"'
alias timestamp="date +%s"
alias docker-clean-containers='docker stop $(docker container ls -a -q) && docker rm $(docker container ls -a -q)'
alias docker-clean-all='docker-clean-containers  && docker system prune -a -f --volumes'
alias docker-clean-unused='docker system prune --all --force --volumes'

alias ip='curl https://ipinfo.io/ip'
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

alias w='which'
alias ll='l -A'
alias ld='l | grep "^d"'

# Easier navigation: .., ..., ...., ....., ~ and -
alias wifion='networksetup -setairportpower en0 on'
alias wifioff='networksetup -setairportpower en0 off'
alias wifirestart='wifioff && wifion'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Directories
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dc="cd ~/Documents"
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $HOME/Code"

# Golang
alias gfresh="rm -rf go.mod go.sum && go mod init && go get -u ./..."
alias gtest="go test ./... -v"
alias gbuild="go build -o bin/$(basename $(pwd)) ."
alias grd='grhh && ggpur'
alias grun="go run ."

# Python
alias pfresh="rm -rf venv/ && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt"
alias ptest="python -m unittest discover -s tests -v"
alias prun="python -m main"
alias pbuild="python -m build --wheel --sdist"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run dev"

# Docker
alias docker-composer="docker-compose"

# SQL Server
alias mssql="docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=LaravelWow1986! -p 1433:1433 mcr.microsoft.com/mssql/server:2017-latest"

# Git - Status & Info
alias gst="git status"  # Changed from gs to avoid Ghostscript conflict
alias gb="git branch"
alias gl="git log --oneline --decorate --color"
alias glog="git log --graph --oneline --decorate --all"

# Git - Advanced Operations
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias gd="git diff"
alias force="git push --force-with-lease"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias prune="git fetch --prune"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
alias grd='grhh && ggpur'