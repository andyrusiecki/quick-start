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

if [ $os == "Mac" ]
then
  # check for homebrew
  if ![ -x "$(command -v brew)" ]
  then
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Updating and Upgrading Homebrew packages..."
  brew update
  brew upgrade

  echo "Installing Homebrew packages: git, zsh, zsh-completions"
  brew install git
  brew install zsh
  brew install zsh-completions

  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "Installing Powerlevel10k..."
  # Assumes your $ZSH_CUSTOM = "~/.oh-my-zsh/custom"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

  # changes to ~/.zshrc for powerlevel10k
  sed -i.bak "s/ZSH_THEME=.*/ZSH_THEME=powerlevel10k\/powerlevel10k/" ~/.zshrc

  echo "Installing Meslo Nerd Font for Powerlevel10k..."
  brew tap homebrew/cask-fonts
  brew cask install font-hack-nerd-font

  echo ""
  echo "All Done! Remaining Manual Steps:"
  if ! [ -f "/Applications/Visual Studio Code.app" ]
  then
    echo "- Download Visual Studio Code at https://code.visualstudio.com/docs/?dv=osx"
  fi

  if ! [ -f "/Applications/Docker.app" ]
  then
    echo "- Download Docker at https://hub.docker.com/editions/community/docker-ce-desktop-mac/"
  fi

  echo "- Set Terminal Font to Hack Nerd Font"
  echo "- Run `p10k configure` to configure Powerlevel10k"
elif [ $os == "Linux" ]
then
  if [ -x "$(command -v apt-get)" ]
  then
    # Ubuntu/Debian
    apt-get update
    apt-get upgrade

    # checking for snap store
    if ! [ -x "$(command -v snap)" ]
    then
      echo "Installing Snap Store..."
      apt-get install snapd
    fi
  elif [ -x "$(command -v pacman)" ]
  then
    # Manjaro
    pacman update
    pacman upgrade

    # checking for snap store
    if ! [ -x "$(command -v snap)" ]
    then
      echo "Installing Snap Store..."
      sudo pacman -S snapd
      sudo systemctl enable --now snapd.socket
    fi
  fi

  # install snap store
  sudo snap install snap-store

  # - zsh and powerlevel10k
  # - install vscode and docker with snap
fi
