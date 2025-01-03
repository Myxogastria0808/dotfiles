{ pkgs, ... }:
{
  programs = {
    # Go
    go.enable = true;
  };
  home.packages = with pkgs; [
    # JavaScript
    nodejs_22
    corepack_latest
    bun
    # Wrangler
    nodePackages.wrangler
    # python
    python3
    # R
    R
    # Rust
    rustup
    pkg-config
    openssl
    # C
    gcc
    # Java
    # 参考サイト: https://www.javadrive.jp/start/install/index5.html
    temurin-bin
  ];
}
