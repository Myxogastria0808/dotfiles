{ pkgs, ... }:
{
  # 共有ライブラリについて: https://qiita.com/syoshika_/items/435a2183265b23bc73fa
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # required Air (R language formatter)
    libgcc
    glibc
  ];
}
