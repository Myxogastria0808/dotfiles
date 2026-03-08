{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # C/C++ compiler (GCC toolchain)
    gcc
    # Rust package manager and build tool
    cargo
    # Go compiler and toolchain
    go
    # Node.js JavaScript runtime
    nodejs
    # Python 3 interpreter
    python3
    # R statistical computing language
    R
  ];
}
