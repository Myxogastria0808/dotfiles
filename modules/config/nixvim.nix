{ inputs, ... }: {
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