{ ... }:
{
  # ── COSMIC Desktop (by System76) ──────────────────────────────────────────────
  # Wayland-native desktop environment. Intended to run as the sole active environment.
  # Running multiple environments simultaneously may cause conflicts.
  services.desktopManager.cosmic.enable = true;

  # Default session is derived automatically from desktopEnvironment (set in flake.nix).
  services.displayManager.defaultSession = "cosmic";

  services.displayManager.cosmic-greeter.enable = true;
}
