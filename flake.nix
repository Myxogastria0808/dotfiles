{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # plasma-manager
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    #ghostty
    ghostty.url = "github:ghostty-org/ghostty";
    #NUR
    nur.url = "github:nix-community/NUR";
    #Zen Browser
    #GitHub:https://github.com/MarceColl/zen-browser-flake
    zen-browser.url = "github:MarceColl/zen-browser-flake";
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
    # nix-vscode-extensions
    # nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    #nix-gaming
    #GitHub:https://github.com/fufexan/nix-gaming?tab=readme-ov-file
    # nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs =
    inputs:
    let
      baseModules = [
        ./nixos/configuration.nix
        inputs.nur.modules.nixos.default
      ];
      nixosModules = [
        ./modules/app.nix
        ./modules/language.nix
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
            overlays = [
              inputs.nur.overlays.default
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
          system = "x86_64-linux"; # system arch param
          # NixOSシステム構成が定義されているモジュールのリスト
          modules = baseModules ++ nixosModules;
        };
      };
    };
}
