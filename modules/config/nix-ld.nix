{ pkgs, ... }:
{
  # nix-ld provides a fake dynamic linker so that unpatched binaries (e.g., downloaded
  # pre-built executables) can run on NixOS without requiring patchelf.
  # Ref: https://qiita.com/syoshika_/items/435a2183265b23bc73fa
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Required by air (R language formatter) which ships as a pre-built binary
      libgcc
      glibc
    ];
  };
}
