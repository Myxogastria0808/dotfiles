#!/bin/bash

curl -L https://nixos.org/nix/install | sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
ln -s $HOME/dotfiles/home $HOME/.config/home-manager
home-manager switch
ln -s $HOME/dotfiles/home/config/zsh/oh-my-zsh $HOME/.config/oh-my-zsh
