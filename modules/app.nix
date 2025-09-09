{ pkgs, ... }:
{
  imports = [
    ./config/commands.nix
    ./config/fonts.nix
    ./config/git.nix
    ./config/haskell.nix
    ./config/language.nix
    ./config/nix-ld.nix
    ./config/nixvim.nix
    ./config/starship.nix
    ./config/steam.nix
    ./config/zsh.nix
  ];
  environment.systemPackages = with pkgs; [
    # home-manager
    home-manager

    # Browser
    google-chrome
    w3m
    tor-browser

    # Fingerprint
    fprintd-tod

    # KDE connect
    kdePackages.kdeconnect-kde

    # AppImage
    appimage-run

    # Wireguard
    wireguard-tools

    # RDP
    parsec-bin
    # RDP Client
    remmina

    # DJ Mixing Software
    mixxx

    # Geographic Information System
    qgis

    # Chat
    vesktop # instead of Discord
    slack
    zulip
    element-desktop # Matrix Desktop Client

    # Editor
    helix
    nano
    vscode

    # Input Method
    skktools

    # Image
    ffmpeg

    # Video
    mpv

    # Microsoft like Software
    teams-for-linux
    libreoffice

    # Live Streaming
    obs-studio

    # Password Manager
    bitwarden-desktop

    # Design and Drawing Software
    drawio
    figma-linux
    krita
    inkscape

    # Color Picker
    kdePackages.kcolorchooser

    # Typst
    typst

    # Http Client
    httpie
    postman

    # Container
    docker-compose
    devenv
    distrobox
    lazydocker

    # Arduino IDE
    arduino-ide

    # for devShell
    nix-direnv
    direnv

    # Display and control Android devices over USB or TCP/IP
    # https://github.com/Genymobile/scrcpy/
    scrcpy

    # Minecraft
    prismlauncher
  ];
}
