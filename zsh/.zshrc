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

# Aliases
alias ll="ls -al --color"

# Sourcing
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
. "$HOME/.cargo/env"
. "$HOME/.base16_theme"

# Path
path+=($HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin)
path=($HOME/.local/bin $path)
export PATH

# Eval
eval "$(starship init zsh)"
