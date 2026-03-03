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
    # python
    python3
    # R
    R
  ];
}
