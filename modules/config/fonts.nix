{ pkgs, ... }:
{
  fonts = {
    # Reference: https://nixos.wiki/wiki/Fonts
    # GitHub repository of nerd-fonts: https://github.com/ryanoasis/nerd-fonts/tree/master
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      nerd-fonts._0xproto
      nerd-fonts.jetbrains-mono
      nerd-fonts."m+"
      roboto
      udev-gothic-nf
      # Microsoft's TrueType core fonts
      # Reference: https://corefonts.sourceforge.net/
      corefonts
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans CJK JP"
          "Noto Color Emoji"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
