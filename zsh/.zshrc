zstyle :compinstall filename '/home/tarkah/.zshrc'
autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e

alias ll="ls -al --color"

. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

eval "$(starship init zsh)"
