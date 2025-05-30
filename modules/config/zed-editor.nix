{
  programs.zed-editor = {
    enable = true;
    # extensions = [ ];
    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
      lsp = {
        rust-analyzer = {
          binary = {
            path = "/run/current-system/sw/bin/rust-analyzer";
          };
        };
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
    };
  };
}
