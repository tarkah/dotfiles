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

# Aliases
alias ll="ls -al --color"
alias vi="nvim"
alias vim='nvim'

# OS specific
case `uname` in
    Darwin)
        path+=($HOME/.rustup/toolchains/nightly-aarch64-apple-darwin/bin)
        . /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
    Linux)
        path+=($HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin)
        . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
esac

# Sourcing
. "$HOME/.cargo/env"
. "$HOME/.base16_theme"
. "$HOME/.zshrc_local"

# Path
path=($HOME/.local/bin $path)
export PATH

# Eval
eval "$(starship init zsh)"

