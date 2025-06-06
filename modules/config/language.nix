{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # python
    python3
    # R
    R
    rPackages.languageserver
    # C
    gcc
  ];
}
