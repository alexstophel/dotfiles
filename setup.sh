#!/bin/bash

echo "Setting shell to zsh..."
if [ "$(echo $SHELL)" != "$(which zsh)" ]; then
  chsh -s $(which zsh);
fi

backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d%H%M%S)"
echo "Backing up existing dotfiles to $backup_dir..."
mkdir -p "$backup_dir"
dotfiles=(.aliases .config .gitconfig .zshrc .tmux.conf .zsh .bin)
for file in "${dotfiles[@]}"; do
  if [ -e "$HOME/$file" ]; then
    mv "$HOME/$file" "$backup_dir/"
  fi
done

echo "Checking for Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed. Skipping installation."
fi

echo "Using Homebrew to install packages..."
brew_packages=(tmux neovim asdf the_silver_searcher ripgrep universal-ctags)
for package in "${brew_packages[@]}"; do
  if ! brew list "$package" >/dev/null 2>&1; then
    brew install "$package"
  else
    echo "$package is already installed. Skipping..."
  fi
done

echo "Installing latest Python..."
asdf plugin-add python
asdf install python latest
asdf global python latest

echo "Installing latest Go..."
asdf plugin-add golang
asdf install golang latest
asdf global golang latest

echo "Installing latest Ruby..."
asdf plugin-add ruby
asdf install ruby latest
asdf global ruby latest
 
echo "Initializing the config for neovim..."
mkdir -p ~/.config
rm -rf ~/.config/nvim
ln -s $(pwd)/.config/nvim ~/.config/nvim
 
echo "Initializing the config for Alacritty..."
rm -rf ~/.config/alacritty
ln -s $(pwd)/.config/alacritty ~/.config/alacritty
 
echo "Creating symlinks to dotfiles in this directory..."
for file in "${dotfiles[@]}"; do
  if [[ "$file" != ".zsh" && "$file" != ".bin" ]]; then # Exclude directories
    ln -s $(pwd)/$file ~/$file
  fi
done
ln -s $(pwd)/.zsh ~/.zsh
ln -s $(pwd)/.bin ~/.bin

echo "Setup completed successfully."
