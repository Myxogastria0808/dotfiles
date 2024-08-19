{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
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
        };
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home/home.nix
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
