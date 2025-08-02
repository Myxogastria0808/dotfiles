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
    # GitHub Repository: https://github.com/dc-tec/nixvim
    nixvim.url = "github:dc-tec/nixvim";
    # nixvim
    # GitHub Repository: https://github.com/fred-drake/neovim
    # nixvim.url = "github:fred-drake/neovim#";
  };

  outputs =
    inputs:
    let
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
            system = "x86_64-linux";
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
          system = "x86_64-linux"; # system arch param
          # NixOSシステム構成が定義されているモジュールのリスト
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
