{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Java
    jdk
    # python
    python3
    # R
    R
    rPackages.languageserver
    # C
    gcc
  ];
}
