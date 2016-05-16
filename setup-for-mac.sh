# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/fonts
brew cask install font-inconsolata

brew tap railwaycat/emacsmacport
brew install --with-cocoa --srgb --gnutls emacs
brew linkapps
