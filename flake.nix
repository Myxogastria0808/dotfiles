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
    nixvimConfig.url = "github:Myxogastria0808/nix-flakes-nixvim/main";
  };

  outputs =
    inputs:
    let
      # System
      systems = "x86_64-linux";
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
      ];
    in
    {
      ## home-manager ##
      homeConfigurations = {
        myHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = systems;# System architecture parameter
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
          system = systems; # System architecture parameter
          # Module configurations
          modules = baseModules ++ nixosModules ++ [
            ({ pkgs, inputs, ... }: {
              environment.systemPackages = [
                inputs.nixvimConfig.packages.x86_64-linux.default
              ];
            })
          ];
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
