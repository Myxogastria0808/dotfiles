{ pkgs, inputs, ... }:
{
  imports = [
    ./config/firefox.nix
    ./config/nvim/nixvim.nix
    ./config/kde.nix
    ./config/ghostty
    ./config/starship.nix
    ./config/git.nix
    ./config/thunderbird.nix
    ./config/yazi.nix
    ./config/zed-editor.nix
    ./config/zsh.nix
    # ./config/archive/alacritty.nix
    # ./config/archive/television
    # ./config/archive/vscode.nix
  ];
  # Install pkgs
  home.packages = with pkgs; [
    #nix-gaming
    # inputs.nix-gaming.packages.${pkgs.system}.wine-ge

    #NUR
    #e.g. nur.repos.nikpkgs.simulide

    # Browser
    google-chrome
    inputs.zen-browser.packages."${pkgs.system}".default
    w3m
    tor-browser
  ];
}
