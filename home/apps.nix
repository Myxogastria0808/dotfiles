{ pkgs, inputs, ... }:
{
  imports = [
    ./config/starship.nix
    ./config/git.nix
    ./config/zsh.nix
    ./config/firefox.nix
    ./config/nvim/nixvim.nix
    ./config/language.nix
    ./config/commands.nix
    ./config/mpv.nix
    ./config/kde.nix
    ./config/yazi.nix
    ./config/television
    ./config/ghostty
    # ./archive/zed-editor.nix
    # ./archive/alacritty.nix
    # ./archive/vscode.nix
  ];
  # Install pkgs
  home.packages = with pkgs; [
    #nix-gaming
    # inputs.nix-gaming.packages.${pkgs.system}.wine-ge

    #NUR
    #e.g. nur.repos.nikpkgs.simulide

    # RDP Client
    remmina

    # Chat
    vesktop # instead of Discord
    slack
    zulip

    #Matrix Desktop Client
    element-desktop

    # Editor
    nano
    vscode

    #skk
    skktools

    # Browser
    google-chrome
    inputs.zen-browser.packages."${pkgs.system}".default
    w3m
    tor-browser

    # Other Apps
    teams-for-linux
    drawio
    figma-linux
    zoom-us
    bitwarden-desktop
    libreoffice
    obs-studio
    ffmpeg
    krita
    inkscape
    blender
    kdePackages.kcolorchooser
    stacer

    # TeXLive full install
    texlive.combined.scheme-full
    # Typst
    typst

    # http client
    httpie
    postman

    # container
    docker-compose
    devenv
    distrobox
    lazydocker

    # Arduino IDE
    arduino-ide

    # for devShell
    nix-direnv
    direnv

    # VM
    vmware-workstation

    # make
    gnumake

    # Display and control Android devices over USB or TCP/IP
    # https://github.com/Genymobile/scrcpy/
    scrcpy

    # Mincraft
    prismlauncher
  ];
}
