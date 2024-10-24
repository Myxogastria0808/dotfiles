# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ # In clude the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix = {
    settings = {
      auto-optimise-store = true; # optimise Nix store
      # Enable flakes
      # nix-command ... flakes requires nix-command
      #nix-command is a new CLI of Nix.
      experimental-features = ["nix-command" "flakes"];
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
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


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

  # Enable fcitx5-mozc
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
  };

  # Fonts
  fonts = {
    fonts = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
    ];
    fontDir.enable = true;
    fontconfig = {
    defaultFonts = {
        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
        sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.defaultSession = "plasmax11";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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
  hardware.pulseaudio.enable = false; # change to pipewire
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  # Disable change password from command.
  users.mutableUsers = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hello = {
    isNormalUser = true;
    description = "hello";
    # Genarate following commacnd: mkpasswd -m sha-512
    initialHashedPassword="$6$DEgxVwM7CWGRVNK6$f/ATlexID21R3DJ7NfQEbnvZ3dakf1Ejro5yPimllGLg2zUqJ5aCjuBxF4QaXOLnXoPc46n.7WLXZmBnuInZ81";
    # Add users (this user name: hello) to the docker group
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    # default terminal
    shell = "/run/current-system/sw/bin/zsh";
  };
  # Add users to vboxusers group
  users.extraGroups.vboxusers.members = [ "hello" ];

  # Enable flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true; # require flatpak

  # Enable pkgs
  programs = {
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git.enable = true;
    zsh.enable = true;
  };
  # Enable OpenGL
  hardware.opengl.enable = true;

  # Enable TailScale
  services.tailscale.enable = true;

  virtualisation = {
    # Enable docker
    docker.enable = true;
    # Enable vmware
    vmware.host.enable = true;
    # Enable waydroid
    waydroid.enable = true;
    # Enable virtualbox
    virtualbox.host.enable = true;
    # Enable virtualbox guest additions
    virtualbox.guest.enable = true;
    virtualbox.guest.dragAndDrop = true;
  };

  # Install pkgs to system
  environment.systemPackages = with pkgs; [
    home-manager
    tailscale # VPN
    fprintd-tod # require fingerprint
    kdePackages.kdeconnect-kde # KDE connect
    appimage-run # require appimage
  ];

  # Enable fingerprint
  # services.fprintd = {
  #   enable = true;
  #   package = pkgs.fprintd-tod;
  #   tod = {
  #     enable = true;
  #     driver = pkgs.libfprint-2-tod1-vfs0090;
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable openssh.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    # trust virtual NIC od TailScale
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [config.services.tailscale.port];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # require KDE connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # require KDE connect
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
