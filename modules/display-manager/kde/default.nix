{ pkgs, ... }:
{
  # ── KDE Plasma 6 ──────────────────────────────────────────────────────────────
  # X11/Wayland desktop environment. Intended to run as the sole active environment.
  # Running multiple environments simultaneously may cause conflicts.
  # To switch environments, edit the imports in modules/display-manager/default.nix,
  # and comment out ./config/hyprland in home/apps.nix when switching away from Hyprland.
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    # Color picker for KDE
    kdePackages.kcolorchooser
    # KDE Connect - file transfer and notification sync with Android devices
    kdePackages.kdeconnect-kde
  ];

  # KDE Connect - file transfer and notification sync with mobile devices (ports 1714-1764)
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
}
