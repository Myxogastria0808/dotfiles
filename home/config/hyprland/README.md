# Hyprland Configuration Reference

> **Config files:** `home/config/hyprland/default.nix`, `home/config/hyprland/rofi/default.nix`, `home/config/hyprland/waybar/default.nix`, `home/config/hyprland/swaync/default.nix`

> [!WARNING]
> Always launch Hyprland via the **`hyprland-uwsm`** session in SDDM. The standalone `hyprland` session (without UWSM) is also registered automatically by the NixOS module and will appear in the SDDM session list, but it bypasses UWSM entirely. **Its stability is not guaranteed and it is not supported by this dotfiles.**

---

## Table of Contents

- [Variables](#variables)
- [Environment Variables](#environment-variables)
- [Keybindings](#keybindings)
  - [Window Management](#window-management)
  - [Utilities](#utilities)
  - [Application Launcher](#application-launcher)
  - [Focus Movement](#focus-movement)
  - [Window Movement](#window-movement)
  - [Switch Workspace](#switch-workspace)
  - [Move Window to Workspace](#move-window-to-workspace)
  - [Screenshots](#screenshots)
  - [Volume & Brightness](#volume--brightness)
  - [Mouse Bindings](#mouse-bindings)
- [Appearance](#appearance)
- [Animations](#animations)
- [Input](#input)
- [Layout](#layout)
- [Autostart](#autostart)
- [Notifications](#notifications)
- [Waybar](#waybar)
- [Bundled Tools](#bundled-tools)

---

## Variables

| Variable       | Value     | Description       |
| -------------- | --------- | ----------------- |
| `$mod`         | `SUPER`   | Modifier key      |
| `$terminal`    | `ghostty` | Terminal emulator |
| `$browser`     | `firefox` | Web browser       |
| `$fileManager` | `dolphin` | File manager      |
| `$discord`     | `discord` | Discord client    |

---

## Environment Variables

Set via NixOS `environment.sessionVariables` in `modules/display-manager/hyprland/default.nix` and propagated to the entire systemd user session (via UWSM).

| Variable              | Value      | Description                                                                  |
| --------------------- | ---------- | ---------------------------------------------------------------------------- |
| `XDG_CURRENT_DESKTOP` | `Hyprland` | Tells apps (e.g. portals, tray) which DE is running                          |
| `XDG_SESSION_TYPE`    | `wayland`  | Marks the session as Wayland; required by some apps to opt in                |
| `XDG_SESSION_DESKTOP` | `Hyprland` | Used by systemd/logind and xdg-desktop-portal to select the portal backend   |
| `NIXOS_OZONE_WL`      | `1`        | NixOS Electron/Chromium wrappers inject `--ozone-platform=wayland` at launch |

> **Note:** Although UWSM sets `XDG_CURRENT_DESKTOP`, `XDG_SESSION_TYPE`, and `XDG_SESSION_DESKTOP` automatically at session start, they are also set explicitly here as a belt-and-suspenders measure to ensure correct values even if UWSM is not used.

---

## Keybindings

### Window Management

| Key         | Action                 |
| ----------- | ---------------------- |
| `Super + Q` | Close active window    |
| `Super + M` | Exit Hyprland (logout) |
| `Super + F` | Toggle fullscreen      |
| `Super + T` | Toggle floating mode   |

### Utilities

| Key             | Action                                                         |
| --------------- | -------------------------------------------------------------- |
| `Super + Enter` | Open terminal (ghostty)                                        |
| `Super + B`     | Open browser (firefox)                                         |
| `Super + E`     | Open file manager (dolphin)                                    |
| `Super + D`     | Open Discord                                                   |
| `Super + V`     | Open clipboard history picker (cliphist + rofi)                |
| `Super + C`     | Open color picker (hyprpicker) — result is copied to clipboard |

### Application Launcher

| Key             | Action                   |
| --------------- | ------------------------ |
| `Super + Space` | Open app launcher (rofi) |

### Focus Movement

Vim-style hjkl navigation.

| Key         | Direction |
| ----------- | --------- |
| `Super + H` | Left      |
| `Super + L` | Right     |
| `Super + K` | Up        |
| `Super + J` | Down      |

### Window Movement

Vim-style hjkl navigation.

| Key                 | Direction |
| ------------------- | --------- |
| `Super + Shift + H` | Left      |
| `Super + Shift + L` | Right     |
| `Super + Shift + K` | Up        |
| `Super + Shift + J` | Down      |

### Switch Workspace

| Key               | Action                  |
| ----------------- | ----------------------- |
| `Super + 1` – `9` | Switch to workspace 1–9 |
| `Super + 0`       | Switch to workspace 10  |

### Move Window to Workspace

Sends the active window to the specified workspace.

| Key                       | Action                |
| ------------------------- | --------------------- |
| `Super + Shift + 1` – `9` | Move to workspace 1–9 |
| `Super + Shift + 0`       | Move to workspace 10  |

### Screenshots

Uses [grimblast](https://github.com/hyprwm/contrib/tree/main/grimblast). `copysave` copies to clipboard **and** saves to `~/Pictures/Screenshots/` with a timestamp filename.

> **Note:** On Linux, `Shift+Print` generates the `Sys_Req` keysym, not `Print`. Bindings involving `Shift+Print` must use `Sys_Req` as the key name.

| Key             | Target        | Action                                   |
| --------------- | ------------- | ---------------------------------------- |
| `Print`         | Selected area | Copy to clipboard                        |
| `Super + Print` | Selected area | Copy + save to `~/Pictures/Screenshots/` |

### Volume & Brightness

`bindel` keys **repeat while held**. `bindl` keys **work on the lock screen** as well.

| Key                            | Action                               |
| ------------------------------ | ------------------------------------ |
| `XF86AudioRaiseVolume`         | Speaker volume +5%                   |
| `XF86AudioLowerVolume`         | Speaker volume -5%                   |
| `Shift + XF86AudioRaiseVolume` | Microphone volume +5%                |
| `Shift + XF86AudioLowerVolume` | Microphone volume -5%                |
| `XF86AudioMute`                | Toggle speaker mute (lock screen)    |
| `XF86AudioMicMute`             | Toggle microphone mute (lock screen) |
| `XF86MonBrightnessUp`          | Brightness +5%                       |
| `XF86MonBrightnessDown`        | Brightness -5%                       |

### Mouse Bindings

| Action                     | Effect        |
| -------------------------- | ------------- |
| `Super + Left click` drag  | Move window   |
| `Super + Right click` drag | Resize window |

> Dragging on borders or gaps also resizes windows (`resize_on_border = true`).

---

## Appearance

### General

| Option                | Value                                   | Description                                |
| --------------------- | --------------------------------------- | ------------------------------------------ |
| `gaps_in`             | `5`                                     | Gap between windows                        |
| `gaps_out`            | `10`                                    | Gap between windows and screen edge        |
| `border_size`         | `2`                                     | Border thickness (px)                      |
| `col.active_border`   | `rgba(33ccffee) → rgba(00ff99ee) 45deg` | Active window border (cyan→green gradient) |
| `col.inactive_border` | `rgba(595959aa)`                        | Inactive window border                     |
| `layout`              | `dwindle`                               | Tiling layout algorithm                    |
| `resize_on_border`    | `true`                                  | Allow resizing by dragging borders/gaps    |

### Decoration

| Option           | Value  | Description               |
| ---------------- | ------ | ------------------------- |
| `rounding`       | `10`   | Window corner radius (px) |
| `blur.enabled`   | `true` | Background blur enabled   |
| `blur.size`      | `3`    | Blur radius               |
| `shadow.enabled` | `true` | Drop shadow enabled       |
| `shadow.range`   | `20`   | Shadow spread range (px)  |

---

## Animations

Custom bezier curve `myBezier (0.05, 0.9, 0.1, 1.05)` — gives a slight overshoot/bounce feel on window open.

Speed unit is **ds** (1 ds = 100 ms). All values are tuned to be as short as possible while remaining perceptible.

| Event        | Enabled | Speed | Duration | Curve    | Description                |
| ------------ | ------- | ----- | -------- | -------- | -------------------------- |
| `windows`    | ON      | 3     | 300 ms   | myBezier | Window open animation      |
| `windowsOut` | ON      | 2     | 200 ms   | default  | Window close animation     |
| `border`     | ON      | 3     | 300 ms   | default  | Border color transition    |
| `fade`       | ON      | 3     | 300 ms   | default  | Focus/workspace fade       |
| `workspaces` | ON      | 3     | 300 ms   | default  | Workspace switch animation |

---

## Input

| Option                    | Value  | Description                                                          |
| ------------------------- | ------ | -------------------------------------------------------------------- |
| `kb_layout`               | `us`   | Keyboard layout                                                      |
| `sensitivity`             | `0`    | Mouse sensitivity (-1.0 to 1.0, 0 = no change)                       |
| `touchpad.natural_scroll` | `true` | Natural (reverse) scrolling                                          |
| `touchpad.tap_button_map` | `lrm`  | Tap-to-click: 1 finger = left, 2 fingers = right, 3 fingers = middle |

---

## Layout

Uses the `dwindle` layout (binary space partitioning).

| Option           | Value  | Description                                                     |
| ---------------- | ------ | --------------------------------------------------------------- |
| `pseudotile`     | `true` | Pseudo-tiling — windows behave like floating but stay in tiling |
| `preserve_split` | `true` | Keep the split direction when windows are added/removed         |

---

## Autostart

The following commands run once on Hyprland startup (`exec-once`).

| Command                                        | Description                             |
| ---------------------------------------------- | --------------------------------------- |
| `wl-paste --type text --watch cliphist store`  | Watch and store text clipboard entries  |
| `wl-paste --type image --watch cliphist store` | Watch and store image clipboard entries |
| `waybar`                                       | Start the status bar                    |

---

## Notifications

**Config file:** `home/config/hyprland/swaync/default.nix`

Uses [SwayNotificationCenter (swaync)](https://github.com/ErikReider/SwayNotificationCenter), a Wayland notification daemon compatible with libnotify.

> **Why a notification daemon is required:** Without a daemon listening on D-Bus, any app that calls libnotify (e.g. Discord on message receipt) will hang indefinitely waiting for a response, causing the app to appear frozen.

---

## Waybar

**Config file:** `home/config/hyprland/waybar/default.nix`

A top bar (height: 30px) with the following layout:

```
[Workspaces] [Window Title]    [Clock]    [BT] [CPU] [MEM] [BAT] [NET] [VOL] [Tray] [PWR]
```

### Module Details

| Module       | Display                                                         | Click Action                       |
| ------------ | --------------------------------------------------------------- | ---------------------------------- |
| Workspaces   | Workspace numbers                                               | Click to switch                    |
| Window Title | Active window title (max 50 chars)                              | —                                  |
| Clock        | `YYYY-MM-DD HH:MM:SS`                                           | Hover to show calendar             |
| CPU          | `CPU XX%` (updates every 5s)                                    | —                                  |
| Memory       | `MEM XX%` (updates every 5s)                                    | —                                  |
| Battery      | `BAT XX%` / `CHG XX%` / `PLG XX%`<br>⚠ ≤30%: yellow, ≤15%: red | —                                  |
| Network      | `WiFi (XX%)` / `ETH` / `No Network`<br>Hover: SSID + IP         | —                                  |
| Volume       | `VOL XX%` / `VOL MUTE`                                          | Click to open pavucontrol          |
| Bluetooth    | `BT` / `BT OFF` / `BT {device}`<br>Connected: blue text         | Click to open blueman-manager      |
| Power        | `PWR` (red)                                                     | Click to open wlogout (power menu) |
| Tray         | System tray icons                                               | —                                  |

### Style

- Font: monospace 13px
- Background: `rgba(26, 27, 38, 0.9)` (semi-transparent dark)
- Text color: `#cdd6f4` (Catppuccin Mocha text)

---

## Shell Helper

A shell function `hypr` is defined in `a.sh` at the repository root. It is intended to be appended into `.zshrc` (or `zsh.nix` `shellInit`). Once added, run `hypr` in any terminal to display a color-coded keybindings cheatsheet.

---

## Bundled Tools

Tools managed under `home.packages` in `default.nix`.

| Package         | Purpose                                            |
| --------------- | -------------------------------------------------- |
| `grimblast`     | Screenshot tool (grimshot wrapper)                 |
| `brightnessctl` | Brightness control                                 |
| `swww`          | Wallpaper manager with transition animations       |
| `cliphist`      | Clipboard history manager                          |
| `wl-clipboard`  | Wayland clipboard utilities (`wl-copy`/`wl-paste`) |
| `hyprpicker`    | Color picker                                       |
| `blueman`       | Bluetooth manager GUI                              |
| `wlogout`       | Power menu (logout / shutdown / reboot / lock)     |
