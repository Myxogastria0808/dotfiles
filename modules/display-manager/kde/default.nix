{ pkgs, ... }:
{
  # ── KDE Plasma 6 ──────────────────────────────────────────────────────────────
  # X11/Wayland desktop environment. Intended to run as the sole active environment.
  # Running multiple environments simultaneously may cause conflicts.
  # To switch environments, change `desktopEnvironment` in flake.nix and run `nixos && hm`.
  # The display-manager module selection and home-manager Hyprland config are handled automatically.
  services.desktopManager.plasma6.enable = true;

  # Default session is derived automatically from desktopEnvironment (set in flake.nix).
  services.displayManager.defaultSession = "plasma";

  # SDDM is the display manager — only one environment should be active at a time
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
  };

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
