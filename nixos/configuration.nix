# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  username,
  ...
}:
{
  imports = [
    # In clude the results of the hardware scan.
    ./hardware-configuration.nix
    # ./disko-config.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  # Cleanup /tmp
  boot.tmp.cleanOnBoot = true;

  nix = {
    settings = {
      auto-optimise-store = true; # optimise Nix store
      # Enable flakes
      # nix-command ... flakes requires nix-command
      #nix-command is a new CLI of Nix.
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    #Automate GC
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Enable unfree pkgs
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos"; # Define your hostname.

  services.resolved.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set resolvconf.conf
  networking.resolvconf.extraConfig = "name_servers=1.1.1.1";

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable fcitx5
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-skk
      ];
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasmax11";
  # Enable XWayland
  programs.xwayland.enable = true;
  xdg.portal ={
    enable = true; # require flatpak
    # Reference: https://search.nixos.org/options?channel=25.05&show=xdg.portal.extraPortals&query=xdg.portal
    # List of additional portals to add to path.
    # Portals allow interaction with system, like choosing files or taking screenshots.
    # At minimum, a desktop portal implementation should be listed.
    # GNOME and KDE already adds xdg-desktop-portal-gtk; and xdg-desktop-portal-kde respectively.
    # On other desktop environments you probably want to add them yourself.
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-gtk
    # ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Audio
  # Enable sound with pipewire.
  services.pulseaudio.enable = false; # change to pipewire
  security.rtkit.enable = true; # require pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # Reduce noise application
  programs = {
    noisetorch.enable = true;
  };

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  # Disable change password from command.
  users.mutableUsers = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    # Genarate following commacnd: mkpasswd -m sha-512
    initialHashedPassword = "$6$DEgxVwM7CWGRVNK6$f/ATlexID21R3DJ7NfQEbnvZ3dakf1Ejro5yPimllGLg2zUqJ5aCjuBxF4QaXOLnXoPc46n.7WLXZmBnuInZ81";
    # Add users (this user name: ${username}) to the docker group
    extraGroups = [
      "networkmanager"
      "wheel"
      "flatpak"
      "incus-admin"
    ];
    # default terminal
    shell = "/run/current-system/sw/bin/zsh";
  };
  # Add users to vboxusers group
  users.extraGroups.vboxusers.members = [
    "${username}"
    "docker"
    "libvirtd"
  ];

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Enable TailScale
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [
    # VPN
    tailscale
  ];

  virtualisation = {
    # Enable docker
    docker.enable = true;
    # Enable waydroid
    waydroid.enable = true;
    # Enable Incus
    incus.enable = true;
  };

  # Enable KVM
  # https://nixos.wiki/wiki/Virt-manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "hello" ];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # Enable fingerprint
  # services.fprintd = {
  #   enable = true;
  #   package = pkgs.fprintd-tod;
  #   tod = {
  #     enable = true;
  #     driver = pkgs.libfprint-2-tod1-vfs0090;
  #   };
  # };

  # Enable openssh.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    trustedInterfaces = [
      "tailscale0" # trust virtual NIC of TailScale
      "incusbr0" # trust virtual NIC of Incus
    ];
    allowedUDPPorts = [
      config.services.tailscale.port # require TailScale
      51820 # require WireGuard
    ];
    # require KDE connect
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
  # Set WireGuard config
  networking.wg-quick.interfaces.wg0.configFile = "/home/hello/Documents/Myxogastria0808-NixOS.conf";
  # require Incus
  networking.nftables.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
