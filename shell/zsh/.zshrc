# Completion
autoload -Uz compinit
compinit

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Useful shell behaviour
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# VIM
bindkey -v

# FZF
source <(fzf --zsh)

# Navigation
eval "$(zoxide init zsh)"
alias ':q'='exit'
alias 'cd'='z'

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt
eval "$(starship init zsh)"

# Better completion behaviour

export LS_COLORS="${LS_COLORS}:di=1;38;2;231;130;255:ex=1;38;2;203;166;247:ln=38;2;203;93;255:mi=38;2;108;112;134:or=1;38;2;243;139;168"
alias ls='ls --color=auto'

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#cba6f7,bold'

ZSH_HIGHLIGHT_STYLES[builtin]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[function]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8'


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
