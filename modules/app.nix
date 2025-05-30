{ pkgs, ... }:
{
  imports = [
    ./config/commands.nix
    ./config/git.nix
    ./config/language.nix
    ./config/mpv.nix
    ./config/starship.nix
    ./config/thunderbird.nix
    ./config/yazi.nix
  ];
  environment.systemPackages = with pkgs; [
    # RDP
    parsec-bin
    # RDP Client
    remmina

    # DJ Mixing Software
    mixxx

    # Chat
    vesktop # instead of Discord
    slack
    zulip
    # Matrix Desktop Client
    element-desktop

    # Editor
    nano
    vscode
    zed-editor

    # Input Method
    skktools

    # Image
    ffmpeg

    # Microsoft like Software
    teams-for-linux
    libreoffice

    # Live Streaming
    obs-studio

    # 3D Modelling
    blender

    # Meeting Software
    zoom-us

    # Password Manager
    bitwarden-desktop

    # Design and Drawing Software
    drawio
    figma-linux
    krita
    inkscape

    # Color Picker
    kdePackages.kcolorchooser
    stacer

    # TeXLive (almost full)
    texlive.combined.scheme-full

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

    # Virtual Machine
    vmware-workstation

    # make
    gnumake

    # Display and control Android devices over USB or TCP/IP
    # https://github.com/Genymobile/scrcpy/
    scrcpy

    # Minecraft
    prismlauncher
  ];
}
