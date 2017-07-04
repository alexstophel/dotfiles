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

autoload -Uz compinit && compinit
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
