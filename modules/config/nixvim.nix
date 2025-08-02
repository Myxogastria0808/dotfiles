{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    #* Configured nixvim *#
    # GitHub:https://github.com/dc-tec/nixvim
    # inputs.nixvim.packages.${pkgs.system}.default
  ];
  programs.nixvim = {
    enable = true;
    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "nvim-treesitter"
        ];
      };
    };
  };
}