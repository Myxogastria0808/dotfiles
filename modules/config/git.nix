{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh
    lazygit
    # 参考サイト: https://zenn.dev/oreo2990/articles/13c80cf34a95af
    ghq
    # Simplistic interactive filtering tool
    peco
  ];
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Myxogastria0808";
        email = "r.rstudio.c@gmail.com";
      };
      credential = {
        "https://github.com".helper = "!gh auth git-credential";
      };
    };
  };
}
