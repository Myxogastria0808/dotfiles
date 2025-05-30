{ pkgs, inputs, ... }:
{
  imports = [
    ./config/starship.nix
    ./config/git.nix
    ./config/firefox.nix
    ./config/nvim/nixvim.nix
    ./config/mpv.nix
    ./config/kde.nix
    ./config/yazi.nix
    ./config/television
    ./config/ghostty
    # ./archive/vscode.nix
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
