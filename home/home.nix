{ username, ... }:
{
  imports = [
    ./apps.nix
  ];
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
    file = {
      "user.dict" = {
        enable = true;
        target = "/home/${username}/.local/share/fcitx5/skk/user.dict";
        source = ./config/skk/user.dict;
      };
    };
  };
  # Enable home-manager
  programs.home-manager.enable = true;
  nixpkgs = {
    config = {
      # Enable install unfree pkgs
      allowUnfree = true;
    };
  };
}
