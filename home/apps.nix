{ pkgs, ... }: {
  imports = [
    ./config/alacritty.nix
    ./config/starship.nix
    ./config/git.nix
    ./config/zsh/zsh.nix
    ./config/firefox.nix
    ./config/nvim/nvim.nix
    ./config/language.nix
    ./config/commands.nix
    ./config/docker.nix
    ./config/vscode.nix
    ./config/mpv.nix
  ];
  # Install pkgs
  home.packages = with pkgs; [
    # Chat
    vesktop # instead of Discord
    slack
    zulip

    # Editor
    nano
    zed-editor

    # Browser
    google-chrome

    # Other Apps
    teams-for-linux
    drawio
    figma-linux
    zoom-us
    postman
    bitwarden-desktop

    # TeXLive full install
    texlive.combined.scheme-full
    # Typst
    typst

    # Font
    _0xproto
    nerdfonts

    # Web API
    httpie

    # Graph DB
    neo4j-desktop
  ];
}
