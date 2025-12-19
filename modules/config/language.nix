{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # C/C++
    gcc
    # python
    python3
    # R
    R
    # Golang
    go
  ];
}
