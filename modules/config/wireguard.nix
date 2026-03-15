{ pkgs, wireGuardVPNConfigFilePath, ... }:
{
  # ── WireGuard VPN ─────────────────────────────────────────────────────────────
  # Fast, modern peer-to-peer VPN built into the Linux kernel. Imported
  # conditionally by modules/app.nix when enableWireGuard = true in flake.nix.
  #
  # Set wireGuardVPNConfigFilePath in flake.nix to the path of your .conf file.
  #
  # WARNING: The .conf file contains private keys and peer secrets.
  #   - Never commit it to this repository or any public repository.
  #   - Keep it outside the dotfiles directory (e.g. ~/Documents/my-vpn.conf).
  #
  # NOTE: NixOS evaluates the config file path at build time. If the file does
  #   not exist yet (e.g. during nixos-install), set enableWireGuard = false
  #   until the home directory has been created.
  networking.wg-quick.interfaces.wg0.configFile = "${wireGuardVPNConfigFilePath}";

  # WireGuard CLI tools (wg, wg-quick)
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  # ── Firewall ──────────────────────────────────────────────────────────────────
  # Open the standard WireGuard UDP port
  networking.firewall.allowedUDPPorts = [ 51820 ];
}
