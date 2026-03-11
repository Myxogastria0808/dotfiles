{ ... }:
{
  # ── KDE Plasma 6 ──────────────────────────────────────────────────────────────
  services.desktopManager.plasma6.enable = true;

  # KDE Connect - file transfer and notification sync with mobile devices (ports 1714-1764)
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
}
