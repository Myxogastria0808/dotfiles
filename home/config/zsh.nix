{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # one of zsh plugins
    zsh-you-should-use
  ];
  #参考サイト: https://blog.ryota-ka.me/posts/2021/12/31/home-manager
  programs.zsh = {
    enable = true;
    initExtraFirst = ''
      DISTRO=`sed -n -e /^NAME=/p /etc/os-release | cut -c 6-`
      EXCLAMATION="!!!"
      cowsay "Welcome to " ''$DISTRO''$EXCLAMATION | lolcat
    '';
    # zsh環境をnix-shellの環境に引き継ぐ
    # 参考サイト: https://scrapbox.io/mrsekut-p/nix-shell
    enableCompletion = true;
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          hash = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    # alias
    shellAliases = {
      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "ls" = "eza";
      "ll" = "eza -l";
      "tree" = "eza --tree";
      "find" = "fd";
      "size" = "fd --size";
      "ps" = "procs";
      "man" = "tldr";
      "diff" = "delta --side-by-side";
      "neofetch" = "fastfetch";
      #参考サイト: https://discourse.nixos.org/t/using-nix-develop-opens-bash-instead-of-zsh/25075
      "nix-develop" = "nix develop -c $SHELL";
      "hn" = "cd /etc/nixos && nix run home-manager -- switch --flake .#myHomeConfig";
      "hm" = "home-manager switch";
      "nr" = "sudo nixos-rebuild switch";
      "hs" = "firefox https://home-manager-options.extranix.com";
      "hg" = "home-manager generations";
      "ns" = "firefox https://search.nixos.org";
      "gc" = "nix-collect-garbage";
      "t" = "typst watch";
      "vv" = "appimage-run ~/.voicevox/VOICEVOX.AppImage";
      "net" = "speedtest";
      "cf-net" = "firefox https://speed.cloudflare.com/";
      "mobile" = "scrcpy -d";
      "clock" = "tty-clock -c -s";
      "g" = "lazygit";
      "pdf" = "tdf";
      "open" = "yazi";
      "tetris" = "bastet";
      "tv-history" = "tv zsh-history";
      "tv-nixpkg" = "tv nixpkgs";
    };
    # .zshrc
    initExtra = ''
      # zoxide
      eval "$(zoxide init zsh)"
      # oh-my-zsh
      ZSH_CUSTOM=$HOME/.config/oh-my-zsh
      # zsh-autosuggestions
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#586e75"
      # copy file to clipboard
      function copyfile () {
        cat $1
        xclip -selection clipboard $1
      }
      # copy path to clipboard
      function copypath () {
        result=$(pwd)
        echo "''${result}"
        echo "''${result}" | xclip -selection clipboard
      }
      # nurl alias
      #参考サイト: https://chitoku.jp/programming/bash-getopts-long-options/
      #参考サイト: https://future-architect.github.io/articles/20210405/
      #参考サイト: https://blog.kteru.net/bash-template-for-using-getopts/
      # fetchFromGitHubのsha256の取得用
      # ($1) ... optional option (-h, -f)
      # $1 ($2) ... github repository url
      # $2 ($3) ... version
      function nl () {
        while getopts ":h:f" opt; do
          case $opt in
            h)
              # -h が指定された場合
              result=''$(nurl -H ''${2} ''${3} 2> /dev/null)
              echo "''${result}"
              echo "''${result}" | xclip -selection clipboard
              ;;
            f)
              # -f が指定された場合
              result=''$(nurl ''${2} ''${3} 2> /dev/null)
              echo "''${result}"
              echo "''${result}" | xclip -selection clipboard
              ;;
            ?)
              # -h, -f 以外のオプションが指定された場合
              cat <<EOM
      This is unexpected option.

      Usage: nl [OPTIONS] [URL] [REV]

      Arguments:
              [URL]
                      URL to the repository to be fetched

              [REV]
                      The revision or reference to be fetched

      Options:
              -h
                      Show and copy to clipboard the hash value
              -f
                      Show and copy to clipboard complete results
      EOM
              ;;
          esac
        done
      }
    '';
    # .zenv
    envExtra = '''';
    # .zlogin
    loginExtra = '''';
    # .zlogout
    logoutExtra = '''';
  };
}
