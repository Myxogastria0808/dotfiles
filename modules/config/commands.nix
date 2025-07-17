{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # fetchers
    curl
    wget
    yt-dlp
    # researcher that files opened by a process
    lsof
    # next generation: neofetch
    fastfetch
    # next generation: top
    htop
    bottom
    # next generation: ls
    eza
    # next generation: cat
    bat
    # next generation: find
    fd
    # next generation: diff
    delta
    # partitioning tools
    parted
    gparted
    # zip / unzip
    zip
    unzip
    # rar / unrar
    rar
    unrar
    # file browsing tui
    yazi
    # pdf viewer
    tdf
    # network speed test tool
    ookla-speedtest
    # tty-clock: https://zenn.dev/nukokoi/articles/539017fa274cf4
    tty-clock
    # converter of character code and newline code
    nkf
    # nurl: https://github.com/nix-community/nurl
    nurl
    # xclip: https://kazuhira-r.hatenablog.com/entry/2023/07/31/000525
    xclip
    # joke commands
    ## audio visualization
    cava
    ## text decorations to rainbow
    lolcat
    ## ascii art
    sl
    cmatrix
    cowsay
    ## tetris
    bastet
  ];
}
