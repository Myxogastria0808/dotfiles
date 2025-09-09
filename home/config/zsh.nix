{ pkgs, ... }:
{
  #参考サイト: https://blog.ryota-ka.me/posts/2021/12/31/home-manager
  programs.zsh = {
    enable = true;
    initExtraFirst = '''';
    # alias
    shellAliases = {};
    # .zshrc
    initExtra = ''
      # IHP (Integrated Haskell Platform)
      # https://ihp.digitallyinduced.com
      eval "$(direnv hook bash)"
    '';
    # .zenv
    envExtra = '''';
    # .zlogin
    loginExtra = '''';
    # .zlogout
    logoutExtra = '''';
  };
}
