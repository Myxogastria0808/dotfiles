{ pkgs, lib, ... }:
{
  # ── xdg-desktop-portal-hyprland override ──────────────────────────────────────
  # v1.3.11 has a destructor bug (SIGSEGV in CCWlOutput::~CCWlOutput) that triggers
  # on every `hm` switch. Override with latest git until a fix is released.
  nixpkgs.overlays = [
    (final: prev: {
      xdg-desktop-portal-hyprland = prev.xdg-desktop-portal-hyprland.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "hyprwm";
          repo = "xdg-desktop-portal-hyprland";
          rev = "906d0ac159803a7df2dc1f948df9327670380f69";
          hash = "sha256-XhnY0aRuDo5LT8pmJVPofPOgO2hAR7T+XRoaQxtNPzQ=";
        };
        version = "1.3.11-unstable-2026-03-14";
      });
    })
  ];


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
  };

  # ── Wayland environment variables ─────────────────────────────────────────────
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
    # NixOS Electron/Chromium wrappers: inject --ozone-platform=wayland at launch
    NIXOS_OZONE_WL = "1";
  };
}
