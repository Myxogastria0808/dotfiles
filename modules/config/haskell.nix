{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # IHP (Integrated Haskell Platform) - full-stack Haskell web framework
    # Ref: https://ihp.digitallyinduced.com
    ihp-new
  ];
}
