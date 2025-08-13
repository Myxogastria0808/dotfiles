{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Fetchers
    curl
    wget
    yt-dlp
    # Researcher that files opened by a process
    lsof
    # Next generation: neofetch
    fastfetch
    # CPU monitaring tui
    s-tui
    # Next generation: top
    htop
    bottom
    # Next generation: ls
    eza
    # Next generation: cat
    bat
    # Next generation: find
    fd
    # Next generation: diff
    delta
    # Partitioning tools
    parted
    gparted
    # zip / unzip
    zip
    unzip
    # rar / unrar
    rar
    unrar
    # File browsing tui
    yazi
    # Pdf viewer
    tdf
    # Network speed test tool
    ookla-speedtest
    # tty-clock: https://zenn.dev/nukokoi/articles/539017fa274cf4
    tty-clock
    # Converter of character code and newline code
    nkf
    # nurl: https://github.com/nix-community/nurl
    nurl
    # xclip: https://kazuhira-r.hatenablog.com/entry/2023/07/31/000525
    xclip
    # Joke commands
    ## Audio visualization
    cava
    ## Text decorations to rainbow
    lolcat
    ## Ascii art
    sl
    cmatrix
    cowsay
    ## Tetris
    bastet
  ];
}
