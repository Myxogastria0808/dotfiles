{ pkgs, ... }:
{
  # System locale - UI language is English, but input method supports Japanese
  i18n.defaultLocale = "en_US.UTF-8";

  # Keep all locale categories in English for consistent formatting
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # fcitx5 input method framework with Japanese input support (SKK and Mozc)
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true; # Use the Wayland input protocol instead of X11
      addons = with pkgs; [
        fcitx5-mozc # Google Mozc - predictive Japanese input (kana/romaji)
        fcitx5-gtk # GTK integration for fcitx5
        fcitx5-skk # SKK - stroke-based Japanese input method
      ];
    };
  };

  # SKK dictionary packages for fcitx5-skk
  # The dictionary list file is managed separately in home/config/skk/
  environment.systemPackages = with pkgs.skkDictionaries; [
    # ── Standard dictionary ───────────────────────────────────────────────────
    # Ref: https://skk-dev.github.io/dict/
    l # SKK-JISYO.L - the largest general-purpose dictionary

    # ── Specialized dictionaries ──────────────────────────────────────────────
    # Ref: https://skk-dev.github.io/dict/
    jinmei # SKK-JISYO.jinmei - Japanese personal names
    fullname # SKK-JISYO.fullname - full names of individuals in newspapers
    geo # SKK-JISYO.geo - Japanese place names and locations
    propernoun # SKK-JISYO.propernoun - proper nouns (excluding names and places)
    station # SKK-JISYO.station - railway station names and terminology
    law # SKK-JISYO.law - legal terminology
    okinawa # SKK-JISYO.okinawa - Okinawan dialect and terminology
    china_taiwan # SKK-JISYO.china_taiwan - Chinese and Taiwanese place names
    zipcode # postal codes
    jis2 # SKK-JISYO.JIS2 - JIS X 0208 character set
    jis3_4 # SKK-JISYO.JIS3_4 - JIS X 0213 character set
    jis2004 # SKK-JISYO.JIS2004 - JIS X 0213:2004 character set
    itaiji # SKK-JISYO.itaiji - variant character conversion dictionary
    itaiji_jis3_4 # SKK-JISYO.itaiji.JIS3_4 - variant characters for JIS X 0213
    mazegaki # SKK-JISYO.mazegaki - mixed kanji/kana writing dictionary

    # ── Emoji dictionary ──────────────────────────────────────────────────────
    # Ref: https://github.com/ymrl/SKK-JISYO.emoji-ja
    emoji # Emoji input via SKK
  ];
}
