{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    #nixvim
    inputs.nixvim.packages.x86_64-linux.default
  ];
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
