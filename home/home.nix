{ username, ... }:
{
  imports = [
    ./apps.nix
  ];
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
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
