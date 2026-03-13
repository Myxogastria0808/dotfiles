{ ... }:
{
  # ── Mako ──────────────────────────────────────────────────────────────────────
  # Wayland notification daemon (libnotify-compatible).
  # Without a notification daemon running on D-Bus, any app that calls libnotify
  # (e.g. Discord on message receipt) will hang indefinitely waiting for a response,
  # causing the app to appear frozen.
  services.mako = {
    enable = true;
    settings = {
      # Dismiss after 5 seconds
      default-timeout = 5000;
    };
  };
}
