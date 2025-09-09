{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # IHP (Integrated Haskell Platform)
    # https://ihp.digitallyinduced.com
    ihp-new
  ];
}