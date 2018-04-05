# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="imajes"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# User configuration

export PATH="$PATH:/usr/local/opt/php@7.1/bin:/usr/local/opt/php@7.1/sbin"
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"
export PATH="$PATH:~/.composer/vendor/bin"
export PATH="$PATH:/Users/Scott/Code/spark-installer"
export PATH="$PATH:/usr/local/opt/ncurses/bin:$PATH"
export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

if [[ -n ${INSIDE_EMACS} ]]; then
# This shell runs inside an Emacs *shell*/*term* buffer.
plugins=(
git
colored-man-pages
history-substring-search
)

export EDITOR="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c"
else
plugins=(
composer
git
vi-mode
colored-man-pages
history-substring-search
)

# source ~/.iterm2_shell_integration.`basename $SHELL`
#
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
else
export EDITOR='nvim'
fi

fi

source $ZSH/oh-my-zsh.sh

# bind UP and DOWN arrow keys
bindkey -M vicmd 'K' history-substring-search-up
bindkey -M vicmd 'J' history-substring-search-down

bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#bind k and j for VI mode
#bindkey kj vi-cmd-mode
#bindkey jk vi-cmd-mode
#bindkey '^l' vi-cmd-mode

# aliases
#alias ctags="`brew --prefix`/bin/ctags"
alias pip="pip3"
#alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias rmsw="rm ~/.vim/swaps/*"

alias cl="clear"

#alias git="hub"

alias gpr="hub pull-request"
alias gbr="hub browse"
alias gbroom="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"

original_phpunit=$(which phpunit)

phpunit() {
if [ -f vendor/bin/phpunit ]; then vendor/bin/phpunit $@
else eval "'$original_phpunit' $@"
fi
}

alias pu="phpunit"
alias pud="phpunit --group default"
alias puf="phpunit --stop-on-failure"

alias sql="mysql.server start"
alias sqlu="mysql -u root"
alias tdbr="mysql -u root -e 'drop database test; create database test;'"

alias chrome="open -a 'Google Chrome'"
alias vlc="open -a 'VLC'"

alias sz="source ~/.zshrc"
alias zrc="nvim ~/.zshrc"
alias vrc="nvim ~/.vimrc"
alias hrc="nvim ~/.hyper.js"
alias kb="nvim ~/.config/karabiner/karabiner.json"

alias lint="npm run lint"
alias dev="npm run dev"
alias hot="npm run hot"

alias rms="php artisan migrate:refresh --seed"
alias pa="php artisan"
alias cdo="composer dump-autoload"

alias qc="quasar build && cd cordova && cordova run ios"

alias dc="docker-compose"
alias dcz="docker-compose down && docker-compose up -d && subzero_devtools"

# chunkwm commands
alias rch="sh ~/.chunkwmrc"
alias qd="chunkc tiling::query --desktop id"
alias qm="chunkc tiling::query --monitor id"

# teensy loader cli
alias teensy="teensy_loader_cli"

# aws completions
# source /usr/local/bin/aws_zsh_completer.sh

# put in iterm. sends ctrlc tl enter: 0x03 0x74 0x6c 0xd
# alias tl="valet log"
alias tl="tail -fn 0 storage/logs/laravel.log"

alias rm-pgpid="rm ~/Library/Application\ Support/Postgres/var-9.6/postmaster.pid"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -n !${INSIDE_EMACS} ]]; then
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# if [ $TERM_PROGRAM == "iTerm.app" ]; then
# source ~/.iterm2_shell_integration.`basename $SHELL`
# fi

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_}
'
alias | sed 's/^alias //' | sed -E "s/^([^=]+)='(.+?)'$/\1=\2/" | sed "s/'\\\\''/'/g" | sed "s/'\\\\$/'/;" | sed -E 's/^([^=]+)=(.+)$/alias \1 \2/' >~/.emacs.d/eshell/alias

# for accessing last output without rerunning command
# does not work yet
#bindkey -s "\n" " | tee ~/.last_zsh_output\n"

# STARTUP
# if [ $NVIM_STARTED ]; then
# nvim -u ~/vterm.rc
# NVIM_STARTED= true
# fi
