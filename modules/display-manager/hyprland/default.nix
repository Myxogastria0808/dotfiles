{ ... }:
{
  # ── Hyprland ──────────────────────────────────────────────────────────────────
  # Wayland compositor (tiling WM). Appears as a session option in SDDM
  # alongside KDE and COSMIC, so all three can coexist without conflict.
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Use UWSM for session management (recommended)
    xwayland.enable = true; # Allow X11 apps to run inside Hyprland
  };
}
