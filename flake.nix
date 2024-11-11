{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # default nixvim
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nixvim
    # GitHub:https://github.com/dc-tec/nixvim
    nixvim.url = "github:dc-tec/nixvim";
    # nixvim
    # GitHub:https://github.com/fred-drake/neovim
    # nixvim.url = "github:fred-drake/neovim#";
    # nix-vscode-extentions
    # nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # rust
    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # plasma-manager
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    #NUR
    nur.url = "github:nix-community/NUR";
    #Zen Browser
    #GitHub:https://github.com/MarceColl/zen-browser-flake
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    #nix-gaming
    #GitHub:https://github.com/fufexan/nix-gaming?tab=readme-ov-file
    # nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = inputs: {
    ## home-manager ##
    homeConfigurations = {
      myHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          # Enable unfee pkgs
          config.allowUnfree = true;
          overlays = [
            inputs.nur.overlay
            #   inputs.rust-overlay.overlays.default
          ];
        };
        extraSpecialArgs = {
          inherit inputs;
          username = "hello";
        };
        modules = [
          ./home/home.nix
          # inputs.nixvim.homeManagerModules.nixvim
          inputs.plasma-manager.homeManagerModules.plasma-manager
        ];
      };
    };
    ## configuration.nix ##
    # nixosConfigurations.hostname
    # Replace nixos with your hostname
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # sysytem arch param
        # NixOSシステム構成が定義されているモジュールのリスト
        modules = [
          ./nixos/configuration.nix
          inputs.nur.nixosModules.nur
        ];
      };
      extraSpecialArgs = {
        inherit inputs;
        username = "hello";
      };
    };
  };
}
