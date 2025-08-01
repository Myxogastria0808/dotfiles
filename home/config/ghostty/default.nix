{ pkgs, username, ... }:
{
  home = {
    file = {
      "config" = {
        enable = true;
        source = ./config/config;
        target = "/home/${username}/.config/ghostty/config";
      };
    };
    packages = with pkgs; [
      ghostty
    ];
  };
}
