# ====================
# path & init
# ====================
# homebrew
export PATH="/opt/homebrew/bin:$PATH"
# starship
eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
FPATH=/opt/homebrew/share/zsh-completions:$FPATH
FPATH=/opt/homebrew/share/zsh/site-functions:$FPATH


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
# git
alias g='git'
