{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #ghostty
    ghostty.url = "github:ghostty-org/ghostty";
    #Zen Browser
    #GitHub:https://github.com/MarceColl/zen-browser-flake
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    # nixvim
    # GitHub:https://github.com/dc-tec/nixvim
    nixvim.url = "github:dc-tec/nixvim";
    # nixvim
    # GitHub:https://github.com/fred-drake/neovim
    # nixvim.url = "github:fred-drake/neovim#";
  };

  outputs =
    inputs:
    let
      baseModules = [
        ./nixos/configuration.nix
      ];
      nixosModules = [
        ./modules/app.nix
      ];
    in
    {
      ## home-manager ##
      homeConfigurations = {
        myHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            # Enable unfree pkgs
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit inputs;
            username = "hello";
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
          system = "x86_64-linux"; # system arch param
          # NixOSシステム構成が定義されているモジュールのリスト
          modules = baseModules ++ nixosModules;
        };
      };
    };
}
