{ pkgs, username, ... }:
{
  home = {
    file = {
      # Deploy Ghostty config file to ~/.config/ghostty/config
      "config" = {
        enable = true;
        source = ./config;
        target = "/home/${username}/.config/ghostty/config";
      };
    };
    packages = with pkgs; [
      ghostty
    ];
  };
}
