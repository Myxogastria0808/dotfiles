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
    # container
    incus-ui-canonical

    # Generative AI Agent CLI
    codex
    claude-code

    # Rs232c
    screen
    minicom

    # WASM Runtime
    wasmtime

    # Build System
    gnumake

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

    # Game Engine
    godot

    # DJ Mixing Software
    mixxx

    # Geographic Information System
    qgis

    # Chat
    discord
    # vesktop # instead of Discord
    slack
    zulip
    element-desktop # Matrix Desktop Client

    # Editor
    nano
    vscode
    zed-editor

    # ni
    # multiple npm package management tool
    # support: npm · yarn · pnpm · bun · deno
    # Reference: https://github.com/antfu-collective/ni
    ni

    # Mermaid CLI
    mermaid-cli

    # Input Method
    skktools

    # Image
    ffmpeg

    # Video
    mpv

    # Video Editor
    kdePackages.kdenlive

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
