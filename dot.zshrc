# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dieter"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias dev='ssh -A steveq@coyote.local'
alias dev='ssh -A steveq@foghorn.local'
alias phantomjs='~/dev/phantomjs_src/bin/phantomjs'
alias gitlog='git log --pretty=format:"%h - %an, %ar : %s"'
alias weather='curl -Acurl https://wttr.in/Australia+Victoria+Hawthorn'
alias ron="curl -s http://ron-swanson-quotes.herokuapp.com/v2/quotes | sed -e 's/\"//g;s/\]//g;s/\[//g' | { cat $1; echo \"\n-Ron Swanson\" }"
alias light='~/dev/sys/light.py'
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export SVN_EDITOR=vim
# Genymotion adb
# export PATH=$PATH:/Applications/Genymotion.app/Contents/MacOS/tools
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

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

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

#
# Google Cloud Client & SDK PATH Config
#
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/steveq/dev/podcastShowNotes/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/steveq/dev/podcastShowNotes/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/steveq/dev/podcastShowNotes/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/steveq/dev/podcastShowNotes/google-cloud-sdk/completion.zsh.inc'; fi
