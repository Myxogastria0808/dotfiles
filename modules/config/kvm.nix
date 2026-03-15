{ username, ... }:
{
  # ── KVM / QEMU ────────────────────────────────────────────────────────────────
  # Kernel-based virtual machine with virt-manager GUI.
  # Ref: https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;

  # USB passthrough from host to virtual machines via SPICE
  virtualisation.spiceUSBRedirection.enable = true;

  # GUI for creating and managing KVM/QEMU virtual machines
  # User group access (libvirtd) managed in nixos/configuration.nix.
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ username ];
}
