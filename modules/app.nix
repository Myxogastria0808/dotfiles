{ pkgs, ... }:
{
  imports = [
    ./config/audio.nix # PipeWire audio stack and noise suppression
    ./config/commands.nix # General CLI utilities and system tools
    ./config/fonts.nix # Font packages and fontconfig defaults
    ./config/git.nix # Git, GitHub CLI, and repository management tools
    ./config/i18n.nix # Locale, fcitx5 input method, and SKK dictionaries
    ./config/language.nix # Programming language compilers and runtimes
    ./display-manager # KDE Plasma 6, COSMIC, and Hyprland desktop environments
    ./config/nix-ld.nix # Dynamic linker compatibility for pre-built binaries
    ./config/starship.nix # Starship cross-shell prompt
    ./config/virtualisation.nix # Docker, Waydroid, Incus, and libvirt/virt-manager
    ./config/steam.nix # Steam gaming platform
    ./config/zsh.nix # Zsh shell with Oh My Zsh, aliases, and custom functions
  ];
  environment.systemPackages = with pkgs; [
    # Container (Incus web UI - accessible at https://localhost:8443)
    incus-ui-canonical

    # TLS/SSL toolkit and certificate management
    openssl

    # Email client
    thunderbird

    # AI assistant CLIs
    codex
    claude-code

    # Serial port communication tools (RS-232C)
    screen
    minicom

    # WebAssembly runtime
    wasmtime

    # Build automation
    gnumake

    # Web browsers
    google-chrome
    w3m # Text-based browser for terminal use
    tor-browser # Privacy browser routing traffic through Tor

    # Fingerprint reader driver (for ThinkPad fingerprint sensor)
    fprintd-tod

    # KDE Connect - file transfer and notification sync with Android devices
    kdePackages.kdeconnect-kde

    # AppImage launcher - run AppImage binaries without extraction
    appimage-run

    # WireGuard VPN tools
    wireguard-tools

    # Remote desktop
    parsec-bin # GPU-accelerated game streaming
    remmina # RDP/VNC client

    # Game development
    godot # Open-source 2D/3D game engine

    # DJ mixing software
    mixxx

    # Geographic Information System
    qgis

    # Chat and communication
    discord
    slack
    zulip
    element-desktop # Matrix protocol desktop client

    # Text editors
    nano # Minimal terminal editor
    # Visual Studio Code
    # `--password-store=gnome-libsecret` suppresses the "OS keyring" popup on KDE Plasma.
    # Without this flag, VSCode prompts on every launch to use KWallet via the Secret Service API.
    # This flag tells VSCode to use the Secret Service API (which KWallet implements) directly.
    (vscode.override { commandLineArgs = "--password-store=gnome-libsecret"; })
    zed-editor # High-performance collaborative editor

    # Multi-package-manager CLI for npm/yarn/pnpm/bun/deno
    # Ref: https://github.com/antfu-collective/ni
    ni

    # Diagram generation
    mermaid-cli # Render Mermaid (.mmd) diagrams to PNG/SVG/PDF
    graphviz # DOT language diagram renderer

    # SKK dictionary management tools (for building custom dictionaries)
    skktools

    # Media processing (audio/video/image encoding, decoding, and conversion)
    ffmpeg

    # Video player
    mpv

    # Microsoft-compatible software
    teams-for-linux # Microsoft Teams
    libreoffice-qt # Office suite (Qt build for KDE)
    hunspell # Spell-checker engine used by LibreOffice
    hunspellDicts.uk_UA # Ukrainian spell-check dictionary
    hunspellDicts.th_TH # Thai spell-check dictionary

    # Live streaming and screen recording
    obs-studio

    # Password manager desktop app
    bitwarden-desktop

    # Design and drawing software
    drawio # Diagram/flowchart editor
    figma-linux # Unofficial Figma desktop client
    krita # Digital painting application
    inkscape # Vector graphics editor

    # Color picker for KDE
    kdePackages.kcolorchooser

    # Typst - modern typesetting system (alternative to LaTeX)
    typst

    # HTTP clients
    httpie # User-friendly HTTP client for the terminal
    postman # GUI API testing and documentation tool

    # Container management tools
    docker-compose # Multi-container Docker orchestration
    devenv # Development environment manager using Nix
    distrobox # Run any Linux distro inside a container
    lazydocker # Terminal UI for Docker container management

    # Embedded development
    arduino-ide

    # direnv integration - auto-load .envrc when entering a directory
    nix-direnv # Nix-specific direnv extension with faster evaluations
    direnv # Shell environment loader

    # Android device mirroring and control over USB or TCP/IP
    # Ref: https://github.com/Genymobile/scrcpy
    scrcpy

    # Minecraft launcher supporting multiple mod loaders
    prismlauncher

  ];
}
