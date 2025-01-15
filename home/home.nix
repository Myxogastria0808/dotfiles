{ username, ... }:
{
  imports = [
    ./apps.nix
  ];
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    #This dotfiles use nixpkgs-unstable so hn command does not check "release check".
    stateVersion = "24.11";
    enableNixpkgsReleaseCheck = false;
    #ghostty
    file."config" = {
      enable = true;
      source = ./config/ghostty/config;
      target = "/home/${username}/.config/ghostty/config";
    };
  };
  # Enable home-manager
  programs.home-manager.enable = true;
  nixpkgs = {
    config = {
      # Enable install unfree pkgs
      allowUnfree = true;
    };
  };
}
