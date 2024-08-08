{ pkgs, ... }: {
  home = rec {
    username="hello";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };
  # Enable home-manager
  programs.home-manager.enable = true;
  # Enable pkgs
  programs = {
    git.enable = true;
    # Editor
    neovim = {
      enable = true;
      defaultEditor = true; # $EDTOR=nvim
      viAlias = true;
      vimAlias = true;
    };
    starship.enable = true;
    zsh.enable = true;
    firefox.enable = true;
  };
  # Install pkgs
  home.packages = with pkgs; [
    discord
    # Editor
    nano
    vscode
    zed-editor
    # Terminal emulator
    alacritty
    # Browser
    google-chrome
    # Command
    curl
    wget
    neofetch
    tree
    lolcat
    sl
    # language
    python3
  ];
}
