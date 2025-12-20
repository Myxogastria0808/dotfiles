{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # C/C++
    gcc
    # Rust
    cargo
    # Golang
    go
    # Nodejs
    nodejs
    corepack
    # python
    python3
    # R
    R
  ];
}
