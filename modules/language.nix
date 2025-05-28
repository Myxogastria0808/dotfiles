{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Java
    temurin-bin
    # python
    python3
    # R
    R
    # C
    gcc
  ];
}
