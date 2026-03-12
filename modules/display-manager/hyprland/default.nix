{ inputs, pkgs, ... }:
{
  # ── Hyprland ──────────────────────────────────────────────────────────────────
  # Wayland compositor (tiling WM). Appears as a session option in SDDM
  # alongside KDE and COSMIC, so all three can coexist without conflict.
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Use UWSM for session management (recommended)
    xwayland.enable = true; # Allow X11 apps to run inside Hyprland
    # Use the flake input package to get the latest version
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # ── Wayland environment variables ─────────────────────────────────────────────
  # NOTE: When using UWSM, env vars set in hyprland.conf's `env` section are NOT
  # reliably propagated to child processes. Setting them here (NixOS system level)
  # via environment.sessionVariables ensures they are injected into the UWSM
  # graphical session and inherited by all apps (Firefox, Discord, etc.).
  # Ref: https://wiki.archlinux.org/title/Hyprland
  environment.sessionVariables = {
    # Force Firefox to use native Wayland rendering (prevents XWayland-induced freezes)
    MOZ_ENABLE_WAYLAND = "1";
    # Electron apps (Discord, VSCode, etc.): prefer Wayland, fall back to X11
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # NixOS Electron/Chromium wrappers: inject --ozone-platform=wayland at launch
    NIXOS_OZONE_WL = "1";
    # Disable DRM format modifiers for Intel iGPU.
    # Hyprland's aquamarine backend can deadlock on DRM modifier negotiation
    # with Intel i915, causing the compositor to freeze when Electron apps
    # (Discord) rapidly submit new Wayland buffers (e.g. typing indicators).
    # AQ_NO_MODIFIERS = "1";
  };
}
