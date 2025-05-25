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
# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

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
alias ls='ls -FG'
alias la='ls -aFG'
alias ll='ls -alFG'
# git
alias g='git'
# lazygit
alias lg='lazygit'

# ====================
# switch shell
# ====================
# switch to Apple Silicon
alias arm64="env /usr/bin/arch -arm64 $(which zsh) --login"
# switch to Rosetta 2 (Intel)
alias intel="env /usr/bin/arch -x86_64 $(which zsh) --login"
