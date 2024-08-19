{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true; # $EDTOR=nvim
    viAlias = true;
    vimAlias = true;
  };
  # require AstroNvim pkgs
  home.packages = with pkgs; [
    tree-sitter
  ];
}
