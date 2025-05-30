{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Java
    jdk
    # python
    python3
    # R
    R
    # C
    gcc
  ];
}
