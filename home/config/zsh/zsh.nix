{ pkgs, ... }: {
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
      "cat" = "bat";
      "find" = "fd";
      "ps" = "procs";
      "man" = "tldr";
      "diff" = "delta --side-by-side";
      "neofetch" = "fastfetch";
      "hn" = "cd /etc/nixos && nix run home-manager -- switch --flake .#myHomeConfig";
      "hm" = "home-manager switch";
      "nr" = "sudo nixos-rebuild switch";
      "hs" = "firefox https://home-manager-options.extranix.com";
      "ns" = "firefox https://search.nixos.org";
      "gc" = "nix-collect-garbage";
      "R" = "R | lolcat";
      "t" = "typst compile";
      "vv" = "appimage-run ~/.voicevox/VOICEVOX.AppImage";
    };
    # .zshrc
    initExtra = ''
      #zoxide
      eval "$(zoxide init zsh)"
      #oh-my-zsh
      ZSH_CUSTOM=$HOME/.config/oh-my-zsh
      #playwright
      export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
      export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
    '';
    # .zenv
    envExtra = '''';
    # .zlogin
    loginExtra = '''';
    # .zlogout
    logoutExtra = '''';
  };
}
