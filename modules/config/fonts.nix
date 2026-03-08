{ pkgs, ... }:
{
  fonts = {
    # Ref: https://nixos.wiki/wiki/Fonts
    # Ref: https://github.com/ryanoasis/nerd-fonts (Nerd Fonts icon glyph patches)
    packages = with pkgs; [
      # Noto fonts - wide Unicode coverage including CJK and emoji
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      # Nerd Fonts - monospace fonts patched with icon glyphs for terminal use
      nerd-fonts._0xproto
      nerd-fonts.jetbrains-mono
      nerd-fonts."m+"
      # General-purpose sans-serif font by Google
      roboto
      # Japanese monospace font with Nerd Font icons
      udev-gothic-nf
      # Microsoft TrueType core fonts (Arial, Times New Roman, etc.)
      # Ref: https://corefonts.sourceforge.net/
      corefonts
    ];
    # Make fonts available to applications via /run/current-system/sw/share/fonts
    fontDir.enable = true;
    fontconfig = {
      # System-wide default font fallback order
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP" # Japanese serif (covers CJK ideographs)
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans CJK JP" # Japanese sans-serif
          "Noto Color Emoji"
        ];
        monospace = [
          "JetBrainsMono Nerd Font" # Primary monospace with icon glyphs
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
