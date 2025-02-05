{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # python
    python3
    # R
    R
    # C
    gcc
  ];
}
