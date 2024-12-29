{ pkgs, inputs, ... }:
{
  imports = [
    ./config/starship.nix
    ./config/git.nix
    ./config/zsh/zsh.nix
    ./config/firefox.nix
    ./config/nvim/nixvim.nix
    ./config/language.nix
    ./config/commands.nix
    ./config/mpv.nix
    ./config/kde.nix
    ./config/zed-editor.nix
    # ./archive/alacritty.nix
    # ./archive/vscode.nix
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

    #Ghostty
    inputs.ghostty.packages.${pkgs.system}.default

    # Editor
    nano
    vscode
    positron-bin

    #skk
    skktools

    # Browser
    google-chrome
    inputs.zen-browser.packages."${pkgs.system}".default
    w3m

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
    freecad

    # TeXLive full install
    texlive.combined.scheme-full
    # Typst
    typst
    #Quarto
    quarto

    # http client
    httpie
    postman

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

    #Display and control Android devices over USB or TCP/IP
    #https://github.com/Genymobile/scrcpy/
    scrcpy
  ];
}
