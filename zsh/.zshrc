# ====================
# path & init
# ====================
# homebrew
export PATH="/opt/homebrew/bin:$PATH"
# starship
eval "$(starship init zsh)"
# zsh autocomplete
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
FPATH=/opt/homebrew/share/zsh-completions:$FPATH
FPATH=/opt/homebrew/share/zsh/site-functions:$FPATH
# mise
unsetopt nomatch
eval "$(mise activate zsh)"


# ====================
# autoload
# ====================
# enable autocomplete
autoload -Uz compinit && compinit
# enable color
autoload -Uz colors; colors
# gh autocomplete
eval "$(gh completion -s zsh)"


# ====================
# history
# ====================
# zsh_history size
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups  # not left same command


# ====================
# alias
# ====================
# unix
alias ls='lsd -FG'
alias la='lsd -aFG'
alias ll='lsd -alFG'
# bat
alias cat='bat --theme base16'
alias bat='bat --theme base16'
# git
alias g='git'
# lazygit
alias lg='lazygit'
# switch to Apple Silicon
alias switch-arm64="env /usr/bin/arch -arm64 $(which zsh) --login"
# switch to Rosetta 2 (Intel)
alias switch-intel="env /usr/bin/arch -x86_64 $(which zsh) --login"


# ====================
# functions
# ====================
# get terminal architecture
export GET_TERMINAL_ARCHITECTURE=$(
  if [ "$(arch)" = "arm64" ]; then
    echo "arm64"
  else
    echo "Rosetta (x86_64)"
  fi
)
