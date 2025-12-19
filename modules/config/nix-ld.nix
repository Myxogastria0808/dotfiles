{ pkgs, ... }:
{
  # What is shared library: https://qiita.com/syoshika_/items/435a2183265b23bc73fa
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # required Air (R language formatter)
      libgcc
      glibc
    ];
  };
}