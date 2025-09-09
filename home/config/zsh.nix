{ pkgs, ... }:
{
  #参考サイト: https://blog.ryota-ka.me/posts/2021/12/31/home-manager
  programs.zsh = {
    enable = true;
    # .zshrc
    initContent = ''
      # IHP (Integrated Haskell Platform)
      # https://ihp.digitallyinduced.com
      eval "$(direnv hook bash)"
    '';
  };
}
