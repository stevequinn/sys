# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/dev/sdk/flutter/bin:$PATH
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(pyenv init -)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dieter"

export EDITOR=nvim
export VISUAL="$EDITOR"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	brew
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias phantomjs='~/dev/phantomjs_src/bin/phantomjs'
alias gitlog='git log --pretty=format:"%h - %an, %ar : %s"'
alias weather='curl -Acurl https://wttr.in/Australia+Victoria+Hawthorn'
alias temperature='curl -Acurl https://wttr.in/Australia+Victoria+Hawthorn\?format\=3'
alias ron="curl -s http://ron-swanson-quotes.herokuapp.com/v2/quotes | sed -e 's/\"//g;s/\]//g;s/\[//g' | { cat $1; echo \"\n-Ron Swanson\" }"
alias light='~/dev/sys/light.py'
alias tunnel='ngrok' # I can never remember the name of this tunnel prog, so alias.
# alias cp='rsync -ah --inplace --info=progress2'
alias speedtest='networkQuality -v'
alias py='python -m pdb -c c' # Python alias that drops into debugger if exception is thrown.
alias starter='sh ~/dev/0starters/starter.sh'
alias piface='~/dev/apps/piface/.venv/bin/python ~/dev/apps/piface'
alias fujisim='exiftool -FilmMode -a -G1 -s'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Fix SSH agent in WSL
# eval $(ssh-agent -s)
# ssh-add ~/.ssh/id_ed25519_github

#
# Custom functions
#

# Coloured cat output using pygmentize
ccat(){
    cat "$@" > /tmp/.tmp
    pygmentize -g /tmp/.tmp
    rm /tmp/.tmp
}

# Colourd man output
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# Timer - count down from n.
timer() {
  total=$1
  for ((i=total; i>0; i--)); do sleep 1; printf "Time remaining $i secs \r"; done
  # echo -e "\a" # Uncomment for term bell.
}

ask() {
  if [ -p /dev/stdin ]; then
    # Data is being piped in
   PYTHONPATH=~/dev/apps/rag-agents/getsmart/getsmart/ ~/dev/apps/rag-agents/getsmart/.venv/bin/python ~/dev/apps/rag-agents/getsmart/getsmart/apps/ask.py "$(cat)" | bat --language=markdown --style plain --theme Dracula
  else
      local question="$@"
    # Data is being passed as arguments
    PYTHONPATH=~/dev/apps/rag-agents/getsmart/getsmart/ ~/dev/apps/rag-agents/getsmart/.venv/bin/python ~/dev/apps/rag-agents/getsmart/getsmart/apps/ask.py "$question" | bat --language=markdown --style plain --theme Dracula
  fi
}

tree() { find "${1:-.}" -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'; }

# pnpm
export PNPM_HOME="/Users/steveq/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.local/bin/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/steveq/dev/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/steveq/dev/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/steveq/dev/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/steveq/dev/google-cloud-sdk/completion.zsh.inc'; fi

# opencode
export PATH=/Users/steveq/.opencode/bin:$PATH
