{ pkgs, inputs, ... }:
{
  imports = [
    ./config/alacritty.nix
    ./config/starship.nix
    ./config/git.nix
    ./config/zsh/zsh.nix
    ./config/firefox.nix
    ./config/nvim/nixvim.nix
    ./config/language.nix
    ./config/commands.nix
    ./config/vscode.nix
    ./config/mpv.nix
    ./config/kde.nix
  ];
  # Install pkgs
  home.packages = with pkgs; [
    #nix-gaming
    # inputs.nix-gaming.packages.${pkgs.system}.wine-ge

    #NUR
    #e.g. nur.repos.nikpkgs.simulide

    # Chat
    vesktop # instead of Discord
    slack
    zulip

    # Editor
    nano
    zed-editor

    # Browser
    google-chrome
    inputs.zen-browser.packages."x86_64-linux".default

    # Other Apps
    teams-for-linux
    drawio
    figma-linux
    zoom-us
    postman
    bitwarden-desktop
    libreoffice
    obs-studio
    davinci-resolve
    ffmpeg

    # TeXLive full install
    texlive.combined.scheme-full
    # Typst
    typst
    #Quarto
    quarto

    # Font
    _0xproto
    nerdfonts

    # Web API
    httpie

    # Graph DB
    neo4j-desktop

    #container
    docker
    docker-compose
    devenv
    distrobox

    #Arduino IDE
    arduino-ide

    #for nix-shell
    direnv

    #VM
    vmware-workstation

    #make
    gnumake
  ];
}
