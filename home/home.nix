{ username, ... }:
{
  imports = [
    ./apps.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    # Using nixpkgs-unstable, so the release check is disabled to suppress version mismatch warnings
    stateVersion = "25.11";
    enableNixpkgsReleaseCheck = false;
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
