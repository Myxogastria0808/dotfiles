#!/bin/bash

sudo chmod 777 /etc/nixos/home
sudo ln -s /etc/nixos/home $HOME/.config/home-manager
sudo ln -s /etc/nixos/home/config/zsh/oh-my-zsh $HOME/.config/oh-my-zsh
nix run home-manager -- switch --flake .#myHomeConfig
