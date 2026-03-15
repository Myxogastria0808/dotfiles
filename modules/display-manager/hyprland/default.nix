{ pkgs, ... }:
{
  # ── Hyprland ──────────────────────────────────────────────────────────────────
  # Wayland compositor (tiling WM). Currently the sole active desktop environment.
  # Each environment (KDE, COSMIC, Hyprland) is intended to run independently.
  # Running multiple environments simultaneously may cause conflicts.
  # To switch environments, change `desktopEnvironment` in flake.nix and run `nixos && hm`.
  # The display-manager module selection and home-manager Hyprland config are handled automatically.
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Use UWSM for session management (recommended)
    xwayland.enable = true; # Allow X11 apps to run inside Hyprland
  };

  # ── Qt Wayland Support ────────────────────────────────────────────────────────
  # Required for Qt apps (LibreOffice, QGIS, etc.) to render natively on Wayland
  # instead of falling back to XWayland under Hyprland.
  # Ref: https://wiki.hypr.land/Useful-Utilities/Must-have/
  environment.systemPackages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
  ];

  # ── Wayland environment variables ─────────────────────────────────────────────
  environment.sessionVariables = {
    # ── XDG Desktop Specifications ──────────────────────────────────────────
    # NOTE: UWSM users may not need these — UWSM sets them automatically at session start.
    #       Keeping them explicit here is harmless and ensures correctness without UWSM.
    # Ref: https://wiki.hypr.land/Configuring/Environment-variables/#xdg-specifications
    #
    # Tells apps (e.g. portals, tray) which DE is running.
    XDG_CURRENT_DESKTOP = "Hyprland";
    # Marks the session as Wayland (not X11). Required by some apps to opt in.
    XDG_SESSION_TYPE = "wayland";
    # Used by systemd/logind and xdg-desktop-portal to select the right portal backend.
    XDG_SESSION_DESKTOP = "Hyprland";

    # ── Wayland rendering hints ───────────────────────────────────────────────
    # NixOS Electron/Chromium wrappers: inject --ozone-platform=wayland at launch
    NIXOS_OZONE_WL = "1";
  };
}
