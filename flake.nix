{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-vscode-extentions
    # nix-vscode-extensions = {
    #   url = "github:nix-community/nix-vscode-extensions";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # rust
    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #nixvim
    nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    ## home-manager ##
    homeConfigurations = {
      myHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          # Enable unfee pkgs
          config.allowUnfree = true;
          # overlays = [
          #   inputs.rust-overlay.overlays.default
          # ];
        };
        extraSpecialArgs = {
          inherit inputs;
          # extensions = inputs.nix-vscode-extensions.extensions.x86_64-linux;
        };
        modules = [
          ./home/home.nix
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };
    };
    ## configuration.nix ##
    # nixosConfigurations.hostname
    # Replace nixos with your hostname
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; #sysytem arch param
        # NixOSシステム構成が定義されているモジュールのリスト
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
