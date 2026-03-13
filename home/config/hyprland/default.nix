{ inputs, pkgs, ... }:
{
  imports = [
    ./moka
    ./rofi
    ./waybar
  ];

  # hyprland family tools
  home.packages = with pkgs; [
    # Screenshot
    grimblast
    # Brightness control
    brightnessctl
    # Wallpaper
    swww
    # Clipboard manager
    cliphist
    wl-clipboard
    # Color picker
    hyprpicker
    # Bluetooth manager
    blueman
    # Power menu
    wlogout
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # Disable home-manager's built-in systemd integration: it conflicts with UWSM,
    # which manages the Hyprland session via its own systemd units.
    # Ref: https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/
    systemd.enable = false;
    # Use the same package as the NixOS module to avoid version mismatch
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {
      # ── Monitor ───────────────────────────────────────────────────────────────
      # Ref: https://wiki.hypr.land/Configuring/Monitors/
      # Format: name, resolution@hz, position, scale
      # "preferred" and "auto" let Hyprland detect the best values
      monitor = [ ",preferred,auto,1" ];

      # ── Autostart ─────────────────────────────────────────────────────────────
      # Ref: https://wiki.hypr.land/Configuring/Keywords/#executing
      # exec-once: execute only on launch
      exec-once = [
        "swww-daemon"
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
        "waybar"
      ];

      # ── General ───────────────────────────────────────────────────────────────
      # Ref: https://wiki.hypr.land/Configuring/Variables/#general
      general = {
        gaps_in = 5; # Gaps between windows (int, default: 5)
        gaps_out = 10; # Gaps between windows and screen edge (int, default: 20)
        border_size = 2; # Size of the border around windows (int, default: 1)
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg"; # Border color for focused windows (str, default: 0xffffffff)
        "col.inactive_border" = "rgba(595959aa)"; # Border color for unfocused windows (str, default: 0xff444444)
        layout = "dwindle"; # which layout to use (str, default: "dwindle")
        resize_on_border = true; # Enables resizing windows by clicking and dragging on borders and gaps (bool, default: false)
      };

      # ── Decoration ────────────────────────────────────────────────────────────
      # Ref: https://wiki.hypr.land/Configuring/Variables/#decoration
      decoration = {
        rounding = 10; # Window corner rounding (int, default: 0)
        blur = {
          enabled = true;
          size = 3; # Blur size (int, default: 8)
        };
        shadow = {
          enabled = true;
          range = 20; # Shadow range (int, default: 4)
        };
      };

      # ── Animations ────────────────────────────────────────────────────────────
      # Ref: https://wiki.hypr.land/Configuring/Animations/
      animations = {
        enabled = true;
        # bezier curve for animations:
        #   Format: name, x1, y1, x2, y2
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          # event name:
          #   windows: appearance a window
          #   windowsOut: disappearance a window
          #   border: change border color
          #   fade: fade in/out when switching workspaces or changing focus
          #   workspaces: switch between workspaces
          #
          # Animation Tree
          # Ref: https://wiki.hypr.land/Configuring/Animations/
          #
          # global
          #  ↳ windows - styles: slide, popin, gnomed
          #    ↳ windowsIn - window open - styles: same as windows
          #    ↳ windowsOut - window close - styles: same as windows
          #    ↳ windowsMove - everything in between, moving, dragging, resizing.
          #  ↳ layers - styles: slide, popin, fade
          #    ↳ layersIn - layer open
          #    ↳ layersOut - layer close
          #  ↳ fade
          #    ↳ fadeIn - fade in for window open
          #    ↳ fadeOut - fade out for window close
          #    ↳ fadeSwitch - fade on changing activewindow and its opacity
          #    ↳ fadeShadow - fade on changing activewindow for shadows
          #    ↳ fadeDim - the easing of the dimming of inactive windows
          #    ↳ fadeLayers - for controlling fade on layers
          #      ↳ fadeLayersIn - fade in for layer open
          #      ↳ fadeLayersOut - fade out for layer close
          #    ↳ fadePopups - for controlling fade on wayland popups
          #      ↳ fadePopupsIn - fade in for wayland popup open
          #      ↳ fadePopupsOut - fade out for wayland popup close
          #    ↳ fadeDpms - for controlling fade when dpms is toggled
          #  ↳ border - for animating the border's color switch speed
          #  ↳ borderangle - for animating the border's gradient angle - styles: once (default), loop
          #  ↳ workspaces - styles: slide, slidevert, fade, slidefade, slidefadevert
          #    ↳ workspacesIn - styles: same as workspaces
          #    ↳ workspacesOut - styles: same as workspaces
          #    ↳ specialWorkspace - styles: same as workspaces
          #      ↳ specialWorkspaceIn - styles: same as workspaces
          #      ↳ specialWorkspaceOut - styles: same as workspaces
          #  ↳ zoomFactor - animates the screen zoom
          #  ↳ monitorAdded - monitor added zoom animation
          #
          # on / off: 1 to enable, 0 to disable
          #
          # speed: duration of the animation in ds (1ds = 100ms)
          #
          # bezier curve name: the name of the bezier curve to use for the animation
          #   myBezier: a custom bezier curve defined above
          #   default: the default bezier curve provided by Hyprland
          #
          # style: the style of the animation

          # windows: appearance a window
          #   Format: event name, on / off, speed, bezier curve name, style
          "windows, 1, 7, myBezier"
          # windowsOut: disappearance a window
          #   Format: event name, on / off, speed, bezier curve name, style
          "windowsOut, 1, 7, default"
          # border: change border color
          #   Format: event name, on / off, speed, bezier curve name, style
          "border, 1, 10, default"
          # fade: fade in/out when switching workspaces or changing focus
          #   Format: event name, on / off, speed, bezier curve name, style
          "fade, 1, 7, default"
          # workspaces: switch between workspaces
          #   Format: event name, on / off, speed, bezier curve name, style
          "workspaces, 1, 6, default"
        ];
      };

      # ── Input ─────────────────────────────────────────────────────────────────
      # Ref: https://wiki.hypr.land/Configuring/Variables/#input
      input = {
        kb_layout = "us"; # Keyboard layout (str, default: "us")
        sensitivity = 0; # Mouse sensitivity (-1.0 ~ 1.0, default: 0)
        touchpad = {
          natural_scroll = true; # Natural scrolling (bool, default: false)
          tap_button_map = "lrm"; # Map of left, right, middle buttons for tap-to-click ([lrm/lmr], default: "lrm")
        };
      };

      # ── Layout ────────────────────────────────────────────────────────────────
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # ── Keybindings ───────────────────────────────────────────────────────────
      # Ref: https://wiki.hypr.land/Configuring/Binds/
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$browser" = "firefox";
      "$fileManager" = "dolphin";
      "$discord" = "discord";

      bind = [
        # Basic window management
        # Super + Q: close window
        "$mod, Q, killactive"
        # Super + M: logout
        "$mod, M, exit"
        # Super + F: toggle fullscreen
        "$mod, F, fullscreen"
        # Super + T: toggle floating
        "$mod, T, togglefloating"

        # Applications
        # Super + Enter: open terminal
        "$mod, Return, exec, $terminal"
        # Super + B: open browser
        "$mod, B, exec, $browser"
        # Super + E: open file manager
        "$mod, E, exec, $fileManager"
        # Super + D: open discord
        "$mod, D, exec, $discord"

        # App launcher
        # Super + Space: open app launcher (rofi)
        "$mod, Space, exec, rofi -show drun"

        # Clipboard history
        # Super + V: open clipboard history (rofi)
        "$mod, V, exec, cliphist list | rofi -dmenu -display-columns 5 | cliphist decode | wl-copy"

        # Color picker (result is copied to clipboard)
        # Super + C: open color picker (hyprpicker)
        "$mod, C, exec, hyprpicker --autocopy"

        # Focus windows
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Screenshot (grimblast)
        #
        # Syntax: grimblast [action] [target] [path]
        #
        # action:
        #   copy              copy to clipboard
        #   save <path>       save to file
        #   copysave <path>   copy to clipboard and save to file
        #
        # target:
        #   area    select an area interactively with the mouse
        #   active  capture the currently focused window
        #   screen  capture the entire screen

        # Super + Print: capture selected area and copy to clipboard and save to ~/Pictures/Screenshots with timestamp
        "$mod, Print, exec, grimblast copysave area ~/Pictures/Screenshots/Screenshot_%Y%m%d_%H%M%S%3N.png"
        # Print: capture selected area and copy to clipboard
        ", Print, exec, grimblast copy area"

        # Super + Ctrl + Print: capture active window and copy to clipboard and save to ~/Pictures/Screenshots with timestamp
        "$mod CTRL, Print, exec, grimblast copysave active ~/Pictures/Screenshots/Screenshot_%Y%m%d_%H%M%S%3N.png"
        # Ctrl + Print: capture active window and copy to clipboard
        "CTRL, Print, exec, grimblast copy active"

        # Super + Shift + Print: capture entire screen and copy to clipboard and save to ~/Pictures/Screenshots with timestamp
        "$mod SHIFT, Print, exec, grimblast copysave screen ~/Pictures/Screenshots/Screenshot_%Y%m%d_%H%M%S%3N.png"
        # Shift + Print: capture entire screen and copy to clipboard
        "SHIFT, Print, exec, grimblast copy screen"
      ];

      # bindel:
      #   e: repeat when the key is held down
      #   l: also work when an input inhibitor (e.g. lockscreen) is active
      bindel = [
        # Volume control: up / down by 1%
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        # Microphone volume control: up / down by 1%
        "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+"
        "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-"
        # Brightness control: up / down by 5%
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      # bindl:
      #   l: also work when an input inhibitor (e.g. lockscreen) is active
      bindl = [
        # Mute audio
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        # Mute microphone
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      # Mouse bindings
      # Ref: https://wiki.hypr.land/Configuring/Binds/#mouse-binds
      bindm = [
        # Super + Left Click: move window
        "$mod, mouse:272, movewindow"
        # Super + Right Click: resize window
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
