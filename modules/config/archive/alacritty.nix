{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "0xProto Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "0xProto Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "0xProto Nerd Font";
          style = "Italic";
        };
      };
      window.opacity = 0.8;
      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
    };
  };
}