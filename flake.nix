{
  inputs = {
    # Package collection - nixpkgs-unstable for latest packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # User environment manager - pinned to the same nixpkgs to avoid duplication
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim configuration from a separate external flake
    # Ref: https://github.com/Myxogastria0808/nix-flakes-nixvim
    nixvimConfig.url = "github:Myxogastria0808/nix-flakes-nixvim/main";
  };

  outputs =
    inputs:
    let
      systems = "x86_64-linux"; # Target architecture
      username = "hello";
      githubUsername = "Myxogastria0808";
      githubEmail = "r.rstudio.c@gmail.com";
      # Active desktop environment — change this single value to switch environments.
      # Valid options: "hyprland" | "kde" | "cosmic"
      # NOTE: After changing, run both `nixos` and `hm` to apply.
      desktopEnvironment = "hyprland";

      # ── Optional services ──────────────────────────────────────────────────────
      # Set to true/false to enable or disable each service system-wide.
      # After changing, run `nixos` to apply.
      enableTailscale = true; # Zero-config mesh VPN (run `sudo tailscale up` after first enable)
      enableWireGuard = true; # WireGuard VPN — also set wireGuardVPNConfigFilePath below
      # Path to the WireGuard .conf file (private keys — never commit this file).
      # Only read when enableWireGuard = true.
      wireGuardVPNConfigFilePath = "/home/hello/Documents/Myxogastria0808-NixOS.conf";

      # NixOS base system configuration (boot, hardware, networking, services)
      baseModules = [
        ./nixos/configuration.nix
      ];

      # NixOS application and tool modules (packages, shell, fonts, i18n, etc.)
      nixosModules = [
        ./modules/app.nix
      ];
    in
    {
      # ── home-manager ──────────────────────────────────────────────────────────
      # User-level configuration, intentionally independent from NixOS
      homeConfigurations = {
        myHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = systems;
            config.allowUnfree = true; # Allow non-free packages
          };
          extraSpecialArgs = {
            inherit inputs;
            username = username;
            desktopEnvironment = desktopEnvironment;
          };
          modules = [
            ./home/home.nix
          ];
        };
      };

      # ── NixOS ─────────────────────────────────────────────────────────────────
      # Replace "nixos" with your hostname if different from the default
      nixosConfigurations = {
        nixos = inputs.nixpkgs.lib.nixosSystem {
          system = systems;
          # Merge base config, app modules, and nixvim from the external flake
          modules =
            baseModules
            ++ nixosModules
            ++ [
              # NixVim module from the external flake
              (
                { pkgs, inputs, ... }:
                {
                  environment.systemPackages = [
                    inputs.nixvimConfig.packages.${systems}.default
                  ];
                }
              )
            ];
          specialArgs = {
            inherit inputs;
            username = username;
            githubUsername = githubUsername;
            githubEmail = githubEmail;
            wireGuardVPNConfigFilePath = wireGuardVPNConfigFilePath;
            desktopEnvironment = desktopEnvironment;
            enableTailscale = enableTailscale;
            enableWireGuard = enableWireGuard;
          };
        };
      };
    };
}
