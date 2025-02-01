{
  username,
  pkgs,
  inputs,
  ...
}:
{
  home = {
    file = {
      "config" = {
        enable = true;
        source = ./config/config;
        target = "/home/${username}/.config/ghostty/config";
      };
    };
    packages = with pkgs; [
      inputs.ghostty.packages.${pkgs.system}.default
    ];
  };
}
