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
