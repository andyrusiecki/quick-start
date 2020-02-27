#! /bin/bash

# OS Detection
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     os=Linux;;
  Darwin*)    os=Mac;;
  MINGW*)     os=Windows;;
  CYGWIN*)    os=Cygwin;;
  *)          os="Unknown:${unameOut}"
esac
echo "Detected OS: $os"

# TODO: Breakout each section by OS
# Mac:
# - xcode tools
# - homebrew
# - zsh and powerlevel10k
# - vscode and docker download if not exists
# Linux:
# - install snap store if possible
# - check for package manager
# - zsh and powerlevel10k
# - install vscode and docker with snap

# Package manager detection
pkgCommand="none"

if [ -x "$(command -v snap)" ]
then
  # Snap store
  pkgCommand="snap"
elif [ -x "$(command -v brew)" ]
then
  # Mac
  pkgCommand="brew"
elif [ -x "$(command -v apt-get)" ]
then
  # Ubuntu/Debian
  pkgCommand="apt-get"
fi
echo "Detected Package Manager: $pkgCommand"

# Add package manager if none is found
if [ $pkgCommand == "none" ]
  if [ $os == "Mac" ]
  then
    # Install homebrew for Mac
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi


# Update package manager lists and upgrade packages
if [ $pkgCommand == "brew" ] || [ $pkgCommand == "apt-get" ]
then
  echo "Updating packages..."
  #$pkgCommand update

  echo "Upgrading packages..."
  #$pkgCommand upgrade
fi

# Install packages
# git, zsh, zsh-completions

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# After Complete
echo "Final Steps:"
echo "Restart zsh"
echo "Set ZSH_THEME=\"powerlevel10k/powerlevel10k\" in ~/.zshrc."
echo "Install and use Recommended Font: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
echo "Run `p10k configure`"
echo "Terminal Colors: Tango Dark"
