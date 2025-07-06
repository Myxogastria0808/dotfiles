{ pkgs, inputs, ... }:
{
  imports = [
    ./config/firefox.nix
    ./config/nvim/nixvim.nix
    ./config/ghostty
    ./config/starship.nix
    ./config/zsh.nix
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
