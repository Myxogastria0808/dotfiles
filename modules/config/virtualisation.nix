{ username, ... }:
{
  virtualisation = {
    docker.enable = true;
    waydroid.enable = true; # Run Android apps on Linux via a container
    incus = {
      enable = true;
      ui.enable = true; # Enable the Incus web UI (accessible at https://localhost:8443)
    };
    # KVM / QEMU (used by virt-manager)
    # Ref: https://nixos.wiki/wiki/Virt-manager
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true; # USB passthrough support for virtual machines
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ username ];

  # Required for VirtualBox USB devices, Docker socket, and libvirt management
  users.extraGroups.vboxusers.members = [
    username
    "docker"
    "libvirtd"
  ];
}
