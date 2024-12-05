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
    ./config/mpv.nix
    ./config/kde.nix
    # ./config/vscode.nix
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
    vscode

    # Browser
    google-chrome
    inputs.zen-browser.packages."${pkgs.system}".default

    # Other Apps
    teams-for-linux
    drawio
    figma-linux
    zoom-us
    bitwarden-desktop
    libreoffice
    obs-studio
    davinci-resolve
    ffmpeg
    krita
    inkscape
    blender
    kdePackages.kcolorchooser

    # TeXLive full install
    texlive.combined.scheme-full
    # Typst
    typst
    #Quarto
    quarto

    # Font
    _0xproto
    nerdfonts

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
