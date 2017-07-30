# Path to your oh-my-zsh installation.
export ZSH=/Users/Scott/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
autoload -Uz promptinit
promptinit
ZSH_THEME="avit"

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
plugins=(
git
composer
brew
npm
laravel
colorize
command-not-found
cp
web-search
colored-man-pages
themes
# vi-mode
history-substring-search
)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin"
export PATH="$PATH:~/.composer/vendor/bin"
export PATH="$PATH:/Users/Scott/Code/spark-installer"
export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

source $ZSH/oh-my-zsh.sh
if [[ -n !${INSIDE_EMACS} ]]; then
  # source ~/.iterm2_shell_integration.`basename $SHELL`
fi

# bind UP and DOWN arrow keys
bindkey -M vicmd 'K' history-substring-search-up
bindkey -M vicmd 'J' history-substring-search-down

bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind k and j for VI mode
bindkey kj vi-cmd-mode
bindkey jk vi-cmd-mode
bindkey '^l' vi-cmd-mode

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# else
#     export EDITOR='nvim'
# fi

if [[ -n ${INSIDE_EMACS} ]]; then
  # This shell runs inside an Emacs *shell*/*term* buffer.
  prompt off
fi

export EDITOR="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c"

# aliases
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias rmsw="rm ~/.vim/swaps/*"

alias cl="clear"

alias git="hub"

alias gpr="hub pull-request"
alias gbr="hub browse"
alias gbroom="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"

alias pu="phpunit"
alias pud="phpunit --group default"
alias puf="phpunit --stop-on-failure"

alias sql="mysql.server start"
alias sqlu="mysql -u root"

alias chrome="open -a 'Google Chrome'"

alias sz="source ~/.zshrc"
alias zrc="vim ~/.zshrc"
alias vrc="vim ~/.vimrc"
alias hrc="vim ~/.hyper.js"
alias kb="vim ~/.config/karabiner/karabiner.json"

alias lint="npm run lint"
alias dev="npm run dev"
alias hot="npm run hot"

alias rms="php artisan migrate:refresh --seed"
alias pa="php artisan"
alias cdo="composer dump-autoload"

alias qc="quasar build && cd cordova && cordova run ios"

alias dc="docker-compose"
alias dcz="docker-compose down && docker-compose up -d && subzero_devtools"
#
# put in iterm. sends ctrlc tl enter: 0x03 0x74 0x6c 0xd
# alias tl="valet log"
alias tl="tail -fn 0 storage/logs/laravel.log"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -n !${INSIDE_EMACS} ]]; then
  # test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi
