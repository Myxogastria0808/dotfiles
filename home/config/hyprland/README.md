# Hyprland Configuration Reference

> **Config files:** `home/config/hyprland/default.nix`, `home/config/hyprland/rofi.nix`, `home/config/hyprland/waybar.nix`

---

## Table of Contents

- [Variables](#variables)
- [Environment Variables](#environment-variables)
- [Misc](#misc)
- [Keybindings](#keybindings)
  - [Window Management](#window-management)
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

---

## Environment Variables

Set via Hyprland's `env` block and propagated to the entire systemd user session (via UWSM).

| Variable                       | Value      | Description                                                                    |
| ------------------------------ | ---------- | ------------------------------------------------------------------------------ |
| `XDG_CURRENT_DESKTOP`          | `Hyprland` | Advertises the current desktop to apps                                         |
| `XDG_SESSION_TYPE`             | `wayland`  | Tells apps the session is Wayland                                              |
| `XDG_SESSION_DESKTOP`          | `Hyprland` | Used by some portals / session managers                                        |
| `MOZ_ENABLE_WAYLAND`           | `1`        | Firefox runs natively on Wayland (avoids XWayland freeze/crash issues)         |
| `ELECTRON_OZONE_PLATFORM_HINT` | `auto`     | Electron apps (Discord, VSCode, …) prefer Wayland; falls back to X11 if needed |

> **Note:** The three XDG variables are also set automatically by UWSM, so their presence here is largely redundant but harmless.

---

## Misc

| Option                       | Value  | Description                                                                                                        |
| ---------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------ |
| `misc.vfr`                   | `true` | Variable frame rate — reduces GPU/CPU usage when no animation is running, preventing starvation of other processes |
| `misc.disable_hyprland_logo` | `true` | Hides the Hyprland logo on the background                                                                          |

---

## Keybindings

### Window Management

| Key         | Action                 |
| ----------- | ---------------------- |
| `Super + Q` | Close active window    |
| `Super + M` | Exit Hyprland (logout) |
| `Super + F` | Toggle fullscreen      |
| `Super + T` | Toggle floating mode   |

### Application Launcher

| Key             | Action                   |
| --------------- | ------------------------ |
| `Super + Space` | Open app launcher (rofi) |

### Utilities

| Key             | Action                                                         |
| --------------- | -------------------------------------------------------------- |
| `Super + Enter` | Open terminal (ghostty)                                        |
| `Super + B`     | Open browser (firefox)                                         |
| `Super + E`     | Open file manager (dolphin)                                    |
| `Super + D`     | Open Discord                                                   |
| `Super + V`     | Open clipboard history picker (cliphist + rofi)                |
| `Super + C`     | Open color picker (hyprpicker) — result is copied to clipboard |

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

| Key                     | Target        | Action                                   |
| ----------------------- | ------------- | ---------------------------------------- |
| `Print`                 | Selected area | Copy to clipboard                        |
| `Super + Print`         | Selected area | Copy + save to `~/Pictures/Screenshots/` |
| `Ctrl + Print`          | Active window | Copy to clipboard                        |
| `Super + Ctrl + Print`  | Active window | Copy + save                              |
| `Shift + Print`         | Entire screen | Copy to clipboard                        |
| `Super + Shift + Print` | Entire screen | Copy + save                              |

### Volume & Brightness

`bindel` keys **repeat while held**. `bindl` keys **work on the lock screen** as well.

Both speaker and microphone volume feedback use `pantheon.elementary-sound-theme` (defined in `modules/app.nix`): speaker uses `audio-volume-change.wav`, microphone uses `bell.wav`.

| Key                            | Action                                                                 |
| ------------------------------ | ---------------------------------------------------------------------- |
| `XF86AudioRaiseVolume`         | Speaker volume +1% (with sound feedback)                               |
| `XF86AudioLowerVolume`         | Speaker volume -1% (with sound feedback)                               |
| `Shift + XF86AudioRaiseVolume` | Microphone volume +1% (with sound feedback + instant waybar refresh)   |
| `Shift + XF86AudioLowerVolume` | Microphone volume -1% (with sound feedback + instant waybar refresh)   |
| `XF86AudioMute`                | Toggle speaker mute (works on lock screen)                             |
| `XF86AudioMicMute`             | Toggle microphone mute + instant waybar refresh (works on lock screen) |
| `XF86MonBrightnessUp`          | Brightness +5%                                                         |
| `XF86MonBrightnessDown`        | Brightness -5%                                                         |

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

| Option           | Value                     | Description               |
| ---------------- | ------------------------- | ------------------------- |
| `rounding`       | `10`                      | Window corner radius (px) |
| `blur.enabled`   | `true`                    | Background blur enabled   |
| `blur.size`      | `3`                       | Blur radius               |
| `shadow.enabled` | `true`                    | Drop shadow enabled       |
| `shadow.range`   | `20`                      | Shadow spread range (px)  |
| `shadow.color`   | `rgba(70, 130, 180, 0.5)` | Shadow color (steel blue) |

---

## Animations

Custom bezier curve `myBezier (0.05, 0.9, 0.1, 1.05)` — gives a slight overshoot/bounce feel on window open.

Speed unit is **ds** (1 ds = 100 ms).

| Event        | Enabled | Speed | Curve    | Description                |
| ------------ | ------- | ----- | -------- | -------------------------- |
| `windows`    | ON      | 7     | myBezier | Window open animation      |
| `windowsOut` | ON      | 7     | default  | Window close animation     |
| `border`     | ON      | 10    | default  | Border color transition    |
| `fade`       | ON      | 7     | default  | Focus/workspace fade       |
| `workspaces` | ON      | 6     | default  | Workspace switch animation |

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
| `swww-daemon`                                  | Wallpaper daemon                        |
| `wl-paste --type text --watch cliphist store`  | Watch and store text clipboard entries  |
| `wl-paste --type image --watch cliphist store` | Watch and store image clipboard entries |
| `waybar`                                       | Start the status bar                    |

---

## Waybar

**Config file:** `home/config/hyprland/waybar.nix`

A top bar (height: 30px) with the following layout:

```
[Workspaces] [Window Title]    [Clock]    [BT] [CPU] [MEM] [BAT] [NET] [MIC] [VOL] [Tray] [PWR]
```

### Module Details

| Module       | Display                                                                 | Click Action                                |
| ------------ | ----------------------------------------------------------------------- | ------------------------------------------- |
| Workspaces   | Workspace numbers                                                       | Click to switch                             |
| Window Title | Active window title (max 50 chars)                                      | —                                           |
| Clock        | `YYYY-MM-DD HH:MM:SS`                                                   | Hover to show calendar                      |
| CPU          | `CPU XX%` (updates every 5s)                                            | —                                           |
| Memory       | `MEM XX%` (updates every 5s)                                            | —                                           |
| Battery      | `BAT XX%` / `CHG XX%` / `PLG XX%`<br>⚠ ≤30%: yellow, ≤15%: red         | —                                           |
| Network      | `WiFi (XX%)` / `ETH` / `No Network`<br>Hover: SSID + IP                 | —                                           |
| Mic          | `MIC XX%` / `MIC MUTE` (signal-based instant refresh; 1s poll fallback) | Left: toggle mute / Right: open pavucontrol |
| Volume       | `VOL XX%` / `VOL MUTE`                                                  | Click to open pavucontrol                   |
| Bluetooth    | `BT` / `BT OFF` / `BT {device}`<br>Connected: blue text                 | Click to open blueman-manager               |
| Power        | `PWR` (red)                                                             | Click to open wlogout (power menu)          |
| Tray         | System tray icons                                                       | —                                           |

### Style

- Font: monospace 13px
- Background: `rgba(26, 27, 38, 0.9)` (semi-transparent dark)
- Text color: `#cdd6f4` (Catppuccin Mocha text)

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
