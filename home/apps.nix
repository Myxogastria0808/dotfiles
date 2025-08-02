{ pkgs, inputs, ... }:
{
  imports = [
    ./config/firefox.nix
    # ./config/archive/nixvim.nix
    ./config/ghostty
    # ./config/archive/starship.nix
    # ./config/archive/zsh.nix
    # ./config/archive/alacritty.nix
    # ./config/archive/television
    # ./config/archive/vscode.nix
  ];
  # Install pkgs
  home.packages = with pkgs; [
    # Browser
    inputs.zen-browser.packages."${pkgs.system}".default
  ];
}
