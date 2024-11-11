# ====================
# path
# ====================
##### homebrew
export PATH="/opt/homebrew/bin:$PATH"

# ====================
# alias
# ====================
##### git
alias g='git'

# ====================
# autoload
# ====================
##### enable autocomplete
autoload -Uz compinit && compinit
##### enable color
autoload -Uz colors; colors

# ====================
# prompt
# ====================
##### add new line after output
function add_new_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}

precmd() {
  add_new_line
}

##### prompt style
PROMPT="%{${fg[blue]}%}%~%{${reset_color}%} % %# "
