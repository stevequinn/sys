# ── Environment ──
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERM="xterm-256color"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PATH=$HOME/bin:/usr/local/bin:$HOME/dev/sdk/flutter/bin:$HOME/.opencode/bin:$PATH

# ── Zsh Options ──
setopt AUTO_CD HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# ── Completion (cached) ──
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# ── Vim Mode ──
bindkey -v

# ── Plugins (manual, no framework) ──
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# must be last plugin
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ── Aliases ──
alias ll='ls -l'
alias la='ls -al'
alias phantomjs='~/dev/phantomjs_src/bin/phantomjs'
alias gitlog='git log --pretty=format:"%h - %an, %ar : %s"'
alias weather='curl -Acurl https://wttr.in/Kiama+NSW'
alias temperature='curl -Acurl https://wttr.in/Kiama+NSW?format=3'
alias light='~/dev/sys/light.py'
alias tunnel='ngrok'
alias speedtest='networkQuality -v'
alias py='python -m pdb -c c'
alias starter='sh ~/dev/0starters/starter.sh'
alias piface='~/dev/apps/piface/.venv/bin/python ~/dev/apps/piface'
alias fujisim='exiftool -FilmMode -a -G1 -s'
alias ron="curl -s http://ron-swanson-quotes.herokuapp.com/v2/quotes | sed -e 's/\"//g;s/\]//g;s/\[//g' | { cat; echo \"\n-Ron Swanson\"; }"

# ── Functions ──
ccat() {
  pygmentize -g "$@"
}

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

timer() {
  local total=$1
  for ((i=total; i>0; i--)); do sleep 1; printf "Time remaining $i secs \r"; done
}

ask() {
  local base="$HOME/dev/apps/rag-agents/getsmart"
  if [ -p /dev/stdin ]; then
    PYTHONPATH="$base/getsmart/" "$base/.venv/bin/python" "$base/getsmart/apps/ask.py" "$(cat)" \
      | bat --language=markdown --style plain --theme Dracula
  else
    PYTHONPATH="$base/getsmart/" "$base/.venv/bin/python" "$base/getsmart/apps/ask.py" "$@" \
      | bat --language=markdown --style plain --theme Dracula
  fi
}

tree() { find "${1:-.}" -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'; }

# ── Tools ──

# NVM (lazy-loaded for fast startup)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unfunction nvm
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Rust/Cargo env
. "$HOME/.local/bin/env"

# gcloud (lazy-loaded)
gcloud() {
  unfunction gcloud
  if [ -f '/Users/steveq/dev/google-cloud-sdk/path.zsh.inc' ]; then
    . '/Users/steveq/dev/google-cloud-sdk/path.zsh.inc'
    . '/Users/steveq/dev/google-cloud-sdk/completion.zsh.inc'
  fi
  gcloud "$@"
}

# pyenv (lazy-loaded)
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}

# ── Starship Prompt (must be last) ──
eval "$(starship init zsh)"
