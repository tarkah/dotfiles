# Fpath
fpath+=~/.zfunc

# Completions
zstyle :compinstall filename '/home/tarkah/.zshrc'
autoload -Uz compinit
compinit

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Bindings
bindkey -e
bindkey '^ ' autosuggest-accept
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# Aliases
alias ll="ls -al --color"
alias nvim="nix run ~/dotfiles/nvim"
alias vi="nvim"
alias vim='nvim'

# OS specific
case `uname` in
    Darwin)
        . /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
    Linux)
        . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
esac

# Sourcing
function __source () [ -f $1 ] && . $1
__source "$HOME/.cargo/env"
__source "$HOME/.base16_theme"
__source "$HOME/.zshrc_local"
__source "$HOME/.ghcup/env"
unfunction __source

# Path
path=($HOME/.local/bin $path)
export PATH

# Eval
eval "$(starship init zsh)"
