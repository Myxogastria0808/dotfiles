{ pkgs, ... }:
{
  # ── Qt Wayland Support ────────────────────────────────────────────────────────
  # Required for Qt apps (LibreOffice, QGIS, etc.) to render natively on Wayland
  # instead of falling back to XWayland under Hyprland.
  # Ref: https://wiki.hypr.land/Useful-Utilities/Must-have/
  environment.systemPackages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
  ];

  # ── Hyprland ──────────────────────────────────────────────────────────────────
  # Wayland compositor (tiling WM). Appears as a session option in SDDM
  # alongside KDE and COSMIC, so all three can coexist without conflict.
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Use UWSM for session management (recommended)
    xwayland.enable = true; # Allow X11 apps to run inside Hyprland
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # ── Wayland environment variables ─────────────────────────────────────────────
  # NOTE: When using UWSM, env vars set in hyprland.conf's `env` section are NOT
  # reliably propagated to child processes. Setting them here (NixOS system level)
  # via environment.sessionVariables ensures they are injected into the UWSM
  # graphical session and inherited by all apps (Firefox, Discord, etc.).
  # Ref: https://wiki.archlinux.org/title/Hyprland
  environment.sessionVariables = {
    # ── XDG Desktop Specifications ──────────────────────────────────────────
    # NOTE: UWSM users may not need these — UWSM sets them automatically at session start.
    #       Keeping them explicit here is harmless and ensures correctness without UWSM.
    # Ref: https://wiki.hypr.land/Configuring/Environment-variables/#xdg-specifications
    #
    # Tells apps (e.g. portals, tray) which DE is running.
    # XDG_CURRENT_DESKTOP = "Hyprland";
    # Marks the session as Wayland (not X11). Required by some apps to opt in.
    # XDG_SESSION_TYPE = "wayland";
    # Used by systemd/logind and xdg-desktop-portal to select the right portal backend.
    # XDG_SESSION_DESKTOP = "Hyprland";

    # ── Wayland rendering hints ───────────────────────────────────────────────
    # Force Firefox to use native Wayland rendering (prevents XWayland-induced freezes)
    MOZ_ENABLE_WAYLAND = "1";
    # Electron apps (Discord, VSCode, etc.): prefer Wayland, fall back to X11
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # NixOS Electron/Chromium wrappers: inject --ozone-platform=wayland at launch
    NIXOS_OZONE_WL = "1";
  };
}
