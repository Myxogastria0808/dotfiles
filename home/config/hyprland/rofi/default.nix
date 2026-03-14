{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun,run";
      show-icons = true;
    };

    theme = ''
      * {
        background-color: #1e1e2e;
        text-color: #cdd6f4;
      }

      window {
        width: 40%;
        background-color: #1e1e2e;
      }

      listview {
        lines: 10;
      }

      element {
        background-color: transparent;
      }

      element-text {
        text-color: #cdd6f4;
      }

      element selected {
        background-color: #313244;
      }

      element-text selected {
        text-color: #f5e0dc;
      }
    '';
  };
}
