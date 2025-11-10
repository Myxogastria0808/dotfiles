{ pkgs, inputs, ... }:
{
  imports = [
    # ./config/archive/nixvim.nix
    # ./config/archive/starship.nix
    # ./config/archive/zsh.nix
    # ./config/archive/alacritty.nix
    # ./config/archive/television
    # ./config/archive/vscode.nix
    ./config/ghostty
    ./config/firefox.nix
  ];
  # Install pkgs
  home.packages = with pkgs; [
    # Browser
    # inputs.zen-browser.packages."${pkgs.system}".default
  ];
}
