{ pkgs, ... } : {
  environment.systemPackages = with pkgs; [
    stack
    haskell-language-server
  ];
  # Binary Cache for haskell.nix
  # nix.settings = {
  #   trusted-public-keys = [
  #     "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  #   ];
  #   substituters = [
  #     "https://cache.iog.io"
  #   ];
  # };
}
