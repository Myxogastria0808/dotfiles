{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # File path index and search tool (run `updatedb` first to build the index)
    mlocate
    # Pipeline progress monitor - shows throughput and ETA for piped data
    pv
    # HTTP/HTTPS download tool
    curl
    # Non-interactive downloader for HTTP, HTTPS, and FTP
    wget
    # YouTube and other video site downloader
    yt-dlp
    # Shows all files currently opened by a process (useful for debugging)
    lsof
    # System information tool - modern replacement for neofetch
    fastfetch
    # CPU stress test and real-time monitoring TUI
    s-tui
    # Interactive process viewer - next-gen replacement for top
    htop
    # Cross-platform resource monitor TUI (CPU, memory, disk, network)
    bottom
    # Modern ls replacement with colors, icons, and Git integration
    eza
    # Syntax-highlighted file viewer - modern replacement for cat
    bat
    # Fast file finder - modern replacement for find
    fd
    # Side-by-side diff viewer with syntax highlighting - modern replacement for diff
    delta
    # Disk partitioning CLI
    parted
    # Disk partitioning GUI
    gparted
    # Terminal-based file manager with Vim-like keybindings
    yazi
    # Archive tools
    zip
    unzip
    rar
    unrar
    # Terminal PDF viewer
    tdf
    # Ookla network speed test CLI
    ookla-speedtest
    # Terminal clock with large display
    # Ref: https://zenn.dev/nukokoi/articles/539017fa274cf4
    tty-clock
    # Character encoding and newline code converter (useful for Japanese text files)
    nkf
    # Nix fetcher helper - generates fetchFromGitHub hashes and revs
    # Ref: https://github.com/nix-community/nurl
    nurl
    # Nix package initializer - scaffolds package expressions from URLs
    # Ref: https://github.com/nix-community/nix-init
    nix-init
    # Prefetch dependencies from npm
    prefetch-npm-deps
    # Copy text to the X11 clipboard from the terminal
    # Ref: https://kazuhira-r.hatenablog.com/entry/2023/07/31/000525
    xclip
    # Fun / joke commands
    cava # Real-time audio spectrum visualizer in the terminal
    lolcat # Pipes text output through rainbow colors
    sl # Animated ASCII steam locomotive (anti-typo for `ls`)
    cmatrix # Matrix-style falling characters animation
    cowsay # ASCII cow (or other animals) saying a message
    bastet # Tetris clone for the terminal
  ];
}
