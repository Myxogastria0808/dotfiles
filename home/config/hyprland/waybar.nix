{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "battery"
          "network"
          "pulseaudio"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
        };

        "hyprland/window" = {
          max-length = 50;
        };

        clock = {
          format = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "CPU {usage}%";
          interval = 5;
        };

        memory = {
          format = "MEM {}%";
          interval = 5;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "BAT {capacity}%";
          format-charging = "CHG {capacity}%";
          format-plugged = "PLG {capacity}%";
        };

        network = {
          format-wifi = "WiFi ({signalStrength}%)";
          format-ethernet = "ETH";
          format-disconnected = "No Network";
          tooltip-format = "{essid} {ipaddr}";
        };

        pulseaudio = {
          format = "VOL {volume}%";
          format-muted = "MUTE";
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: monospace;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(26, 27, 38, 0.9);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 5px;
        color: #7f849c;
      }

      #workspaces button.active {
        color: #cdd6f4;
        font-weight: bold;
      }

      #clock,
      #cpu,
      #memory,
      #battery,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
        color: #cdd6f4;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }
    '';
  };
}
