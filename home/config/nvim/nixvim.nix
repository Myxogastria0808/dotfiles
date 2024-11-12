{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # nixvim
    # GitHub:https://github.com/dc-tec/nixvim
    inputs.nixvim.packages.${pkgs.system}.default
  ];
  # default nixvim
  # programs.nixvim = {
  #   enable = true;
  #   performance = {
  #     combinePlugins = {
  #       enable = true;
  #       standalonePlugins = [
  #         "nvim-treesitter"
  #       ];
  #     };
  #   };
  # };
}
