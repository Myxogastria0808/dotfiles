{ pkgs, ... }: {
  programs = {
    # Go
    go.enable = true;
  };
  home.packages = with pkgs; [
    # JavaScript
    nodejs_22
    corepack_latest
    bun
    # Rust
    cargo
    rustc
    sea-orm-cli
    # C
    gcc
  ];
}
