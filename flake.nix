{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Zen Browser
    # GitHub Repository: https://github.com/MarceColl/zen-browser-flake
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    # nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-25.05";
      #* Configured nixvim *#
      # GitHub Repository: https://github.com/dc-tec/nixvim
      # url = "github:dc-tec/nixvim";
    };
  };

  outputs =
    inputs:
    let
      # System
      system = "x86_64-linux";
      # Username
      username = "hello";
      # GitHub username
      githubUsername = "Myxogastria0808";
      # GitHub email
      githubEmail = "r.rstudio.c@gmail.com";
      # NixosModules entrypoint
      baseModules = [
        ./nixos/configuration.nix
      ];
      nixosModules = [
        ./modules/app.nix
        inputs.nixvim.nixosModules.nixvim
      ];
    in
    {
      ## home-manager ##
      homeConfigurations = {
        myHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = system;# System architecture parameter
            # Enable unfree pkgs
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit inputs;
            username = username;
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
          system = system; # System architecture parameter
          # Module configurations
          modules = baseModules ++ nixosModules;
          specialArgs = {
            inherit inputs;
            username = username;
            githubUsername = githubUsername;
            githubEmail = githubEmail;
          };
        };
      };
    };
}
