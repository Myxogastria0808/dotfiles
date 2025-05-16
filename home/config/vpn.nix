{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreswan
    strongswan
    softether
  ];
}
