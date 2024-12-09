{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gh
    #lazygit
    lazygit
  ];
  programs.git = {
    enable = true;
    userName = "Myxogastria0808";
    userEmail = "r.rstudio.c@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      credential."https://github.com".helper = "!gh auth git-credential";
    };
  };
}
