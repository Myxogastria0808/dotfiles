{ config, pkgs, ... }:
{
  # ── Tailscale ─────────────────────────────────────────────────────────────────
  # Zero-config mesh VPN that connects devices across networks without port
  # forwarding. Imported conditionally by modules/app.nix when enableTailscale = true
  # in flake.nix.
  #
  # After first enable, run: sudo tailscale up
  services.tailscale.enable = true;

  # Tailscale CLI (tailscale up, tailscale status, etc.)
  environment.systemPackages = with pkgs; [ tailscale ];

  # ── Firewall ──────────────────────────────────────────────────────────────────
  # Trust all traffic on the Tailscale virtual NIC (fully-meshed, encrypted)
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  # Allow the Tailscale coordination UDP port (assigned dynamically by the service)
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];
}
