#!/bin/bash

cd /etc/nixos && nix run home-manager -- switch --flake .#myHomeConfig
