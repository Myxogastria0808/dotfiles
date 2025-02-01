{
  username,
  pkgs,
  inputs,
  ...
}:
{
  #nix-search-tv: https://github.com/3timeslazy/nix-search-tv?tab=readme-ov-file
  home = {
    file = {
      "config.toml" = {
        enable = true;
        source = ./config/television/config/config.toml;
        target = "/home/${username}/.config/television/config.toml";
      };
      "default_channels.toml" = {
        enable = true;
        source = ./config/television/config/default_channels.toml;
        target = "/home/${username}/.config/television/default_channels.toml";
      };
      "nix_channels.toml" = {
        enable = true;
        source = ./config/television/config/nix_channels.toml;
        target = "/home/${username}/.config/television/nix_channels.toml";
      };
    };
    packages = with pkgs; [
      television
      inputs.nix-search-tv.packages.${pkgs.system}.default
    ];
  };
}
