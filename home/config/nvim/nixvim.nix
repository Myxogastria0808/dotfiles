{ pkgs, ... }: {
  imports = [
    nixvim.homeManagerModule.nixvim
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "hmts.nvim"
          "nvim-treesitter"
        ];
      };
      byteCompileLua.enable = true;
    };
  };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
}
