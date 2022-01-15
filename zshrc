# Load configs
for config in ~/.zsh/configs/*; do
  source $config
done

# Load functions
for function in ~/.zsh/functions/*; do
  source $function
done

# Add dotfiles bin to path
export PATH=$PATH:~/dotfiles/bin
export PATH=/Users/alexstophel/Development/recruiting-tech/ncsa-convoy/bin:$PATH

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source aliases.
[[ -f ~/.aliases ]] && source ~/.aliases

# Makes color constants available
autoload -U colors
colors

# Enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# Add .bin to the PATH
export PATH="$HOME/.bin:$PATH"

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

export PATH="$PATH:/Users/alexstophel/.local/bin"
