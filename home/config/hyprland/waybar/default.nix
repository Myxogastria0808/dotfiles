{ pkgs, ... }:
let
  micScript = pkgs.writeShellScript "waybar-mic" ''
    MUTE=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
    VOL=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk -F'/' '{print $2}' | tr -d ' ')
    if [ "$MUTE" = "yes" ]; then
      echo '{"text": "MIC MUTE", "class": "muted"}'
    else
      echo "{\"text\": \"MIC $VOL\", \"class\": \"active\"}"
    fi
  '';
in
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
          "bluetooth"
          "cpu"
          "memory"
          "battery"
          "network"
          "custom/microphone"
          "pulseaudio"
          "tray"
          "custom/power"
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
          format-muted = "VOL MUTE";
          on-click = "pavucontrol";
        };

        "custom/microphone" = {
          exec = "${micScript}";
          return-type = "json";
          interval = "once";
          signal = 1;
          on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +5% && kill -RTMIN+1 $(pgrep -x waybar 2>/dev/null || pgrep waybar)";
          on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -5% && kill -RTMIN+1 $(pgrep -x waybar 2>/dev/null || pgrep waybar)";
          on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle && sleep 0.1 && kill -RTMIN+1 $(pgrep -x waybar 2>/dev/null || pgrep waybar)";
          tooltip = true;
        };

        bluetooth = {
          format = "BT OFF";
          format-on = "BT";
          format-off = "BT OFF";
          format-connected = "BT {device_alias}";
          format-connected-battery = "BT {device_alias} {device_battery_percentage}%";
          tooltip-format = "Bluetooth: {status}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          on-click = "blueman-manager";
        };

        "custom/power" = {
          format = "PWR";
          on-click = "wlogout";
          tooltip = false;
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
      #bluetooth,
      #custom-microphone,
      #custom-power,
      #tray {
        padding: 0 10px;
        color: #cdd6f4;
      }

      #custom-microphone.muted {
        color: #f38ba8;
      }

      #pulseaudio.muted {
        color: #f38ba8;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #bluetooth.connected {
        color: #89b4fa;
      }

      #bluetooth.off {
        color: #6c7086;
      }

      #custom-power {
        color: #f38ba8;
      }
    '';
  };
}
