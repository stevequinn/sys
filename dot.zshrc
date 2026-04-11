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

# ── Lazy Load Helper ──
# Usage: _lazy_load <loader_fn_name> cmd1 cmd2 ...
# Creates a stub for each cmd that runs the loader once, then re-dispatches.
# Use for loading commands on demand instead of slowing down the shell init
_lazy_load() {
  local loader="$1"; shift
  local cmds=("$@")

  # Define the one-time loader (called by any stub)
  eval "
  _run_${loader}() {
    # Remove all stubs and this loader
    for _c in ${cmds[*]}; do
      unfunction \"\$_c\" 2>/dev/null
    done
    unfunction _run_${loader} 2>/dev/null

    # Source the real tool
    ${loader}_init

    # Re-dispatch the original command
    \"\$@\"
  }
  "

  # Stamp out a stub for every managed command
  for cmd in "${cmds[@]}"; do
    eval "
    ${cmd}() {
      _run_${loader} ${cmd} \"\$@\"
    }
    "
  done
}

# ── Tools ──

# NVM (lazy-loaded for fast startup)
export NVM_DIR="$HOME/.nvm"
nvm_init() {
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}
_lazy_load nvm nvm node npm npx corepack

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Rust/Cargo env
. "$HOME/.local/bin/env"

# gcloud (lazy-loaded)
gcloud_init() {
  if [ -f '/Users/steveq/dev/google-cloud-sdk/path.zsh.inc' ]; then
    . '/Users/steveq/dev/google-cloud-sdk/path.zsh.inc'
    . '/Users/steveq/dev/google-cloud-sdk/completion.zsh.inc'
  fi
}
_lazy_load gcloud gcloud gsutil bq

# pyenv (lazy-loaded)
pyenv_init() {
  eval "$(command pyenv init -)"
}
_lazy_load pyenv pyenv python python3 pip pip3

# ── Python venv auto-activation ──
_venv_auto() {
  local venv_dir=""
  local search="$PWD"

  while [[ "$search" != "/" ]]; do
    for candidate in .venv venv; do
      if [[ -f "$search/$candidate/bin/activate" ]]; then
        venv_dir="$search/$candidate"
        break 2
      fi
    done
    search="${search:h}"
  done

  if [[ -n "$venv_dir" ]]; then
    if [[ "$VIRTUAL_ENV" != "$venv_dir" ]]; then
      source "$venv_dir/bin/activate"

      # Venv provides its own python/pip — remove pyenv stubs so they
      # don't intercept. Only needed if pyenv hasn't fully loaded yet.
      if (( ${+functions[_run_pyenv]} )); then
        unfunction python python3 pip pip3 2>/dev/null
      fi
    fi
  else
    if [[ -n "$VIRTUAL_ENV" ]]; then
      unset _OLD_VIRTUAL_PS1   # prevent deactivate from restoring a stale PS1
      deactivate

      # Restore pyenv stubs now that no venv is providing python/pip,
      # but only if pyenv still hasn't been fully initialised.
      if (( ${+functions[_run_pyenv]} )); then
        _lazy_load pyenv pyenv python python3 pip pip3
      fi
    fi
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _venv_auto
_venv_auto  # run on shell init for terminals opened inside a project

# ── Starship Prompt (must be last) ──
eval "$(starship init zsh)"
