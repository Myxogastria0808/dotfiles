{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    wget
    fastfetch
    bottom
    eza
    zoxide
    bat
    fd
    procs
    tldr
    delta
    parted
    gparted
    zip
    unzip
    rename
    #tty-clock: https://zenn.dev/nukokoi/articles/539017fa274cf4
    tty-clock
    ookla-speedtest
    # ネタコマンド
    lolcat
    sl
    cowsay
    cmatrix
    bastet
    oneko
  ];
}
