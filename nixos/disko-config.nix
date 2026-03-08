{
  # Declarative disk partitioning configuration via Disko
  # Ref: https://github.com/nix-community/disko
  #
  # Partition layout for /dev/nvme0n1:
  #   ESP       500M   vfat    /boot   (EFI System Partition)
  #   root      100%   ext4    /       (remaining space)
  #   plainSwap 8G     swap            (hibernation + memory overflow)
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # EFI System Partition - required for UEFI boot
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077" # Restrict read/write access to root only
                  "dmask=0077"
                ];
              };
            };
            # Root partition - takes all remaining disk space after ESP and swap
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            # Swap partition - used for hibernation and as memory overflow
            plainSwap = {
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both"; # Enable TRIM for both sync and async discard
                resumeDevice = true; # Resume from hibernation from this device
              };
            };
          };
        };
      };
    };
  };
}
