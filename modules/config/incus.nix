{ pkgs, ... }:
{
  # ── Incus ─────────────────────────────────────────────────────────────────────
  # System container and VM manager (LXD community fork).
  # Web UI accessible at https://localhost:8443 after enabling.
  # User group access managed in configuration.nix.
  virtualisation.incus = {
    enable = true;
    ui.enable = true;
  };

  # Incus web UI package (served by the Incus daemon itself)
  environment.systemPackages = with pkgs; [ incus-ui-canonical ];

  # ── Firewall ──────────────────────────────────────────────────────────────────
  # Trust all traffic on the Incus bridge NIC for container networking
  networking.firewall.trustedInterfaces = [ "incusbr0" ];

  # nftables is required by Incus — it uses nftables instead of iptables
  # for container network rules and cannot fall back to iptables
  networking.nftables.enable = true;
}
