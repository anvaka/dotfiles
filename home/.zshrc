# ~/.zshrc — refreshed 2026-06-21
# Flow: PATH -> history -> completion -> plugins -> prompt -> tools -> aliases/fns -> env -> secrets -> SDKs
# Secrets are NOT here — they live in ~/.config/zsh/secrets.zsh (chmod 600, keep out of git).

# Interactive shells only beyond this point.
[[ $- != *i* ]] && return

# ----- PATH -----
typeset -U path
path=(
  /opt/homebrew/opt/llvm/bin
  /opt/homebrew/bin
  "$HOME/.local/bin"
  /usr/local/bin
  /usr/bin /bin /usr/sbin /sbin
  /usr/local/opt/go/libexec/bin
  "$HOME/.npm-global/bin"
  "$HOME/.cargo/bin"
  $path
)
export PATH

# ----- History (atuin layers fuzzy search on top of this) -----
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY EXTENDED_HISTORY

# ----- Completion (must run before fzf-tab loads) -----
autoload -Uz compinit
# Rebuild the completion dump at most once a day; otherwise take the fast path.
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu no                              # fzf-tab owns the menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive matching

# ----- Plugins (antidote) -----
ANTIDOTE=/opt/homebrew/opt/antidote/share/antidote/antidote.zsh
if [[ -e $ANTIDOTE ]]; then
  source "$ANTIDOTE"
  antidote load "$HOME/.config/zsh/.zsh_plugins.txt"
fi
# fzf-tab niceties
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=auto $realpath 2>/dev/null'
zstyle ':fzf-tab:*' fzf-flags --height=60%

# ----- Prompt: Starship -----
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# ----- Tools -----
[[ -t 0 ]] && command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd z)"   # smart cd: `z <dir>`
command -v fnm    >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"
command -v atuin  >/dev/null 2>&1 && eval "$(atuin init zsh)"            # Ctrl-R fuzzy history

# ----- Modern CLI aliases (only if the tool is installed) -----
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -lah --group-directories-first --icons=auto --git'
  alias la='eza -a   --group-directories-first --icons=auto'
  alias lt='eza --tree --level=2 --icons=auto'
fi
command -v bat     >/dev/null 2>&1 && alias cat='bat --paging=never'
command -v dust    >/dev/null 2>&1 && alias du='dust'
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'
alias vim=nvim
alias chrome="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"

# ----- Functions -----
vv() { npm version $* && git push && git push --tags && npm publish; }   # bump version + publish

fe() {  # fuzzy-find a file, open in $EDITOR
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

fkill() {  # fuzzy-pick process(es), then kill
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  [ -n "$pid" ] && kill -"${1:-9}" $pid
}

conda-init() {  # initialize conda on demand (kept out of startup for speed)
  local conda_bin="$HOME/miniforge3/bin/conda"
  if [ -x "$conda_bin" ]; then
    eval "$("$conda_bin" 'shell.zsh' 'hook' 2>/dev/null)"
  else
    echo "conda-init: Conda not found at $conda_bin" >&2; return 1
  fi
}

# ----- Environment (non-secret) -----
export EDITOR=nvim
export RUST_SRC_PATH="$HOME/projects/other/rust/src"
export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
export ANDROID_HOME=/usr/local/opt/android-sdk
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# ----- Secrets (chmod 600, not in git) -----
[ -f "$HOME/.config/zsh/secrets.zsh" ] && source "$HOME/.config/zsh/secrets.zsh"

# ----- Third-party SDKs -----
for gcloud_root in "$HOME/google-cloud-sdk" "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"; do
  if [ -f "$gcloud_root/path.zsh.inc" ]; then
    source "$gcloud_root/path.zsh.inc"
    [ -f "$gcloud_root/completion.zsh.inc" ] && source "$gcloud_root/completion.zsh.inc"
    break
  fi
done
[ -f "$HOME/torch-cl/install/bin/torch-activate" ] && . "$HOME/torch-cl/install/bin/torch-activate"
